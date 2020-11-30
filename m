Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59237C64E90
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Nov 2020 22:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E637E20725
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Nov 2020 22:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IVnWNURy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388784AbgK3W65 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Nov 2020 17:58:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388780AbgK3W64 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Nov 2020 17:58:56 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC8CC061A4B
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Nov 2020 14:57:53 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id n12so9503296qta.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Nov 2020 14:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=1eLB70/LoA1JAyrb2lCBaA7M2noAwc2Ppo14iel1jO4=;
        b=IVnWNURySqY21sL04MVvJPfOk+APOINXesF2PUz/uH+sUy23zlAucl1SDd6BV2/weG
         UN/+fDqbrsj8fXrpXh18tnD9xS9bGE0+Arg0nJsAgMXTJn5sayfhJbj3t1dw7ffF9p7j
         PH7goQbaYpf6BdDKfs3gT4BCTuK9o1llE4iU5SDYZuUl9sRVhD+ERtFIfgw5F34LOvx3
         935ocqPA1zj+sebyeyMfOcb6rD08vC9Dgnm1l1izLePhliQXYxPIjKPooKqBRRre2XkM
         8QUN30kLWd854Vz3fYlrX12KDHJtUptA2zlCeoZIdiiXP0xqmgyGnYbk+rEFxBuBU1uv
         hjjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1eLB70/LoA1JAyrb2lCBaA7M2noAwc2Ppo14iel1jO4=;
        b=Sw4AThEYj0o541Vw0C4lakebVKcWIbjXXNRwoRSnmtY4e1ng43D7/vDazPQu4Cx+w6
         SIZAB/pNcj2+73gdDMEB9KkW86MjztEmRgwxRdL1VHclmcop0C9InzqOvoefH1s+Dc+Y
         9tdcK2+cB8tDVc3nTCmk60p6vPgfNC8sOZUG86l44svhLbH2XPaFb9rQ9BSJOH68pm0a
         cr1cjCzjWrc6rxporTnaZ9gqvDhDbgwg4OQ3rpvB9cP9SaJzxCpjt+W1UVf7WpmKXoZv
         9JimQsVkZsA7lBL/Lc9UJKdx3PZqCtqM65pvAsEhssLG5+CBcabUayrUh4TvUaSG2kP7
         yPCg==
X-Gm-Message-State: AOAM530z+H2d0HpkHb76TkbG8SUtm3T3F7tho5xZKDIQrRJnobIwlxr/
        aOsJB5Iz4dkRvSEH7ea3f+th64nmEgfkPYimg0jr
X-Google-Smtp-Source: ABdhPJyDckN6VCLqj9jew6vwG61BX27Ak0D5RGKwFth5yP+kFZDThAHRdgmctUeJ6hsfJMmVjmbyBXXQgywQcoimVplb
Sender: "danielwinkler via sendgmr" 
        <danielwinkler@danielwinkler-linux.mtv.corp.google.com>
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:a05:6214:5cd:: with SMTP id
 t13mr25217023qvz.56.1606777072329; Mon, 30 Nov 2020 14:57:52 -0800 (PST)
Date:   Mon, 30 Nov 2020 14:57:40 -0800
In-Reply-To: <20201130225744.3793244-1-danielwinkler@google.com>
Message-Id: <20201130145609.v6.1.I5f4fa6a76fe81f977f78f06b7e68ff1c76c6bddf@changeid>
Mime-Version: 1.0
References: <20201130225744.3793244-1-danielwinkler@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v6 1/5] Bluetooth: Add helper to set adv data
From:   Daniel Winkler <danielwinkler@google.com>
To:     marcel@holtmann.org
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
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

Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
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
index 502552d6e9aff3..35afb63514f38b 100644
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
2.29.2.454.gaff20da3a2-goog

