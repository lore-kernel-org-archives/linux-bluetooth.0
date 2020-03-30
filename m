Return-Path: <SRS0=mSPA=5P=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EDB2C43331
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Mar 2020 07:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E4F420776
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Mar 2020 07:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YT2dd8fC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729372AbgC3HBo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Mar 2020 03:01:44 -0400
Received: from mail-pj1-f74.google.com ([209.85.216.74]:50337 "EHLO
        mail-pj1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728489AbgC3HBo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Mar 2020 03:01:44 -0400
Received: by mail-pj1-f74.google.com with SMTP id e8so14032697pjd.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Mar 2020 00:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ke886rB8QIOU962vQZEnZSoXxgI8l/NeMYgG8IAiLgw=;
        b=YT2dd8fCaRPhOcu/ec2vGFYtQ8kAGGK5cPUPuj9a5tRQY16Bk0L/5IAB2J3We65oVd
         U+t8abkHNQRDMgV6gWnsNr/fGYzKu6E/2hDvF3zB88FUh0b8PN5BRdX/ugtpAPDqnjZd
         oroi0dhXJ08jSpMgZDzfq7Om2YenuXvEV4E2fClSWkFNrc0YEnxQJuNTcia8M4FqBBoA
         b4OhqRn6a5ondqOh3eQM1jizxcepvnm2xiM15f6ovRNLNkKiN5zv2fGPjgHH7++XiAel
         fFtXxVl0lB3QM6wxQEswBEUUDI/emKH7R5/JMmC/lxDvuv0Hb0fHLcwqwHaEJP/KnSlN
         4RbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ke886rB8QIOU962vQZEnZSoXxgI8l/NeMYgG8IAiLgw=;
        b=UR/1EkAf32nAjvARvrTbk9b6qPUsfH1qqVKymgI7FZ3NvJ4wtThIuJCxvku6LkAFvq
         ly5D6tFGIk7/G0OmV5HRKj5S3MKU9oVhqbjREj/mbIT3HkTmqRWb+1UEvD6LKKMnFI3g
         SuoBmyDBKNXrAoJWeIrt0uOCV+wysgyoOV2EKO/mITYk7p4C77qGKuA3ogXaFVHrptM5
         PrfaFaA5+rVQWEl3oB3kRleJ3w4Lw583/ILUe2NZffLRkFjlo46DnZLfhcwjtih/gM5o
         +nxijULOsWVy6hVnnKZYEj2VWLigFTcLaGgRC6Kj+B1rxcJm9FgK/w2HS7dTQ2J60wCA
         HRVA==
X-Gm-Message-State: ANhLgQ2NKs2Cf6DIwxZm5Y/OwrWeeiUwSGsJDskmjDXofCX6NxKWA22N
        +sbnRoEwBe2gzDrNI9Mcfqm6ZByjXTMTYLiZ7c7leFfINMMll4hPBkmvndJAF9muYcl4cWhZGOW
        3mQTzFMRwYpgpsiOMCaV0GQZZi5UHX4pyECW58kyRQY0NBKUBVymKo6P8D+81xgfSKAbvXDdokv
        1HXGUHFBQ/CGg=
X-Google-Smtp-Source: ADFU+vvn3anPPvbq1a4giE8OwsfTK94Q34DHi0VZLk8YJsN18Q1Frq8IXkxJi7bguIJcYXyKJ74kgnI6jxdbXBbwcg==
X-Received: by 2002:a17:90a:1784:: with SMTP id q4mr14107944pja.111.1585551703216;
 Mon, 30 Mar 2020 00:01:43 -0700 (PDT)
Date:   Mon, 30 Mar 2020 15:01:37 +0800
Message-Id: <20200330150033.Bluez.v1.1.I3621733fcf428d49c82b09bfc2bdc7d3b2f7894a@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
Subject: [Bluez PATCH v1] monitor: Fix missing setting string
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, luiz.von.dentz@intel.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Howard Chung <howardchung@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add wideband speech and phy-configuration to setting string
---

 monitor/control.c | 2 +-
 monitor/packet.c  | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/monitor/control.c b/monitor/control.c
index 1e9054db3..790890fb4 100644
--- a/monitor/control.c
+++ b/monitor/control.c
@@ -200,7 +200,7 @@ static const char *settings_str[] = {
 	"powered", "connectable", "fast-connectable", "discoverable",
 	"bondable", "link-security", "ssp", "br/edr", "hs", "le",
 	"advertising", "secure-conn", "debug-keys", "privacy",
-	"configuration", "static-addr",
+	"configuration", "static-addr", "phy-configuration", "wide-band-speech",
 };
 
 static void mgmt_new_settings(uint16_t len, const void *buf)
diff --git a/monitor/packet.c b/monitor/packet.c
index 994ae6341..3d32563e6 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -11668,6 +11668,7 @@ static const struct bitfield_data mgmt_settings_table[] = {
 	{ 14, "Controller Configuration"},
 	{ 15, "Static Address"		},
 	{ 16, "PHY Configuration"	},
+	{ 17, "Wideband Speech"		},
 	{ }
 };
 
-- 
2.26.0.rc2.310.g2932bb562d-goog

