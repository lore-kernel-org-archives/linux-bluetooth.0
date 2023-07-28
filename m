Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B43C0015E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Jul 2023 05:25:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbjG1FZS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Jul 2023 01:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233160AbjG1FZP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Jul 2023 01:25:15 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB3E3580
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jul 2023 22:25:14 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so6208747a12.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jul 2023 22:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1690521912; x=1691126712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C7E+FTqfyEXrIi3TWNidzVidXXLIuSIeeSDB1DNrydQ=;
        b=q6F5xAYZXIh6Tdvc40hQMOvn5N4pDp3RQtM9GO8aMJJA5kcrMH+F9JRirtwgbLcbZq
         E/f5g271J39toiFMaxiVWS6E9CnUBiMFSb2eQdfRv3j7onoHq0pUHKw3PAV3dLeCEljB
         xQirsEAkhzo7sy5Y7yKDqQIjWckVFYenooguI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690521912; x=1691126712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C7E+FTqfyEXrIi3TWNidzVidXXLIuSIeeSDB1DNrydQ=;
        b=GpZLYsFfS3NfoWDUuOJugJeaHMH9slBk7fSxx4vuprpNFGSq4XZUWrNbgiBYlUbUcu
         8Exe5lkSoZNklJ7H25Yqyh/BEJlTBJSAJXyVXeHVB56hJU14jj+A4H1WZ8yIzKmwNsK/
         S4Xzt7EQeQD5F3db9m+5E9q8E+D7zB1824CkQ+fBea8TJh3KZDobKQxp0LKWs1xpNUPS
         zgB5lH2NiLvAzLvF5xnqkWzjSo0nrLLq2zaAt26wOsYwHNZ/N3lTyW4jDfwOgCjnyLtz
         BCckm0sAEMHz61+arhMED1mEVnOXyF5UHsjXq73IqLaMX709CQVRzUvRBGlhPfaqA1MP
         kExw==
X-Gm-Message-State: ABy/qLbY5TptVL5UUKGxVEMznkMeVC5zx9vQEuXokbB3oCKVQewyaIdl
        4ZrAhykLtMLWDL//7pcPqFtAJWU4ZWzXC4IHVWY=
X-Google-Smtp-Source: APBJJlHiLCbpbTJR2TZ2895A5UkfwVhNh6k2WlUR8gi334PXXBWqgqx9hoFLsefKpjn35oBq+ISz7g==
X-Received: by 2002:a17:907:784d:b0:99b:50ea:2f96 with SMTP id lb13-20020a170907784d00b0099b50ea2f96mr1429867ejc.12.1690521912119;
        Thu, 27 Jul 2023 22:25:12 -0700 (PDT)
Received: from smi-ubuntu.sueba ([2a01:390:0:101:353d:c2fa:e0df:3251])
        by smtp.gmail.com with ESMTPSA id va16-20020a17090711d000b0099bc0daf3d7sm1600545ejb.182.2023.07.27.22.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 22:25:11 -0700 (PDT)
From:   Simon Mikuda <simon.mikuda@streamunlimited.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ 1/1] adapter: Be able to use ConnectDevice for discovered devices
Date:   Fri, 28 Jul 2023 07:25:06 +0200
Message-Id: <20230728052506.582394-2-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230728052506.582394-1-simon.mikuda@streamunlimited.com>
References: <20230728052506.582394-1-simon.mikuda@streamunlimited.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This can be useful when you want to specify trasport type for already
paired device (e.g. use LE transport for dual mode device).
---
 doc/adapter-api.txt | 2 +-
 src/adapter.c       | 3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
index 9b2721c1b..239d9463d 100644
--- a/doc/adapter-api.txt
+++ b/doc/adapter-api.txt
@@ -182,7 +182,7 @@ Methods		void StartDiscovery()
 			profile will be connected. There is no need for calling
 			Connect on Device1 after this call. If connection was
 			successful this method returns object path to created
-			device object.
+			device object or device that already exist.
 
 			Parameters that may be set in the filter dictionary
 			include the following:
diff --git a/src/adapter.c b/src/adapter.c
index 2679d4302..17f4a637d 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3763,9 +3763,6 @@ static DBusMessage *connect_device(DBusConnection *conn,
 	if (!bacmp(&addr, BDADDR_ANY))
 		return btd_error_invalid_args(msg);
 
-	if (btd_adapter_find_device(adapter, &addr, addr_type))
-		return btd_error_already_exists(msg);
-
 	device_connect(adapter, &addr, addr_type, msg);
 	return NULL;
 }
-- 
2.34.1

