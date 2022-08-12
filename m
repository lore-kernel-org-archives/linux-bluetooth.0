Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5148C00140
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Aug 2022 22:39:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236951AbiHLWjs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 12 Aug 2022 18:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbiHLWjq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 12 Aug 2022 18:39:46 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE905142F
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Aug 2022 15:39:45 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id gj1so2221323pjb.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Aug 2022 15:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc;
        bh=Frthcr7PfiOJYR0LsEe4mwvwkCuYCUALSmcVnnuBhPI=;
        b=J1CV6e6ytoy593jasPDDEBsQIeh4XASMtQiUpHZn3BZuE2xiMRmhSB/9mPDo8/OsST
         HwbQhdIxhILyFFgxDWc/FJguHyr1JtJzgUdHUi6s9OqdbPCNnoCR30NHGQ3PiTFkFhwU
         +ngS1JuBNgFt0ZyBdQEg8NbnSqj6ykD5p7IQ48COl02BYw3hfCnNISsSHQvDffdm1DWN
         H8O4oqdRYHJO8q47aZRm1S/j/03opMrlodzn/dw54zmiZxdfcus88eE3n4cekqd5mgPs
         oTpZlVMmgMKQsij+D52F99NOu8omrgvbeu0n5C/w6GflpUbgGXWsLKUOJJYZhgfcNOiy
         n0Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc;
        bh=Frthcr7PfiOJYR0LsEe4mwvwkCuYCUALSmcVnnuBhPI=;
        b=dmyxKzOjiaZn9cpiC+245oUrpyFxGPQiIycShQpEId0vUzFgfIp8p1D9icwUR5nGlT
         phQ5HtNn6Kcn9EXvQPoCeifNFJS4mLIlYvH7E1BjYaks/a2ACz315Rp9Js94B6a9d/kH
         YH0d2rQtM/Jr9CdfJCFzMsRuTubniZiR+879zj/L3xamwSlrnttsanWI9TmyD1S2PWcF
         p+EqPNNJBgsmK/uJhPwJnFslsO+Ik+k9aj3NRtMgp1oWYO+oTaNsGkmyXWIEXEjK9PPZ
         KBaeJ9+QAKFbeLNeAT1hKNJ3grUgCoGaTk5I1MNVRk2NiV3kvEykecllyELmoOY9VEEz
         hhUQ==
X-Gm-Message-State: ACgBeo0cIov/hlsNsNEBgRJKF13BOTTxzC3Nle3mZ1/I1eEbbCgQpAOo
        wTxM97mKzthsESasYQQNeE9qTs0OZ6mkdA==
X-Google-Smtp-Source: AA6agR6iNwkC6cmw0j/VYK2/OCbykZ6rZeFO6KNSShQCO3NqYETqU8TEUaVudfO8VeBgj9RJBAm7Bw==
X-Received: by 2002:a17:903:285:b0:16e:dcb7:937a with SMTP id j5-20020a170903028500b0016edcb7937amr5953284plr.4.1660343984155;
        Fri, 12 Aug 2022 15:39:44 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id b13-20020a170903228d00b001714fa07b74sm2319009plh.108.2022.08.12.15.39.42
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 15:39:43 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: L2CAP: Fix build errors in some archs
Date:   Fri, 12 Aug 2022 15:39:39 -0700
Message-Id: <20220812223939.530428-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This attempts to fix the follow errors:

In function 'memcmp',
    inlined from 'bacmp' at ./include/net/bluetooth/bluetooth.h:347:9,
    inlined from 'l2cap_global_chan_by_psm' at
    net/bluetooth/l2cap_core.c:2003:15:
./include/linux/fortify-string.h:44:33: error: '__builtin_memcmp'
specified bound 6 exceeds source size 0 [-Werror=stringop-overread]
   44 | #define __underlying_memcmp     __builtin_memcmp
      |                                 ^
./include/linux/fortify-string.h:420:16: note: in expansion of macro
'__underlying_memcmp'
  420 |         return __underlying_memcmp(p, q, size);
      |                ^~~~~~~~~~~~~~~~~~~
In function 'memcmp',
    inlined from 'bacmp' at ./include/net/bluetooth/bluetooth.h:347:9,
    inlined from 'l2cap_global_chan_by_psm' at
    net/bluetooth/l2cap_core.c:2004:15:
./include/linux/fortify-string.h:44:33: error: '__builtin_memcmp'
specified bound 6 exceeds source size 0 [-Werror=stringop-overread]
   44 | #define __underlying_memcmp     __builtin_memcmp
      |                                 ^
./include/linux/fortify-string.h:420:16: note: in expansion of macro
'__underlying_memcmp'
  420 |         return __underlying_memcmp(p, q, size);
      |                ^~~~~~~~~~~~~~~~~~~

Fixes: 332f1795ca20 ("Bluetooth: L2CAP: Fix l2cap_global_chan_by_psm regression")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/l2cap_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 1c39fc40591b..1dc05c77c22f 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1992,12 +1992,12 @@ static struct l2cap_chan *l2cap_global_chan_by_psm(int state, __le16 psm,
 			src_match = !bacmp(&c->src, src);
 			dst_match = !bacmp(&c->dst, dst);
 			if (src_match && dst_match) {
-				c = l2cap_chan_hold_unless_zero(c);
-				if (!c)
+				c1 = l2cap_chan_hold_unless_zero(c);
+				if (!c1)
 					continue;
 
 				read_unlock(&chan_list_lock);
-				return c;
+				return c1;
 			}
 
 			/* Closest match */
-- 
2.37.1

