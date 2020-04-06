Return-Path: <SRS0=77es=5W=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD58C2BA19
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Apr 2020 11:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5D80206F8
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Apr 2020 11:49:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dso8O917"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbgDFLtR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Apr 2020 07:49:17 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:46550 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727376AbgDFLtR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Apr 2020 07:49:17 -0400
Received: by mail-pf1-f202.google.com with SMTP id f75so12805426pfa.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Apr 2020 04:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kM6p4rYstFstZmd3iLT4BlY687j2y67u06nUobmZsaI=;
        b=Dso8O917Wzmv+ly6AeOaGVHw6uEvYnR0eHS6TJg5fIP8hSSAf4S3Q++FfdGqVYjs7+
         dXy4AiSHONT9Q3qWjpd88F6x/2oPbBRdmnFMa5b7J96bh2ER6aisozqkbKHC327EAICP
         2aGqqzNmKsNMUgE8uHVXRktqEZPvrQfvZHavOXWSjPLYu0KubqIg3Qf7895fGKSuaNK0
         IYmVn94co+lPvCUp6PRlLgMUD2lkdsWwEyygbUUcWIzfenWaGfgII+Imfa9T/1R166jl
         +QUntLAcocl3ByqTO+hCZkb2Gg6QvHd9SZKgUwG0c0UbU8gGOgvtdgkpzMWyfDMVOEdV
         wugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kM6p4rYstFstZmd3iLT4BlY687j2y67u06nUobmZsaI=;
        b=dWWRnVr3F9lPNptKa2eTzBqNdiw84j8UKxRATJWBCIk8WLDnXjLmvlss5QWaxo+aBa
         VpXpOPjBm88T0qD/eFCa9PBLBr1L2yOC0biKOoSBjuhllxODFM0dC82sa4a5RamsmcvQ
         /eIgNbiGJOI/2dDa1/igA9/Ng2TpSsIPth98dN/uoxBE1uKhXjkbLF9cv1NKjKCjsdgD
         xoVIfHeRRaxgjS8ITeB+Pb5RT1wRncuKsIDLIJd/c22lXV5GTKI90TTSiAJsFadYhP9i
         VDPkCvxcoU6KMD5KE9tEXfq6tyKQ02NQmHU4LJk5vf9xoPXJzbs0ERS0ZN+TwQDDRtjU
         i2Vw==
X-Gm-Message-State: AGi0PuaKbVyoC7tGf54iKctKS51UWt/5kKY/NwRkOxgFr919dokvGtsb
        SsqJG+2X5XtgCJlciEIYSJzdSjLIRX/3QuLPacLM3JCjYDZf2JfAvo/BLS33I4T2wIc2mSL9CSs
        ibXgjvCbVMJ1dKGPP1VPwSi+kQJ7PKRH4TfmxDF87gCtY8xrMYhoWQwixShgi1H4xE/9B5oW1EM
        OU
X-Google-Smtp-Source: APiQypLR8Q+eC3eKrS6+SATscRDMW9VdjFRyCZAWXJmb7HCTccGrF2esklyo/lTmmLEDtr41JRT6jYER2rZS
X-Received: by 2002:a17:90a:5217:: with SMTP id v23mr13910594pjh.127.1586173755421;
 Mon, 06 Apr 2020 04:49:15 -0700 (PDT)
Date:   Mon,  6 Apr 2020 19:48:44 +0800
In-Reply-To: <20200406114845.255532-1-apusaka@google.com>
Message-Id: <20200406194749.Bluez.v3.2.Ieda68013af7fbafbf53fbf7c8fd85ea295153e5e@changeid>
Mime-Version: 1.0
References: <20200406114845.255532-1-apusaka@google.com>
X-Mailer: git-send-email 2.26.0.292.g33ef6b2f38-goog
Subject: [Bluez PATCH v3 2/3] unit/test-crypto: test for bt_crypto_verify_att_sign
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

Adding tests for verifying att signature

---

Changes in v3:
- Add unit test

Changes in v2: None

 unit/test-crypto.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/unit/test-crypto.c b/unit/test-crypto.c
index e20b2fa66..3bc944be8 100644
--- a/unit/test-crypto.c
+++ b/unit/test-crypto.c
@@ -272,6 +272,58 @@ static void test_gatt_hash(gconstpointer data)
 	tester_test_passed();
 }
 
+struct verify_sign_test_data {
+	const uint8_t *msg;
+	uint16_t msg_len;
+	const uint8_t *key;
+	bool match;
+};
+
+static const uint8_t msg_to_verify_pass[] = {
+	0xd2, 0x12, 0x00, 0x13, 0x37, 0x01, 0x00, 0x00, 0x00, 0xF1, 0x87, 0x1E,
+	0x93, 0x3C, 0x90, 0x0F, 0xf2
+};
+
+static const struct verify_sign_test_data verify_sign_pass_data = {
+	.msg = msg_to_verify_pass,
+	.msg_len = sizeof(msg_to_verify_pass),
+	.key = key_5,
+	.match = true,
+};
+
+static const uint8_t msg_to_verify_bad_sign[] = {
+	0xd2, 0x12, 0x00, 0x13, 0x37, 0x01, 0x00, 0x00, 0x00, 0xF1, 0x87, 0x1E,
+	0x93, 0x3C, 0x90, 0x0F, 0xf1
+};
+
+static const struct verify_sign_test_data verify_sign_bad_sign_data = {
+	.msg = msg_to_verify_bad_sign,
+	.msg_len = sizeof(msg_to_verify_bad_sign),
+	.key = key_5,
+	.match = false,
+};
+
+static const uint8_t msg_to_verify_too_short[] = {
+	0xd2, 0x12, 0x00, 0x13, 0x37
+};
+
+static const struct verify_sign_test_data verify_sign_too_short_data = {
+	.msg = msg_to_verify_bad_sign,
+	.msg_len = sizeof(msg_to_verify_bad_sign),
+	.key = key_5,
+	.match = false,
+};
+
+static void test_verify_sign(gconstpointer data)
+{
+	const struct verify_sign_test_data *d = data;
+	bool result = bt_crypto_verify_att_sign(crypto, d->key, d->msg,
+						d->msg_len);
+	g_assert(result == d->match);
+
+	tester_test_passed();
+}
+
 int main(int argc, char *argv[])
 {
 	int exit_status;
@@ -292,6 +344,13 @@ int main(int argc, char *argv[])
 
 	tester_add("/crypto/gatt_hash", NULL, NULL, test_gatt_hash, NULL);
 
+	tester_add("/crypto/verify_sign_pass", &verify_sign_pass_data,
+						NULL, test_verify_sign, NULL);
+	tester_add("/crypto/verify_sign_bad_sign", &verify_sign_bad_sign_data,
+						NULL, test_verify_sign, NULL);
+	tester_add("/crypto/verify_sign_too_short", &verify_sign_too_short_data,
+						NULL, test_verify_sign, NULL);
+
 	exit_status = tester_run();
 
 	bt_crypto_unref(crypto);
-- 
2.26.0.292.g33ef6b2f38-goog

