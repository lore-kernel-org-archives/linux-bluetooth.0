Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CADU0VqyM081pHYtNWTxM+ajg-f2-jcs=F_5wCnV5L2_mOQ_TvQ@mail.gmail.com>
References: <CADU0VqyM081pHYtNWTxM+ajg-f2-jcs=F_5wCnV5L2_mOQ_TvQ@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 15 Nov 2017 13:39:09 +0200
Message-ID: <CABBYNZJKYniLeC3oGn7QgDyVN27VzjY2g=oeauHkQGSqAUfK+w@mail.gmail.com>
Subject: Re: Security block and Bluez 5.47
To: John Klug <ski.brimson@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi John,

On Tue, Nov 14, 2017 at 11:45 PM, John Klug <ski.brimson@gmail.com> wrote:
> I have tried unblock, and nothing seems to help.
>
> Frequently when I connect my Android phone to my bluez 5.47 device I
> see (btmon):
>
>  > HCI Event: Number of Completed Packets (0x13) plen 5
>
>                                                             #36 [hci0]
> 5.709020
>          Num handles: 1
>          Handle: 1
>          Count: 1
>  < ACL Data TX: Handle 1 flags 0x00 dlen 16
>
>                                                             #37 [hci0]
> 5.714589
>        L2CAP: Connection Response (0x03) ident 4 len 8
>          Destination CID: 64
>          Source CID: 81
>          Result: Connection refused - security block (0x0003)
>          Status: No further information available (0x0000)
>
> This is using connecting from Android 7 to Bluez 5.47.

I think this might be due to not having a default agent set which is
needed if the devices is not trusted so it would require agent
authorization.

>
>  [bluetooth]# info DC:74:A8:05:39:77
>  Device DC:74:A8:05:39:77
>          Name: John Cell Phone
>          Alias: John Cell Phone
>          Class: 0x005a020c
>          Icon: phone
>          Paired: yes
>          Trusted: yes
>          Blocked: no
>          Connected: no
>          LegacyPairing: no
>          UUID: OBEX Object Push          (00001105-0000-1000-8000-00805f9b34fb)
>          UUID: Audio Source              (0000110a-0000-1000-8000-00805f9b34fb)
>          UUID: A/V Remote Control Target (0000110c-0000-1000-8000-00805f9b34fb)
>          UUID: Headset AG                (00001112-0000-1000-8000-00805f9b34fb)
>          UUID: PANU                      (00001115-0000-1000-8000-00805f9b34fb)
>          UUID: NAP                       (00001116-0000-1000-8000-00805f9b34fb)
>          UUID: Handsfree Audio Gateway   (0000111f-0000-1000-8000-00805f9b34fb)
>          UUID: Phonebook Access Server   (0000112f-0000-1000-8000-00805f9b34fb)
>          UUID: Message Access Server     (00001132-0000-1000-8000-00805f9b34fb)
>          UUID: PnP Information           (00001200-0000-1000-8000-00805f9b34fb)
>          UUID: Generic Access Profile    (00001800-0000-1000-8000-00805f9b34fb)
>          UUID: Generic Attribute Profile (00001801-0000-1000-8000-00805f9b34fb)
>          UUID: Vendor specific           (936da01f-9abd-4d9d-80c7-02af85c822a8)
>          Modalias: bluetooth:v0075p0100d0200
>
>  [bluetooth]# show
>  Controller 00:23:A7:49:67:FB
>          Name: MTCDT-pan-Bluez
>          Alias: MTCDT-pan-Bluez
>          Class: 0x00020000
>          Powered: yes
>          Discoverable: yes
>          Pairable: yes
>          UUID: Generic Attribute Profile (00001801-0000-1000-8000-00805f9b34fb)
>          UUID: NAP                       (00001116-0000-1000-8000-00805f9b34fb)
>          UUID: A/V Remote Control        (0000110e-0000-1000-8000-00805f9b34fb)
>          UUID: PnP Information           (00001200-0000-1000-8000-00805f9b34fb)
>          UUID: Generic Access Profile    (00001800-0000-1000-8000-00805f9b34fb)
>          UUID: A/V Remote Control Target (0000110c-0000-1000-8000-00805f9b34fb)
>          Modalias: usb:v1D6Bp0246d052F
>          Discovering: no
>
>  $ bluetoothctl -v
>  5.47
> ======================================================
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
