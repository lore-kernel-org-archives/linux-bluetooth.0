Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD6A9C001DF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Aug 2023 00:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbjHDAL2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Aug 2023 20:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbjHDAL0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Aug 2023 20:11:26 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEBEB420E
        for <linux-bluetooth@vger.kernel.org>; Thu,  3 Aug 2023 17:11:23 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-63d03d3cac6so8587956d6.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Aug 2023 17:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691107882; x=1691712682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y55Yg/C7ifA7uYXM7obeHwISK1JjvWlPYwGVPva4JEs=;
        b=SWpZupy4UCPkqDyJ3j34KE9HLpSfJmwvXDMf/I+ggGna0CcpDaD520ppQGD7tEt7gw
         z6rrkoh9h3PdDW0D/kdefLWTiBrV75GKLzd8ZWz8leMPMMt8ZyougiUCWli9nrxrW9LY
         ooF3elYCif3F+JPcVMHpNQT+fk6FXu+/nHAy2/cAHbHC1roMkcHw8OlreAt2faJhoxYH
         w21diB9BMlL14Byb6WSPW/+NRl/S+vxVoYmRu4wbXHuxUILKgEMkxPzQu+XE6An9ZXZj
         CNQkL7hxNB1hU9COxMji/RCH0T38HRSutHKrKgwoDVEIESzv9+r5DP0yf04CY0rTWPI0
         4Hww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691107882; x=1691712682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y55Yg/C7ifA7uYXM7obeHwISK1JjvWlPYwGVPva4JEs=;
        b=Tk0j8LduFh/O4exziTTMdkRQxjajFWIF20s8QESyaZ+LjX9F6Ij0HzrRYX7NqydjpM
         n1QZbwb4OL54nMYP/zk34Qbht+TnpN7RCZ4dzvX0ho6kOdtz9zcL0eAlnEaeEgCEzCgn
         4O6cvU9dH4/Tmpg55ehFocgn+Q/3U6MEeYtx46fF1szRPdS0Q73bin5Rq33B3TpQKMdD
         hh0lDqV9PBULWOUTWkzfqdlO4jz8xs80MONjso0MenM2IWKbRQ6tu8HAypftGSGQK/tY
         SOWBpx8mws3pKVA19sgf8VkAqIyoPuVQ2BkUNi6tIFcZD4QHAeAGc9g+U+LIIQIAnl5N
         kCTw==
X-Gm-Message-State: AOJu0Yx4h0t68nuaK/7VyeMJZt3ex7/J6GyWx72HTRj5HcMCQML26E/A
        AvredXEFiKZ+9O24O3+rjPysLLGCdN0=
X-Google-Smtp-Source: AGHT+IEANTOTi/hzAGo6W4FCN923h1viwj4tro40Xfw9CJc6hq8ErgnGzd1FjbvJ95+Anki77E0xUA==
X-Received: by 2002:ad4:4e82:0:b0:636:955e:3dd7 with SMTP id dy2-20020ad44e82000000b00636955e3dd7mr164880qvb.42.1691107882256;
        Thu, 03 Aug 2023 17:11:22 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-236-201-58.hsd1.or.comcast.net. [71.236.201.58])
        by smtp.gmail.com with ESMTPSA id y11-20020a0ce04b000000b0063c6c7f4b92sm272448qvk.1.2023.08.03.17.11.20
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 17:11:21 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 3/5] Bluetooth: ISO: Fix not checking for valid CIG/CIS IDs
Date:   Thu,  3 Aug 2023 17:11:13 -0700
Message-ID: <20230804001115.907885-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230804001115.907885-1-luiz.dentz@gmail.com>
References: <20230804001115.907885-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Valid range of CIG/CIS are 0x00 to 0xEF, so this checks they are
properly checked before attempting to use HCI_OP_LE_SET_CIG_PARAMS.

Fixes: ccf74f2390d6 ("Bluetooth: Add BTPROTO_ISO socket type")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/iso.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 358954bfbb32..6b66d6a88b9a 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1187,6 +1187,12 @@ static bool check_io_qos(struct bt_iso_io_qos *qos)
 
 static bool check_ucast_qos(struct bt_iso_qos *qos)
 {
+	if (qos->ucast.cig > 0xef && qos->ucast.cig != BT_ISO_QOS_CIG_UNSET)
+		return false;
+
+	if (qos->ucast.cis > 0xef && qos->ucast.cis != BT_ISO_QOS_CIS_UNSET)
+		return false;
+
 	if (qos->ucast.sca > 0x07)
 		return false;
 
-- 
2.41.0

