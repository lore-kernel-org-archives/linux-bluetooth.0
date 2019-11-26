Return-Path: <SRS0=oE9z=ZS=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FFB2C432C0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Nov 2019 19:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D12AE207DD
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Nov 2019 19:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DCoL/2z0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbfKZTO4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 Nov 2019 14:14:56 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:33642 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbfKZTO4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 Nov 2019 14:14:56 -0500
Received: by mail-vk1-f193.google.com with SMTP id b64so4749913vkg.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Nov 2019 11:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4fjFadtOE1y2ASE+pw74HaEijTyrQTOi/Pb5vTJXJmA=;
        b=DCoL/2z02Jg8ekCdZLZdxpeExYCBAW5cqzA+7nS+9tuWOJ90JC4l1Qx8j7iG/zyM9t
         sheZnZDT3gfnr++2dhBoyVRkOn7jriA68h4XdJy2p5m9Lwlne1Dl9UxNgV7c5ku1r6d+
         kX2osMt6UNDlrDaw58XxqMN5BVN/30OKKCDXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4fjFadtOE1y2ASE+pw74HaEijTyrQTOi/Pb5vTJXJmA=;
        b=OdXXHJAI33Hbe3kzk2VogrzWiLpoUEjmhqF54QfOezXQw8ODYjmYmhi92nnYW4NUFH
         NEDLY64mehyJTfykQCKgrBZGPK1wxltgxzF5Em+6Qp4chXAN0PRqhDmSnGKOemD7TKay
         KwK97CMCxH7F1Q6X7O4xSaByRDdOYjaKAERp8r61+moWWFFtCtuwdUnQN9s23Gr4+RTm
         kI48K03/manRl0hySGkrRjpZnBjz/PfRkP+D13A6SwRW4jSIcOcZtSCK9Q0vYY+p5nKu
         sY2KnNGYF1e2hPv7JNzIrI3CkGfVD658H1v/FK13NzxejUFf0RwNo9rnyG6eWGoB8E4A
         nNYQ==
X-Gm-Message-State: APjAAAV7gvjHe4P+M8+PT+w/u+vpEJr+Zfpv/KJ6yipzEnB7Hg7gf829
        dAE1FRjjjf98qFFp8VHcya6nuXvNOUZzLQ==
X-Google-Smtp-Source: APXvYqwG5yVg9uNuY5oi7urzLj+IS2LLpldHtkOL+f8yXZH1dI2NA4vat7c+ikZbT55CfLcHGo3dUQ==
X-Received: by 2002:a1f:e0c2:: with SMTP id x185mr90994vkg.6.1574795694892;
        Tue, 26 Nov 2019 11:14:54 -0800 (PST)
Received: from alain.us-east1-b.c.cloudtop-prod.google.com.internal (239.145.196.35.bc.googleusercontent.com. [35.196.145.239])
        by smtp.gmail.com with ESMTPSA id q16sm3229784vke.31.2019.11.26.11.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 11:14:54 -0800 (PST)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [PATCH] Blocked key mgmt Api definition
Date:   Tue, 26 Nov 2019 19:14:52 +0000
Message-Id: <20191126191452.23603-1-alainm@chromium.org>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 doc/mgmt-api.txt | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 0d11aa035..7c77927a2 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -3013,6 +3013,39 @@ Set PHY Configuration Command
 	Possible errors:	Invalid Parameters
 				Invalid Index
 
+Load Blocked Keys Command
+===========================
+
+	Command Code:		0x0046
+	Controller Index:	<controller id>
+	Command Parameters:	Key_Count (2 Octets)
+				Key1 {
+					Key_Type (1 Octet)
+					Value (16 Octets)
+				}
+				Key2 { }
+				...
+	Return Parameters:
+
+	This command is used to feed the kernel a list of keys that
+	are known to be vulnerable.
+
+	Currently defined Key_Type values are:
+
+			0x00	Link Key (BR/EDR)
+			0x01	Long Term Key (LE)
+			0x02	Identity Resolving Key (LE)
+
+	This command can be used at anypoint to add to the list of blocked keys.  Any connections that
+	are attempting to use the keys will be terminated. If a device tries to distribute the keys during
+	pairing, pairing will fail.
+
+	This command generates a Command Complete event on success or
+	a Command Status event on failure.
+
+	Possible errors:	Invalid Parameters
+				Invalid Index
+
 
 Command Complete Event
 ======================
-- 
2.24.0.432.g9d3f5f5b63-goog

