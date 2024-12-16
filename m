Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D5A1E493
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Dec 2024 18:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734374783; cv=none; b=Jn1MVZcH0RQU9ayp3r3qXV7iqwzfIPfr5t02/YESIWisqAp/PVL6Bdc5oI/r+HgbxSh7cZOr5vfCzgItkj6ufhiVy0fMNEG3mDtj7wdqeN7VwGjTqkGnxG0zXfjB4pGv7N8oiu3nJ6/PTLYu0oJZuKWVC+3L1g6dN8r+mOYblT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734374783; c=relaxed/simple;
	bh=75k8vQfAdxNCyc8upk6BS2mFTnwef5NOPkGdceviGNk=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BG6OMj0Q6PtJ+EyxnnjhVAlUFezqKkjPrXJE2yv/1zxSiMMmYXtm3AacOmXYjHFLPOZuDMcp9pLi3uK6TD9CApXMbIXsT36AJfa4bWWauEeKv7VV7crn0kKI/g/wcAT95es601Eb1hVQCO0INyp1ryHboNO+B2ZhHQGv+fO/Qp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ffpeZC83; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ffpeZC83"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1734374779;
	bh=75k8vQfAdxNCyc8upk6BS2mFTnwef5NOPkGdceviGNk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ffpeZC83Wj5N1oBaIC1U49AamOup5/8BbC9W2JYBey8jZnKXhU/uIPVFeDzUkJ1Lh
	 IN1jiIEBm5St1Zru9x5zzb/Wt2o5a3YSBY8APRLulgYAEdLyOdg6oDFk9AcJOvYYTN
	 l2gLzLIIeAVhrOcuTq/1F3vVdQRyYQFdSvEsIk+bAPr8ucha2z0cn6lXtut6fRgiTo
	 YjaoJE85pL2nyXVx/VFA8K9nYjH6RnS1o411osSDWj3HSg57d5kIQMI18TbQY8Iz5n
	 bhIxDfF+4uTwfK2Oq4DgFiUF9pc9WOuVRNOYr3qZrjiEL7Ii2THDdYogKWFj2WqXY5
	 cNRjJbnk4l99g==
Received: from fdanis-XPS-13-9370.. (67.227.121.78.rev.sfr.net [78.121.227.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E18CD17E37E7
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Dec 2024 19:46:18 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 1/2] lib: Add constant for 16 bits transparent voice setting
Date: Mon, 16 Dec 2024 19:46:12 +0100
Message-Id: <20241216184613.135538-2-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241216184613.135538-1-frederic.danis@collabora.com>
References: <20241216184613.135538-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Add 16 bits, 2s complement, transparent air coding format for mSBC.
Corresponding commit implements functionality on kernel side.

The voice setting is used by sco_connect() or sco_conn_defer_accept()
after being set by sco_sock_setsockopt().

The PCM part of the voice setting is used for offload mode through PCM
chipset port.
This commits add support for mSBC 16 bits offloading, i.e. audio data
not transported over HCI.

The BCM4349B1 supports 16 bits transparent data on its I2S port.
If BT_VOICE_TRANSPARENT is used when accepting a SCO connection, this
gives only garbage audio while using BT_VOICE_TRANSPARENT_16BIT gives
correct audio.
This has been tested with connection to iPhone 14 and Samsung S24.
---
 lib/bluetooth.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bluetooth.h b/lib/bluetooth.h
index 073ed875d..32e58678b 100644
--- a/lib/bluetooth.h
+++ b/lib/bluetooth.h
@@ -111,6 +111,7 @@ struct bt_voice {
 
 #define BT_VOICE_TRANSPARENT			0x0003
 #define BT_VOICE_CVSD_16BIT			0x0060
+#define BT_VOICE_TRANSPARENT_16BIT		0x0063
 
 #define BT_PHY			14
 
-- 
2.34.1

