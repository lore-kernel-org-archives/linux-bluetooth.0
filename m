Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9CF35294E
	for <linux-bluetooth@vger.kernel.org>; Sun, 14 Jun 2026 10:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781434229; cv=none; b=TfBaceWMOvqo5yiaUIUFIjBZ0opsB9GHDDLmitoDrkTstOWvCngFDVcRRayE130n1IsBKWyOyVgu1rEyIMuaSeVRFflU+rGxfPnN93btQMkVn+YJ8ObvdaclyaMoO0IECpquTnOi8LF4I7RLEzR4Bn0xrpuZsglbbuDSz8VWyMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781434229; c=relaxed/simple;
	bh=/kk8iw63V/fPd1/W36Gzr5d72iq5913zwYMLPedxSqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=daSoy+MDXyoTSfGPeDE3+RhjznaiBTxcR3QQXl7cHvwNQCvRAdc5XjPuLGlW2iUcCcyEA2s8x9k+eG7IEhGcxRjiAw0MJCcprEz2aZ2OzLOdQbX5w5sbW+KQfxwYBTGpY6bqEDZwzdSzKV7zqZMQLundWWShgggWryahn9BkxeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com; spf=pass smtp.mailfrom=streamunlimited.com; dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b=WCUyEzsq; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b="WCUyEzsq"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49222b6e871so9176695e9.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 14 Jun 2026 03:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1781434226; x=1782039026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u7wRDerEKiBp/b2Hp8v4JE1nBNLT8skqdPRg092EK3U=;
        b=WCUyEzsqqBHVA5CnywPv+WSZq3TnPWYTDgKTY2vcJIWiSA30DHs0OgCMv4NpNQByqI
         jGZJo3bLHM8e5UuyzARCvS2iFzlAVibgcpebp+O9IzIfBR6uP/7EwwJpKfJdw9sbHdam
         j7yo4Tp8LT9eaTwxjg2crlPgozO7VB7XQYVec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781434226; x=1782039026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u7wRDerEKiBp/b2Hp8v4JE1nBNLT8skqdPRg092EK3U=;
        b=DQri2B50SHWeVUO3Nvc2jC44lJdO2KmkcfDLd6doF2MhEIgDXEdimiUW0T5lpDo+UO
         LMlBEwdwSEql1eiCq0Tmlc7Z/EKHiYeTUqf2086r8G7xgrxk3NveTZgBsVdX24iLVmko
         e8+qOKlNeaHrgSI/dqzUzI7J+T3/QLCEZJXroIc4ZiPkqojj95bAkeAj/n7p/lUw9tNE
         xrhwR9RPFSZeTG5P5UEeyX788JLCPeRh1lDJ330NgrmDeLxjBmNYeuQF0yf3BnjVtc6P
         41UcGjbhNGp3ODi1O1Tk7Y52WXZJZSFz3WYNu58u2vczorkudEkkqLdJBIgPHtEx+XGT
         uYoA==
X-Gm-Message-State: AOJu0YyPwyhVSDhIvamN4gytGjBUARkO1qvL8TaAnYqcgjgfXMZ8Y85f
	HbN/7TkkFb6Jtt9CwP3gFGdqWF8NmMT1X0k//tbL5NoQE1wIkmk9JNRKbNn7AeCLdNIFdeBYY5D
	HjMhn
X-Gm-Gg: Acq92OHhDJV0m8oe3oh+bu9nKsRzH0bfwTMd8p62ZU6lZ+5pVkYSxOhuM4fG45RxsZZ
	ITioC2zy0iYxuJLth8dmLuqsWLBIt/tB+6RoqLoUYk1aPJ0yM/YZz7cja4HyaqPlavbcNiCHphr
	/KVCTy3U0bLvCVA4KSt9S27NdHrA9SN4PxhBgP7aWk54cC9EBIP4CK1Yf1/kTm4OY3/0IwCvXS9
	5nUL9II5FfIE1pMoyoQABd+vpvwh2sqQX6QABisou4nn19UtHtu6LyqGr003EG0+JBRUDLY+MR/
	kRg1lR40Ns7BUUniW+DUT5SuIYgdAADJbDLQby/BDyUgRJXAN7M3WPEzQvIguw2F7N9bIRZePtX
	Xu4va4+1ulj13PqwGdMPaJwBpHo/EwULnljsQwCwnjJCIHvYflSI7w2xq0/DSjq7wl0f6/sA9rE
	6atudFrL8MVtUtQ7y4VeyhqRMaScpiTn+ydHYw52pPAjKS
X-Received: by 2002:a05:600c:3144:b0:48f:e3e7:3d39 with SMTP id 5b1f17b1804b1-490ec4d523dmr127050025e9.11.1781434225873;
        Sun, 14 Jun 2026 03:50:25 -0700 (PDT)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:eb61:bfa9:279d:6464])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490ea95c51dsm166655505e9.1.2026.06.14.03.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 03:50:25 -0700 (PDT)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ v3 2/2] shared/bap: Don't link server ucast streams before CIS IDs are assigned
Date: Sun, 14 Jun 2026 12:50:16 +0200
Message-ID: <20260614105016.1147112-2-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260614105016.1147112-1-simon.mikuda@streamunlimited.com>
References: <fa0febe1-5866-4a3f-9f86-ae70e9d4b22d@streamunlimited.com>
 <20260614105016.1147112-1-simon.mikuda@streamunlimited.com>
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
 src/shared/bap.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index e8fbf0899..6ba9d3e06 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -2679,6 +2679,15 @@ static int bap_ucast_io_link(struct bt_bap_stream *stream,
 			stream->ep->dir == link->ep->dir)
 		return -EINVAL;
 
+	/* The server pairs Sink and Source by matching CIG/CIS, but those are
+	 * unset until QoS Configured, so it would link unrelated ASEs (CIS 0
+	 * is otherwise a valid ID). Clients gate linking on the lock instead.
+	 */
+	if (!stream->client &&
+			(stream->qos.ucast.cis_id == BT_ISO_QOS_CIS_UNSET ||
+			link->qos.ucast.cis_id == BT_ISO_QOS_CIS_UNSET))
+		return -EINVAL;
+
 	if (stream->client && !(stream->locked && link->locked))
 		return -EINVAL;
 
-- 
2.43.0

