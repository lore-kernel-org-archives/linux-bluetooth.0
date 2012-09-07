Return-Path: <cyrus@holtmann.org>
Message-ID: <1347049933.21200.141.camel@aeonflux>
Subject: Re: [PATCH 1/2] Implement broadcom patchram firmware loader
From: Marcel Holtmann <marcel@holtmann.org>
To: Jesse Sung <jesse.sung@canonical.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 07 Sep 2012 13:32:13 -0700
In-Reply-To: <CAH10aOj2VP2W1MPxLztWR4-enOmaLF=oyC2zg898-f9vyf0sJQ@mail.gmail.com>
References: <1346390510-18538-1-git-send-email-jesse.sung@canonical.com>
	 <1346390510-18538-2-git-send-email-jesse.sung@canonical.com>
	 <1346429464.23377.19.camel@aeonflux>
	 <CAH10aOj2VP2W1MPxLztWR4-enOmaLF=oyC2zg898-f9vyf0sJQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jesse,

> >>  static int btusb_probe(struct usb_interface *intf,
> >>                               const struct usb_device_id *id)
> >>  {
> >> @@ -1078,15 +1162,26 @@ static int btusb_probe(struct usb_interface *intf,
> >>               }
> >>       }
> >>
> >> +     usb_set_intfdata(intf, data);
> >> +
> >> +     if (id->driver_info & BTUSB_BCM_PATCHRAM) {
> >> +             const struct usb_device_id *match;
> >> +             match = usb_match_id(intf, patchram_table);
> >> +             if (match) {
> >> +                     btusb_open(hdev);
> >> +                     load_patchram_fw(interface_to_usbdev(intf), match);
> >> +                     btusb_close(hdev);
> >> +             }
> >> +     }
> >> +
> >
> > So we are now blocking every other USB devices on that bus here? I
> > actually do not like this idea very much.
> 
> Do you mean the usleep() in load_patchram_fw()? These only affects people
> who have this kind of device, so the impact should be limited.

and what about the global USB lock that is hold when probing devices.

> > Also the call of btusb_open() before hdev is actually registered is
> > kinda fishy to me. I am not even sure that works how you think it would.
> 
> Humm.. If there are concerns about calling btusb_open() and btusb_close(),
> I'll try to find another way to hook usb callbacks.

They are callbacks exposed from hci_dev and not for direct calling.

I have been telling this before multiple times. If you require a
firmware patching stage, then integrate that into hci_dev directly and
use the core for driving this properly.

> > And why can't Broadcom just change the PID once the patchram has been
> > loaded to something else. That way we can nicely iterate through this.
> 
> Unfortunately that's how they do it now, and these modules are already in
> users' machines.

Some companies never ever learn. Most funny is that we had the bcm203x
driver that was doing this correctly. And 8 years later they have
forgotten all about it.

Regards

Marcel


