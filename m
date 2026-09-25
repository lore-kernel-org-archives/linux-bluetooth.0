Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D394A1DF6
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 13:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790342755; cv=none; b=lA88U1w3HJaye79rGGZb80hzKOd6K8OOV92O3TOoQXOgTg2mEHtHyVXNbSGas3knreu3Qf50uAfOTylhvF9vMHdZuUpcBwdv+GPPN/pWkWyEtsG0/wOdx3B3PBb4aZgrH6xh7VZIfr1cMFo8P87creae/y3A8OqECzoyzbryrO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790342755; c=relaxed/simple;
	bh=6wDILU1MgvdsEkceu3pGbzlpufWrnEBTdujmRCTIipI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m5rwyWFNWTlHHdsjeMJqp1gtNF+l7Mv8OKUlyUTyes88qMG6mhYyWu/tkrRzQ9VxGRPDuQuBjQ/EvocBd7fi5KyzmRrMpW+P8sOvsGVwiZ1flhECoxkEke4KaWXFVdSJbTUSpsSCUNd0TKbcSbZB6N34eq44n7W2nMiwefTScgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=PJyAM9IW; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="PJyAM9IW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1790342737;
	bh=6wDILU1MgvdsEkceu3pGbzlpufWrnEBTdujmRCTIipI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=PJyAM9IWHuYJldMZafZhxzC8fj/R0G/H96ft4MZAeSjrjzQD4i7aOBs17dd/Uq/1H
	 IT7LzQjmpx3uJj+ZmjVPVG51XxBIFSEkBHtJJM+3iSh/dktKp2JUJRjdfwQ2DcYCMa
	 ewb8nf1BO+hnNA8xC3kiVIsXMdiPFn+RzQcJKkqHPNFNkSRIO++0M+yCgCN22JCeR/
	 Nw9b3i9vaf35suw6iDC3KB5nHkZp6zg1xpQD8uiwYB+xKe6TnYirq6wUgvvJENFLvw
	 R/avhBx5fm/ScnOu5761A0JRd1jjrX/5Km4sTRTLgSsybc5neojSGUzgoUCt1D8P+a
	 s2BPdKzFlI7hA==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 06B7917E0B59
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 15:25:36 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 05/12] audio/hfp-hf: Add hangup all calls support
Date: Fri, 25 Sep 2026 15:25:21 +0200
Message-ID: <20260925132528.3361517-6-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260925132528.3361517-1-frederic.danis@collabora.com>
References: <20260925132528.3361517-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Frédéric Danis <frederic.danis.oss@gmail.com>

This releases all calls except waiting calls. This includes
multiparty calls.
---
 profiles/audio/hfp-hf.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/profiles/audio/hfp-hf.c b/profiles/audio/hfp-hf.c
index dddd56261..287b79f1f 100644
--- a/profiles/audio/hfp-hf.c
+++ b/profiles/audio/hfp-hf.c
@@ -503,6 +503,20 @@ static DBusMessage *dial(DBusConnection *conn, DBusMessage *msg,
 	return NULL;
 }
 
+static DBusMessage *hangup_all(DBusConnection *conn, DBusMessage *msg,
+				void *profile_data)
+{
+	struct hfp_device *dev = profile_data;
+	bool ret;
+
+	ret = hfp_hf_hangup_all(dev->hf, cmd_complete,
+					dbus_message_ref(msg));
+	if (!ret)
+		return btd_error_failed(msg, "Hang up all command failed");
+
+	return NULL;
+}
+
 static DBusMessage *call_answer(DBusConnection *conn, DBusMessage *msg,
 				void *call_data)
 {
@@ -535,6 +549,7 @@ static DBusMessage *call_hangup(DBusConnection *conn, DBusMessage *msg,
 
 struct telephony_callbacks hfp_callbacks = {
 	.dial = dial,
+	.hangup_all = hangup_all,
 	.call_answer = call_answer,
 	.call_hangup = call_hangup,
 };
-- 
2.43.0

