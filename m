Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795006087;
	b=mIt97ANMy9BQrHYTfKfGR3NTZ+AJ8UlsTY//eUAlOcmSsNk89T6XE8gnmoNyBwgWOb7Z
	 fwlALTp/QDgV/4InQIgPy4HiYhnx1Sb/aPw8YUI2icO7jrAZANFV6e4ZZXbo2htBfox1J
	 yd4ShlJExEsm+pXm8aqwnEd03SynEAi+TUEGdrlh/OtjYWG5bY5A5JNI1U1tCIID+6G9T
	 sFyq48bGInGpUK1aMkrK4x6ay7sMOcU5Jo0kaNvYQjc3FN0A7BDR6GYL6OR8azQAInMrm
	 7Di5mLTcTzS3wPqQTmuiDzyvHMXOXE9ed0BHkLZhPAbT9a7dgT+IVdkRPgv42iL17uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795006087;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=LjfmYi6jxAobL2J/ncBt2ONxTq2J0U69VJpQ5IVs6qU=;
	b=wiLqPpwC9VuabVSYZSe7KJGVedCgHKB7rPcKdze/3Sfn0TrbXJ9AM9BidRx/pUOoQZdU
	 yC+sLIgMuTl2s+sVTXY5sptrBC5aMpJs6lLyK62VCy5yFqpUEGmq1rftEOPuLgTqvVYqf
	 ZboG2W0sPIzNMm1Q4iEZeQaO8I2kof25qPhG3UHaB4oqCR9f5W7TwxpKXYTQN5qmbmewR
	 IFXufLHI5OtKoYUaP3M/15SZ2pxP8NXAMXUyA4oen6x0S3seY8Qllanezb2DRM3aJf3Ye
	 UAeYOrWnuLrp+ahBaXXLL5zYYz/LPlqiae5w3c41xfDRhKwx2QNFGWDD5lL93ADLwJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Tdk29yw3;
	arc=none smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DCA606A32C
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 12:48:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45DCA606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Tdk29yw3
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2e9ae391a05so5301585ad.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 04:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795006086; x=1795610886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LjfmYi6jxAobL2J/ncBt2ONxTq2J0U69VJpQ5IVs6qU=;
        b=Tdk29yw3/PRUl38+VNvz9P8HeVNbv/SXLOtLIZdOIz0pPeo9ny+AnQ0JTzs/oGlqxD
         EAJG0Auya2snuQ5mfsVmIL5uZXeEX3e3odvhDwwBaw01oT/obzyGhflt+2xwPtpjqxuL
         6CGDnwVPGxZ2C11PGN5I7/YS0x+41+m+fJdX8mZtoHF2uWrj1zpbo8nnVNUa0PLlJhFK
         0F789cia/Cj5tXTZF0A7Sj/d4dJzoNDY5AUtsRregNUm3qp3kupQO1s/j6u4xRf0gTgs
         9RCvCauILyPsYlN+dtT5ExsFzLu37Z3YrGnLDBeGa6smWRYWP60/hM+0mmNg+ilRvPRT
         5FBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795006086; x=1795610886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LjfmYi6jxAobL2J/ncBt2ONxTq2J0U69VJpQ5IVs6qU=;
        b=Q6PHdCenNlTVDpxG02UAmidpBXMp9NPYxWVPbYd/b62MAbv738PS3cgQQZJ1+5D/Jy
         jJcskLNk/ytEKl9SpFTO8J9heoz6acfc4ftNjNvWtaTnWwc2v/U6qpBEHtw8j14MmxOS
         AYgYKvcupvdp20YeuwHH+V9gAZs9lKMTRu5RmUfbbx5aouY9kMU3TdtoCx45n0i19eYR
         kOEBdeBFeqwVWMUMfpPRAkBuqYj2lpzKHfra9cgFkvbytaA8g8O0qoNf7AHredwbCVo1
         VnQ1S0hO/tY5e9GMV8+htfOFy/pZrFzHtwAOU1+6Tu9Lu0YbX+MHabzahYoc+jNgmR1l
         77ZA==
