Received: from mail-ed2-f32.google.com (mail-ed2-f32.google.com [74.125.228.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1712E3B8945
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Sep 2026 09:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790761390; cv=none; b=Li12PfJzpCJkJpv0qcmk6m80XS7/gEK3sLEsf3K7k7zueDTUeGd3I418/VQP7wroG6yPWtw7JBnR50bpWMCmZ7aGK1MZFM1NyZz+kYmAzXPzjoAzTtOfXRS898YqNLIyjO+KDIL0v6bNjHFVVAImBKuJE4bi+qkY5iODOE4jhfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790761390; c=relaxed/simple;
	bh=XeIN5W02/6+2PkBuNVGLdwNw5LgA5lkSWGdPHoxqmmw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tAZMgJ3etjdZnPDVFqxbBI0zJNH78tF17qOqJlIsg1KtqQRzpnRMiMQXKAkZS72zzB6DaKVeAqzjoaX/diW1LX+ubW+W7mncz62+KqxzqUrhukSh5W/ZlUZYDi5dcrG/OnpGQ/kOnjzxvf/wJGG7Pg57PPZm75yuTvbwIHYa49Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W/wn2gQg; arc=none smtp.client-ip=74.125.228.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/wn2gQg"
Received: by mail-ed2-f32.google.com with SMTP id 4fb4d7f45d1cf-6acb91ecaccso2348568a12.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Sep 2026 02:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790761387; x=1791366187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6Of+2fMoYj5OX/CFX0Jvb68p/9DmVXmvWTWpw+JnI40=;
        b=W/wn2gQgi5FLxLWtnBBi4fXA7uU+302nYxr3CeSnBZSvqVtkJhZbhJzPqWo34lrw33
         Fuey/cBgXSnI2lu6oioShDq+rNx+oMAiqZMitAiODdLISntxKBAN542UvCqJ09Y+fHb4
         BCIdJDEOQRroasZ6ojF17VJVRC8irpzCP7pQylBCZ+hmALUI1iZaXeZiGn6xCNEdBsjc
         68gr1APV67xZGNE7wTxQZMpUoz2FDIyQdFvlcTn7zdmP6DcFOe44kaONUUO9oYDh+6ZA
         nSoIqxhiUQNYVqgdjIScsuj28gRXaY/1Ba0e5yV538GVMJULTc9b+UCjIt3x4QhzP3NP
         sUUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790761387; x=1791366187;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6Of+2fMoYj5OX/CFX0Jvb68p/9DmVXmvWTWpw+JnI40=;
        b=R/hbtJu9aWnZB8S+hF4ciRN7RF2e1mvz+NagveG1CHGSDhdYbxPwfCbdMrxPBBCOTj
         M+PzVkjb5VlgZ94yzaGJA/mE59EifljNtY8/2SWltz+ftc5AakiwohIlymFrEvWMoTUD
         SKAEmW+CSTvIIx7HwwhQqvkozNS1V5vl50qV+Jnh7cd5zMUASXjMBdQVdkzpmoaek8kd
         Y29nqfqzMK5zmrUCEcCxwvd+VtRkPrvPIOof87wY/Ss3Finl8Xcj73ps/X/NY/sgz1Mc
         +4d2cA5EK8U9COmNHeLGIlXDF2c7STqQYKDzUN4NRd9lCrKZf6yNjbRzQLmy1YWks2pD
         +pSg==
X-Gm-Message-State: AFq9FYJv9GEmUmn94gFOGk9eKuEWgb5atuacaDA8KQyssRuTjMca5/lH
	iVMKAGEgX+6miJecBON6DiSLuDTcw46BINjvHNarmPkxsmqsR0+roNxm0jijAwJj
X-Gm-Gg: AYBFou1R9cQQVtSAgToX/47R0fmeG6EYJ6z0y+n+poiw+VZeFl9OGCbLfWq2KwMwfyY
	nUWf4YekUQK6d+4txphOmbIwxSiW5fap4O++oIjv24CF0HGuL1dx1gpDCHr5dqSEUVdLkJqje6h
	ZsPVfchYklnt2fINXxRYM7gtco2scAksWP8Fi3Q7xWG4dS3CSHtotN3Ueen7DY6mj2KalA2p0ZU
	S9umGZ6BXlHulPHJ/GPVd60TELppGs8jsO2b8gt0g5hiGrIVjV6JKlfoUlQL6LChHPEEFSBVdMx
	WfS0RgyTlJf6NMHtmcTJMcI08dlu4QUjiSpqtnUbqO2hQvGKFQ8kvhUXVExrcAoPpEFXozNQtXH
	AUMJmJKSBfagJbs7o26NDhMt8asM0H3V/bloRvtTVxph21HCu8UUhRuVc/Ai22M6eBXDU3anMdM
	f3FA+Bv0Y1NEfrSw2UV6PHqM5xi0lEZkpC+mZCYG9+0DAWDEAeX/2iNFK7x3be39utZI9/DDUBr
	alxdThAbdXqBcq/QmHEVyHK6KhliFFTaSIGJLVXlFj9i/PwQpvz1SzUipkoK8aaOTZe+nGuIOt9
	svI5R+5WxybKX2flBi1sPjBRcknEwnfCZ+3wbZRAHb0=
X-Received: by 2002:a05:6402:5384:b0:6aa:a015:716e with SMTP id 4fb4d7f45d1cf-6ae199621f3mr501521a12.41.1790761386627;
        Wed, 30 Sep 2026 02:43:06 -0700 (PDT)
Received: from home-fedora.hippo-beardie.ts.net (146-241-156-87.dyn.eolo.it. [146.241.156.87])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ae1539561esm521126a12.13.2026.09.30.02.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 02:43:05 -0700 (PDT)
From: Gianluca Altomani <altomanigianluca@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Gianluca Altomani <altomanigianluca@gmail.com>
Subject: [PATCH BlueZ 0/2] Fix use-after-free in GATT client discovery
Date: Wed, 30 Sep 2026 11:39:26 +0200
Message-ID: <20260930093928.360745-1-altomanigianluca@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bluetoothd crashes in discovery_op_complete() when a discovery of a
connected peer's GATT database is cut short, e.g. because the link
drops mid-discovery. Two separate bugs leave a freed service in the
discovery's pending_svcs queue, and each patch fixes one of them.

It reproduces by connecting over LE, reading one characteristic and
disconnecting about once a second, with a peer that answers the
remote's GATT discovery. Each connection is short enough that the
remote's discovery of the peer is still running when the link drops.
On 5.72 bluetoothd crashed on the 15th connection in 4 runs out of 4.
With both patches it survived 381 connections in a row. On 5.83, 50
such connections crashed the unpatched daemon within the first minute
and pass with both patches.

Gianluca Altomani (2):
  shared/gatt-db: Always notify service removal
  shared/gatt-client: Fix double-queued service

 src/shared/gatt-client.c | 10 ++++++++--
 src/shared/gatt-db.c     |  9 +++++++--
 2 files changed, 15 insertions(+), 4 deletions(-)

-- 
2.55.0

