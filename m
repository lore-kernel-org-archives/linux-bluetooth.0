Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FA123AD
	for <linux-bluetooth@vger.kernel.org>; Sun,  5 Oct 2025 22:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759702683; cv=pass; b=FjXenJQ47r8vNQNsQhEnLB3vSXyHxUlc8lSR/RI1LuGOHhRcMYMyOAocR2ui9dpWg8rkvu0HlJyWy1ZgsztpZa1g2N/hs+fdWAfOfVm/QCSiDGygTBJOZjAx4uZ+nr/e0qrj7GDZp7pPDj340U9/VGPScKemZH3+rBGxC6J8UA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759702683; c=relaxed/simple;
	bh=Uta5NtReha88eEL6w7LsOr1WHEqFPD/rfKOgU2otAYc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pHpJfDiWisjmQ2T4m2FCswgymCaUjqxEwLhOfKNWcWfeLf30vOzgkOo2rUrvJkqLHkED9yM3bm58gubY7nad8sLpFvk3pgG4KQi7r1y63PvVhdfH0nSC4Bj+3WrHOpoF9WrFil3G0IqPzS6AuzZnYHGhUjpmEewbCayP2msUmm8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=A2HDDtLy; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="A2HDDtLy"
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a02d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4cfxbv6kC3zyR8;
	Mon,  6 Oct 2025 01:17:47 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1759702668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EeBi9f6YIhKF9XpkLG3yxflbcMbPCLmCqJPlwJGx9DQ=;
	b=A2HDDtLyQng1jWEdLCOmEzjn2aUjbxIdBT3fDzO11zETwPxYTiiSnolQTkWwCaOx5yy2qm
	TWDPSKSb8lGIfmXsAhu2esOKkSohAuox/44RpGdVmHjzG3/4+4HCTLBZHo9JAZR4tiHtIr
	G7I4Eb6UElUbtJQodtK2JjptTBCkgdc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1759702668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EeBi9f6YIhKF9XpkLG3yxflbcMbPCLmCqJPlwJGx9DQ=;
	b=TNtvC5o3/EavhqZGkQkh6Bhb0Lo5dcOVVErIF3nnvvG8VDrssucH8NRU/fVKczBvQ4nLil
	sCyDrv40/+dDMY9tftYu8Kuiqm0io8SGUBmiO5OwzKRwnHdp0lkwGuDsKPvxxe4j0KJBgD
	+CqDjCELzf3GOAkIcVe8jjMY7zFC2fQ=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1759702668; a=rsa-sha256; cv=none;
	b=O6oQL6vuVPpuLBWqDhV1+WC5qbJoR7pgoPutj6KT6YwgG/ng+25pYFZZ5KPcoSJTPCq8MV
	0bxRAL20MSZaa4Z6Gb3pG+nuJTYuysoZQXLEJGiTOJru5QKo0Q8SV68FdKrN2dYiGTph3Z
	S/iE7et9QkmmGCam3FCli92TqoR+4Ps=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 0/4] Add 6lowpan-tester
Date: Mon,  6 Oct 2025 01:17:38 +0300
Message-ID: <cover.1759702519.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make a basic tester for the net/bluetooth/6lowpan.c implementation.

This module doesn't look like it's much used and locking around
l2cap_chan / hci_conn there looks suspicious, so probably some tests are
useful.

Here just simple connection / disconnection and packet RX tests are
added.  Some issues appear to be there:

Client Recv Raw - Success
    -> kernel panic (kernel BUG at net/core/skbuff.c:212!)

Client Connect - Disable
    -> lockdep splats

Pauli Virtanen (4):
  bthost: handle L2CAP_DISCONN_RSP and remove l2cap_conns
  bthost: handle L2CAP_FLOW_CONTROL_CREDIT_IND
  tools: add 6lowpan-tester
  doc: enable 6lowpan in tester.config and explain in test-runner.rst

 Makefile.tools         |  12 +-
 doc/test-runner.rst    |  10 +
 doc/tester.config      |   5 +
 emulator/bthost.c      |  93 +++++-
 emulator/bthost.h      |   6 +-
 tools/6lowpan-tester.c | 657 +++++++++++++++++++++++++++++++++++++++++
 tools/l2cap-tester.c   |   3 +-
 7 files changed, 782 insertions(+), 4 deletions(-)
 create mode 100644 tools/6lowpan-tester.c

-- 
2.51.0

