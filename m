Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 6 May 2016 15:29:06 +0200
Message-ID: <CAE-M4kpe3S-9Gedm_dHU+D2YMhWGbBEjm59sYB77pDjsEVkC4w@mail.gmail.com>
Subject: Bluez 5.39 Secure Connection (SC) and uncompliant devices
From: Roberto Pierpaoli <roberto@iooota.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Environment:

- linux kernel 4.2.0 i686
- Ubuntu 15.10 distribution
- Bluez 5.39 compiled from source (--enable-experimental --enable-library)

I'm trying to pair my Broadcom BCM20702A0 dongle with the BLE device
"Xiaomi MiBand".

I've figured out that the MiBand does not support the following pairing request:

> Authentication requirement: Bonding, MITM, **SC**, No Keypresses (0x0d)


The response is the following:

> > ACL Data RX: Handle 32 flags 0x02 dlen 6
>       SMP: Pairing Failed (0x05) len 1
>         Reason: Invalid parameters (0x0a)


The problem seems to reside in the "SC" requirement: I've found
someone sharing the same problem on the Chromium Project's tracking
system ==> https://bugs.chromium.org/p/chromium/issues/detail?id=522965

Is it possible to loosen the requirements in the request (expecially
"SC"), so that it won't be rejected by the MiBand device?

Thanks in advance for your support,


Roberto
