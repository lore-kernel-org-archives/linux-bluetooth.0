Return-Path: <cyrus@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: Polling in rfcomm listen
From: Dominic =?iso-8859-1?q?Sacr=E9?= <dominic.sacre@gmx.de>
Date: Wed, 17 Jun 2009 15:28:31 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200906171528.31651.dominic.sacre@gmx.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I'm trying to use "rfcomm listen" (or "rfcomm watch") to run a command as 
soon as a client connects. The problem is that after starting the command, 
rfcomm enters a loop which continually calls ppoll() with a timeout of 200 
nanoseconds. This causes a very high CPU load, and also a chirping noise on 
my laptop, presumably from ther CPU entering a power save mode, and 
immediately being woken up again.

Is there any reason to use such an extremely short timeout? I tried 
replacing the timeout with 2 milliseconds (that's 10000 times the original 
value...), and rfcomm works much better now. Probably even higher values 
would work.

Another issue is that occasionally, the command started by rfcomm fails to 
open /dev/rfcomm0. Apparently rfcomm starts the command before the device is 
properly created and its permissions set?


Regards,

Dominic
