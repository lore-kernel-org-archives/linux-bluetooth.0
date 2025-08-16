Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3958B1C5D4B
	for <linux-bluetooth@vger.kernel.org>; Sat, 16 Aug 2025 08:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755334624; cv=pass; b=P1j30/H/1vhzIh26xq3UqZW0MaGrk7fGSXs7HClxUxK02gyhJs2XCVpcbdT+dhd+eXn2KHq+KzJ/7r/c5Ue0RKrFSsLAgZBLNghcDOr4Y93Z84MWj37mPZmLZ7R+QeAzjsKR95YVn3ZnuAotnvXGGue84FSgWo2zZjJ/mqwimuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755334624; c=relaxed/simple;
	bh=8Ag2pprYvqKqL6pWunbSGG+8Yl2W23UJ/RGaB7/nJR8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R2Csa4G/39jrLmY+gvp+U0xgUPZOl5cIXkpWbgj5NLnWu1CGbuX1jXZsqWRgfRNG/d4l+941VsYrefm418A95mrqFceOSsLQ7u5vTvL1N9bTANgUEE0+7OffJuEWKA5JZuilha6jd9gyVcz1r6U5yJ2il0T6eq+UXR4onHf6Iy8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=PJAhCtPb; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="PJAhCtPb"
Received: from monolith.lan (unknown [193.138.7.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4c3tBw425qzyRb;
	Sat, 16 Aug 2025 11:56:56 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1755334617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=h+SPSIMWWP+w9jbZMezmw91ZEO2B/8AbB/e8GKSDwUs=;
	b=PJAhCtPb//5PkT8xfE3GrgaoG7QqgVkakBqj12nr6upYJ++Se0ZPUkGOI8z7NzWaLDeqic
	qkoZ7rdjE6Ig2bdXruGRotvc32YFPI05KVG6qRp8eas44mgbveVuPDKx7LWKFexWPjVPWj
	Mrv4C8arTQgg3u5WX9xLM8bYInMrZOk=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1755334617; a=rsa-sha256; cv=none;
	b=EuMNGw0soKfC2VfyeXd5zHhfXZ9+ky7BMJYpG/yxpZII7+i8Ro7kP+RA378xvGybqmqvPy
	vhiqGMfKY9jZt/RhhFi1BBKFPymIpE0Hx1+/uHVLa5/wJ41KsxLyqP2a9/J6zEkayXL0mc
	vskUr5tgAQnIgbDeS4RRnoNPSskc/0Q=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1755334617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=h+SPSIMWWP+w9jbZMezmw91ZEO2B/8AbB/e8GKSDwUs=;
	b=fa8KThTuQ8vTyo08aw9BzznJ1Xr5C8XE9IjfqHEdUB8wx/4fi9JwDqbS5ZEUl7rQgVHh+J
	RcTJCyeg+thaIHjU0B/hz/far9yQWzS9j7N2uaN1WCfBCNamhre8RCeQYPT4YjG8KKvLZy
	qsmetxWQCJJ2BkElmh631g/BRR0pJE4=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ] transport: fix A2DP Delay values missing from DBus
Date: Sat, 16 Aug 2025 11:56:53 +0300
Message-ID: <b2fba95d658c75135f0ee7b4bc11e193be126622.1755334561.git.pav@iki.fi>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With headsets, a2dp_transport::session == NULL usually until stream
resumes. During this time, delay_reporting_exists() incorrectly returns
FALSE, because streams corresponding to NULL session cannot be found.
As no further "Delay" property updates will usually arrive, the property
remains missing even though delay reports have been received.

Fix by setting a2dp->session when processing a delay report, if missing.

Log (bluetoothctl):
[NEW] Transport /org/bluez/hci1/dev_XX_XX_XX_XX_XX_XX/sep2/fd1
[CHG] Transport /org/bluez/hci1/dev_XX_XX_XX_XX_XX_XX/sep2/fd1 Delay is nil
---
 profiles/audio/transport.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 2b9832a76..ab149bcd7 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -2649,6 +2649,9 @@ void media_transport_update_delay(struct media_transport *transport,
 	if (a2dp->delay == delay)
 		return;
 
+	if (a2dp->session == NULL)
+		a2dp->session = a2dp_avdtp_get(transport->device);
+
 	a2dp->delay = delay;
 
 	g_dbus_emit_property_changed(btd_get_dbus_connection(),
-- 
2.50.1

