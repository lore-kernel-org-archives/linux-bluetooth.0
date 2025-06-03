Received: from sdore.me (unknown [95.165.1.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF832AD02
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Jun 2025 10:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.165.1.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748945119; cv=none; b=r+T2t4h1sc1p25WjyFgvznBr2Kw1xY9OdeMdLi3gdS9dRLmDP75OetjE1kKz6eKqh6y2jlOVMzjB12gPdIoIN1Wwl4JEWAKc0XpzSPp8MMuTkFNan7MPykGm169CWXZq+8hBU8/0I9XClIhdu1YonltrmBzavBzM11iTVAD0hic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748945119; c=relaxed/simple;
	bh=4Dn5vdC2dIhPZqA2sQa2RLokzC5gqZH5xNNe+qZw+ZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=duIvDmrbbY9SD6biPzjRj7h/Bl9bJPgra06en8wFPaqEzh1T/ay7uLn5UboEoRif6uePn+LCCor8kSiuXxNah/xOlE5rtzKfgOLeN2+/NkQ4SPkx2Huev5SFbNRFIEBW2ZMI8I9LZImfPg8TPdA8fSwEt7GHw2AV4DxRuDnPgpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sdore.me; spf=pass smtp.mailfrom=sdore.me; dkim=pass (1024-bit key) header.d=sdore.me header.i=@sdore.me header.b=EI//g9fi; arc=none smtp.client-ip=95.165.1.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sdore.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sdore.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sdore.me header.i=@sdore.me header.b="EI//g9fi"
Received: from Beast.lan (Beast.lan [192.168.1.2])
	by sdore.me (Postfix) with ESMTPSA id CCCDA103F010DE;
	Tue, 03 Jun 2025 12:56:21 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sdore.me; s=SERV;
	t=1748944581; bh=4Dn5vdC2dIhPZqA2sQa2RLokzC5gqZH5xNNe+qZw+ZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EI//g9fiQrMumlbrWi3dSKqKjX5Il1vZPylWpHChGMGIHlnjtPbFYcV6JZLKWBUvu
	 GayybRbXnFLKyWU+2ydhuoJmf338EusQWxzgtmLO3ovxwnrLUNImO4tTpq1IQcvXz2
	 O26eaXR2/ooFpBz0ZsTMv5IP7z+zKC4lnDaabKMs=
From: Egor Vorontsov <sdoregor@sdore.me>
To: linux-bluetooth@vger.kernel.org
Cc: Egor Vorontsov <sdoregor@sdore.me>
Subject: [PATCH BlueZ 1/2] profiles/input: Add cable pairing constants for DualSense
Date: Tue,  3 Jun 2025 12:56:16 +0300
Message-ID: <20250603095617.92785-2-sdoregor@sdore.me>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250603095617.92785-1-sdoregor@sdore.me>
References: <20250603095617.92785-1-sdoregor@sdore.me>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sony DualSense & DualSense Edge controllers support cable pairing
the same way as previous Sixaxis controller generations do.

This patch prepares their input profile for its implementation.
---
 profiles/input/server.c  |  3 ++-
 profiles/input/sixaxis.h | 25 +++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/profiles/input/server.c b/profiles/input/server.c
index c8be445c7..68105d48c 100644
--- a/profiles/input/server.c
+++ b/profiles/input/server.c
@@ -122,7 +122,8 @@ static bool dev_is_sixaxis(const bdaddr_t *src, const bdaddr_t *dst)
 
 	cp = get_pairing(vid, pid, NULL);
 	if (cp && (cp->type == CABLE_PAIRING_SIXAXIS ||
-					cp->type == CABLE_PAIRING_DS4))
+					cp->type == CABLE_PAIRING_DS4 ||
+					cp->type == CABLE_PAIRING_DUALSENSE))
 		return true;
 
 	return false;
diff --git a/profiles/input/sixaxis.h b/profiles/input/sixaxis.h
index ab8831995..ac7e75223 100644
--- a/profiles/input/sixaxis.h
+++ b/profiles/input/sixaxis.h
@@ -17,6 +17,7 @@ typedef enum {
 	CABLE_PAIRING_UNSUPPORTED = 0,
 	CABLE_PAIRING_SIXAXIS,
 	CABLE_PAIRING_DS4,
+	CABLE_PAIRING_DUALSENSE,
 } CablePairingType;
 
 struct cable_pairing {
@@ -72,6 +73,30 @@ get_pairing(uint16_t vid, uint16_t pid, const char *name)
 			.version = 0x0001,
 			.type = CABLE_PAIRING_DS4,
 		},
+		{
+			.name = "Sony Interactive Entertainment Wireless Controller",
+			.source = 0x0002,
+			.vid = 0x054c,
+			.pid = 0x0ce6,
+			.version = 0x0001,
+			.type = CABLE_PAIRING_DUALSENSE,
+		},
+		{
+			.name = "Sony Interactive Entertainment DualSense Wireless Controller",
+			.source = 0x0002,
+			.vid = 0x054c,
+			.pid = 0x0ce6,
+			.version = 0x0001,
+			.type = CABLE_PAIRING_DUALSENSE,
+		},
+		{
+			.name = "Sony Interactive Entertainment DualSense Edge Wireless Controller",
+			.source = 0x0002,
+			.vid = 0x054c,
+			.pid = 0x0df2,
+			.version = 0x0001,
+			.type = CABLE_PAIRING_DUALSENSE,
+		},
 	};
 	guint i;
 
-- 
2.49.0

