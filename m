Return-Path: <SRS0=sr2f=PQ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 288C6C43612
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Jan 2019 15:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA47821019
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Jan 2019 15:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ezoVrjAs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729032AbfAHPuD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Jan 2019 10:50:03 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40428 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727906AbfAHPuD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Jan 2019 10:50:03 -0500
Received: by mail-pl1-f196.google.com with SMTP id u18so2077715plq.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Jan 2019 07:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=Ei+i5HTcP0MZ6Q36/H2rA5K0H0HbOdEJMvGxu12BRUo=;
        b=ezoVrjAsq9gxkEVIlaLiG3kE9Qge37tCIVEQ0JMUsflQCgiii6pkYFWwlXG3XCIDky
         GzLfbJtWV41rMNl+OVXcVymv/FpRTRdzaobvSnNUpd7F67rq7ZmgDqjtIEaikf7cMDwD
         R//wPLWlWaX0be3iIt3tF2htkLzWV8xMpnOz5PwUBaJ/KTDMtOJGOal46v2xe1Dgqzgs
         xvP1NhLRrQ9lmQ2ffiBOVsO0UGDPeuNCc9EdRuHxQYhK9//U9CJVYWj3X/uG7RpfZpdI
         CM2iCr1bbvNmCvD0Q/s0AoBlDrDQRBz1dJ6pphLyIcAdIqGK3owwkmRP/BtzgdjxwVK7
         fvvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=Ei+i5HTcP0MZ6Q36/H2rA5K0H0HbOdEJMvGxu12BRUo=;
        b=UIJbYszOlwQlgWkwDmlZu0FWlxR312qz4JgHDxy2cKnVZfwon+fF12w7vM3EnziG33
         dDJ6beQ6gaPmj8I4LDg4jlSfcaH9Tz2w3IW0f8qvIdVqSW17X3Jw2AxY+ZkrZB53urpu
         cOHQ+frcjPxEa/AzIc4rUU1GjZ6hCbTKMMaWNXxzHdAa4qjeZYOJrUNKNxiwKkaRPLvj
         xGMAy34LLa5HjOlfENc+tqmi1BZV3EyjtquGrw8loscRotcdL6H/tZy1D7aYT3cVsDbE
         M183ktAK7Cae0pEd1bYENViwrBZPWsDYhayPn5LOCxLnrV8y1bPmEkpzXateRiUuCoKf
         DuuA==
X-Gm-Message-State: AJcUukeFYg217eWPg0ujt+ioqf0KQuDfBe2jutjE7aQFENPT3fDXuvR8
        rhkquD1v61B8WECAJjZGFWbZrhqPRBU=
X-Google-Smtp-Source: ALg8bN7xhRoWLgzqWAGQb19+UH3V099TdbKc5qaREzH4n/hUlDPnoCSAqDFfCKFRG8oGgu7lMgffEg==
X-Received: by 2002:a17:902:e18d:: with SMTP id cd13mr2286372plb.262.1546962602078;
        Tue, 08 Jan 2019 07:50:02 -0800 (PST)
Received: from vudentzs-t460s.amr.corp.intel.com ([2804:14c:8782:823b::1002])
        by smtp.gmail.com with ESMTPSA id 196sm275082811pfc.77.2019.01.08.07.50.00
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Jan 2019 07:50:01 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/6] doc/settings-storage: Add Endpoint group to cache
Date:   Tue,  8 Jan 2019 12:49:49 -0300
Message-Id: <20190108154950.8534-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190108154950.8534-1-luiz.dentz@gmail.com>
References: <20190108154950.8534-1-luiz.dentz@gmail.com>
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

