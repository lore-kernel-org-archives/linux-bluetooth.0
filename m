Return-Path: <wim.delvaux@adaptiveplanet.com>
From: wim delvaux <wim.delvaux@adaptiveplanet.com>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: bnep and refcnt
Date: Mon, 8 Mar 2004 02:02:24 +0100
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
References: <200403071625.01627.wim.delvaux@adaptiveplanet.com> <1078705651.15279.20.camel@pegasus>
In-Reply-To: <1078705651.15279.20.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200403080202.24547.wim.delvaux@adaptiveplanet.com>
List-ID: <bluez-users.lists.sourceforge.net>

On Monday 08 March 2004 01:27, Marcel Holtmann wrote:
> Hi Wim,
>
> > after browsing the Linux 2.6 code there is a remark in net/core/dev.c
> > that state what the problem with the following message that I get is
> >
> > unregister_netdevice: waiting for bnep0 to become free. Usage count = 6
> >
> > The comment with the function in dev.c states that this error is caused
> > by buggy protocols that should unregister after receiving notification
> > that the devices they are using has been unregistered.  They should call
> > unregister_netdev which decreases the refcnt.
>
> looks like we need a more detailed audit for the BNEP module and some of
> the 2.6 changes in the network device layer.

	I tried that but did not find anything usefull.

	I noticed (after GREP) that the BNEP module does not have a notify function
	(does it need one ?).

	Hence I think we need to look for those systems (HCID?) that have a
	reference to the bnep module.  Probably those do not unregister properly

	How can I compile them in debug ?

	Thanx

	W

>
> Regards
>
> Marcel
