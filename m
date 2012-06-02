Return-Path: <cyrus@holtmann.org>
Date: Sat, 2 Jun 2012 09:15:10 +0800
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Gustavo Padovan <gustavo@padovan.org>,
	Jefferson Delfes <jefferson.delfes@openbossa.org>,
	linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Subject: Re: [PATCH] Bluetooth: Fix flags of mgmt_device_found event
Message-ID: <20120602011510.GD22641@x220.docomointertouch.net>
References: <1338577525-9182-1-git-send-email-jefferson.delfes@openbossa.org>
 <20120601231335.GI24769@joana>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120601231335.GI24769@joana>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Fri, Jun 01, 2012, Gustavo Padovan wrote:
> * Jefferson Delfes <jefferson.delfes@openbossa.org> [2012-06-01 15:05:25 -0400]:
> 
> > Change flags field to matches userspace structure.
> > This field needs to be converted to little endian before forward it.
> > 
> > Signed-off-by: Jefferson Delfes <jefferson.delfes@openbossa.org>
> > ---
> >  include/net/bluetooth/mgmt.h |    2 +-
> >  net/bluetooth/mgmt.c         |    5 +++--
> >  2 files changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
> > index ebfd91f..3a8a714 100644
> > --- a/include/net/bluetooth/mgmt.h
> > +++ b/include/net/bluetooth/mgmt.h
> > @@ -435,7 +435,7 @@ struct mgmt_ev_auth_failed {
> >  struct mgmt_ev_device_found {
> >  	struct mgmt_addr_info addr;
> >  	__s8	rssi;
> > -	__u8	flags[4];
> > +	__le32	flags;
> 
> Seems we are breaking API here, MGMT API is stable now and should have such
> kind of change. However I wanna see what Marcel and Johan has to say about
> this.

I don't see how this is breaking anything. The exact same bytes in the
same order would be transmitted through the mgmt socket. Or am I missing
something?

Johan
