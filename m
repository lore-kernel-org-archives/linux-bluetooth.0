Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B88C433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Nov 2022 20:54:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235990AbiK2UyR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 29 Nov 2022 15:54:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235854AbiK2UyR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 29 Nov 2022 15:54:17 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F58E15
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Nov 2022 12:54:16 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so18516046pjc.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Nov 2022 12:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=/LCWHRgU3tJt4R+wNt+EVQsyReDLXIgQMXd0+U7vGJ4=;
        b=Sb5Cu9e9fzbcQTbKE60V+pf5ie78mF3/6XadSAKBeG1fkCJRgxXOMR+hh7BBcUAz5n
         I+9s2tTbKNNa93LZIWHGBcWMk9m0sg//8MyWDhbOpJXZ7+h+FiyVcJQ5jHc7AatRVgrb
         u7teYkusR56lLX9+xbUxhT4QInD7YmTTtX6d7YZDay+fTcd5dB+KuMHF6HScZyTxq97X
         ZMEck9jWRnleXgrNP5OrxZNWJK1Q4M2b+36SXKTz/NCSx4UhMaYD/QVY+hmbPND4vhj5
         N3K3YJf9G+oLgFYKImtTPRCthZRVAd+iDTi6YAdnEH/sBWq/b8NVHAtVvUZrOxohOVJR
         X3Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/LCWHRgU3tJt4R+wNt+EVQsyReDLXIgQMXd0+U7vGJ4=;
        b=jdF8P5EnJ6kmLqtBt0jDUHf6Ljryk0UoPfW414Ef/guZ5lWPpykPADnBWpn+sM6okQ
         XGUxkdjHSATZ9/9LxpkkrAS3kbAhrilmlF7B/+aMDwZDLCbWQnmlaJ851xXMXx0Qb2sz
         Bpdkxk4KgDTSCKZLvQFk8qiY0Hpr7i3jZoqjRQG2igxuVEuazIAaZU5cBxYcJ0DZLpSg
         LVs2lxEsgoB6MRoMBeyNNPr4aNB5tAU8vLrzq3BI+uIfp0wuopEXVEoiq3czMMUJ10HX
         li4Zx10he3f5x0KImUuvKT4sQBi5btYSEp1Dh1//hnDgSM4SLb+xLjHUg+b9fpx4Uedu
         clRQ==
X-Gm-Message-State: ANoB5pkk5usKrs7jMyHiXkmLD2tg5AVp1+Iief4Rn2lxzEoMtR1040mj
        g8LbEyaYnLJyp9z6TzwzR1BrsnOFsNoafA==
X-Google-Smtp-Source: AA0mqf6KFeTRGNLN4zDFItCqqzWhkLeHPcvRX+d/pZ1EKg/WGCA6bk0xmMxPZNCPJTfDRdkidK1oTw==
X-Received: by 2002:a17:90b:2642:b0:219:55d5:f30a with SMTP id pa2-20020a17090b264200b0021955d5f30amr3673393pjb.23.1669755255089;
        Tue, 29 Nov 2022 12:54:15 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id y4-20020a634944000000b00477fb27eaddsm5595258pgk.63.2022.11.29.12.54.14
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 12:54:14 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix crash when replugging CSR fake controllers
Date:   Tue, 29 Nov 2022 12:54:13 -0800
Message-Id: <20221129205413.1537851-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

It seems fake CSR 5.0 clones can cause the suspend notifier to be
registered twice causing the following kernel panic:

