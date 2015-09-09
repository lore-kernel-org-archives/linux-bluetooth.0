Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: "SMP security requested but not available" when BT_6lowpan connection
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <2CF57A644018A745B8FE029C7223E16E11A91C41@SHSMSX104.ccr.corp.intel.com>
Date: Tue, 8 Sep 2015 22:58:30 -0700
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <8D7E2DC8-B9FE-45CD-A873-CC20DAE9769C@holtmann.org>
References: <2CF57A644018A745B8FE029C7223E16E11A91C41@SHSMSX104.ccr.corp.intel.com>
To: "Zheng, Wu" <wu.zheng@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Wu,

> When I use kernel 4.1.6 to test BT 6lowpan, the error of "SMP security requested but not available" is shown.
> 
> 1. I use bluetoothctl power on
> 
> 2. echo 1 > 6lowpan_enable
> 
> 3. echo "connect 00:XX:XX:XX:XX:XX:XX 1" > 6lowpan_control.
> 
> Then "SMP security requested but not available".
> 
> I test kernel 4.1.3 and BT 6lowpan works well.
> 
> Any suggestion? Thanks.

can try to boot a bluetooth-next kernel and see if the error is still present. We included a fix for the warning.

Regards

Marcel

