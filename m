Return-Path: <cyrus@holtmann.org>
Message-ID: <1334839305.16897.280.camel@aeonflux>
Subject: Re: [PATCH 2/2] rfkill: Set device powered even adapter is not
 created
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@intel.com>
Cc: "Wang, Arron" <arron.wang@intel.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Thu, 19 Apr 2012 14:41:45 +0200
In-Reply-To: <20120419123136.GA27022@x220.ger.corp.intel.com>
References: <1326704570-22854-1-git-send-email-arron.wang@intel.com>
	 <20120419074533.GA20567@x220.ger.corp.intel.com>
	 <3B8E4CEA2CC045459E7856C66B82CE930FD5E48E@SHSMSX102.ccr.corp.intel.com>
	 <20120419123136.GA27022@x220.ger.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> > >> --- a/src/rfkill.c
> > >> +++ b/src/rfkill.c
> > >> @@ -128,11 +128,18 @@ static gboolean rfkill_event(GIOChannel *chan,
> > >>  	if (id < 0)
> > >>  		return TRUE;
> > >>
> > >> +	DBG("RFKILL unblock for hci%d", id);
> > >> +
> > >>  	adapter = manager_find_adapter_by_id(id);
> > >> -	if (!adapter)
> > >> +	if (!adapter) {
> > >> +		/*
> > >> +		 * If device is rfkilled, the initialize operation
> > >> +		 * may failed and adapter is not created, then we
> > >> +		 * need to set the device powered directly.
> > >> +		 */
> > >> +		adapter_ops_set_powered(id, TRUE);
> > >>  		return TRUE;
> > >> -
> > >> -	DBG("RFKILL unblock for hci%d", id);
> > >> +	}
> > >>
> > >>  	btd_adapter_restore_powered(adapter);
> > >
> > >This looks more like a workaround to another issue: if the kernel is
> > >aware of the adapter but user space isn't it means that something has
> > >gone wrong during the initialization process and *that* should be
> > >fixed instead of blindly attempting to power on the adapter id
> > >anyway.
> > 
> > Kernel works well and can detect the adapter, Bluetooth initialize failed
> > due to when we init HCI device, we try to start the device, however the
> > device is hardware/software rfkilled. From the code, we only init the
> > adapter when the device is up, this result in the current code in rfkill.c
> > can't bring up the device because adapter is NULL. Also only the kernel
> > detected the device we can get the rfkill event, the code in rfkill.c also
> > checked the device, then it is safe to power on the device in rfkill.c
> 
> Ok, now I understand the issue better. Unfortunately your approach wont
> work with the management interface since the HCI index is invalid until
> the kernel has been able to send the first basic HCI commands. The
> expectation there is also that the first mgmt command to be sent for a
> new index is read_info.
> 
> I had a brief chat with Marcel and one potential solution would be to
> have a kernel side timer for rfkilled devices to let the basic HCI
> commands be sent before bringing the adapter down. This would allow user
> space to have a properly initialized adapter object and your patches
> wouldn't be needed.

I actually meant to have the pending RFKILL events to be handled in
userspace.

But sure for the RFKILL switches that are tight to a Bluetooth
controller and are part of hci_dev, we could be even smarter inside the
kernel.

Regards

Marcel


