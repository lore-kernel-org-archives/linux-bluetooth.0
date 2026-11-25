Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795641123;
	b=WRh4+yGDHoj192C/B3ioUz3Y/nA+q6O6u3X+3UGNR75gfrNLnHdRA7qMyAcE0vJdJKaM
	 nM0yCwQ/12Qj4oNqF5R9luutE+sdSk3kWdfbklKnw+8c/NVel3HQGhm3OBJFhQvMLuesK
	 KKm1t/xDWcG55DlU+k27UwIj7rhiOx+1Pj8pESwtNGea3B4TqDbDfK3Qqfb+j99AZ7niD
	 JgQI3dhZOgB0LHz6dQn18EclbsirQcrLmgX1ak3fPZk7R5dYASxWDTPxtAxLWAoCxgwJu
	 UNK5Md7i7LfrIGf/YS5djE+E7xk9Pk3WDx3T75yP99ZA3iWX7g5z1Turc7A6/57EmnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795641123;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=aMTFophXEJAkRoKOWBQEmXxasmuNjUzPsZF5lhq/wA8=;
	b=001y7K1iXJVO9HPO/3efknINdpCpzwXu3P1Wux0llUpZCakGCglfQE2Wd8XkPIfHhSSm
	 qEz/oLbTzJlQI8XQPT7uLLeLQroz+fKHXfJxE3vytk03Z86JYnv2X2rIw3LXlzBzbcP/a
	 ynsnYCqB0hkGe/A4RI2nYzkRggLRSplzrGj/+9R6RoX/LmmLRU4YBJ3o+iDDaxOej9o+3
	 HyCjCytm8FqviySPxevEISYo7RgHe0E2NaBB8Q9K3TLQyVAWNmloHg7eJ4a+QCiR2PDP9
	 vsZJnfrvS+ku0250qO/3e33yHFqaXUu36SMSYaE04Dtsl1ecSz70aBsbJX7fD6pFk1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QUD7Xqnr;
	arc=none smtp.remote-ip=209.85.222.51
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25814606A323
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 21:12:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25814606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QUD7Xqnr
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-9906870a9baso3189074241.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 13:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795641122; x=1796245922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aMTFophXEJAkRoKOWBQEmXxasmuNjUzPsZF5lhq/wA8=;
        b=QUD7XqnrQQzgBwEIXg+OfEsxsEUFg3zItjXtZbZLj87pH8DFH4yzK2GEOAB3gUYuXb
         IlFPENRrtH0G33mIcMGVGX210DPZb/m/A2NqK8LroO1RxtlPTFr2MZzEwFZm52m810qy
         TAnsdLI5wby692p1k1Z+j9WA7Lczk1UrYBiPKP9/jUe4F6fBwYJy/OAAGhW4RNgEccxr
         GnsLQXYRZyCoIYk0wepYpHNYJXmS7Z7bDlVi/zwE3+WsGpsjcRgBjc0h7ORGM4jDZZyO
         uLN4S/8PJr1SlBcmvR2R1slZe0NXFBQ4+jgCkl+kIWKigZTv9LLsAtIDMwA9dtGY1WXG
         QYfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795641122; x=1796245922;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=aMTFophXEJAkRoKOWBQEmXxasmuNjUzPsZF5lhq/wA8=;
        b=WO5UMjWHOXruMLDxZmV/pADTGV8mvP5g5N3Un4j+PTCNYWl1eq/Ep/aow0qGoC40hd
         Dm3OHgcplSLq29OYLvjpFRpJ/4fXJG+G2IRlhq0Yg/uKnMGhPx63HOxNp5lQqm4EGADf
         sLv11YCO/go1Edp1sBPh8NswBJdfg+Co5YbBUnk92lMcJTKPKPouTzQ8LSMdsl4JDcTz
         H83dMEGDVSXug1jIftnnHmlF3acSg49oUgUaMxdcOIgsLwAIzxgHvHDNQX3AxMxNJUNf
         Dy7QSs+jvbHMC4dOVFbQz/+nb7KLnpfID4VXczccMlTqhwrPl8e4djnD5zC8B46DxWRK
         J0Mw==
X-Gm-Message-State: APuU4Z/FeehUV8bK9WxTe+5+nxjxCi7aBa3K1PN3mW4xX4edlap8P5E+
	Ziot3BvjIvazRZLUIx1oqgRchYUVWEmYfCkxenK6F1cSq/hcs/PhVbMi8WKPJw==
