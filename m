Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59912C0015E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Jul 2023 08:47:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbjGYIrE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Jul 2023 04:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbjGYIqi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Jul 2023 04:46:38 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137831FC6
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jul 2023 01:45:16 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-98dfb3f9af6so898302266b.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jul 2023 01:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1690274693; x=1690879493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GzUjLzohbNEhHgBw32hCU4RFlK69VEaX+mca/4cUI38=;
        b=yK8mDbabyNk46H0Ki6PqYbIO99oKb4YpVJOodRypP3hjXvp20VD6pKT8FKgWP3Xf3U
         YGRo9m2eXvpStj6fPw5qdaNusPVnJYAJOVPMrlRUSgtcU8V60xnbtgHCbowAfB3wm55e
         ika7iE2tX/fDLR7Drfhz8KcNwNWrKikLYtZcI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690274693; x=1690879493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GzUjLzohbNEhHgBw32hCU4RFlK69VEaX+mca/4cUI38=;
        b=Bvm+V096j+FDrl22zEPNJDK20tJDATTaaW2lf01vODcWnNZlYZ/VRxBdp+3reqTj/k
         Rtjn9Y+Qa83bT8Dn/j0dLGRD3Uul8yDLKiDo92K0IWawsLddCiKAOutsmbzar14E+2NT
         cJ25NuEcmePFT/zVU8qUm1u0ihMzYTYZKdagCA3fkRcL8YpPt8acR7WTbQj3xuNaneKg
         faqiuirKLYgiGdk8pBY2hexvgb3xvxzxeOVqFMxSm4K3FB7CMXQ9R7ZzD0XMYBYd2S92
         Gcmtm1d2g/TJbvkc4+dBHqW5IX2vJ9nVdJDukKO4cVeYcKg8K+AfvsmKR1ZamKdjnAA1
         Z2rQ==
X-Gm-Message-State: ABy/qLZdJN4o+Z+6SQoyoCAGKPXvZsNuIqRbV5L9KI7EWuzrGZYs9yyc
        h36YodKANKUuFWPh/3+4GZbJpnUAIxfSmaBWDPw=
X-Google-Smtp-Source: APBJJlHgLC2twt44z4jSuljYXXBWcgTxGLDlceQjTktWuqcBVe6nrUDHKp91E4CIa7e7mTyd+1Z06w==
X-Received: by 2002:a17:906:76cd:b0:993:f12a:39ce with SMTP id q13-20020a17090676cd00b00993f12a39cemr12803927ejn.15.1690274693115;
        Tue, 25 Jul 2023 01:44:53 -0700 (PDT)
Received: from Legionbuntu.. ([2a01:c846:10c0:200:ed64:7921:ba0:11aa])
        by smtp.gmail.com with ESMTPSA id n10-20020a170906164a00b00977cad140a8sm7866577ejd.218.2023.07.25.01.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 01:44:52 -0700 (PDT)
From:   Simon Mikuda <simon.mikuda@streamunlimited.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ 2/8] adapter: Be able to use ConnectDevice for discovered devices
Date:   Tue, 25 Jul 2023 10:44:25 +0200
Message-Id: <20230725084431.640332-3-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230725084431.640332-1-simon.mikuda@streamunlimited.com>
References: <20230725084431.640332-1-simon.mikuda@streamunlimited.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This can be useful when you want to specify trasport type for already
paired device (e.g. use LE transport for dual mode device).
---
 src/adapter.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 2679d4302..17f4a637d 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3763,9 +3763,6 @@ static DBusMessage *connect_device(DBusConnection *conn,
 	if (!bacmp(&addr, BDADDR_ANY))
 		return btd_error_invalid_args(msg);
 
-	if (btd_adapter_find_device(adapter, &addr, addr_type))
-		return btd_error_already_exists(msg);
-
 	device_connect(adapter, &addr, addr_type, msg);
 	return NULL;
 }
-- 
2.34.1

