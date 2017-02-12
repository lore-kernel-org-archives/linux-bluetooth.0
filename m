Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAEd-yTTD0TAE86Ts=Doa0QFcMk2_FARQmxVr5zia8eaJ=NZNDA@mail.gmail.com>
References: <CAEd-yTTD0TAE86Ts=Doa0QFcMk2_FARQmxVr5zia8eaJ=NZNDA@mail.gmail.com>
From: Barry Byford <31baz66@gmail.com>
Date: Sun, 12 Feb 2017 19:56:32 +0000
Message-ID: <CAAu3APanyqS-4JdV6yV-nnAKT4bqJjREjUNB3M1Ziq4OHta3XA@mail.gmail.com>
Subject: Re: Bluez5.43 stack for bcm4334x chipset
To: Sinthu Raja M <sinthu.raja@mistralsolutions.com>
Cc: Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Raja,

On 12 February 2017 at 16:14, Sinthu Raja M
<sinthu.raja@mistralsolutions.com> wrote:
> Hi,
> I am working on Bluez5.43 stack, cross compiled for ARM v7 and
> successfully compiled. also ported into the target device. I am using
> Broadcom bluetooth chip (BCM4334x)The problem is when i do a hciconfig
> i am getting the following result
>
> # hciconfig
> hci0: Type: Primary  Bus: UART
> BD Address: 72:8E:6C:AB:DD:A4  ACL MTU: 1021:8  SCO MTU: 64:1
> DOWN
> RX bytes:647 acl:0 sco:0 events:32 errors:0
> TX bytes:407 acl:0 sco:0 commands:32 errors:0
>
> 1)  I am not able to scan any devices.  what could be the possible
> causes ? In my other bluetooth device it is detected as Bluetooth USB
> Host Controller
>
> 2) But I am expecting the following result
> # hciconfig
> hci0:   Type: BR/EDR  Bus: UART
>         BD Address: C4:00:49:00:06:D9  ACL MTU: 1021:8  SCO MTU: 64:1
>         UP RUNNING PSCAN ISCAN
>         RX bytes:3640 acl:0 sco:0 events:317 errors:0
>         TX bytes:43776 acl:0 sco:0 commands:311 errors:
>
> What modifications I need to be done in hciattach_bcm4334x.c code
> inorder to get the above output or I need to modify in some other
> files of Bluez?

I'm not sure if it is relevant to your situation but on the Raspbery Pi 3
I need to apply the following patches to BlueZ 5.43 for the BCM43xx
https://gist.github.com/pelwell/c8230c48ea24698527cd

The issue I see without the patch is that the controller has an
address of all A's in bluetoothctl.

E.g:

$ bluetoothctl
[NEW] Controller AA:AA:AA:AA:AA:AA RPi3 [default]
[bluetooth]# show
Controller AA:AA:AA:AA:AA:AA
    Name: RPi3
    Alias: RPi3
    Class: 0x000000
    Powered: yes
    Discoverable: no
    Pairable: yes
    UUID: Generic Attribute Profile (00001801-0000-1000-8000-00805f9b34fb)
    UUID: A/V Remote Control        (0000110e-0000-1000-8000-00805f9b34fb)
    UUID: PnP Information           (00001200-0000-1000-8000-00805f9b34fb)
    UUID: Generic Access Profile    (00001800-0000-1000-8000-00805f9b34fb)
    UUID: A/V Remote Control Target (0000110c-0000-1000-8000-00805f9b34fb)
    Modalias: usb:v1D6Bp0246d052A
    Discovering: no
[bluetooth]# exit
[DEL] Controller AA:AA:AA:AA:AA:AA RPi3 [default]


>
> 3) Is there any thing to do with this HCI type for scanning?
>
> With Regards
> Raja
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
