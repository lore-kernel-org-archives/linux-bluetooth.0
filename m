Return-Path: <cyrus@holtmann.org>
Date: Thu, 19 Jul 2012 13:25:36 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: Gustavo Padovan <gustavo@padovan.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 1/2] Bluetooth: Fix legacy pairing with some devices
Message-ID: <20120719102536.GB15933@x220>
References: <1338198440-15077-1-git-send-email-szymon.janc@tieto.com>
 <8577078.KmiEQoH2Vq@uw000953>
 <20120719093452.GC7612@x220>
 <1709298.ayJY9Nu1WY@uw000953>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1709298.ayJY9Nu1WY@uw000953>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Thu, Jul 19, 2012, Szymon Janc wrote:
> On Thursday 19 of July 2012 12:34:52 Johan Hedberg wrote:
> 
> > > > > > Maybe we could set timeout back to HCI_DICONN_TIMEOUT when l2cap is
> > > > > > connected (or disconnected)? That should cover SDP search case..
> > > > >
> > > > > What happened to getting this patch upstream? To me it looks like a
> > > > > definitely needed fix. After adding the fix to restore a sensible value
> > > > > for disc_timeout after an L2CAP connect request either way and adding a
> > > > > better explanation to the commit message (that we only get the PIN
> > > > > request after user has entered one on the remote side, including a
> > > > > hcidump of this) I think this should go upstream. If this had been
> > > > > processed in a timely manner it could have made it to 3.5 but now it
> > > > > seems too late for that (as it's not strictly speaking a regression from
> > > > > 3.4).
> > > >
> > > > Could you re-do this patch as Johan says so we can try push it to 3.5?
> > > 
> > > Sorry for late reply, been on rather long holiday..
> > > 
> > > I now feel that this is a bug in bluez not in kernel - bluez should not cancel
> > > PIN request for agent if acl is disconnected but just reconnect when PIN is
> > > provided.
> > > 
> > > So, if you still like to have this workaround in kernel for devices which are
> > > highly unlikely to have this fixed I can send new version.
> > 
> > I don't agree with your categorization of the kernel change as a
> > workaround. Since it was the remote side the initiated the initial ACL I
> > don't think it's right for us to have any kind of automation of creating
> > a second ACL in the opposite direction. So please do the improvements to
> > your patch as discussed and resend. Thanks.
> 
> I guess I wasn't clear enough.. I meant that the bug is in bluez which is also
> running on remote device and is unlikely to get updated. No connection in 
> opposite direction is taking place. It is bluez on initiator side that should
> reconnect when it received PIN from user if acl was disconnected. Most agents
> do service search in the meantime so l2cap exists and acl is not disconnected.
> 
> This can be easily reproduced with simple-agent which is not doing service
> search.

Understood. I still think that we should do the necessary changes to the
disconnect timer. I've actually seen this kind of behavior quite often
at UnplugFests and I doubt all of the other parties have been running
BlueZ.

Johan
