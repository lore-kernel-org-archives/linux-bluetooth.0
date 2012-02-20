Return-Path: <cyrus@holtmann.org>
Date: Mon, 20 Feb 2012 16:44:59 +0200
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFCv6 00/14] Bluetooth: Change socket lock to l2cap_chan lock
Message-ID: <20120220144453.GE27197@aemeltch-MOBL1>
References: <1329747685-4163-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1329748173.2172.0.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1329748173.2172.0.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Feb 20, 2012 at 03:29:33PM +0100, Marcel Holtmann wrote:
> Hi Andrei,
> 
> > Changing socket lock to L2CAP chan lock in L2CAP code. Needed for implementing
> > protocol above L2CAP without creating sockets.
> > 
> > Changes:
> > 	* RFCv6: Same code but patches 2,3 and 4 from RFCv5 are merged together
> > 	following recommendations from review.
> > 	* RFCv5: Fixed locking bug in l2cap_data_channel, added locks in 
> > 	l2cap_sock_shutdown function, fixed several styles issues.
> > 	* RFCv4: Better split patches so they looks more clear and obvious,
> > 	taking coments about naming change and delete unused vars. See diff change
> > 	from the previous version below:
> > 	* RFCv3: Split the big patch to several small (I believe logical) chunks,
> > 	remove unneded locks from cleanup_listen, use the same arguments for
> > 	locked/unlocked socket error functions.
> > 	* RFCv2: Convert l2cap channel list back to mutex from RCU list.
> 
> so what is the general status of this patch series. Are there still
> concerns or opens? Or should it be go for final review and be merged?

The code looks now good enough for final review.

Best regards 
Andrei Emeltchenko 
