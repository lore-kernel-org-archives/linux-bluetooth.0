Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E58C74A44
	for <linux-bluetooth@archiver.kernel.org>; Sat, 11 Mar 2023 11:15:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjCKLPl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 11 Mar 2023 06:15:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjCKLPJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 11 Mar 2023 06:15:09 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320B91E9E8
        for <linux-bluetooth@vger.kernel.org>; Sat, 11 Mar 2023 03:14:12 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id cy23so30624495edb.12
        for <linux-bluetooth@vger.kernel.org>; Sat, 11 Mar 2023 03:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678533245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fqnFWHdK7OkL6s/x+Horh58nZE+IP653IunDnJQbJV4=;
        b=wn7FVQFl7D3LMIfw29Qi1jtJ1MVwkM0EDx7SDmMVlQpPZ5Z8OlHgNky0ImuXoqfRPH
         HOIBqaVfLiMYyvenIsfFpJilxjljVUcOfIlgnqBk+mRvo/SWhWQF64W2CdhCzeQ68l+c
         JLHt6bAMGJVOWiphYP/YUW7qz0QALjbqRPxYK8QTi4EL1dX4/vYfi145nYdkd5ioNFPx
         YcV3bsrvZ41Q6CCxd73yqKiSRoOL8cHmuIzg1R/Co0Y5ryPOtRY4bb72pGfD5Arr7eoq
         /i5vHp2yfNDSzSrc/YDFxPvyaX2mx/q7nkH/1KSTA46KnLsPcmcJgDngsRDyam/mWby1
         GFLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678533245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fqnFWHdK7OkL6s/x+Horh58nZE+IP653IunDnJQbJV4=;
        b=q3oKk7EkQOpOu8gaDmPeRt793scD/9IJ/LqrQ4npIAqaNQBXkhfDqVjzY/9ie0/4AO
         r1Zl2QPSth5oXyvEytDSI51BGo1YXO9fx7gH7H8lkiG4L7Gm4riR0uH315fCsIpJJGXd
         cqtYW2W7nn+PgFnkzrGbzGKOLZg28SjQOxUUP8xQaRO/oC1e6OQmERtshqc02taoKIx2
         OC/YT9dx4C0M2Zdjzmr8LGZtPzDqso/2I3ApztE8HgAmtOfSdUUWWvC7Mz6K72OGmcMl
         VoBHV7d9hNVd6spt8FKSetWbwX/ze6r2Sx2lBSbhO8yuOjmDCmHq1YswZyVoOgTCj29t
         0g5Q==
X-Gm-Message-State: AO0yUKW7ud4ra8E+mTufAnPst6qgJIq+1mbaKLF9YT8IM5Qwl18II+Q/
        9qxicwPZPBq45SgZQdtev/mFpw==
X-Google-Smtp-Source: AK7set8FKt7DgZJCxADdonM8M5e0Zncbtd5P2PQt9Jg/NcC9iy3KbzD1PtBGcdMWo1JVDQsA6rHrqQ==
X-Received: by 2002:a17:907:7f87:b0:881:44e3:baae with SMTP id qk7-20020a1709077f8700b0088144e3baaemr4671177ejc.54.1678533245427;
        Sat, 11 Mar 2023 03:14:05 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:fa97:2d7c:bdd7:e1b])
        by smtp.gmail.com with ESMTPSA id q12-20020a50c34c000000b004bf2d58201fsm1053859edb.35.2023.03.11.03.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 03:14:05 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/4] Bluetooth: btmrvl_sdio: mark OF related data as maybe unused
Date:   Sat, 11 Mar 2023 12:13:52 +0100
Message-Id: <20230311111354.251316-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230311111354.251316-1-krzysztof.kozlowski@linaro.org>
References: <20230311111354.251316-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The driver can be compile tested with !CONFIG_OF making certain data
unused:

  drivers/bluetooth/btmrvl_sdio.c:43:34: error: ‘btmrvl_sdio_of_match_table’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/bluetooth/btmrvl_sdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index ba057ebfda5c..d76c799553aa 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -40,7 +40,7 @@ static struct memory_type_mapping mem_type_mapping_tbl[] = {
 	{"EXTLAST", NULL, 0, 0xFE},
 };
 
-static const struct of_device_id btmrvl_sdio_of_match_table[] = {
+static const struct of_device_id btmrvl_sdio_of_match_table[] __maybe_unused = {
 	{ .compatible = "marvell,sd8897-bt" },
 	{ .compatible = "marvell,sd8997-bt" },
 	{ }
-- 
2.34.1

