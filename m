Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795526410;
	b=IvVr9I7Ze6Z0KH+73Js3j8j3MAWhirsc1uxDJNuRuwYPwDFbxvrYP0HADTdfZidqZYrf
	 XjmD44/nA4J5VN4NgCs7anr9ttXjaRAZy8gAsJMrOMkk3N9Co9bXVMKKnvC5+ZflWrQqY
	 k6p72u04AfU2SxC3CYG+GUbcw651IKej071brMevHlaocLz59IyPCQ9n9HeJlR9h67rLL
	 150iPQv+9uhtEjXaEJ/avKRq7XMlBYK3pTxa4scAsL2PIXRt8ZVqw+zhe8fufPOyINTCU
	 P0JL9I8oS56hPlSDNQSidc4qv+Q47XBNtoVUbDVCY51RjfFzSvJsjG/9YusjxJ98mOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795526410;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=KjH2Owsy5cUdweEkXdaQwLd/4OzSGSG2TGUzBMD61is=;
	b=EWswjitMYYOdRNWPi5hUGXrwDbWMiLGn8c1ORcRHkpAEaW1t/KH7qjfa26oOx0K04aJv
	 1CHu5YNskyihxPTV7gXHOarglcQqtdiic8fHU7KjHnjVWpbgreYVE8lOEoxsYHbltmcDV
	 BacxaDTtoeU8rCe2DXZv37ix4gpVXnHocRAljVPYK+QOy32GH1o9747Pf6hYV80HVv9tf
	 uLxhwzJ9K8pMfw3dUbqIS3J+OaazFgjrR//QcP2cy172ktVGLsOkH027xiwYXwJIm/y9Q
	 Ea+pcM5z2uhbwUL8/q2W2ITE6+5VwF5j71Ynu0kl89R9AryJzdMbTioxwLgLdiVzx0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=OvH4IIzF;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCEE606A33B
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 13:20:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6DCEE606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=OvH4IIzF
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4bb6886d30aso43214725e9.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 05:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795526409; x=1796131209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KjH2Owsy5cUdweEkXdaQwLd/4OzSGSG2TGUzBMD61is=;
        b=OvH4IIzFekP//1RoNgggqgxZDnP/P4/Drr7uNG7Oo6/kvvomKy04ZjfRSxoSBggNI9
         XlaRiNI4+nlb5Qe8QKGDSK9LvkEBBQrzRoOFAAKPMfbgvBu+IEdxIGD38oN3EGb2zfK8
         SS4iLK8ZcycbAjZSEE17CVCJsRFPy9ypQgSoc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795526409; x=1796131209;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KjH2Owsy5cUdweEkXdaQwLd/4OzSGSG2TGUzBMD61is=;
        b=rMeAitwRXk0EVGh72LMCuwjprE95GqtnbAKrZ2LYzltndJK6dmGddWR4DMFXlIoiOr
         Bdv4baj6wP8X0rEHAhVhFqOQJKyrgcZ/l/uNg57ZIaeOniV7M+H0c3f44Z9Ay5kDR0MM
         PbHrKZFjKUWJ96IoIjxS5lTTXB2DBhhILbByiRzyU6oXcp8dF+AihZpeiCopt/8+eqcE
         DbDLVR3AygVvgxppaJFKwvl6VTPidy2BfO9Z0s9GVnlWyHGDOOblldjxKSWxKglOCRZq
         yU/w9jxGt1MRGGO4QUucZr4KAWAxdfGu9kDEvFFleyyTg2V3rX+iOsQ1+ikXUdlViZpS
         ug2g==
X-Gm-Message-State: APuU4Z+msxIFHsSOlygc5EoO2wC5Iamq/y+yuN1d3G7gmLkVAgjTj6tk
	Tb2akVLKRB6Az064qiHAOSNS1XdhO/jMQMwQ6ZZrcAcN3smcTnlmT498ykkQ1H7oCpS+ptVgdpk
	WchWH
X-Gm-Gg: AZFdTZfX4QIq40qhm1xg1XumpixvZjcMytusbbqPoJIat/sHi/PJnNH53wG31yyMCo+
	yVoWkjfYLFs4q7S1/SWrSb42CqnMgbrsUHX7xwEgW7jmMJjokH4rzPSzqGR2ljRpvNp978f3DiY
	1BT75Wq8/TQd8Gj4V278R0peKDyMyLIOiQhWeky1Locr0iRC7Ox90o1Q/YeZ/YKuVEmYqLkruht
	RTSCyJq8iZuCE2FxZxJm5RdQz4Ah9BX1Ni3vEKY6SjsuC5ABPCa8IHuJF43/o9cFkHczaXQ1eiA
	ibbDu5D5tZ83daQKPkwlv4PsPj5w1JjTsLR43+Ed5G+TFspyDs5c1c6dqq4wudGkyStdRjhHe01
	7JM2iTNiW2vf2zFg+QObc+Ouk/jWm+I6Gnd7IO+3zsi3wQmNmUxmwr4EqXTWq7RyTF/UvRo9J/F
	EtsptlITWXtMEduAiHLuIu2i2YWfO2EaKEjzLXi6VS52JZ7idPS2vs7An3AvhG0ZauF/AGSLcoE
	tEcsKiLN5W2gCYLCBzYfw0vDSYA+FLn1QWq7uCbi28ldCV6xBuNFXH/n7iubVoBOiNgBGMdP8ZW
	9oiBbVvy0ZlZd2JHDteLrL3Vn8BuD5S8MRgHwjZu+4uhg9uBSbw=
X-Received: by 2002:a05:600c:8210:b0:4a2:1a:a116 with SMTP id 5b1f17b1804b1-4bb887865b5mr293528955e9.0.1795526408754;
        Tue, 24 Nov 2026 05:20:08 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:d476:8432:c5c5:dd98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb9067846esm270963015e9.4.2026.11.24.05.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 05:20:08 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ 1/4] doc/org.bluez.MediaTransport: Add Mute property
Date: Tue, 24 Nov 2026 14:20:00 +0100
Message-ID: <20261124132003.3899120-1-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
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

Add a Mute property for LE Audio (BAP) transports with a Volume Control
Service session, next to Volume.

Assisted-by: Claude:claude-opus-5-5
---
 doc/org.bluez.MediaTransport.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/doc/org.bluez.MediaTransport.rst b/doc/org.bluez.MediaTransport.rst
index e50ec3f20..35a227237 100644
--- a/doc/org.bluez.MediaTransport.rst
+++ b/doc/org.bluez.MediaTransport.rst
@@ -160,6 +160,16 @@ Examples:
 
 :bluetoothctl: > transport.volume <transport> [value]
 
+boolean Mute [readwrite, optional]
+``````````````````````````````````
+
+Indicates mute state of the transport, only present for LE Audio (BAP)
+transports backed by VCS.
+
+Examples:
+
+:bluetoothctl: > transport.mute <transport> [on/off]
+
 object Endpoint [readonly, optional, experimental]
 ``````````````````````````````````````````````````
 

base-commit: 1608f836188610aabeff5a3164169ebe0360e443
-- 
2.43.0

