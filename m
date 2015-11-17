Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 17 Nov 2015 10:11:25 +0530
Message-ID: <CAKafyqqXugV5ceP2i=a9UEeYU1VR4yDNjqFFkQw5mv6kzraiCA@mail.gmail.com>
Subject: HoG device : Authentication Failure while connecting after reboot.
From: Prabhu Chawandi <foss.chaws@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All,

  I have a HoG device, first time I pair and connect work fine...
in the next reboot while connecting I saw multiple disconnection,
after looking into hcidump
I found that disconnection was due to authentication failure.  After
multiple attempts (which it does) one attempt will succeed to
establish the connection.

I also found that while initializing adapter stored link keys are
being deleted. is this the reason for Authentication failure ?

> HCI Event: Command Complete (0x0e) plen 14
    Read Local Extended Features (0x04|0x0004) ncmd 1
    status 0x00 page 1 max 1
    Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
< HCI Command: Delete Stored Link Key (0x03|0x0012) plen 7
    bdaddr 00:00:00:00:00:00 all 1

Please let me know your thoughts on it..

Many Thanks,
Prabhu Chawandi
