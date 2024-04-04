Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721DE76044
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Apr 2024 16:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712247695; cv=pass; b=a4+9B8F3p9tEjjlIrVI1GxR3sk93PSXbIY9nAT9cKazuyrM4bYPuNwjfEo79TOTD8ikkG5DF//URe7kLnbLuswqf4JJ5sply5ouXwgEepqTTDDRcKAnclKYrM4WLP2U5nh2a/TNZPpCw0n5oIkAJLLbsgbvdglLAAtOwkHBY5m0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712247695; c=relaxed/simple;
	bh=mdJoZW1SknHfooohRUiR4UNHTLRK8mJbqqyvZ96KwRo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SlSvZrU61Uwfrj364qX6BaxNw+hyncw9BZUwRAnCir/CFOYpM7LNx49j6492ShK6/JdDP4FN4LS7tZOa7lWVjWnr51+OWOkm9tU09wj18wBWXYAbczkbmIa7EnhrnmTGF5FL0Sm9cNP/tyT4/bCge8jHzwhqN5QlGYXQpju978k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=tA4+vNx2; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="tA4+vNx2"
Received: from monolith.lan (unknown [193.138.7.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4V9Rh82lZBz49Q20;
	Thu,  4 Apr 2024 19:21:28 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1712247688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3WpY6qo+95LyKy/WeT14j/sEkkRJAapCuQUeb0p5jdM=;
	b=tA4+vNx2IZ4M9StggUD+dd6mLvrSD05ecvSKDoGOXhEeiMn6Fu3F/wZZa5CxRIb2hYFuIH
	mGUvEbaNzSLVyJ8qug7VvgRsh8rtCs/uABCPhEUpE10IAvDoeXl8hf4b/4AlTa97b6ykVg
	+97h/wOv1tEC/In0uFeetaWCRzQiug2aBVWQ+IxMI061y208du8Vyu9okhLnFRN1m+0hWr
	/UGG9jZ5HNxS35FzdlMoI7SKTqPdUlBdxd6keKjSBN6mDJieDJeBsF+l8ivipK5Fc2ZRrk
	KBurkWRHDLcKCTqPrHTgVnJnNA/FcaRMxuFUGBTGKqg+mfkWtnFXdUVR2ChFvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1712247688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3WpY6qo+95LyKy/WeT14j/sEkkRJAapCuQUeb0p5jdM=;
	b=TFwIPssF+X+bcn5Hf8oeMbt1QWpbk65jxcb5cwzt+Ic+GWgiX0oHlWJU4vrTHzZLr2nWZk
	h1OkOfzXQoInhqiHpPP60iN+Xpoo0yU9yg0lZbaWkKoEbqMhf9taUD8tQPCeNk4qiorc0h
	NRb4mrw4XVwNK5b8L6r4hjPuIn3MG+PYPQ7uUKzT/KEzziYP4QE48zro7gFHf0LFGIytvK
	FfW6R8FvtjOLYKjG4OsP1KNURKVqRiXmztFL3bGUKRKQ0G5s5vrdsx3WQ3qWrfwhJKh00s
	3TXOvTw3AhOIxZmfgnUgCzu75+eRj12mjFySiu73XwXsbJElPwlHB6jgqd5j3g==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1712247689; a=rsa-sha256;
	cv=none;
	b=FqeAfOPoJjhoqHlOjft7FaXJII+NnsDNYRDFBM7nyfBi91i0qOc1Gc8+NIf3C9ZFeaxGV2
	NLuRsTJ01nz5ux4X2bd7mRdZXpDR1dt0lIKfGlUyIV/tei1UgYtRmYOQURMmKbmzOBzA/j
	82QD2aU0hiuLPSIFX/9e9aMHMi/yG8rL38uXLi71BkFOXwJ9EBYXK8ZZ67kNimOwLjjBkN
	j+Woj0I9H1hqPBjIAEL4xkT3mknUd6HNx8ODFAfqXLwbsUmaVz4x4VbwuVJkiPqDBtQIxQ
	d7cmZNuX/KrKaU3dWGSzjcfmVcIfYBwtqTHTCv2YOWnGsRzRWoZNMY/7svzKDA==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v7 0/7] tests: add TX timestamping tests
Date: Thu,  4 Apr 2024 19:21:16 +0300
Message-ID: <cover.1712243675.git.pav@iki.fi>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tests for TX timestamping

v7:
- Fix CI (false positive) compiler warning in sco-tester.c

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
 tools/sco-tester.c   |  98 ++++++++++++++++++++-
 tools/tester.h       | 163 ++++++++++++++++++++++++++++++++++
 7 files changed, 761 insertions(+), 47 deletions(-)
 create mode 100644 tools/tester.h

-- 
2.44.0

