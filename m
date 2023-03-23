Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68187C7619A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Mar 2023 10:41:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbjCWKl6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Mar 2023 06:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbjCWKlh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Mar 2023 06:41:37 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DDB3B213
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Mar 2023 03:38:41 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id b20so51427363edd.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Mar 2023 03:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1679567919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IAjtHHkZIjXfehI7jKJJnTD5plU363jFhdvoTH8SNNQ=;
        b=UD1Y+30oZ0mDaqMoWRiCL7UWo+td3EIS/bc8rC+uvRfMOqDPKmZVEDpVztnL+0gOMX
         XE2fyThsKd1WgWsb8zvEZarM6le2af/rBjwBCyAH/ximXGdzgHLad+2gc3LvmMEdwYNv
         LjVovedNpM4H3VmHkwwTrWaTvtRR/s9SPZaUE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679567919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IAjtHHkZIjXfehI7jKJJnTD5plU363jFhdvoTH8SNNQ=;
        b=tQWCH0y0cplKTv54mPl8QWRJG6m8xkdXLjkYwBoRbfgP62XwZG3hvmm+7m1VLy5PNM
         tWZ/5rgx5ZbrIStM+a+3mSayRXLKVBV4754h/hU+7iOcGeJXd6lTg4TI+j1CKcQ6Y5q8
         RmoWKIuZfgOGktRmC4XVFmUzxJhLlOHrP/HkMHgp05cpK0FffUI/ia5kS2zo3GCNT5rQ
         KIOh2AwO78joYD82guqHOxQq3HnH6t2D0W4cTksQ5bajezBqLUeO+06CHHQ0aQlAD2GJ
         HXSbbqEWCIPPOmfDmN0Mb/kGS0HrQ41uYppyjPbTOZK4IlyS9wedSR/84ycKZ5lWKgwW
         DgGg==
X-Gm-Message-State: AO0yUKX7I9wwltukC/7MEtRpucpY3UmiobHJFTtvMsjnZAk4nJO3sDkZ
        BMfu0fOUztkZz9l9DBXkpf9f45OC6qDVLUurlSA=
X-Google-Smtp-Source: AK7set9ZEbOm4QWvfW1CW499GZmIXw19gzL2RZ3N20O6HaIZjian97SBB4jGZFZldB6AHaTcbul6Tw==
X-Received: by 2002:a17:906:3391:b0:932:748a:f0ea with SMTP id v17-20020a170906339100b00932748af0eamr10670022eja.63.1679567919528;
        Thu, 23 Mar 2023 03:38:39 -0700 (PDT)
Received: from smi-ubuntu.sueba ([2a01:390:0:101:4f8c:7da4:48b2:8bd2])
        by smtp.gmail.com with ESMTPSA id bv1-20020a170906b1c100b00939e76a0cabsm3513208ejb.111.2023.03.23.03.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 03:38:39 -0700 (PDT)
From:   Simon Mikuda <simon.mikuda@streamunlimited.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ 2/9] btgatt-client: Add option to connect to ATT over BR/EDR
Date:   Thu, 23 Mar 2023 11:38:28 +0100
Message-Id: <20230323103835.571037-3-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230323103835.571037-1-simon.mikuda@streamunlimited.com>
References: <20230323103835.571037-1-simon.mikuda@streamunlimited.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 tools/btgatt-client.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
index 58a03bd48..cce978869 100644
--- a/tools/btgatt-client.c
+++ b/tools/btgatt-client.c
@@ -35,6 +35,7 @@
 #include "src/shared/gatt-client.h"
 
 #define ATT_CID 4
+#define ATT_PSM 31
 
 #define PRLOG(...) \
 	printf(__VA_ARGS__); print_prompt();
@@ -1406,7 +1407,7 @@ static void signal_cb(int signum, void *user_data)
 	}
 }
 
