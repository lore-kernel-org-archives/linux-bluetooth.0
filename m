Return-Path: <cyrus@holtmann.org>
Subject: Re: [RFCv0 0/5] extended window size and extended control field
 support
From: Marcel Holtmann <marcel@holtmann.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>,
	linux-bluetooth@vger.kernel.org, pkrystad@codeaurora.org,
	padovan@profusion.mobi
Date: Tue, 30 Aug 2011 11:18:27 -0700
In-Reply-To: <alpine.DEB.2.02.1108300842410.14580@mathewm-linux>
References: <1314688721-16742-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <alpine.DEB.2.02.1108300842410.14580@mathewm-linux>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1314728311.3373.246.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

> > First draft patches applied to my previous EFS patches. Please comment.
> >
> > Adds support for extended window size option (EWS) and extended control
> > field. Code partly based on Atheros patches sent a year ago and Qualcomm
> > code git://codeaurora.org/kernel/msm.git.
> >
> > To decode EWS option and extended control field please apply patch to hcidump
> > which I sent to linux-bluetooth.
> >
> > Andrei Emeltchenko (5):
> >  Bluetooth: extended window size option support
> >  Bluetooth: l2cap extended control field support
> >  Bluetooth: EWS: support extended seq numbers
> >  Bluetooth: remove magic numbers in l2cap
> >  Bluetooth: prevent unneeded fragmentation in l2cap
> >
> > include/net/bluetooth/l2cap.h |  304 ++++++++++++++++++++++----
> > net/bluetooth/l2cap_core.c    |  481 +++++++++++++++++++++++++----------------
> > net/bluetooth/l2cap_sock.c    |   11 +-
> > 3 files changed, 562 insertions(+), 234 deletions(-)
> >
> > -- 
> > 1.7.4.1
> 
> Extended window size is next on my list to upstream.  As you probably 
> noticed, the git://codeaurora.org/kernel/msm.git code has a slightly 
> different approach to handling the two control field types.  The 
> fields are handled in a struct that's part of the bt_cb control block, 
> and only read/written in wire format when the frame is first received 
> or about to be sent.  Are there any issues with this method (other 
> than the fact that I haven't upstreamed it yet)?  Some of the 
> subsequent L2CAP state machine changes depend on this.

in general using bt_cb is fine, but it depends a little bit on the
details. The space of the skb cb is limited. So we need to be cautious
here.

We are also currently making bt_cb global for all protocols. Maybe one
way is to have l2cap_cb for this. We need to see what makes more sense
and what is more efficient.

> Please let me know if there are specific features from the 
> git://codeaurora.org/kernel/msm.git code base that you would like to 
> prioritize for upstreaming - there's a lot to do to bring in those 
> L2CAP and AMP changes, and I'll have more time to devote to it in 
> mid-September.  I think we can gain a lot by reviewing each other's 
> patches and coordinating our efforts.

Maybe just for reference, you should post a set of patches to the
mailing list so they are archived and seen by others. Digging into a
generic msm.git tree is not really efficient.

Regards

Marcel


