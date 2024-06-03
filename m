Received: from mail2.andi.de1.cc (vmd64148.contaboserver.net [161.97.139.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E1E82D8E;
	Mon,  3 Jun 2024 14:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.97.139.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717425871; cv=none; b=TLACjSJdC2q5O5mCOKEKjX2cVbhx78rsLvalJZcDILo30G2AYk6d898ZVaB+OY9ivyxxjMr63uTUEBDOl/5c/DRxQ0cpPenhCZ8/LJTvHaYfqVSMpc7m9whT5UDWmJp+YtVoYthpGTuqFyqyMeckdHGT7maTez1eKKsKgE+jBtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717425871; c=relaxed/simple;
	bh=6kMGZvbbwAVpUY7o/3Mo1hVEWC+DsN8qKwLMZzsvR7s=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jjQd+8QPHnf5VxHUcJY3skyebWrS0Y+HHOPy6x63K88L+cs3cjnmDk0DTHjf+ofX5xPscFEnmQEvVlUREmI6NQxbmSWWRgh9lUpy2ABk6gt9giM5gEsAmtQZrP/9ku6s6JzU4E0TT6B6SQ5z8fu9MKNMNm73OaI1HZ6nGVNJ01M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=mQigtz+E; arc=none smtp.client-ip=161.97.139.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="mQigtz+E"
Received: from mail.andi.de1.cc ([2a02:c205:3004:2154::1])
	by mail2.andi.de1.cc with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1sE8v6-008hAe-2w;
	Mon, 03 Jun 2024 16:44:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bMF1CyWf3RbQIO/q5KxisncBbMfKZqOgAKsNghJdEpk=; b=mQigtz+Ea4BY1ZoY399w8Dqs9i
	BwDrTkYfBhqIIt2dN8f3yD7SSH27sC+lzGBOR9WzQG4W0Odq5eNjJr+G4WFhAmC6dJpQqIqwyccdc
	h9G54vhXpqtlmJdL8xsLKe8DD/3aUegBBcYpZPnlHG+7imipme3/lO7ZxxYJvUKOKZAF3NdBFStv4
	nTRk6GFNv+yzj7bHipc05RXZ873IwH/p2xAMeBytJzDE1e9Ex2D7IF12Veg8pdk8VWcG6UYQeTtpL
	S9x+mDzlWXVtRTH75KMDKnlviNRHiUkwi3PZlKmQGjlzJQ+pU42BlZFHdt9EqTREdT5UewhauS3Rg
	DrIRAW7g==;
Received: from p200300c20737c2001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:c2:737:c200:1a3d:a2ff:febf:d33a] helo=aktux)
	by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1sE8v3-002Uea-1s;
	Mon, 03 Jun 2024 16:44:18 +0200
Received: from andi by aktux with local (Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1sE8v4-009DAn-1x;
	Mon, 03 Jun 2024 16:44:18 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	johan@kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	andreas@kemnade.info,
	pmenzel@molgen.mpg.de,
	linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	Adam Ford <aford173@gmail.com>,
	Tony Lindgren <tony@atomide.com>,
	tomi.valkeinen@ideasonboard.com,
	=?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@gmail.com>,
	robh@kernel.org,
	hns@goldelico.com
Subject: [PATCH v3 1/4] gnss: Add AI2 protocol used by some TI combo chips.
Date: Mon,  3 Jun 2024 16:43:57 +0200
Message-Id: <20240603144400.2195564-2-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240603144400.2195564-1-andreas@kemnade.info>
References: <20240603144400.2195564-1-andreas@kemnade.info>
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

