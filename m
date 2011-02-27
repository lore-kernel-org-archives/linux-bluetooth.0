Return-Path: <cyrus@holtmann.org>
Message-ID: <4D6AA78D.3030201@wp.pl>
Date: Sun, 27 Feb 2011 20:35:41 +0100
From: "W.P." <laurentp@wp.pl>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: RFCOMM not starting automatically
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,
my problem is: RFCOMM not starting automatically after upgrade to BlueZ
4.86.
If I issue manually rfcomm bind all /dev/rfcomm* is there.

As I can see there is no invocation of bluetooth in rc*.d S* scripts
only udev script.

System Fedora 8 (kernel, initscripts, glibc from 10).

What am I missing?
(of course I can add Sxxbluetooth containing rfcomm bind all to my
scripts but it looks "quick and dirty").

W.P.
