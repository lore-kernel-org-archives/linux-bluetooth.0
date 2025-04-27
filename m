Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095B4522A;
	Sun, 27 Apr 2025 16:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745771013; cv=none; b=qabsocOK+1LHmoO7Ehq12Ic7RwEAqo+OTXiU2uCRN/OLfLNvXZQEhkKSDtGT8MFB9+dnbi3Vf3B/4NmUO0SKoCD27i36uSSbt5FTcyxiGVWafEKsvLr3eqzwV3yraq90+D34C6jlatLwgrDPIGQuWhMadlWQODyB58bSTamygf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745771013; c=relaxed/simple;
	bh=u7rZtqeTEBNhbCs2z+YD+W2pM0dkaKhKfuee9KJf3qs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RB9K/8dmObonWc/P3Q6lgbVEr7Gr8SKwHGh2MqCQTP8GHl5k4ZKmqXX6qASbGjqjqEa7TFYv9NQtBxAQvMBhfz1L1z7/yl+XIGyyii4Rw0etl1Izz2Ni7KNyUWzS5oP+zUb76zkGMaBxdF/fU2x4tGL6V24Lsd2aolmHKVkPtFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DADPMBjl; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DADPMBjl"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-acacb8743a7so649246866b.1;
        Sun, 27 Apr 2025 09:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745771010; x=1746375810; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fzIFX0CgigFkZBJm8z/5Q/haOTHH6wXgOdQd6IFogh4=;
        b=DADPMBjlmoZM2TSR6xwskxd8S8fu3mC4aR8ReKi0LEpaeagCNUTGmLiOtPR15Cyivg
         yBvlpAhGDUOFoE8sOiBLRf1WyxV4G74ef3MC/ELwjCYuzrCjXaKyRHfPbBUdV2vZdjez
         l5tRMPAtl3uzEsWiDkIMhOX7yfF7tHlXwKFaL3I2axeVCaIMRAozCGwNX0UnAvnLgln0
         VRplOMZz4RYO36CyR9h7dHKsPqBoAaGoUH6xT7yJSfG08wu3txEtFItHcgM4g4/Jhz6o
         9+qTD+Sh/lEK25dq8d7UvKFkPtUuxDQ7fHEAMmhWOyzf/73GrlT5Pck5lSSu9Ck27ub5
         5+wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745771010; x=1746375810;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fzIFX0CgigFkZBJm8z/5Q/haOTHH6wXgOdQd6IFogh4=;
        b=d6DAmPA/kqkrtoJHW0UyB3srJAKVicXQT6x6knCO14l4Tmo7WEW/CBbB8gqRKzIMjx
         ULLjLSIe39B9epEbQfKLHZICIva6G2gG4HtMyu4xHd+KqRvtx7wII8NmNL1wX6cL/+Hv
         N31gPIA0eDMnoIomGCN+YqfFOkiBdpbDQzziRwLBdVpdYTsre1mVxB8Q0fQnTcmmlcK8
         OyhuOCPTBg6f9xGlMZAp9Kcl2aWSQcY6Q8k3Krvn8J6OVDE8dLEl+iLedaDJxUDpNd8R
         eaHdC/xxcwwHidEbxfreqM5Jclfw5R7qDSEvbv97GwWp44Czn0UCN3gLb5kLo1g+qu/2
         C7bA==
X-Forwarded-Encrypted: i=1; AJvYcCWIMpYf7c+N3/JziB0520n7C+QGTinSDy1vNWzBUm2aa+ww1wj0Dsz3DkjbHTl/OOpdTETVwuzviSLY5dGguxY=@vger.kernel.org, AJvYcCX5ewNLODF6DiUu5CicoOQK65dxwIFiwLo656/Z95izjuoda7vAmLPdYvWSJy20Vo2GLa85g10ks8xwqqff@vger.kernel.org
X-Gm-Message-State: AOJu0YxT4tisj4ph67pBBgLaofAmQgZqAcLfhnJ/dCfLAzWNpM2astAi
	vyH3dEt+lbadIi2u23z5ldM57BYDWk0S5tuFz4QQ7CCWeRvnST5Y
X-Gm-Gg: ASbGnctYNsTi0NtjvB44gTwIxfQwNhS43S6DZ6qXo87tNNnPHvkPHRPX3braK5zeKia
	agqCI5ioKW9T5Su/2HKlkL7sltXX5oGqGzoXbjR+PABDb8KJlNwc01r5mL/7KnMiu1eP51nsiXQ
	Jo0HTZhnLT4qpu2fBBzmraEgtiAr1yfgzKGFF7oIayxyySvv16sc1hEvqOFV+Y9hQzT0asEzH/k
	iTUmqT6ccTDn0zrB1JFHe9sR9n4LST6U846t1By3ywBMGydiyyveoBYZdoDkY99bJT+TAUwca+i
	z5paova2RFaFA51IOecSSLoAFbnUbA==
X-Google-Smtp-Source: AGHT+IHXfV6TTaPbNAIrIP+nUudqNK6Mq96yLZNja9aJs85relvKdY2lu2TnQiEeecpvKpEXSU68Vw==
X-Received: by 2002:a17:906:9f87:b0:ac7:b213:b7e5 with SMTP id a640c23a62f3a-ace5a2a92ebmr1252341666b.18.1745771010013;
        Sun, 27 Apr 2025 09:23:30 -0700 (PDT)
Received: from pc ([165.51.118.63])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6e4e7a41sm476761566b.55.2025.04.27.09.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Apr 2025 09:23:29 -0700 (PDT)
Date: Sun, 27 Apr 2025 17:23:26 +0100
From: Salah Triki <salah.triki@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: salah.triki@gmail.com
Subject: [PATCH] drivers: bluetooth: bpa10x: use usb_{get,put}_dev in
 bpa10x_{probe,disconnect}
Message-ID: <aA5Z_gOXAwrWDI7E@pc>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Use usb_{get,put}_dev() to update the ref count of udev.

Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
 drivers/bluetooth/bpa10x.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/bpa10x.c b/drivers/bluetooth/bpa10x.c
index 1fa58c059cbf..0b9931311a59 100644
--- a/drivers/bluetooth/bpa10x.c
+++ b/drivers/bluetooth/bpa10x.c
@@ -375,7 +375,7 @@ static int bpa10x_probe(struct usb_interface *intf,
 	if (!data)
 		return -ENOMEM;
 
-	data->udev = interface_to_usbdev(intf);
+	data->udev = usb_get_dev(interface_to_usbdev(intf));
 
 	init_usb_anchor(&data->tx_anchor);
 	init_usb_anchor(&data->rx_anchor);
@@ -422,6 +422,8 @@ static void bpa10x_disconnect(struct usb_interface *intf)
 
 	usb_set_intfdata(intf, NULL);
 
+	usb_put_dev(data->udev);
+
 	hci_unregister_dev(data->hdev);
 
 	hci_free_dev(data->hdev);
-- 
2.43.0

