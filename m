Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3998346A14
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 21:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781039476; cv=none; b=s6XxMwCwWIHYs6k+xIKV3tI2PFnaucDZEsInaUEAo7Yzv86d0YET/KbdfiGOWm8SYGs9DzPip9cRC0SyCjOZAKyYxzPFguFCyTwcMCPV+Gvb/7vdF5q5+1I+3reIvfdqoJL7kYl8xxTieJfmKxqO7D1KLHsbPN/9iRrJH4qyquk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781039476; c=relaxed/simple;
	bh=l6vIO8aKdSECF01zksjP0E30zNSyrT6ade2qIYgk2+o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nk6etD+KMqw/k7H81vJZWRBMFD+rKpCDht/IloowpT3lHyepdbQWyPSZ1WdPfUQEpEj2ifyZ5BWEIFtGgvILKhBMz5UvLskFEv3hRQzA7GTbivyp0AwJau5YsyuMtMBx9VCZ0Y/kQTu69rfhjWWD8IB7Eg5mrCqFJl6f1MmVF/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com; spf=pass smtp.mailfrom=streamunlimited.com; dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b=q/6hXc+n; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b="q/6hXc+n"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-45efb698ef2so2912242f8f.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jun 2026 14:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1781039473; x=1781644273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HQUTv8bjCStfsksjMszQoEWEYUN1EKebGoo+vXRst8c=;
        b=q/6hXc+nJQdYVEwzyg2uEAPmMDluRq2GalCh7TMyZH0lEtQOy+EUTMBvPoC8RtOauw
         KTq6tHDC5QPSOxcix0cHv2jxCefaUZ3CVtSEY/VDNwiDFctoqE1EF3OwMvBna84wFS/1
         /CgzSV9G/UwSyL5XfVMF0ojKE7YH8UFrXCj7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781039473; x=1781644273;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HQUTv8bjCStfsksjMszQoEWEYUN1EKebGoo+vXRst8c=;
        b=MJ3mRJva81Op3L70+4RXisazCFfoTFZBgF8vVsjt0PHHpoAiZ/m06/yjMhUdvSf6vN
         HIgGskfmzYyBcr+EZuJPlYxbXQLpaD40DDSK2Lnin3RJ3zEWtsX0uNLY3aPRb7D750fX
         8tReTxM72j5UlAyIUulfSRQDERCRKyeY8dwRziOcs3y3p7rFOR43/oXdhutJLMziR4bG
         zrMcLextTRSDcH3bGzPGodjIgq2wGhsFRa9nG3e66A36Pz6aQM4crXxx+JBZRDjryEdS
         2NSqnz2VkBIgAmRdMqOIS2ZXYJFJig9i1kRXfT+7v1rJUT2u3SG+yR+ybH8rF0VKKkW4
         YvtQ==
X-Gm-Message-State: AOJu0YyW47PdD8K+5jcTa1s/Fv24mn9rFldNMqprGBC1xU9Y7zvSD59Y
	rBWomugfr7ZkDR/rJeb6wotGMCIxO6qCVjzHKUJdJlByO65GDAi7W310ldaiVA4OxkYpEkVmom5
	GrphJ
X-Gm-Gg: Acq92OH3+QF/87venG03iGzvZtw0IRptHMzDltjvdilxnQmo6D5t3Bho/s+yY0OzL3/
	UUMS0ifJ5lXSddbZybivMHMqwkglmkmEYCNk3/RcPX+RCDVlrO7yJlraVKPDkrKO6VGCltbWx3A
	nSk+JSSiJlbi+StP+BB2HCsSWZijSZNu2Tn5JGyNs070n4lOv1hYQcTBpRCZzDAXu/0RmT3NhmL
	N3De5AsArzkgE7Avpf3WqvPKXyokVmMYGJoEj5bTOLFZ7Mf1MEX/l5ODBuZtNBie6Rakikf4gnx
	y7/Dr7nfBiFuBUySpR5+qqqljOsCfTbPGNIQDd+0HKhi54ItMMQp62HtLjdikJp/maOWXrb9jrx
	WvIoaoo5oLaY29GxOezozTxwR+qHMMdDH5JfWU0rULKvoRD0FZoTl+hjONB0p8weah51WPYMXxC
	6viV6DKvV/5kkZqhLcIQax8nvWD2KS9YbvX0wGjKmv5B/aYHq+kgN1zn4=
X-Received: by 2002:a5d:5e08:0:b0:43d:77a8:3baf with SMTP id ffacd0b85a97d-4603062bc2amr35981783f8f.32.1781039472893;
        Tue, 09 Jun 2026 14:11:12 -0700 (PDT)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:e2e3:d5f1:fbcb:c827])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f351d69sm117426445f8f.29.2026.06.09.14.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 14:11:12 -0700 (PDT)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ] shared/bap: Don't link ucast streams before CIS IDs are assigned
Date: Tue,  9 Jun 2026 23:11:11 +0200
Message-ID: <20260609211111.3887657-1-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bap_ucast_io_link pairs streams whose CIG/CIS IDs match, but the IDs
are unset in Codec Configured state, so a Sink and Source bound for
different CISes get linked. The stray link later propagates a
disconnect to the wrong ASE and breaks Receiver Start Ready.

Skip linking until QoS Configured assigns the IDs.

Fixes PTS test BAP/USR/STR/BV-362-C
---
 src/shared/bap.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index deb85b264..98537de60 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -2679,6 +2679,12 @@ static int bap_ucast_io_link(struct bt_bap_stream *stream,
 			stream->ep->dir == link->ep->dir)
 		return -EINVAL;
 
+	/* Don't link until QoS Configured assigns the CIS IDs; while unset
+	 * the check above would pair unrelated streams.
+	 */
+	if (!stream->qos.ucast.cis_id || !link->qos.ucast.cis_id)
+		return -EINVAL;
+
 	if (stream->client && !(stream->locked && link->locked))
 		return -EINVAL;
 
-- 
2.43.0

