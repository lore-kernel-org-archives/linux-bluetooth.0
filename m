Return-Path: <cyrus@holtmann.org>
Date: Fri, 27 Apr 2012 21:18:19 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	pkrystad@codeaurora.org, andrei.emeltchenko.news@gmail.com
Subject: Re: [RFCv2 4/8] Bluetooth: Fix a redundant and problematic incoming
 MTU check
Message-ID: <20120428001819.GA2917@joana>
References: <1335570655-30878-1-git-send-email-mathewm@codeaurora.org>
 <1335570655-30878-5-git-send-email-mathewm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1335570655-30878-5-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

* Mat Martineau <mathewm@codeaurora.org> [2012-04-27 16:50:51 -0700]:

> The L2CAP MTU for incoming data is verified differently depending on
> the L2CAP mode, so the check is best performed in a mode-specific
> context.  Checking the incoming MTU before HCI fragment reassembly is
> a layer violation and assumes all bytes after the standard L2CAP
> header are L2CAP data.
> 
> This approadch causes issues with unsegmented ERTM or streaming mode
> frames, where there are additional enhanced or extended headers before
> the data payload and possible FCS bytes after the data payload.  A
> valid frame could be as many as 10 bytes larger than the MTU.
> 
> Removing this code is the best fix, because the MTU is checked later
> on for all L2CAP data frames (connectionless, basic, ERTM, and
> streaming).  This also gets rid of outdated locking (socket instead of
> l2cap_chan) and an extra lookup of the channel ID.

I don't think we can remove this code from here. This check is different
from the ones you are talking, those are l2cap packets, here we are still
dealing with ACL fragments. This check is there to avoid accept a first
ACL packet that is too big. See 8979481328d. 

One possible solution is to add a slack value to the check, so we can
fit those 10+ bytes packets in it.

	Gustavo
