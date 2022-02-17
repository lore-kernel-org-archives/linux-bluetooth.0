Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC280C433FE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Feb 2022 23:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiBQXrc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Feb 2022 18:47:32 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:55994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiBQXrb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Feb 2022 18:47:31 -0500
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B29A378F76
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Feb 2022 15:47:06 -0800 (PST)
Received: by mail-pj1-f50.google.com with SMTP id qe15so7061661pjb.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Feb 2022 15:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SF3Rz9iAegGfFyo/QFSu8zphh0k7BTH08lz7l9LmvHs=;
        b=QFnucT4jVLpbz8QSa7F3vDOzGYsgA+TxYW/4VRwi4xSxIO8dcJATUMVYpNKTmNebuc
         z4Omv5ANDtEQ4EE+oYjxTcaxJr8zBdTjWqWTdV2IzyMzZCfCfATNgxZ6Ofd8UjZ8XBCT
         Ag1e3UeGZt7ykc8Zkii7CLZlehDXVjKrO/LBSljq3yqTNRCiOSBnHbSBKxpObm34Qfv9
         6TBP0PbWhTai9I6SCIcg/bRieS0kHJXiRO7aOpsqGx1U6U2VSnU4ON8hFqoelITqqqYh
         hz3D19y/vsxjRpmTAxIRjlJ6E+vGPB5NaootausgYK9soJ6IxBKfxuAzxaxyZstvQico
         s9+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SF3Rz9iAegGfFyo/QFSu8zphh0k7BTH08lz7l9LmvHs=;
        b=x8F3KBO4lA3xjW1gIhX+C8pQc2NY+Pl1B0FAzFwz7F7enhP3+QD+MaflXssigx2Wyo
         o5pswNqPmU/yJJhKybJai/KOI9+ow4Pwoc/KAbSVqMmgdo/W/zyEHizIm6kgLVQKxnse
         GRr/1/b/mYkWR72ojVmDwcOI4f50rxKiK+4q5R8bO+TSPZKV7PV0lUggFddJ2j919/7z
         VkB3MSJeQkcX92NonaCanW1O0saegbRodx/PgzDc/TRAFNFlwEhP7blIc6uLrCFfJpX/
         75AJ2fYBRwF+wkfCo+Z7jxkRnWwe136boF3YASYSZujBIeCxXz/80lU1FOMNDVPBmkgb
         QAiQ==
X-Gm-Message-State: AOAM5318cCuEYC0jxVgsu+TiMNSUTFsyW6ynvf83Ps0lt8Ef07U9fS7I
        TGM05115iKpU/SFgROJUXgJacWVwRYMCCw==
X-Google-Smtp-Source: ABdhPJw5nOJA2N37OdDgTTIk7YyFOI5aTILnQ/DdOehOR/sZsaWZuUB8EkFR0ECQnWcKE0BcvB+ZeA==
X-Received: by 2002:a17:902:da88:b0:14a:26ae:4e86 with SMTP id j8-20020a170902da8800b0014a26ae4e86mr5164971plx.59.1645141143093;
        Thu, 17 Feb 2022 15:39:03 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id lb18sm2840780pjb.42.2022.02.17.15.39.02
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 15:39:02 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] main.conf: Introduce MaxControllers
Date:   Thu, 17 Feb 2022 15:39:01 -0800
Message-Id: <20220217233902.3093404-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This introduces MaxControllers which can be used to limit the number of
adapters exposed in the system.
---
 src/adapter.c | 7 +++++++
 src/btd.h     | 1 +
 src/main.c    | 9 +++++++++
 src/main.conf | 4 ++++
 4 files changed, 21 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 2071cf8db..1551011a8 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -10078,6 +10078,13 @@ static void index_added(uint16_t index, uint16_t length, const void *param,
 		return;
 	}
 
+	/* Check if at maximum adapters allowed in the system then ignore the
+	 * adapter.
+	 */
+	if (btd_opts.max_adapters &&
+			btd_opts.max_adapters == g_slist_length(adapters))
+		return;
+
 	reset_adv_monitors(index);
 
 	adapter = btd_adapter_new(index);
diff --git a/src/btd.h b/src/btd.h
index a805a40d7..d13646889 100644
--- a/src/btd.h
+++ b/src/btd.h
@@ -121,6 +121,7 @@ struct btd_opts {
 	uint16_t	did_version;
 
 	bt_mode_t	mode;
+	uint16_t	max_adapters;
 	bt_gatt_cache_t gatt_cache;
 	uint16_t	gatt_mtu;
 	uint8_t		gatt_channels;
diff --git a/src/main.c b/src/main.c
index 8cc2dfca6..bf9d398e4 100644
--- a/src/main.c
+++ b/src/main.c
@@ -77,6 +77,7 @@ static const char *supported_options[] = {
 	"NameResolving",
 	"DebugKeys",
 	"ControllerMode",
+	"MaxControllers"
 	"MultiProfile",
 	"FastConnectable",
 	"Privacy",
@@ -779,6 +780,14 @@ static void parse_config(GKeyFile *config)
 		g_free(str);
 	}
 
+	val = g_key_file_get_integer(config, "General", "MaxControllers", &err);
+	if (err) {
+		g_clear_error(&err);
+	} else {
+		DBG("MaxControllers=%d", val);
+		btd_opts.max_adapters = val;
+	}
+
 	str = g_key_file_get_string(config, "General", "MultiProfile", &err);
 	if (err) {
 		g_clear_error(&err);
diff --git a/src/main.conf b/src/main.conf
index 49b9e6755..401796235 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -51,6 +51,10 @@
 # Possible values: "dual", "bredr", "le"
 #ControllerMode = dual
 
+# Maximum number of controllers allowed to be exposed to the system.
+# Default=0 (unlimited)
+#MaxControllers=0
+
 # Enables Multi Profile Specification support. This allows to specify if
 # system supports only Multiple Profiles Single Device (MPSD) configuration
 # or both Multiple Profiles Single Device (MPSD) and Multiple Profiles Multiple
-- 
2.35.1

