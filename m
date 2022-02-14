Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 141AAC433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Feb 2022 09:13:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235950AbiBNJN7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Feb 2022 04:13:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbiBNJN6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Feb 2022 04:13:58 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B86860068
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Feb 2022 01:13:51 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id m10-20020a25800a000000b0061daa5b7151so32551504ybk.10
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Feb 2022 01:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=qOJUau3R9DNwghj7AGgRGxzrrSvkfkutzqGQ8LXl1n4=;
        b=WiqoSzc/MoHiP8/Y2wi9GAOycBK62nhA2OMYTU9WGBK1hT3n9E0VLIStOJKRL3jUFq
         k3JCmQH83bsW1xK3ocehxZd8vEZgkorBAgc19FRMvT0Mbo7zvs3bITzF3wEXLCKdytOa
         HOM0IyGzVu9ONxgGFuAUZ/EIbzjep+rUkc9h7oh5h+Vsg62jI+nwVypS9O4EtjFDh/C9
         S5SmLvvwi6ybjIj0SxEGLribnBtD/m32Jh8eiOSoWLQnH7/q6xBzu+Ggba3S0rLqW+cX
         gHRyKQt3s8N3PvV+8o5qlG2Gw9jZcExB+UjL/ZWbfv1SOA0LT9l/judDs4i/f0KOiIbe
         paww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=qOJUau3R9DNwghj7AGgRGxzrrSvkfkutzqGQ8LXl1n4=;
        b=itABWM5DzYzn4xTFSHjuEQackWWnCTamPA8/eAwsqVEeFN8sK46UJyzOgAxLAqdlAL
         lK+wRxtDy8I6Ns8fC6Roeq7B4n4iw2sixagm9nM27K1oXvwsCDke46eus/NkSkfHRdlM
         hOPE8nNTA6lv0/JXJxLxeeemZuX0n5hCIldEc/FafCrV3mlu7GQnpwX0khwmhtqKAKqA
         8pzU0UjtDIW7Qewov7DK7v38GOuyMu+r1bzIsnRhYj6DkarqX2yZcN49Qe3fPWYfFEmp
         fzSZEITg3diUbDjXy8zvaWSSEMi7k6z4tDPIXstqcHq9klEI3PbskPWqfzYa8LmoWgrt
         Uaeg==
X-Gm-Message-State: AOAM532j6Zy9uT31cZDdONj0SpQg07MXh7NZ0U5aiNwhifJaRjMAUFjs
        5PRWHpjXB5HqiPkTf9Ms+toL8ZmQgq5N+QjYeRlZ25xzf9+wL2DCgDsBGHvDC45eukwvtnNvpcP
        wOBlLvV1Rf8pDYH4fSm1GDtZXJTZAdw1LwYuUn+gDh9hWZ8KntWW5fdTudlXmHkCFZ4SIPyHBPr
        l4pZNLoIOmBxI=
X-Google-Smtp-Source: ABdhPJxFt9pV0EmvxqByMpEOPrS5id8EWfl4U3c2tkhTg7KCvi5Uleeg7SBLBLqS70Htzpd6oZZyzKfFsenfMHtxHA==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:b204:5f3:5b41:e9f])
 (user=howardchung job=sendgmr) by 2002:a25:d512:: with SMTP id
 r18mr11563551ybe.87.1644830030294; Mon, 14 Feb 2022 01:13:50 -0800 (PST)
Date:   Mon, 14 Feb 2022 17:13:43 +0800
Message-Id: <20220214171329.Bluez.v1.1.I8c72b5af2506378bba6da369228ae50483231e35@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: [Bluez PATCH v1] lib: fix hci_strtolm crash
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc:     Yun-Hao Chung <howardchung@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Yun-Hao Chung <howardchung@chromium.org>

|str| can be NULL in the case of reading lm value. Calling strcasestr
could lead to a crash.

Reviewed-by: Archie Pusaka <apusaka@chromium.org>
---
Verified by running "hciconfig hci0 lm" on hatch

 lib/hci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/hci.c b/lib/hci.c
index 5141f20ac..5228c2ad2 100644
--- a/lib/hci.c
+++ b/lib/hci.c
@@ -323,7 +323,7 @@ int hci_strtolm(char *str, unsigned int *val)
 	int ret = hci_str2bit(link_mode_map, str, val);
 
 	/* Deprecated name. Kept for compatibility. */
-	if (strcasestr(str, "MASTER")) {
+	if (!!str && strcasestr(str, "MASTER")) {
 		ret = 1;
 		*val |= HCI_LM_MASTER;
 	}
-- 
2.35.1.265.g69c8d7142f-goog

