Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 140E4C433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Dec 2021 22:07:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383334AbhLCWKv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Dec 2021 17:10:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383318AbhLCWKu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Dec 2021 17:10:50 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F16A7C061751
        for <linux-bluetooth@vger.kernel.org>; Fri,  3 Dec 2021 14:07:25 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id gx15-20020a17090b124f00b001a695f3734aso3658776pjb.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Dec 2021 14:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/lLfEm/ZKVuJS0aITX55IpwHJw9It37eiV/mbuWOt7s=;
        b=EY/K20tru9I4Deb1qPl2UlOl8XiYcRpteGydLsMlJLmy2mKFjTl71+hquiZAcIrTfx
         lgPhrbpFU/XFTR2OozSaBzvXUktkJo358zzgMRVWIEv70quaj1E+SglZNHiITPsl5ixh
         awRDDN0xvhOLft/I7Sc5MtIw6zsSazU1UvKrtHiO2RDNvdsYLJOnZqmBIJ8vSKFfvKX7
         BBSt9v+A5pST59gs0ZnyKVr4TZxBuYTIdn+b2lke2fOpIeOoXmE2GRRadStR60qCEgXi
         dKGhCd3NQGut4Spw0h2UNvV2YDeYd9cYm8TUr1y4ut1+66xXgUemEXiOhplSXxEeq4Sz
         WDAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/lLfEm/ZKVuJS0aITX55IpwHJw9It37eiV/mbuWOt7s=;
        b=6h/+H8j73ltEYvK84YRKeOW/ShCdUH0pTrKH+Qx22EQp7ZONncHX3j9Fm1/U1ejNCy
         NH48gBDK1xt73C8gVsO6elGeJLKIDzNCtg0R/MtimNhbE7qNWuJldYm0vxHKNAjXpGNs
         QhGXfSLq/pcGb9umYBO0W+0VzTa3Ntu+BQrAxcZJiJJiw0EzbGohKw2wuiIfYoAiW62W
         pU6KxwtwbJo4rmZ2Emt6tYfJKQ97M9tLExh/on04Mutl/wEE0gBZWqilfZxvHIQyaAkA
         SnCGVIXnnFAQ0zNqw5EUI937yE13UDA97vvTDixdukTKHoRf07mIVlFlOKybc3em41+N
         KX5w==
X-Gm-Message-State: AOAM533/5Q9fXt9w4MlOu+UE2Ct2/RH+lIom6xi55LZ6lrU3oW7vAlpu
        KQTIpeTvQOTJWlERgx6mLGzu6TDlcps=
X-Google-Smtp-Source: ABdhPJyQYXF4fF5DrxMhHvU8sAJIDMg1K5MdW4wE5xkr64gMoLJoCxLXdDVi9eB6Ibhr+2GVl57yww==
X-Received: by 2002:a17:90a:d192:: with SMTP id fu18mr17417783pjb.177.1638569245046;
        Fri, 03 Dec 2021 14:07:25 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id m15sm4274389pfk.186.2021.12.03.14.07.24
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 14:07:24 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Introduce HCI_CONN_FLAG_DEVICE_PRIVACY device flag
Date:   Fri,  3 Dec 2021 14:07:22 -0800
Message-Id: <20211203220723.2302153-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This introduces HCI_CONN_FLAG_DEVICE_PRIVACY which can be used by
userspace to indicate to the controller to use Device Privacy Mode to a
specific device.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_core.h |  4 ++++
 net/bluetooth/mgmt.c             | 12 ++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index d1b67755a373..cf24af649c7f 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -154,6 +154,7 @@ struct bdaddr_list_with_irk {
 
 enum hci_conn_flags {
 	HCI_CONN_FLAG_REMOTE_WAKEUP,
+	HCI_CONN_FLAG_DEVICE_PRIVACY,
 
 	__HCI_CONN_NUM_FLAGS,
 };
@@ -1466,6 +1467,9 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 #define use_ll_privacy(dev) (ll_privacy_capable(dev) && \
 			     hci_dev_test_flag(dev, HCI_ENABLE_LL_PRIVACY))
 
+#define privacy_mode_capable(dev) (use_ll_privacy(dev) && \
+				   (hdev->commands[39] & 0x04))
+
 /* Use enhanced synchronous connection if command is supported */
 #define enhanced_sco_capable(dev) ((dev)->commands[29] & 0x08)
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 7d3c69c3cf62..17a5f972cc65 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3978,6 +3978,11 @@ static int exp_ll_privacy_feature_changed(bool enabled, struct hci_dev *hdev,
 	memcpy(ev.uuid, rpa_resolution_uuid, 16);
 	ev.flags = cpu_to_le32((enabled ? BIT(0) : 0) | BIT(1));
 
+	if (enabled && privacy_mode_capable(hdev))
+		set_bit(HCI_CONN_FLAG_DEVICE_PRIVACY, hdev->conn_flags);
+	else
+		clear_bit(HCI_CONN_FLAG_DEVICE_PRIVACY, hdev->conn_flags);
+
 	return mgmt_limited_event(MGMT_EV_EXP_FEATURE_CHANGED, hdev,
 				  &ev, sizeof(ev),
 				  HCI_MGMT_EXP_FEATURE_EVENTS, skip);
@@ -4461,6 +4466,13 @@ static int set_device_flags(struct sock *sk, struct hci_dev *hdev, void *data,
 		if (params) {
 			bitmap_from_u64(params->flags, current_flags);
 			status = MGMT_STATUS_SUCCESS;
+
+			/* Update passive scan if HCI_CONN_FLAG_DEVICE_PRIVACY
+			 * has been set.
+			 */
+			if (test_bit(HCI_CONN_FLAG_DEVICE_PRIVACY,
+				     params->flags))
+				hci_update_passive_scan(hdev);
 		} else {
 			bt_dev_warn(hdev, "No such LE device %pMR (0x%x)",
 				    &cp->addr.bdaddr,
-- 
2.33.1

