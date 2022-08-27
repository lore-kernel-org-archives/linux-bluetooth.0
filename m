Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE84ECAAD5
	for <linux-bluetooth@archiver.kernel.org>; Sat, 27 Aug 2022 00:05:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233538AbiH0AFt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 26 Aug 2022 20:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbiH0AFq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 26 Aug 2022 20:05:46 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A83BC13A
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Aug 2022 17:05:46 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id 199so2922269pfz.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Aug 2022 17:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc;
        bh=+CslJruZhhH6jfT3eIwvKw88vFc+u4Wpz1EW4s1KON8=;
        b=DPXnc1YSe5yEu7hGOGjTpyaa+hKTjCjiIThnXDlU7hProxIW5/E4I6reJnkQDhwcGv
         bcFK9b9zlwmNBXOC65asRE6GMFcJRqdPFcG9EPdJCakU5WawXcYnjXLgqNt6r5O00m8l
         7JELrYn2lZ1wjHtxn7NQ5smgMXmbAll0+5RL/oh3QWkwC3oMBoRqt2A3VMwJrkrF/5j4
         GhT/5CssQjBUypkhJ3WTqkpkHuS/y17C6Mm+JGsSZtJp3jHRFRPsfZo6EmZwmr7MsuHS
         flX6ZqXCTqStUi9ZWJA6hYmWbSptYg09kWyNE9WUL38a214dQsEjRIf/3cTq+Ue6iLJr
         0YFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc;
        bh=+CslJruZhhH6jfT3eIwvKw88vFc+u4Wpz1EW4s1KON8=;
        b=5W7JhTCgTYCxrL6N6x6M7lXSh1VpsPw+cPH7Ej+2irkiTqi0Ijh7dfFDSJsqdaaQA3
         Xjx49V45VaT1WC2CTspAg2H4RJy3yV1COrOlFE2v7r8TfETx5YdkBTccIlDe+W3or3dj
         0Nw2U0kJt3+hMff/1QOUvDZEeB23T7F4O6t1MdUo2Di2V7mDG54ofE1Bc8YtYA2NQx8L
         X0Knqfvdgn6rn/c9ZSl9CGZMyURuuNagyKx8fAxKYiZcZ3XFN+zUxv/DhGaRZjq8SGP7
         ROfN8vY0ArJNBnQ5NtnmKK5oH5HrC1VFeza8YPG6g2klG/ZWf6kXJmZ71LxLBAIAef4b
         qBHw==
X-Gm-Message-State: ACgBeo1bam9FnURakClPnClv8L8LFyUWa2K9wZS7b4Qoy6MPNnSCoKXy
        28KSoN1H0lRQhZQW8vH85LGK9ANwwgE=
X-Google-Smtp-Source: AA6agR4edTkpqHBlsMvJdk0lR9y3WVQc1Qf3FJFOd9vIsV4Hhzmav3tjsJDtidpmlm9ORItlFYp6fw==
X-Received: by 2002:a63:8542:0:b0:42b:4c9a:97cd with SMTP id u63-20020a638542000000b0042b4c9a97cdmr5140038pgd.221.1661558744903;
        Fri, 26 Aug 2022 17:05:44 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id o1-20020a17090a168100b001fa8b909ef0sm2249487pja.7.2022.08.26.17.05.43
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 17:05:44 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 02/11] lib/uuid: Add PACS/ASCS UUIDs
Date:   Fri, 26 Aug 2022 17:05:31 -0700
Message-Id: <20220827000540.113414-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220827000540.113414-1-luiz.dentz@gmail.com>
References: <20220827000540.113414-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds PACS/ASCS UUIDs which will be used by Basic Audio Profile.
---
 lib/uuid.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/lib/uuid.h b/lib/uuid.h
index 6236752a17a6..cb9294be8c6e 100644
--- a/lib/uuid.h
+++ b/lib/uuid.h
@@ -146,6 +146,24 @@ extern "C" {
 /* GATT Server Supported features */
 #define GATT_CHARAC_SERVER_FEAT				0x2B3A
 
+/* TODO: Update these on final UUID is given */
+#define PACS_UUID					0x1850
+#define PAC_SINK_CHRC_UUID				0x2bc9
+#define PAC_SINK_UUID		"00002bc9-0000-1000-8000-00805f9b34fb"
+#define PAC_SINK_LOC_CHRC_UUID				0x2bca
+
+#define PAC_SOURCE_CHRC_UUID				0x2bcb
+#define PAC_SOURCE_UUID		"00002bcb-0000-1000-8000-00805f9b34fb"
+#define PAC_SOURCE_LOC_CHRC_UUID			0x2bcc
+
+#define PAC_CONTEXT					0x2bcd
+#define PAC_SUPPORTED_CONTEXT				0x2bce
+
+#define ASCS_UUID					0x184e
+#define ASE_SINK_UUID					0x2bc4
+#define ASE_SOURCE_UUID					0x2bc5
+#define ASE_CP_UUID					0x2bc6
+
 typedef struct {
 	enum {
 		BT_UUID_UNSPEC = 0,
-- 
2.37.2

