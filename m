Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <512A82B3.405@kamens.us>
References: <51100E6E.8070804@kamens.us>
	<CAJdJm_MsOBOGTBoG+Nua49DbwuXx5Pu5KRm9zMp2ma3_nhF2CQ@mail.gmail.com>
	<512A82B3.405@kamens.us>
Date: Mon, 25 Feb 2013 11:25:50 +0200
Message-ID: <CABBYNZLRZkosRo95TDGMOwfD4-QB5NgP7erT1CoWzGbdq=o-ig@mail.gmail.com>
Subject: Re: HFP/HSP Telephony profile doesn't work with Bluetooth USB dongle
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Jonathan Kamens <jik@kamens.us>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jonathan,

On Sun, Feb 24, 2013 at 11:14 PM, Jonathan Kamens <jik@kamens.us> wrote:
>
> $ uname -r
> 3.7.9-201.fc18.x86_64
> $ bluetoothd --version
> 4.101
> $

The SCO connection seems to be established without problems:

> HCI Event: Command Status (0x0f) plen 4
    Setup Synchronous Connection (0x01|0x0028) status 0x00 ncmd 1
> HCI Event: Synchronous Connect Complete (0x2c) plen 17
    status 0x00 handle 6 bdaddr 00:12:3D:00:48:FD type eSCO
    Air mode: CVSD

But I cannot see any packets which might be the cause of your problem,
so it might be a controller/driver related not PulseAudio problem. You
can check what is the current voice settings of the controller by
doing:

> sudo hciconfig hci0 voice


--
Luiz Augusto von Dentz
