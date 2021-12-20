Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1FE9C4332F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Dec 2021 23:59:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233226AbhLTX72 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 20 Dec 2021 18:59:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233050AbhLTX72 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 20 Dec 2021 18:59:28 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9CB5C061574
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Dec 2021 15:59:27 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id q17so9296308plr.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Dec 2021 15:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Y1ismcWgDnFFXISLA/l57y2B3Rq2xdUkaw18gPCSGm0=;
        b=Vjljshy56cUcnbVtMfk+9ILY7rRahEcV8IB+M6DcZrUB3Q7k9VHFfmHT1F6MvLudvt
         wJtwaGsi6xotpOF+JGi1faAZ8GqTjnSDoZNZktwKfyHNEgHmHK56W+OJLpQuapLlDKFD
         aQPiTpPzaa1ciO04pZDp5ZcqRmW/by+mjzV5/YLgtty8YnRECW67kENBPJHajDnBSaDi
         kY0RKEEatkkbKI2sv+6/vMY5lnJi0WRdH0Ch+NfPWI85IHC8+kKjUOYUWwiZo9Q0WFCn
         BihFk6pv3XC0/DaQqPT43gGnrGjasBYCEuJ1pQ54B109VybVmCLULvPcw9V7f7C7oDMm
         lIzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y1ismcWgDnFFXISLA/l57y2B3Rq2xdUkaw18gPCSGm0=;
        b=PgKo7aahDwnz5y4wGGe4f/e/5IYuyPdWRATzkfKcyh0zRxYP9ttZAplQC10qGW/ogI
         NksjyNC9igpo9iKx+f+SB3ZBJ933cDUGeUDKDHADVvhw918wJNoq727jzdl/6pyOP4wg
         1aBG/XP9ikfkQIEpbGv9PpwKjsX+kHt5cTgd5rEwJ4sgYCqDOY66+rgfvECm74zE0bhG
         XFOCOcYjYQZ/vHjNfUY6vGaJN11T6XQ25FPh5o+nd8PAboY/ZVvsF2GEBE2fGp+h4gUk
         pyEizRnDnCyUGbBXV+9QydrkxlY/VC4metNqImRx2HEbVvGE0j2Umoyzu4Q0JmhDiJUG
         +sRw==
X-Gm-Message-State: AOAM532F29TnN5EieNRHeE4lzrZYQ9f8qnHJUbAVkHRVuRXsQggwZpx3
        boH6MeUwpLxClzi0z2JLzzaTjZ5mu4I=
X-Google-Smtp-Source: ABdhPJxFpmYfCEP9+NDxlXhcUhg7Q36B6PhhZfptJ+UuV2kmyZB1J9i8Qdsyrg6yBBtj2upN3ckScw==
X-Received: by 2002:a17:903:24d:b0:143:beb5:b6b1 with SMTP id j13-20020a170903024d00b00143beb5b6b1mr663767plh.54.1640044767116;
        Mon, 20 Dec 2021 15:59:27 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id x9sm447263pjp.48.2021.12.20.15.59.26
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 15:59:26 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/3] bootstrap-configure: Enable sanitizer options
Date:   Mon, 20 Dec 2021 15:59:24 -0800
Message-Id: <20211220235924.349373-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211220235924.349373-1-luiz.dentz@gmail.com>
References: <20211220235924.349373-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes bootstrap-configure enables all sanitizers.
---
 bootstrap-configure | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/bootstrap-configure b/bootstrap-configure
index a34be8320..8172840d5 100755
--- a/bootstrap-configure
+++ b/bootstrap-configure
@@ -28,6 +28,9 @@ fi
 		--enable-btpclient \
 		--enable-logger \
 		--enable-pie \
+		--enable-asan \
+		--enable-lsan \
+		--enable-ubsan \
 		--enable-cups \
 		--enable-library \
 		--enable-admin \
-- 
2.33.1

