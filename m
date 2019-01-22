Return-Path: <SRS0=wtFT=P6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69134C282C3
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Jan 2019 13:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3944A21721
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Jan 2019 13:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uogIOKM5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbfAVNpf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Jan 2019 08:45:35 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35416 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728664AbfAVNpf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Jan 2019 08:45:35 -0500
Received: by mail-ed1-f66.google.com with SMTP id x30so19369547edx.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Jan 2019 05:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=Ei+i5HTcP0MZ6Q36/H2rA5K0H0HbOdEJMvGxu12BRUo=;
        b=uogIOKM5UpTLBxv0bJaTgCKKOd9xY0ZpMZoGYZ1A9XppqMBXTSm3uNH4wr82rCDqHD
         qmgjHkPPldugF8eOy8Z5FnT+ImvXB1gjhl1Pg+T84nJVr+/P0VRJYMFNXN1PGHKdi7Qy
         kkeJs5g/vDa1TY6xqY8voH/Fn3T/QSkpgY5PcqH32lBV+uHDPSEJMDNiAqRHNYDI+lP1
         ALgI51wefMjyrNcXeW9N7F2VdmuabYNhz3atcAZFq0H2/PcIHYo1rBuOgM0m+gR73jFv
         wVFpzpnn9q1uQVMwlRF2PHxS+E6lRnmSyR8nZt/WHGG0WohpHaVI3LlxlvUjoOraibPc
         fKNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=Ei+i5HTcP0MZ6Q36/H2rA5K0H0HbOdEJMvGxu12BRUo=;
        b=KZhfX9uF9u22stre403fB58eVZGNljQbknmpMut+9NTxW8L+kaGQXJ9fL6yedMU7us
         jLroVEeMnZvjQu5R3xmieXIi4D52dfVL0VXNGYbZ6hlaYblvP5weaeKNS7nWtxBZyxbY
         VDHoar/y162Sktg7Uh+eR2Q0gQPrcBbjc0rWisbIrroqkqS8qtEgBcZB6PdnMWAU9Mhy
         5CHVBPRNnldby34mg/2RLaqVaZDzvRlCUhKAZUdsz2kXb03B1Hq8EdQVPeS3FC93pBTX
         fpZEJaEUlrg+iWkObJCzlteoPuJMrl1/AR9JhlJ+/A8poMTvuqDmZ42z26zgOTOa69ig
         u33Q==
X-Gm-Message-State: AJcUuke/qj/I9BuInIZsf9j20wQPp9mEPofLFBmy/zjIinkzlxw0GAyC
        f73SOJLive2DIoq+/XFWIWlRu9A9
X-Google-Smtp-Source: ALg8bN6i/hyrNU5KWTZREghSMgJuH89O72285yNZ51nnORYQm7bAXv50FLg/MqMKx3XVbEabxCSCUQ==
X-Received: by 2002:a17:906:8249:: with SMTP id f9mr5336654ejx.134.1548164733115;
        Tue, 22 Jan 2019 05:45:33 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id dc5-v6sm5319153ejb.53.2019.01.22.05.45.32
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 05:45:32 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 5/9] doc/settings-storage: Add Endpoint group to cache
Date:   Tue, 22 Jan 2019 15:45:20 +0200
Message-Id: <20190122134524.20509-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190122134524.20509-1-luiz.dentz@gmail.com>
References: <20190122134524.20509-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This documents how A2DP endpoints should be stored in the cache.
---
 doc/settings-storage.txt | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/doc/settings-storage.txt b/doc/settings-storage.txt
index 90357f735..44b0b4961 100644
--- a/doc/settings-storage.txt
+++ b/doc/settings-storage.txt
@@ -159,7 +159,7 @@ Cache directory file format
 ============================
 
 Each file, named by remote device address, may includes multiple groups
-(General, ServiceRecords, Attributes).
+(General, ServiceRecords, Attributes, Endpoints).
 
 In ServiceRecords, SDP records are stored using their handle as key
 (hexadecimal format).
@@ -168,6 +168,9 @@ In "Attributes" group GATT database is stored using attribute handle as key
 (hexadecimal format). Value associated with this handle is serialized form of
 all data required to re-create given attribute. ":" is used to separate fields.
 
+In "Endpoints" group A2DP remote endpoints are stored using the seid as key
+(hexadecimal format) and ":" is used to separate fields.
+
 [General] group contains:
 
   Name		String		Remote device friendly name
@@ -211,6 +214,12 @@ Sample Attributes section:
   002b=2803:002c:02:00002a38-0000-1000-8000-00805f9b34fb
   002d=2803:002e:08:00002a39-0000-1000-8000-00805f9b34fb
 
+[Endpoints] group contains:
+
+	<xx>:<xx>:<xxxxxxxx...>	String	First field is the endpoint type,
+					followed by codec type and its
+					capabilies as hexadecimal encoded
+					string.
 
 Info file format
 ================
-- 
2.17.2

