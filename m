Return-Path: <cyrus@holtmann.org>
Message-ID: <1260906227.4b27e6f39cc7c@www.fastmail.com.br>
Date: Tue, 15 Dec 2009 17:43:47 -0200
From: dcobra@videam.com.br
To: linux-bluetooth@vger.kernel.org
Subject: Long delay to (re)connect a bluetooth mouse
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I have a bluetooth mouse that I have tried to use with a notebook running
Kubuntu Jaunty, Kubuntu Karmic, and sidux 2009-03. With all three distros it
always takes about 5 to 6 seconds for the mouse to connect (or reconnect,
coming out of sleep mode). However, if I boot the notebook under Windows XP,
the same mouse always (re)connects in under one second. Having to wait for 5-6
seconds every time I bring the mouse out of sleep mode under Linux is quite
annoying!

I have opened an Ubuntu bug and posted to the Ubuntu and sidux forums about
this, but got exactly zero replies (the Ubuntu bug was opened back in May and
nobody has even touched it!) So now I come to see if I have better luck here on
this mailing list.

Specifically, I'd like to ask: is there some bluez configuration option I can
try to speed up the mouse (re)connection, or is this 5-6 second delay the norm
under Linux?

The notebook is an Asus A8Js with a built-in bluetooth module, and the mouse is
a Targus AMB02US. In my latest attempt, under sidux, I followed the directions
found in http://www.sidux.com/index.php?module=Wikula&tag=hwBluetooth to set it
up. Please let me know if there is any additional information I should provide
about my system to help diagnose this problem.
