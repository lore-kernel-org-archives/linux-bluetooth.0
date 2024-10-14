Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163C3231C9A
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Oct 2024 05:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728883393; cv=none; b=QgIk74DMHRyMDyHnS/eUyeIx8yYpEB2cYg6Uxe1nMOCIeqdAeOmu9p85KeurxPXupl7su2Zt9W2uZNPHZhHKSHeVkhXPB5T1RZqbvKWTh2LRulPsW8M5KXl8LOw0fC3K2A4f2lI1O3A5zmB6Qs7psIFGnyL//AIR2UbejNPxSL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728883393; c=relaxed/simple;
	bh=22rmkplHJOZuJfQerTHUr1KtHf0Zubet17D6hFOCe7o=;
	h=Message-ID:Date:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=HVeFE+Ba6NVeHIh/Aqu19W4G8kmP/1fhBdzzvCdPn+hIyCT3V70IR68YDcggiSAvs8w8W1fBH8urcpvV12J+0Tlgu9GL9UNGERIEgSMnU9nb6LnlrMAXlw5wVFQUFRXBDarVd0xL9x/rvhQ2mOpa/YnMdX10xPp+oqHAsK+BUFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BKEiuzA1; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BKEiuzA1"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e2fb304e7dso2161536a91.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 13 Oct 2024 22:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728883391; x=1729488191; darn=vger.kernel.org;
        h=content-disposition:mime-version:subject:to:from:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5cahgCFq8ehz8N/gd6lTB5/KBKLYT/QE1Od2NZO1lEw=;
        b=BKEiuzA1fqG3ng7bjEnPaOnBcOwB4LgTaXF8PNTugeC1ycQue40fprm5P3g0YtFEGE
         ikApWpZRtqlN9RM0Hwj5IYNdITPodJev8kAOfIJbGXoJPf30oGSOvaYmVjMwCdRnzP05
         LjCrvs/xlnoMpWXuiuj0TslFfTBF5o9VJcF/Mvz29g3CXNn5pWLzApj5vXIv7QatAy3I
         olN4vW41Pa4TJGA6CZTc44SwzsgsCcVPfYjFsyNb9nBEZs9fGEk6rc7QO6isEeswfoRy
         iPm7OtxQLABQR0LI29fOhKBsD4ykXO+CnR759y3Pc512xREAdiiYfokiDWwjOeL/kDIw
         MF3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728883391; x=1729488191;
        h=content-disposition:mime-version:subject:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5cahgCFq8ehz8N/gd6lTB5/KBKLYT/QE1Od2NZO1lEw=;
        b=czKfh3BiDl0dVLEBjutDfDn7pE2KuHmavwyK8u2GC36qP84jmEm4G1FM3dGl7dYNtM
         5KUnsN/iX5mPm+sVCmyDAjTgPacPv+IGmyZX/oOf3lcXAmhf4yzUUDdPaCNXJfoqbB9T
         5oNPZOFP0jO4ieYUsiZdV0Y1cmg0VQx6BkQsqPiS6VbeW4AL4vOBcqr4C1NehosS6xgo
         zOT52vKobpoHdTW13I9X6MLd74S8UHuKhO7fTssg2YZMNfrMqxHNAGbiSIL+kOS5Eg/N
         clKZHSRZM618CGw3QS7bmYH4jFbwD4RbpBYWwQTC4seKnWKi8Oe9ko+DZlm6jtGa4Cob
         XiSQ==
X-Gm-Message-State: AOJu0Yy2Jj5tf/+utaBTPWLaAU3MEZRkPab18rEst/kz/mDjr/0j4/AM
	fFQiLyEMlnuE5IC6MtWb7UO2egVYl40zf7nfQsHaa1XY9UVwp/zLK2xhIA==
X-Google-Smtp-Source: AGHT+IEs1hfcMsyrYxjUx9pXR3zHwqXatIuoccyhQ03e8WvGBVW4ZUTquNW1odItbCm8mnP8Idn0+Q==
X-Received: by 2002:a17:90b:3b81:b0:2e2:b17a:b118 with SMTP id 98e67ed59e1d1-2e2f0c550e1mr13112910a91.32.1728883391084;
        Sun, 13 Oct 2024 22:23:11 -0700 (PDT)
Received: from JUNHO-NEOSTACK. ([221.154.134.3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2d1c0fd2bsm7837630a91.17.2024.10.13.22.23.10
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2024 22:23:10 -0700 (PDT)
Message-ID: <670caabe.170a0220.2dd053.5e00@mx.google.com>
X-Google-Original-Message-ID: <ZwyqvI83eijxFbTf@JUNHO-NEOSTACK.>
Date: Mon, 14 Oct 2024 14:23:08 +0900
From: Junho Lee <tot0roprog@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 3/4] mesh: Fix inserting NULL into bool type
 arguments to false
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Inserting NULL into a variable of type bool is undefined behavior and
inconsistent.
---
 mesh/net.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mesh/net.c b/mesh/net.c
index 48032c64d..82c812b73 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -2649,7 +2649,7 @@ static enum _relay_advice packet_received(void *user_data,
 						msg, app_msg_len);
 				}
 			} else {
-				seg_rxed(net, NULL, iv_index, net_ttl,
+				seg_rxed(net, false, iv_index, net_ttl,
 						net_seq, net_idx, net_src,
 						net_dst, key_aid, net_szmic,
 						net_seqZero, net_segO, net_segN,
@@ -2657,10 +2657,10 @@ static enum _relay_advice packet_received(void *user_data,
 			}
 
 		} else {
-			msg_rxed(net, NULL, iv_index, net_ttl, net_seq, net_idx,
-					net_src, net_dst, key_aid, false,
-					false, net_seq & SEQ_ZERO_MASK, msg,
-					app_msg_len);
+			msg_rxed(net, false, iv_index, net_ttl, net_seq,
+					net_idx, net_src, net_dst, key_aid,
+					false, false, net_seq & SEQ_ZERO_MASK,
+					msg, app_msg_len);
 		}
 
 		/* If this is one of our Unicast addresses, disallow relay */
-- 
2.34.1

