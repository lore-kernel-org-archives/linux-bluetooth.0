Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Sat, 2 Jul 2011 22:49:58 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Peter Hurley <peter@hurleysoftware.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] Bluetooth: l2cap: fix NULL ACL packet handling
Message-ID: <20110703014958.GA2706@joana>
References: <1309628689.22449.12.camel@THOR>
 <1309644714.21109.7.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1309644714.21109.7.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

* Marcel Holtmann <marcel@holtmann.org> [2011-07-02 15:11:51 -0700]:

> Hi Peter,
> 
> > A 0-length ACL continuation-fragment is a valid NULL packet. Remote
> > devices can use the FLOW indicator in the ACL packet header to
> > flow-control ACL packets without sending a payload.
> > 
> > Track as a device stat instead of logging.
> > 
> > Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
> > ---
> >  include/net/bluetooth/hci.h |    1 +
> >  net/bluetooth/l2cap_core.c  |    8 ++++++++
> >  2 files changed, 9 insertions(+), 0 deletions(-)
> > 
> > diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> > index 0c20227..de7ed81 100644
> > --- a/include/net/bluetooth/hci.h
> > +++ b/include/net/bluetooth/hci.h
> > @@ -1142,6 +1142,7 @@ struct hci_ufilter {
> >  
> >  /* ---- HCI Ioctl requests structures ---- */
> >  struct hci_dev_stats {
> > +	__u32 null_rx;		/* # NULL pkts recvd */
> >  	__u32 err_rx;
> >  	__u32 err_tx;
> >  	__u32 cmd_tx;
> 
> you can not do it like this. This will break userspace API/ABI.

Actually I don't see a point to have null_rx counter, just drop the packet and
we are done.

	Gustavo
