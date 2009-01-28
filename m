Return-Path: <cyrus@holtmann.org>
Subject: Re: Can we connected HFP and A2DP at the same time?
From: Marcel Holtmann <marcel@holtmann.org>
To: =?UTF-8?Q?=E5=8D=9E=E7=A3=8A?= <mykofzone@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <a172fe730901222111i1837081apadbf9402d57868c2@mail.gmail.com>
References: <a172fe730901222111i1837081apadbf9402d57868c2@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 28 Jan 2009 06:51:59 +0100
Message-Id: <1233121919.18259.15.camel@violet>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

>      This is the case for the cellphone : suppose the user is
> listening music via A2DP, then a call coming, the user can answer this
> call via HFP (press answer key in the bluetooth headset). After the
> call ending, the cellphone will continue to play music via A2DP.
>     I test several headset on Moto A1200
> (iTech/Jabra/SonyEricsson/Moto bluetooth headset). But not all the
> headset can answer the call by pressing answer key. Only the
> iTech/Jabra can pass this case.
>     My question is : does the bluez protocol support connected HFP and
> A2DP at the same time? Then how can i judge whether a headset support
> this or not? Thanks.

in theory you can, but there are certain physical limits and I don't
know of any headset that does support it. BlueZ would be just fine in
doing so.

Regards

Marcel


