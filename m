Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Fri, 25 Sep 2015 11:45:39 +0100
Message-ID: <CA+V-a8v1DaXL=S850KWaBt-ykDGr_533y8bAkpKq+NMoiVRncA@mail.gmail.com>
Subject: rfcomm sockets
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I am using 5.34 bluez-5 stack on linux kernel version 3.14. when I
create rfcomm connection and do cat /dev/rfcomm0 and from other
terminal send AT commands to rfcomm0 I get proper response and other
characters continuously(> ??? ...) echoed from rfcomm0.
If I do the same from bluez4-101 I get proper response with no other characters.

What is the proper way to do rfcomm communication ? I am trying to
connect to a OBD device via rfcom socket.


Cheers,
--Prabhakar Lad
