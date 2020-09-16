Return-Path: <SRS0=qc6f=CZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 386D1C433E2
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Sep 2020 20:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA6E721941
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Sep 2020 20:20:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="UH8BwLtk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbgIPUUJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Sep 2020 16:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728273AbgIPUQN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Sep 2020 16:16:13 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67FCFC06178B
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2020 13:16:12 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id 60so7063076qtf.21
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2020 13:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ouJiHCy9pxH2T5sj1WvYnJy8YM/MOUySnAX+tlwL2Gg=;
        b=UH8BwLtkHWhbvtlrnOx6o/E+DHvd5pUr9rXriuBNxKQ8cgR4HYRcjlG+1Uhz8PsJmJ
         iszKYxgls1Lm7qMJE++pD96lGlHyUh6T0EQt7h+KYlbxQNyRF/225JVRS1z1M+f2ktnv
         am1k7dS8Ju9FsCpWZDUHpgA7ZyF8ETcqT5BSEwwzq33wM3QmAAsObTZHr7aAmTnsrdX5
         ePRCv3rBzh64mrTm/pMOgQ8mi7T/yuxblGUjCdKoGi1ZXR6paZ3NSB+GlzlHa5GUrs2l
         df5UN0cmCy7Wd7NDRDmV/WikaCe3inVRL2MehUEmzlsWoAxkHQ7m7YNdNN65NsAGLy/E
         qb6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ouJiHCy9pxH2T5sj1WvYnJy8YM/MOUySnAX+tlwL2Gg=;
        b=Xk6oJDNin+aOa5Sz7gftQP/BaFEuNvmjXoNh7XmeamqAKCJfZ1IETvTab5m3naSLpc
         XG3wlGS72sOrDG1Vtd9pq2ZkAnYsEtgu+xvCdgVIijyPEhBctmDzYLRpGsN81ARr4Vzk
         K1LYDNeOrKEs9dLSQtmJrEc+XNEVxI31LYWWDXA3nVHsjKBmHTMJZwqnZhkBN2SKS9qZ
         YeSJpRjKWTo7jPpEHSIxx/e2pinga1dbLo666Q3/Fsoy+Zl42RWj7fIfwfp5zF8IZyRU
         yGmBKl7fWakxLfbQq9NhaMptMu85tf0s2OPgU1s0IrifVOa2G4g9Zn2bQJpb2qZwqmYl
         yktQ==
X-Gm-Message-State: AOAM530T1wE+lC+5axP41+D+DAbpu8R39FEDfzA+aQiDr6IMI9v4RSl4
        eLrabE8Rm3Hz8Bm0nC3di81HSzpEOsxSkSxTGm1AYmmv0d327drIVp+glXzWY8XjPqRx64Wl2W2
        RIHLUoB2CHC2BSHYFM3ZyBFQMr+RXx34ANSfo1AQbYjsR/k+1Q0D/BRtwjhiO2b+13Qdj7olVAe
        00jiXAH1J77/7BRQG1
X-Google-Smtp-Source: ABdhPJyOpQ4N29pZDC8hPDv7B7QRLfS+4nlHD81FOSX8Yz1lGNTqb8jjD+/PxRtpoZl1uLpN42r/+zYEa3sofnMw/bLj
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:ad4:57cc:: with SMTP id
 y12mr8902976qvx.48.1600287371193; Wed, 16 Sep 2020 13:16:11 -0700 (PDT)
Date:   Wed, 16 Sep 2020 13:15:57 -0700
In-Reply-To: <20200916201602.1223002-1-danielwinkler@google.com>
Message-Id: <20200916131430.1.I5f4fa6a76fe81f977f78f06b7e68ff1c76c6bddf@changeid>
Mime-Version: 1.0
References: <20200916201602.1223002-1-danielwinkler@google.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [PATCH 1/6] Bluetooth: Add helper to set adv data
From:   Daniel Winkler <danielwinkler@google.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Daniel Winkler <danielwinkler@google.com>,
        Sonny Sasaka <sonnysasaka@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

We wish to handle advertising data separately from advertising
parameters in our new MGMT requests. This change adds a helper that
allows the advertising data and scan response to be updated for an
existing advertising instance.

Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
Signed-off-by: Daniel Winkler <danielwinkler@google.com>
---

 include/net/bluetooth/hci_core.h |  3 +++
 net/bluetooth/hci_core.c         | 31 +++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 9873e1c8cd163b..300b3572d479e1 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1291,6 +1291,9 @@ int hci_add_adv_instance(struct hci_dev *hdev, u8 instance, u32 flags,
 			 u16 adv_data_len, u8 *adv_data,
 			 u16 scan_rsp_len, u8 *scan_rsp_data,
 			 u16 timeout, u16 duration);
+int hci_set_adv_instance_data(struct hci_dev *hdev, u8 instance,
+			 u16 adv_data_len, u8 *adv_data,
+			 u16 scan_rsp_len, u8 *scan_rsp_data);
 int hci_remove_adv_instance(struct hci_dev *hdev, u8 instance);
 void hci_adv_instances_set_rpa_expired(struct hci_dev *hdev, bool rpa_expired);
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 8a2645a8330137..3f73f147826409 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3005,6 +3005,37 @@ int hci_add_adv_instance(struct hci_dev *hdev, u8 instance, u32 flags,
 	return 0;
 }
 
+/* This function requires the caller holds hdev->lock */
+int hci_set_adv_instance_data(struct hci_dev *hdev, u8 instance,
+			      u16 adv_data_len, u8 *adv_data,
+			      u16 scan_rsp_len, u8 *scan_rsp_data)
+{
+	struct adv_info *adv_instance;
+
+	adv_instance = hci_find_adv_instance(hdev, instance);
+
+	/* If advertisement doesn't exist, we can't modify its data */
+	if (!adv_instance)
+		return -ENOENT;
+
+	if (adv_data_len) {
+		memset(adv_instance->adv_data, 0,
+		       sizeof(adv_instance->adv_data));
+		memcpy(adv_instance->adv_data, adv_data, adv_data_len);
+		adv_instance->adv_data_len = adv_data_len;
+	}
+
+	if (scan_rsp_len) {
+		memset(adv_instance->scan_rsp_data, 0,
+		       sizeof(adv_instance->scan_rsp_data));
+		memcpy(adv_instance->scan_rsp_data,
+		       scan_rsp_data, scan_rsp_len);
+		adv_instance->scan_rsp_len = scan_rsp_len;
+	}
+
+	return 0;
+}
+
 /* This function requires the caller holds hdev->lock */
 void hci_adv_monitors_clear(struct hci_dev *hdev)
 {
-- 
2.28.0.618.gf4bc123cb7-goog

