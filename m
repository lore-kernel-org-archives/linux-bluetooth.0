Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <68c8200a-d99f-431c-8685-30b5b9e395c4@interia.pl>
References: <68c8200a-d99f-431c-8685-30b5b9e395c4@interia.pl>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Sat, 26 May 2018 08:13:02 +0300
Message-ID: <CABBYNZKAHLb9ELQUyvfCdb70HdfbWDXMO201d9_4yebPvWDBLQ@mail.gmail.com>
Subject: Re: Problem with mpris-proxy
To: =?UTF-8?Q?Rafa=C5=82_Bilski?= <rafalbilski@interia.pl>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Rafal,

On Fri, May 25, 2018 at 7:31 PM, Rafa=C5=82 Bilski <rafalbilski@interia.pl>=
 wrote:
> Hello,
>
>     I've been trying to display track name on bluetooth device AND contro=
l a
> player on computer using
>
> device's buttons.
>
>     I can have one, but not both.
>
>     If "mpris-proxy" isn't running I get key pressed/released event on
> computer and I can control the player
>
> with buttons. Even if player doesn't have GUI it seems to get signals on
> dbus mpris interface. BUT no metadata

Do you have the mpris-player and bluetoothd logs?

> seems to be send to bluetooth device and there isn't anything on display.
>
>     When "mpris-proxy" is running player doesn't get any button events, B=
UT
> I have all track information on
>
> a display.

Perhaps with dbus-monitor if the message is not being rejected or something=
.

>     In both cases, with pulseaudio, "btmon" shows that device sends key
> pressed/released events:
>
>> ACL Data RX: Handle 43 flags 0x02 dlen 12                  #1 [hci0]
>> 6.185397
>       Channel: 68 len 8 [PSM 0 mode 0] {chan 0}
>         30 11 0e 00 48 7c 46 00 0...H|F.
> < ACL Data TX: Handle 43 flags 0x00 dlen 12 #2 [hci0] 6.185506
>       Channel: 68 len 8 [PSM 0 mode 0] {chan 0}
>         32 11 0e 09 48 7c 46 00 2...H|F.
>> ACL Data RX: Handle 43 flags 0x02 dlen 12 #3 [hci0] 6.189511
>       Channel: 68 len 8 [PSM 0 mode 0] {chan 0}
>         40 11 0e 00 48 7c c6 00 @...H|..
> < ACL Data TX: Handle 43 flags 0x00 dlen 12 #4 [hci0] 6.189650
>       Channel: 68 len 8 [PSM 0 mode 0] {chan 0}
>         42 11 0e 09 48 7c c6 00 B...H|..
>> HCI Event: Number of Completed Packets (0x13) plen 5 #5 [hci0] 6.191383
>         Num handles: 1
>         Handle: 43
>         Count: 1
>> HCI Event: Number of Completed Packets (0x13) plen 5 #6 [hci0] 6.193385
>         Num handles: 1
>         Handle: 43
>         Count: 1
>
>     On bluealsa I only have sound. No keys or information on display.
>
> Is this issue related to pulseaudio?
> Can I somehow take over uuid 0x110e using dbus and python and still have
> sound?
> I tried connecting to 0x110e L2CAP socket, but this only works if device =
is
> disconnected and unable to produce sound.
>
> Please advise
> Rafal Bilski
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth=
"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
Luiz Augusto von Dentz
