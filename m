Return-Path: <SRS0=Oq99=5U=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69CCCC43331
	for <linux-bluetooth@archiver.kernel.org>; Sat,  4 Apr 2020 00:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37CC020737
	for <linux-bluetooth@archiver.kernel.org>; Sat,  4 Apr 2020 00:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="J1U7N2O0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbgDDAE5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Apr 2020 20:04:57 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45514 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbgDDAE5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Apr 2020 20:04:57 -0400
Received: by mail-pg1-f195.google.com with SMTP id o26so4367138pgc.12
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Apr 2020 17:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=gx2Zz31qQKSdLwjcNZC1UDAz/ogOFa1LRseoq/TcLn8=;
        b=J1U7N2O0pKRUdrpiwlpEXGv6/1RINjYsFP3YaJ0ecuz2pKUbFsx3hMlxIBEVwQtVc0
         PRhumJ02bKlN9q0e+qWDWOKAaL6MeU7XVLByFs1dYBZR+FYZENkIygHvCpLHITy81eOe
         xtGk5s1IpwGy4kngBMml4fcmtBO3rVTmvTjEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gx2Zz31qQKSdLwjcNZC1UDAz/ogOFa1LRseoq/TcLn8=;
        b=LRwi9ZRkEptRez/cqdpur0Ss7myu2i2tc/y+d4mSI21PBxz990dym+GpSgQW4DX1yD
         c7YsKSOi0uzQLHqIH/FI2hJEkEp+wln7QNIKP3Wr96cgx2PfvQk5+1W4lbhxMLpAJSHl
         Z0+7CMredlwamBzDDfWf1ER4B+6q00mrJ+T8sgqnRZMSsKPNPrS3D3gHJEBgGe3fn3ae
         zLg9A7qUVBU6wV7ByPcmor0+Q1Egd5eaxQ4ZEngU1kqVP3xc/GL9hA3GbJScKYDslRra
         dhZFVioEWJG2A+cfixMWzdd9yAqoPOHQ8OmXqmoojqt0m3xbCkH4YQ5DnYRJP4XxZ/+E
         QaPQ==
X-Gm-Message-State: AGi0PubliQRjOE/BAq5LofKPcks71W60PnLXpkj1TfWIYeDKZ92uTyoB
        hjZ0lY5PASdP+NBvZL7vFBZAIuitKyo=
X-Google-Smtp-Source: APiQypLj9oeSjVKCKgWjuLgvDChGwbxxoTvCJwZaAvaufpW+o8HLFcsqCYBtzs9qUWPgBFmZcgMGRA==
X-Received: by 2002:a63:1158:: with SMTP id 24mr10778707pgr.88.1585958696111;
        Fri, 03 Apr 2020 17:04:56 -0700 (PDT)
Received: from localhost.localdomain (c-73-231-41-185.hsd1.ca.comcast.net. [73.231.41.185])
        by smtp.googlemail.com with ESMTPSA id nl7sm6924674pjb.36.2020.04.03.17.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 17:04:55 -0700 (PDT)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sonny Sasaka <sonnysasaka@chromium.org>
Subject: [PATCH] Bluetooth: Always request for user confirmation for Just Works (LE SC)
Date:   Fri,  3 Apr 2020 17:04:39 -0700
Message-Id: <20200404000439.12219-1-sonnysasaka@chromium.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

To improve security, always give the user-space daemon a chance to
accept or reject a Just Works pairing (LE). The daemon may decide to
auto-accept based on the user's intent.

This patch is similar to the previous patch but applies for LE Secure
Connections (SC).

Signed-off-by: Sonny Sasaka <sonnysasaka@chromium.org>
---
 net/bluetooth/smp.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index d0b695ee49f6..daf03339dedd 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -2202,7 +2202,7 @@ static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (err)
 		return SMP_UNSPECIFIED;
 
-	if (smp->method == JUST_WORKS || smp->method == REQ_OOB) {
+	if (smp->method == REQ_OOB) {
 		if (hcon->out) {
 			sc_dhkey_check(smp);
 			SMP_ALLOW_CMD(smp, SMP_CMD_DHKEY_CHECK);
@@ -2210,6 +2210,18 @@ static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 		return 0;
 	}
 
+	/* If Just Works, ask user-space for confirmation. */
+	if (smp->method == JUST_WORKS) {
+		err = mgmt_user_confirm_request(hcon->hdev, &hcon->dst,
+				hcon->type, hcon->dst_type, passkey, 1);
+		if (err)
+			return SMP_UNSPECIFIED;
+
+		set_bit(SMP_FLAG_WAIT_USER, &smp->flags);
+
+		return 0;
+	}
+
 	err = smp_g2(smp->tfm_cmac, pkax, pkbx, na, nb, &passkey);
 	if (err)
 		return SMP_UNSPECIFIED;
-- 
2.17.1

