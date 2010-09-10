Return-Path: <cyrus@holtmann.org>
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/3] bluez: isolate btio.[ch] and do some cleanup
Date: Fri, 10 Sep 2010 10:49:41 +0800
Message-Id: <1284086984-17072-1-git-send-email-zhenhua.zhang@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Similar with previous patch threads. These patches move bluez/src/btio.[ch] out from source directory and make it identical with obex's btio.[ch]. So we can freely copy them among bluez, obex and ofono.

Best Regards,
Zhenhua

