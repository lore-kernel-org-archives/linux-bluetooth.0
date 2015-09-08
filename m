Return-Path: <cyrus@holtmann.org>
From: "Zheng, Wu" <wu.zheng@intel.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: "SMP security requested but not available" when BT_6lowpan
 connection
Date: Tue, 8 Sep 2015 08:24:03 +0000
Message-ID: <2CF57A644018A745B8FE029C7223E16E11A91C41@SHSMSX104.ccr.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

When I use kernel 4.1.6 to test BT 6lowpan, the error of "SMP security requested but not available" is shown.

1. I use bluetoothctl power on

2. echo 1 > 6lowpan_enable

3. echo "connect 00:XX:XX:XX:XX:XX:XX 1" > 6lowpan_control.

Then "SMP security requested but not available".

I test kernel 4.1.3 and BT 6lowpan works well.

Any suggestion? Thanks.

Best Regards
Zheng Wu
