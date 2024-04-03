Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE14915099C
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Apr 2024 18:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712168818; cv=pass; b=n6J2UpeQEqbil6QRArPfO4SYxc7hGHef6xYPb44cQv7r96YeZ5KQcEJSBMH3HoG135rhboZL4GUF+5vrOZmIJELi+xbuSP6MFUNJPvyUJ1vAG7TnAADTvS9chu3SV8c7QhNNYWiFMDj/vQH510wqIYqnc/mMYK9c5uV7PNJ/ev0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712168818; c=relaxed/simple;
	bh=jB5V9eAWljdX3T6Dr8ODhqKOUwKUO6Sx4zvgxPVC6W8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DgfkMc8igwFNe8BA6Yf8kNCtP1Ipp9Itfd5kPgNQ/uISCayfqak6YHWc533wg0+zYi7C+R2zTAoD4/hSqEkhPFOvGayo1dfpo+11eYBQfhQkiabMV3Hy5gVlsCADFHb3AfBqUz4sd7Vx8GiEfADpzr2ZvJoJd4MwCnBpBjpbTZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=AaJknlD4; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="AaJknlD4"
Received: from monolith.lan (unknown [193.138.7.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4V8tWC05PVz49Q10;
	Wed,  3 Apr 2024 21:26:46 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1712168807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nk4Za9qGbkhNRNSSrlVFAsnYwwagKzqIsRwy/IOmD0I=;
	b=AaJknlD4v0p02WdyPya5sirkE145OfndPt0XpwqbU6R1ACaf54aJC0fjcI9vW8RbwBuSaP
	Zs+aQ4ONkrgJfz5IQFifR6ifS60MVcyVWQU5GYGMshZyVF+Zx5BI32eZ6B1vWpIWY3NfBG
	lUv6YFCEVzVHZ6yCnwz26cG00MM1qSqECHHvz2bwLrxeb29gXXZzfmtu7wxrXlCwH+8R2Y
	bUFW+Es3CohGY115eb90/BTMdx6M3ibkIPnBpvF0upL6QGBTAMTY04r9Kubt4pnZbHVS8R
	ZlrIO5Z6/4xsrFiPtCjm5/Sthz+C6gpqPO9WL3aV3yPUH/CNpZNp4JHaVTDVYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1712168807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nk4Za9qGbkhNRNSSrlVFAsnYwwagKzqIsRwy/IOmD0I=;
	b=dJ0YNeVQS307O9WLh+W0j7JfmhMNepOKnVibEdwFRyCjSdUyPuykHOu3i/L+cwAkbdf/2m
	lkXlbYY+G4YIiCM1sBis0LOlOsKPZxARE1lSwL843JAKe2VpqZ2ev+o2/oBR+q72nCiG8J
	l1GdYeGREdh2zM0I23Tksu/oQzclZpFcioA+qAc4ncJku5BxkXG64CE9SgKeqCYldQ0iNG
	mztdJZmIpreJ8ZmE0PPboLE358VRNrTiOrtW9A13Aiojg8FcOsE4pZVgwvSGKpe5PoAMgc
	dT4srDkDBCS6j3Do9MlooQtdsXbBXc3/UQxHfXXGmy9oP9Tm5ogv2wlZ/4MxAg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1712168807; a=rsa-sha256;
	cv=none;
	b=kicqRS7WuYJdDfaiq9zbSUit4r4P4oxrALbXRD+y7ix9Zgar1w3ptQlMNBuHCSG/plzD1o
	xOCLtDvuHPPLFseZq+F9mbHoILU91NYSt3p430GMbj/KXEjAtPJuWgg9iTzhtIQ/41jhz/
	sHVYiWHKrcmtXoOJ11rRbVlVf4hdqzo0sHRs0fsAvuF5h6QZtyHshVWvh0pvmOzii00Hfl
	Z6pk4BbtGGJXRyEcxZ2CUA+/4iSj1JPXZYz5Pb16dcCQjqO+bYYAc842VR+M4cw13P7L9V
	oqzz0ytmHiSA+qJNZe+0pLRN1jWoApIZCoZ+MT399ZD7fnHOlmjcsKTfU3mnOQ==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v6 0/7] tests: add TX timestamping tests
Date: Wed,  3 Apr 2024 21:26:30 +0300
Message-ID: <cover.1712168788.git.pav@iki.fi>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tests for TX timestamping

v6:
- Rebase.

v5:
- Add comments & rename send_extra* test data fields
- Rename tester-utils.h -> tester.h
- Use int, not struct so_timestamping for setting SO_TIMESTAMPING,
  as CI seems to be running old environment without the struct.

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
 tools/iso-tester.c   | 182 +++++++++++++++++++++++++++++++++++---
 tools/l2cap-tester.c | 148 +++++++++++++++++++++++++++++--
 tools/sco-tester.c   |  96 +++++++++++++++++++-
 tools/tester.h       | 163 ++++++++++++++++++++++++++++++++++
 7 files changed, 760 insertions(+), 46 deletions(-)
 create mode 100644 tools/tester.h

-- 
2.44.0

