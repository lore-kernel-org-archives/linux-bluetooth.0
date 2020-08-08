Return-Path: <SRS0=i5J1=BS=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D56C433DF
	for <linux-bluetooth@archiver.kernel.org>; Sat,  8 Aug 2020 19:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 267D82067D
	for <linux-bluetooth@archiver.kernel.org>; Sat,  8 Aug 2020 19:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596915021;
	bh=2226bEyerzItLybHMBlj5sXan6LT38jfwU0O6wIhD/s=;
	h=From:To:Subject:Date:List-ID:From;
	b=NtY5knDgtteTqKzs8qN3VnxC4dTFm6PO6wBSOspIxKp3bpHPRRegjZvd3LPft3OhL
	 ciUprm8v8kNYVlsI0YhQvxHf2M7bDYcWMwho9NwhvYnJzqkpYGEaMbeNBvLLioJ3ak
	 lG8ym3krNO68paKt+PVeCDInl/ZL0jFbHlDjXL2c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbgHHTaU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 8 Aug 2020 15:30:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:48992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726232AbgHHTaT (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 8 Aug 2020 15:30:19 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0FEF2067D
        for <linux-bluetooth@vger.kernel.org>; Sat,  8 Aug 2020 19:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596915019;
        bh=2226bEyerzItLybHMBlj5sXan6LT38jfwU0O6wIhD/s=;
        h=From:To:Subject:Date:From;
        b=Il2yOt84oi1WlbuJrm7R64bqyQy4ObzqfSbUpG4wdOCGui1xcwsMQrGat5g8yOc7/
         Nz9NOV10GCEmOqmOnVmoYsbJAQ2iU2VOktnKuAbcnyfhF2S0yeL2+Wp4g7KO9+hpAr
         1ZmLPvUUtPG1UbF/5DoLqgkbGN+zcEiHyD3olYnI=
Received: by pali.im (Postfix)
        id DEF725FD; Sat,  8 Aug 2020 21:30:16 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] sbcenc: Add missing error check for unsupported sample rates
Date:   Sat,  8 Aug 2020 21:30:14 +0200
Message-Id: <20200808193014.28951-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 src/sbcenc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/sbcenc.c b/src/sbcenc.c
index dabdff4..2a4c240 100644
--- a/src/sbcenc.c
+++ b/src/sbcenc.c
@@ -105,6 +105,10 @@ static void encode(char *filename, int subbands, int bitpool, int joint,
 		case 48000:
 			sbc.frequency = SBC_FREQ_48000;
 			break;
+		default:
+			fprintf(stderr, "Unsupported sample rate %ukHz\n",
+					BE_INT(au_hdr.sample_rate));
+			goto done;
 		}
 
 		srate = BE_INT(au_hdr.sample_rate);
-- 
2.20.1

