Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <508E30B7-76A0-4589-8D2D-5C736695E4C4@gmail.com>
References: <508E30B7-76A0-4589-8D2D-5C736695E4C4@gmail.com>
From: Barry Byford <31baz66@gmail.com>
Date: Thu, 9 Feb 2017 11:13:54 +0000
Message-ID: <CAAu3APY6k07tYS_uAvPN77r1crhGiPKRQ0S9MTmF7LgLcvtrBw@mail.gmail.com>
Subject: Re: Scanning for advertising packets more often
To: Bridger Maxwell <bridger.maxwell@gmail.com>
Cc: Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Bridger,

On 9 February 2017 at 02:09, Bridger Maxwell <bridger.maxwell@gmail.com> wr=
ote:
> Hi,
>
> I=E2=80=99m trying to make a Bluetooth LE peripheral that will work witho=
ut pairing. Instead, multiple receivers can listen for events by listening =
for changes in the advertising packet. I=E2=80=99ve got the peripheral conf=
igured to broadcast every 100ms, but the receiver running Bluez only gets u=
pdates about once per second.
>
> Is there a way to configure Bluez to get advertising packets scanned more=
 often? I=E2=80=99d also like to turn off any duplicate filtering.
>
> Additionally, the peripheral broadcasts two types of advertising packets.=
 One type is from the builtin firmware and I don=E2=80=99t care about. The =
other type is my custom advertising packet. Both of these have the same MAC=
 address. I believe Bluez is filtering duplicates from the same address wit=
hin each 1 second window. I am getting a random sampling of either the firm=
ware advertising packet or my custom advertising packet once per second.
>
> I=E2=80=99m using Pybluez[ble] to use Bluez. This is the scratch script I=
 have running so far: https://gist.github.com/bridger/83fc2e9c60fd07d925b0b=
ec80c47acab I tried using LE_SET_SCAN_PARAMETERS to change the scan interva=
l and window but this didn=E2=80=99t seem to have an effect.
>
> If this is a bad idea, let me know. I liked the simplicity of not pairing=
 but maybe I=E2=80=99m headed in the wrong direction.

You may find this link to a previous thread relevant to your requirements:
http://marc.info/?l=3Dlinux-bluetooth&m=3D148106041713054&w=3D2



>
> - Bridger Maxwell--
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
