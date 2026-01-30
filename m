Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344C03542CB
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 22:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769810596; cv=none; b=EfiqYrUNP+k6txV6RQT1f5m/C3ZamhFY28x3n01FfOK1OTxpXXGeKTuqNz7fnyVyOHf0nnmTzYJqZkXziCacook+8rmrQ6HoQivMfCyn/dveR1kythQIK+j/TIC0hvWgYecCubZpsNG9wiueCiUQa/CBaGGnM69AxHEHH3IDu9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769810596; c=relaxed/simple;
	bh=LUvx/+Q3xOMrhSXC238ySseF1NFqUwYEOKxEONrnae0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FGc97ijdrXfAwDfXr4sBCSY/2dvBncDJG5oRRH3J/xWA+ohBV3YQSNCKAFlMOr+LqPa0+c/UJLC8w7W38q85M34DtQV732kyUyk8k/whcbIX58uuz3b9wo8RHdylRmTuGYgUhHaxYjNVf4xo5bsTpdClxM8olugWvKOShVTbTLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZTfm59u5; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZTfm59u5"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-94120e0acbeso1447982241.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 14:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769810594; x=1770415394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g3dZOCvLZWCbbCQbDN29wytuTNMne4wDsKPEOd4+Nko=;
        b=ZTfm59u5XOMcQe0hva3Rh3lPpvrP0Wdm2h0egAd0yY1c931RABVrpeh6fKyIGQ4OVG
         jT0sqjwiwkgs/DDAjnR9Firu0EUM+pQ6tK9biOEUaolJY4UYcMNzc7cyZwNdq1iG8d+d
         9aeUFETyQ4fXuKen+BQ0kMFA5lJZOdQNYUsaxWSHd008BePuYFuCNdL+ZDa30CN1vxtI
         aWDFolX8l5kpL+b5PQ4bOaRIzoVMEAlTx37w3x77E8fEdJVISPktDDwt8KBHsNzB1a4i
         tWdrE++l4LH2wqBZol3iK5y8YUlMEnKXldAZlK7DrSQaV5VKk4Ux0AYt81vFYFqOzjHR
         I5/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769810594; x=1770415394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=g3dZOCvLZWCbbCQbDN29wytuTNMne4wDsKPEOd4+Nko=;
        b=VPsoFZ2SZYN/YDUzqA+XIySrSPAmuM01ifM63Kq9ly1U25YK4uJoS2HTNcTa8RcMif
         7BkXE/HGdlmit8KLg7BVkvk5BQ18f3rTCV7SROjwNr9tJMGQ0ep/3RPXmOQWAMO8etR5
         syaU5ptvwiWXmy09F7ORFWBzGfXe7jFMMKKGDw48QajgW4xqblrT/0oUA/jEYdF1iX8B
         z0q1wr3s979bIpV9gSyDFON1vU72ubGe4w0JKv16FFsqNkst5f/Bb8vhvl58DM7fj4VD
         ZO9MinCVM3c6lt4jnSa44cSJxrnfkWdstKq26jCAwJv0B6Mb1Ltzlf+YE2Y/2Y3luahP
         RDzA==
X-Gm-Message-State: AOJu0Yz5oBEZGEr855ZOlp8kVWjf1dZ/LMW18yztBso84rTgkcMcNvNE
	YoZsV6pRcesuXpv/T8vPj61DHXT039XbK/k4eK/XAW4ik4WUQd/2sKPXgEgWaA==
X-Gm-Gg: AZuq6aKYAlTCMtYma7nTpjwGvWHjoOkPg+Ipkcf7ud1v6cV/FoPocDnTQnGxohZZO6R
	HXTl/kbEalvlh0HHoQaT2xVWNo7tIORb2bo8GEJ1z2x4JZ/OXgXWCNbuz5nga1CiR75OCIByfRJ
	KIG4XBHiyCLujQQ0HNy8oyN+bl5PnKXazfdpwm50evMcGCzyf4wIBHtDhWgDuNb79jkNaPvNBGF
	pYyArW8x8HPhCepiGtTizMfMsH3L7oS0Q6mtW7t/Fg+FL19/yqAnHgcgLPVG5nEQeKpSNtBQgue
	6a5O/YuTRbb7gjVEMngN/d/XgFxJV+d8oU/P3Bpc9M3wKBJ7pKVb4Fq1j6oj1JOHHSo59n0dZ3n
	S/fjYWw3y06ai4EaJcBKvps6uojaK5/TVIBRxB8m64z8nLrKTOMbc6MSIRh8jr4SIFL/h8nW81f
	4NEwvGf7nQbeYf1gIWyTawcO5egxpgTTleLjBC28lOhNqK+2nG2DwzdYsYyamH5KU+eb2MzaL5p
	yafMJ8h2ErfUD/v
X-Received: by 2002:a05:6102:1606:b0:5ef:a1ec:fbb0 with SMTP id ada2fe7eead31-5f8e25f38bemr1733631137.30.1769810593910;
        Fri, 30 Jan 2026 14:03:13 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-948723adb7csm2404052241.2.2026.01.30.14.03.13
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 14:03:13 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 28/37] doc/org.bluez.LEAdvertisement: Add Used by reference
Date: Fri, 30 Jan 2026 17:02:19 -0500
Message-ID: <20260130220229.1346261-29-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130220229.1346261-1-luiz.dentz@gmail.com>
References: <20260130220229.1346261-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add :Used by: field linking to bluetoothctl-advertise for this callback
interface implemented by LE advertisement clients.
---
 doc/org.bluez.LEAdvertisement.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/doc/org.bluez.LEAdvertisement.rst b/doc/org.bluez.LEAdvertisement.rst
index 680a6c4cb97b..aae80f08f3a5 100644
--- a/doc/org.bluez.LEAdvertisement.rst
+++ b/doc/org.bluez.LEAdvertisement.rst
@@ -35,6 +35,7 @@ versions of the same UUID will be used in the advertising data as appropriate.
 :Service:	org.bluez
 :Interface:	org.bluez.LEAdvertisement1
 :Object path:	freely definable
+:Used by:	**bluetoothctl-advertise(1)**
 
 Methods
 -------
-- 
2.52.0

