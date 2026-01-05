Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3477F265CA2
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Jan 2026 21:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767647289; cv=pass; b=mAfMutehrZy1h7vxsODpNupV2UeUoTpP8d442fkjgb4J5Jhi0xELqR7H0a+hZnh+8ocP/RKtReuGbsNBg4cBWziq3pZ11jd/M+PPS3opX9Jam9nnVKabjr9j9oxAA464f9I4ejpg2fCSoIicHSho32+nXO/UURZ0fQaJeLDDx+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767647289; c=relaxed/simple;
	bh=gl2sw/T2yz15uu8ic3Nje6GGBRFp1VbCpU6hGRpM9i4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YzPnks5rMWdOx0ny6SzDBAJdgp6ktWNepNs5ghkjbdf9CLVCyecZv9fmd5H3iGbkatoiJfO6kvCof+zWYsnmeWJEEhpnegPnnssvM6dm8t9qoBl6WWEuh46D/2dqz5FSOdLU0wfI8cmneLveObKCGp1f3K0mmM9nqWkZDcDT1e8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=HoKPQMYY; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="HoKPQMYY"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dlRht19PTzyRd;
	Mon, 05 Jan 2026 23:07:58 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1767647278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=H6wx3T9kRXlkXKRxmiO4PV3pWCgGqdfD/sy6RpYH5HU=;
	b=HoKPQMYYIINWkSvQizgXDGA5VphnJQa/4+ufuxiAEsDclhehuU44G6r7dz0leCf/F1y1HO
	4C7192Zt/vGQyzCqcpbNDP66rfeZo2VgFl+49AShVPX92kCkQ60mtw/nLpKJv2UQzu5c1U
	ycRUcZAKy4GZlFlYKqSpNVGmwtTUhVk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1767647278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=H6wx3T9kRXlkXKRxmiO4PV3pWCgGqdfD/sy6RpYH5HU=;
	b=xUcVxgIf089qN9Xh0ZeysP6kcf0L0Dvv8TH/Tx+qPI+V4QCfWk+F8ZF266D60Xxl/feFM3
	eDQWWjiaZmpwojsyxuEZXXq57BfcXBxK73QVkYFOvPb0LnX0vGhvYsw8J9Zirt4qQ6tD8Y
	rmTrzkdrnygGDGDHj0kW/Vh9ll/h2cs=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1767647278;
	b=mrzT52uBJRgPS6pPqOrcCTUy79kQDlrkdiKPPoq1QW/7w5EcOqfPtnZwbArvJRePs2aPLa
	C57eQehIK8PLiLOD7f9+F9j86AjKEApSw4qeG1ikvFd9EufXKjarlE4bwmncGCGZht5uQR
	1l8hxWMULRu1Kl5tPNGCGSGeG+0M/DM=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2 0/2] transport: distinguish BAP mic and playback volumes
Date: Mon,  5 Jan 2026 23:07:53 +0200
Message-ID: <cover.1767647222.git.pav@iki.fi>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2:
- Drop the bt_bap_stream_is_server() function. The direction can be
  found based on bt_bap_stream_get_dir(), which for BAP Client indicates
  the remote endpoint, and for BAP Server the local endpoint direction.

  Its return value is a bit strange for broadcast, as
  lpac BCAST_SINK -> dir BCAST_SOURCE.

***

Currently we are confusing VCP and MICP volumes.

We are also mixing up AVRCP and VCP volumes.

As microphone volumes are commonly 100% and sound server may set them,
we end up with spurious 100% playback volumes.

Fix this, and also do some cleanup of #ifdefs in the volume code.

Pauli Virtanen (2):
  transport: clean up volume set/get for A2DP and VCP
  transport: distinguish BAP mic and playback volumes

 profiles/audio/avrcp.c     |  10 +--
 profiles/audio/media.c     |   2 +-
 profiles/audio/media.h     |  10 +++
 profiles/audio/transport.c | 133 +++++++++++++++++++++----------------
 profiles/audio/transport.h |  10 +--
 profiles/audio/vcp.c       |  12 ++--
 profiles/audio/vcp.h       |  21 +++++-
 7 files changed, 121 insertions(+), 77 deletions(-)

-- 
2.52.0

