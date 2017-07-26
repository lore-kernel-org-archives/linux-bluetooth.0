Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Alvin Lovi <alvinlovi80@gmail.com>
Date: Wed, 26 Jul 2017 10:32:10 +0200
Message-ID: <CANdxJyqO3mPKdsL4iy2JNq8111Ags+9Af-S0Vi+X+1AEdUextQ@mail.gmail.com>
Subject: Bluez 5.43 - Problems with btmgmt
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi, I'm trying to use the btmgmt command line tool integrated in the
above Bluez version and i've found the following problems/doubts:

1. btmgmt pair -c  [cap] -t [type] <rem addr.>
The tool automatically sends Passkey or PIN negative reply without
waiting any user input

2. btmgmt pair -c 0x04 -t 0x00 <rem addr.>
The sniffed pcap gives "IO Capability: Display Yes/NO (0x01)"

3. I've found the "disconnect" command but i haven't found the
"connect" one: is it present or not?

Thanks
