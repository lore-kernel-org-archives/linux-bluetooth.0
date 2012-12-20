Return-Path: <cyrus@holtmann.org>
Date: Thu, 20 Dec 2012 11:19:43 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrey Voropaev <voropaev.andrey@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Authentication Rejected when pairing stereo headset
Message-ID: <20121220091943.GA5862@x220>
References: <CAFOXTdcaRvGHesU_J7rW93Yp_5d438+x5xryCzAhY9QQL_-Y4Q@mail.gmail.com>
 <20121220080447.GA561@x220>
 <CAFOXTde8iSouGKEVZKG-egvPUr4LAyLnFigVa6avhpqTjXNq8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAFOXTde8iSouGKEVZKG-egvPUr4LAyLnFigVa6avhpqTjXNq8A@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrey,

First of all, please don't do top posting. It messes up the thread,
especially when mixed with inline quoting.

On Thu, Dec 20, 2012, Andrey Voropaev wrote:
> I've copied the output from hcidump -w to http://vandal.sdf-eu.org/hcidump.file
>
> So far, I'm not sure how to add -d switch to bluetoothd. It is started
> via dbus and this monster is not familiar to me. Can you please tell
> me, which file should I edit to add the switch?

Actually the hcidump helped a lot. It shows an issue on the kernel side:

 < HCI Command: IO Capability Request Reply (0x01|0x002b) plen 9
     bdaddr 00:1A:7D:25:2C:A4 capability 0x04 oob 0x00 auth 0x03
     Capability: Reserved (OOB data not present)
     Authentication: Dedicated Bonding (MITM Protection)
 > HCI Event: Command Complete (0x0e) plen 10
     IO Capability Request Reply (0x01|0x002b) ncmd 1
     status 0x12 bdaddr 00:1A:7D:25:2C:A4
     Error: Invalid HCI Command Parameters

The IO capability value 0x04 that the kernel is responding with is
invalid and shouldn't be sent to the controller. This was already fixed
quite long time ago (about 1 year ago) by the following patch from
Hemant Gupta: "Bluetooth: Send correct response to IO Capability Request"

It adds the following code to the IO capability handling to avoid 0x04
from being sent:

        /* Change the IO capability from KeyboardDisplay
         * to DisplayYesNo as it is not supported by BT spec. */
        cp.capability = (conn->io_capability == 0x04) ?
                                        0x01 : conn->io_capability;

It seems however that your kernel is missing this patch and the right
way forward would be to include it.

Johan
