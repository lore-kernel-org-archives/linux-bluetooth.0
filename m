Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97718C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Nov 2021 11:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B70F611AD
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Nov 2021 11:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233202AbhKKL5F (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 11 Nov 2021 06:57:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233213AbhKKL5D (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 11 Nov 2021 06:57:03 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D66C06127A
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Nov 2021 03:54:14 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id d9-20020a251d09000000b005c208092922so8916645ybd.20
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Nov 2021 03:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jmP+ym/LNDBSoNGjkA1WbJQp3PL8dM66JjCqrEvWUO4=;
        b=EReAqt3wWCshtfpjrVqkeOUzoUlSUMZ+WirKASttCbc31hhh7FM9kGHf9kxHQhuQkV
         YDIgswGFGMl931UjVBr3ybbHSU7RV7KfnTIEgKcuEuDSmCU+C3ogFRCIuEhe1u0kX2Yy
         4Hq69kQKV6aJlwvzXl7CgoAyCqVr1vagFZKpuHVDpJhDhfOfEpsxTM5kiWCjeSNS1Kf4
         wsr+snkF95KdCVXyQcsYzp4Abs2Yqd+MS4/ni6wr6tHKH70EVNfQSgSWNPbL6G3WaIIL
         q1896XJsPNojHt+DRvo3Nm2HRySj+uwYFzaQp5Dos07gkxMLTQmeQ4+Udsn/I5toLT8Z
         lyRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jmP+ym/LNDBSoNGjkA1WbJQp3PL8dM66JjCqrEvWUO4=;
        b=KKz133DV3oIVglQcTFWq66yJNR81YKULp9ymklZVYPZ7n6Vt3ZDUn7VoLLnzYCedAg
         FgcMnJ5I/XHed4++k1XOf/EWV2WGj0F0nZgWDaGQ9uNdqkOb/HD/ZpVBTSgSDNq89208
         FraipMF6PHuadAW0u9UAUYZhj4S3ctCmd3iq5hR0sYNR/qye3gxgiGfA76SjvrT+t+8Z
         31XwK+hjgkNwaW7wzFamdhWctssv6ceqXTzd/U9xj6zoT49juvv1h5qWMQNsJUSB7kpG
         dlaWDziTM1Xmu4ma37PBtfmzISbJ5c2MpSzxTgn1OEU2p8emCwsNscWzgNj0qMlJ90WF
         EHgQ==
X-Gm-Message-State: AOAM5335rttdgtDvSQITMSF5U5Jf7PeGZ0MZSVvHUtQEaAAt81bcHtSW
        Aww+VEVstS1k27zbDw3f6O4FqZEpocv63iyvGXyXqGMRs9cGRDYtC2wNjVY+Uz9xQrm87aX5Vnr
        MyXd+y5GGfo3+p81339CU2SaTz/kTr1o0tYXxUd3MLmb/U2ttpX74hgZ2YimWzaajYY3ytb72d6
        qF
X-Google-Smtp-Source: ABdhPJyve7pqoR9nIze4bse7v5R2P8N8xr58adtTxqsoI8t7P2Q91OPdlzKWlpjE0YvsLOIS0O+XebV/fh3m
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:b87e:3eb:e17e:1273])
 (user=apusaka job=sendgmr) by 2002:a25:d6c2:: with SMTP id
 n185mr7025157ybg.319.1636631653894; Thu, 11 Nov 2021 03:54:13 -0800 (PST)
Date:   Thu, 11 Nov 2021 19:53:51 +0800
In-Reply-To: <20211111195320.1.Id7366eb14b6f48173fcbf17846ace59479179c7c@changeid>
Message-Id: <20211111195320.2.I8f792722c41f0841a0eba7a6782ce80d61b20a14@changeid>
Mime-Version: 1.0
References: <20211111195320.1.Id7366eb14b6f48173fcbf17846ace59479179c7c@changeid>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH 2/3] Bluetooth: Add "DONT_CARE" to remote name inquiry
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

With this patch, the user space can specify DONT_CARE when sending
confirm_name MGMT command. The kernel then will not attempt to perform
remote name request. In practice, we will treat them the same as if
the user space specified NAME_KNOWN instead.

Signed-off-by: Archie Pusaka <apusaka@chromium.org>
Reviewed-by: Miao-chen Chou <mcchou@chromium.org>

---

 include/net/bluetooth/hci_core.h | 1 +
 include/net/bluetooth/mgmt.h     | 6 +++++-
 net/bluetooth/hci_core.c         | 1 +
 net/bluetooth/mgmt.c             | 5 ++++-
 4 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index b5f061882c10..eb08dd502f2a 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -56,6 +56,7 @@ struct inquiry_entry {
 		NAME_NEEDED,
 		NAME_PENDING,
 		NAME_KNOWN,
+		NAME_DONT_CARE,		/* Don't know but don't want to know */
 	} name_state;
 	__u32			timestamp;
 	struct inquiry_data	data;
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 113438f295bf..30d0415c29c9 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -352,10 +352,14 @@ struct mgmt_cp_stop_discovery {
 } __packed;
 #define MGMT_STOP_DISCOVERY_SIZE	1
 
+#define MGMT_CONFIRM_NAME_UNKNOWN	0
+#define MGMT_CONFIRM_NAME_KNOWN		1
+#define MGMT_CONFIRM_NAME_DONT_CARE	2
+
 #define MGMT_OP_CONFIRM_NAME		0x0025
 struct mgmt_cp_confirm_name {
 	struct mgmt_addr_info addr;
-	__u8	name_known;
+	__u8	name_state;
 } __packed;
 #define MGMT_CONFIRM_NAME_SIZE		(MGMT_ADDR_INFO_SIZE + 1)
 struct mgmt_rp_confirm_name {
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index fdc0dcf8ee36..90064dbbba5f 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -304,6 +304,7 @@ u32 hci_inquiry_cache_update(struct hci_dev *hdev, struct inquiry_data *data,
 
 update:
 	if (name_known && ie->name_state != NAME_KNOWN &&
+	    ie->name_state != NAME_DONT_CARE &&
 	    ie->name_state != NAME_PENDING) {
 		ie->name_state = NAME_KNOWN;
 		list_del(&ie->list);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index c1d6fbc19207..e887de6f411e 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -5531,9 +5531,12 @@ static int confirm_name(struct sock *sk, struct hci_dev *hdev, void *data,
 		goto failed;
 	}
 
-	if (cp->name_known) {
+	if (cp->name_state == MGMT_CONFIRM_NAME_KNOWN) {
 		e->name_state = NAME_KNOWN;
 		list_del(&e->list);
+	} else if (cp->name_state == MGMT_CONFIRM_NAME_DONT_CARE) {
+		e->name_state = NAME_DONT_CARE;
+		list_del(&e->list);
 	} else {
 		e->name_state = NAME_NEEDED;
 		hci_inquiry_cache_update_resolve(hdev, e);
-- 
2.34.0.rc0.344.g81b53c2807-goog

