Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF62C43217
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Dec 2022 16:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbiLAQJ6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Dec 2022 11:09:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231986AbiLAQJ4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Dec 2022 11:09:56 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D497B9560
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Dec 2022 08:09:55 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id f71-20020a25384a000000b006dd7876e98eso2047564yba.15
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Dec 2022 08:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FR107kANSLutJz1BILZr0Vl3fPpqLy52IrhEqRHOMyQ=;
        b=VatvvIrN09dR1CSWxH0S+f+Gf1FJKhx4zMQMkEY9vkbS0WkzHIJ5hINrvuRmVgUVXo
         QDOYQdZ/WW5+Ko31lb6PG3avxVVFmSJZZD02LQOf+FjzNW84bx5LTj5yblBeRKVVXGYc
         9qBojJK2TXko1EHCeT/uIDak6snGJqGFd9gbnTvkYx4P4Kopx8dmXY8rmvgEwl0NQvrk
         gA3+e9/GDZrEfCh9PYMp8EqOB8B8e6KXRq/DjIRlxig9LmliYBCsXDaz5Nl9IsfZDjHn
         psd611SHGiP5AO77RQvGKmEVOeP/GoRNO1Pzjs7iq2eW7zdWpVWF5rGrnYpzKMoQ5lt5
         BHUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FR107kANSLutJz1BILZr0Vl3fPpqLy52IrhEqRHOMyQ=;
        b=7KWvM4D0jgE+Jgx1iNrV0OnhVjz/9UzqTW2R5kmjnY0txIapalMOKwCiHADSD1eIXq
         JiIaKn4YiHuYTbLeO7AsT7UclI2AKTWEsNjzGKFqGQvoieWW6B1mWzbFuQwI7q3rJ4RB
         JcINuuoXYOK4fh9Npm6bHWHq5XOgq58jQI6nSTwsN8jpucj5rHNrZdl2qdL/AXoYCsBJ
         5Hmpr3fsc6G1cHRjrJprqMjbkeaD8YUGFP5idfPOzDaCw0ELN4qYgFPg3IpqaaKBw4DJ
         NR5LesyqdJwXCa9xgho39obLsU4wM6EN873Db85OgcrRf5n0yT75GHbA9N0QxAkpMgYv
         6Opg==
X-Gm-Message-State: ANoB5pmGuL1JY/yY2dy99CygTc/acqB/H4MWk7R+nFjXiXOWTPX08/6N
        NSCfpXj+ItPvyGzDPo+UiBRxEDJ/EPOrxJLFZg6+22PsFC8x0CqLyOM7w1ZnXaiaUyAsFr1EZHo
        ZsN/WJWt34nYhjzCH9Ms7OekOLSZxnvDJwgOhE4KZG2oJFx+n65dlqwrr1H9egWaUMYrkHslrkY
        Att/WGXw==
X-Google-Smtp-Source: AA0mqf79WxhM2fWLJG9nPbfPrTn1gZmpI8KAgG2ybNaY2pgR7rkX5ufwZPDH0A6w5fF+KIZqSxT7qOHPpxYakPo=
X-Received: from allenwebb.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:12e8])
 (user=allenwebb job=sendgmr) by 2002:a81:f80f:0:b0:38e:e541:d8ca with SMTP id
 z15-20020a81f80f000000b0038ee541d8camr60632998ywm.283.1669910994443; Thu, 01
 Dec 2022 08:09:54 -0800 (PST)
Date:   Thu,  1 Dec 2022 10:09:41 -0600
In-Reply-To: <20221201160941.1065499-1-allenwebb@google.com>
Mime-Version: 1.0
References: <20221201160941.1065499-1-allenwebb@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221201160941.1065499-2-allenwebb@google.com>
Subject: [PATCH BlueZ 1/1] bluetooth.ver: Export sanitizer symbols.
From:   Allen Webb <allenwebb@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Allen Webb <allenwebb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Fix llvm sanitizer support by not hidding sanitizer related symbols.
---
 src/bluetooth.ver | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/bluetooth.ver b/src/bluetooth.ver
index 214fa8a61..158627cc3 100644
--- a/src/bluetooth.ver
+++ b/src/bluetooth.ver
@@ -7,6 +7,12 @@
 		debug;
 		baswap;
 		ba2str;
+		/* Sanitizer support */
+		__asan*;
+		__lsan*;
+		__msan*;
+		__sanitizer*;
+		__ubsan*;
 	local:
 		*;
 };
-- 
2.38.1.584.g0f3c55d4c2-goog

