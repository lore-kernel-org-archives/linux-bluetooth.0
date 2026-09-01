Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34863286D4D;
	Tue,  1 Sep 2026 21:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788296696; cv=pass; b=N9JDLRqOHap1mPNYMknX40Nho72KSEyyeXbAxJEzJmGouzd8uo+UYf24Be7jUtVjpJgU+maGeR46MwIQHCnngIztvdPOkJCdit4Q6k0ZyPdZ7wxPyUZ6qmNTP1yk8AX2eB9anP/V6lpjMPV6d1D+87VsmvNdO9JTEyG5bwqwgn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788296696; c=relaxed/simple;
	bh=siRcIqafrLLrJiVn7kcwViYKjxp+wOX5zovxcRqNsHw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dZuZOw44HQ6DgChVefKCnv8ZmDBXZwUeSdbOs3ie6jt6/S/GcSiteytN5zM0CcSGw4Z434V7tzQ7hBhqroqbDAPl76Fn8FYwMmAi40tLuG6wpAyx9XHtNytvH2MSSEUZT4hW8QGQ3E5WTbzrJz98tr42LG6XABs541NWIaoGecs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=CoLXucQm; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="CoLXucQm"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:4:f011::dd01])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4hZJJn1h7pzyQn;
	Wed, 02 Sep 2026 00:04:41 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1788296681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vzMIDexbNd2TMfdTcW5E1/Lh4MABP7e/J0+mTr41DDk=;
	b=CoLXucQm4qUWSoPm+4sv3TZCzbz8ABfhvXf4HLJBRTwp4GC9vVRdtrmDDBsvf5yS1IJR0a
	OCHZtunqThmNy+ZpkbSGWUP/OeHaziuqBzLH5mgITYAQuB8KK9Z97ZLY3ykj1ZRIssOfud
	6s6RqliBosnv9Sg5LioE9P4azOwhmA0=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1788296681;
	b=bONV3/X3JD7UGdr4Pgit0ZCcTmOrZP8SsEZI1V6GbCJDWLOyBUOTdp4/qmzeuEMrOr2pdx
	C4enhHTZ4uqh4vsOoqBpnwvydo6wIR0yP8jeuCxSWWcDhWxnQiCq8yiq5A+jqmmz+cXNz+
	0CKlT0EQnfXXK555We4ybH7AemTPlcI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1788296681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vzMIDexbNd2TMfdTcW5E1/Lh4MABP7e/J0+mTr41DDk=;
	b=o97b0Fwtp0hQcFDKNqRhy/HSg9KtXRtQ4qqtXgd3ArpfnFWgOXuyFwhknkKo1GceEnZ9QY
	v6Evlkh0YHWS88lnYCKUjt61JNYPPRKV0uZRA0z0vsqvII2iMCRLYWDQVsfnTUsmCbaE0F
	uXG7N/y4rSTiLkIoHxd3GIXe5Qo5Rrs=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	elver@google.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] Bluetooth: L2CAP: part 2 of l2cap_conn::chan_l locking fixes
Date: Wed,  2 Sep 2026 00:04:32 +0300
Message-ID: <cover.1788296635.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rebase to fix conflict in remaining commits from series
https://lore.kernel.org/linux-bluetooth/cover.1788013041.git.pav@iki.fi/

Fixed minor conflict vs. moved mutex_lock + l2cap_chan_lock in diff
context
commit ddaccd985bb0 ("Bluetooth: L2CAP: fix out-of-bounds write in l2cap_ecred_connect")

No other changes than resolving that.

Pauli Virtanen (4):
  Bluetooth: L2CAP: take lock for l2cap_chan_del in
    l2cap_ecred_rsp_defer
  Bluetooth: L2CAP: annotate locking for l2cap_chan_del()
  Bluetooth: L2CAP: annotate locking for l2cap_ops callbacks
  Bluetooth: L2CAP: refuse __l2cap_chan_add if chan already has conn

 include/net/bluetooth/l2cap.h |  65 +++++++++++--------
 net/bluetooth/6lowpan.c       |   2 +
 net/bluetooth/l2cap_core.c    | 113 ++++++++++++++++++++++++++++++++--
 net/bluetooth/l2cap_sock.c    |   2 +
 4 files changed, 150 insertions(+), 32 deletions(-)

-- 
2.55.0

