Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795244284;
	b=jvlw/JU9cXmss92PQPvg/ekME7ppFB9CaSly0ncfBRXT8xg0PDqcYhWynfCrDDfarCZv
	 dczRUWClVs/4xTaqlo9FKXPIg9ywWM9kuSgdf1udNMZRP/23VGfZmL9ZSzA7sNSDO9qU5
	 122jTJW9c6dLIvz0lh5pmeszi7vrccJmC+DQ1XI4WUeRk69HQcsICUARPyE2AcIIhuGa8
	 XBTxHHV/4yVAhQ1hEYu6Q+z6RzJbw6svH46i6U7VpU80q/Trzn2YXGX0QoHL0bZ8pyhYI
	 27X0iim9nzR9Qo/roU/AxNt1QS+nwECTp3218VCgaTZ9ZSy8tXlxLgeS7n5yByfp73Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795244284;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=HJvLZtYqV9IRY5S+Gk4Obo3dupP4kEt47B2cXHjBvWw=;
	b=px3cYnuDps2hmPThutrIA6jKctJ5XtcA8CNmlHjd68pRu7HL2fWuL80vUkYECmi2ohIN
	 hzbhdqqEVCHKI7H7b4MHdt1XtTsbqGRPrGr6oXRhW7Iy109tDSydlpnC13H23vXeAOhw0
	 4wAYt9TCgPBZZh4NFwLVd33CyCqoTfjgdT1RZJw/qAIQsNL/1QmmhBtxE6sozwnL7rkVR
	 D6obQ00pfzmXDQtU2+YRzTYPu9q6zApgmIYax66L2/1Y8ui403vPEx7Fs4IpkanSxqnpx
	 qEVmQg1fYv25lMZOGATzfGupl+XdK6CUMJIihnjViTH6PZVOBdYHlaHF41qDHrp9AJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SoeqgtS+;
	arc=none smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BF3606A320
	for <linux-bluetooth@vger.kernel.org>; Sat, 21 Nov 2026 06:58:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83BF3606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SoeqgtS+
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2f04e3bf46dso9808155ad.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 22:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795244284; x=1795849084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HJvLZtYqV9IRY5S+Gk4Obo3dupP4kEt47B2cXHjBvWw=;
        b=SoeqgtS+1h/2ImBq/UuEjf7ZubtLd/vVrYcv1kJZWXz+PiNQNVFZWNIBtR17VmMt8y
         TfTkpCcECO8nHgS4VLKyTR/sUm3GwVWeqSjZP6lRWbxf638yFLhvtPGcWOxgkBB8gHUF
         vNhothvTxK1Gt5lW9YmcEXlvpUWMpuzuzCfK62NrbgJ/dvceFbRp5cY7GfAdk76iXQYw
         J12xwfMV1mizZvOMAbahnokRSDIE7zst+HAIz77OQRJNHn+ARhIj1hZcwzf6+cvi/tC/
         cdptZ6gFZzRmRfFXR/sgRyNaPqE05qQef5yQEII+forAcqApeDrnKgqoE7wNRHgEarzu
         9S0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795244284; x=1795849084;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HJvLZtYqV9IRY5S+Gk4Obo3dupP4kEt47B2cXHjBvWw=;
        b=X+mP2+QJjZuO+U+bNcOQztT5QDl0jWFMOXHlCcKfhgXLr80vjz0kaVL25suoTM8GPi
         iM0l3G8AAJhBmK41+ij90BvRQLpREElAHwdaXfJcXIlm/GcHt1P8CMJm9KaHEQRmxZdP
         okG7WmYvAaaxpQIBG3idWXSNz1+7yyTJql99DxT7Pu+dUg7HoWzQ70mvghs4cmNbkG1m
         DUQ7oPyY7ZNUBNcpIHrs3URiyeBLYtRzc7EbRlGfIJkbjRJAcIuQPEos1OwOTcDxWkzI
         iDmFM+1L1HYPUK4UWK9hpKBf+3wwz62xEPgB0IhKX3i756JJuWNLat1DHI7ZMbf7gQQz
         4LKw==
X-Gm-Message-State: APuU4Z9xMFjSDGR1XSZ/IFwiNSBgWEFIvZF5oPWrRnQ65TmeiYsaSQuD
	IrxE758HM1fKYSLuTTrn5HdMY9dMKHHCEhL3SDNWHD23b92dOg78kHJQ
X-Gm-Gg: AZFdTZdpWXGxvvY+ugsyQdFwNoikurZ1OQrgnsxoskOC75TMYGDtuMuPqMA/asxC7uD
	eH2ZgkOx4CVxLoaokfb4/u3DN/49lhnyoaW4XKLKK5Vh0BJgRhMcJjaUp6TvHRLuaZhvaCnpyYt
	QgCISXbBOy3lXVa0ILZjpJBzmTw/0gV0cG35dznRl9ZhlIe2WyRV19R1MoRLNqDrgBRVnqkTn6/
	T4xdVAWTAZrfrjRhLg7i71L6a2nmev/w8EgUcZTuPDQkM4+KtYZpCib06VScrgnLKjSK2WHQrPo
	zdSHSgZiS2bjrh3ZFZZAoC66Iy3DPXx0iBc4VzBpiGQ8/QGBDcs/hbRdadqjKPcNftVLgvzn+y3
	L65pEn6HiiD/iL99OWCC0pQCjiiEhYZQanxWZw/ri0eKm8W9Xh4I93327mzbq+WTXevF1rTht2w
	TXwT3ZEBadzVpUgNUpiEN9Nnxtjv7QphXYHit/1Epn03EFoafPgeja/QrmQ66oJNo5nxJIAck8l
	VU9G0Fy38ncqF9PKn8X2cwLjNLK/k9j9Ac7CMzjSXTaWd15R8bk+9etPNaP35IWQvMpruGvsize
	ojWbPxy8UFCVufbd9SZxmOkP
X-Received: by 2002:a17:90a:d2cf:b0:3b4:1714:5bfc with SMTP id 98e67ed59e1d1-3b41c9b9dc1mr4963449a91.61.1795244283752;
        Fri, 20 Nov 2026 22:58:03 -0800 (PST)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad48786sm7447286a91.9.2026.11.20.22.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 22:58:03 -0800 (PST)
From: Cen Zhang <zzzccc427@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH 0/2] Bluetooth: SMP: Avoid stale pairing key reads
Date: Sat, 21 Nov 2026 14:57:54 +0800
Message-Id: <pm-bluetooth-objects-candidate-0132-v9-b93d60723e48169ee3ae-0@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Management can reload a key registry while a pairing context is still
alive. These changes use the pairing's own flags and identity data for
the debug-key decision and IRK notification, avoiding reads through two
saved registry pointers.

Cen Zhang (2):
  Bluetooth: SMP: Use pairing state for the debug key check
  Bluetooth: SMP: Use pairing data for IRK notifications

 net/bluetooth/smp.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

---
