Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Fri, 29 May 2009 17:28:36 -0300
Message-ID: <5d223510905291328o2dfea714hb39254f00dc3822d@mail.gmail.com>
Subject: Howto enable dynamic debug
From: Rafael Seste <rseste@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

I'm trying to enable the bluetooth dynamic debug.
I compiled the kernel with the dynamic_debug enable. I mounted the debugfs:

mount -t debugfs debugfs /sys/kernel/debug

In the file /sys/kernel/debug/dynamic_debug/control there isn't any
bluetooth module (sco, bluetooth, rfcomm....). I trying to debug sco
module but nothing happens.

The command below only works if the module is in control file?
echo -n 'module sco +p' > /sys/kernel/debug/dynamic_debug/control

what am I doing wrong??
kernel 2.6.30-rc6

Where msg will be printed? syslog, message?


-- 
Rafael S. Seste
Eng Computação - Unicamp
