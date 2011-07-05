Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH v2 1/1] Bluetooth: l2cap: fix NULL ACL packet handling
From: Marcel Holtmann <marcel@holtmann.org>
To: Peter Hurley <peter@hurleysoftware.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Date: Tue, 05 Jul 2011 18:35:59 +0200
In-Reply-To: <1309877745.4125.7.camel@THOR>
References: <1309628689.22449.12.camel@THOR>
	 <1309644714.21109.7.camel@aeonflux> <1309877745.4125.7.camel@THOR>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1309883760.21109.30.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Peter,

> > >  /* ---- HCI Ioctl requests structures ---- */
> > >  struct hci_dev_stats {
> > > +	__u32 null_rx;		/* # NULL pkts recvd */
> > >  	__u32 err_rx;
> > >  	__u32 err_tx;
> > >  	__u32 cmd_tx;
> > 
> > you can not do it like this. This will break userspace API/ABI.
> 
> Thanks for the definitive answer, Marcel.
> 
> I suspected as much (which is why I noted in the accompanying cover that
> this would be incompatible with previous userspace versions of this
> ioctl).
> 
> Is the general plan then to freeze the existing raw HCI interface and
> only implement new userspace <-> kernel interfaces on mgmtops?

we can extend the existing ioctl, but only in an API/ABI compatible
fashion. So adding the null_rx at the end of the struct might work. And
we might wanna add null_rx + null_tx to be consistent.

The problem part here is that the stats struct is also nested in the
info struct. We might get lucky here since it is nested at the end.

Regards

Marcel


