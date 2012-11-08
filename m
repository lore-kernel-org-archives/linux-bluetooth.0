Return-Path: <cyrus@holtmann.org>
From: "Zheng, Wu" <wu.zheng@intel.com>
To: "Von Dentz, Luiz" <luiz.von.dentz@intel.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: HFP can't work well and sound can't be heard
Date: Thu, 8 Nov 2012 09:41:26 +0000
Message-ID: <2CF57A644018A745B8FE029C7223E16E0FE3E843@SHSMSX102.ccr.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

The GetProperties methods of "org.bluez.manager", "org.bluez.Adapter" and so on have been converted to some methods of "org.freedesktop.DBus.Properties".

It results in pulseaudio can't communicate with bluez well and sound can't be heard when using HFP.

What do upstream plan for it? Thanks.

Best Regards
Zheng Wu
