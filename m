Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55347C0015E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Jun 2023 21:26:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjFWV0r (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Jun 2023 17:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbjFWVYg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Jun 2023 17:24:36 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1CDE1FCE
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jun 2023 14:24:35 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b50394a7f2so7060375ad.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jun 2023 14:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687555474; x=1690147474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rp/ru7qYcdWmXC/qbmOwoVdMj0EeyzmUVpTC1B+bdQc=;
        b=jl2qQiWSD7wRM9jNT+MEZWmcte1yhdB8AkuWQyFZp8QiDOPkpx6miWk0bhMXPKxDaq
         a0eHti0eQyZYsOlMWGbqbSqmNNNSoWI2aUheaWyB0Z4eUrKGFHVPIQ7ns2Y00idFXGuE
         Z0lt9eYPvqhU3hHs98qn0EiizutctRxixCaHgGyF/cXGR0rX8HWTYn+EuY3ukzhHMI0Q
         iZUQgk/ief5tEP8RFMvNd7/aZs8v6vKBF61pah9riSuUmyDWlBYoS5SjzG5tjpO5BMqM
         3dNRVBLWHqD1XwXjib6qovnc5agmkZxmyiq7TZ1QCde46AQerkKsI9kdLDxB4GqraImf
         sBkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687555474; x=1690147474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rp/ru7qYcdWmXC/qbmOwoVdMj0EeyzmUVpTC1B+bdQc=;
        b=fRk/zVe8mlvMiTenEUkM18lFIqu0My0RKs84Br4EFinoMS7RzLhgCYo0Mtncj5YZbO
         OJrXVfMm3vzxy70GJ4/BBOgV7TIXKJX9T/fpPsEaE3NKYeDEbm1xtZ4JBtfNCXCetg6n
         XmfypNozUhsZD50L1OhXAxl5iCi9M4EX/3k5Ys5gl2QKHaE2T2XaWD3Dqd74N4mvfFL8
         3nSYvobXa1wqVIu2bHDBnqjYXwaSWbEXAxhq+kkYBtjio5+9VedOxvqpkUiY20sWsyFz
         h8+Ms05KbipLGaeX3Sl27Z0NLQh1sTFCMnUc1gVVJV/KY32xSDLXedvExSMARCxooKQ9
         A94w==
X-Gm-Message-State: AC+VfDznMgL2RNU/UJgWbTEKYLQJfWMImxZuBe9r45ZI+JGXvXXJSUdk
        BE0dVj1AUEfBSMrCoH+d/LhsQtzEk4x/TQ==
X-Google-Smtp-Source: ACHHUZ46CJLP1QQBXtqskYmKmfw99buKXwzx3HyJpMxE9rEi3q/E2J0Z1wmvb3ua6Mo6i51/hPcUhw==
X-Received: by 2002:a17:902:ecce:b0:1b5:561a:5ca9 with SMTP id a14-20020a170902ecce00b001b5561a5ca9mr312058plh.50.1687555474207;
        Fri, 23 Jun 2023 14:24:34 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id bb6-20020a170902bc8600b001b694140d96sm20481plb.170.2023.06.23.14.24.32
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 14:24:33 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] iso-tester: Fix checks of latency and interval
Date:   Fri, 23 Jun 2023 14:24:30 -0700
Message-Id: <20230623212430.1702254-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230623212430.1702254-1-luiz.dentz@gmail.com>
References: <20230623212430.1702254-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Due to rounding of latency, BAP uses msec while HCI uses slots of
1.25 ms, values may not return an exact match which is fine since the
BAP QoS suggests they are the maximum latency/interval so values bellow
that shall be considered a match.
---
 tools/iso-tester.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index d6c79db9072b..bbd5a47f6197 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -1480,14 +1480,14 @@ static int connect_iso_sock(struct test_data *data, uint8_t num, int sk)
 static bool check_io_qos(const struct bt_iso_io_qos *io1,
 				const struct bt_iso_io_qos *io2)
 {
-	if (io1->interval && io2->interval && io1->interval != io2->interval) {
-		tester_warn("Unexpected IO interval: %u != %u",
+	if (io1->interval && io2->interval && io1->interval > io2->interval) {
+		tester_warn("Unexpected IO interval: %u > %u",
 				io1->interval, io2->interval);
 		return false;
 	}
 
-	if (io1->latency && io2->latency && io1->latency != io2->latency) {
-		tester_warn("Unexpected IO latency: %u != %u",
+	if (io1->latency && io2->latency && io1->latency > io2->latency) {
+		tester_warn("Unexpected IO latency: %u > %u",
 				io1->latency, io2->latency);
 		return false;
 	}
-- 
2.40.1

