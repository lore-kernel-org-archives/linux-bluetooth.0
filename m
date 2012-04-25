Return-Path: <cyrus@holtmann.org>
Date: Wed, 25 Apr 2012 16:48:52 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: coekbe <coekbe@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Bug report: bluetoothd broken for a USB dongle since bluez 4.85
Message-ID: <20120425194852.GB2781@joana>
References: <CAK678xgXnf-bgBRGU+tyNdnUv4VoGM+XyH15W0jw8h3Wypi+_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAK678xgXnf-bgBRGU+tyNdnUv4VoGM+XyH15W0jw8h3Wypi+_A@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi coekbe,

* coekbe <coekbe@gmail.com> [2012-04-25 10:06:18 +0300]:

> Hi linux-bluetooth,
> 
> I have a Prodige bluetooth USB dongle that does not work with bluez
> starting with version 4.85. Specifically, the command "hcitool scan"
> does not find any bluetooth devices (my phone). Version 4.84 is good,
> though. Git bisecting found the culprit:
> 
> ----------------
> commit 5b1a2a39dc7710f5a58e4f676389fea06764800b
> Author: Johan Hedberg <johan.hedberg@nokia.com>
> Date:   Tue Jan 11 00:16:33 2011 +0200
> 
>     Fix event mask setting for 1.1 controllers
> 
>     Controllers based on the core spec 1.1 support the event mask HCI
>     command but need a very stripped down default value for the mask. This
>     patch makes sure the command gets issued for 1.1 controllers with the
>     appropriate value.
> 
> --------------------

Can you also send the output of hciconfig -a?

	Gustavo
