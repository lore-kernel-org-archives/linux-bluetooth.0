Return-Path: <SRS0=CLw3=RR=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4AF2C43381
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Mar 2019 14:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B98492075C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Mar 2019 14:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+T0yY8Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbfCNOvM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 14 Mar 2019 10:51:12 -0400
Received: from mail-ed1-f50.google.com ([209.85.208.50]:46646 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfCNOvM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 14 Mar 2019 10:51:12 -0400
Received: by mail-ed1-f50.google.com with SMTP id n17so4847259edt.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Mar 2019 07:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Z5kPax8mj1GEB10T43xudYLezyTV8jTu1noXla33cjU=;
        b=R+T0yY8Z79fudbp/YJWJzt86VSJ9i3iZkix10G4LzwBB/S9KZGnArT5WoOJiyRuc7T
         dDHrcKoS7BE1a9H7a/Imp0xJk8eNdg03nnKHu6B4bjkTGsDvd0EDRdmwxNwPS8Jhn9Vg
         5Pi3NZc5raJxRkIOsdy0K8Zm0f4U3CEWEeZKwJ1021RlwaDueHIXJC6lJndFFFxmXXJp
         mdbL3/UVSRpxEOwTnYmoOQDSHP6syW519DUj/ly8Qx/qAvbt4iewff9agtd6eCne83jB
         VvJHW+KOsbDEIsk4yhH9zNtzqv3LuWHHNwkfgg9FpoNoeP4CjYiN6Lzc3VKkv9+Vck0R
         l8Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z5kPax8mj1GEB10T43xudYLezyTV8jTu1noXla33cjU=;
        b=hC+IG2wJ25bqjlswCNNRQSZGLQRIraMTw9JdX2vEO8z9GpnpNilk5/8HgB7SDPTl0K
         4WsdqWRhbnCooq1j4uF7RRHuOsviBlEAI8VmFmSyxskkzQRRdApg8lgmSswHb+UzTiAi
         MgyTv5qvbo5LtozSjBWccyJd8YcEy/nO5A3loJWaWf+6lW40LpK3F4Fzld5Cw5TqicXa
         197PIm3VQ86cHLI50hYH8fGrQi61GCI3VNVMxYioVWMTGQpQt6/x738Ms9yA32sxyPVu
         IOul4GnZNyJD1SWUQLb0OI5Q5tOeIHJqAgIS7NzA1xxR8OZI9zT7OS8jnrDbgEXIbpwr
         2hnA==
X-Gm-Message-State: APjAAAUrmxh84e5Ul0j0SxCho8+ZTdR7yfD/Tu8hnuqaZKAQuImOgRXH
        LQe5ZSLL+hADc3yW/za6at2t9ZxxDDQ=
X-Google-Smtp-Source: APXvYqw9KygIMWAxiGTIsJLR+ytzpYsHBFBC4IizKI5yBzFJl638k3Qcap+ABVVVP2skl+9PdFH7xg==
X-Received: by 2002:aa7:c616:: with SMTP id h22mr5438680edq.39.1552575069751;
        Thu, 14 Mar 2019 07:51:09 -0700 (PDT)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id e1sm1467213edn.22.2019.03.14.07.51.08
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 14 Mar 2019 07:51:08 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] shared/shell: Highlight user prompt input
Date:   Thu, 14 Mar 2019 16:51:05 +0200
Message-Id: <20190314145105.25524-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190314145105.25524-1-luiz.dentz@gmail.com>
References: <20190314145105.25524-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes them more evident compared to regular output which is now
possible since coloring prompts should not produce artifacs anymore.
---
 src/shared/shell.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index d7fbf46aa..eac654f40 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -592,7 +592,8 @@ void bt_shell_prompt_input(const char *label, const char *msg,
 
 		prompt = new0(struct bt_shell_prompt_input, 1);
 
-		if (asprintf(&prompt->str, "[%s] %s ", label, msg) < 0) {
+		if (asprintf(&str, COLOR_HIGHLIGHT "[%s] %s " COLOR_OFF, label,
+								msg) < 0) {
 			free(prompt);
 			return;
 		}
@@ -605,7 +606,8 @@ void bt_shell_prompt_input(const char *label, const char *msg,
 		return;
 	}
 
-	if (asprintf(&str, "[%s] %s ", label, msg) < 0)
+	if (asprintf(&str, COLOR_HIGHLIGHT "[%s] %s " COLOR_OFF, label,
+								msg) < 0)
 		return;
 
 	prompt_input(str, func, user_data);
-- 
2.20.1

