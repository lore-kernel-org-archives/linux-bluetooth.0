Return-Path: <cyrus@holtmann.org>
Subject: Re: [RFC 1/2] Add g_attrib_send_seq()
From: bgix <bgix@codeaurora.org>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>,
	rshaffer@codeaurora.org, padovan@profusion.mobi,
	linux-bluetooth@vger.kernel.org
In-Reply-To: <20101228214722.GA30135@piper.indt.org>
References: <1292626132-30029-1-git-send-email-bgix@codeaurora.org>
	 <1292626132-30029-2-git-send-email-bgix@codeaurora.org>
	 <AANLkTinnsNX_9ENWvBcnN7j8_kmBhbSoL6cCWJ8-Lzgh@mail.gmail.com>
	 <1293059620.7281.43.camel@sealablnx02.qualcomm.com>
	 <20101228214722.GA30135@piper.indt.org>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 04 Jan 2011 17:07:17 -0800
Message-ID: <1294189637.20505.61.camel@ubuntuLab1>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

I'm sorry, but I submitted patches before I was aware that you had
responded.

On Tue, 2010-12-28 at 18:48 -0300, Vinicius Costa Gomes wrote:
> Hi Brian,
> 
> First of all, sorry for the delay.
> 
[...]
> > I wanted to delay the call to wake_up_sender() until *after* the
> > invocation of the cmd->func() callback, because if the the subsequent
> > ATT command is to be sent next, it needs to be added to the head of the
> > queue before the sender is woken up. wake_up_sender calls
> > g_io_add_watch_full(), and I am unsure how the process threading works
> > here, so I don't know if received_data() is going to be preempted (and
> > send the current queue head) by that call.
> 
> It is really simple, it was not meant to work on multi-threaded enviroments.
> receeived_data() is going to be called after control is back to the mainloop. 
> It is not meant to be reentrant.

Understood.

> 
> > 
> > I do see that the call to wake_up_sender is called by the g_attrib_send*
> > function, but only if the addition was to a previously empty queue (so
> > that the count is now 1).  It appeared to me that care was taken by the
> > original coder to make sure wake_up_sender() was called exactly once for
> > each ATT command that was queued, and since only a single ATT command
> > can be outstanding at a time, I believe this is the correct
> > functionality.
> 
> I think that Claudio was referring just to the changes that you made to
> received_data(). And considering what I said above (that it's not meant to be
> thread-safe) I think that received_data could stay unchanged.
> 
> And g_attrib_send_seq() could have a bug when the command at the head was 
> already sent but is waiting for a response. If the command is always added to
> the head of the queue, could it be so the order of the command of a compound 
> procedure is inverted?

In the patches I resent, I eliminated g_attrib_send_seq in favour of a
single API with the original name (g_attrib_send) which has an
additional parameter.

The intention of the version of the call to enqueue at the head of the
queue, is that it take place within the scope of the cmd->func()
callback.  Perhaps there is a way to code for that, by checking within
g_attrib_send that the head of the queue has not been sent, but from
within cmd->func() it should definitely not have sent the next pkt,
assuming what you stated about re-entrancy above holds true.

> 
> And taking a closer look at the spec, it was clear to me that only a higher
> level profile (above GATT) is able to know that a characteristic needs to be
> read by using the "Read Long Characteristic Value" procedure -- which I think is
> what brought this discussion, right? or you already have another need for 
> these procedures? -- Which gives me the impression that this should
> be dealt by the profile implementation. Which gives us more time to think about
> how to implement this correctly ;-) in case the need arrise.

I don't believe this is correct. Reading a Characteristic Value is a
GATT procedure, not a Profile procedure.  And any String based
Characteristic is a candidate for being longer than the LE default MTU.
The Reading of Long characteristics as a procedure is enumerated in the
GATT specification.

> 
[...]
> > 
> > I don't know.  What happens if g_queue_push_head or g_queue_push_tail is
> > passed a NULL pointer for the queue? I noticed that it is checked by
> > g_attrib_cancel, and was unsure as to why it would be different.
> > 
> 
> It would not crash, but I think that GLib would give an warning. Doing the
> check is correct.

And I just removed it from my patch.  oops.

> 
[...]
> > > > +guint g_attrib_send(GAttrib *attrib, guint8 opcode, const guint8 *pdu,
> > > > +                               guint16 len, GAttribResultFunc func,
> > > > +                               gpointer user_data, GDestroyNotify notify)
> > > > +{
> > > > +       return g_attrib_send_seq(attrib, FALSE, 0, opcode,
> > > > +                               pdu, len, func, user_data, notify);
> > > Coding style issue here.
> > 
> > What is the issue?  I saw in g_attrib_new() that a return of a call to
> > g_attrib_ref was tail-chain-returned.
> 
> I think it was more about indentation, something like this looks better:
> 
> return g_attrib_send_seq(attrib, FALSE, 0, opcode, pdu, len, func,
> 						user_data, notify);
> 

OK.

-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

