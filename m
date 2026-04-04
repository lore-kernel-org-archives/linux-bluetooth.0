Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2391E2BEFF5;
	Sat,  4 Apr 2026 20:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775333289; cv=none; b=AMMlP3rKkIeFj/D8vFNoUG/bMzbl6fCYKNMnYhC/D9ef7GPsmyEmooEQ4alyAgUAfQtygsdTrYj1pXHG9KxGFK0nvGvyeNaMO8aELTCqaI0PHahiGDb6SNN8Q25+vmdeMiG2w/LImRNGCNkeSm1QYdE5XeZx60FT4TEmOnT2SFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775333289; c=relaxed/simple;
	bh=oGbWYW5gmlfGVRTVo5yxNx//F9QWsJ0gFPnddHa+9ac=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KwOIWn7iuDk2DkJEAvOd2YHr2Ai6bXpN0SIvZ3jiIzHbya/A0mYUg6XMKIgAE2f2teexnh6/LYUlGqH7vnd3stcZ8oCtLyZKaMgNTivNiqZIA5NgC1adLKo8BAb25CulENGpgBA9mpAqaLQcZnInpOcS0CQKNj2njXmCSDRF37Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h5jvFGa4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h5jvFGa4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B983DC19421;
	Sat,  4 Apr 2026 20:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775333288;
	bh=oGbWYW5gmlfGVRTVo5yxNx//F9QWsJ0gFPnddHa+9ac=;
	h=From:To:Cc:Subject:Date:From;
	b=h5jvFGa40Txr7pkwcn9LG3v615eJG8jhmtXhv5uZaZnb+RDBlDy9jjvXoCKtymbt1
	 38caeN30/83cuolNemIIGXFBgFpPLm0cguKNaeITc5nN4oLC2VDkzunt0QyYM4+EYN
	 BktHg5RN09Zu9VrRxtYCqrN5mNuuXgzcWHqzlrs3/5Vp7cr1XQFr5zAnVoqbj2dxb5
	 colR0kjnTZnU80wBnnc9uq0KQpj5KT9ep0ziCVflS2PzDlkJOWGQOPPITr5zmccXol
	 uDbkmfjOEl7c9+cWP0SbtRDK4iAxsPQ5jVG47o7TBbSPxPX2dh30FXTfnL9TQ9D3Rw
	 obmNJr5pFf/ew==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-bluetooth@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH] Bluetooth: Remove unneeded crypto kconfig selections
Date: Sat,  4 Apr 2026 13:06:45 -0700
Message-ID: <20260404200645.28902-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove several kconfig selections that are no longer needed:

  - CRYPTO_SKCIPHER and CRYPTO_ECB have been unneeded since
    commit a4770e1117f1 ("Bluetooth: Switch SMP to
    crypto_cipher_encrypt_one()") in 2016.

  - CRYPTO_SHA256 has been unneeded since
    commit e7b02296fb40 ("Bluetooth: Remove BT_HS") in 2024.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---

This patch is targeting the bluetooth tree.

 net/bluetooth/Kconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/bluetooth/Kconfig b/net/bluetooth/Kconfig
index 6b2b65a667008..8bd0f28911617 100644
--- a/net/bluetooth/Kconfig
+++ b/net/bluetooth/Kconfig
@@ -7,16 +7,13 @@ menuconfig BT
 	tristate "Bluetooth subsystem support"
 	depends on !S390
 	depends on RFKILL || !RFKILL
 	select CRC16
 	select CRYPTO
-	select CRYPTO_SKCIPHER
 	select CRYPTO_LIB_AES
 	imply CRYPTO_AES
 	select CRYPTO_CMAC
-	select CRYPTO_ECB
-	select CRYPTO_SHA256
 	select CRYPTO_ECDH
 	help
 	  Bluetooth is low-cost, low-power, short-range wireless technology.
 	  It was designed as a replacement for cables and other short-range
 	  technologies like IrDA.  Bluetooth operates in personal area range

base-commit: 2febe6e6ee6e34c7754eff3c4d81aa7b0dcb7979
-- 
2.53.0

