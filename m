Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Fri, 4 Sep 2009 13:42:46 -0300
Message-ID: <5d223510909040942u7ee2ae0ds96e1321b1fab24b9@mail.gmail.com>
Subject: choppy audio on ARM
From: Rafael Seste <rseste@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

A couple of months ago I sent a email about a problem with the
bluetooth audio on a ARM platform. I have a choppy audio on the
incoming stream. I still didn't solve this problem but I found a setup
that this problem doesn't happens.

My ARM device has only one USB port, so I always connect the BT dongle
in this port. Last week I bought a USB hub and plug it into the usb
and the BT dongle in the hub. Miraculously this problem disappeared. I
removed the hub and tried again and the problem returns.

Does anybody has any clue why the USB hub "fixed" this choppy audio???
Does it use a different USB drivers?

tks in advance

-- 
Rafael S. Seste
