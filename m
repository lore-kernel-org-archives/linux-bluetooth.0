Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC8A386C25
	for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2026 17:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780076049; cv=none; b=tSUC8LvZT2v9XK9bBlc8j4c0VyJSwWtBIDadyCHYdomBTq0FqB58slX9EXGiTqKam5tebcKASAR8XZHhMrPu/ROH9GLWB6lOC/phIXyRTExtnX9Yn/Z3vw23eCD9iewkCrieR5br2Nb76x+R4c0G9ZQTjIUDshPti/zlIiJJCk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780076049; c=relaxed/simple;
	bh=rjLfN0SAm0XetwEmFqwIqt7LwciP/mnuvaEnvxaoZJM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IezTGrFOQR2wBORg1GVw/SQYDJ6H3ahuUfnx47NlEvKSGXfMOhXJdUvUlthUj18JLvmkis1R0bSBuwn2MPVQzrN1hixLLYfSozVNMMB6K5Jh1ViG81gMK9pxEylniYPUyUsA+btw+BJ4cuwHa+7kaKnoKH10reh6LH/7yX2a78M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TsoWXDUl; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TsoWXDUl"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c80227c9572so6385990a12.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2026 10:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780076047; x=1780680847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xjaihLgvutZ1fFlKyQCNXr6DGsbYvGyqlu1s3B1StM0=;
        b=TsoWXDUlM4fAjZDpMAyu/NVOjqkl5zm4mrg4oPZTxDnlodgvm42wRQsEOPZawAQAW+
         Gc3NUhdk50/14OCNctbmYcrHyYOGz+r23cynRsBsfyb/qMj1DHS7ydbSO305ywWefWN+
         UF0mv9l3MtOZXbUkp8wxLz5PVFD/4ohP8h4e9bCVSupi6SljJe6+U8X0aL0IxEXTnALO
         n3a8BG0C3u87i9RS0uTcpde6WCCqYAcCl91QWf9FHEfUHqBIaiYIAi+uA0DQ8kk/7wB1
         U9t7+fVpZCdCiDymN90r2sl7AHCz08+dLRGJFtOE6pxSlTPeDQavUIiMSHZG8zm6iFkx
         varA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780076047; x=1780680847;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xjaihLgvutZ1fFlKyQCNXr6DGsbYvGyqlu1s3B1StM0=;
        b=spPXitL2pJnPz/897g3/VjFxh7IbyPAPHZreREVbobTdZkbPyiCTdJp9gF7h/VIv+S
         Tcv1a8WKwGKlTw7L47TNsqqqWkmvYLL+VYDINg2H932yAZqfnFzSz4pxcTQt0VAFPtst
         xOVOUHeAgFrq3LfP+nK7dUGuGYz1ssO4NCDMIeYEWSSAcAaivhlXMVrKC1Royl50VjjH
         e1HgSWJ+KuPBdMTsvHrTkmE0PouLAC5EoTHQ9N0fvdxrGSMVaq1ruZ/I4WbgUBqmihTg
         nQP1Uitrex42u0hnsYFd/Xe+4dotyyf7ZMSOltChizGLslQrgcsnsCQt91gcom+YDsnP
         EraQ==
X-Gm-Message-State: AOJu0YyOI8kzLKdwDMQSNkg7TVv5QbBDe+e2/7VJE0DYyYrSDLRYuoKK
	cROuTpNUhT+RpA/3jgZ9KQVz3Xj1mxSWHCV3UMaDBqZ8M7w+0jMoTCzr
X-Gm-Gg: Acq92OHdepUdoGi+/u5DadJ+21/MQkY0sDw3nMQ5X9IX8ZQTnPtboeiFraFXdbyYGJN
	tHHnl4lBLJ7hMU+wPMLXdOcxPgPKw6H2WnA/Z6ry9073sByZOV3nUMx+PNXDvdN58TNj6dHpwAi
	TtlzegU3I53HvfPQmZ2Abk4pQlz/qixCG8+UvblIMOZ8l224ygg4nFlto6mjHuOIFLMaVRfjDHf
	6ydsBPbtW2MTaTTG0EdaoI7ORe5KqD775rZpIZYXU5GuMPSykP+MV8OOj79XqJIQeRBjZWQAHjg
	KDDl2do4u+lQmRvvbDo94fuo2AFhTHcdiM87RNsYOtH5uffVF2YEIoCrae+h36yxdMWsztX+HDV
	A+UGEq2F3lwg3T3vNl2GmlL9liPMHYr1FAEKYfIo21gu4G8Il1emStNyLtQv5YrPDa9FSGx87Lk
	nfPOAeVINeTlSwtleR/1qDiAXOs98xxfA3ouKdzU4cFXbcxGCvg5wdDxxHCw==
X-Received: by 2002:a05:6300:189:b0:3a2:c683:fa84 with SMTP id adf61e73a8af0-3b427f6d141mr220913637.27.1780076047144;
        Fri, 29 May 2026 10:34:07 -0700 (PDT)
Received: from fedora ([61.74.238.173])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85772ba4adsm2361027a12.23.2026.05.29.10.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 10:34:06 -0700 (PDT)
From: SeungJu Cheon <suunj1331@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	me@brighamcampbell.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	SeungJu Cheon <suunj1331@gmail.com>
Subject: [PATCH v1 0/2] Bluetooth: Fix data-race on dst/src in connect paths
Date: Sat, 30 May 2026 02:33:45 +0900
Message-ID: <20260529173347.43967-1-suunj1331@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two KCSAN-reported data races on socket address fields passed to
hci_get_route() without proper synchronization.

Patch 1/2 fixes ISO: iso_connect_bis(), iso_connect_cis(),
iso_listen_bis(), and iso_conn_big_sync() read iso_pi(sk)->dst/src
without lock_sock before calling hci_get_route().

Patch 2/2 fixes SCO: sco_connect() reads sco_pi(sk)->dst after
lock_sock has been released by the caller.

Both races were confirmed with KCSAN using VHCI-based reproducers.

SeungJu Cheon (2):
  Bluetooth: ISO: Fix data-race on iso_pi fields in hci_get_route calls
  Bluetooth: SCO: Fix data-race on dst in sco_connect

 net/bluetooth/iso.c | 51 ++++++++++++++++++++++++++++++++++-----------
 net/bluetooth/sco.c | 11 +++++++---
 2 files changed, 47 insertions(+), 15 deletions(-)

-- 
2.52.0

