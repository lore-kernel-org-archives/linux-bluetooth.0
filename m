Return-Path: <cyrus@holtmann.org>
Date: Wed, 16 Mar 2011 20:27:39 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Brian Gix <bgix@codeaurora.org>
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"par-gunnar.p.hjalmdahl@stericsson.com"
	<par-gunnar.p.hjalmdahl@stericsson.com>,
	"henrik.possung@stericsson.com" <henrik.possung@stericsson.com>
Subject: Re: [PATCH] Bluetooth: Add counter for not acked HCI commands
Message-ID: <20110316232739.GD2339@joana>
References: <1299003369-17901-1-git-send-email-andrzej.kaczmarek@tieto.com>
 <4D6D480E.7080908@codeaurora.org>
 <4D70DD01.2030003@tieto.com>
 <4D710F7D.6090905@codeaurora.org>
 <20110316213020.GC2339@joana>
 <4D813ECC.10806@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4D813ECC.10806@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian,

* Brian Gix <bgix@codeaurora.org> [2011-03-16 15:50:52 -0700]:

> Hi Gustavo & Andrzej,
> 
> On 3/16/2011 2:30 PM, Gustavo F. Padovan wrote:
> > Hi Andrzej,
> >
> > * Brian Gix<bgix@codeaurora.org>  [2011-03-04 08:12:45 -0800]:
> >
> >> Hi Andrzej,
> >>
> >> On 3/4/2011 4:37 AM, Andrzej Kaczmarek wrote:
> >>> Hi Brian,
> >>>
> >>> On 01.03.2011 20:25, Brian Gix wrote:
> >>>> The problem you describe sounds like one I had to solve in the past, but
> >>>> unfortunately, I think it may be a little more difficult to solve here.
> >>>> This particular baseband appears to have an outstanding Cmd queue of
> >>>> 2. It also appears to consume one of them for extended periods of time
> >>>> when making requests of the remote device, and using the NOP
> >>>> Cmd-Status-Event to inform the host that the slot is now free.
> >>>>
> >>>> As you are observing, the completion of the task (triggering additional
> >>>> requests locally) overlaps with these NOP responses, giving a false
> >>>> count to the host of available cmd slots.
> >>>>
> >>>> Personally, I consider this to be a baseband bug, which could have been
> >>>> avoided by having a max outstanding queue of 1.
> >>>
> >>> This particular controller uses 1 credit for each command that is being
> >>> processed and having max outstanding queue of 1 would make some
> >>> scenarios impossible - consider authentication with
> >>> HCI_Authentication_Request pending and other HCI command to be sent in
> >>> parallel.
> >>>
> >>
> >> The adjustment I suggest doesn't disallow this.  I was having a
> >> theory-of-operation talk with a baseband guy once, and this is what he
> >> had to say:
> >>
> >> The HCI interface is intended to be an interface that immediately
> >> responds to *every* command. The problem is that some commands are
> >> intended for the local baseband (and can be handled immediately) and
> >> others require interaction outside of the control of the local baseband,
> >> and take an indeterminate amount of time.
> >>
> >> So two response mechanism were created:
> >>
> >> Command    Immediate Rsp     Delayed Rsp
> >> Cmd   -->   Cmd Complete Evt                (Cmds handled Locally)
> >> Cmd   -->   Cmd Status Evt -->  Cmplt Event  ("long" Async Cmds)
> >>
> >> The HCI flow control is contained in both the Cmd-Complt-Evt and the
> >> Cmd-Status-Evt.
> >>
> >> So it is assumed that both flow control response event types will be
> >> delivered immediately after the baseband receives them. Of course
> >> because of the communication link, these response are still asyncronous
> >> in most cases including the BlueZ case.
> >>
> >> The baseband guy basically said that "the baseband" does not expect the
> >> next command until the host has processed the (immediate) response to
> >> the previous one. And that the (immediate) response to the previous one
> >> should be RXed in milliseconds at the most.
> >>
> >> So I would always delay sending the next command until the prior
> >> commands CmdStatus or CmdCmplt has been received. This should work
> >> unless there is something seriously wrong with the baseband.
> >
> > That's exactly how linux stack work, and I'm seeing where we could be doing
> > wrong, so I believe your patch is fixing nothing. A best version of your
> > patch is:
> >
> > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > index cebe7588..2d4d441 100644
> > --- a/net/bluetooth/hci_event.c
> > +++ b/net/bluetooth/hci_event.c
> > @@ -1771,7 +1771,7 @@ static inline void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *sk
> >          if (ev->opcode != HCI_OP_NOP)
> >                  del_timer(&hdev->cmd_timer);
> >
> > -       if (ev->ncmd) {
> > +       if (ev->ncmd&&  ev->opcode != HCI_OP_NOP) {
> >                  atomic_set(&hdev->cmd_cnt, 1);
> >                  if (!skb_queue_empty(&hdev->cmd_q))
> >                          tasklet_schedule(&hdev->cmd_task);
> 
> I don't think that this is correct.

Yes, this is wrong. It's just a simplified version of Andrzej's patch.

> 
> First: Any change made here in hci_cmd_cmplete_evt would need to also be 
> made in hci_cmd_status_evt.  The "NOP" event can be either a Cmd Cmplt 
> or a Cmd Status, and in the example given by Andrzej, it was a Cmd Status.

Yes, of course. My patch is just a concept (as it is wrong)

> 
> Second: How is cmd_cnt being used?  I see it being decremented when a 
> command is sent in hci_cmd_task, or being set to "1" when one of the two 
> events are received. It is also set to "1" for time-outs and channel 
> open/close/reset activities.
> 
> It looks to me like the cmd_cnt is being misused.  It should in fact be 
> set to the value indicated by the event, and not just "1".  It also does 
> not address the original problem observed by Andrzej, which is that the 
> Asyncronous link between the Host and Baseband can cause them to be 
> momentarily out of sync with each other.

We limit cmd_cnt to 1 in our stack, to be sure that one command a time will be
sent, I don't for the reason for that but Marcel certainly has one.

-- 
Gustavo F. Padovan
http://profusion.mobi
