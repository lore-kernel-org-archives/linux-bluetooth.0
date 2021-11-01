Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBDD4C43217
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Nov 2021 06:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8B6461101
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Nov 2021 06:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbhKAGKJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Nov 2021 02:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbhKAGKB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Nov 2021 02:10:01 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2059C061A0E
        for <linux-bluetooth@vger.kernel.org>; Sun, 31 Oct 2021 23:06:34 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id z2-20020a254c02000000b005b68ef4fe24so24612213yba.11
        for <linux-bluetooth@vger.kernel.org>; Sun, 31 Oct 2021 23:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Zoa2fAXM28rUtlN/ISSvLdAbfkRTXQYLDwy+ZQkaVpU=;
        b=JanpAjZ54bDdYnwxbmStfu/fWjIk9VlZip/2ICVrA5Fu4NYCpGT9xjQEXL8X01ZcqC
         KywLcBzUYB9JWZH7ehuY07ydf93/K1Vi9BSefOdID86G5r7bZiv6VMffCIo69EqWpwFD
         fB99JfRqdQEL8R5L9jXjmR++ZBtfolLf6iP2hEvdW/YDBd25QetwWMP8HcHzAx2Au5Md
         GyEaKwNALvHi6+/yfKtbMBNwfeibcnPqyYG0WJfkFzNB83kgj60QR9gvzAfEIz0Q6h0c
         tCxKZwQtyO0shYWgeYU0q1l5orRGFu3mHBIimnsgaH1J3TNL4qGB6bYZetZjPIf6sAsb
         pXcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Zoa2fAXM28rUtlN/ISSvLdAbfkRTXQYLDwy+ZQkaVpU=;
        b=KTk8dypuqfQc+I+pkelSADUrl7K95QQCJ0O9ZR/gUh7mBp8D9k3yBno1U3Wcj2dK/P
         pBg5b/in92bflqqCg0rxQbQvWEkiUXb0r46jndw+C+FyMNL2gTRRvR6VuC7Aq1Sn70nB
         qEH7KBqK4gV9atkbIkC1bIOGjpv1lrOH3Wakowo4szPEArHLHIT1FTlnNddxUlfc9Oqw
         CYfKg7x3w3zAbNrVlN7Qwu/c11diDfJIDyFBj+bFZ78PhFB1NttSaKSSSeghsuF8vd3B
         5jrU9AsZ7hOEbu1JxUyJ/cfVQRJcF1s69kwleoPp2hL7UTHXQSTiXGU3Sj5C+D4mH5kN
         ZGow==
X-Gm-Message-State: AOAM531Z2VvLwkWq1jJIqoLIVFaf6Sk3sPkgELEzJWC8rqIMk2JHIW6o
        GvpbA1Hmz7kDDOrRmO1MpYNLkZwQAJLePLPX4XpPltlaaEvLsqFSFROOypd+sroN6NW7AdA5agV
        qoLxdXuQweHroaG9qTfN27faCwFpwDaoLv78nFBBdQvtwUlppkM8PKvvsMl4tolN5ELzp70s/V6
        09
X-Google-Smtp-Source: ABdhPJxuiv1u5QlziHNRW3ip4TMax+nO8Xlwh8Irov/00oSHRChEwcLF/NNDApft/rVdq3g/bBjsMJUAxv9J
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:93ab:332e:48e3:1733])
 (user=apusaka job=sendgmr) by 2002:a25:6152:: with SMTP id
 v79mr28722879ybb.400.1635746793861; Sun, 31 Oct 2021 23:06:33 -0700 (PDT)
Date:   Mon,  1 Nov 2021 14:06:24 +0800
Message-Id: <20211101140544.Bluez.1.I515833d2764b8ec2ac2bb1f87313de80ebb497cd@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
Subject: [Bluez PATCH 1/3] adapter: Use PeripheralLongTermKey to store LTK
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

 src/adapter.c | 41 ++++++++++++++++++++++++++++++++---------
 1 file changed, 32 insertions(+), 9 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index d0d38621b8..6b12c9e793 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3868,7 +3868,11 @@ static struct smp_ltk_info *get_peripheral_ltk_info(GKeyFile *key_file,
 
 	DBG("%s", peer);
 
-	ltk = get_ltk(key_file, peer, bdaddr_type, "SlaveLongTermKey");
+	/* Read from both entries. Later we should deprecate Slave. */
+	ltk = get_ltk(key_file, peer, bdaddr_type, "PeripheralLongTermKey");
+	if (!ltk)
+		ltk = get_ltk(key_file, peer, bdaddr_type, "SlaveLongTermKey");
+
 	if (ltk)
 		ltk->central = false;
 
@@ -8415,13 +8419,12 @@ static void new_link_key_callback(uint16_t index, uint16_t length,
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
@@ -8431,11 +8434,6 @@ static void store_longtermkey(struct btd_adapter *adapter, const bdaddr_t *peer,
 	char *str;
 	int i;
 
-	if (central != 0x00 && central != 0x01) {
-		error("Unsupported LTK type %u", central);
-		return;
-	}
-
 	ba2str(peer, device_addr);
 
 	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/info",
@@ -8475,6 +8473,31 @@ static void store_longtermkey(struct btd_adapter *adapter, const bdaddr_t *peer,
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
+		/* Store duplicates for now. Later we should deprecate Slave. */
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

