Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Chris Murphy <chris@colorremedies.com>
Date: Wed, 16 Aug 2017 09:26:36 -0600
Message-ID: <CAJCQCtSDo8NuRQuEa0vX2cw9jKiaDRQ0ypY5H+31pQCwWRUSbQ@mail.gmail.com>
Subject: Re: WARNING: CPU: 3 PID: 2952 at drivers/base/firmware_class.c:1225 _request_firmware+0x329/0x890
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Found this thread google searching.


4.13.0-0.rc4.git1.1.fc27.x86_64  Problem sometimes happens with this kernel.
This translates to git 623ce3456671.

4.13.0-0.rc3.git0.1.fc27.x86_64 But not this kernel, which translates
to the actual rc3 release (clean).

It seems to be a regression between those two. The problem only
happens when waking from suspend to RAM, but it doesn't always happen.


    Product Name: HP Spectre Notebook
    SKU Number: W2K28UA#ABA


dmesg, with bluetooth firmware warning and call trace only
https://drive.google.com/open?id=0B_2Asp8DGjJ9eDFsbHNMelVzelE

dmesg, normal boot
https://drive.google.com/open?id=0B_2Asp8DGjJ9X3gzYTdTNE4ydm8


-- 
Chris Murphy
