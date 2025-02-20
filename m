Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0621E0B8A
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Feb 2025 07:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740036297; cv=none; b=imJjiNbK7xrUIY3HbceIN/IK2EaBZX12nVMJQERTqzDsLBr2rmuPWRKCoJMduhkQdhoKRTViH7yoVtwAz0B39VoQNuiffsZsZGLawoweaGu+YMPAmFCKYxyle8bbUFCMnPwnhuPiFAowdX8Y4x4VcQ3LoiR6GPOf7vU21BMd0cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740036297; c=relaxed/simple;
	bh=BpAkn2mvcbx9ZRaE+7Nh+mOHj5B40lRl9OT033p2yy8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tacz2tTaKS+F/IPdeHH/YSYev1zFbevcccWgsCh/PJQNVjKq+Sy6i2gkvs2q6XLJAViDttbnjSNLWOdWmJ86PNcPlINk40RNN5+b70tBu2LYvjkLAWwbP1qyGFw6dRaBT4bxf6gnssMBKRQsKlpLKUIGS9KpYrCTSUCHxkTxp+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Tpz3QpP3; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Tpz3QpP3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740036294;
	bh=BpAkn2mvcbx9ZRaE+7Nh+mOHj5B40lRl9OT033p2yy8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Tpz3QpP3A2w6dIvFU2jRyWuxordMzErD5dfnHCkL8hy1XmZGh4YrIhkxB8vv6OVBt
	 QjdvkAHNzsHsvPiGOP1O+wq/dnwQ/GegIiP7VJIXVDYd7Fmz0SqVcC2BnLJFq3URCs
	 euJQbGttQveO92O/bs9UwVO/yqQ1zzr+NOTd78oI2wsSQw/lcd7vYQrzpxrwIe2gyY
	 M64+lByuGH/KGULSkcKOTLpDDKuzcNjKFnzHr+nLoug8onKnOzRWv04esA40t1v9He
	 P1hsz1VxG0CUHVG7d66m6TPnChGvSrArJ+nF+foXR+BtLzVe1Bwn2claZFoR9BYYdV
	 zY2GQNzq8PLLw==
Received: from fdanis-XPS-13-9370.. (2A02-8428-aF44-1001-98Fd-0e9A-da79-5443.rev.sfr.net [IPv6:2a02:8428:af44:1001:98fd:e9a:da79:5443])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3FA9617E156E
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Feb 2025 08:24:54 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] doc: Add SupportedTypes property to MessageAccess1
Date: Thu, 20 Feb 2025 08:24:46 +0100
Message-ID: <20250220072446.190256-2-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250220072446.190256-1-frederic.danis@collabora.com>
References: <20250220072446.190256-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

---
 doc/org.bluez.obex.MessageAccess.rst | 30 ++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/doc/org.bluez.obex.MessageAccess.rst b/doc/org.bluez.obex.MessageAccess.rst
index 4f7f07d1b..6962520a2 100644
--- a/doc/org.bluez.obex.MessageAccess.rst
+++ b/doc/org.bluez.obex.MessageAccess.rst
@@ -199,3 +199,33 @@ object, dict PushMessage(string sourcefile, string folder, dict args)
 
 	:org.bluez.obex.Error.InvalidArguments:
 	:org.bluez.obex.Error.Failed:
+
+Properties
+----------
+
+array{string} SupportedTypes [readonly]
+```````````````````````````````````````
+
+	List of supported message types.
+
+	Possible values:
+
+	:"EMAIL":
+
+		Email messages.
+
+	:"SMS_GSM":
+
+		GSM short messages.
+
+	:"SMS_CDMA":
+
+		CDMA short messages.
+
+	:"MMS":
+
+		MMS messages.
+
+	:"IM":
+
+		Instant messaging.
-- 
2.43.0

