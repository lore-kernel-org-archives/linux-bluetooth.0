Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C340C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Mar 2022 20:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbiCUU47 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Mar 2022 16:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbiCUU46 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Mar 2022 16:56:58 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42891965FE
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Mar 2022 13:55:32 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id h63so18147933iof.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Mar 2022 13:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=xyfQ12nt6pG22SvHBM0vQh87QLNHiLdGosvvjZins0w=;
        b=NdZeFJwrqmAhFDCjqERExoYSX/4x06PpbqJp6YPIeBKIa6uW2PXMYZ8+lsKTHO89Y8
         N4NuACeJxBOZ8c5cOdYIJ+ENbzP1IfAptDg9SEcjNaY3aAMyYiPigAqbEPPLppWKUgHF
         Rh8zLoNkEJFe4r9cVRwwcvPkpi0CfCAwqJHq74mvhUNdL3Gl4uCwPUI8DG++XZg+6x/k
         cBieF/mtTq3jCUWZWFkJNmlxStG2rlYlId31WVDkNmvBZGnTnjZ54fV7FcjBqJMxg9P7
         ImFTr9AOsyHy9y4h2MavTdfYg1EAFZeEB2Be6N1q6/heQKFzs2hhpgKzLJb4EsItXdTm
         Fhpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xyfQ12nt6pG22SvHBM0vQh87QLNHiLdGosvvjZins0w=;
        b=ghyJYD119Pd1Q8cgGKhw0UJ6WP8VtB1z2Q1KO5X14WTipxgu88jJHq3tDbLy8Uy174
         Ev1isPz7DMqvybP+QV9xZa6sX3WPiOkG5kg8li/DEooU/lYooBXoBwS+9SxK7M8JGsjX
         YeY8Gpgm5UAaSzDCWsbmhDce2nFJWP/r5buh+O8Ed8lazBQlw6W3PmTMEFI+QLIwBVUY
         mgt+KkzDFAn53ySE/WFmgSJIdetpc5yMtYnpWcyFdgJpSZ5Linja6YdYoodxmJlKOjMf
         bWiP4NugDEr4zQ0bRGA/DA5T1GJb1MhHzki1BywEzlJxdm5oUfaA3LWDWkqagtXfK4lj
         j1rw==
X-Gm-Message-State: AOAM5327ubXT/9Q3n6c0JLvfuDakb17KkZthRsbG+pmDRBVp6Qnqh7ED
        CetmSaKMspjh41Q8kg0TgfnahIdjMHY=
X-Google-Smtp-Source: ABdhPJyzihnq2h5Yj9z8KnVV+sqEae1lCBn3/MJm6nzYDr7P2TrbTBh5VAGL2rNZVM6Y2CCwxjk4CA==
X-Received: by 2002:a05:6638:dca:b0:317:c2e0:180f with SMTP id m10-20020a0566380dca00b00317c2e0180fmr11811162jaj.161.1647896131980;
        Mon, 21 Mar 2022 13:55:31 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id q4-20020a056e0215c400b002c5fdff3087sm10962223ilu.29.2022.03.21.13.55.31
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 13:55:31 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/5] device: Don't use DBG in gatt_debug
Date:   Mon, 21 Mar 2022 13:55:26 -0700
Message-Id: <20220321205529.2469387-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220321205529.2469387-1-luiz.dentz@gmail.com>
References: <20220321205529.2469387-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

gatt_debug callback is used to print debug strings from bt_att which
includes the file and function names so using DBG would add yet another
set of file and function prefixes which makes the logs confusing.
---
 src/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/device.c b/src/device.c
index 3992f9a0c..96d939a53 100644
--- a/src/device.c
+++ b/src/device.c
@@ -5545,7 +5545,7 @@ static void gatt_client_service_changed(uint16_t start_handle,
 
 static void gatt_debug(const char *str, void *user_data)
 {
-	DBG("%s", str);
+	btd_debug(0xffff, "%s", str);
 }
 
 static void gatt_client_init(struct btd_device *device)
-- 
2.35.1

