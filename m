Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D3EC43334
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Jul 2022 00:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbiGAAn6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Jun 2022 20:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiGAAn4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Jun 2022 20:43:56 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DDEC24BC4
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jun 2022 17:43:55 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id z14so984109pgh.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jun 2022 17:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tldd8hQ2wUn25jo82acAyXTHIBMdYLaXJm4pX84uJh0=;
        b=OZ2R2vAbl3j1N9ro9m3UBiFhQk4tKZFk2yEf179rAF/wmMKRoDt81P7AwQoHRb4g5Y
         vzxUI+w8NCphm3AzCilM1yoGnZXHE95zmBOCanBEHP6Rzf/869+VPOQA90rQQ0U4Aing
         ZCd8UF8Jjj4sEbXcxVlxGSj6MueHH6EKL0yNU196kdOk+MdZgsqHFfpCT+MSPOIOsUuH
         ULZTToPUd6yccgxvVQDvewrt5GOYL0HwXME+JZbDYjFuka/8kBtswsQyhgF4GwHtg7qU
         thqlduWqndFl48Crr0FPrUjcRzUwyu55msilMYfGH/L0TQUNd0OGoxxcBG66tAcRKePs
         8LXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tldd8hQ2wUn25jo82acAyXTHIBMdYLaXJm4pX84uJh0=;
        b=cBG8UIlBjhujn/uNFiJQe1yDPY418hlmwqZXNiecQKu/nkOLjth0OqFm8hb8o9VyxD
         FwIqz/8FS39fnJRijZ60G/XkX4Cw6OvRR7EXPv76xuBJRbA6dq8CMLjhTRbiAvw9xuGp
         pnB9kE73bBSGfiie6BUo0OsFqNf3I3fV5NHx5nH/Nd0HHlAuYlyr1Y4FhMW7WdSY6kV3
         4yIYClrbFyEPeUXL/+Bu2mHGfez1ntT6BAlM7PLXhQfTPoBz7lFYi6OpYkQk60DgzgXT
         OF3EvlLYA3FP1HZEsfuf3g28KSIU9htpw9e8SX/4we9s0gGDOAFZ4kfOfFmLokV0TmUz
         gL9A==
X-Gm-Message-State: AJIora/MQXB+Xh7PmqsS9DvTvOInVOgsR7Tp1+Z4hUgLSgP/HkjkWuNQ
        ncBBh4UvGBiygbO/i1AaYeRW4/nfhTk=
X-Google-Smtp-Source: AGRyM1smJ3I6c4J2js9DY1uy2laVOFty9rZA4HWc71rXDPcBJ7Ec6GjnIn6cBXH2pvr/XagxqPbURQ==
X-Received: by 2002:a63:9516:0:b0:40c:c3b9:f984 with SMTP id p22-20020a639516000000b0040cc3b9f984mr10062309pgd.116.1656636234559;
        Thu, 30 Jun 2022 17:43:54 -0700 (PDT)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a01:d830:6a2e:d91e:28c5:a052])
        by smtp.gmail.com with ESMTPSA id z11-20020aa7888b000000b0052516db7123sm14181442pfe.35.2022.06.30.17.43.53
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 17:43:54 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] tools/btmgmt: Fix errors reported by scan-build
Date:   Thu, 30 Jun 2022 17:43:51 -0700
Message-Id: <20220701004352.2253107-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch fixes the errors reported by the scan-build.

tools/btmgmt.c:2699:2: warning: Value stored to 'argc' is never read
[deadcode.DeadStores]
        argc -= optind;
        ^       ~~~~~~

tools/btmgmt.c:2859:2: warning: Value stored to 'argc' is never read
[deadcode.DeadStores]
        argc -= optind;
        ^       ~~~~~~

tools/btmgmt.c:2860:2: warning: Value stored to 'argv' is never read
[deadcode.DeadStores]
        argv += optind;
        ^       ~~~~~~

tools/btmgmt.c:2934:2: warning: Value stored to 'argc' is never read
[deadcode.DeadStores]
        argc -= optind;
        ^       ~~~~~~

tools/btmgmt.c:2935:2: warning: Value stored to 'argv' is never read
[deadcode.DeadStores]
        argv += optind;
        ^       ~~~~~~

tools/btmgmt.c:3000:2: warning: Value stored to 'argc' is never read
[deadcode.DeadStores]
        argc -= optind;
        ^       ~~~~~~

tools/btmgmt.c:3001:2: warning: Value stored to 'argv' is never read
[deadcode.DeadStores]
        argv += optind;
        ^       ~~~~~~

tools/btmgmt.c:3261:11: warning: Value stored to 'index' during its
initialization is never read [deadcode.DeadStores]
        uint16_t index = mgmt_index;
                 ^~~~~   ~~~~~~~~~~

