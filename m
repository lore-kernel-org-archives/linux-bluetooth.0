Received: from mail-ua1-f67.google.com (mail-ua1-f67.google.com [209.85.222.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD76A337BB5
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jan 2026 23:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769728940; cv=none; b=WjSj+hMzNjIO+Bn+BvdxqxVKzqoEWMGyESIrh0FFruZiVhzBs3XwtVyb0Nf6uaa6ui+/EqN5w8nodlAPKjUpzfLajWLfz5++BVcDXD1nli/DoaOUB261u5LaRCrtDc5AvqpU8ORtlymXwnP1tByZtRep7wM3nF7Wca0SnsyNvis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769728940; c=relaxed/simple;
	bh=Oqd/5axQpNBBKaYZwC1sCacmNMfQHVOtd3yzKqeHaA0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F1nkIpaoIilTA87jihBU31srU+cuyOdbvL7LEQ8jCTlGU+vbwDYv30KU6WZTOIBrLxpaHrNLZfnOQIJo4TgSmkbOR9AsTY6H3gf5roGHCT0r1TMLrGmChJoA9c9PKdHNhCfQetyKrrJ66VWnYhBHp/AHK9rkS61yVE87++SZ/58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hFH7AWSt; arc=none smtp.client-ip=209.85.222.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hFH7AWSt"
Received: by mail-ua1-f67.google.com with SMTP id a1e0cc1a2514c-9481cdd7665so465360241.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jan 2026 15:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769728937; x=1770333737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mNiQi3h0qwwB+RsYOGqi0PNMnIa3CBX8un5UV6iRDIQ=;
        b=hFH7AWStd4Fvtlmcq3LO+9l4faGZysbZJ6HoWk9d4wAk5tmggDXFIUDshPTnYkxI+j
         DLQbUjZWxtE77RXdordxIrz2/JURHrG9CQtLWqwcYrqKDf4fSN9vx9AqHq19WzninH1R
         CIgMoY0zBPwoyA/6/1doHr2GFudZY9VeB/ZBTB1vA5H74SvEZFktqRg1dHuFUu1TPm+Y
         hsoqBAVoRq9+c3zmOO6OySyKwi5aZclhbMZEEwRZk5yisXEq3Vg+0DPrICzCPe72HGZG
         9rnc7S7NmHG3syMqhrlXrxQ37M4IsM0w+VqjmI2iIe5QIp3vApH41749oT0rRoWmn/MX
         lpFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769728937; x=1770333737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mNiQi3h0qwwB+RsYOGqi0PNMnIa3CBX8un5UV6iRDIQ=;
        b=G8uhUAIIgbsPXCDr1xtOYfPDRjuTyuh8ZKlGyvw+1Q+DzkVCBFtj1tuOY8xojRsz13
         rcCtxdsp/Hn3RNS2cbZjv6jX1oPElwgmvU257O2ZLK1UCv1/fJbhrt03T34MLGrDxnLT
         IwjrXknx0zrngj1OEsC2YtWyWHW9GNBmVORUQb9mM6GYM+YiJmBAOECdyHyRnk7Tsdw1
         f0EjgAWDB4V8risEF1r+rZ83xVtEcrHgzKFRc6zzycjLC60aphV6IZWv9TdLGphZk9iY
         EaPcxW7WfNtXJDiXsuD/OXIJ4FhD/Hb2de8ZQabhQcqIzySUy+5Ans4Kj+GKRQysN62j
         entg==
X-Gm-Message-State: AOJu0YwUnl1OUuXj24WE24M11qA9gTySD700YDi28RKimil+SOSDWZWy
	J3O2/RoD5+kTSC2WBrRK9tyfEpnL4wfRoDjWXGWPfu9LwGIJtG+yQ0daL4mBS74TPlk=
X-Gm-Gg: AZuq6aI1hbB5SizjMh6VO6H5B8+MSkaeUkIFPa0CHFI+3wx0rA+VVLKuTLMFH0CHLCt
	N13wDk3y9AgvmiF4QKda3CPWwtATZVlwohRVv8EQr7aLQEJlUckhM1Ma4K/2kjYIobqUO5L72YE
	PWPU75pHXGYmkQ3iy95KZ/VR0URmINfnyB/vqLM/lfak/9hWMKT3nXHpnWZ/cjgtqm3kwKXYx9l
	XUSXe10vAQJGUpyYbzr62BPNh/NkxyYMqdNjRJE0cD9Desb/0tR7ahb9r+P3kpwd9HVwqMZaXgR
	y1W4VsAY9IyjRpY1rmzbiEI792JDeUP2M6rya0ngtLdzrnW6EzvlaEGcB6We3NQd94VvOoYpJ72
	2eGpjPWqwDa+dIoj+qx6pfAuWUfuVFQQuayCRRJ+nMIcXCdfjeE3UH+jT3G4Su1Qdh78+iQwXUX
	h6ol+sWuEtzk93m1PrMK7GJICkIRJ+lMRtLbkHr+/HVxQcns3RNmAbm+f+qjpcLApGf1s7yOy9d
	l8vIw==
X-Received: by 2002:a05:6102:3585:b0:5f5:421a:fc91 with SMTP id ada2fe7eead31-5f8e25d2b3fmr329755137.19.1769728937504;
        Thu, 29 Jan 2026 15:22:17 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-948724cb7casm1535890241.9.2026.01.29.15.22.16
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 15:22:17 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 05/15] doc/bluetoothctl-assistant: Document arguments and add examples
Date: Thu, 29 Jan 2026 18:21:44 -0500
Message-ID: <20260129232201.1049568-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260129232201.1049568-1-luiz.dentz@gmail.com>
References: <20260129232201.1049568-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add parameter documentation for show and push commands explaining
BAP Broadcast Assistant path parameters for media assistant operations.
Documents optional vs required parameters for assistant management.
---
 doc/bluetoothctl-assistant.rst | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/doc/bluetoothctl-assistant.rst b/doc/bluetoothctl-assistant.rst
index 33fbcbc764cf..26fede09ae99 100644
--- a/doc/bluetoothctl-assistant.rst
+++ b/doc/bluetoothctl-assistant.rst
@@ -27,6 +27,8 @@ list
 List available assistants.
 
 :Usage: **> list**
+:Example Display all available BAP Broadcast Assistants:
+	| **> list**
 
 show
 ----
@@ -34,6 +36,11 @@ show
 Show assistant information.
 
 :Usage: **> show [assistant]**
+:[assistant]: BAP Broadcast Assistant path (optional, shows current if omitted)
+:Example Show information for currently selected assistant:
+	| **> show**
+:Example Show specific BAP Broadcast Assistant information:
+	| **> show /org/bluez/hci0/src_05_1F_EE_F3_F8_7D/dev_00_60_37_31_7E_3F/bis1**
 
 push
 ----
@@ -66,9 +73,15 @@ Code, a zero filled array will be sent to the peer. Otherwise,
 the string entered by the user will be sent as an array of bytes.
 
 :Usage: **> push <assistant>**
-:Example: | **> push /org/bluez/hci0/src_05_1F_EE_F3_F8_7D/dev_00_60_37_31_7E_3F/bis1**
-          | **[Assistant] Enter Metadata (auto/value): 0x03 0x02 0x04 0x00**
-          | **[Assistant] Enter Broadcast Code (auto/value): Borne House**
+:<assistant>: BAP Broadcast Assistant path to send stream information to
+:Example Push stream info with automatic metadata and broadcast code:
+	| **> push /org/bluez/hci0/src_05_1F_EE_F3_F8_7D/dev_00_60_37_31_7E_3F/bis1**
+	| **[Assistant] Enter Metadata (auto/value): auto**
+	| **[Assistant] Enter Broadcast Code (auto/value): auto**
+:Example Push stream info with custom metadata and broadcast code:
+	| **> push /org/bluez/hci0/src_05_1F_EE_F3_F8_7D/dev_00_60_37_31_7E_3F/bis1**
+	| **[Assistant] Enter Metadata (auto/value): 0x03 0x02 0x04 0x00**
+	| **[Assistant] Enter Broadcast Code (auto/value): Borne House**
 
 RESOURCES
 =========
-- 
2.52.0