[   71.986122] Call Trace:
[   71.986124]  <TASK>
[   71.986125]  blocking_notifier_chain_register+0x33/0x60
[   71.986130]  hci_register_dev+0x316/0x3d0 [bluetooth 99b5497ea3d09708fa1366c1dc03288bf3cca8da]
[   71.986154]  btusb_probe+0x979/0xd85 [btusb e1e0605a4f4c01984a4b9c8ac58c3666ae287477]
[   71.986159]  ? __pm_runtime_set_status+0x1a9/0x300
[   71.986162]  ? ktime_get_mono_fast_ns+0x3e/0x90
[   71.986167]  usb_probe_interface+0xe3/0x2b0
[   71.986171]  really_probe+0xdb/0x380
[   71.986174]  ? pm_runtime_barrier+0x54/0x90
[   71.986177]  __driver_probe_device+0x78/0x170
[   71.986180]  driver_probe_device+0x1f/0x90
[   71.986183]  __device_attach_driver+0x89/0x110
[   71.986186]  ? driver_allows_async_probing+0x70/0x70
[   71.986189]  bus_for_each_drv+0x8c/0xe0
[   71.986192]  __device_attach+0xb2/0x1e0
[   71.986195]  bus_probe_device+0x92/0xb0
[   71.986198]  device_add+0x422/0x9a0
[   71.986201]  ? sysfs_merge_group+0xd4/0x110
[   71.986205]  usb_set_configuration+0x57a/0x820
[   71.986208]  usb_generic_driver_probe+0x4f/0x70
[   71.986211]  usb_probe_device+0x3a/0x110
[   71.986213]  really_probe+0xdb/0x380
[   71.986216]  ? pm_runtime_barrier+0x54/0x90
[   71.986219]  __driver_probe_device+0x78/0x170
[   71.986221]  driver_probe_device+0x1f/0x90
[   71.986224]  __device_attach_driver+0x89/0x110
[   71.986227]  ? driver_allows_async_probing+0x70/0x70
[   71.986230]  bus_for_each_drv+0x8c/0xe0
[   71.986232]  __device_attach+0xb2/0x1e0
[   71.986235]  bus_probe_device+0x92/0xb0
[   71.986237]  device_add+0x422/0x9a0
[   71.986239]  ? _dev_info+0x7d/0x98
[   71.986242]  ? blake2s_update+0x4c/0xc0
[   71.986246]  usb_new_device.cold+0x148/0x36d
[   71.986250]  hub_event+0xa8a/0x1910
[   71.986255]  process_one_work+0x1c4/0x380
[   71.986259]  worker_thread+0x51/0x390
[   71.986262]  ? rescuer_thread+0x3b0/0x3b0
[   71.986264]  kthread+0xdb/0x110
[   71.986266]  ? kthread_complete_and_exit+0x20/0x20
[   71.986268]  ret_from_fork+0x1f/0x30
[   71.986273]  </TASK>
[   71.986274] ---[ end trace 0000000000000000 ]---
[   71.986284] btusb: probe of 2-1.6:1.0 failed with error -17

Link: https://bugzilla.kernel.org/show_bug.cgi?id=216683
Cc: stable@vger.kernel.org
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 9d9fb3dff22a..56f8569ace86 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2764,7 +2764,8 @@ int hci_register_suspend_notifier(struct hci_dev *hdev)
 {
 	int ret = 0;
 
-	if (!test_bit(HCI_QUIRK_NO_SUSPEND_NOTIFIER, &hdev->quirks)) {
+	if (!hdev->suspend_notifier.notifier_call &&
+	    !test_bit(HCI_QUIRK_NO_SUSPEND_NOTIFIER, &hdev->quirks)) {
 		hdev->suspend_notifier.notifier_call = hci_suspend_notifier;
 		ret = register_pm_notifier(&hdev->suspend_notifier);
 	}
@@ -2776,8 +2777,11 @@ int hci_unregister_suspend_notifier(struct hci_dev *hdev)
 {
 	int ret = 0;
 
-	if (!test_bit(HCI_QUIRK_NO_SUSPEND_NOTIFIER, &hdev->quirks))
+	if (hdev->suspend_notifier.notifier_call) {
 		ret = unregister_pm_notifier(&hdev->suspend_notifier);
+		if (!ret)
+			hdev->suspend_notifier.notifier_call = NULL;
+	}
 
 	return ret;
 }
-- 
2.37.3

