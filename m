Return-Path: <SRS0=Btsr=QG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E91CC282D7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Jan 2019 13:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AA5220833
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Jan 2019 13:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Job1Fwzb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730966AbfA3Nya (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 30 Jan 2019 08:54:30 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40139 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbfA3Nya (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 30 Jan 2019 08:54:30 -0500
Received: by mail-ed1-f66.google.com with SMTP id g22so19038110edr.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Jan 2019 05:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=oaRyVDA/eovjNcMCRjZe6dtyv9PtDgAS5pv0eCkcD0I=;
        b=Job1FwzbrepL8R/oUgPKjA6J7yg2sFGhPhmpkkSyH5z4CMsoXNp2FMEisUq0uzSBlF
         CsyyzzXjkubpzUAB6OH9/oVqubOT8aEA7TNd1MRQ+zGarWjPPSAohIadLWeyzEtUgisp
         FzR356v3Jub0iP4B2quNwBx9rq+ebpwqLy0JtfAT0N2jWshjrbSkSMtVK2foJz57D1hx
         wA45dNotO7rN3MmbqsZ+Rw6vY+efaKYK+4xq1yQuh9mMNXMGZUa5+iVE+SbpyCX3zbPE
         7Tx7w7zRUUxOO/U6ow7d/0B6VB10GX5JYSndTz3vjJ+9IvGyW40WYQyOrFY8ATkCHfMQ
         cGUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=oaRyVDA/eovjNcMCRjZe6dtyv9PtDgAS5pv0eCkcD0I=;
        b=kU7+XIwGRuo3rbIk45IPwKPaw03KO1rmHqm7j9zYVfflMzPeFZurQNYB9WWM3/VVCO
         u9/Vb16NSzuqp+YsBuaf1VBTUBRtLGQX0LtR7xOcUMbuMi8BewUiLjC4CsCpRX6nrAUR
         GN4/VbiclKYDhYmVYoYkZzN2onWjyiwpXOV+kfQgiSL+WHg0OSC4/NhYmr+fjV1z60f3
         2IQgbNMh7Q1ujDTKF57DADO8w7uIxZdWYRqFxd05XDamUOOpd9luOs+a5AtoIDVZHlVx
         qZZ3EeK1A/YHaLKXirsMb0w01EwbFILXhGH9R+8RUgVRUz2BePxKLgKDoHPpsNQTMr/3
         AGrw==
X-Gm-Message-State: AJcUukeDa9gXdaNh7zHJR0ICmstbMiDdT4XhyIyjcigfrQJVaqy3ufOr
        Ec92n2WkH0fPA6KWEOn4dByInOt+
X-Google-Smtp-Source: ALg8bN5JefKasCu6BVu6+vLjsYC73xwrb3KsqunrDb2JA1V6VQVW6vHQ8vuYedeUgLVAbsmacRNzKQ==
X-Received: by 2002:a17:906:6d46:: with SMTP id a6mr25480743ejt.203.1548856468247;
        Wed, 30 Jan 2019 05:54:28 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id s19sm325045eja.52.2019.01.30.05.54.26
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 05:54:26 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/8] doc/gatt-api: Add Handle property
Date:   Wed, 30 Jan 2019 15:54:17 +0200
Message-Id: <20190130135424.2091-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When acting as server it is useful to select where to allocate the
handle for an attribute so it can be restored in the same position when
restarting the daemon or rebooting the system.

In order to do that the application also needs to know in which handle
the attribute is allocated the very first time it is registered, this
also allows for a better integration with PTS and tools like auto-pts
which needs to know the handles where the attributes have been
allocated.
---
 v2: Fixes inserting characteristics and descriptors with handle 0x0000,
 add a patch to enable list-attribute to list with local attributes and
 print changes to attribute Handle property.

 doc/gatt-api.txt | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/doc/gatt-api.txt b/doc/gatt-api.txt
index 8dda60b8a..491eb026a 100644
--- a/doc/gatt-api.txt
+++ b/doc/gatt-api.txt
@@ -50,6 +50,14 @@ Properties	string UUID [read-only]
 			Array of object paths representing the included
 			services of this service.
 
+		uint16 Handle [read-write, optional] (Server Only)
+
+			Service handle. When available in the server it
+			would attempt to use to allocate into the database
+			which may fail, to auto allocate the value 0x0000
+			shall be used which will cause the allocated handle to
+			be set once registered.
+
 
 Characteristic hierarchy
 ========================
@@ -257,6 +265,14 @@ Properties	string UUID [read-only]
 				"secure-write" (Server only)
 				"authorize"
 
+		uint16 Handle [read-write, optional] (Server Only)
+
+			Characteristic handle. When available in the server it
+			would attempt to use to allocate into the database
+			which may fail, to auto allocate the value 0x0000
+			shall be used which will cause the allocated handle to
+			be set once registered.
+
 Characteristic Descriptors hierarchy
 ====================================
 
@@ -332,6 +348,14 @@ Properties	string UUID [read-only]
 				"secure-write" (Server Only)
 				"authorize"
 
+		uint16 Handle [read-write, optional] (Server Only)
+
+			Characteristic handle. When available in the server it
+			would attempt to use to allocate into the database
+			which may fail, to auto allocate the value 0x0000
+			shall be used which will cause the allocated handle to
+			be set once registered.
+
 GATT Profile hierarchy
 =====================
 
-- 
2.17.2

