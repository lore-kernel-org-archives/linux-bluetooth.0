Return-Path: <cyrus@holtmann.org>
Subject: Re: using hci0 interface without DEVUP
From: Marcel Holtmann <marcel@holtmann.org>
To: Pavan Savoy <pavan_savoy@ti.com>
Cc: linux-bluetooth@vger.kernel.org,
	"Leibovitch, Kobi" <kobile@ti.com>,
	pavan savoy <pavan_savoy@yahoo.co.in>
In-Reply-To: <010f01cb1d12$67fecdc0$LocalHost@minx0099669>
References: <250863.34433.qm@web94911.mail.in2.yahoo.com>
	 <1278420904.2789.41.camel@localhost.localdomain>
	 <010f01cb1d12$67fecdc0$LocalHost@minx0099669>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 06 Jul 2010 11:08:37 -0300
Message-ID: <1278425317.2789.43.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Pavan,

> >> In certain cases, as in using VS commads to communicate with different cores on the combo chips 
> >> (say, BT, FM, GPS) - we would have to use the hci0 interface without it being UP.
> >>
> >> As in the hci0 interface still needs to be invisible (via dbus/bluetoothd) to the system but to be 
> >> available to be use.
> >>
> >> Is there a way we can do this while registering with the hci ?
> >> say a flag in the struct hci_dev to be by default during registration HCI_DEV_DOWN to be default 
> >> state ?
> >
> > it is a pretty simple fact that the HCI device has to up. Otherwise it
> > is not going to work. Same with an Ethernet interface. That is the
> > proper state for such interfaces.
> 
> device should be UP and RUNNING, I agree, But somehow to hide this from the bluetoothd !! is my 
> concern,
> hide this from bluetoothd, and hence hide this from dbus, so as to hide it from rest of the system 
> ...
> 
> > What you want is to set RAW mode on the HCI device before bringing it
> > up. Then bluetoothd will actually ignore it.
> 
> You mean to say HCI_RAW to the hdev->flags ?
> But that has the same effect even now because our HCI commands are HCI_VS, ogf of 0x3f.
> 
> > However I am not sure what you are really trying to achieve here since
> > every device will be brought up automatically by bluetoothd. And so you
> > are already to late to the game at that point.
> 
> exactly what I am trying to avoid, as in during hci_register_dev, I provide a flag from my hdev, 
> telling whether
> hci_notify and hence sock internal notification should happen at all ...
> Thereby, when I do
> 
> set_bit(hdev, NO_NOTIFY);
> hci_register_dev(hdev);  --> bluetoothd doesn't get notification of a HCI-REG itself.
> 
> But the problem would then be, how would I do a DEVUP internally ...
> Any hints ??

listen to what I said. If you wanna set this as RAW device from the
kernel, then that is fine as well. You can do that. Only exception is
that you can never take this back from userspace:

	set_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks);

Regards

Marcel