tools/btmgmt.c:3450:2: warning: Value stored to 'argc' is never read
[deadcode.DeadStores]
        argc -= optind;
        ^       ~~~~~~

tools/btmgmt.c:3451:2: warning: Value stored to 'argv' is never read
[deadcode.DeadStores]
        argv += optind;
        ^       ~~~~~~

tools/btmgmt.c:4822:2: warning: Null pointer passed to 2nd parameter
expecting 'nonnull' [core.NonNullParamChecker]
        memcpy(cp->data + uuid_bytes, adv_data, adv_len);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

tools/btmgmt.c:4823:2: warning: Null pointer passed to 2nd parameter
expecting 'nonnull' [core.NonNullParamChecker]
        memcpy(cp->data + uuid_bytes + adv_len, scan_rsp, scan_rsp_len);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

tools/btmgmt.c:5244:2: warning: Null pointer passed to 2nd parameter
expecting 'nonnull' [core.NonNullParamChecker]
        memcpy(cp->data + uuid_bytes, adv_data, adv_len);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

tools/btmgmt.c:5245:2: warning: Null pointer passed to 2nd parameter
expecting 'nonnull' [core.NonNullParamChecker]
        memcpy(cp->data + uuid_bytes + adv_len, scan_rsp, scan_rsp_len);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
---
 tools/btmgmt.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index 3bf2c21c1..ebef3888f 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -2696,7 +2696,6 @@ static void cmd_disconnect(int argc, char **argv)
 		}
 	}
 
-	argc -= optind;
 	argv += optind;
 	optind = 0;
 
@@ -2856,8 +2855,6 @@ static void cmd_find_service(int argc, char **argv)
 		}
 	}
 
-	argc -= optind;
-	argv += optind;
 	optind = 0;
 
 	cp = (void *) buf;
@@ -2931,8 +2928,6 @@ static void cmd_find(int argc, char **argv)
 		}
 	}
 
-	argc -= optind;
-	argv += optind;
 	optind = 0;
 
 	memset(&cp, 0, sizeof(cp));
@@ -2997,8 +2992,6 @@ static void cmd_stop_find(int argc, char **argv)
 		}
 	}
 
-	argc -= optind;
-	argv += optind;
 	optind = 0;
 
 	memset(&cp, 0, sizeof(cp));
@@ -3258,7 +3251,7 @@ static void cmd_unpair(int argc, char **argv)
 	struct mgmt_cp_unpair_device cp;
 	uint8_t type = BDADDR_BREDR;
 	int opt;
-	uint16_t index = mgmt_index;
+	uint16_t index;
 
 	while ((opt = getopt_long(argc, argv, "+t:h", unpair_options,
 								NULL)) != -1) {
@@ -3447,8 +3440,6 @@ static void cmd_irks(int argc, char **argv)
 		}
 	}
 
-	argc -= optind;
-	argv += optind;
 	optind = 0;
 
 	cp->irk_count = cpu_to_le16(count);
@@ -4819,8 +4810,11 @@ static void cmd_add_adv(int argc, char **argv)
 		memcpy(cp->data + 2, uuids, uuid_bytes - 2);
 	}
 
-	memcpy(cp->data + uuid_bytes, adv_data, adv_len);
-	memcpy(cp->data + uuid_bytes + adv_len, scan_rsp, scan_rsp_len);
+	if (adv_len)
+		memcpy(cp->data + uuid_bytes, adv_data, adv_len);
+
+	if (scan_rsp_len)
+		memcpy(cp->data + uuid_bytes + adv_len, scan_rsp, scan_rsp_len);
 
 	if (!mgmt_send(mgmt, MGMT_OP_ADD_ADVERTISING, index, cp_len, cp,
 						add_adv_rsp, NULL, NULL)) {
@@ -5241,8 +5235,11 @@ static void cmd_add_ext_adv_data(int argc, char **argv)
 		memcpy(cp->data + 2, uuids, uuid_bytes - 2);
 	}
 
-	memcpy(cp->data + uuid_bytes, adv_data, adv_len);
-	memcpy(cp->data + uuid_bytes + adv_len, scan_rsp, scan_rsp_len);
+	if (adv_len)
+		memcpy(cp->data + uuid_bytes, adv_data, adv_len);
+
+	if (scan_rsp_len)
+		memcpy(cp->data + uuid_bytes + adv_len, scan_rsp, scan_rsp_len);
 
 	if (!mgmt_send(mgmt, MGMT_OP_ADD_EXT_ADV_DATA, index, cp_len, cp,
 					add_ext_adv_data_rsp, NULL, NULL)) {
-- 
2.34.1

