Return-Path: <cyrus@holtmann.org>
Message-ID: <4F9B0108.2000007@tu-ilmenau.de>
Date: Fri, 27 Apr 2012 22:26:48 +0200
From: Steffen Becker <steffen.becker@tu-ilmenau.de>
MIME-Version: 1.0
To: Kal Torak <chronognosis@aim.com>
CC: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Re: main.conf issues
References: <201204271541.q3RFfVd5006035@imr-da04.mx.aol.com>
In-Reply-To: <201204271541.q3RFfVd5006035@imr-da04.mx.aol.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Torak,

I'm not very familiar with BlueZ (also just asking questions on this 
mailing list), but what I can tell is that:
You have to setup this file:
/var/lib/bluetooth/<local-bdaddr>/config
At the moment I can't look up the right syntax for all the 
configuration, but if i remember right, for enabling discoverable mode 
you have to enter something like this in the config-file:

onmode discoverable
mode discoverable

For changing the name of your device, you have to edit this line in the 
config-file:

name <your-name>

Hope this helps you.
Regards,
Steffen


Am 27.04.2012 17:40, schrieb Kal Torak:
> Hello, When I setup the main.conf with the values for Name, Class,
> PairableTimeout and DiscoverableTimeout, and restart the bluetoothd,
> hciconfig shows that nothing change name still the same, I cant "see"
> the device from the outside(iscan is disabled), and the class still
> 0x000100, and I must re-do hciconfig hci name #### class #### and
> hciconfig hci0 piscan by hand to make the device visible and try
> streaming support, OTOH I just can't see and/or connect to the device.
> a ConWise 6622 Bluetooth dongle.
> I'm using bluez-4.99 and linux 3.2.15.Any information will be usefull...
>
> Regards,
> Torak
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