X-Gm-Gg: AZFdTZf4Jy2VmiLY2zLntede5SsWsGxpFt9UQfXVK4HRx+S81NukR9PJ5pq3wuoq7rD
	2B/BgXp7gaDknJ8NomkWikg+snw3NOzdc/5CgF0YuGEOhUtYg9LDffFu+RrewVsGJtTjfNr2N7V
	qzLk4sACe/L89f7Ugw8L0MVGSrnQxrXpd4N4JJklKoPJk4Il2JUZopDTzRLXPLYDh8V9/0YdSnL
	jfxjq47fClpTlcdrSp/w6E7aSoE/LQXktE1eXIUHEgVpGiu9IgzaRmoi1zFilgH9097mGGlKo85
	oBcpirHiv8t5EsverRHULGcSBaYMWD/UgoSGz0xtDdS9fjRYtSWVCvYP/Jq+pwljuieo7dZq//1
	JO+fldIabVJ30td82/rIyNBLT8zSPzjcGG2S/7uu2+UmLXwSt2RJ+N7m5iRendO/JhS8r7HC0fI
	BpQX+SyAqWBXukhFB/OtvdqAi6Ffn8d7gzsGLfhICuGisk8B+oHQGCAXPT/rsh/FmLZ6ULizIOo
	LElBg7FS/txQYjLUuks7cfFACThIb5+pFb49Alfv9TyHgbvR1C5j2iA64uw1alau7vegueMOMfO
	GomNmT6q7VpXcxOzMMVCkYD1VRunOvv3V/sCrWJt2acnsAQUnY0/zzxoR8SyZqyk4McRdfm+vb3
	g3Oef5a0tKw3hWu9qqcZAGwWF6nRTIcxDOdQeHd2kwoGalJUbH+DXJYPjV3DG5JdbwUOnInzfCO
	twRJ0=
X-Received: by 2002:a05:6102:1614:b0:7cc:56a:58e5 with SMTP id ada2fe7eead31-7d7396ef657mr10306337137.37.1795641122094;
        Wed, 25 Nov 2026 13:12:02 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99e6e0686b1sm20199653241.10.2026.11.25.13.12.01
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 13:12:01 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 0/6] Add tests for security of deferred setup
Date: Wed, 25 Nov 2026 16:11:54 -0500
Message-ID: <20261125211200.1955466-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds tests for listeners using BT_DEFER_SETUP when the security
of the link changes, or is still pending, while a connection waits to be
authorized, along with the emulator helpers they need.

The following tests depend on the kernel series "[PATCH v7 0/4]
L2CAP: Fix channels being established with insufficient security" and
fail without it:

L2CAP BR/EDR Server - Security Block Downgrade
L2CAP BR/EDR Server - Defer Encryption Off
L2CAP BR/EDR Server - Defer Early Accept
L2CAP Ext-Flowctl Server - Accept 1 Refuse 1
L2CAP Ext-Flowctl Server - Refuse 1 Accept 1

The remaining tests pass with and without the kernel changes, they
cover paths that had no tests: deferred setup with BR/EDR, LE and
RFCOMM, and a connection being blocked when pairing fails after the
request has been responded as pending.

With the kernel series a channel is refused if encryption completes
below its security level, so L2CAP BR/EDR Client SSP - Success 2, which
requires BT_SECURITY_HIGH, now sets an IO capability that makes pairing
result in an authenticated key.

v4:
 - Add L2CAP Ext-Flowctl Server - Accept 1 Refuse 1 and Refuse 1 Accept 1,
   which check the response to an Enhanced Credit Based request when the
   listener refuses only some of its channels.
 - L2CAP BR/EDR Server - Defer Early Accept and Basic RFCOMM Socket
   Server - Defer Early Accept check how accepting while the security is
   pending ended, an empty queue or an accepted connection, instead of
   only that it was attempted, and fail on any other accept() error.
 - L2CAP LE Server - Defer Success no longer expects a response, so it
   only passes once the socket is connected instead of passing with the
   response.
v3:
 - L2CAP BR/EDR Server - Defer Early Accept and Defer Encryption Off
   fail if the final Security Block response is received before the
   connection was accepted or encryption was disabled, instead of
   passing with it.
v2:
 - Add L2CAP BR/EDR Server - Security Block Downgrade and
   btdev_set_link_key_type() which it uses.
 - L2CAP BR/EDR Server - Defer Success no longer expects a response,
   so it only passes once the socket is connected instead of passing
   with the first, pending, response.
 - bthost: A request kept while its response is pending is only called
   with Connection Responses, other requests may use the same
   identifier.
 - Set the IO capability in L2CAP BR/EDR Client SSP - Success 2.

Luiz Augusto von Dentz (6):
  emulator/bthost: Add helpers to test security of deferred setup
  emulator/btdev: Add btdev_set_link_key_type
  l2cap-tester: Add tests for security of deferred setup
  rfcomm-tester: Add tests for deferred setup
  l2cap-tester: Set IO capability in Client SSP - Success 2
  l2cap-tester: Add tests for partially accepting Ext-Flowctl requests

 emulator/btdev.c      |  13 +-
 emulator/btdev.h      |   5 +
 emulator/bthost.c     |  86 +++++++++
 emulator/bthost.h     |   6 +
 tools/l2cap-tester.c  | 432 ++++++++++++++++++++++++++++++++++++++++++
 tools/rfcomm-tester.c | 167 ++++++++++++++++
 6 files changed, 708 insertions(+), 1 deletion(-)

-- 
2.56.0

