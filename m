Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFE81F4C8F
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Feb 2025 17:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740762809; cv=none; b=TS81M6iiSkDzC+13Via+DfuUQqO/yg8DP3M6+PWPbXYjokIGDxJlHUq6EFs+xOf+sktQOJ3Yl75V27lRd2effWAA8ttE32gsv0AJV6SaLYFLeuLMrYZxXbwGEtmE70xlhsmJ+AAfRiv30ocR30BMQFnusn/7qh5VRTImvbFhMGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740762809; c=relaxed/simple;
	bh=eqmJotZCYlsTTV+eL2oW8iauWWkbrp2axe+IBnHC2vM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=tu0umF9A0E3jXv4FX5afaBwP3txlTI4RFt3KxObA7/vdjY21alOPF/02IT5KD6pIJz83e1CCEfrdr+riSgGpR4FYrVR++ZGaygTbQTKGgs3tYTzQ5kiDRpqDGhXq1sbOK6ob5HbPWnTifb5Q7bLnkbZyd5CHCDsLx6cuZ8RQuBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bZ+YMxTs; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZ+YMxTs"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6e894b81678so12114856d6.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Feb 2025 09:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740762805; x=1741367605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=xP+6B+9sC1rDAJnGU6dhLLsLdHKuciFB6XDnpwAECKI=;
        b=bZ+YMxTs7mlKKfR4wrc2G5/JNocN699WZIUwGtYb9xrUwlAKC2/9l3anCougA7GMFD
         hDZFz1PuEnBfnvK20qfwa2QGoLm74/ahqlboHIw3mAUz8f7zWSEfjTtBM4EUspL6vr7f
         YO/01THlCmCEZxfSf0uxNsLbQeX8nxOy8kbMI4uo0Y4bNtwmc4YKRtYY1KFt1Ub4LzzP
         T8Ecm14e8CpD7Q0GQiMTrj+LS4IA4O2HsCoakiJFIy0mklX5hm4SWP5VgBuCczM3HPcO
         T1rq1FFSugbdZQm/QfmIJ2ABYT+IVpWy6wEipBS0PRvrpBmq54BZQNEqpCLNLHtFYDa6
         Jlkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740762805; x=1741367605;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xP+6B+9sC1rDAJnGU6dhLLsLdHKuciFB6XDnpwAECKI=;
        b=UUQAVLDbtWbLUiFTcQPxyTXVyGuWeai/NvnglWHN6AB32WerLhrv05p7c33yuIxmfP
         GyPMTv0ES/L7omTWpNOmemfE6sFm6qazDEBcmkjZGWNtraiXTrjE/iDNASQT3KVzPXNO
         wYBpSCeQQPeAy1jKy0CJZ7i+skqbDEGLQW14fYt6XwrLYdC0IThPk6V6mFx3ob1LGqH2
         qm+JTmhZlU4VmL8joy9tzWwd8tv1PtFGd97ID6tZDMtCM6WtQ18PFJqfZAu4G9ok7ZaI
         7xc3a5BzHiUwxRLMHPl+yTkL40We23HuWvsuGT7GQYmj/ZNFGnT2JlgozbWRU/JGu4cP
         boBA==
X-Gm-Message-State: AOJu0YxKQ6mvewuJ8FJnyCk954kgC423PV+QPNbhaT3ZbsdOtuwmr/o0
	rtSMQrbT0AmekjE0hUN68LcYUxauOfhi6rwf19JJM9GCSuR0IvHOd5Jf7OCw
X-Gm-Gg: ASbGncvlRaZA4G31S5F35fjo9dOeb/C1TQnAb+E4AR4S3x8CZYu4sUaQb3DgRpKvL2p
	o+DRYumXYqmVRDngsDm8IE9d5MQwwBztNTHS+8jHx9KXR5whnm13UOzN34pR8+YP0RxoDstI8zS
	dt19PpraIdIEXqdDrsTmRTOO9xQ9rQAZAHfMtzfwrk+BZ4z/m4VJ9oDGwViss6ZXVK3iM7HVnDo
	SuJW8DJPKcRPHsEpwBclnSSRpJrHQAa7sNJVRuMfo0Hn4W7TU+4Uq9Mg+yNgUjb7ZOFxT3U5tz8
	FWe68WjR5zJHHnJvoUePxdPbkXUlWYdeRdhIYg+MZOA6gyZMtqRmiEeTZB+NV+xzq5sKNuI=
X-Google-Smtp-Source: AGHT+IGyoSPD6Oy1sPPpQRDU2qIqPcjryxpLRd5VsL7yprad8/FOYMv99YUt+QhMdacTmK00LjtNyA==
X-Received: by 2002:ad4:5c64:0:b0:6e8:9a55:824f with SMTP id 6a1803df08f44-6e8a0ccd0bbmr48887296d6.6.1740762805427;
        Fri, 28 Feb 2025 09:13:25 -0800 (PST)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-86b3dc1358asm584981241.9.2025.02.28.09.13.22
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 09:13:23 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] shared/bap: Fix not starting released operation
Date: Fri, 28 Feb 2025 12:13:21 -0500
Message-ID: <20250228171321.3465285-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The release operation is intended to release CIS resources:

  'Releases resources associated with an ASE, immediately decouples the
  ASE from any previously coupled CIS, and tears down any CIS previously
  established for the ASE for one or more ASEs.

  Valid only if ASE_State field value = 0x01 (Codec Configured),
  0x02 (QoS Configured), 0x03 (Enabling), 0x04 (Streaming), or 0x05
  (Disabling).'

But as the stated in ASCS specification release can also be used with
the likes of Codec/QoS Configured which may not require the CIS to be
established and in that case released operation shall start
autonomously:

  'The Released operation shall be initiated autonomously by the server
  if:
  The Release operation for an ASE has been completed and the server
  controller has indicated that the underlying CIS for the ASE has been
  torn down.'
---
 src/shared/bap.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 8b860ce8b984..f7e42fc15a81 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -2099,7 +2099,24 @@ static uint8_t stream_release(struct bt_bap_stream *stream, struct iovec *rsp)
 
 	ascs_ase_rsp_success(rsp, stream->ep->id);
 
-	stream_set_state(stream, BT_BAP_STREAM_STATE_RELEASING);
+	/* In case the stream IO is already down the released transition needs
+	 * to take action immeditely.
+	 */
+	if (!stream->io) {
+		switch (bt_bap_stream_get_state(stream)) {
+		case BT_BAP_STREAM_STATE_CONFIG:
+			/* Released (no caching) */
+			stream_set_state(stream, BT_BAP_STREAM_STATE_RELEASING);
+			stream_set_state(stream, BT_BAP_STREAM_STATE_IDLE);
+			break;
+		default:
+			/* Released (caching) */
+			stream_set_state(stream, BT_BAP_STREAM_STATE_RELEASING);
+			stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);
+			break;
+		}
+	} else
+		stream_set_state(stream, BT_BAP_STREAM_STATE_RELEASING);
 
 	return 0;
 }
-- 
2.48.1

