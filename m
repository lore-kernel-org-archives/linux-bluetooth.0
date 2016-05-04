Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <5728C5DA.7000703@gmail.com>
References: <5728C5DA.7000703@gmail.com>
Date: Wed, 4 May 2016 14:03:42 +0300
Message-ID: <CABBYNZLiv7uY-i3W+TcieskEQqrxC6Y0pUkFatDSqL_wrsnHpg@mail.gmail.com>
Subject: Re: DBUS API error "Not paired" when attempting to read GATT characteristic
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Joe Glancy <joe.t.glancy@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Joe,

On Tue, May 3, 2016 at 6:38 PM, Joe Glancy <joe.t.glancy@gmail.com> wrote:
> Hello all.
>
> I was wondering whether someone could possibly help shine some light on an
> issue I'm having.
>
> Here's the setup:
>  - Ubuntu 16.04 w/Bluez 5.37 (from the official repos, experimental mode
> enabled)
>  - BBC micro:bit
>  - "hciconfig -a hci0":
> hci0:   Type: BR/EDR  Bus: USB
>         BD Address: XX:XX:XX:XX:XX:XX  ACL MTU: 1022:8  SCO MTU: 183:5
>         UP RUNNING PSCAN
>         RX bytes:718 acl:0 sco:0 events:54 errors:0
>         TX bytes:3731 acl:0 sco:0 commands:54 errors:0
>         Features: 0xff 0xfe 0x0d 0xfe 0xd8 0x7f 0x7b 0x8f
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>         Link policy: RSWITCH HOLD SNIFF
>         Link mode: SLAVE ACCEPT
>         Name: 'Io'
>         Class: 0x4c010c
>         Service Classes: Rendering, Capturing, Telephony
>         Device Class: Computer, Laptop
>         HCI Version: 4.1 (0x7)  Revision: 0x3101
>         LMP Version: 4.1 (0x7)  Subversion: 0x1
>         Manufacturer: Atheros Communications, Inc. (69)
>
> What I am trying to do:
>  - Read some bytes from a characteristic on the micro:bit through BlueZ's
> DBUS API using a Python script and the dbus module
>
> The error I am getting:
>  - "org.bluez.Error.NotPermitted: Not paired"
>
> I have paired the micro:bit both from the normal Ubuntu Bluetooth settings
> menu, and I have also paired it with the bluetoothctl tool, each on separate
> occasions. Both reported that the pair was successful (no pin was required
> however, compared to when I pair the micro:bit to my phone I do need the
> pin), however when I tried running my script (which does not check whether
> the device is paired or connected: this is performed by the user, and I can
> verify that both the Ubuntu settings and bluetoothctl reported it as both
> paired and connected), I get the afore mentioned error
> ("org.bluez.Error.NotPermitted: Not paired").

case BT_ATT_ERROR_AUTHENTICATION:
case BT_ATT_ERROR_INSUFFICIENT_ENCRYPTION:
case BT_ATT_ERROR_INSUFFICIENT_ENCRYPTION_KEY_SIZE:
return btd_error_not_permitted(msg, "Not paired");

So any of these errors could be causing the problem, perhaps it is the
device that requires higher security.

> Is this, therefore, an error with my program (I have spent hours checking it
> and cannot find any errors)? Or a possible bug with BlueZ? There are very
> few resources online for this kind of thing so I ended up resorting to the
> Bluetooth mailing list - please notify me if this is the wrong kind of stuff
> to be asking.
>
> The micro:bit is the only LE device which has ever connected to this
> (laptop) computer, and the characteristic (and its service) which I am
> reading from do both exist as DBUS objects. My grasp of the DBUS system is
> rather rudimentary, and so far has just been gained from BlueZ examples.
>
> I have checked using the DBUS API to make sure that the device is both
> paired and connected - both said yes, but, as previously said I get an error
> (more specifically, an exception is thrown when I try to call "<DBUS
> interface to characteristic>.ReadValue()").

How you are actually testing this, perhaps you should try using bluetoothctl:

> agent on
> default-agent
> pair <address>
> select-attribute <object>
> read

> Is this my doing, or an issue with something out of my control? Any help
> will be appreciated :)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
