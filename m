Return-Path: <cyrus@holtmann.org>
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: bluez: isolate btio.[ch] as a library and do cleanup
Date: Thu,  9 Sep 2010 17:43:04 +0800
Message-Id: <1284025388-3831-1-git-send-email-zhenhua.zhang@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

These patches move bluez/src/btio.[ch] out from source directory and make it identical with obex's btio.[ch]. So we can freely copy them among bluez, obex and ofono.

Regards,
Zhenhua

