Return-Path: <SRS0=ehmo=RB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA7B5C43381
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Feb 2019 12:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9781C217F9
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Feb 2019 12:56:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20150623.gappssmtp.com header.i=@codecoup-pl.20150623.gappssmtp.com header.b="krVBjOk8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbfBZM4j (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 Feb 2019 07:56:39 -0500
Received: from mail-lj1-f180.google.com ([209.85.208.180]:43627 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfBZM4j (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 Feb 2019 07:56:39 -0500
Received: by mail-lj1-f180.google.com with SMTP id z20so10640470ljj.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Feb 2019 04:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F9NiNo/WGSJXqkJo6O664Xvlb31685eGyDVD9Gl8kgY=;
        b=krVBjOk8LgP7QcTtncNItxp847egNoqS+75pNs5FxkawAELGKa8KP2lDzlNuCVaXBl
         OlzJLT0uReREG/VuNw9OKOGm9FdokBRY2FlSFDjm93hUZ1X5zR84JIH7twHGRGlCo5xZ
         et5HuS79tFkmbvdoNx4yC1Q3Jb75lEJ2cVSfKuuBNVrjpUXx8bad2167uT2tWJ6hKiqB
         jpJmri9x9AMe+MMfBKnKj9tjd86MgnlCOqfwLFrs4EpgMKXsVM9X5bWrCmPIAmsbgdV0
         TC1w7KO/krEiHvbLpFKTvFbX4TsLaR6LfmxLiDLFNzx6hPFETCWjYXcVB7qZ3nImIHRX
         GJ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F9NiNo/WGSJXqkJo6O664Xvlb31685eGyDVD9Gl8kgY=;
        b=OnFHH9PcO0QsUPrxp4qFN+MvxVfDHCq/6gxeXc6EhgCct4KGOagokeBbMgVU3EGm2n
         sVQpu6aeo609DSSSUAADXuXTXNLf1Huwg4VlrBoR/0qCcRMsiAu8iUzqFvLetqL4Dq+K
         3CVKnMZYNclKEJmVydVVOUZx8XFa++eoPGB0ZduLxZEz1nQp7FhtQBvgtOfaaCNcpDbg
         prRSz47OczCKtNXec2caiDWJCOrVvQqBeuCePJWXn8e0rfriFfrfwnGT7ssH9dEc75YP
         4EI1RQ/cPr6iFBTqGdiZwcmPCfhC1sMxUZTkw3gLx0rmmXsvEjCkc/3Jh5n8+Nq9WjCx
         4O2Q==
X-Gm-Message-State: AHQUAuanPjb/pa+o7M+V5WAVGex7tCo+fdZZ0NeqONUohcYUj736sQ8q
        8hhS1diWTfCqYzX5NTLJoqEwNykH+is=
X-Google-Smtp-Source: AHgI3Iblf+mAQqOB2gYap1T1GVn9ZlsEqccaeRPkorGWSKckwPbUr31cevUITRSu3CTUb1ZXJaC02Q==
X-Received: by 2002:a2e:425b:: with SMTP id p88mr12784778lja.78.1551185797166;
        Tue, 26 Feb 2019 04:56:37 -0800 (PST)
Received: from localhost.localdomain ([95.143.243.62])
        by smtp.gmail.com with ESMTPSA id q1sm3186771lfk.15.2019.02.26.04.56.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Feb 2019 04:56:36 -0800 (PST)
From:   Szymon Janc <szymon.janc@codecoup.pl>
To:     linux-bluetooth@vger.kernel.org
Cc:     Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH] monitor: Fix LE Set Extended Advertising Parameters TX power decoding
Date:   Tue, 26 Feb 2019 13:56:29 +0100
Message-Id: <20190226125629.30277-1-szymon.janc@codecoup.pl>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

TX power of 127 has special meaning for this command.
---
 monitor/packet.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index 96cacddd5..7f4d6b1ea 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -1115,7 +1115,7 @@ static void print_power_level(int8_t level, const char *type)
 {
 	print_field("TX power%s%s%s: %d dbm (0x%2.2x)",
 		type ? " (" : "", type ? type : "", type ? ")" : "",
-								level, level);
+							level, (uint8_t) level);
 }
 
 static void print_host_flow_control(uint8_t enable)
@@ -6944,7 +6944,10 @@ static void le_set_ext_adv_params_cmd(const void *data, uint8_t size)
 	print_peer_addr_type("Peer address type", cmd->peer_addr_type);
 	print_addr("Peer address", cmd->peer_addr, cmd->peer_addr_type);
 	print_adv_filter_policy("Filter policy", cmd->filter_policy);
-	print_power_level(cmd->tx_power, NULL);
+	if (cmd->tx_power == 0xff)
+		print_field("TX power: Host has no preference (0xff)");
+	else
+		print_power_level(cmd->tx_power, NULL);
 
 	switch (cmd->primary_phy) {
 	case 0x01:
-- 
2.20.1

