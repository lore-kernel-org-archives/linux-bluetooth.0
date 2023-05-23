Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C49D2C77B75
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 May 2023 17:49:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237576AbjEWRtj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 May 2023 13:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237601AbjEWRtc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 May 2023 13:49:32 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12EBB19B
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 May 2023 10:49:10 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-7748edd6c87so1581039f.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 May 2023 10:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684864148; x=1687456148;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=EE/b2plJUzly6mj8iD1XqeQ5YtfmQN0MS5ML9oVAnFs=;
        b=lSi37r8vDuobMuD6i1lAkhDiLjXC3eUHmI/i+DhmgcE9iDIheap3XZIZJlMjYCUZUh
         0jP/7cmN3k/2mtBJcTSSmTxSGl+c7laK0nNFc19xoyxmeFAuM+EExpyWqCW5+cWk69ku
         lsPKhgmnYtyezwU6oMh8EHOnPMtskg7P1aO6/he2l8rWhsM022MfMMsLJuJIsIZVXCgr
         fQVdY4skIUkNrjEJXXsELJiZgUfeqsf2j8CLzeuufgU0T/OHEaIrbFVC5isfi90dx8rU
         JrmHKxohlGENsCOgoYxCG4dX+NNhxCDd5B+X890jAFsA8ehEd+gaoWexjmvanF0OGfZ0
         3Urg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684864148; x=1687456148;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EE/b2plJUzly6mj8iD1XqeQ5YtfmQN0MS5ML9oVAnFs=;
        b=A8y3AHHHZOzjK8/Fp+qFe57d8MLtHrPV9Ie40MUcN9iKIBdRXKCz4Br/8bcNGIA5bJ
         HAOSrN09SVdIUQw1C812nAQPd21THUw2h1IC5H2yCaGcThRP5JKCIxDO1mf3J6UY8QuE
         iU8+tI9QwLSq8U158TH9XYYGRHuYB8G4/KyzMm5+gVQFhyA4vW56XtMcyBLbm5aptPia
         g3GWtsRb02VI6LfT6EzYbzQbLKJVvxjCuFv7rWoHoXt7bELUB8EBT/96RM2nPbBtLtns
         aLG/c2N81tFCZLSxDYqaY4miDd47vroDQm1E1EaLInzAZ3Blt4Cc6HkYPO2MpWIDn1v1
         5aEw==
X-Gm-Message-State: AC+VfDz7TQ9zYI8p5xh1pb2XsHnVUc9VNR0nnVaoI2bCFdU1jsQG0Fur
        gCh6ilSB7PGq6gmtakq/orKQ6qa41qM=
X-Google-Smtp-Source: ACHHUZ6LBBHtKmByPACGXtCz2kT4uLd4mrT6+K3dJTPVfFXqC7mZyUObbQ/EtNHsnwGok3ZqWdpA5A==
X-Received: by 2002:a5d:924c:0:b0:76c:6674:243b with SMTP id e12-20020a5d924c000000b0076c6674243bmr9191019iol.15.1684864148383;
        Tue, 23 May 2023 10:49:08 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id u27-20020a02cb9b000000b00411be337516sm2664573jap.24.2023.05.23.10.49.07
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 10:49:07 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] iso-tester: Make QoS parameters reflect the tests names
Date:   Tue, 23 May 2023 10:49:06 -0700
Message-Id: <20230523174906.2751379-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

AC 1 + 2 tests shall use their respective QoS parameters.
---
 tools/iso-tester.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index c59d12ef4ba6..63c37bd52161 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -101,6 +101,9 @@
 #define QOS_IN_1(_interval, _latency, _sdu, _phy, _rtn) \
 	QOS_FULL(0x01, BT_ISO_QOS_CIS_UNSET, \
 		QOS_IO(_interval, _latency, _sdu, _phy, _rtn), {})
+#define QOS_IN_2(_interval, _latency, _sdu, _phy, _rtn) \
+	QOS_FULL(0x02, BT_ISO_QOS_CIS_UNSET, \
+		QOS_IO(_interval, _latency, _sdu, _phy, _rtn), {})
 #define QOS_IN_1_1(_interval, _latency, _sdu, _phy, _rtn) \
 	QOS_FULL(0x01, 0x01, \
 		QOS_IO(_interval, _latency, _sdu, _phy, _rtn), {})
@@ -148,8 +151,12 @@
 
 /* One unidirectional CIS. Unicast Server is Audio Sink */
 #define AC_1_4 QOS_OUT(10000, 10, 40, 0x02, 2)
+/* One unidirectional CIS. Unicast Server is Audio Sink CIG 0x01 */
+#define AC_1_4_1 QOS_OUT_1(10000, 10, 40, 0x02, 2)
 /* One unidirectional CIS. Unicast Server is Audio Source. */
 #define AC_2_10 QOS_IN(10000, 10, 40, 0x02, 2)
+/* One unidirectional CIS. Unicast Server is Audio Source CIG 0x02 */
+#define AC_2_10_2 QOS_IN_2(10000, 10, 40, 0x02, 2)
 /* One bidirectional CIS. Unicast Server is Audio Sink and Audio Source. */
 #define AC_3_5 QOS(10000, 10, 40, 0x02, 2)
 /* Two unidirectional CISes. Unicast Server is Audio Sink.
@@ -552,20 +559,6 @@ static const struct iso_client_data connect_1_16_2_1 = {
 	.expect_err = 0
 };
 
-static const struct iso_client_data connect_ac_1_2_cig_1_2 = {
-	.qos = QOS_1_16_2_1,
-	.qos_2 = QOS_2_16_2_1,
-	.expect_err = 0,
-	.mcis = true,
-};
-
-static const struct iso_client_data connect_ac_1_2 = {
-	.qos = QOS_16_2_1,
-	.qos_2 = QOS_16_2_1,
-	.expect_err = 0,
-	.mcis = true,
-};
-
 static const struct iso_client_data connect_1_1_16_2_1 = {
 	.qos = QOS_1_1_16_2_1,
 	.expect_err = 0
@@ -918,6 +911,20 @@ static const struct iso_client_data connect_ac_11ii = {
 	.defer = true,
 };
 
+static const struct iso_client_data connect_ac_1_2 = {
+	.qos = AC_1_4,
+	.qos_2 = AC_2_10,
+	.expect_err = 0,
+	.mcis = true,
+};
+
+static const struct iso_client_data connect_ac_1_2_cig_1_2 = {
+	.qos = AC_1_4_1,
+	.qos_2 = AC_2_10_2,
+	.expect_err = 0,
+	.mcis = true,
+};
+
 static const struct iso_client_data bcast_16_2_1_send = {
 	.qos = QOS_OUT_16_2_1,
 	.expect_err = 0,
-- 
2.40.1

