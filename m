Return-Path: <SRS0=XILz=C2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1944EC43466
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 22:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8758208C3
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 22:23:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="GsPrOGW9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbgIQWWf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Sep 2020 18:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgIQWWb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Sep 2020 18:22:31 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A25CC06174A
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2020 15:22:30 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id q131so2813866qke.22
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2020 15:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=F5sPlGRRVLln1OHpY3xzu4VxzaSsS7i3+4mGVYVmXPs=;
        b=GsPrOGW9MIc4kbFKIpt6UVGvX76M+zC0Ujv+anlq/wR4MJT8KJe8SxxNHS9su1xxgB
         CUTNyENmzO9M6XR7jyLq/7rWAnxI1lM1zmb/qoqFyZH86kr1oUF7DbQzMpI1oIxC2+Rd
         Foa6Sx7xdfThDYP1ukwt/RrhOCnyZaba/0awAFw52C/5pwSVMrUkGljwbJvnEveVOJDT
         Q4kBks1NSjEs+dOFqobEXIpV8ye1V95BuAewNdVz2Aw3P7opWSYTjRcZYsIZ6fzf8U17
         1ZBkYe8iUnhkO0leJnlwvtGvC9zlG1uKKKtRBAV7sDdQz7NEJMsKB91mzcOtwQ9+hXur
         sWHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=F5sPlGRRVLln1OHpY3xzu4VxzaSsS7i3+4mGVYVmXPs=;
        b=D3AEGdRk0JWo3Ovt1L3qd5C85vSQZyB1wmc0XRfh43y/7bQnqyhHEuGRuc8Qff0hyo
         EMxVovFF4JPM51GIRogVEpqO/dZNNqJ4zZSIvLD4p5hbbwkvDc+KZ94YjT8QCrJncunA
         PbCf89qzfaoNiW0+pMiHo/8pdhRnfdXZClGeRf3w8orVVNu7W/CE2A6NNudhJ4aafvzh
         OjaXfU+JKjFDjO3EVuW/gUltLWOkkddvHp16zPZ9RLcSIMXCB9Y8YQT1Sgcm5hTVe8Zu
         q2MhR0bskYEprUyMybc45XvJIqfrmx35QJeXbEbto+cZXEY4jqmejcEw1p7sXlBlEknG
         up4Q==
X-Gm-Message-State: AOAM531dpM5oIUgPgmZrGy1lsNQyTToEiKtMcaimrzOxrWsireVH6zm6
        o1V5YgW6tnm2cFwwv7KrLMieKONnC9N5Ul7lo8He
X-Google-Smtp-Source: ABdhPJwT7E54N7UW/26IfDYWjmdUbQmZVOUAzWq+3GViiH9dggVfK7OCbfrcvwGYeT5J98WLBWcNE+LDRxGn5fFTzLHz
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:ad4:5565:: with SMTP id
 w5mr30020818qvy.24.1600381349707; Thu, 17 Sep 2020 15:22:29 -0700 (PDT)
Date:   Thu, 17 Sep 2020 15:22:12 -0700
In-Reply-To: <20200917222217.2534502-1-danielwinkler@google.com>
Message-Id: <20200917152052.v2.1.I5f4fa6a76fe81f977f78f06b7e68ff1c76c6bddf@changeid>
Mime-Version: 1.0
References: <20200917222217.2534502-1-danielwinkler@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH v2 1/6] Bluetooth: Add helper to set adv data
From:   Daniel Winkler <danielwinkler@google.com>
To:     marcel@holtmann.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Daniel Winkler <danielwinkler@google.com>,
        Sonny Sasaka <sonnysasaka@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

Changes in v2: None

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
2.28.0.681.g6f77f65b4e-goog

