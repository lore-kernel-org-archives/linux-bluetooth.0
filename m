Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: Fail to test advertisement
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <2CF57A644018A745B8FE029C7223E16E11A31EAD@SHSMSX104.ccr.corp.intel.com>
Date: Fri, 19 Jun 2015 02:51:42 +0200
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <5FC3FEC4-261B-4EA6-84A5-552824A36401@holtmann.org>
References: <2CF57A644018A745B8FE029C7223E16E11A31EAD@SHSMSX104.ccr.corp.intel.com>
To: "Zheng, Wu" <wu.zheng@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Zheng,

> I try to test the feature advertisement of bluez.
> 
> Environment: 
> The kernel is 3.19.
> The bluez is the latest git version.
> 
> The process is the following points:
> 
> Hciconfig hci0 up.
> 
> then run "Bluetooth -Edn" for testing advertisement.
> 
> I can get the log info: 
> 
> Src/advertising.c:btd_advertising_manager_new() LE Advertising Manger cretated for adapter: /org/bluez/hci0
> Failed to read advertising features: Unknown Command (0x01)
> 
> Bluez failed to create LE Advertising Manager.
> 
> And try to run "ibeacon" to check "read advertising features". It works well.
> 
> What's suggestion? Any step is wrong? Thanks.

the kernel you have it not supporting advertising in a form that is needed for LE Advertising Manager. You need at least 4.1 kernel.

And the ibeacon test tool uses HCI User Channel and thus raw access to the hardware. You are looking for the mgmt interface for advertising. Check doc/mgmt-api.txt.

Regards

Marcel