X-Forwarded-Encrypted: i=1; AL+hErFQ40cRPALLSMnwylj6wqagMC1ri5NqIkUErTZ2ZrWquwcEC0Lmkeqwn/ObYDTMpKYqTzA6EtPPOC2F0tg6y7s=@vger.kernel.org
X-Gm-Message-State: APuU4Z84VgY9JrDuq7BcCLipCXrqYDsKL1a1JcUFrbzQiBJdlg3IQ7sD
	a+7z5vOiZklgTEWBJTU2dX6+sZZyd3ExFaB2TwdbPui8DAmFBLmt3t//
X-Gm-Gg: AZFdTZdyk3MTafrJPBW5stF/ID1Rf2xnU9V2DU31VRTZAy/MTuYXzf9YRaSrQZgn6Tp
	62iJ8VrdM/W0zxgY7um+aseLo+8dUlSEAaNhbZxhuCLECE1ckJ+/fXyWB+RrFWf6jHHCLSPCjpP
	8F+tyB7DezoRI6SpEDIxMhp6VYql6uH4tlvoGlIi3GKZCSKqN67C12yWSFXhXmLNI73gpsw2Jc6
	D0Z6uYl+BX3zcH3enlHMKj/2vNb5iNUa1GBHPEMY9go1HtGX250AkE1V+eveDl4lPcpLklK/Y7r
	4eVHSnpRgcpVYzJQm+/lvP4s+/rhP8yGkkZS9iK0tMg/N1djnTr1OenyXb6F2hq1VBmhcVPb9/+
	FXnnCb7Y/K3HmA8gzgWh6KfFKKhdBHFa37kWFbNPAyGHVxSaUCrcYUHiX7P/DI9Wn14wjwQUXXD
	HBX5apD6+Q6Vn+IdhES1OL7Tj1JJJgj10nh0R1NCOiZf9hF6u9wZvRnKoelLy5dNyzNCs3+T9Wh
	ILmHuvSJZ//nZG2GHzvI8B3005ao/+mG/3GTwiyNGN3e20xHOGAea8b211rGp65FVCMiLc9why2
	FEjWFUYC0j5gOn16Up0nMKPgFyVBVQzMHU/eiV98n5ajSzgc15OTnX229nc=
X-Received: by 2002:a17:902:cf09:b0:2ef:db5d:59a6 with SMTP id d9443c01a7336-2eff75209famr17213905ad.23.1795006086041;
        Wed, 18 Nov 2026 04:48:06 -0800 (PST)
Received: from G7XWH7K1F3 ([2408:8256:2e80:7371:2c16:ada8:2d24:d03])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eff6214f4dsm12775795ad.43.2026.11.18.04.47.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 18 Nov 2026 04:48:05 -0800 (PST)
From: Zhao Li <enderaoelyther@gmail.com>
To: Michael McAllister <me@michaelmcallister.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	brgl@kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	quic_bgodavar@quicinc.com,
	lumag@kernel.org,
	mka@chromium.org,
	markus.probst@posteo.de,
	shuai.zhang@oss.qualcomm.com
Subject: Re: [PATCH v3 2/5] Bluetooth: hci_serdev: Track whether the serial port is open
Date: Wed, 18 Nov 2026 20:47:27 +0800
Message-ID: <20261118124727.2330-1-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <179484638195.54009.8903355214693287470.wcn3950-poweroff-v3-2@michaelmcallister.org>
References: <179484638195.54009.1916641645532262287.wcn3950-poweroff-v3-0@michaelmcallister.org> <179484638195.54009.8903355214693287470.wcn3950-poweroff-v3-2@michaelmcallister.org>
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

Hi Michael,

The hci_uart_close() hunk touches the quirk branch that clears
HCI_UART_PROTO_READY and closes the port. That branch has a separate
race: it clears the flag without hu->proto_lock and closes the port
without waiting for write_work, so a transmit that is still queued can
reach the tty while the port is being closed.
hci_uart_unregister_device() already clears the flag under
percpu_down_write() and calls cancel_work_sync() first.

Your patch does not change the ordering, so I think it is better kept
as is. I will send a separate fix for the close path. It changes one
context line of your hunk (the close call), so it will need a trivial
rebase on whichever series lands first. If you prefer, fold it into
your series and I will send it to you.

Zhao Li
