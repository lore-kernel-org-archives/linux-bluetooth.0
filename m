Return-Path: <cyrus@holtmann.org>
From: "Zheng, Wu" <wu.zheng@intel.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Fail to test advertisement
Date: Thu, 18 Jun 2015 07:23:17 +0000
Message-ID: <2CF57A644018A745B8FE029C7223E16E11A31EAD@SHSMSX104.ccr.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

I try to test the feature advertisement of bluez.

Environment: 
The kernel is 3.19.
The bluez is the latest git version.

The process is the following points:

Hciconfig hci0 up.

then run "Bluetooth -Edn" for testing advertisement.

I can get the log info: 

Src/advertising.c:btd_advertising_manager_new() LE Advertising Manger cretated for adapter: /org/bluez/hci0
Failed to read advertising features: Unknown Command (0x01)

Bluez failed to create LE Advertising Manager.

And try to run "ibeacon" to check "read advertising features". It works well.

What's suggestion? Any step is wrong? Thanks.

Best Regards
Zheng Wu
