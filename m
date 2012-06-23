Return-Path: <cyrus@holtmann.org>
From: "Zheng, Wu" <wu.zheng@intel.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: using simple-player for testing avrcp
Date: Sat, 23 Jun 2012 19:03:15 +0000
Message-ID: <2CF57A644018A745B8FE029C7223E16E0FD7924A@SHSMSX102.ccr.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I want to use simple-player for testing avrcp.

Run the following step in control device.

1.Use the "connect" method of org.bluez.AudioSource to connect target device.

2.Use simple-player to test avrcp.

The command of "playing", "paused" cannot be sent to target device.

After checking the process, the reason should be that avrcp connection did not setup.

Which test script or interfaces need be used for setup avrcp connection? Then simple-player can be used to test avrcp?

Best regards
Zheng wu
