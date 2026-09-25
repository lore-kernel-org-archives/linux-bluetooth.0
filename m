Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FD5494819
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 10:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790332166; cv=none; b=GdHDPRVbxqik7ZCog2/GTNUxUH02W904EMQ7uk3HV+iokxjaULT41E1Q22/cWHTOVgai0b5/007Uf5U+tT6V1a5I476XYQA1jS7jbi3wT0Ao4oondQOXHlrvfZjXHKdgtTQ990VU3Uh3eBxetV010Ej558RNO7c0/uoYjTz2ub4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790332166; c=relaxed/simple;
	bh=Aiqfh+mFRo5Ii7dLiFrZeMDBfqsQSVq5e3O2NU0K6rg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T5DBn4ksZyWpUEGLwoFzF+uqPKfnh/Ly1WRILhml5vh9kJSUzqd3TOqx+hqMCR8OzVa8YK7DXBWFelCPberUU610yV5DQrEEqnz9qHakdPMIeXzPro4L64eiyVO9zPyB+f3Xpm/lImxxBSC/YhK6iS0YIDiCvNFYXK16zuk9tBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=dVj9x92R; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="dVj9x92R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1790332160;
	bh=Aiqfh+mFRo5Ii7dLiFrZeMDBfqsQSVq5e3O2NU0K6rg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=dVj9x92RDUGOAKU3YBpAsLpiy3HFIVH6pm98uf2VEOLEquQJAU9u5Rqwx8b/bCItX
	 ElSo1P2380HSpdsKe7443yq7GYKBYmpGebOKZdQHNrrBOwLMEJ9Xzm1gTfO+4pjPmp
	 ubJiYtWa5B/xSQuvyAAWtYB8cD1J3/d/fTLzTbzd/Pqf/Awf455IwI/MTfxn3UigCy
	 HxImLUWkQBMoCtEHt0B99PPQ/3AVd/lho/haXxb94+9Ah469vX9FBrSKA/OkCQkWcc
	 nPODNC84II1VIfx2Es9H08+YUjyuBG0fHKFofnlbF4BLMSnhefMxq+gWIe3xG6nog8
	 0fib4wA+gspeQ==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id BEBDD17E0D84
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 12:29:20 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 RESEND 6/6] client: Display SecurityLevel in device info
Date: Fri, 25 Sep 2026 12:29:14 +0200
Message-ID: <20260925102914.3282319-7-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260925102914.3282319-1-frederic.danis@collabora.com>
References: <20260925102914.3282319-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

---
 client/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/client/main.c b/client/main.c
index 314aead8c..8298fc9eb 100644
--- a/client/main.c
+++ b/client/main.c
@@ -2020,6 +2020,8 @@ static void cmd_info(int argc, char *argv[])
 	print_property(proxy, "WakeAllowed");
 	print_property(proxy, "LegacyPairing");
 	print_property(proxy, "CablePairing");
+	print_property(proxy, "SecurityLevel");
+	print_property(proxy, "EncryptionType");
 	print_uuids(proxy);
 	print_property(proxy, "Modalias");
 	print_property(proxy, "ManufacturerData");
-- 
2.43.0

