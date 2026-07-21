Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFA526E71F
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 14:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784643455; cv=none; b=jWRZUaMWQVimPL5WfNGDrNbH/7PSrPhKF9u6MMf4Fd/wH9uNRHaG/Izc/CkaXUHkbyGH3xckchnaEKsUc/DUhEHPaDbWBrP82tI4LWWXMz6T3DsAN1r36+BCCpaAzIy/J55ZFp18oiVQ9EEzUJpjXnDIEyAd+Xbp8r6NGfzNcQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784643455; c=relaxed/simple;
	bh=tc3YdF5mVpLCVx9e0iwUZXoa9FrmDIW3J45eXuJqpD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pbGp6QzKY27cUZgg9Ibw/zaMW+z18VeduLOddV4MHAMCleVZZdVvlkGJulOvmlN9hb334ViF7qgYJqEOnLryRWs4DHxZaX1fJgJJnZMO2Fn8R1GTYvkAUZgZY78PARHga5r9xkDbIzOsBInu7UNWupcvitJ7I3FXWAeuiCygzaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X7IoMRGh; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7IoMRGh"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-47f707e5d75so1714738f8f.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 07:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784643452; x=1785248252; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BH+sMaCv9UTAR2XGXjplvITasJTKLVbwwKJarF/6wb0=;
        b=X7IoMRGhRa9RjD7EbMkQi1rpvYuHxuaB15IAtruJ/MLX7YfzVDitHgydD9uE2oCGfG
         f8ZLFpSXpjE++jFk0B0EATOzcVbVLfpiIngxdi2Kg4d4/jUcKbcR3Vv5TvFgPiCRIeXr
         Z0nlWJZgbZa6BkCBSMxZm5chX0lsxWpiEo4/KnE09dW1Jn2ztx3NG3vCrmsAz3bsnwHy
         kq0/lU9w+yqnVZ7S2+0Uzbm6Mu7wBLZftwC0fYPosbUep8Hx1vX1ClXbzfNUleKAfsRS
         Um/RE2AYOyFXPyi3YK1ML8DsBAnCvR4WkZfLhK6x3f9wXcObXRSQ+cNqHEF3Wsjm0/28
         vCdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784643452; x=1785248252;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BH+sMaCv9UTAR2XGXjplvITasJTKLVbwwKJarF/6wb0=;
        b=eAK1gRw6Q9XbrdGvilHJY/1l0b91I35uSt93ZeNIPxpsID3Hf8r4bLT5QV8Kwh0rIY
         DrbZ0//NPfG4cxRXnZhMEyK2FhmffvtxtqABIR5ZEEb4nqe2Ua0slSYTsidOQbPjf3Wl
         gnRvd/sfd18+XsesyZGSh3LWQriAmUuWfb9z5ImEa06WTMgVqZ21qtHyVMiEd/wToO1b
         iRCEotpe3UsUPeNEFvo18+M8WAqaNE0HFtLbjD+B6y3FkIaQgpVrtXtk/4ifBySkjzj6
         47XSM+BNsbMqImg8i6XEyS9HPs+ziyntIPazEYWv5Q4Ag/zWCRY4iTiZKE+gLy2YGaBY
         akAw==
X-Gm-Message-State: AOJu0YzzANc6PcVdt8SFoavuRtsIeC7EhfthLy0x9CmU/8+5erxdbiy+
	4q/6OWzfA7Y55q/GXTYZsKbsEWzC1PnWKUD160fymwyLFs8mgeWckyJXwPt2MIN9/OS6CA==
X-Gm-Gg: AR+sD13QZkcRiO8F2CFoDJ+Z+Tj3a6OR++FRi5DgVTUJYLk5Bdy+O8szffQ3a0ewN7C
	qZJHb2h11UDPBiren2VXKqI3gqZqb1lha6RrJ8VNRf2FGRKwNUifFFMRCycAwEkDWAZPPK2wrPb
	gX4Lbn6hn98ufLvzskp43inrmmfLw7NK2mv3p4GDpaNriTbd+dpdciEMdfT1P1qLW+5FBcD9Mzg
	PFfeHfL59j8waz9peo4ILsIG9muyqwOiMY2I51HKbCTkVCiiBXrWiHTBT/b1TwbsbPhCtsoZ8vE
	Gyq20paAxt9vX0XOVmNfpwyXfIR9lzBs8MdlUsRTKWiu+7mSMStCZojgGEBfntTPGgpiOf08Slq
	i91eZpEKYYVBEbDC7Dt6xqRjW1r1+kiZiXCtTT4ifGjYehy9JegyNovmB231Nz5/25J+OxRFMb0
	SiS3p/
X-Received: by 2002:a05:6000:1869:b0:47f:7030:bfbd with SMTP id ffacd0b85a97d-47f817fa7ddmr3048360f8f.48.1784643452094;
        Tue, 21 Jul 2026 07:17:32 -0700 (PDT)
