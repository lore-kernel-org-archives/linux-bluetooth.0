Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795514449;
	b=axMpHz7InA20j/C6sDf8/mDrCnMwqW4hZlf9ZBSY63lJrHrBssxLOk4VCAjpA5Lym3R5
	 4g7j51rx3XqVfH+dUJ+RJXVuAZLWDE7k9FmtR13v5AbGOQ1EzzqqW8n6QY+bBv4NzJJjn
	 J6wtXHC1yBTZliXyJj4YyEDJm6POcI7yNe9rwEdhRxXOoFdUJBjS5hq7SBblYsw+hJLGF
	 75RwJQHpnvJRuxAsGQbPLCaRVcy6T3zGMTD/XHS/+xCIhWmO5xxVFydu1zhCwmHwFduIS
	 GMP7NNx02EqhfPgszE0eau/F5EXFDTeXUpvEjKF4okaah87Yfz2ksp75Qhk5XqI2gIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795514449;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Type:Content-Type:
	 Content-Transfer-Encoding;
	bh=FaAwduUVUkvJVaLaDJyxuLe34tZJmzszApSEW7y60rE=;
	b=nmFxXhIUWt2cbezpxPiB0mTKyKFxko/lvalR5s+tSZn+FalsgWAzPMt6KYcpI1Rl3HOm
	 V74b7TiuL+i1MiOeTXQFab5ZASyidwfQ+GMH86Bx5HDB6PTI7r12e42e1dyFioiDWpU6N
	 36OtDg8VwXZ+0X9ZzsgajfGP45W05Deh4lpUXoxcWzuV9QzLt0hOudtDaBnaMBFjgyUUa
	 PWeGo9cfaeSKmLEVB/uRRCcHnnSszFfxwrbVqqYvarjYE3bg4oRIg+SbfVunAJhsK9kW+
	 B7nUO4afXEH3D552+mHXO5v+6tcnHLpVLOQWeh8YTmo9vWJ+CsLbdSKEA7C+78sniJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b="aNKrIo/w";
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF64606A32D
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 10:00:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DF64606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=aNKrIo/w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795514441;
	bh=MAHykyVxzDT/sW7h8EV1IC52v5MuyFqPQe55KB8TN10=;
	h=From:To:Subject:Date:From;
	b=aNKrIo/wzFzkyIxtADeiQkFUCGrhYyzE5HSznSnktTyl7Q8nT9EKb0GWo+6jfYGh5
	 mzdDf1O8z5uFkGUaAZdDAzAnMW6N4LHmmiuIjTqTEYFZDbYenDscT4iwgjVXsw1LuP
	 1EAhM6ws4v71xo69uDlf9Ervf670C9jy5ziudb9r33m7yFquYfuJ+R7VvSXn2T1A5+
	 kRp8i26Y6Iec+z8ZsQ+4odBh1nWzS+9vQUpxO0B/lWBuL/phihnwOmNO5Y1dNYpu9z
	 H/yanEgGU5pTRHQvHqhlMk+9pCIFc+yn3pAkK1hbw+HbpwGx4/BLiV4EpK96LZvGGL
	 TLO61IOQBdXcA==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1497E17E091F
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 11:00:41 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 0/3] client/btpclient: Security Level reporting
Date: Tue, 24 Nov 2026 11:00:32 +0100
Message-ID: <20261124100035.245953-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Set org.bluez.Device SecurityLevel and EncryptionType properties to
optional so application can access them only when they are meaningful.

Send BTP_EV_GAP_SEC_LEVEL_CHANGED event from SecurityLevel property
changes once the device's services are resolved, matching the BTP levels
expected by auto-pts.
This reduces connection time for the BAP tests.

v1->v2: Retitled patch 1 from "device: Provide Security Level related
  props when supported by kernel" (subject line was exceeding the
  mailing list's 80-character limit with the series prefix).

Frédéric Danis (3):
  device: Provide Security Level props when kernel supports them
  org.bluez.Device: Make Security Level props optional
  client/btpclient: Add BTP_EV_GAP_SEC_LEVEL_CHANGED support

 client/btpclient/gap.c   | 52 ++++++++++++++++++++++++++++++++++++++++
 doc/org.bluez.Device.rst |  8 +++----
 src/adapter.c            |  4 ++++
 src/adapter.h            |  1 +
 src/device.c             | 13 ++++++++--
 src/shared/btp.h         | 11 +++++++++
 6 files changed, 83 insertions(+), 6 deletions(-)

-- 
2.43.0

