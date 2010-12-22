Return-Path: <cyrus@holtmann.org>
Subject: Re: [RFC 1/2] Add g_attrib_send_seq()
From: Brian Gix <bgix@codeaurora.org>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: rshaffer@codeaurora.org, padovan@profusion.mobi,
	linux-bluetooth@vger.kernel.org
In-Reply-To: <AANLkTinnsNX_9ENWvBcnN7j8_kmBhbSoL6cCWJ8-Lzgh@mail.gmail.com>
References: <1292626132-30029-1-git-send-email-bgix@codeaurora.org>
	 <1292626132-30029-2-git-send-email-bgix@codeaurora.org>
	 <AANLkTinnsNX_9ENWvBcnN7j8_kmBhbSoL6cCWJ8-Lzgh@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Date: Wed, 22 Dec 2010 15:13:40 -0800
Message-ID: <1293059620.7281.43.camel@sealablnx02.qualcomm.com>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Thanks Claudio,

On Wed, 2010-12-22 at 19:29 -0300, Claudio Takahasi wrote:
> Hi Brian,
> 
> On Fri, Dec 17, 2010 at 7:48 PM, Brian Gix <bgix@codeaurora.org> wrote:
> > Add g_attrib_send_seq() as an extension to g_attrib_send().
> >        g_attrib_send_seq() functionally queues an entire
> >        "GATT Procedure" as defined in the BT Core v4.0.
> >        The intention is that the full procedure is run
> >        to completion before the next GATT Procedure is
> >        started. Subsequent ATT requests to a continuing
> >        procedure are added to the head of the Attrib queue.
> >
> > Fix g_attrib_send() to be the degenerative case of g_attrib_send_seq()
> >        This function now chains to g_attrib_send_seq() with arguments
> >        indicating that it is *not* a compound (multi-step) GATT
> >        procedure, but rather that the entire procedure is performed
> >        with a single ATT opcode request/response.
> >
> > Fix received_data() to recognize that incoming response is (or isn't)
> >        part of a compound Procedure, so that it waits for additional
> >        requests before servicing the Attrib queue.
> > ---
> >  attrib/gattrib.c |   44 ++++++++++++++++++++++++++++++++++++--------
> >  attrib/gattrib.h |    4 ++++
> >  2 files changed, 40 insertions(+), 8 deletions(-)
> >
> > diff --git a/attrib/gattrib.c b/attrib/gattrib.c
> > index eace01b..8ef5d92 100644
> > --- a/attrib/gattrib.c
> > +++ b/attrib/gattrib.c
> > @@ -58,6 +58,7 @@ struct command {
> >        guint16 len;
> >        guint8 expected;
> >        gboolean sent;
> > +       gboolean compound;
> >        GAttribResultFunc func;
> >        gpointer user_data;
> >        GDestroyNotify notify;
> > @@ -285,6 +286,7 @@ static gboolean received_data(GIOChannel *io, GIOCondition cond, gpointer data)
> >        uint8_t buf[512], status;
> >        gsize len;
> >        GIOStatus iostat;
> > +       gboolean compound = FALSE;
> Intialization is not necessary.

There is a path to it's usage (a "goto done") just after
g_io_channel_read_chars call.

> 
> >
> >        if (cond & (G_IO_HUP | G_IO_ERR | G_IO_NVAL)) {
> >                attrib->read_watch = 0;
> > @@ -319,6 +321,8 @@ static gboolean received_data(GIOChannel *io, GIOCondition cond, gpointer data)
> >                return attrib->events != NULL;
> >        }
> >
> > +       compound = cmd->compound;
> > +
> >        if (buf[0] == ATT_OP_ERROR) {
> >                status = buf[4];
> >                goto done;
> > @@ -332,7 +336,8 @@ static gboolean received_data(GIOChannel *io, GIOCondition cond, gpointer data)
> >        status = 0;
> >
> >  done:
> > -       if (attrib->queue && g_queue_is_empty(attrib->queue) == FALSE)
> > +       if (!compound && attrib->queue &&
> > +                       g_queue_is_empty(attrib->queue) == FALSE)
> >                wake_up_sender(attrib);
> >
> >        if (cmd) {
> > @@ -340,6 +345,11 @@ done:
> >                        cmd->func(status, buf, len, cmd->user_data);
> >
> >                command_destroy(cmd);
> > +
> > +               if (compound && attrib->queue &&
> > +                       g_queue_is_empty(attrib->queue) == FALSE)
> > +                       wake_up_sender(attrib);
> > +
> Any chance to change the logic to avoid duplicated verification?
> No mater the value of "compound" wake_up_sender() is always called. Is
> the order important?

This is probably the ugliest part of my additions.

Here is the problem:
I wanted to delay the call to wake_up_sender() until *after* the
invocation of the cmd->func() callback, because if the the subsequent
ATT command is to be sent next, it needs to be added to the head of the
queue before the sender is woken up. wake_up_sender calls
g_io_add_watch_full(), and I am unsure how the process threading works
here, so I don't know if received_data() is going to be preempted (and
send the current queue head) by that call.

I do see that the call to wake_up_sender is called by the g_attrib_send*
function, but only if the addition was to a previously empty queue (so
that the count is now 1).  It appeared to me that care was taken by the
original coder to make sure wake_up_sender() was called exactly once for
each ATT command that was queued, and since only a single ATT command
can be outstanding at a time, I believe this is the correct
functionality.

Also, there is the problem that just because a GATT procedure *may* be
compound, there is no guarantee that it *will* need to queue an
additional ATT command. In the read characteristic case, for instance,
if the result is less than 22 bytes, it will not end up being truly
compound at all. However, we do not know that until we have processed
the first result.

I could get around the "two code blocks that do almost the same thing"
problem by the following changes:
	
1. In g_attrib_send_seq(), pull "if length == 1 then wake_up_sender"
	block out one level, so that it is invoked for both the
	push_head and push_tail cases.

2. In received_data(), Check the queue member count prior to invoking
	cmd->func, and then calling wake_up_sender afterwards if the
	prior count was non-zero. We can't check the current count
	at that point, because wake_up_sender may have already been
	called in g_attrib_send_seq.

3. Then, we can totally eliminate the "compound" local var, and
	structure member, making the whole thing cleaner.


Should I try that?

> 
> >        }
> >
> >        return TRUE;
> > @@ -367,12 +377,16 @@ GAttrib *g_attrib_new(GIOChannel *io)
> >        return g_attrib_ref(attrib);
> >  }
> >
> > -guint g_attrib_send(GAttrib *attrib, guint8 opcode, const guint8 *pdu,
> > -                               guint16 len, GAttribResultFunc func,
> > -                               gpointer user_data, GDestroyNotify notify)
> > +guint g_attrib_send_seq(GAttrib *attrib, gboolean compound, guint id,
> > +                               guint8 opcode, const guint8 *pdu, guint16 len,
> > +                               GAttribResultFunc func, gpointer user_data,
> > +                               GDestroyNotify notify)
> >  {
> >        struct command *c;
> >
> > +       if (attrib == NULL || attrib->queue == NULL)
> > +               return 0;
> > +
> Is it necessary to check if queue is NULL?

I don't know.  What happens if g_queue_push_head or g_queue_push_tail is
passed a NULL pointer for the queue? I noticed that it is checked by
g_attrib_cancel, and was unsure as to why it would be different.

> 
> >        c = g_try_new0(struct command, 1);
> >        if (c == NULL)
> >                return 0;
> > @@ -385,16 +399,30 @@ guint g_attrib_send(GAttrib *attrib, guint8 opcode, const guint8 *pdu,
> >        c->func = func;
> >        c->user_data = user_data;
> >        c->notify = notify;
> > -       c->id = ++attrib->next_cmd_id;
> > +       c->compound = compound;
> >
> > -       g_queue_push_tail(attrib->queue, c);
> > +       if (id) {
> > +               c->id = id;
> > +               g_queue_push_head(attrib->queue, c);
> > +       } else {
> > +               c->id = ++attrib->next_cmd_id;
> > +               g_queue_push_tail(attrib->queue, c);
> >
> > -       if (g_queue_get_length(attrib->queue) == 1)
> > -               wake_up_sender(attrib);
> > +               if (g_queue_get_length(attrib->queue) == 1)
> > +                       wake_up_sender(attrib);
> > +       }
> >
> >        return c->id;
> >  }
> >
> > +guint g_attrib_send(GAttrib *attrib, guint8 opcode, const guint8 *pdu,
> > +                               guint16 len, GAttribResultFunc func,
> > +                               gpointer user_data, GDestroyNotify notify)
> > +{
> > +       return g_attrib_send_seq(attrib, FALSE, 0, opcode,
> > +                               pdu, len, func, user_data, notify);
> Coding style issue here.

What is the issue?  I saw in g_attrib_new() that a return of a call to
g_attrib_ref was tail-chain-returned.

> 
> Claudio

Thanks,

-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

