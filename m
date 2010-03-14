Return-Path: <cyrus@holtmann.org>
Subject: Re: A strange compatible problem for eSCO audio with CSR USB
 Bluetooth dongle
From: Marcel Holtmann <marcel@holtmann.org>
To: Cooper Xu <cooper.xu@mapleworks.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1660E2CC4AF24655A1FFE788570A34FF@mapleworks.com>
References: <1660E2CC4AF24655A1FFE788570A34FF@mapleworks.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 14 Mar 2010 16:28:50 -0700
Message-ID: <1268609330.3897.51.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Cooper,

> We have a strange compatible problem with Bluez for eSCO audio. 
> 
> We develope an embedded application based on Bluez library that can play the
> role of HF and it uses a generic CSR USB Bluetooth dongle. The application
> worked well for most cell phones (iPhone, Blackberry etc). But when we tried
> it with an Android phone (Motorola Droid), we found one way voice problem.
> The Android phone side can not hear the voice. 

do you have a link to your sources so that we can have a look at it.

> We know that Android phone also uses the Bluez library. So we tried to pair
> our application with another Linux with Bluez library with another CSR USB
> Bluetooth dongle. We used "hcidump" to capture the SCO packets in that
> system. We received a lot of SCO packets, but the content of packets is all
> zero. However from another end of SCO connection, we actually sent a lot
> non-zero contents. 
> 
> To simply our debug, we then used the "scotest" program from the Bluez 4.65
> source and used one system as client and another as server. From the hcidump
> output, we still saw the content of packets is all zero. However when we
> changed one USB dongle to another USB dongle with the Broadcom chipset, we
> can receive some non-zero data. In both case, we didn't see Bluez kernel
> error message.

If you are using BlueZ 4.65 then I want a ride in your time machine ;)

> The Linux kernel for the system we used for test is 2.6.30.  The attachment
> is the SCO packet we captured for receiving side. The following is the
> information of Bluetooth USB dongle we use:
> 
>         BD Address: 00:11:F6:0B:CA:EE ACL MTU: 310:10 SCO MTU: 64:8
>         UP RUNNING PSCAN AUTH ENCRYPT

Bluetooth security mode 3. Seriously? Who still thinks this is a good
idea. I don't get it.

>           BD Address: 00:11:F6:0B:CA:EE ACL MTU: 310:10 SCO MTU: 64:8
>           Unified 21e
>           Chip version: BlueCore4-ROM
>           Max key size: 128 bit
>           SCO mapping:  HCI

So at least the SCO mapping is correctly set to HCI.

For the 2.6.30 kernel, that is a pretty ancient kernel. It is most
likely over 9 month old. I would prefer if you can re-test it with a
2.6.34-rc1 kernel to ensure there is no kernel issue.

> This audio problem seems only happen if both ends use Bluez library. If one
> side uses a different Bluetooth library, this issue will not appear. What
> can be the cause of this? I am very confused. 

Nothing can really cause this. Please show us the source code for your
application maybe someone can have a quick look. The BlueZ builtin
headset and handsfree support works perfectly.

Regards

Marcel


