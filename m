Received: from mail-vs2-f43.google.com (mail-vs2-f43.google.com [74.125.227.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C197A4FDA4A
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 16:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789748062; cv=none; b=bjbjjmfFoiDB2CnEuAeB3ZPSlXikw18Yusx9IQfV6xfwGxIoraLSw12FLsjUjLZnZiFtQ6xMsHIK3Dwf4/K1UaF3i+vmm3Uc6SmrIJAv0k5C9fQa4rjC60+R9l2jN50YNf5gY4hXwhNX6AN+auxhJoYTWeEmo0kcLszm6YZxNyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789748062; c=relaxed/simple;
	bh=FD6l1FQ6PhJ2sFRpMo5q2e+ZJnrrGI7a3Q3JUapsHm8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VCFiZ97MkfqfsyXEAM8IFZhkw6c5EHNkZlJgMYZxBGRR9rrrI5u1FXhQVlzMduemWrQoTLHG7EfWA2jJ1sRnPnGHB31Rb+eRT4P+8Rn6UZicQFaRMRCX/tCn/y/DOmyYquyUvUMVzNEy5Pheb1N4MkOPJvWmCCER/rnJxY20vzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LUnMlgT6; arc=none smtp.client-ip=74.125.227.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LUnMlgT6"
Received: by mail-vs2-f43.google.com with SMTP id ada2fe7eead31-78a5e045187so410513137.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 09:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789748059; x=1790352859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=I3BuChxq/K/tVHQ3Morzr9dEpNMWxLBD7m6hfDex+Ng=;
        b=LUnMlgT652DatHymDMgK+ZBR3rZn0QRBZsTFZyxXx3YCh/+0afJfKU/r7hpswCTg2b
         Ln/xLRX9629E1zVr9zcqgYExay0SdcrkmmCeLxjDCSfdelPurWKy+Dy4vxfLYn8I5nsa
         V0a7p7h+QJ1WU+edl8gfDDoq8U2U5EIJWiBpjf4BnIG7wYtJDmIXsoaXNzZ95ALAuaBV
         kxvFjeESFxUr+s0HrwRSOfZodk7HfjL8ZeBZftEUctWOlfj6ChPFsTSlrlrhxZH7YJqZ
         NYWeVW3UuZpAHNYBgQ3JIaV6nMdwm2g34ZyfsZMz4N7ZgXOffYrYuD7r/3SOOl6F+9AS
         DP3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789748059; x=1790352859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=I3BuChxq/K/tVHQ3Morzr9dEpNMWxLBD7m6hfDex+Ng=;
        b=lkfmkdhYuf86UU8Gs92uw8S1KHSVjZIyhr+EQpLwQCuFxOsR3itidKWAGiu0TCbWSU
         Lx1oFvGuf99LzLdBH8epnI2+EcjmGHsGSMFdvEKyTI0onHGtp12CJrEyCn/K4c+VhRj8
         GY8s8KHS+HTgyVcBj1XG/Ks70fzOJtpAux7G6io+bObnwxfFVPUDWpZVLh9/sTa9alQe
         nz2eOqnsYCXo393TV89dfPS6aWiLq487gjehqY3E88fmtUhnXnUlYUVfkzPXEkfwTMw9
         l8NELtAjs4rNdpsrgwynFfnx1yocqrAHHYaJKKJ0TstrU+ezQSROq6/erdD0zzMZl8fr
         POVQ==
X-Gm-Message-State: AFuF++mZbjJvAkNxbNbiB3hKLI1ml6MXxMYnIj2YtsigYbhWIEXwuKgt
	KkQjSPm4qFbu7JcAn4arKJTnd9+95XFg0HYXBvIdvcUR/WIq5u+xb+0vOlg4hSSN
X-Gm-Gg: AYBFou1qOPi4JQoXs/Lbd22Dy9kdcdByM0oP3R9iXpgpQxOMRjSwgzVXZmfnVDiKpWZ
	eStBUIzYiUkdAn6jpL2P5GxUnc8Vww310Iix8EjJMUmpqz0oFrANJnAOnsEtNOKMOS296Aiq44e
	ZvYxpefK5T2XjOJNByHzU03F+pjunC3KjMkupU9N6+EaCv5hFKvO13vO9SoNufvrva6IU6GsjOF
	PiTrrGn9ST3ZDJxooM3PPkwdL96JGtT1y4ewfuQwbMdiBf23RcZdHIO/ZYd4VQtU05BQJQ33FCc
	KiILCj6xd6hytDZ/0oo0EBbUdJToF66/Hiqy5vJTWj0MdbvBv1crB0F2KAI5ErdFMd5Fm9gNI9/
	f1Euc4F9ZYDYG5ceW2rs4yw5xd3JJQPCXTKswu1aD9fM6ggsO8lziczvNyL5ZW6qoZ2HZZFStBs
	l54X89O/RrMcLoEawChaa6EIjJW+DsBNmL8EN3jbdpdg+5OJ+3mql7+MZslHYQg5VTVqsa5UoQF
	PXM6pTXAeGWezp4wyNMuTR1G5K78QPjYA3Y9R+sLMJQiCRw7XfJUDe0FQULnmwH
X-Received: by 2002:a05:6102:5812:b0:7a4:fb71:25d1 with SMTP id ada2fe7eead31-7a55b143293mr1542996137.7.1789748059131;
        Fri, 18 Sep 2026 09:14:19 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7a59c569181sm2104078137.11.2026.09.18.09.14.17
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 09:14:18 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 1/9] monitor/analyze: Free the channel latency plots
Date: Fri, 18 Sep 2026 12:14:00 -0400
Message-ID: <20260918161408.2464981-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918161408.2464981-1-luiz.dentz@gmail.com>
References: <20260918161408.2464981-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

A channel keeps a plot of its latencies for as long as it exists, but
destroying one frees only the channel itself, leaking both plots and
everything queued on them. A connection already frees its own.

Assisted-by: opencode:claude-opus-5
---
 monitor/analyze.c | 2 ++
 monitor/l2cap.c   | 6 ++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/monitor/analyze.c b/monitor/analyze.c
index 154303eb7330..5a3adedc211c 100644
--- a/monitor/analyze.c
+++ b/monitor/analyze.c
@@ -298,6 +298,8 @@ static void chan_destroy(void *data)
 	print_stats(&chan->tx, "TX");
 
 done:
+	queue_destroy(chan->rx.plot, free);
+	queue_destroy(chan->tx.plot, free);
 	free(chan);
 }
 
diff --git a/monitor/l2cap.c b/monitor/l2cap.c
index a132bcf397f4..3eaca5bc226b 100644
--- a/monitor/l2cap.c
+++ b/monitor/l2cap.c
@@ -2913,9 +2913,11 @@ void l2cap_dequeue_frame(struct timeval *delta, struct packet_conn_data *conn)
 			frame->cid, frame->psm, mode2str(frame->mode),
 			frame->mode, frame->chan);
 
-	print_field("Channel Latency: %lld msec (%lld-%lld msec ~%lld msec)",
+	print_field("Channel Latency: %lld msec (%lld-%lld msec ~%lld msec "
+			"+/- %lld msec)",
 			TV_MSEC(*delta), TV_MSEC(chan->tx_l.min),
-			TV_MSEC(chan->tx_l.max), TV_MSEC(chan->tx_l.med));
+			TV_MSEC(chan->tx_l.max), TV_MSEC(chan->tx_l.med),
+			packet_latency_stddev(&chan->tx_l));
 
 	free(frame);
 }
-- 
2.55.0

