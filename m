Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E1221D3FD
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 May 2025 07:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748330294; cv=none; b=ZJpIThc6KFGXDcFr3HDohM9qlBUgWHfPiFmSF5kdJiERqkvhmzqkl2WncyOfegzjfmiDdV9hLWdJeeUCYgp7+f5ZFD8H3xE8iJdJEhZMaoQLXvw62OaVlFu/P+tE08sKOAeNLuQiSvPeLU1gRTVGLJ/UmLpIB1JT+XVv2ssPr3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748330294; c=relaxed/simple;
	bh=6GjF5KavKa6k7YRIDjO50XZdGpDUzwtipRslS0AppnI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MYQUHYDmJRQInfEVawhAqwMkIZYea2tBwkgzud5uSVz+3SsEKUcbit3Flf/sbI7ocW47e7+BMU8fa2Wes2Uw/nA4D/mGlvZnzllSTrMs1cIcJv3r2UhYcbbDsjvbo/ZsegABrBSMXWh0qYbAZ7+L0y01yYyZzjAuFHZ+Zd0nT44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=OKbsVALZ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="OKbsVALZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1748330284;
	bh=6GjF5KavKa6k7YRIDjO50XZdGpDUzwtipRslS0AppnI=;
	h=From:To:Subject:Date:From;
	b=OKbsVALZ8U/aPYpW1N5GFj9tO5B3V7690Ax0nKb4vGt2+mZghSD2ebXBQw8gg82ub
	 +fE3jGTWDNuUP+poswIkRXVfM5mMQsVkEOe1JC4mTcS98maj1F3JlwtcEU1JjqoY/5
	 bw2DG9Z9ahEmRLXfJubKS7ErNKAkRTNZr50xQRzuGdr54eEJfGLzN8Lx1F3LpbStMB
	 5YnnqQuhWIlXlh4p1wgdYDNGneEzRfKWj6kfo4yQ+h9bh/OCnkTMd1eRuFjMSKE7Xq
	 rah444i5FiRpkUnlw5yHOyrAVk5Oq3q20ptVae4tNjgjVke7GyFBX0dclegNxdP00E
	 jfkxH00TIph/A==
Received: from fdanis-ThinkPad-X1.. (2A02-8428-Af44-1001-2F37-b1f9-024a-369A.rev.sfr.net [IPv6:2a02:8428:af44:1001:2f37:b1f9:24a:369a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7937617E04C0
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 May 2025 09:18:04 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] obexd/transfer: Send Transferred property on transfer completion
Date: Tue, 27 May 2025 09:17:59 +0200
Message-ID: <20250527071759.130143-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Currently the Transferred property is sent each second and not on
transfer completion, this leads to get no transferred size info or
without the last packet size(s).
---
 obexd/client/transfer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/obexd/client/transfer.c b/obexd/client/transfer.c
index 879d67d58..668cefa40 100644
--- a/obexd/client/transfer.c
+++ b/obexd/client/transfer.c
@@ -660,6 +660,9 @@ static void xfer_complete(GObex *obex, GError *err, gpointer user_data)
 	struct transfer_callback *callback = transfer->callback;
 
 	transfer->xfer = 0;
+	transfer->progress = transfer->transferred;
+	g_dbus_emit_property_changed(transfer->conn, transfer->path,
+			TRANSFER_INTERFACE, "Transferred");
 
 	if (transfer->progress_id != 0) {
 		g_source_remove(transfer->progress_id);
-- 
2.43.0

