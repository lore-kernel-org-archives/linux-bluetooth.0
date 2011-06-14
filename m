Return-Path: <cyrus@holtmann.org>
Date: Tue, 14 Jun 2011 20:53:13 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/4] Bluetooth: Limit depth of the HCI TX queue with ERTM
 mode
Message-ID: <20110614235313.GE2613@joana>
References: <1307143270-2655-1-git-send-email-mathewm@codeaurora.org>
 <1307143270-2655-3-git-send-email-mathewm@codeaurora.org>
 <20110609021648.GA2776@joana>
 <alpine.DEB.2.02.1106091610040.18748@mathewm-linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.02.1106091610040.18748@mathewm-linux>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

* Mat Martineau <mathewm@codeaurora.org> [2011-06-09 16:36:29 -0700]:

> 
> Gustavo,
> 
> On Wed, 8 Jun 2011, Gustavo F. Padovan wrote:
> 
> >Hi Mat,
> >
> >* Mat Martineau <mathewm@codeaurora.org> [2011-06-03 16:21:09 -0700]:
> >
> >>In order to provide timely responses to REJ, SREJ, and poll input from
> >>the remote device, it helps to reduce the number of ERTM data frames
> >>in the HCI TX queue at one time. If a full TX window of data is in the
> >>HCI TX queue, any responses to REJ, SREJ, or polls must wait in line
> >>behind all previously queued data. This latency leads to disconnects,
> >>and will be more severe with extended window sizes.
> >
> >I prefer if we go with a hci_send_acl_prio() implementation. It will have much
> >less overhead using a workqueue. As it will be filled only by S-frames with a
> >few bytes each I don't think we will have problems. So lets go with this
> >approach and see what we can get.
> 
> I considered that approach too, but it breaks some major assumptions
> and I don't think it complies with the ERTM spec.  I-frames contain
> reqseq fields and a final bit, so if S-frames and I-frames are
> delivered out-of-sequence, you can easily end up with a confusing
> series of reqseq values at the receiver.
> 
> Suppose the HCI tx queue is full of I-frames, and the oldest I-frame
> has reqseq set to 1.  Since that I-frame has been queued, other
> incoming I-frames have been processed, so the last recieved I-frame
> had txseq 20.  The remote device sends a poll, and we reply with an
> RR (reqseq 21) using the priority queue.  HCI sends that RR first,
> then an I-frame from the normal queue with reqseq 1.  Now the remote
> side thinks it missed all of the frames from 21 to 1 (having wrapped
> around).  The remote side then has to send REJ or SREJ frames, even
> though nothing is actually missing.

Good point. That will be a problem indeed.

> 
> So, I think we have two options:
> 
>  * Use the skb_destructor mechanism to pull data for ERTM (which is
> what my patch does), and leave queuing for other modes alone
>  * Rearchitect HCI & L2CAP so that data is pulled from the L2CAP
> layer as num_comp_pkts events are received

I prefer the rearchitect HCI and L2CAP approach, but I still don't have too
much idea on how to do this. I'm open to suggestions here.

Another idea is to delay in setting the control bits until the moment we
actually send the frame. If we do that, we can have priority for REJ/SREJ.
Before send, hci calls a l2cap function to fill the control bit. These are
just ideas.

I just think that use an workqueue and a tasklet to send packet is just too
much.

	Gustavo
