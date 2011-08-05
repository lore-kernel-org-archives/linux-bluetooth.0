Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110805191416.GB2537@joana>
References: <1312377094-11285-1-git-send-email-luiz.dentz@gmail.com>
	<alpine.DEB.2.02.1108040901420.13578@mathewm-linux>
	<CABBYNZ+OPDnR=e2sPx=mLmOkd80z2sPNAPX+ss7GCh+7rndH1g@mail.gmail.com>
	<20110805191416.GB2537@joana>
Date: Sat, 6 Aug 2011 01:49:24 +0300
Message-ID: <CABBYNZLCO6aesaXa15B6kKYy2HEohF+ySCq4kGEgJF7_Ai37kA@mail.gmail.com>
Subject: Re: [PATCH 0/3] RFC: prioritizing data over HCI
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Mat Martineau <mathewm@codeaurora.org>,
	linux-bluetooth@vger.kernel.org, peter@hurleysoftware.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Fri, Aug 5, 2011 at 10:14 PM, Gustavo Padovan <padovan@profusion.mobi> wrote:
>
> Only ERTM needs to have its own queue, Basic and Streaming mode doesn't need
> to change, they can use the same queue they are using now.

The guaranteed channels also seems to need separated queue, actually
even best effort channels could use QoS (see page 1442  :5.3 QUALITY
OF SERVICE (QOS) OPTION). Note this is a general option which is then
negotiated also on HCI level, it seems completely independent of ERTM.

The per channel queuing is almost a must have if we really want to be
able to implement any QoS, because then we can track exactly what
channels are sending, calculate if we can attend the QoS needs and so
on. But I don't think doing this on L2CAP level is a good idea,
because it create a circular dependency with HCI  and the pull mode
might create a locking nightmare, not to mention L2CAP is already
quite big.

One of the solution Ive been thinking is to have an HCI Channel (e.g.
struct hci_chan) abstraction, which would be responsible for queueing
and storing necessary information for scheduling. This could be
implemented directly in HCI level (hci_conn.c) so L2CAP can still push
data to HCI by using the HCI Channel (l2cap_chan->hci_chan). How about
that?

-- 
Luiz Augusto von Dentz
