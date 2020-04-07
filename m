Return-Path: <SRS0=KN4I=5X=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45422C2BA1B
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Apr 2020 08:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 194E220748
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Apr 2020 08:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MwSfnbxb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbgDGI4m (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Apr 2020 04:56:42 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:41331 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgDGI4m (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Apr 2020 04:56:42 -0400
Received: by mail-pl1-f201.google.com with SMTP id u16so134699plq.8
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Apr 2020 01:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lM3d0cm86Nb/bkeV31ug0t8xTN773qSnytS58ID4fmU=;
        b=MwSfnbxbtCi7NUeb2ybu+8+EpQNsj4n8o3YC4LBPOjQKdYub2Fa97PCNRAw1WCAXkK
         kemZ7fmHPXqeXL4oxB9xumo+NdpNze+IHHvmXDkiauJNHdATDn/UMmhEsL1Jv+3oyWV/
         8S7I7Ou/EOpJSyvDIs6CZGV07nAtIFxKADpvEc1MiQNRSpaQ3MeLjiRLoIFiQPV8zbrb
         jf8y/7ZT5lhVuf9uACFmaKXJLFkjfR29DBEoCm/GfZA/Ij2CO4dcAE4e89MW4zHhvhBx
         JE1HGhcc9Sj5cN9kvXHR+b4Xpr1+txc0A9jGoVaAsSkDJSQvoFJjX1oLBRTpwNe/IVaD
         nf3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lM3d0cm86Nb/bkeV31ug0t8xTN773qSnytS58ID4fmU=;
        b=rXwA5jwdL+x92nV+iq6ehOd38gN4805+jK0VKcOzmwj26RskBvtGxaYSU3iHhySTPJ
         roWP45TY90Kwn+DUeUIiQstGHZnFiojsnFdCk40YKAZ9p5QAk219F/7wqpQwB9ARbmu6
         Fqz1p6H6lL3Njj8oVZRLJjwhjaZ1yiEfofUh6/7yGF0U8tIDNkLhuzN4oNii6FVzuNRV
         C9Lrk6bQlR24PMGEb3qWZxx46P9q8MvRjm3yHdy6m+ahqj9haxVKu67kEhbGXzJGweZP
         mEXq2MZnEW2csqeZdqxEy+CFXzAy9ZLOJT3J/r8gByagD9dBQI06iN+E9XcChkpioJwS
         KJNw==
X-Gm-Message-State: AGi0PuZu3bqZNWHc0MrPWcEWaFhjwcEm3RL6YNEJSyS0P4PGS0dDYXFk
        S6811B7IJKaZkX2VBo1pNXjuQIMu/B+5jtlEKoI3EjdiDk4504poQV59YKe0iAjaDzevI9/M3WK
        bNEv35h3lrAlHC+NrczUkUtn5aECc5MR7kgWuQP/GRhSLlVngxKDuAHADJBFBEkKpwLHqKzTJ35
        v4
X-Google-Smtp-Source: APiQypIMMNrQYxg3ncPXrJqdquFwU2eK5R2mMCr7GxUSItIET64/n1qEE810PBDPO/NGfZio7TjeeCnpHLqj
X-Received: by 2002:a17:90b:30f:: with SMTP id ay15mr1560079pjb.134.1586249799353;
 Tue, 07 Apr 2020 01:56:39 -0700 (PDT)
Date:   Tue,  7 Apr 2020 16:56:10 +0800
In-Reply-To: <20200407085610.231013-1-apusaka@google.com>
Message-Id: <20200407165521.Bluez.v4.4.I6813a39e5d8499d24471d7b575c7ef6c493a046c@changeid>
Mime-Version: 1.0
References: <20200407085610.231013-1-apusaka@google.com>
X-Mailer: git-send-email 2.26.0.292.g33ef6b2f38-goog
Subject: [Bluez PATCH v4 4/4] unit/test-gatt: Fix unknown request with signed bit
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

The BT spec doesn't make it explicit of what should happen when
receiving a bad signed att request packet.

According to BT core spec Vol 3, Part C, Sec 10.4.2:
A device receiving signed data shall authenticate it by performing
the Signing Algorithm. If the MAC computed by the Signing Algorithm
does not match the received MAC, the verification fails and the Host
shall ignore the received Data PDU.

According to BT core spec Vol 3, Part F, Sec 3.3
If a server receives a request that it does not support, then the
server shall respond with the ATT_ERROR_RSP PDU with the error code
Request Not Supported.

This patch does this two things:
(1) Removing the signed bit to the existing tests so they are not
    in a conflicting state within the bluetooth spec, while still
    keeping the original intent of the test.
(2) Add another test that purposely fall within this grey area
    with some comments.
---

Changes in v4:
- Fixing test-gatt.c

Changes in v3: None
Changes in v2: None

 unit/test-gatt.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 36dd2847c..139a6fc72 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -4473,16 +4473,38 @@ int main(int argc, char *argv[])
 			raw_pdu(0x18, 0x01),
 			raw_pdu(0x01, 0x18, 0x25, 0x00, 0x06));
 
-	define_test_server("/robustness/unkown-request",
+	define_test_server("/robustness/unknown-request",
 			test_server, service_db_1, NULL,
 			raw_pdu(0x03, 0x00, 0x02),
-			raw_pdu(0xbf, 0x00),
-			raw_pdu(0x01, 0xbf, 0x00, 0x00, 0x06));
+			raw_pdu(0x3f, 0x00),
+			raw_pdu(0x01, 0x3f, 0x00, 0x00, 0x06));
+
+	define_test_server("/robustness/unknown-command",
+			test_server, service_db_1, NULL,
+			raw_pdu(0x03, 0x00, 0x02),
+			raw_pdu(0x7f, 0x00),
+			raw_pdu());
 
-	define_test_server("/robustness/unkown-command",
+	/*
+	 * According to BT core spec Vol 3, Part C, Sec 10.4.2:
+	 * A device receiving signed data shall authenticate it by performing
+	 * the Signing Algorithm. If the MAC computed by the Signing Algorithm
+	 * does not match the received MAC, the verification fails and the Host
+	 * shall ignore the received Data PDU.
+	 *
+	 * However, according to BT core spec Vol 3, Part F, Sec 3.3
+	 * If a server receives a request that it does not support, then the
+	 * server shall respond with the ATT_ERROR_RSP PDU with the error code
+	 * Request Not Supported.
+	 *
+	 * Since there is no explicit instruction on what should be done in
+	 * case the server receives a bad signed unsupported request, here
+	 * we just ignore the received PDU.
+	 */
+	define_test_server("/robustness/signed-unknown-request",
 			test_server, service_db_1, NULL,
 			raw_pdu(0x03, 0x00, 0x02),
-			raw_pdu(0xff, 0x00),
+			raw_pdu(0xbf, 0x00),
 			raw_pdu());
 
 	return tester_run();
-- 
2.26.0.292.g33ef6b2f38-goog

