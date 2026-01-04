Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE432DF3DA
	for <linux-bluetooth@vger.kernel.org>; Sun,  4 Jan 2026 20:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767559881; cv=pass; b=Pntupg1gpYPXWLqyX4g9sxGDjCnxQm1BCRE4l55HIxJhqTgoXIh4AWKeOsJND3joklBKJqN9/k03jnFKUg6f87BtPQCDMTWYHx5fQCnu1bijWeUZCl5TlAlwlZ4GGiz8wii4bId11x1I21cIQfom3FzKDLQVXZKC9a0alu1A1aE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767559881; c=relaxed/simple;
	bh=mdlT2xTIuFcx/VeKSVsBSh8VeO3NeEUtgfeizTRRfSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kHqM+LhFSMU2UgQYk+JSJKWraGnJh8O1tJ+6iyzmwhtnbQvJauM8r0c1ZgF/yJnOZsq8ILpz6oNA7Pj803Nfx9sFp8W47sggmctz0H6yfoUxRnDaYcK4rYXbOzs7zfMQcuADyhzlRYCLoIEbDSrQYc0Bxc3DcmscG0QPG+ayj0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=kzqEdqv6; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="kzqEdqv6"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dkqN369fYzyYm;
	Sun, 04 Jan 2026 22:51:15 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1767559876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sRoiX89FQ96w0Gcf+dFYnY09/9tuoWb+8D44S9J+2uc=;
	b=kzqEdqv6W6IQ5G8F84cse+6HiCXUNam3Q6Mr7Xjzuhw6AQbMIrDlgC1jtfqcrHogt+5G/E
	lrlh3D4OcJmpxVYrSVpiwZOBpB7oAVQKR3R+3NT/bI7w2vZUt98/upLX1XUxKXSp3lJ0vX
	JCSTK20nuUa1EpF+fP5RnOpoES2V37U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1767559876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sRoiX89FQ96w0Gcf+dFYnY09/9tuoWb+8D44S9J+2uc=;
	b=s0vXY3/67co884sg/e5l/CsWGsDbRxeHHYD/IuS+ag4ynjxaslUCqtqyWUmsaj0h9jczwG
	KSUq9aLp60W6osj0KqqN6imSYmLqa2AFRPH8VkytI5iuz1c4UTa7fG5yEhAxYRe5nROXdd
	4ATIwUMk7DcMH04Dut7rwZRvpeQP4zs=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1767559876;
	b=HdkmynDmF2NdqoU7f5En+PfcT42hnCEWhvIbNJn8PpmnlfG5evvPfkaQr+rVDH+rpO6Fns
	417VCLT452tRoMuHTH3jC2czZmOoR1LssvRBGlCrQaCjhBgGb8nbmmSzHE7KDVKmz3RGHa
	dbscBnxLAJtWhW44XtY3RlP9LFUElq8=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 1/3] shared/bap: add bt_bap_stream_is_server
Date: Sun,  4 Jan 2026 22:51:10 +0200
Message-ID: <ce1ecf069f0856ff58471bbc39c6e38ad4acf0a9.1767559459.git.pav@iki.fi>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1767559459.git.pav@iki.fi>
References: <cover.1767559459.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add function for determining whether a given stream is a BAP Server
stream or not.
---
 src/shared/bap.c | 6 ++++++
 src/shared/bap.h | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 6a35e4e1d..d0425318c 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -4270,6 +4270,12 @@ uint8_t bt_bap_stream_get_type(struct bt_bap_stream *stream)
 	return 0x00;
 }
 
+bool bt_bap_stream_is_server(struct bt_bap_stream *stream)
+{
+	/* Stream is a BAP Server stream (not Broadcast or BAP Client) */
+	return !stream->client;
+}
+
 static void notify_pac_removed(void *data, void *user_data)
 {
 	struct bt_bap_pac_changed *changed = data;
diff --git a/src/shared/bap.h b/src/shared/bap.h
index 80e91f10a..983b9d9a6 100644
--- a/src/shared/bap.h
+++ b/src/shared/bap.h
@@ -113,6 +113,8 @@ struct iovec *bt_bap_pac_get_metadata(struct bt_bap_pac *pac);
 
 uint8_t bt_bap_stream_get_type(struct bt_bap_stream *stream);
 
+bool bt_bap_stream_is_server(struct bt_bap_stream *stream);
+
 struct bt_bap_stream *bt_bap_pac_get_stream(struct bt_bap_pac *pac);
 
 /* Session related function */
-- 
2.52.0

