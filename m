Received: from mail2.andi.de1.cc (vmd64148.contaboserver.net [161.97.139.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1588821;
	Thu,  6 Jun 2024 18:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.97.139.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717698649; cv=none; b=s8Hya2vKUUYd8JfxU/gzyomF25cKHZsKMojbZeRQlh+/vMYF1baIjfzjn3hprMBG8yPVK3smHxXxH/rmiO/cI8flrnSfOqTAY1csqQsXNhHwT9+Bv3wWNsc1Lp75Y05EyoGUFrcmxfb9fNDiFWEMNrzqE1Kj7m4HUQsLP8qqWgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717698649; c=relaxed/simple;
	bh=6kMGZvbbwAVpUY7o/3Mo1hVEWC+DsN8qKwLMZzsvR7s=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ri94dSsUHRyLx5nGLGkEK4wNCboOCzFizowrw+cXLFzYnibpES3g5kpRhDumAaNo8CW1Zigc9cKfgw5dqix5D4KbrWbXClyUVd+JdbIl32KtNsgOLm+IAmdeArhegJebXX2s9PdBn2J4KfZEJGGVqQttOTE/MCweCmF6OscY+8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=38zXRAQw; arc=none smtp.client-ip=161.97.139.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="38zXRAQw"
Received: from mail.andi.de1.cc ([2a02:c205:3004:2154::1])
	by mail2.andi.de1.cc with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1sFHsp-0090x2-1w;
	Thu, 06 Jun 2024 20:30:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bMF1CyWf3RbQIO/q5KxisncBbMfKZqOgAKsNghJdEpk=; b=38zXRAQwrZf5v55378iG5mrHDN
	dnjBtwe3L7TTqMIrhQ01F9rzGUXQR2AQlVySak0cI8T3ukDyWbxwVYk74h8iMFEMtFsDDfNGOkDRL
	hxjkLxfpIoRa6wII02JeCaLHOMF+VkaOdNfZC04k+9BeDQTVPSS8HSOoDwwNYcsBSvon4fDqU85Me
	zhA/hMNY4D/qQhmjyzxp9Hwc1Z4T7Z1gL11pL/T6zTIr3f4THEWr7pr9W6vv+mvnK/ba3CClqOJAu
	is8xiaBLSqtD6RpX+W7/mdg3Nzch1zbic+1sVNNTL1aAVdRd+gL9KG2zofb7Ykaq9U0BUTyCrRKuA
	Mybcgqbg==;
Received: from p200300c20737c2001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:c2:737:c200:1a3d:a2ff:febf:d33a] helo=aktux)
	by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1sFHsj-002nvT-31;
	Thu, 06 Jun 2024 20:30:39 +0200
Received: from andi by aktux with local (Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1sFHsk-002s4Q-2z;
	Thu, 06 Jun 2024 20:30:38 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	johan@kernel.org,
	pmenzel@molgen.mpg.de,
	jirislaby@kernel.org,
	andreas@kemnade.info,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	Adam Ford <aford173@gmail.com>,
	Tony Lindgren <tony@atomide.com>,
	tomi.valkeinen@ideasonboard.com,
	=?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@gmail.com>,
	robh@kernel.org,
	hns@goldelico.com
Subject: [PATCH v4 1/4] gnss: Add AI2 protocol used by some TI combo chips
Date: Thu,  6 Jun 2024 20:30:29 +0200
Message-Id: <20240606183032.684481-2-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240606183032.684481-1-andreas@kemnade.info>
References: <20240606183032.684481-1-andreas@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Texas Instruments uses something called Air Independent Interface (AI2) for
their WLAN/BT/GPS combo chips.

No public documentation is available, but allow that protocol to be
specified.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
 drivers/gnss/core.c  | 1 +
 include/linux/gnss.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gnss/core.c b/drivers/gnss/core.c
index 48f2ee0f78c4d..cac9f45aec4b2 100644
--- a/drivers/gnss/core.c
+++ b/drivers/gnss/core.c
@@ -335,6 +335,7 @@ static const char * const gnss_type_names[GNSS_TYPE_COUNT] = {
 	[GNSS_TYPE_SIRF]	= "SiRF",
 	[GNSS_TYPE_UBX]		= "UBX",
 	[GNSS_TYPE_MTK]		= "MTK",
+	[GNSS_TYPE_AI2]		= "AI2",
 };
 
 static const char *gnss_type_name(const struct gnss_device *gdev)
diff --git a/include/linux/gnss.h b/include/linux/gnss.h
index 36968a0f33e8d..16b565dab83ea 100644
--- a/include/linux/gnss.h
+++ b/include/linux/gnss.h
@@ -23,6 +23,7 @@ enum gnss_type {
 	GNSS_TYPE_SIRF,
 	GNSS_TYPE_UBX,
 	GNSS_TYPE_MTK,
+	GNSS_TYPE_AI2,
 
 	GNSS_TYPE_COUNT
 };
-- 
2.39.2

