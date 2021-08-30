Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC5DAC432BE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Aug 2021 19:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFA05604D7
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Aug 2021 19:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232493AbhH3Th4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Aug 2021 15:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbhH3Th4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Aug 2021 15:37:56 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F6EC061575
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Aug 2021 12:37:02 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id s16so17345145ilo.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Aug 2021 12:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=sef1AzHM+Rn2npDzc9uQlukq/aaMLJPU2TC+pPhlNNc=;
        b=CSPX4NrBRdjsHKfX1QZ1Kw+kCtrOKOnqxVED/917/UPzXEsoPmPIrRDPrmb52PRxRp
         q5eV37YsYGNl/yMr2ND0Gta3WdGh6VcAr209xByIJ64Dg8GYmqfFWNjY+XholzUhvN2P
         W8YmlbUXGSF2MbmrIrlf0QAmNwOproV05mQaELTCSeyxv4j2ba7t7lQ5OJ3ODX8nG3Px
         VXmGFzvCtSOrz+HneeksiA6noPdcngyQhaRes8qj2+jSbO6Hjt41lQ0S2se40N6M0kQU
         JzbD1z0h3ibXcp+aAJjQsMgSh+2IxZyTi9agh4/hzNEOJILGXBpi0QBvXC496tGSFbC4
         emLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=sef1AzHM+Rn2npDzc9uQlukq/aaMLJPU2TC+pPhlNNc=;
        b=kthV6W88aQs1z6LC7MhKzzElJV1Loh3u1vHu0UoO2ye3Ijky3x4eKlRdRxF2ofkkbz
         qjILuGhmkWqLZ7/uOCuywb0cZWzvAoGa9Kbw/C6fVepdhKHgYyimLEQQkJsa4nGbhCtV
         SHMZsjvBgJ9HbO9c92YofW0GRBW88Jfb3Hj59jiVzAuMCGgrGQFc8/UA/vph0NJZ55zY
         cwYuF0Y3BwR4Eq9NVl1xwc4DMcXjueICDoRdsAMgzhtrCIOdFJkNQahHbQtPqej8bFk1
         39RYkDSH1w5hux8v/A3REFrQkbyzvTvdCXnP8Z6H0FJnE74JnOMOh6b7FpRahDQ5TlEY
         m5uw==
X-Gm-Message-State: AOAM530Cz7g/YCZsOxiN//95/BlLdczHVArzW3m2Xckrj9XduytsKBr/
        wNJJbQd6/nnwW6L9vp3fg89InWdLtjY=
X-Google-Smtp-Source: ABdhPJwuCJy8tWuF+ovbvDh4yfFCRLVQfBwR47YOyYZz/BIPzS/GvcoBIe2t7jL4fNxUscOsYwql9w==
X-Received: by 2002:a05:6e02:b43:: with SMTP id f3mr4984915ilu.260.1630352221579;
        Mon, 30 Aug 2021 12:37:01 -0700 (PDT)
Received: from rechenknecht2k11 (200116b8450b3000528fd077fba667fc.dip.versatel-1u1.de. [2001:16b8:450b:3000:528f:d077:fba6:67fc])
        by smtp.googlemail.com with ESMTPSA id u15sm8657303ion.34.2021.08.30.12.37.00
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 12:37:01 -0700 (PDT)
Date:   Mon, 30 Aug 2021 21:36:55 +0200
From:   Benjamin Valentin <benpicco@googlemail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] sixaxis: Fall back to matching VID/PID for unknown devices
Message-ID: <20210830213655.16e6c37a@rechenknecht2k11>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Commit 61745d2bb made device matching stricter.
Before, a third party device would be matched according to it's
vendor / device ID only.

Now we require it's name to be in the list of known devices too,
so the name is retained later on.

This regresses unknown third-party devices that are not in the list
(as reported by [0]).

We can try to keep up by expanding the list, but let's also gracefully
fall back to vid/pid matching if there is a device that we don't know.

[0] https://www.reddit.com/r/archlinux/comments/pdvdfd/a_dirty_fix_for_ps3_controller_bluetooth/

Signed-off-by: Benjamin Valentin <benpicco@googlemail.com>
---
 profiles/input/sixaxis.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/profiles/input/sixaxis.h b/profiles/input/sixaxis.h
index ab8831995..db518997a 100644
--- a/profiles/input/sixaxis.h
+++ b/profiles/input/sixaxis.h
@@ -74,6 +74,7 @@ get_pairing(uint16_t vid, uint16_t pid, const char *name)
 		},
 	};
 	guint i;
+	const struct cable_pairing *best_match = NULL;
 
 	for (i = 0; i < G_N_ELEMENTS(devices); i++) {
 		if (devices[i].vid != vid)
@@ -81,13 +82,16 @@ get_pairing(uint16_t vid, uint16_t pid, const char *name)
 		if (devices[i].pid != pid)
 			continue;
 
-		if (name && strcmp(name, devices[i].name))
+		/* if the device is unknown, use the next best match */
+		if (name && strcmp(name, devices[i].name)) {
+			best_match = &devices[i];
 			continue;
+		}
 
 		return &devices[i];
 	}
 
-	return NULL;
+	return best_match;
 }
 
 #endif /* _SIXAXIS_H_ */
-- 
2.30.2
