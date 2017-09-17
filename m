Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Laczen JMS <laczenjms@gmail.com>
Date: Sun, 17 Sep 2017 17:41:58 +0200
Message-ID: <CAFxSrVsZcJxkgAFL8yoSK9buoSzFJryNT18mGSRUUq17VPdOEg@mail.gmail.com>
Subject: meshctl fails on rpi 3
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

After downloading and compiling bluez 5.47 on raspberry pi 3 (raspbian
2017-09-07), it is not possible to run meshctl on the raspberry pi.
Meshctl fails at loading the prov_db.

After some further testing I have found that the loading fails in the
crypto functions at binding the AF_ALG in line 178 of crypto.c. Has
this something to do with cryptographic modules being unavailable on
the rpi 3?

If so, what crypto module is required and what is the best way to add
these modules ?

Kind regards,

Jehudi
