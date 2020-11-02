Return-Path: <SRS0=F55x=EI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C84C3C00A89
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Nov 2020 13:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73D872054F
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Nov 2020 13:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="YF8ux7ux"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725824AbgKBN1i (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 Nov 2020 08:27:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbgKBN1h (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 Nov 2020 08:27:37 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 775B2C0617A6
        for <linux-bluetooth@vger.kernel.org>; Mon,  2 Nov 2020 05:27:37 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id 126so17424107lfi.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Nov 2020 05:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=zbHMo4BUNx71IZo55HUEi+rmpDEOmOephdzmb49uG3w=;
        b=YF8ux7uxpJ5DYHRIIi+AtrzeKh2Ov0ukaZ1eW7oGezCsLlYY7Ei9E6TS1D26PSNInI
         2A+EkfT0ofBuWrGMCYbgTo6brtmbaGZNefXYTn4g14L61+U1u56qsOUdaro8nJVzzply
         247IonboN6LsFv0ZXGYSqJGylfPuSwx85C6Uw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=zbHMo4BUNx71IZo55HUEi+rmpDEOmOephdzmb49uG3w=;
        b=a0lZGK0GTypy4hPTdwa232P1Sbarg5sWSpiwEkzSwKVIkO4nhAghnGfE8UnwvDHE/i
         FOhH9qTlbhxiCNev5EXVw4SEHJhqGtF4f7BnBA61Ga17aImquiW2HBx2tBuWjB0jzYiq
         Whd5OcU+YkHp0bSVMoCKCMX0KslJrAf7hifB83v8ZYhOAOlfW80cVNiAI1Q9Bj6Clz/r
         Sp3DurMSSL3yBk+HG8UKNLZY2O7nRayUNQMijuVD4MweDIWcM9IGDVJfLG4c60HCZUAd
         1Okrc77rRaT2esFGYPNULktumCq0aqI7vrdEKrKk12HxmJjCQp7hcyqIaBkJO7aQuJEu
         ZvoA==
X-Gm-Message-State: AOAM532d5C9vcUxFleu++k9SnRHZn15pBSZvMkVpI6wrxOtPdV5GHhhx
        8eiqp/d2ILvlqdgxHnVkS9gyJv2UD62HbI8=
X-Google-Smtp-Source: ABdhPJz8EOY8ZNVW+LfbmOIn3YWD33mHXeNmBuBirsZqwKukuZuPKZZmxkvMGDHlXyT00bh3Gga/3g==
X-Received: by 2002:a19:68c:: with SMTP id 134mr6328897lfg.188.1604323655732;
        Mon, 02 Nov 2020 05:27:35 -0800 (PST)
Received: from jimmy-ryzen-home (c-8713e055.76534-0-69706f6e6c79.bbcust.telenor.se. [85.224.19.135])
        by smtp.gmail.com with ESMTPSA id i63sm2303115lfi.53.2020.11.02.05.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 05:27:34 -0800 (PST)
Date:   Mon, 2 Nov 2020 14:27:33 +0100
From:   Jimmy Wahlberg <jimmywa@spotify.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        johan.hedberg@gmail.com, davem@davemloft.net, kuba@kernel.org
Subject: [PATCH] Fix for Bluetooth SIG test L2CAP/COS/CFD/BV-14-C.
Message-ID: <20201102132733.GA77385@jimmy-ryzen-home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This test case is meant to verify that multiple
unknown options is included in the response.

Unknown options shall be in the response if
they are not hints according to Bluetooth Core
Spec v5.2. See chapter 4.5 L2CAP_CONFIGURATION_RSP

Signed-off-by: Jimmy Wahlberg <jimmywa@spotify.com>
---
 net/bluetooth/l2cap_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 1ab27b90ddcb..16956f323688 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3627,7 +3627,7 @@ static int l2cap_parse_conf_req(struct l2cap_chan *chan, void *data, size_t data
 			if (hint)
 				break;
 			result = L2CAP_CONF_UNKNOWN;
-			*((u8 *) ptr++) = type;
+			l2cap_add_conf_opt(&ptr, (u8)type, sizeof(u8), type, endptr - ptr);
 			break;
 		}
 	}
-- 
2.25.1

Hi,

While running tests I encountered this one test that I could not pass. After some troubleshooting I landed in this patch. Please let me know what you think.

Best regards
Jimmy
