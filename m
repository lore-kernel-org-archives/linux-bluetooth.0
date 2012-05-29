Return-Path: <cyrus@holtmann.org>
Date: Tue, 29 May 2012 04:16:25 +0300
From: Ido Yariv <ido@wizery.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] gattrib: Fix a request/response command deadlock
Message-ID: <20120529011624.GA31806@WorkStation.localnet>
References: <1338230071-27599-1-git-send-email-ido@wizery.com>
 <20120528194505.GA6742@samus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120528194505.GA6742@samus>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Mon, May 28, 2012 at 04:45:06PM -0300, Vinicius Costa Gomes wrote:
> Hi Ido,
> 
> On 21:34 Mon 28 May, Ido Yariv wrote:
> > New requests and responses are never sent if a request was sent and the
> > response for it hasn't been received yet. As a result, if both end
> > points send requests at the same time, a deadlock could occur. This
> > could happen, for instance, if the client sends a read request and the
> > server sends an indication before responding to the read request.
> > 
> > Fix this by introducing an additional queue for responses. Responses may
> > be sent while there's still a pending request/indication.
> > ---
> >  attrib/gattrib.c |   86 +++++++++++++++++++++++++++++++++++++++++++----------
> >  1 files changed, 69 insertions(+), 17 deletions(-)
> > 
> > diff --git a/attrib/gattrib.c b/attrib/gattrib.c
> > index 769be36..769d746 100644
> > --- a/attrib/gattrib.c
> > +++ b/attrib/gattrib.c
> > @@ -47,6 +47,7 @@ struct _GAttrib {
> >  	guint write_watch;
> >  	guint timeout_watch;
> >  	GQueue *queue;
> > +	GQueue *response_queue;
> 
> I would change the name of the other queue as well, to make it clear
> that the two queues have different objectives.

Sure, why not.

> 
> >  	GSList *events;
> >  	guint next_cmd_id;
> >  	guint next_evt_id;
> > @@ -175,9 +176,13 @@ static void attrib_destroy(GAttrib *attrib)
> >  
> >  	while ((c = g_queue_pop_head(attrib->queue)))
> >  		command_destroy(c);
> 
> I would add a empty line here.

Done.

> 
> > +	while ((c = g_queue_pop_head(attrib->response_queue)))
> > +		command_destroy(c);
> >  
> >  	g_queue_free(attrib->queue);
> >  	attrib->queue = NULL;
> 
> And here.

Done.

> 
> > +	g_queue_free(attrib->response_queue);
> > +	attrib->response_queue = NULL;

...

> > @@ -421,6 +442,7 @@ guint g_attrib_send(GAttrib *attrib, guint id, guint8 opcode,
> >  			gpointer user_data, GDestroyNotify notify)
> >  {
> >  	struct command *c;
> > +	GQueue *queue;
> >  
> >  	c = g_try_new0(struct command, 1);
> >  	if (c == NULL)
> > @@ -435,15 +457,25 @@ guint g_attrib_send(GAttrib *attrib, guint id, guint8 opcode,
> >  	c->user_data = user_data;
> >  	c->notify = notify;
> >  
> > +	if (is_response(opcode))
> > +		queue = attrib->response_queue;
> > +	else
> > +		queue = attrib->queue;
> > +
> >  	if (id) {
> >  		c->id = id;
> > -		g_queue_push_head(attrib->queue, c);
> > +		g_queue_push_head(queue, c);
> 
> I don't know if this is the right thing to do for responses. For
> requests there's is no problem if I rearrange them, but if I rearrange
> responses I guess that it would confuse the remote side.

Good catch. Though I don't see how this could happen in practice, I'll
verify that we don't re-order responses to be on the safe side.

> 
> >  	} else {
> >  		c->id = ++attrib->next_cmd_id;
> > -		g_queue_push_tail(attrib->queue, c);
> > +		g_queue_push_tail(queue, c);
> >  	}

...

> > -gboolean g_attrib_cancel_all(GAttrib *attrib)
> > +static gboolean g_attrib_cancel_all_per_queue(GQueue *queue)
> 
> I don't think that the g_attrib_ prefix here adds much, if that function
> is not exported.

Sure, I'll change that.

...

> Other than that, patch looks good.

Thanks for reviewing it!

> 
> Just for information, some time ago I did something similar, but I never
> felt sure enough about it, but I guess that I was not that far off, in case
> you want to take a look:
> 
> http://git.infradead.org/users/vcgomes/bluez.git/commitdiff/refs/heads/two-queues

Nice, it looks very similar :)

Thanks,
Ido.
