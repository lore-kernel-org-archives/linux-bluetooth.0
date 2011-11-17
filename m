Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 6/6] Bluetooth: Support LE-Only discovery procedure
From: Marcel Holtmann <marcel@holtmann.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 17 Nov 2011 09:59:38 +0900
In-Reply-To: <44EE3913-AD40-4EAC-A7AE-A2BC8812B186@openbossa.org>
References: <1321051824-5216-1-git-send-email-andre.guedes@openbossa.org>
	 <1321051824-5216-7-git-send-email-andre.guedes@openbossa.org>
	 <1321080225.15441.417.camel@aeonflux>
	 <A37EF08F-5B90-43F3-AA5B-BE0FD282E3D7@openbossa.org>
	 <1321479940.15441.550.camel@aeonflux>
	 <44EE3913-AD40-4EAC-A7AE-A2BC8812B186@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1321491582.15441.557.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> >>> And here, I have a serious problem with how the code is done. I realize
> >>> that from using hdev->flags this ends up this crappy, but this is not
> >>> how I wanna see things done.
> >>> 
> >>> What you are doing is this:
> >>> 
> >>> - We call a complete unrelated function anyway
> >>> - And if it fails with a specific error code then we call something
> >>> else instead
> >>> 
> >>> I think it becomes pretty obvious now that we should just have had
> >>> hdev->mgmt_flags that tell us with discovery procedure is running right
> >>> now. And thus we know how to cancel it.
> >> 
> >> I'm not sure this will help us in case we have a interleaved discovery
> >> running. My point is, even if we know what discovery procedure is running,
> >> we need to know what the controller is doing right now (inquiring or le
> >> scanning) so we can properly stop it, and, therefore, stop the ongoing
> >> discovery procedure. IOW, telling us we have a interleaved discovery
> >> running does not help us to decide the right function to call
> >> (hci_cancel_inquiry or hci_cancel_le_scan).
> >> 
> >> So, I think we need to check the controller flags (HCI_INQUIRY and
> >> HCI_LE_SCAN) in order to stop the ongoing discovery procedure properly.
> > 
> > I have nothing against separate flags. That makes fully sense. I have
> > something against weirdly calling one function and expecting it to error
> > out. Relying on an error is a bad idea. You want to keep track of what
> > is currently going on.
> 
> Ok, I agree with that too.
> 
> The way I see to fix that is we have something like we had before:
> 
> if (HCI_INQUIRY)
> 	hci_cancel_inquiry()
> else if (HCI_LE_SCAN)
> 	hci_cancel_le_scan()
> 
> The drawback, as you already pointed, is the double check of these
> flags.

there is nothing you can do about it actually. However with the changes
we are doing, the flags are internal. That is really important to me to
be able to move over to a proper userspace side API in the future that
does not rely on a magic bitmask.

And also it is in one place here so people can easily understand what
code is run with what dependency.

> But, as I said before, the flags checking in stop_discovery is to
> decide the right cancel helper function to call. The flag checking
> in hci_cancel_*() helper functions guarantees no cancel command is
> sent to the controller if there is no ongoing inquiry or le scan.
> The flag checking in stop_discovery() and hci_cancel_*() have
> different purposes.
> 
> Since hci_cancel_*() are helper functions and they can be reused in
> future by other parts of the code, I think it is a good idea we keep
> the flag checking internally. This way we don't rely on the programmer
> doing the proper checking before calling these helper functions.

I lost you here. I need to see this in code.

Regards

Marcel


