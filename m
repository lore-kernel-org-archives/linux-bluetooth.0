Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BB32571D7
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Mar 2026 16:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773245786; cv=pass; b=mF79xtBCRdjsx0qmee29nRaoVAwoawY0+1WQv7Nj+ED20zrOj2TqND99jegmfX5txkfraOaacqFXaDKxmDrzB6PEAUoOqjo6tsv1DGqCd3PY/P49UKCxGbF5wr+5kZRW+9CxMJUTK8X6LKEq39ybya4w2M+3DsfYyrnnNmxyiA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773245786; c=relaxed/simple;
	bh=deCGOOsJTVJlqSe2nt6Njx/87ssGq0QF+LQw+8RWU8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HgkYliVElj4crU7cCocNtDY5CKrbObJHP7qyEFBRtOiTOR32jEKgs8A5Mx3Xe4jgbxQTQIhOopADOa9wDaa0n3dH9vPhvupPAz8jZDqzIs31buSCsyeQH0DbDP/LCaUGGGw/HeeqVGVU6iUabE7ggwAPc2cP3VOqeQ7HDYf2244=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=Ebz5EIk2; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="Ebz5EIk2"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:d:f011:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4fWG8R1t8DzyQc;
	Wed, 11 Mar 2026 18:16:23 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1773245783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Zi9tPwajz9DUaiBbPAEP+V+k+SwNWCojz61078IejSc=;
	b=Ebz5EIk2NrmbxIv1x4fraM2SB+Bp4l7BcBjnlVT4YldE/po13gyYflKGimrQNq4lyAVDKN
	/PX4wM+7MXuxgmCaYGT5Kvu05mxa5ZyvrbnOdbb3xQFgDgrHbX0JdIjbOZ20eMRQsUvv4F
	lD4lqTG53M1BfeCBaWNWrVDMnvUrwq8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1773245783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Zi9tPwajz9DUaiBbPAEP+V+k+SwNWCojz61078IejSc=;
	b=SfHBbuQLsGr7IIXoyKZsnLhhm7kIDU+2aiifbSKHs/UvTQ6nYgIHPgCV6S0H1JyGaW9I32
	RXgwGx7EaxP97dMKudxrcbRJyvlRXgR5pB5ISAy3KX5vzPfAyci+hmfgRO+UExMr6nLELW
	oU24uFb0r6xzDbFh0DYcu1Sb8irF7Tk=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1773245783;
	b=A0MgoV+b4rIDpU1VaajHmu+sJYTnNwc3NyjAzhfyySTRShsNxhnLueafjcgO5rsoLDlr/S
	Tx0TDox6zT68fR7ZD0WKcTAyVST0HvImrq0LX4kZ8EnHQmpFEGg5bbr4j0P3YqJE7Ua+5L
	ANBEjP/j0Y4b+v5oNsHfVlN9feXV8BM=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [RFC PATCH BlueZ 0/4] iso-tester: add tests for set & receive ISO HW timestamps
Date: Wed, 11 Mar 2026 18:16:16 +0200
Message-ID: <cover.1773245672.git.pav@iki.fi>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tests that utilize sending BT_SCM_PKT_ISO_TS / BT_SCM_PKT_SEQNUM to
kernel, and receiving HW timestamps from HCI LE Read ISO TX Sync.

RFC mainly because BT_SCM_PKT_SEQNUM. In cases where userspace decides
to not send packets on all intervals, this might be reasonable to allow
userspace to set, but not fully though out.

Adds tests:

ISO Send - HW Timestamping
ISO Send - SWHW Timestamping
ISO Send - Set HW Timestamp

Pauli Virtanen (4):
  bthost: fix receiving timestamped ISO packets
  btdev: implement LE Read ISO TX Sync command
  iso-tester: add tests for ISO HW timestamps
  iso-tester: Add test for sending ISO packets with set timestamps

 emulator/btdev.c     | 162 +++++++++++++++++++++++++++++++++++++++----
 emulator/bthost.c    |  83 ++++++++++++++--------
 emulator/bthost.h    |   2 +-
 tools/iso-tester.c   | 103 ++++++++++++++++++++++++---
 tools/l2cap-tester.c |   2 +-
 tools/sco-tester.c   |   2 +-
 tools/tester.h       |  70 ++++++++++++++++---
 7 files changed, 359 insertions(+), 65 deletions(-)

-- 
2.53.0

