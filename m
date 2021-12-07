Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA10C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Dec 2021 22:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242401AbhLGW7n (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Dec 2021 17:59:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242400AbhLGW7n (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Dec 2021 17:59:43 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45ECEC061574
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Dec 2021 14:56:12 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id w1so1888595edc.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Dec 2021 14:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mTxRFAKeAsHwDITQiCzTJ+Q6rYIr9mXEv3r5v8AK5ls=;
        b=Y4TFbbe7J04AGJ039hKDma4pK9DePv28yLyP3L2DkaOiEwGGJJ8q4w+sYXNPDc3zIp
         xYJiajnmyAl8dAJ+oy12CnmDNneL6sN/uQ5KYvUetqkhKm2EYFjvOUschJ3VsPlHW3Zz
         9OBYzH48JYKP91yu9nShUyK/bTglVevoYpsWNn+x0F183uNPEB3A+m3e/u+uEs0Pp2gk
         vDb/RbqKpwy78nkObHOw1TB2XvRMQOveVxkodtx57s3bXvfCzoE2KOplZYDdi+wUFGzX
         /rVSgh2L798qQ14XhhuGoyPXkyExYdks4lPO60vXv2PuRmdt+TG4/GnRFkyrpFltBKaM
         uYqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mTxRFAKeAsHwDITQiCzTJ+Q6rYIr9mXEv3r5v8AK5ls=;
        b=XuYxfh2zrKHfi3UQNVoq9TRUDDjEqk/ifQJGxWnVhog/+E+SWtSOc89+2eIJxinfYw
         m61Kb1Ws2sPmvsfg95o0YqLeqcNDmPxaFB/8fbmPHGZwzc/v1zJ+JqsIlrXP03LZiTW9
         38Eyzq9hoXeQtCr/Bvd1+Ud3PTKDziCxPYNUV1TsDUXuUP0Csy5y6YzfaY12Wjcu+OS8
         592njDRF4gN0lQXz9eqsUa+K6D5PdrOohHtsLZ/6bZaa2aYXx68srEYnGceUssOeVaQU
         FUHgsxR98YA5pXynxWkpi/CxucM4nUQ02WLH8CMlM6whj3ttX7k9rGus2V8oN0CADiLM
         5O3w==
X-Gm-Message-State: AOAM533Ubtk+4coYCEyZa3hIt4kIEPqCT1EMmWe7iI1HUfgoS32O6wOV
        ZsYd5JFGBclW5JSG2eUJMKBaHDiIy+I=
X-Google-Smtp-Source: ABdhPJwvfUnI1ZoYk/CyTUW/jyHpZsFRqXWAg1RAYt7KCXI45URu7nuh0HSgJtG2lsiar1byY1ChdQ==
X-Received: by 2002:a05:6402:90e:: with SMTP id g14mr13910565edz.49.1638917770855;
        Tue, 07 Dec 2021 14:56:10 -0800 (PST)
Received: from aspire.cbl.vpn (net-188-217-49-100.cust.vodafonedsl.it. [188.217.49.100])
        by smtp.gmail.com with ESMTPSA id ho30sm489468ejc.30.2021.12.07.14.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 14:56:10 -0800 (PST)
From:   Daniele Biagetti <dbiagio79@gmail.com>
X-Google-Original-From: Daniele Biagetti <daniele.biagetti@cblelectronics.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Daniele Biagetti <daniele.biagetti@cblelectronics.com>
Subject: [PATCH BlueZ 3/6] tools/mesh-gatt: Fix unwanted return in onoff client model
Date:   Tue,  7 Dec 2021 23:56:01 +0100
Message-Id: <20211207225604.35156-4-daniele.biagetti@cblelectronics.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211207225604.35156-1-daniele.biagetti@cblelectronics.com>
References: <20211207225604.35156-1-daniele.biagetti@cblelectronics.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Replaced the return statement with a warning message in case of
transmission or reception of messages coming from unknown addresses
(such as group addresses)
---
 tools/mesh-gatt/onoff-model.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/mesh-gatt/onoff-model.c b/tools/mesh-gatt/onoff-model.c
index 1c9676e03..9a4ef6d97 100644
--- a/tools/mesh-gatt/onoff-model.c
+++ b/tools/mesh-gatt/onoff-model.c
@@ -209,8 +209,9 @@ static void cmd_get_status(int argc, char *argv[])
 
 	node = node_find_by_addr(target);
 
-	if (!node)
-		return;
+	if (!node){
+		bt_shell_printf("Warning: node %4.4x not found in database\n",target);
+	}
 
 	n = mesh_opcode_set(OP_GENERIC_ONOFF_GET, msg);
 
@@ -237,8 +238,9 @@ static void cmd_set(int argc, char *argv[])
 
 	node = node_find_by_addr(target);
 
-	if (!node)
-		return;
+	if (!node){
+		bt_shell_printf("Warning: node %4.4x not found in database\n",target);
+	}
 
 	np = read_input_parameters(argc, argv);
 	if ((np != 1) && (np != 2) &&
-- 
2.25.1

