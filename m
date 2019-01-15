Return-Path: <SRS0=18cS=PX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC96C43612
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Jan 2019 14:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8B5A20656
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Jan 2019 14:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dT+JvBR0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730006AbfAOOMe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Jan 2019 09:12:34 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42429 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730000AbfAOOMe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Jan 2019 09:12:34 -0500
Received: by mail-qk1-f193.google.com with SMTP id 68so1584671qke.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jan 2019 06:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=Ei+i5HTcP0MZ6Q36/H2rA5K0H0HbOdEJMvGxu12BRUo=;
        b=dT+JvBR0hgQEhXjWJzl57zIG/8oVjXOVT/wu+5EpjdKqCcIVrYMRd928gpESzxMPfn
         EWeFsUA3vjvM2zTKRvNYFRkeTZnnjQ4MYLSMV/2LS+DP27M4t9Xx0Ml0gF/8ndKr0swy
         i/hFb+nrZCswMOHxyk4XCFGjcvvKz5/E6SAjkjUtLJ3lKtLTYtrpzWem/qYTvNdh2IkQ
         XstdMGq5VYQVwfHjEAtk21n2i3Gr8cE9qz48o4ciDeGwrYVru+EV4R0YoK1LB5XlCxJP
         T9TN+FQyra+5MRCNnrB4kFe2ri9zr4NRqSrGkJqqi3wGo3m1Mm4Gkcku4lWxp9d6Xr5t
         mydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=Ei+i5HTcP0MZ6Q36/H2rA5K0H0HbOdEJMvGxu12BRUo=;
        b=SiU6qkdKz4uYOlPagKxuFp2/JMG5AFCCmLmFe2GbJMJJ4eWLaIzjp2ArjQuga1fFP0
         WFn894BJ0tk2TEYEGPGpsBfjK7BnNw4hJOdDSg8eFwsDgHIuoWzTXu/dvOz/0SbYdr5k
         SJN2LhgFJjdpgiPkgX7Hr4f2sQZCgcwEn+F8kkwZLBu2ddPP5iReKu6hEMmTOXxVVOL4
         l1D+NbG4BrD61nVd2EbPiomYKrkHOyx809c5A5TvYWwgK9iQHjNvYrn287bTqQP07R1x
         Xr3n7RwTLdWSsbj684Q64jtXZj9pwhtT9Y7rB8+dXw993FTNf5HUwKia8FpXms9ZyhFD
         073A==
X-Gm-Message-State: AJcUukdMdyv0oQrwGwvghrV72RIcfmJSR1Z6LYNwNQ9XzvUwrQB0aYh+
        zyfO/gwobLrX5hOUoju0CcmxrA3rKkI=
X-Google-Smtp-Source: ALg8bN5sSckGZdwGe3GIO9xtjR/3Y9OD9FHWoXlLrNU0NMs+duaoSk+iUDcE3/oXb7es4305rzVPoA==
X-Received: by 2002:a37:6517:: with SMTP id z23mr2840750qkb.161.1547561552836;
        Tue, 15 Jan 2019 06:12:32 -0800 (PST)
Received: from localhost.localdomain ([186.206.5.228])
        by smtp.gmail.com with ESMTPSA id l95sm10572580qkh.37.2019.01.15.06.12.31
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 06:12:32 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 5/8] doc/settings-storage: Add Endpoint group to cache
Date:   Tue, 15 Jan 2019 11:10:20 -0300
Message-Id: <20190115141023.353-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190115141023.353-1-luiz.dentz@gmail.com>
References: <20190115141023.353-1-luiz.dentz@gmail.com>
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

