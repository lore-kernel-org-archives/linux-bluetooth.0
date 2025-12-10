Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D07130DD21
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Dec 2025 16:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765383210; cv=pass; b=R+zBrHiBQGc7i4jV6UVnWCmorMIzcPbdrQpHp88Lr0pYP6cLeOBhAyPulhQ5w4KpxslvmdWPIX31n1o4SVhrnJDnyHBGsoJF+pyHnePzuZweJPigTp3+XfAcfeSrJDSWFdJJ8QCHZrFJyoCLipfrnmSe/HvFIEYFQdXOUCKZOEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765383210; c=relaxed/simple;
	bh=GAIS4GeWu2x6xkY59AyqBMCbN8lQUABZHwe9qMFtjHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yq/M5vCvucTvuJPd81DkKTnlvM1J+OAQmppbR9+a5zMF82Eu2C2iR5uDYCM8yU5khiR5n1iR2cvbQzJVWHis4pQRkppx+pbi/HPeOzbgnZihcU//mk8cifjx4VJf5x6Eupz4mOyxlgfUneB0u23ANwuH2yMjoClVgLprC9fhvHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=T8zzep3G; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="T8zzep3G"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dRLP06Wd2zyY5;
	Wed, 10 Dec 2025 18:13:24 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1765383205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L4p3cmGJPMDhkJ/nlsUfoswOT2xcuoTNU+p8gWWiZEc=;
	b=T8zzep3G9aMA9EvY8WI8OdkLSS/SHFkhQ4RsKTTmd1cs0jrDLguPDeA7CS7bzRJeY2wF5M
	HZoLAMEokohoYLQdvqhGsqyoWpRQMav70nq1xuvX0ns/CslIkm4yENOPwksy6UCB84b1Le
	AyqMrxvW6sWMeUJ+TvLJJaVbdv9sIY4=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1765383205;
	b=tz4Ma/jeQCv54MUJapjHUpcbcoeyy7IfKKrni3w3O9kS2Kkqb6iX7+/CWuQ3SSUSTB1N5O
	0eMW0qpHQxVID6KAxMzebFEMoTWscjoaA/q4hQXD4v8G6i6hNs72K4pC4Os3al75t1zkxo
	NyZHcZMZdER+I2mhN4OMMHSI7N0h2hU=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1765383205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L4p3cmGJPMDhkJ/nlsUfoswOT2xcuoTNU+p8gWWiZEc=;
	b=Id56aNn76CAZ+vmei+V+AE1f1EISNyIKGbMH+6+umerVk1mbX2QOak1LiIllAOtGhJPW1z
	kaQLlYMPBJi8xmVkOjv3s0GDXVDpBHd8qNgjqTC7qW32/Lf1of1ux/bphQlSVi6pC0VEUo
	CEpplcEM8lWA2o3X12L3QkClnCC1OMA=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v3 5/7] uinput-util: fix compiler complaint about strncpy usage
Date: Wed, 10 Dec 2025 18:13:13 +0200
Message-ID: <22eca2737d042f897f0a63d24adf94dd2dc20885.1765383173.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1765383173.git.pav@iki.fi>
References: <cover.1765383173.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes:

profiles/audio/uinput-util.c: In function 'uinput_create':
profiles/audio/uinput-util.c:97:25: error: '__builtin___strncpy_chk'
    output truncated before terminating nul copying as many bytes
    from a string as its length [-Werror=stringop-truncation]
   97 |                         strncpy(dev.name + len, suffix, slen);
---
 profiles/audio/uinput-util.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/profiles/audio/uinput-util.c b/profiles/audio/uinput-util.c
index 75f2a500c..d7c24a0af 100644
--- a/profiles/audio/uinput-util.c
+++ b/profiles/audio/uinput-util.c
@@ -95,6 +95,8 @@ int uinput_create(struct btd_adapter *adapter, struct btd_device *device,
 		if (len + slen < UINPUT_MAX_NAME_SIZE - 1) {
 			strcpy(dev.name + len, suffix);
 		} else {
+			if (slen >= UINPUT_MAX_NAME_SIZE)
+				slen = UINPUT_MAX_NAME_SIZE - 1;
 			len = UINPUT_MAX_NAME_SIZE - slen - 1;
 			strncpy(dev.name + len, suffix, slen);
 			dev.name[UINPUT_MAX_NAME_SIZE - 1] = '\0';
-- 
2.51.1

