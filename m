Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8717C4332F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Mar 2022 20:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344561AbiCWUPV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Mar 2022 16:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244619AbiCWUPS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Mar 2022 16:15:18 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4AE8A31B
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Mar 2022 13:13:47 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id mp6-20020a17090b190600b001c6841b8a52so7450863pjb.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Mar 2022 13:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=/j7e/CWw6oRrnkQVp/KphTi81K+8ZW6pXdZNgewlKz0=;
        b=Ab0VD8ceTkG8fpaqCmLVSsw+gP7Cuuz1a+E+9+a4ewSr6wE9ouej2vV9h8tpCG2hta
         xjcuSbLHmY3tu86aSk4e4y3eO/PhUscZcoaQK0PFPrwoB1Qe7OIQhvQAK9WynytCg5F9
         YKvdZz4kZmOFF/ndCwHj9tVw+OTOKaZkXLnNc74HgabfQVG/+QaEG8A6FSDB+oHut35O
         e2oA7MyfigU8rsvnY2cT563PKIRK3yjygJLNIG6gQKRWIKi1pURPcfLIIln95190KxXF
         9+ZaS6VPRpchSw4z3OW16PD/dQldgVlM7U3z2DuCfHJjL6b8uy2g0S/J5bmMg2xC9SgK
         swNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/j7e/CWw6oRrnkQVp/KphTi81K+8ZW6pXdZNgewlKz0=;
        b=NJYsQc40VH7MO6uuQyXC+EiuDVSnhsnH9fvtm+elz/SE0Ebn5CICJIsBcZ+qbc7kEn
         uj3jlxDe4BuUXgAzME9UYR4fcz36lZhVaOhfQTPaxV8EahCk9HKv0VehAdeu4/oda+mr
         20grsXxcsSywNcTh8r1V1HYZbVV1b50C6pBsoPdPh5/hOM8BYBEGWbMaLNnWidM6V6kk
         Ja6Cfe8FEHCKMzE8Kk3ucd74BxvwOnaA7pY1YKYlN9PpsFYgpLcfrWfrnddWRPPm8U3f
         x8QwBYmPowLRuPrECkuDn5QpwbB+hNPp5b7Wj79+I49zdb3sRXOuxqaGDY3K+J6ZRE79
         umUw==
X-Gm-Message-State: AOAM531L/RCCEqL2nkU31F45LatJLknYLKQJAjJO5ZrYOOavdErPPc2x
        QiK3WdmIClYLmz3Da3R9nTLg3q1B6+A=
X-Google-Smtp-Source: ABdhPJw+1Wdv1daRIxzVok+heMtDU4AKn7MQCse4XXxDvs6s19AOnx1Fcg1bSwcAFxZ99AipdExgdQ==
X-Received: by 2002:a17:902:b7c2:b0:153:b7fb:14c3 with SMTP id v2-20020a170902b7c200b00153b7fb14c3mr1842601plz.134.1648066427068;
        Wed, 23 Mar 2022 13:13:47 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id m4-20020a17090a7f8400b001bef3fc3938sm478361pjl.49.2022.03.23.13.13.46
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 13:13:46 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 5/9] att: Log file and function names
Date:   Wed, 23 Mar 2022 13:13:37 -0700
Message-Id: <20220323201341.3596128-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220323201341.3596128-1-luiz.dentz@gmail.com>
References: <20220323201341.3596128-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds logging of file and function names.
---
 src/shared/att.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/shared/att.c b/src/shared/att.c
index 169f726e4..7344b0c46 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -308,10 +308,12 @@ static void att_log(struct bt_att *att, uint8_t level, const char *format,
 }
 
 #define att_debug(_att, _format, _arg...) \
-	att_log(_att, BT_ATT_DEBUG, _format, ## _arg)
+	att_log(_att, BT_ATT_DEBUG, "%s:%s() " _format, __FILE__, __func__,\
+		## _arg)
 
 #define att_verbose(_att, _format, _arg...) \
-	att_log(_att, BT_ATT_DEBUG_VERBOSE, _format, ## _arg)
+	att_log(_att, BT_ATT_DEBUG_VERBOSE, "%s:%s() " _format, __FILE__, \
+		__func__, ## _arg)
 
 static void att_hexdump(struct bt_att *att, char dir, const void *data,
 							size_t len)
-- 
2.35.1

