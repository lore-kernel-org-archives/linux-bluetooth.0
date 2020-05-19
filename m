Return-Path: <SRS0=t8jV=7B=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1543AC433E1
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 May 2020 20:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E22F920657
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 May 2020 20:25:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tPeU1nmb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbgESUZZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 May 2020 16:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgESUZY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 May 2020 16:25:24 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2CF5C08C5C0
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2020 13:25:24 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id b12so340232plz.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2020 13:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ni50vKkK680nKaSMsTHtpa2+eV2jnN40meRoXQpQfZI=;
        b=tPeU1nmb//31SZraI8KY+XD9i5EKwHdpO+h46+AScvcVJt48Ywp/fXwZHDnuF7I80k
         XUOrS8kI7qnyeNGchOxwpN5SFtyV5+f6wYzkdsmX7NZfBODdj7CizaIKog2Ux33Bbkvv
         QzLbfRqGLw6xWHLSK8m5+4nEWoifbT+f+ND3jTfidwwv1yx8Lqh053vYN2exfLspr9iY
         Ryb6ds6CsvoYkwtuMrkdsl78AOAWpaIN5WpMtm1DNlaJAeMB0kzbzq4FPT/Bl0dF22Od
         u0GEdUP/p5zzEsFelBoOwDk+NVGIIX1rC97WMrcuAqlON35pLWEE9XhwO4uUB8lelNj+
         QzKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ni50vKkK680nKaSMsTHtpa2+eV2jnN40meRoXQpQfZI=;
        b=NLBQJnUPWmPSKme+eQinyDU10lrp2O8JWlbGmO8nscfnLlz3k517IhReDVScmKYRuS
         +l4K4CLW2cn/IX4cPBgpXrd0sumpRV61IAyOYaOfhmu5HhdjRrtnv8XLuWf1BwlhsTVL
         cCmcwi2TMrLMoCH3w6uf1UCu00mN3x2e6nDJbxWfdxcilXi9TYzeoq3QEgitH6Odlvdu
         +6zQflUlWo1Lv/YrqZZ4FY5Pm9+xjngGaOoASBUitWKdG9swelTBadQho5HpLZqL7kq3
         qKYBTxlQcXXr0EpqTPy3i8ig3YA3VXjsEg1vqgNag5d2wsSJA9WCNOC2zvAyJfwUluzg
         doug==
X-Gm-Message-State: AOAM532/RLWsROIZVcoVynLxsOhhp26DC+oDBJ2saQsJg5k4VCwsMve2
        x3Rr9LeevRyDgZTIM3UpQeIBLfPW
X-Google-Smtp-Source: ABdhPJwlecuGBF/XqhjnyPpn+3dcDYOJniTefIS3+OHuBgj2dHK3FOhhTP1rfjhPlKrjAMmfaRdAFA==
X-Received: by 2002:a17:902:ab8d:: with SMTP id f13mr1264949plr.58.1589919923905;
        Tue, 19 May 2020 13:25:23 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id c184sm298808pfc.57.2020.05.19.13.25.22
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 13:25:23 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/4] Bluetooth: Fix bogus check for re-auth no supported with non-ssp
Date:   Tue, 19 May 2020 13:25:18 -0700
Message-Id: <20200519202519.219335-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.25.3
In-Reply-To: <20200519202519.219335-1-luiz.dentz@gmail.com>
References: <20200519202519.219335-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This reverts 19f8def031bfa50c579149b200bfeeb919727b27
"Bluetooth: Fix auth_complete_evt for legacy units" which seems to be
working around a bug on a broken controller rather then any limitation
imposed by the Bluetooth spec, in fact if there ws not possible to
re-auth the command shall fail not succeed.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_event.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index dc1cc3c4348c..8c9051ffa665 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2869,14 +2869,8 @@ static void hci_auth_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 	if (!ev->status) {
 		clear_bit(HCI_CONN_AUTH_FAILURE, &conn->flags);
-
-		if (!hci_conn_ssp_enabled(conn) &&
-		    test_bit(HCI_CONN_REAUTH_PEND, &conn->flags)) {
-			bt_dev_info(hdev, "re-auth of legacy device is not possible.");
-		} else {
-			set_bit(HCI_CONN_AUTH, &conn->flags);
-			conn->sec_level = conn->pending_sec_level;
-		}
+		set_bit(HCI_CONN_AUTH, &conn->flags);
+		conn->sec_level = conn->pending_sec_level;
 	} else {
 		if (ev->status == HCI_ERROR_PIN_OR_KEY_MISSING)
 			set_bit(HCI_CONN_AUTH_FAILURE, &conn->flags);
-- 
2.25.3

