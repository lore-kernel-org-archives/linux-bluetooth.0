Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CAD38DD2
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Apr 2024 16:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712076194; cv=pass; b=c12A26Yf7OoE2d+b6uFO3IxEFRssmt3rIsIrIwsVsU1MXAPMEEVciIuqBIgHl2ZZb2IYshY7xBqeZuFHK43ikb9P7AHpRuis6gLK4G4vL6T+nEeuCbrK7mx8z+6FhcvWXziqNxTghz1QktvnRDzNcbXBtRWSxNlKSd56DqmXU5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712076194; c=relaxed/simple;
	bh=bgdrKKzVaj9O/5siQbonr/BBLD7grpeAnx2TGl+N4wI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WUBmMwn0sKUausrFyu+PAU4puN2SDPmUgFu7Vr35mUJ/E97gS/X7RckzxK2QxjhncSwBui9paElbt9WOZSU8NvrcL0Z6Gn3lRtRcW+1pWO6iP3+Xey05XYmPY47bZWY31H6c1W5k904bX6k3a9Ig2dwiEdwz3CCdlgwKLiSA+YM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=v/AjLieF; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="v/AjLieF"
Received: from monolith.lan (unknown [193.138.7.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4V8DG56DqdzyTX;
	Tue,  2 Apr 2024 19:43:09 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1712076190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lZMvxhHdxKpoG9GqA3FEMFAfZUyA6bhe5nEIIl9m+oY=;
	b=v/AjLieFRVh7/bdiISG0HtjOdaFQvkK9z7GZBBRwO53FKtoTE1oIuaVmqswDUdjrwUhJc3
	fkja+TOk83mZ9xyDibQvAtznFcmYcgGlBSDl2z/G01LcKgm1TXvd/r4LDEZP7NusLZu//o
	mslrN4mzh19T2kOLMh4LFRYIy7PCyMQ=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1712076190; a=rsa-sha256; cv=none;
	b=ywOkjtTSqy7MV+gc3Q35JnvV/HSx6TqVIRCD9VPowDm55RHUYn5nZPeF6wl4y2sgBhl0Dk
	VXeZCdOaxM9vO2gwj/YKCH487kK+2rYZV2UPUoI7ySGCBYiWY1DcbuoPr7ZqM7JVwDoQlv
	B087HznR15R6QioY6EuZ88rLKfko1Ns=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1712076190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lZMvxhHdxKpoG9GqA3FEMFAfZUyA6bhe5nEIIl9m+oY=;
	b=O0qnsfvE6jSsOe4Ax8oGUdGMmZvrRGYUFtINBlOGQSz4lv1kWUy18LwaI1dkHEbCV6qkLs
	upYYHmUIxWXbTBOMVpQzLvu/QdAlqTjxrzKKktyNxm/o6W1QHqv+knl5UqGgjipvhA1H9m
	LaqcZm4ENEPiRaHb/qEuZDYjV1DRjaI=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v3 0/8] tests: add TX timestamping tests
Date: Tue,  2 Apr 2024 19:42:57 +0300
Message-ID: <cover.1712076170.git.pav@iki.fi>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tests for TX timestamping

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

Pauli Virtanen (8):
  lib: add BT_SCM_ERROR and BT_NO_ERRQUEUE_POLL
  iso-tester: Add tests for TX timestamping
  l2cap-tester: Add test for TX timestamping
  btdev: set nonzero SCO mtu & max pkt
  sco-tester: add TX timestamping test
  bthost: handle client L2CAP conn in LE credit based mode
  l2cap-tester: add tests for LE Client read/write/tx-timestamping
  iso-tester: add test for BT_NO_ERRQUEUE_POLL

 emulator/btdev.c     |  11 +-
 emulator/bthost.c    | 205 +++++++++++++++++++++++++++----
 lib/bluetooth.h      |   3 +
 tools/iso-tester.c   | 286 +++++++++++++++++++++++++++++++++++++++++--
 tools/l2cap-tester.c | 147 +++++++++++++++++++++-
 tools/sco-tester.c   |  94 +++++++++++++-
 tools/tester-utils.h | 166 +++++++++++++++++++++++++
 7 files changed, 866 insertions(+), 46 deletions(-)
 create mode 100644 tools/tester-utils.h

-- 
2.44.0

