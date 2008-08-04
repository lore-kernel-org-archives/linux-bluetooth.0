Return-Path: <cyrus@holtmann.org>
From: Oliver Neukum <oliver@neukum.org>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [rfc]btusb with SCO support
Date: Mon, 4 Aug 2008 18:23:27 +0200
Cc: linux-bluetooth@vger.kernel.org,
 linux-usb@vger.kernel.org
References: <200807311452.24166.oliver@neukum.org> <200808041033.05446.oliver@neukum.org> <7B57E1E8-7077-4CCB-AF81-ACF5DCBCE918@holtmann.org>
In-Reply-To: <7B57E1E8-7077-4CCB-AF81-ACF5DCBCE918@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200808041823.28309.oliver@neukum.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Am Montag 04 August 2008 18:05:11 schrieb Marcel Holtmann:
> Hi Oliver,
> 
> >>>
> >>> +module_param(override_ignore, bool, 0644);
> >>> +MODULE_PARM_DESC(override_ignore, "Drive blacklisted devices");
> >>
> >> Why do we need this one? What is it good for?
> >
> > To override HCI_IGNORE. IF we provide overrides for blacklist entries,
> > it should be done systematically.
> 
> no we should not do that. The HCI_IGNORE is for devices that pretend  
> to be Bluetooth H:2 compatible, but they are not. In these cases we do  
> have other drivers that do this right. See bcm203x and bpa10x drivers.

Then why do you implement this option for hci_usb?
And why can the other IGNORE options be overridden?

	Regards
		Oliver
