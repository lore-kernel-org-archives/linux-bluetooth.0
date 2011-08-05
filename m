Return-Path: <cyrus@holtmann.org>
Date: Fri, 5 Aug 2011 16:12:10 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Mat Martineau <mathewm@codeaurora.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 0/3] RFC: prioritizing data over HCI
Message-ID: <20110805191210.GA2537@joana>
References: <1312377094-11285-1-git-send-email-luiz.dentz@gmail.com>
 <alpine.DEB.2.02.1108040901420.13578@mathewm-linux>
 <1312499377.2158.36.camel@THOR>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1312499377.2158.36.camel@THOR>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* Peter Hurley <peter@hurleysoftware.com> [2011-08-04 19:09:37 -0400]:

> Hi Mat,
> 
> On Thu, 2011-08-04 at 13:37 -0400, Mat Martineau wrote:
> 
> > I had a recent discussion with Gustavo about HCI queuing issues with 
> > ERTM:
> > 
> > http://www.spinics.net/lists/linux-bluetooth/msg13774.html
> > 
> > My proposal is to move tx queuing up to L2CAP, and have the HCI tx 
> > task only handle scheduling.  Senders would tell HCI they have data to 
> > send, and HCI would call back to pull data.  I've been focused on 
> > L2CAP - it would be possible to make a similar queuing change to 
> > SCO/eSCO/LE, but not strictly necessary.
> 
> Would you please clarify this approach (perhaps in a separate thread)?
> 
> For example, how does having tx queues in l2cap_chan (instead of the
> hci_conn) solve the latency problems in ERTM when replying to
> REJ/SREJ/poll? Won't there potentially be just as much data already
> queued up? Is the plan to move the reply to the front of the tx queue
> because reqseq won't need to be assigned until the frame is actually
> pulled off the queue?

Exactly. ERTM connections can get dropped if the too much data is buffered and
we need to send final bit for example.

> 
> > This is different from the problem you're solving, but as long as 
> > we're talking about big changes to HCI tx, I think we could make some 
> > changes that help out with prioritization and queuing across all 
> > channels (whether they're going to the same remote device or different 
> > remote devices).
> > 
> > It could be more efficient to schedule this way since HCI wouldn't 
> > have to iterate over all of the connections and queues - it would only 
> > have to review the prioritized list of pending sends. Might be a more 
> > fitting structure for QoS too.
> 
> Wouldn't this 'prioritized list of pending sends' need to be locked to
> prevent update while reading? ISTM that contention might be fairly high
> for a single, shared resource like that.
> 
> 
> Regards,
> Peter Hurley
> 

	Gustavo
