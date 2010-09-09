Return-Path: <cyrus@holtmann.org>
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: obex: isolate btio.[ch] as a library and do some cleanup
Date: Thu,  9 Sep 2010 17:41:19 +0800
Message-Id: <1284025283-3773-1-git-send-email-zhenhua.zhang@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

These patches move obexd/src/btio.[ch] out from source directory and make it identical with bluez's btio.[ch]. So we can freely copy them among bluez, obex and ofono.

Regards,
Zhenhua

