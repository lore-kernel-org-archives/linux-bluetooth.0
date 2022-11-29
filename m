Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6314C4332F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Nov 2022 20:46:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235990AbiK2UqF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 29 Nov 2022 15:46:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234423AbiK2UqD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 29 Nov 2022 15:46:03 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3392527B34
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Nov 2022 12:46:03 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id g10so14603476plo.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Nov 2022 12:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uipxcqFe+9TjstR7zL9pYMpnpbO4FjPsAnDw9doWmUg=;
        b=VuzLwGHu7NelXnYVXfw/9BgA6ker3L+99AXnn6WiwY9eRc3SNVNsHBqf91Q3Td7f/M
         3Fa3UeuCf1EgNvkNMuoX7TVhNHRx5NoW5WlAakA226BaP6q0wb75Mijo6/ey8pvTxkWO
         du0eu74Tz+fhCMLEte6Af+Gwr589zB9aQg0nvLRP2+1En9HmQ3xi8Q6wOCiCSDGQ3uPh
         zqOzl+ItnCx3YUaU2e1eO3vQaDiSralSqGkowu0LrpwDDBHmeW7m6SavdKXK/H3YObAN
         qWTEP9P8UDWEfcYNnW1pZxh4Gv3fOpY4Z9c8L6ElhR14rQflyGgHod8vswP7/oG5p7Kv
         0f+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uipxcqFe+9TjstR7zL9pYMpnpbO4FjPsAnDw9doWmUg=;
        b=l3F3mjQrHcCyhH3b3o5khcXvpg23r/PMuHjSz/htn1NFYyGCN+1aJdIgs00dhi3hOh
         Of8DgmNTUkS6Pmw8mIafho7Eb/eLhyQAtiTKfEVsWRbAPf2Uvi7kooQb8plvUHMg3vXO
         +w+KYi9TOebDp7M2IdSQuboAFassqFt5geV80yitcmrIrYDdm68JnYxM/FezAnUDm5ZU
         r2uVJ5TM9ac99bt+UkXqUBxPvouf9tbOj53purm2pbqZv5ENL1VVdK9RI9VhY+ztj8S7
         Lf4KjBOc9cLou/XcREew8iEplWqXdG2Mqy/fP3g8GKH80QN/t5/0khbex8ULLp3i5dtS
         rl7w==
X-Gm-Message-State: ANoB5pmikA7RuR29b+FzKykqfSoAF+XrGpo8A6K90rMqip3ovqGU/V0E
        qRJIwsY77MOxU6U1E3eBxQQTHjZUpWABmQ==
X-Google-Smtp-Source: AA0mqf7hjBMrL8YZazNgGgOR3omIM5fVv/6i+5PE6xhFtL/CQ7GKhx87CY+mL/6nKBGLVCNcbb84fg==
X-Received: by 2002:a17:902:aa07:b0:186:a97d:6bcc with SMTP id be7-20020a170902aa0700b00186a97d6bccmr39301765plb.121.1669754762181;
        Tue, 29 Nov 2022 12:46:02 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id i7-20020a17090332c700b001887e30b9ddsm11216214plr.257.2022.11.29.12.46.01
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 12:46:01 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/5] bap: Fix not able to reconfigure
Date:   Tue, 29 Nov 2022 12:45:55 -0800
Message-Id: <20221129204556.1535821-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221129204556.1535821-1-luiz.dentz@gmail.com>
References: <20221129204556.1535821-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

While attempting to configure QoS setting the request id is not reset
to 0 when a response is received which prevents any the QoS to be
reconfigured.
---
 profiles/audio/bap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 67aba3bd76d9..9cee9fd030da 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -366,6 +366,8 @@ static void qos_cb(struct bt_bap_stream *stream, uint8_t code, uint8_t reason,
 
 	DBG("stream %p code 0x%02x reason 0x%02x", stream, code, reason);
 
+	ep->id = 0;
+
 	if (!ep->msg)
 		return;
 
-- 
2.37.3

