Return-Path: <cyrus@holtmann.org>
Message-ID: <453936.71245.qm@web52604.mail.re2.yahoo.com>
Date: Tue, 8 Dec 2009 14:15:20 -0800 (PST)
From: Ed Tsang <netdesign_98@yahoo.com>
Subject: How to force a fix pin
To: Bluettooth Linux <linux-bluetooth@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi, My application scan for devices, send file to it. But some device (blackberry) will request a pin. With the bluetoothd 4.51. bluetooth-applet will pop up and enter a pin. If de-install it, the bluetoothd will complain "No agent available for 0 request (pin_code_request?).". And the remote device failed to pair with a "default pin 0000".
Is there a way to force a default pin "0000".  look like /etc/bluetooth/pin is history.  Is there a simply work around.

Net Des



      __________________________________________________________________
Get a sneak peak at messages with a handy reading pane with All new Yahoo! Mail: http://ca.promos.yahoo.com/newmail/overview2/
