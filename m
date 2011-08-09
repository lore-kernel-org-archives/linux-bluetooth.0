Return-Path: <cyrus@holtmann.org>
Date: Tue, 9 Aug 2011 01:32:10 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: Peter Hurley <peter@hurleysoftware.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 0/3] RFC: prioritizing data over HCI
Message-ID: <20110809043210.GA2594@joana>
References: <1312377094-11285-1-git-send-email-luiz.dentz@gmail.com>
 <alpine.DEB.2.02.1108040901420.13578@mathewm-linux>
 <1312499377.2158.36.camel@THOR>
 <20110805191210.GA2537@joana>
 <alpine.DEB.2.02.1108081628030.29183@mathewm-linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.02.1108081628030.29183@mathewm-linux>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* Mat Martineau <mathewm@codeaurora.org> [2011-08-08 16:29:51 -0700]:

> 
> On Fri, 5 Aug 2011, Gustavo Padovan wrote:
> 
> >* Peter Hurley <peter@hurleysoftware.com> [2011-08-04 19:09:37 -0400]:
> >
> >>Hi Mat,
> >>
> >>On Thu, 2011-08-04 at 13:37 -0400, Mat Martineau wrote:
> >>
> >>>I had a recent discussion with Gustavo about HCI queuing issues with
> >>>ERTM:
> >>>
> >>>http://www.spinics.net/lists/linux-bluetooth/msg13774.html
> >>>
> >>>My proposal is to move tx queuing up to L2CAP, and have the HCI tx
> >>>task only handle scheduling.  Senders would tell HCI they have data to
> >>>send, and HCI would call back to pull data.  I've been focused on
> >>>L2CAP - it would be possible to make a similar queuing change to
> >>>SCO/eSCO/LE, but not strictly necessary.
> >>
> >>Would you please clarify this approach (perhaps in a separate thread)?
> >>
> >>For example, how does having tx queues in l2cap_chan (instead of the
> >>hci_conn) solve the latency problems in ERTM when replying to
> >>REJ/SREJ/poll? Won't there potentially be just as much data already
> >>queued up? Is the plan to move the reply to the front of the tx queue
> >>because reqseq won't need to be assigned until the frame is actually
> >>pulled off the queue?
> >
> >Exactly. ERTM connections can get dropped if the too much data is buffered and
> >we need to send final bit for example.
> 
> Right now, an outgoing ERTM frame goes through two queues: a
> channel-specific ERTM tx queue and the HCI ACL data_q.  The ERTM
> control field is not constructed until a frame is removed from the
> ERTM tx queue and pushed to the HCI data_q, so the s-frame latency
> problem comes in when the the HCI data_q gets deep.  S-frames are
> already pushed directly in to the HCI data_q, bypassing the data tx
> queue.
> 
> From an ERTM perspective, the goal is to defer assignment of reqseq
> and f-bit values as late as possible, so the remote device gets the
> most recent information on data frames and polls that have been
> received.  The optimal thing to do (by this measurement, anyway) is
> to build the ERTM control field as data is sent to the baseband --
> in other words, to eliminate the HCI data_q altogether.
> 
> (Yeah, without the data_q, ERTM would need additional queues for
> s-frames and retransmitted i-frames)
> 
> So, without a data_q, what makes sense?  If there are ACL buffers
> available and no pending L2CAP senders, it would be great to push
> data straight out to the baseband.  If we're blocked waiting for
> num_completed_packets, then receipt of num_completed_packets is the
> natural time to pull data from the tx queues that now happen to be
> up in the L2CAP layer.
> 
> There are certainly locking, task scheduling, data scheduling, QoS,
> and efficiency issues to consider.  This is just a general
> description for now, and I'm trying to see if there's enough
> interest (or few enough obvious gotchas) to put some serious effort
> in to moving forward.

Getting rid of conn->data_q makes sense. I started a patch to create the
struct hci_chan that Luiz proposed. It would be one HCI channel per L2CAP
connection. The buffer (acl_cnt) would be now divided by the number of
channels and not the number of connections. This is a first step to support
QoS and priority inside ERTM. QoS then would just need new scheduler rules.

+struct hci_chan {
+       struct list_head list;
+       struct hci_conn *conn;
+       struct sk_buff_head data_q;
+       unsigned int    sent;
+}

So in the next step for ERTM we move the queue to L2CAP and create a callback
to call from HCI at the moment of push data to the baseband. The function in
L2CAP would set the last control bits in the first packet of the queue and
sent it through.

Then the queue can be split in two by adding a pointer that will mark which
element divides the queue between prio and normal. New prio skbs would just be
queued after this element and before the rest.

I still need to think on locking here. (and also finish my patches that move
all the bluetooth to workqueue)

	Gustavo
