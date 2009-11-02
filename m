Return-Path: <cyrus@holtmann.org>
Message-ID: <4AEF6F94.4080209@zgod.cjb.net>
Date: Tue, 03 Nov 2009 00:47:32 +0100
From: Julius Schwartzenberg <julius@zgod.cjb.net>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Logitech Bluetooth mouse batteries drain quickly
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I have a rather strange problem. I bought a Logitech Bluetooth mouse 
some time ago. It works very well in Ubuntu and I never had any usage 
problems.

The strange thing is though, that the batteries that are inside the 
mouse drain extremely quickly. I compared the time it takes the mouse to 
drain a set full batteries to my flatmate's who uses the exact same 
mouse with Mac OS X. It turns out that my batteries drain about four 
times as quickly as his.

I didn't test much else. May be the problem could also be related to my 
Bluetooth "receiver" which is a Broadcom BCM2046.

I suspect however that Bluez is somehow talking with the device in such 
a way the mouse doesn't sleep as quickly as when Mac OS X talks to it. 
Could this somehow be the case? If so, what could I do to help solve 
this with Bluez?

Thanks a lot in advance,
Julius
