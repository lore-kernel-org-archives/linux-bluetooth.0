Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4834A3AC0F
	for <linux-bluetooth@vger.kernel.org>; Sat,  2 Mar 2024 20:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709410204; cv=pass; b=mqfobRcVArF8gA8lPxvlk7ympWi/0yV/tGhKM0O1aMVi9H0mBt6kmF8bX3TVX6PH9XwWOCM+FjrTXig7b1kANGTWk6s1Hff0GJFIM7B99y5wlgglIFNsX54TN0Va9Qnfe7ZhNQaqjtwMDxX25mp3r5JJD8IAfmDqwxZ46y4x5uQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709410204; c=relaxed/simple;
	bh=yHroH3k2SAJ9qjG0+XjEWDPJbUUin6gQKhZK7BuCfEE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Njxud49e3AWABs8kVU6KNK9bO5+A1nQhIX9LwIrGDO3oqsCDEelErOOCrUSAPNRxDQbWuTa2cpORob+AussPfSXLHvhBDvjNaNPUC4lnFydUUwmS88U3TJRV6clJ4+8A2RrnWpT15GF8AkkngCEFc9Gk2aFjQm25Rric8nIYXDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=N49q9gRZ; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="N49q9gRZ"
Received: from monolith.lan (unknown [193.138.7.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4TnGK26x8ZzyYT;
	Sat,  2 Mar 2024 22:09:58 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1709410199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zHDlSpEUYMyRcfyJHwBAzywyvGDVeeuki0C9cHEHRtY=;
	b=N49q9gRZHop687DJc5FRzb0c7ZzZZPW0Ub/99BUvKRvVZ4dRA+Z0nwcapZ16VRPJ6AqnaP
	4r3nGtw8SrMlOgt/xYngF+j7etNTJyuJ3GA9n5F4Kh2SFoWgK1rLvnrdKYi9VZsBLbasyV
	Uji2oCnbEl+hkRDCChuFQBDbKtlRfGw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1709410199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zHDlSpEUYMyRcfyJHwBAzywyvGDVeeuki0C9cHEHRtY=;
	b=LLrt7vRBortRcjzf1rrhNCuiXjUsXLiWtDzcpym+8pLQx822A3t9VGvm4eKOZEeHKja/Zx
	j59KKSrgwUTwEjoqupLePzHdEV1FqtA3Iu/ATxecA4MJTyNZyladPluSCeMqOIQCKDu0zv
	IeIysn8hjexwklTtEp3Yt3l/BKrXAGc=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1709410199; a=rsa-sha256; cv=none;
	b=duu+rl1xUnQD3ySFQ8tyNYlTu0OXoE4o3H2dkWy+17F036a00BdcMwokpEin3w7yiRsk3Q
	LXBtjQWDnA673uT9+qySO8mwRPM5JTKzhRdOY2V7XVbifZ6FKfAHI30ctB/aHA2XBoAUJ1
	QuD5i2jdFYGPB0LGiCakYTw2dbjNieo=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 0/3] tests: add TX timestamping tests
Date: Sat,  2 Mar 2024 22:09:50 +0200
Message-ID: <cover.1709409039.git.pav@iki.fi>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tests for ISO and L2CAP TX timestamping

Pauli Virtanen (3):
  lib: add BT_SCM_ERROR sock_extended_err CMSG
  iso-tester: Add tests for TX timestamping
  l2cap-tester: Add test for TX timestamping

 lib/bluetooth.h      |   1 +
 tools/iso-tester.c   | 169 ++++++++++++++++++++++++++++++++++++++++---
 tools/l2cap-tester.c | 106 +++++++++++++++++++++++++--
 tools/tester-utils.h | 163 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 424 insertions(+), 15 deletions(-)
 create mode 100644 tools/tester-utils.h

-- 
2.44.0

