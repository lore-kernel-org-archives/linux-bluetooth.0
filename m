Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DABB8C636D3
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Jan 2023 18:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238149AbjA3Sjm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Jan 2023 13:39:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238367AbjA3Sj0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Jan 2023 13:39:26 -0500
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED405458BC
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jan 2023 10:38:42 -0800 (PST)
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by lahtoruutu.iki.fi (Postfix) with ESMTPS id 7349E1B001DD
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jan 2023 20:38:41 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1675103921;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4KtAWC244lJsYIhkxvCvI19oe6r2Hb0iG6ZLYhRq+XQ=;
        b=C7xF1n4rt+KDq7IlwC1PCiCd22kMATN1/fDuxodaaAzmkETIqiMUDLdc4rbw8quvp6BP4w
        fxaCLVeVuRg515m6p0sR/oFo0YvMkK8AqV3lli24EoFJrm0JMc24zt2JIJcJ1YhRN9Sqxx
        sns0BTyxRYwV5KCNL08AOkLZYFshi/sQvxmm466A7wsCzVbhwryVY4/+RFzUv4tfVl1yvZ
        AoAnCXLlCwsC5NTtFmdaFfkj2cy8pxGQI8exl/xOE2UlEt1HWuA9xs6hPA+R9NNVsB4GLR
        NwUOxqMfF+0TmjVR0NODBhO94qg3CefasQC+qPsRqawhzCz0XOPudUzfXTJpBQ==
Received: from monolith.lan (91-152-121-187.elisa-laajakaista.fi [91.152.121.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by meesny.iki.fi (Postfix) with ESMTPSA id 2CCFF2055D;
        Mon, 30 Jan 2023 20:37:55 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1675103875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4KtAWC244lJsYIhkxvCvI19oe6r2Hb0iG6ZLYhRq+XQ=;
        b=l4iOcjJ1yy0/nEECxNeePOCSqA+2+fiRIl5JCuhZrMA32CMdy0L6CBFA336MGJtMOBJLfd
        y0/5znnkc4vhB4yhZo53M+A7jbV/wM+KSWvQO61/MEkpmSHssLFRL/rS14lYmYbvaW6k3e
        jdKW2rc/OuZySKllJQqYB/CiniDakPo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1675103875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4KtAWC244lJsYIhkxvCvI19oe6r2Hb0iG6ZLYhRq+XQ=;
        b=MVmF8dF89++HjdL+zfwaTs6+qfDyEGqT+SON2nArnwGCYVe4cMOikbFR+/kiD65Gltibdr
        2n+9OljMYhcNeHbCk5QiZllGGMc67nnxWyecicPYqc+mmBKIcW9H1CtsqGPbpjuVAiBDRw
        nB07k7BSs/dPw5rskUxdC0z6ZmQbMlg=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1675103875; a=rsa-sha256; cv=none;
        b=dMNRkAWSbWnRcDAZWwNhv6RJ7IHjRSIrKlAR6MD9MI5DdOmHgVR4Ud1zbEl2ZFwowjoxIk
        t3Pa4Lkl6V1jx/C70Cvuy9rZl2pRjIzQ3xfcUHHAp6nqFW8YJT7U8HIzG8VIywGO/JkPcA
        EADwnS7Nk6yzVcqgErSIQow8f1+pnV0=
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 6/8] media: Check adapter CIS support to add BAP in SupportedUUIDs
Date:   Mon, 30 Jan 2023 20:37:37 +0200
Message-Id: <51806bcde7e2fe5a500023026d4ae68491c64bc2.1675103676.git.pav@iki.fi>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <a8aedc0f9a4c1e21d61694589c5b7a9f31cbedc1.1675103676.git.pav@iki.fi>
References: <20230127205205.20235-1-pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Don't indicate BAP support in SupportedUUIDs, if adapter supports
neither CIS Central nor Peripheral.
---
 profiles/audio/media.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index fbb350889..d68085514 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -1259,6 +1259,10 @@ static bool experimental_endpoint_supported(struct btd_adapter *adapter)
 	if (!btd_adapter_has_exp_feature(adapter, EXP_FEAT_ISO_SOCKET))
 		return false;
 
+	if (!btd_adapter_cis_central_capable(adapter) &&
+	    !btd_adapter_cis_peripheral_capable(adapter))
+		return false;
+
 	return g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL;
 }
 
-- 
2.39.1

