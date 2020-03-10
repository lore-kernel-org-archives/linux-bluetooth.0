Return-Path: <SRS0=NTC4=43=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B8ECC10F27
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Mar 2020 17:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D09921D7E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Mar 2020 17:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r7qt/jS5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgCJREQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Mar 2020 13:04:16 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:37800 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbgCJREQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Mar 2020 13:04:16 -0400
Received: by mail-pj1-f66.google.com with SMTP id ca13so697725pjb.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Mar 2020 10:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2xM90dffTvLukV9Gy+9eaM+lQj47FbJNZsqqzLKTSQU=;
        b=r7qt/jS5sNy75rRoxrGZXLa+3WAMasn25TWz8OPwSTxUKbzbSb8PDcIGtgn10a9tVR
         LGHf+rnUZHlsStcn1Pf+LcGpjkHszWOgBk5EsW2pC0SR2IUw+cmx1evLhUAVRs4ope32
         harT4YqJ12TwfRJjy1LeJBRNgTlswIPWHgQ0RBL6iUzZzKoWSks7BqgehsKMeRC/VZYG
         nLnka1ntoQDCkOMQZnfFSBhuk/vH16z3hR3DeG/O9zfQ7wrxHf9hYt4BWi03sLlF2SSG
         Uo3thZijYht8W3xx4KmUiaVPDLwJcfTdju0VQ0i3/z6bLqhFi4mf4rg4LubsmikgcPSw
         d0bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2xM90dffTvLukV9Gy+9eaM+lQj47FbJNZsqqzLKTSQU=;
        b=m8bqtrJ1fH9/q2jvcrcjSZkoh4gvcVo7pnEbb6hTTtxaSm4VknQ4f2K27Kood0Ex0h
         YQSk5UInQ8Q31C5DfSpa1sbx94IfVG0pyzVKOMtME8ikUfbK8dvHHOCYsHPMiMAFLsXs
         kVzezLeCNzFLqlclOsxC+ofvKqRyAieiNHeFZ4kOI6eO4NY4F0volT0nSwHBKvB/BzbD
         khWvAVL8WA8bXds32qni8MgRz5C/89x+HO2S0d69SE8B38CPmeKurg46X1063xR/mKKw
         cy1QoLUa++MEfQmigk4u366QzjGMqw4pCUd6oFfQ/pu+NxOC4oLPR55DQLIfglBL3gz0
         FdOA==
X-Gm-Message-State: ANhLgQ0aM0VBlB20ZmtH4fxgX3PHzo9m8gtrIKWWukRg9IJI3CXgeLzO
        Ez6n1avx04Hq0UmX+yboSRGA2fdiHuY=
X-Google-Smtp-Source: ADFU+vsNz9ol3DJ8rnLwfrQAl94fhm8snE73QC29sttzP6/DptGoVEchmqIZi5l8rIJQBVGZzQw2pg==
X-Received: by 2002:a17:90a:a102:: with SMTP id s2mr2683518pjp.46.1583859852798;
        Tue, 10 Mar 2020 10:04:12 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id r24sm23077014pfg.61.2020.03.10.10.04.11
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 10:04:12 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] input: hog: Attempt to set security level if not bonded
Date:   Tue, 10 Mar 2020 10:04:10 -0700
Message-Id: <20200310170410.30897-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This attempts to set the security if the device is not bonded, the
kernel will block any communication on the ATT socket while bumping
the security and if that fails the device will be disconnected which
is better than having the device dangling around without being able to
communicate with it until it is properly bonded.
---
 profiles/input/hog.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/profiles/input/hog.c b/profiles/input/hog.c
index dfac68921..f0226ebbd 100644
--- a/profiles/input/hog.c
+++ b/profiles/input/hog.c
@@ -49,6 +49,8 @@
 #include "src/shared/util.h"
 #include "src/shared/uhid.h"
 #include "src/shared/queue.h"
+#include "src/shared/att.h"
+#include "src/shared/gatt-client.h"
 #include "src/plugin.h"
 
 #include "suspend.h"
@@ -187,8 +189,15 @@ static int hog_accept(struct btd_service *service)
 	}
 
 	/* HOGP 1.0 Section 6.1 requires bonding */
-	if (!device_is_bonded(device, btd_device_get_bdaddr_type(device)))
-		return -ECONNREFUSED;
+	if (!device_is_bonded(device, btd_device_get_bdaddr_type(device))) {
+		struct bt_gatt_client *client;
+
+		client = btd_device_get_gatt_client(device);
+		if (!bt_gatt_client_set_security(client,
+						BT_ATT_SECURITY_MEDIUM)) {
+			return -ECONNREFUSED;
+		}
+	}
 
 	/* TODO: Replace GAttrib with bt_gatt_client */
 	bt_hog_attach(dev->hog, attrib);
-- 
2.21.1

