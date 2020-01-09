Return-Path: <SRS0=NtgA=26=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA38C33CA2
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Jan 2020 08:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E266C2067D
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Jan 2020 08:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="FxFnmsa3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbgAIIjD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Jan 2020 03:39:03 -0500
Received: from mail-lf1-f47.google.com ([209.85.167.47]:41307 "EHLO
        mail-lf1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728508AbgAIIjD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Jan 2020 03:39:03 -0500
Received: by mail-lf1-f47.google.com with SMTP id m30so4550815lfp.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Jan 2020 00:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=FhlLUKjGwVYf5VuApi0YO0EzQNR8qTPBxKH7AHC8hsE=;
        b=FxFnmsa38FiXRIs0Vi7vVcZhgPX5z4bf35phLbgGq12mDIzaOhm8tjlOS8qgyOfJ7L
         qhPfrVxDakjIw+Ax8ra2vkiRGaMspmSZARTwOPw/riIODVrnmbSGsH4Gw1s30KExbAp6
         apljXHNPyWDh0BRuhGFr83muylNtn8wIGnx5JgDLlBSdTfsfKlMBHz/MEiptxECp9HWf
         YaqU8DKi3pcjDTKQOsyeHexgoRcUElmpAS1UbT4FaHx4wFcqK68f8IZv/GUuJRE9oMgS
         DgGnuzcCVDnYLSw0PsTkZBSO7dBgUybwFaqIF0wySnd5P45S69CqfDyVN7rqQLiNkRq+
         nlFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FhlLUKjGwVYf5VuApi0YO0EzQNR8qTPBxKH7AHC8hsE=;
        b=uOC4fDwpCgto7uyK3qr+IhdtILJgYwQyQbk7YBntk74XH33SnlDM4XYq4Vqa+SoTuh
         3RyyubLPxppYwRNyX5HqROUm1wHhAsVWFpAEpofVdJChy2QyP9LbpNsYJ1hw0KFG0gBh
         p6vmu1XIkjKqjCx6CFUsDPeL0OppqXsz5PXwQUhhHrB5qIWnHFpysbvXCmddXj1rybM5
         IoJDU9O3Gbb/KvDEpMhiYZgT1oNllINkogEWMWNGKgC0TKfnzJEPIH39Xn9LszMKfc54
         F1W3zIZTpbKOEcFws7o5AS4CkjFrF1dVgQjxXmX8pGiknG2nIbYZbuny+CsWZEqnbxFY
         xf4Q==
X-Gm-Message-State: APjAAAW579SRfGOF83wTH/0ZtngpbK/MfyQYuxAZy3dhVQ5QS7N3WBMh
        J05lpTYPp4XAQqiwPhshBr5l0jVgmqc=
X-Google-Smtp-Source: APXvYqwrn/FFSGRFs1X5v3j38jdAS6ehFT+N3yq6vq++zx8T/vQYQYddkbMRqeBSdj8yfXQ7kXTt1w==
X-Received: by 2002:ac2:508e:: with SMTP id f14mr5106590lfm.72.1578559141095;
        Thu, 09 Jan 2020 00:39:01 -0800 (PST)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id b22sm2930456lji.99.2020.01.09.00.39.00
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 00:39:00 -0800 (PST)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ 1/2] mesh: Rename IVUpdate import flag to IvUpdate
Date:   Thu,  9 Jan 2020 09:38:54 +0100
Message-Id: <20200109083855.16000-2-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20200109083855.16000-1-michal.lowas-rzechonek@silvair.com>
References: <20200109083855.16000-1-michal.lowas-rzechonek@silvair.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Name change for consistency with "IvIndex" property.
---
 doc/mesh-api.txt | 2 +-
 mesh/mesh.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/mesh-api.txt b/doc/mesh-api.txt
index 6f9531019..b33c24e12 100644
--- a/doc/mesh-api.txt
+++ b/doc/mesh-api.txt
@@ -188,7 +188,7 @@ Methods:
 		The flags parameter is a dictionary containing provisioning
 		flags. Supported values are:
 
-			boolean IVUpdate
+			boolean IvUpdate
 
 				When true, indicates that the network is in the
 				middle of IV Index Update procedure.
diff --git a/mesh/mesh.c b/mesh/mesh.c
index 6d2f86b6d..972beecc9 100644
--- a/mesh/mesh.c
+++ b/mesh/mesh.c
@@ -777,7 +777,7 @@ static struct l_dbus_message *import_call(struct l_dbus *dbus,
 							"Bad net index");
 
 	while (l_dbus_message_iter_next_entry(&iter_flags, &key, &var)) {
-		if (!strcmp(key, "IVUpdate")) {
+		if (!strcmp(key, "IvUpdate")) {
 			if (!l_dbus_message_iter_get_variant(&var, "b",
 								&ivu))
 				goto fail;
-- 
2.19.1