Received: from pakrohk.localdoman ([89.34.36.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63e49acesm37898270f8f.6.2026.07.21.07.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 07:17:31 -0700 (PDT)
From: Pakrohk <rhpcir@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	marcel@holtmann.org,
	Pakrohk <Pakrohk@users.noreply.github.com>
Subject: [PATCH BlueZ v2 1/3] src: add HMAC-SHA256 to bt_crypto using kernel AF_ALG
Date: Tue, 21 Jul 2026 17:47:16 +0330
Message-ID: <patch.1753084801.git.Pakrohk@users.noreply.github.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1753084800.git.Pakrohk@users.noreply.github.com>
References: <cover.1753084800.git.Pakrohk@users.noreply.github.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Pakrohk <Pakrohk@users.noreply.github.com>

Add HMAC-SHA256 computation to the bt_crypto library using the Linux
kernel AF_ALG interface. This follows the exact same pattern as the
existing cmac(aes) implementation.

The HMAC-SHA256 function is needed for verifying external quirk profile
signatures. The previous implementation used popen("openssl dgst ...")
which had command injection risks and an openssl CLI dependency.

Using kernel AF_ALG:
  - No external library dependencies
  - Matches existing BlueZ crypto patterns
  - No shell invocation or temp files
  - Works in bluetoothd's process context

The hmac(sha256) algorithm is available in all modern Linux kernels
via the crypto API (/proc/crypto).

Signed-off-by: Pakrohk <Pakrohk@users.noreply.github.com>
diff --git a/src/shared/crypto.c b/src/shared/crypto.c
index cb99116..f5883bd 100644
--- a/src/shared/crypto.c
+++ b/src/shared/crypto.c
@@ -69,6 +69,7 @@ struct bt_crypto {
 	int ecb_aes;
 	int urandom;
 	int cmac_aes;
+	int hmac_sha256;
 };
 
 static int urandom_setup(void)
@@ -126,6 +127,28 @@ static int cmac_aes_setup(void)
 	return fd;
 }
 
+static int hmac_sha256_setup(void)
+{
+	struct sockaddr_alg salg;
+	int fd;
+
+	fd = socket(PF_ALG, SOCK_SEQPACKET | SOCK_CLOEXEC, 0);
+	if (fd < 0)
+		return -1;
+
+	memset(&salg, 0, sizeof(salg));
+	salg.salg_family = AF_ALG;
+	strcpy((char *) salg.salg_type, "hash");
+	strcpy((char *) salg.salg_name, "hmac(sha256)");
+
+	if (bind(fd, (struct sockaddr *) &salg, sizeof(salg)) < 0) {
+		close(fd);
+		return -1;
+	}
+
+	return fd;
+}
+
 static struct bt_crypto *singleton;
 
 struct bt_crypto *bt_crypto_new(void)
@@ -159,6 +182,16 @@ struct bt_crypto *bt_crypto_new(void)
 		return NULL;
 	}
 
+	singleton->hmac_sha256 = hmac_sha256_setup();
+	if (singleton->hmac_sha256 < 0) {
+		close(singleton->cmac_aes);
+		close(singleton->urandom);
+		close(singleton->ecb_aes);
+		free(singleton);
+		singleton = NULL;
+		return NULL;
+	}
+
 	return bt_crypto_ref(singleton);
 }
 
@@ -183,6 +216,7 @@ void bt_crypto_unref(struct bt_crypto *crypto)
 	close(crypto->urandom);
 	close(crypto->ecb_aes);
 	close(crypto->cmac_aes);
+	close(crypto->hmac_sha256);
 
 	free(crypto);
 	singleton = NULL;
@@ -1005,3 +1039,35 @@ bool bt_crypto_sirk(struct bt_crypto *crypto, const char *str, uint16_t vendor,
 	/* Encrypt sirk using k as LTK with sef function */
 	return bt_crypto_sef(crypto, k, sirk_plaintext, sirk);
 }
+
+bool bt_crypto_hmac_sha256(struct bt_crypto *crypto,
+				const uint8_t *key, size_t key_len,
+				const uint8_t *msg, size_t msg_len,
+				uint8_t res[32])
+{
+	ssize_t len;
+	int fd;
+
+	if (!crypto)
+		return false;
+
+	fd = alg_new(crypto->hmac_sha256, key, key_len);
+	if (fd < 0)
+		return false;
+
+	len = send(fd, msg, msg_len, 0);
+	if (len < 0) {
+		close(fd);
+		return false;
+	}
+
+	len = read(fd, res, 32);
+	if (len < 0) {
+		close(fd);
+		return false;
+	}
+
+	close(fd);
+
+	return true;
+}
diff --git a/src/shared/crypto.h b/src/shared/crypto.h
index d85f807..6b234bc 100644
--- a/src/shared/crypto.h
+++ b/src/shared/crypto.h
@@ -62,3 +62,8 @@ bool bt_crypto_sirk(struct bt_crypto *crypto, const char *str, uint16_t vendor,
 			uint8_t sirk[16]);
 bool bt_crypto_rsi(struct bt_crypto *crypto, const uint8_t sirk[16],
 					uint8_t rsi[6]);
+
+bool bt_crypto_hmac_sha256(struct bt_crypto *crypto,
+				const uint8_t *key, size_t key_len,
+				const uint8_t *msg, size_t msg_len,
+				uint8_t res[32]);

