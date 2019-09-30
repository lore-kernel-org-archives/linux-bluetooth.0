Return-Path: <SRS0=G1Nt=XZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A6EAC388F4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Sep 2019 09:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2152521721
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Sep 2019 09:22:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="Wx/+1/ta"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbfI3JWl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Sep 2019 05:22:41 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33280 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbfI3JWl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Sep 2019 05:22:41 -0400
Received: by mail-lj1-f194.google.com with SMTP id a22so8677630ljd.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Sep 2019 02:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QTN1y9TOQH0HRUT0BHv+ByuZ253DbuQM1DJ2JUNJ0cg=;
        b=Wx/+1/tafkfo1/0+oVHXu94h0i/o9oWCZZXwh+IPFdCIvEgqM7682CQZuRMP4GikmR
         KvLiF5t4oOA1W1VIRXWBnEdC1jEqtQwpvafZhaa8XXqejFUyo3HPnbmaJfoiHhG6W6e2
         +GySUpepx0IsUG4c7ukkjH6FVHWbof8GRmLnOTZ4BFIs4qSV8M8cZOyLts3uVCP2AiSW
         5zPLY5DWdNYP5c8Zgu0Etf/LGR2YYDYCFKT/z/DR8T59QNwIhlOcVck4VoG8oruOEeeM
         R51VhtrD3G+niqmSzipkhqqY7T0wVWP0wv/6Xg3nbn5QWbuA8qfrXHF9vAxJWH6Qa1+/
         OrWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QTN1y9TOQH0HRUT0BHv+ByuZ253DbuQM1DJ2JUNJ0cg=;
        b=my99L8UIX2Nae7GEEZpu6241b/3cmE5ua8pZc8BMt7b0H9Th8IiRHWtU2TnhXa4dlX
         W/KO6h2tmHN36gGorOT1Bwr6Xm5K28sxk20DXBtHewoIutxAakMRNpMfyLypoQJz4EGM
         kcBzXm85TVXc8SkMQu+OyGDz6YqvITSGG/SSgI/Rk6o3ophANhumePV/tLOsCatg4hmS
         2KOncExdPEewYxm9ipR4O4l+ir6nkCezCNedIhkf8+fr6ylobSZRys5BEIA/PgF+YHks
         2iwJ0Z+6hqbR9uhQp6AYJv6G+kgdWLo+XEoWMdij8rdzyG8mOLQ6Meq9praozkUjwXoS
         Lzgw==
X-Gm-Message-State: APjAAAUo1+j4Pj8Gs3NenBaaQrJyKKEBrKymNsN5XjNKe+tsFfLMEugJ
        fFgopMqBqKpogSlDvxhYKkxVbxcAOTg=
X-Google-Smtp-Source: APXvYqyP7dMAAAmpqLpwwIvbCeZmA/dGIV8XhacQMI2hBBCHJn5MbQDZC0u+zAQKsAS7lnYaQE6EzQ==
X-Received: by 2002:a2e:7e05:: with SMTP id z5mr11496451ljc.8.1569835357321;
        Mon, 30 Sep 2019 02:22:37 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id p22sm3096757ljp.69.2019.09.30.02.22.36
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 02:22:36 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] mesh: Fix ignored return value
Date:   Mon, 30 Sep 2019 11:22:30 +0200
Message-Id: <20190930092230.15122-1-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This fixes the following build error when compiling in maintainer mode:

mesh/keyring.c: In function ‘finalize’:
mesh/keyring.c:142:8: error: ignoring return value of ‘write’, declared with attribute warn_unused_result [-Werror=unused-result]
  (void)write(fd, &key, sizeof(key));
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
---
 mesh/keyring.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mesh/keyring.c b/mesh/keyring.c
index 3a7f92f9f..806ea153c 100644
--- a/mesh/keyring.c
+++ b/mesh/keyring.c
@@ -139,7 +139,8 @@ static void finalize(const char *fpath, uint16_t net_idx)
 	l_debug("Finalize %s", fpath);
 	memcpy(key.old_key, key.new_key, 16);
 	lseek(fd, 0, SEEK_SET);
-	write(fd, &key, sizeof(key));
+	if (write(fd, &key, sizeof(key)) != sizeof(key))
+		goto done;
 
 done:
 	close(fd);
-- 
2.19.1

