Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH v2 09/16] Bluetooth: Prepare for full support discovery
 procedures
From: Marcel Holtmann <marcel@holtmann.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 10 Aug 2011 17:24:50 -0700
In-Reply-To: <59EF67F7-A9E0-4C6D-963E-C4EF90F611FC@openbossa.org>
References: <1311623405-31108-1-git-send-email-andre.guedes@openbossa.org>
	 <1311623405-31108-10-git-send-email-andre.guedes@openbossa.org>
	 <1312984092.3373.116.camel@aeonflux>
	 <59EF67F7-A9E0-4C6D-963E-C4EF90F611FC@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1313022292.3373.135.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

<snip>

> >> diff --git a/include/net/bluetooth/hci_core.h b/include/net/ 
> >> bluetooth/hci_core.h
> >> index 1ff59f2..0d2e703 100644
> >> --- a/include/net/bluetooth/hci_core.h
> >> +++ b/include/net/bluetooth/hci_core.h
> >> @@ -597,6 +597,7 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
> >> #define lmp_esco_capable(dev)      ((dev)->features[3] & LMP_ESCO)
> >> #define lmp_ssp_capable(dev)       ((dev)->features[6] &  
> >> LMP_SIMPLE_PAIR)
> >> #define lmp_no_flush_capable(dev)  ((dev)->features[6] &  
> >> LMP_NO_FLUSH)
> >> +#define lmp_bredr_capable(dev)     (!((dev)->features[4] &  
> >> LMP_NO_BREDR))
> >
> > I don't think this is a good idea. You keep forgetting if you actually
> > have LE switched on or not.
> >
> > I think we should keep it like this and just keep a global hci_dev  
> > state
> > which discovery procedure to use. Depending on if the device is just
> > really LE-Only, it is dual-stack, but LE got switched off (we will  
> > need
> > this eventually for testing) or it is just only BR/EDR.
> 
> I agree. What really matters for the discovery procedure is the
> operation mode not the device type. The term "device type" was
> misused here.
> 
> About the global hci_dev state, IMO we may not need it. By looking
> at the controller's LMP features we are able to infer what is the
> controller's operation mode.

you need to look at the extended features page 1, but yes, if you have
that available, the it might be as simple as have the global state.

It really depends on how often you have to check. Maybe it is worth to
just have a simple operation mode variable compared to always have to
access multiple bits in the features array. Depends on how often you
need to use it.

> >> #define lmp_le_capable(dev)        ((dev)->features[4] & LMP_LE)
> >>
> >> /* ----- Extended LMP capabilities ----- */
> >> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> >> index bbb0daa..dcfb466 100644
> >> --- a/net/bluetooth/mgmt.c
> >> +++ b/net/bluetooth/mgmt.c
> >> @@ -32,6 +32,15 @@
> >> #define MGMT_VERSION	0
> >> #define MGMT_REVISION	1
> >>
> >> +enum bt_device_type {
> >> +	BREDR_ONLY,
> >> +	LE_ONLY,
> >> +	BREDR_LE,
> >> +	UNKNOWN,
> >> +};
> >
> > What is this for? We essentially have a local device capabilities  
> > and an
> > operation mode. They are both different. We do not have a device type.
> 
> I'll change this. I may call this bt_operation_mode or something.

Call it bt_opermode or similar. Something shorter than some long crazy
name that takes a lot of space at least ;)

Also remove the UNKNOWN thing. That is useless. The devices is either
BREDR or LE_ONLY anyway. And worst case it is really BREDR. That has
been the default for a long time now.

And while at it just call it BREDR. And prefix this with
BT_OPERMODE_BREDR or so.

Regards

Marcel


