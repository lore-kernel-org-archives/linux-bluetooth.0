Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6304014F125
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Oct 2024 07:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728892512; cv=none; b=JodulEsjT/sTGMayUMxBtNCWdlqX3qnNfo2BszwE5/x6ilsywiuzFt1T/ZYJ9U0gCfMJuy0CbW0yvywAO3V95KfU8xyBAXNwAyHSHstnZyvOkA3b/18APLp8SMg5XyE5DDNWdjHqNkwlhwFcu5THOvoTVzR5Rt1LFKveCqNI3oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728892512; c=relaxed/simple;
	bh=22rmkplHJOZuJfQerTHUr1KtHf0Zubet17D6hFOCe7o=;
	h=Message-ID:Date:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=a48TZDeHOZ5l36i5IY9WMzN8Z7BKAh+YFbFzA+FymsZlDE0sXINuX6NVVo+DfRs830ZAtXexFa4PfuymJJsED9S7A6B0yEjUVYduRWNcbponxRZfypFSQXMBm1zJcffezWzwhn+C4gPaqlpkNjWhN8ss9p8j+F/+LEs7BhCMke0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RRpVp0GH; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RRpVp0GH"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7ae3d7222d4so3338591a12.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Oct 2024 00:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728892510; x=1729497310; darn=vger.kernel.org;
        h=content-disposition:mime-version:subject:to:from:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5cahgCFq8ehz8N/gd6lTB5/KBKLYT/QE1Od2NZO1lEw=;
        b=RRpVp0GHcfuhuCVE0OrALFmydPahFEwhD8p2aNdrKfUUpuZ1ZcJCT7Hk15bXCSt2I8
         g/EdKaos5TRpUtbKRdzwQB+TAtaR2ytv7WYbRs85rJujOrXxYdbJnk7J8Xigx23f8N0g
         mRGhj7kh3f/s31EHS/BAtJr/G8WPbj7cDgdWMxSBPFDsqYc5baDoyeGrl/98y+laCMMD
         pZQIBcOexTYoAFcn/Su8aHWz23xwg67AmC+D97M9ng1uBbny2RyVpbYxYwGRwDrQPCwV
         c+95pj2TlaSGXrXgHgIxakLn8aFqRmpmdkJqymM9NY1nQyLR4uIoPOrsWc5vfIWyUNZv
         Hamg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728892510; x=1729497310;
        h=content-disposition:mime-version:subject:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5cahgCFq8ehz8N/gd6lTB5/KBKLYT/QE1Od2NZO1lEw=;
        b=MpIfDCJBtt7Ly1lPhm7g2Qu6ZKRI0IMfrYudTroeErUpQ62Tq+xrqv05UUBh7KPsJ2
         2nriRmKkl8+2qyw2m+c57ruhRAdfq3LUJ1ypgatw3P9E3uqrwtK5utEmY0YYROcTAbAS
         AxeXpVVmRXzD6IHfasyuN6KQY1IoMDm0HAGiBgsoIV3Nh4wTLiYeA2yTD5AOxAf9d8TK
         SwUDhwa5mJlx2wKFr/6NDv+MWNQyRHaXMmwVAV6R/Sl0i7WbpcyHJ30H0LNtD2IElMsD
         pXIV3dgJzey1osk2Lou7HjgqzpkI7Pjt0tuINFI7EtGbT5cpoNByMswIEdcM4HfFPabd
         Yorg==
X-Gm-Message-State: AOJu0YwArbh8XaccAP9qJ0E3/lC8R3pzlsjN1LmMFWJsaTkVXajRLXyE
	QSC1yrC6Q+7rcblSTt4Lol8DQvCXkcrPwiiZ3mpg8rWLJ+vHHTPGp/zzPg==
X-Google-Smtp-Source: AGHT+IGBBcIQ1JZsUgMNglKHibUBSIEKGw+yMUoZmsCbqXYey0lhJGXbX2v9OUHRba6IOU04UcHSCQ==
X-Received: by 2002:a05:6a20:43a9:b0:1cc:da14:316a with SMTP id adf61e73a8af0-1d8bcf2f4f0mr14946117637.20.1728892510270;
        Mon, 14 Oct 2024 00:55:10 -0700 (PDT)
Received: from JUNHO-NEOSTACK. ([221.154.134.3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea8885df80sm1262337a12.74.2024.10.14.00.55.09
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 00:55:09 -0700 (PDT)
Message-ID: <670cce5d.650a0220.14e0cd.22b4@mx.google.com>
X-Google-Original-Message-ID: <ZwzOW8EKr8+AwpOH@JUNHO-NEOSTACK.>
Date: Mon, 14 Oct 2024 16:55:07 +0900
From: Junho Lee <tot0roprog@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 3/4] mesh: Fix inserting NULL into bool type
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

