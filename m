Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02E3360EDA
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 03:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779334119; cv=none; b=bb9fMjCS2JT8JhJLuLQoXHUR2I9MXJtrlegsFK4XU2skFuIniP/2H9Nfe1Lal+w2bmg8IUU/mEtxCVWEg1Kka5SoQdX11vdY8bkhe7mrjGU9ng5/ua7fIbKtv7FnBZ5FWpaVY3//SjO66uxo+pXiD3RCAh2mleess8H9ayCuWXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779334119; c=relaxed/simple;
	bh=LXLu+dKxn48nS8bzT8a4K64eXLd+fRAbAF3h689QREI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MzFM2Sf24savjXJUW/BLzMQU9avPu5xfSg3YEaVv6Q/ktHDyrdNYO2grJBPGU15vVqPxqYMbqZV0IO2xTYqXtdrBaGSufBi2B2f3bwjDxFY+4CTubob3Zc8K8FgyI+XLSRoQ5fpRTVK4lRTBIN3nw7ln+Oiovro/oEy5edDw60E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=VY/D/Rj2; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="VY/D/Rj2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=DE
	UquMsOSkXE7cJPmqrjFAeH0LMkasgIOjnoOk7W1m0=; b=VY/D/Rj28TMG7diEku
	H6CwaOqsbcSbPrBLNFHCrNyXQip6mJiYJ6e2CVm6mWePPmM6sCdUvarBlHEL9pcJ
	j+LI9bXM1cXHmoLQ+PN/XK+TH4LD1wkkNXbXW08nfsvuvy/hYyo8+8AAQVqPFyZw
	Zf3xYGBfLIPIrqqbTrym6jZWY=
Received: from A207080518.realsil.com.cn (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wB3VeHTew5qUYFtCg--.57035S3;
	Thu, 21 May 2026 11:28:27 +0800 (CST)
From: michael_kong <kx960506@163.com>
To: linux-bluetooth@vger.kernel.org
Cc: michael_kong <kx960506@163.com>
Subject: [PATCH BlueZ 2/2] transport: Add support for obtaining PresentationDelay in broadcast QoS
Date: Thu, 21 May 2026 11:28:15 +0800
Message-Id: <20260521032815.1845-2-kx960506@163.com>
X-Mailer: git-send-email 2.29.1.windows.1
In-Reply-To: <20260521032815.1845-1-kx960506@163.com>
References: <20260521032815.1845-1-kx960506@163.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wB3VeHTew5qUYFtCg--.57035S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7JrW7Cw1fXw1rJw18AF13Arb_yoWxArg_Aa
	4Sg3409w4Uta9xtF12krykGF98AFs5t3Z5Xws3t3s8Ga4DGr98Gr1UXwsavr15Wrsxurs5
	GF9rZa1Iq3s3WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRicdjtUUUUU==
X-CM-SenderInfo: dn0zliqvqwqiywtou0bp/xtbC6xsz7WoOe9sUIQAA3f

---
 profiles/audio/transport.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 3cb4ab0e2..4b9d26c5e 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -1605,6 +1605,8 @@ static gboolean get_bcast_qos(const GDBusPropertyTable *property,
 					&bap->qos.bcast.mse);
 	dict_append_entry(&dict, "Timeout", DBUS_TYPE_UINT16,
 					&bap->qos.bcast.timeout);
+	dict_append_entry(&dict, "PresentationDelay", DBUS_TYPE_UINT32,
+					&bap->qos.bcast.delay);
 
 	append_io_qos(&dict, &bap->qos.bcast.io_qos);
 
-- 
2.29.1.windows.1

