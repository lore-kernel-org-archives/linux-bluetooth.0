Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00AECC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Oct 2021 08:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4BB760D43
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Oct 2021 08:41:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234135AbhJMIn3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Oct 2021 04:43:29 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:14343 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235764AbhJMIn2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Oct 2021 04:43:28 -0400
Received: from dggeml709-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HTm8y50qlz900t;
        Wed, 13 Oct 2021 16:36:34 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggeml709-chm.china.huawei.com (10.3.17.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Wed, 13 Oct 2021 16:41:24 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     <linux-bluetooth@vger.kernel.org>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH v2] Bluetooth: Fix memory leak of hci device
Date:   Wed, 13 Oct 2021 16:55:01 +0800
Message-ID: <20211013085501.101286-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggeml709-chm.china.huawei.com (10.3.17.139)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Fault injection test reported memory leak of hci device as follows:

unreferenced object 0xffff88800b858000 (size 8192):
  comm "kworker/0:2", pid 167, jiffies 4294955747 (age 557.148s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 ad 4e ad de  .............N..
  backtrace:
    [<0000000070eb1059>] kmem_cache_alloc_trace mm/slub.c:3208
    [<00000000015eb521>] hci_alloc_dev_priv include/linux/slab.h:591
    [<00000000dcfc1e21>] bpa10x_probe include/net/bluetooth/hci_core.h:1240
    [<000000005d3028c7>] usb_probe_interface drivers/usb/core/driver.c:397
    [<00000000cbac9243>] really_probe drivers/base/dd.c:517
    [<0000000024cab3f0>] __driver_probe_device drivers/base/dd.c:751
    [<00000000202135cb>] driver_probe_device drivers/base/dd.c:782
    [<000000000761f2bc>] __device_attach_driver drivers/base/dd.c:899
    [<00000000f7d63134>] bus_for_each_drv drivers/base/bus.c:427
    [<00000000c9551f0b>] __device_attach drivers/base/dd.c:971
    [<000000007f79bd16>] bus_probe_device drivers/base/bus.c:487
    [<000000007bb8b95a>] device_add drivers/base/core.c:3364
    [<000000009564d9ea>] usb_set_configuration drivers/usb/core/message.c:2171
    [<00000000e4657087>] usb_generic_driver_probe drivers/usb/core/generic.c:239
    [<0000000071ede518>] usb_probe_device drivers/usb/core/driver.c:294
    [<00000000cbac9243>] really_probe drivers/base/dd.c:517

hci_alloc_dev() do not init the device's flag. And hci_free_dev()
using put_device() to free the memory allocated for this device,
but it calls just put_device(dev) only in case of HCI_UNREGISTER
flag is set, So any error handing before hci_register_dev() success
will cause memory leak.

To avoid this behaviour we can using kfree() to release dev before
hci_register_dev() success.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index 7827639ecf5c..4e3e0451b08c 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -86,6 +86,8 @@ static void bt_host_release(struct device *dev)
 
 	if (hci_dev_test_flag(hdev, HCI_UNREGISTER))
 		hci_release_dev(hdev);
+	else
+		kfree(hdev);
 	module_put(THIS_MODULE);
 }
 
-- 
2.25.1

