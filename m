Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038713DE42D
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Mar 2026 16:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773245777; cv=pass; b=gPxlcZSIlHswZS2ZRqcY2i8ydg2/2U4WYMv6E5zhT4oB49oYVhBZdZCxkLlYEZg7+K5D1gmyWbOZYoxAkTdD/zcYV1x96SAKw/ublmq6RbMRAzcI5h1CEIvE0J/7xz+etDmR+sqqc0Hs9JybzOicFTUJWoaigePIhe4bw3toyX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773245777; c=relaxed/simple;
	bh=+JFqwlirb/rtbPjHWImtfjfKbdABbZLJXmcNKMOBNKo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nmYnr6byoVuWvuxhyP2/40GcPhanX3SirwHAP/8CftsDJKf0feGk3esqoQt3Ggn4Xq4b9JduikLeMBE+MwTlkQhi5rplHctt/MckVwtTBVjaNllxkqXNG1CuyYsatMmjlnnC/I8lfAuqEyp2YahP1Wf7jel4O8W4kzzgDlJhSbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=knmC/wXm; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="knmC/wXm"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:d:f011:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4fWG861FPGzyTZ;
	Wed, 11 Mar 2026 18:16:06 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1773245767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EExpn5BO6rJgFng1/HfdoKh1WHXGsP0wSNd7svpynqI=;
	b=knmC/wXm8A92Ue7sbx6PC4sTBveeGxOQvp3oVRAa+irTv4BVaBDjBAI+2j7UHasVxPZtSE
	v9r8NmuLXWGFTSb4QNndmwBd7ajGGjF1PJOPrea2vx4q7Zfpltbcn5LLkQJ9abB6UqDVfb
	5+kjw478xB1YIn9dMpO2Zj78we6LZxM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1773245767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EExpn5BO6rJgFng1/HfdoKh1WHXGsP0wSNd7svpynqI=;
	b=QyfOPGH+Qgi+8vcq05/9xdI2xvKMqDd1o4oEgevnhx9Ah+hl0+1t2BldC0de/DKDWY7ex4
	2fbOkokNu2xHu19pF0Azy1533zMhTtL5FlQeDSmTuK8ZJQJkbwLCiio9G/+WgpfRZ5aIUd
	ZNJXzkADafuCBQ8G5tRPLiUciXvJe0w=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1773245767;
	b=WT2XB4+aP0LyRprRflvC2MUc2nBBDX67puYCHkRJ7pQm8YBe+PdlLZ7YKNvNLPya8vOf5Z
	p0WqwtZahP/JDba0/XAhOt6ZpofU8p1Y7yCYMVqW5zG/GbnlhoVs0Gocp4vpWlXhW7dGjE
	sepwcZgE8ruXyZItabB2sb6WJVCdDmw=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [RFC PATCH 0/2] Bluetooth: ISO: support setting send Time_Stamp and LE Read ISO TX Sync
Date: Wed, 11 Mar 2026 18:15:49 +0200
Message-ID: <cover.1773245666.git.pav@iki.fi>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for userspace setting BT_SCM_PKT_SEQNUM and
BT_SCM_PKT_ISO_TS as CMSG to provide timestamps and sequence numbers to
controller.

Also support obtaining sent packet timestamps via HCI LE Read ISO TX
Sync and transmitting those to user as HW timestamps.

User-provided BT_SCM_PKT_SEQNUM may make sense if userspace is not
sending SDUs every interval, and it is in the best position to determine
when it wanted things to be sent.  Behavior of course varies per
controller, so not sure how useful this is in practice, and if it's
premature to expose this in case there will be future clarifications in
the Core Specification (no idea about whether that's likely).

RFC since this is not satisfactorily tested on real hardware, and there
may be some design questions and ugly bits here. Sending anyway since
there seems to be interest in this.

I also send the series adding iso-tester + emulator tests.

Pauli Virtanen (2):
  Bluetooth: ISO: allow userspace to set seqnum and timestamp for
    sending
  Bluetooth: produce HW TX timestamps for ISO from LE Read ISO TX Sync

 include/net/bluetooth/bluetooth.h |  2 +
 include/net/bluetooth/hci.h       |  2 +-
 include/net/bluetooth/hci_core.h  |  5 +-
 net/bluetooth/hci_conn.c          | 53 +++++++++++++++++++--
 net/bluetooth/hci_core.c          |  8 ++--
 net/bluetooth/hci_event.c         | 79 ++++++++++++++++++++++++++++++-
 net/bluetooth/iso.c               | 70 +++++++++++++++++++++++----
 7 files changed, 199 insertions(+), 20 deletions(-)

-- 
2.53.0

