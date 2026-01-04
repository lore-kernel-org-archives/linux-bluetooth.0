Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC25221710
	for <linux-bluetooth@vger.kernel.org>; Sun,  4 Jan 2026 20:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767559880; cv=pass; b=RImqXLJxYtgKAmdzYkHblIdx5b4fpO0ooxmaLSpdZzXv87IShKJOtJRO4R8hIxPTmy+/zOxRTtQDaGc0uIKwizHjY4xH94JU3wixgBZTKNwfo9QU0ifbptbmHxZF6+AI3dZKGNqDCTeWKSYO6EJV6mTO9r4Hbzpq+OY2SoWPzfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767559880; c=relaxed/simple;
	bh=W9BQLHhts7Iroo0HrqY5TbjBzDm4OZGdgMcc2UACUbs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dQGUgdOiL8fa40A6YSQBaa66gPkmsxlqjut8Lx3I+z3k/QrdMeUS4kUsdSaUqPtBDf5//bN6dRHtTjjxwLPJMm6hQyxzy6Y5DnCAEj2iBbjoepGemAXUXIJwySNeIc7jhvJwlQE0MKCaoUW1PIz08vGzE8dspa+QY6kxmZ41qdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=BLc/kQSH; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="BLc/kQSH"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dkqN26FLmzyQR;
	Sun, 04 Jan 2026 22:51:14 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1767559875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vAuKhIdgQTL6AhxqWhuFpZtilsbushTq0lYrt3lMgWo=;
	b=BLc/kQSHojNhafaesKeQ7vpCBBLs54nh0TAKEHPZ7w4iT0XnhFVpQLVjfCiLr5jjJ3sIu1
	OAeD2QzYEjKnwbU1NTNUbm6iTfarzGS993ZafopZm4S4W5vQeyBCIsRLDOLvNThPoChQ4n
	sneOYyM1TOjww5m57F4hfUAcSOKLC4k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1767559875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vAuKhIdgQTL6AhxqWhuFpZtilsbushTq0lYrt3lMgWo=;
	b=zMIGpzQcKXMYKMUIbBqdpFVXB4vDFjnWM8QyiD34iSq3LwnwszbVZAILaVNzChl3aC6r/t
	LsXYA1ANxNfFpxQ1B6QL5bH15JeZ9DOq3yXTgNByZJRUIMyD7g/Vjjjv3DgfJ7D0ZWYsot
	M23shyfV7Cc7+R47FxawMdl41iHZfFs=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1767559875;
	b=ik3MJJHT8HaNm794wQ9iCBU6Htu6yuWPpiGhZ4Oe2BtO9Zyxr12F4K+ZgKu4j9lW6FUEXU
	huLR33uWvbTLgaZWHpx/nTior9IPWdMrNwqDCanczYEV/0+XJ7Kyhv+HIqPr+PPPNL9Nzh
	jzP1t00MCwLfDYsTS+OPuUs6v0ExfLM=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 0/3] transport: distinguish BAP mic and playback volumes
Date: Sun,  4 Jan 2026 22:51:09 +0200
Message-ID: <cover.1767559459.git.pav@iki.fi>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently we are confusing VCP and MICP volumes.

We are also mixing up AVRCP and VCP volumes.

As microphone volumes are commonly 100% and sound server may set them,
we end up with spurious 100% playback volumes.

Fix this, and also do some cleanup of #ifdefs in the volume code.

Pauli Virtanen (3):
  shared/bap: add bt_bap_stream_is_server
  transport: clean up volume set/get for A2DP and VCP
  transport: distinguish BAP mic and playback volumes

 profiles/audio/avrcp.c     |  10 +--
 profiles/audio/media.c     |   2 +-
 profiles/audio/media.h     |  10 +++
 profiles/audio/transport.c | 137 +++++++++++++++++++++----------------
 profiles/audio/transport.h |  10 +--
 profiles/audio/vcp.c       |  12 ++--
 profiles/audio/vcp.h       |  21 +++++-
 src/shared/bap.c           |   6 ++
 src/shared/bap.h           |   2 +
 9 files changed, 133 insertions(+), 77 deletions(-)

-- 
2.52.0

