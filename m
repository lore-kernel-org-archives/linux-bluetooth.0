Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C68DC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Nov 2021 09:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F1B6611C9
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Nov 2021 09:03:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbhKCJFl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Nov 2021 05:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbhKCJFk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Nov 2021 05:05:40 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EAB3C061714
        for <linux-bluetooth@vger.kernel.org>; Wed,  3 Nov 2021 02:03:04 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id h185-20020a256cc2000000b005bdce4db0easo3131178ybc.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Nov 2021 02:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=bIe43DMC+hVNx274dZvwV5NiQPHCOMhtMi2x8daakaQ=;
        b=AVcdizCpSpMltW+Xut7W/8Irq/gOAvqCgt0LOINzK9fS2/lSmreNX1MjyvVnspq18E
         U2FSkApiD5zgsNjfBAPKaElaM1uW4/cKKn1bYEaMnEe7IkVXiL1YhxVZjO+YVNjz152T
         dsYk32ZlDHsbGiHvbBw10lpEy+eIFnlYGqRonE4HBIATYof+axhfpBK82C9xTZYkYfiC
         eGedDsA3Z/jiXuaNwsZfXB6zjAVr7EUn5U2160kaLtakAXbTX+lK3p6yhE1CVUeHLAI+
         /ramtb0M1viDtCChJoZJWUy+RXtIQS7olK/I3RBIvXMonujG3R9cR1hwXeKtjrqjNp3G
         mpyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=bIe43DMC+hVNx274dZvwV5NiQPHCOMhtMi2x8daakaQ=;
        b=feQJfGYcgAAeI46PBTcUHT0jfbPScMGYLyx+eO5ivzFhTdesc43xCWDmHCs+dWMoNF
         6BuqBNeDg6GcQ+pambxFBaxqluHDAXXZPlL6oGmcnFFBPsH/bBlC/NP+Q6E+jMdlCUDZ
         WRxbCUbKtR+O6YQiOHBp8+7VMyCPOKLtokb7CZWzkzedPWCrBsPbRZzdU/ClTXU0Jj3Z
         oa+TEUshbQQwdUhWvZG/X916b4qRihaKKO2nvXfN7tKXiPQvZg7J4/c/aRpcxC+4f/7N
         tf+cLh0Fl3T2QurFimxjeG44xGldYnQ1mUD0ek9xuM183WjAeFu1mwLHC8KUTQynRI1B
         DGcg==
X-Gm-Message-State: AOAM532cEXtIG+aFG3tGpXzN3JqegvaznBuYsUWyg0RUgCKFuG/VUC7s
        z74qwD2LFF/zVj+6lUXxmxAjsl+GQdw7RQlkQTsZ6Sk6f6KDtpcMpLSCIIEVSQZVLuLzwx4KPzj
        IuKcc7XWFsT+cDRVTbj8QaA8Dx/4yq50GTP6YxCFnbBI1Rjqx54sr7mHBLnhDg+io0bSeqoVBak
        6b
X-Google-Smtp-Source: ABdhPJx8gsKPIhWShNSrImJpq4Bf/u4PHiLnczpAtBssuvzQDAAblcynhdtNXz7/03LvAfNEGKZ9Qv3k1FGO
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:7af7:a937:5810:b542])
 (user=apusaka job=sendgmr) by 2002:a25:b9cd:: with SMTP id
 y13mr7266461ybj.407.1635930183482; Wed, 03 Nov 2021 02:03:03 -0700 (PDT)
Date:   Wed,  3 Nov 2021 17:02:53 +0800
Message-Id: <20211103170206.Bluez.v2.1.I515833d2764b8ec2ac2bb1f87313de80ebb497cd@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
Subject: [Bluez PATCH v2 1/3] adapter: Use PeripheralLongTermKey to store LTK
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

Introducing PeripheralLongTermKey group for storing LTK info to
replace the less inclusive term. Currently we still need to write/read
from both to ensure smooth transition, but later we should deprecate
the old term.

Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
---

Changes in v2:
- Add reason to keep duplicates as comment

 src/adapter.c | 47 ++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 38 insertions(+), 9 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index d0d38621b8..114ae84c10 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3868,7 +3868,14 @@ static struct smp_ltk_info *get_peripheral_ltk_info(GKeyFile *key_file,
 
 	DBG("%s", peer);
 
-	ltk = get_ltk(key_file, peer, bdaddr_type, "SlaveLongTermKey");
+	/* Peripheral* is the proper term, but for now read both entries
+	 * so it won't break when user up/downgrades. Remove the other
+	 * term after a few releases.
+	 */
+	ltk = get_ltk(key_file, peer, bdaddr_type, "PeripheralLongTermKey");
+	if (!ltk)
+		ltk = get_ltk(key_file, peer, bdaddr_type, "SlaveLongTermKey");
+
 	if (ltk)
 		ltk->central = false;
 
@@ -8415,13 +8422,12 @@ static void new_link_key_callback(uint16_t index, uint16_t length,
 	bonding_complete(adapter, &addr->bdaddr, addr->type, 0);
 }
 
-static void store_longtermkey(struct btd_adapter *adapter, const bdaddr_t *peer,
+static void store_ltk_group(struct btd_adapter *adapter, const bdaddr_t *peer,
 				uint8_t bdaddr_type, const unsigned char *key,
-				uint8_t central, uint8_t authenticated,
+				const char *group, uint8_t authenticated,
 				uint8_t enc_size, uint16_t ediv,
 				uint64_t rand)
 {
-	const char *group = central ? "LongTermKey" : "SlaveLongTermKey";
 	char device_addr[18];
 	char filename[PATH_MAX];
 	GKeyFile *key_file;
@@ -8431,11 +8437,6 @@ static void store_longtermkey(struct btd_adapter *adapter, const bdaddr_t *peer,
 	char *str;
 	int i;
 
-	if (central != 0x00 && central != 0x01) {
-		error("Unsupported LTK type %u", central);
-		return;
-	}
-
 	ba2str(peer, device_addr);
 
 	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/info",
@@ -8475,6 +8476,34 @@ static void store_longtermkey(struct btd_adapter *adapter, const bdaddr_t *peer,
 	g_key_file_free(key_file);
 }
 
+static void store_longtermkey(struct btd_adapter *adapter, const bdaddr_t *peer,
+				uint8_t bdaddr_type, const unsigned char *key,
+				uint8_t central, uint8_t authenticated,
+				uint8_t enc_size, uint16_t ediv,
+				uint64_t rand)
+{
+	if (central != 0x00 && central != 0x01) {
+		error("Unsupported LTK type %u", central);
+		return;
+	}
+
+	if (central) {
+		store_ltk_group(adapter, peer, bdaddr_type, key, "LongTermKey",
+				authenticated, enc_size, ediv, rand);
+	} else {
+		/* Peripheral* is the proper term, but for now keep duplicates
+		 * so it won't break when user up/downgrades. Remove the other
+		 * term after a few releases.
+		 */
+		store_ltk_group(adapter, peer, bdaddr_type, key,
+				"PeripheralLongTermKey", authenticated,
+				enc_size, ediv, rand);
+		store_ltk_group(adapter, peer, bdaddr_type, key,
+				"SlaveLongTermKey", authenticated,
+				enc_size, ediv, rand);
+	}
+}
+
 static void new_long_term_key_callback(uint16_t index, uint16_t length,
 					const void *param, void *user_data)
 {
-- 
2.33.1.1089.g2158813163f-goog

