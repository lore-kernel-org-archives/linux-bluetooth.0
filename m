Return-Path: <cyrus@holtmann.org>
Subject: Re: Help regarding Bluez features
From: Marcel Holtmann <marcel@holtmann.org>
To: Asutosh Das <das.asutosh@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <y2gca39c8ec1004072245p3187486lcf296b97e282562c@mail.gmail.com>
References: <y2gca39c8ec1004072245p3187486lcf296b97e282562c@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 08 Apr 2010 14:47:53 +0200
Message-ID: <1270730873.6375.32.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Asutosh,

> I have tried figuring out most of it on my own, but the below
> mentioned I couldn't.
> 
> I have the following queries regarding Bluez 3.36.
> 
> Does Bluez 3.36 support:
> 
> A2DP SRC Features -
> - Initiate Connection Release (y/n) -
> - Accept Connection Release (y/n) -
> - SBC Encoder (y/n) (I guess its present not sure though) -
> - Protocol Descriptor List (y/n) -
> - Bluetooth Profile Descriptor List (y/n) -
> - Support of DM3 packet type (y/n) -
> - Support of DH3 packet type (y/n) -
> - Support of DM5 packet type (y/n) -
> - Support of DH5 packet type (y/n) -
> - Supports inquiry (y/n) -
> - Supports inquiry scan (y/n) -
> - Supports initiation of general inquiry (y/n) -
> - Supports general/limited discoverable mode (general/limited) -

sounds like you are doing qualification testing based on 3.36. You know
that this version is not really supported anymore. We have jumped to the
4.x major release. And also latest release is 4.63 already. I would
really propose you update to BlueZ 4.60 or later.

Regards

Marcel


