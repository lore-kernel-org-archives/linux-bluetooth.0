Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH v3] Bluetooth: Add HCI_AUTO_CONN_DIRECT_REPORT_IND
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAHF=Y4owMj-RBquSk2GWVjGSL4H1SU0qC6pVEN6DJvdmyqw9zA@mail.gmail.com>
Date: Mon, 29 Sep 2014 13:34:22 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <BCEE5DFC-08DA-43A7-AED8-BEFD837B07ED@holtmann.org>
References: <1411746855-9936-1-git-send-email-fons@spotify.com> <24D2CD11-D43B-4F53-8A7C-175934A54C87@holtmann.org> <CAHF=Y4owMj-RBquSk2GWVjGSL4H1SU0qC6pVEN6DJvdmyqw9zA@mail.gmail.com>
To: Alfonso Acosta <fons@spotify.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alfonso,

you can not send HTML emails here. The mailing list will just reject you.

> I am not really convinced that this is a good idea. In general either you really want Action 0x01 and only accept incoming connection or you want Action 0x02 and connect to the device no matter what.
> 
> We are dealing with an HID device which sends meaningful information in ADV_IND reports and to which we want to connect when receiving ADV_DIRECT_IND reports.
> 
> Without kernel support for auto-connecting on ADV_IND while still forwarding ADV_DIRECT_IND to userland, we are forced to keep active scanning on so that the content of ADV_IND reports isn't lost.
> 
> We would of course like to avoid active scanning when possible, hence the reason on the patch.

The kernel does support connecting on ADV_IND. When you use Action 0x02, then it auto-connects when seeing ADV_IND and ADV_DIRECT_IND.

Forwarding ADV_DIRECT_IND to userspace is not really useful since the only thing you can do with it is actually connect. In addition if you are using high duty cycle ADV_DIRECT_IND, then you need to connect rather quickly to that device. Even if you happen to have a Bluetooth 4.1 peripheral that uses low duty cycle ADV_DIRECT_IND it will still not carry any advertising data.

> Originally I had the idea that the advertising data that you receive from ADV_IND when Action 0x02 is in play gets also included in Device Connected event.
> 
> In our particular case, based on the content of ADV_IND we may not want to or simply can't connect to the device right away. In other words, the Device Connected event may never arrive (if the connection fails) and if it does, it's already too late to decide whether we want to connect or not.

If you have added a peripheral device address to the kernel, then it means you actually do want to connect to that device. The connection will normally always succeed in that case. The kernel auto-connection logic only uses low security level. The elevation into medium or high security levels is done by userspace. And if you do not like the connection, you can just reject it. However if you don't want the connection, then it should not be in the auto-connect list in the first place.

> One could argue that the device should be broadcasting ADV_NONCONN_IND instead, but I don't think it makes it non-compliant. 

If you advertising with ADV_NONCONN_IND, then your peripheral is not connectable at all. The specification calls these broadcaster devices.

> Johan told me on IRC that, as opposed to introducing HCI_AUTO_CONN_DIRECT_REPORT_IND, modifying HCI_AUTO_CONN_DIRECT to also forward ADV_IND to userland in Device Found events could be considered. Are you open to this idea?

The background with Add Device Action types is that they also need to map to BR/EDR as well. So Action 0x01 for BR/EDR defines the concept of incoming connections. It means it allows incoming connections. On LE that would map to ADV_DIRECT_IND since that is the only way for a slave to connect to a master. So that mapping is pretty straight forward.

This means that there is not equivalent of ADV_IND on BR/EDR side and this would make the Action 0x01 a little bit unbalanced.

I still think that what you really want is actually using Action 0x02 since you know the remote device address and you want to connect it. It does not matter if it happens via ADV_DIRECT_IND or ADV_IND in the end. However in case it happens via ADV_IND you want to get the advertising data and for that I am proposing to get it via Device Connected event.

Regards

Marcel

