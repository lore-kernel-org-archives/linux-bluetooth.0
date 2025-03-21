Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F89241C64
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Mar 2025 19:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742586353; cv=none; b=e9aOUeZZjsuMAIojHBvnkOzaYTePcV4hiKNlKLn6SDPOQOwo8Xlqr7UnpxoN+Ah45KF5weVzDBXMaOgdmJ7/c/5Q/8SaluJVmUOskviF28k3zvBuzVRhZDlDvP+kOAJfGy4kavVH2wR7vRmZDg7D4zFnoFPpNfl/zCA9xRQiLOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742586353; c=relaxed/simple;
	bh=USJvLpemHmBWdpM+Yu/IlUrbuNGcOT0su0cG3RU6qOA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=aMBCNVIpyaWI63/1D7VitTfNaxWiyi/4GHoDn4chx6mp3wvgqm+Ur2uWeWe4BURv/h3lqFIcRbpHPJZBGujaw1vxySXqah7uFkx1z8Z2IXrpl2xjHnmcuuy8wv9XnPDzegrJ7arAXuuxOD2ZPpr/KbDAxZN7Z24Ldt5ko0hVGHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KmiuRZNV; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KmiuRZNV"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-523f721bc63so3045013e0c.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Mar 2025 12:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742586350; x=1743191150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=sY3VK+k9fQlOzDn+gms0VEXawpB0JCEdap4mn3LAEDA=;
        b=KmiuRZNVLviC2dVcZEaVJdC+MP9YhDs0FlgYAjO8nZMv6ButEVN7IWr5CEPXR1e0Zw
         5uKRZRBy0iWMBpXQWL8iR0OMbEp4ZG1FLouJ66KHyxPCspTjCrGBvzjOz4Oo2J7ogkI1
         wsBldJHKEGw2BdURDTCITd90MS/mYtUGSNLXkKItJA6KVJ3W3JZj1H/3covWevAWUOG2
         8bdlxOhohafEnqmRGGih/Kz5fo3IXqVfKISrH9P9+KhGGVnfq6i8XuKqc4WHTV6xokFr
         1Qn7IkQyZ4tK4j8LC7T7pWh0mhayplFDYRKTZuHVrfNbRKOjmTnpQH8b+A5p73skXj5U
         wkRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742586350; x=1743191150;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sY3VK+k9fQlOzDn+gms0VEXawpB0JCEdap4mn3LAEDA=;
        b=UramebYzPsQGj2IFxbAPDZUcZbYjwREZMy+hLqCWowXZEKFowOS/meggp6D3AkCHVA
         FFELAkEimr5SA5FcoIop0R2DWfvn2DAhHwSc8wlEm6ULJm0Ao5t0pttOQgJDz0pn9WH4
         KSOMRafwj23Ttq5FCmPbwDTvGxqB1rjB/KvgNeoQ+4yqopa9GN2mUkiUPmWzbvg/Q/3D
         zU2DP4B2NEQyokBWSPilxCrRYW041k8NecM0CC+lPuQEx+fxpS/ztvffaMCqIqs8vC1J
         ilWBUzzzuKlSBo33nSRgtT1lxGTwE9ysRziMa+1VaNVbuW23T1qE2KpquVqUz/JrF/Fj
         CVbA==
X-Gm-Message-State: AOJu0Yypt24yve2p43Speif9YM12uWgArzmoypq3euq3ZK3/opupus3p
	r4g7pDJRLDmXHXzSAnbYo0ZsCabk49J/wuLuG0PCz/kn1Ie+YUj8k207tyIY/bo=
X-Gm-Gg: ASbGncsFFhryPZPpPOkZWrJRwwuoHO57pKV7bmoL2ku+IBR+BEnqC+fFCGpYdbpK3Fa
	Iwcuq9ykRKUQqxZC28SMhr9NMA5aeWYJ4ZYjwpPdab0amLJ1knjLuIdYWX8wNqxKdGsM6vK9Un9
	Vv+Rcva8joTrEq8NBORi0NlG0d8ugkK7Bs0N97kqKxwBk/n4rltejGEdL1ijknbVbCVKgrYWPph
	PAC2j1lktpJmuE2r+AkcZygeHzeK8yZNGdoBa6DMBRfSjy+pihgnQHAWCb5gWZC0mufuWUy+cxn
	sF1o5olptqtDIlH2t4szy85JFg3wlqpFICh2QupkWhkA0oYzvLZgTaWelDMGKSrs7wpWW8UMjjP
	uVZYGF0TFGIE/jQ==
X-Google-Smtp-Source: AGHT+IHVzI/vrpgA/stXghDmcmGvsOgovcyQSu5rWVaEsF79DxQkwQbe+8oo6HWv+Dx9FSS4+CW4rQ==
X-Received: by 2002:a05:6122:2395:b0:523:620a:ffd3 with SMTP id 71dfb90a1353d-52595d6a7f9mr7414920e0c.1.1742586349911;
        Fri, 21 Mar 2025 12:45:49 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-86f9f47a3a1sm519917241.33.2025.03.21.12.45.46
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 12:45:48 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/3] mgmt-api: Add missing Device Flag
Date: Fri, 21 Mar 2025 15:45:43 -0400
Message-ID: <20250321194545.1728631-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds the missing Device Flag - Address Resolution = bit(2)
---
 doc/mgmt-api.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index b4a5776574f7..3181607d94fa 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -3429,6 +3429,7 @@ Get Device Flags Command
 
 		0	Remote Wakeup enabled
 		1	Device Privacy Mode enabled
+		2	Address Resolution enabled
 
 	This command generates a Command Complete event on success
 	or a Command Status event on failure.
-- 
2.48.1

