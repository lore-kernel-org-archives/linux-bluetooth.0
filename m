Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A2A15AAAA
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Apr 2024 18:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712083788; cv=pass; b=kU9wkLmG73qbGgR5OyAtChSxtzFivDjFyhH78XsxPmn4qI0496/gaanz88gQUjK/qJ7Ip0A9Mj97huo73EGIdS1sVvYYsoGuLg2qPRXJZrxJGeUMcIDOgwN/hPPtDtPC/4dPSgEVjMgOct6tKXtraCGqVQjMP/nnAZdhLxIopwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712083788; c=relaxed/simple;
	bh=aL8OwFy62MW581XpYRN/HxtAFS2k3Xpm4X4Ub6SwCPw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tYjYb4J5OcQMG7+bvlSUATvaiPJ/7fj2fCuzBtaekrQk+ToWqaQw0SSqs8zKsVCH8l5/8sNDZweEJPXq1vaZuJprfkznTNKs0OhL6Y6nAhGjUh+WiIqgBwtfydZpMi/RNq+9Qzz/SYtrdqv+EIx1yVEUBKiNmcFQrQYMSx6v9Ps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=MzQYYyRY; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="MzQYYyRY"
Received: from monolith.lan (unknown [193.138.7.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4V8H3d0xNGz49Psw;
	Tue,  2 Apr 2024 21:49:16 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1712083757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aKCpJBX43yCFLigJ6xMVk70zNGcZeYng0frb6at2yNU=;
	b=MzQYYyRYDRx/y3v4IuVxrdCWN3FXGCXSCnSr7aDBcb9MwDEZECydkVkfhqKWDDEv/PxlhA
	yeEWemFlu8n6uCIqhoh0XAU2Qq0UcD2BlccHSxpQtiigp6TfxUUUlJHz4t60pm5g0gr/Oa
	lQPOKCoygchsq6VP6SO1eoQvTyErh+Xp2vIO+gQ+8Gtzuz/G35CNDhQm9aJ2oBdl7CHaL5
	36ajHgJTDSk41GKUSNKyP19Dtfrfiibgr5DLv7g+MBCGKDoXY/A2f+VLykGo1xS4n6NSv4
	vxcElhwocz73CgALAZYe57oDuVndaOOGDgF+ic2+QV44NET5MBWEL3iK9jnsdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1712083757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aKCpJBX43yCFLigJ6xMVk70zNGcZeYng0frb6at2yNU=;
	b=mVURDoxCCr8TdSyi2oudvDCVR5ohM6Sh2yYmJ71hXP1I2HSRmg7Y4ParbCSGG9A8+gIBo7
	INXOOQ2TlSQic3cu8qJzSxVu+1NeqfU6UytY1sJKdFGsT6OEqw5XTFInDkkZNUXhtnGT/p
	wfQgKQ4/D8RZ4tgnDkrPikWUaGOEDbSdiqSW1ajBysbpvQr04ziVTN5TGC42/YWwm6TawO
	35yJ0dp/qdm6AI2huhROj0P3fD1XY/rAqbupEUkON3K8lkW3FoLzevYtx8iJPsUcKyf/4G
	4+mZ+q+ZhyDBlKWrEKE/zRnh8Kij/n+V+q3YnxMYf4FuOEDNhFm+tL7LgYPJyQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1712083757; a=rsa-sha256;
	cv=none;
	b=PUA0XEnvIX163SeWQYTLA98U8tHYd+BBmf6Gld943Q8myoG5L7AW8+CMVwonmIgXmoVbWi
	LSH7uiXiJcn39NqmD5ESWtXZDTmmzAczDCSkIg5ZBGPqksNKp+/o026abBh3hwmvkEY/FC
	PG82Eotivz0nBoBIPO6gWW2L9ex8qvnDwvkB7sG0bUxTINJjLZIuRIz8NZhpA2JfkF1Orw
	E2qvSUvoiFKlciF0DDFWJ3A6JLqBxMnXBlVsgw0RR2zUILTeU4T0gMEKcp8A/l8guapxtq
	oseikwowFE//Jr4wQvKMwOsQLDdOT6r4tPkHX4Nc5aqLWnc7ElH848N/MNQorw==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v4 0/7] tests: add TX timestamping tests
Date: Tue,  2 Apr 2024 21:49:07 +0300
Message-ID: <cover.1712083655.git.pav@iki.fi>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tests for TX timestamping

v4:
- Drop BT_NO_ERRQUEUE_POLL test and lib #define

v3:
- BT_NO_ERRQUEUE_POLL experimental flag enable in tests
- Drop tester cmdline patch as it's unrelated

v2:
- L2CAP LE Client tests
- SCO TX timestamping test
- Fix emulator bthost L2CAP LE credits send/recv
- Fix emulator SCO send pkts
- BT_NO_ERRQUEUE_POLL test
- Tester command-line option -n

Pauli Virtanen (7):
  lib: add BT_SCM_ERROR
  iso-tester: Add tests for TX timestamping
  l2cap-tester: Add test for TX timestamping
  btdev: set nonzero SCO mtu & max pkt
  sco-tester: add TX timestamping test
  bthost: handle client L2CAP conn in LE credit based mode
  l2cap-tester: add tests for LE Client read/write/tx-timestamping

 emulator/btdev.c     |  11 ++-
 emulator/bthost.c    | 205 +++++++++++++++++++++++++++++++++++++------
 lib/bluetooth.h      |   1 +
 tools/iso-tester.c   | 169 ++++++++++++++++++++++++++++++++---
 tools/l2cap-tester.c | 147 +++++++++++++++++++++++++++++--
 tools/sco-tester.c   |  94 +++++++++++++++++++-
 tools/tester-utils.h | 163 ++++++++++++++++++++++++++++++++++
 7 files changed, 744 insertions(+), 46 deletions(-)
 create mode 100644 tools/tester-utils.h

-- 
2.44.0