-static int l2cap_le_att_connect(bdaddr_t *src, bdaddr_t *dst, uint8_t dst_type,
+static int l2cap_att_connect(bdaddr_t *src, bdaddr_t *dst, uint8_t dst_type,
 									int sec)
 {
 	int sock;
@@ -1419,8 +1420,9 @@ static int l2cap_le_att_connect(bdaddr_t *src, bdaddr_t *dst, uint8_t dst_type,
 		ba2str(src, srcaddr_str);
 		ba2str(dst, dstaddr_str);
 
-		printf("btgatt-client: Opening L2CAP LE connection on ATT "
+		printf("btgatt-client: Opening L2CAP %s connection on ATT "
 					"channel:\n\t src: %s\n\tdest: %s\n",
+					(dst_type == BDADDR_BREDR ? "BR/EDR" : "LE"),
 					srcaddr_str, dstaddr_str);
 	}
 
@@ -1433,7 +1435,10 @@ static int l2cap_le_att_connect(bdaddr_t *src, bdaddr_t *dst, uint8_t dst_type,
 	/* Set up source address */
 	memset(&srcaddr, 0, sizeof(srcaddr));
 	srcaddr.l2_family = AF_BLUETOOTH;
-	srcaddr.l2_cid = htobs(ATT_CID);
+	if (dst_type == BDADDR_BREDR)
+		srcaddr.l2_psm = htobs(ATT_PSM);
+	else
+		srcaddr.l2_cid = htobs(ATT_CID);
 	srcaddr.l2_bdaddr_type = 0;
 	bacpy(&srcaddr.l2_bdaddr, src);
 
@@ -1456,7 +1461,10 @@ static int l2cap_le_att_connect(bdaddr_t *src, bdaddr_t *dst, uint8_t dst_type,
 	/* Set up destination address */
 	memset(&dstaddr, 0, sizeof(dstaddr));
 	dstaddr.l2_family = AF_BLUETOOTH;
-	dstaddr.l2_cid = htobs(ATT_CID);
+	if (dst_type == BDADDR_BREDR)
+		dstaddr.l2_psm = htobs(ATT_PSM);
+	else
+		dstaddr.l2_cid = htobs(ATT_CID);
 	dstaddr.l2_bdaddr_type = dst_type;
 	bacpy(&dstaddr.l2_bdaddr, dst);
 
@@ -1482,7 +1490,7 @@ static void usage(void)
 	printf("Options:\n"
 		"\t-i, --index <id>\t\tSpecify adapter index, e.g. hci0\n"
 		"\t-d, --dest <addr>\t\tSpecify the destination address\n"
-		"\t-t, --type [random|public] \tSpecify the LE address type\n"
+		"\t-t, --type [random|public|bredr] \tSpecify the address type\n"
 		"\t-m, --mtu <mtu> \t\tThe ATT MTU to use\n"
 		"\t-s, --security-level <sec> \tSet security level (low|medium|"
 								"high|fips)\n"
@@ -1558,9 +1566,11 @@ int main(int argc, char *argv[])
 				dst_type = BDADDR_LE_RANDOM;
 			else if (strcmp(optarg, "public") == 0)
 				dst_type = BDADDR_LE_PUBLIC;
+			else if (strcmp(optarg, "bredr") == 0)
+				dst_type = BDADDR_BREDR;
 			else {
 				fprintf(stderr,
-					"Allowed types: random, public\n");
+					"Allowed types: random, public, bredr\n");
 				return EXIT_FAILURE;
 			}
 			break;
@@ -1616,7 +1626,7 @@ int main(int argc, char *argv[])
 
 	mainloop_init();
 
-	fd = l2cap_le_att_connect(&src_addr, &dst_addr, dst_type, sec);
+	fd = l2cap_att_connect(&src_addr, &dst_addr, dst_type, sec);
 	if (fd < 0)
 		return EXIT_FAILURE;
 
-- 
2.34.1

