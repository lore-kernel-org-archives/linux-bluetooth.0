Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036E8190685
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Dec 2024 18:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734631996; cv=none; b=fS1ahhnGrvIDDjZekFOyK2b10PJs6Ho2kM8bMrjrcZZ+ZwC8ReTSk+qwPmXFyKHaKLw5acXhKHjToUM0EhH/j2JNIEwj8B8BlBlyROhNsTyS7GmDEmdkJNAwqPG1uegMe8d2ketTtfUekA0lsmvf8ITsvGh/vW3Y4Ww9Ob3ACFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734631996; c=relaxed/simple;
	bh=BTeNAIGuMxpES6pUdNEtUJ9vSKdB3dGU4sLRxrx6API=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zeg3j0SRGITfDzmTjY8MHZqj2lovZB9RAGhzyccXbWIFNfM7TlOBMCBGYGHTcmPILlrJHW+4kyEZ3UvjDOV8aAROTM27yZLVVEpXNL8QO6UDiTrpo1Wbl6no1VaIqPM3R5VBle0cMHLN6gOU4izC9u5va3rKAWhaSdK7LagvtUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B7d5dAZX; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7d5dAZX"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-385f06d0c8eso658736f8f.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Dec 2024 10:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734631992; x=1735236792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=83h8UAu9PrXQm00dmms5kMwzd6y0yHh1FQEqThmnQO4=;
        b=B7d5dAZXs73zuIjFo9SMiexupnkQ0WGJzaQK8AWXlGNyK/Kd0cwNTwu0YJARREY29T
         osTwG0vydyqoZHEELtLnMtTg9euWv4KFcCbuM3VDudHTnHMkSoqB9kfUT5ZC1sdzZPaX
         6I23WyNJFFXzRC+nG6FINn+ACawlw5cWc8WKPoBXRTVfNMHhlmrJeiJwuR8YNcmLbJjK
         csq/kw/RwK/TmXhCn8TMp2RFFmlDdRG7agFZK+m4XTC/XQAHS3otNnRppuaqcEebmRbA
         rPUZuHoTmUzlg3hI76+u3y1h+AbNC9KDEYx8Q/isy/iyOaMPTXZITMaI6Yz33DbGWELX
         DtFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734631992; x=1735236792;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=83h8UAu9PrXQm00dmms5kMwzd6y0yHh1FQEqThmnQO4=;
        b=j6WN4Lw8ZqF4XfqxjskK97XXZwxmsH0Uf7/T4sFIKi6qfx76GZxXcWJFl4dzLWp5Kf
         DGcep/6VBywV5YJ173jnuI2IBrMb8bXzx8NRXTBxIot+In3BLgZlW56YaGz9mSQbYuBr
         /Yii2/GLpvD0zpOFwGGLOhsz1RreQT+gzchRZ3px1sXSbRUp2X+VCBf4ysukfO65LWIA
         MubhJJyz3UNsPY+/kvdxlmvQurSQTm28aUHhZyMsD0mX5pj2bztrXHpV0BFKlSbmzu5P
         TphLrzEoeLQdvdXqZATGBO5Eu8GT2+5FiYy2/2K5GyZBv490+LDzhAlufFzG5PAGZ133
         ES8g==
X-Gm-Message-State: AOJu0YzLN8hdpOaO0FwiUUrwxXKaNTSzvy81rVRAylxXKIKy47FY/VjT
	DNt1z6EVaQ0yigfua/wdstrQubdU2VAXhD76++nfu9IjVZSkzTka8uTHzfsn
X-Gm-Gg: ASbGncuBUzz8oKhAakRxcioHhfPJ/OWEYCO1MZMdqnxw3tJUVuNPn5Gu4vTP/j4hu4H
	e3g6u2IwCwN/1WlCXc2smLC2WeTUuYxd3zUUHVOo+ZxbbFElkK0cwdiLXgybvftRv9KRiCPIQPs
	DaHwpcpO1dkyWcKtA4xGKi8nwWEHYbg6anv8DUtFYPv+2xkjqNDdWtEvvcSfv80C9it8Tx1EP9a
	MuKhVKTEnogKAXYvp8wBd9D4z8XeM05WUMEPeoWQMSK82aS8Ns2vQOwduvOboj6n0iZARAnIf6M
	RMvFnEI/QWuejrDrlPVbTTGl
X-Google-Smtp-Source: AGHT+IEJwbrMddO4d+03CyajJtJzzQCNw9DVnntOPLEWMXZNqcIJCcI7oArD9L2EntTR+GEDfcydSw==
X-Received: by 2002:a05:6000:2ae:b0:382:450c:2607 with SMTP id ffacd0b85a97d-38a221f3392mr63794f8f.4.1734631991692;
        Thu, 19 Dec 2024 10:13:11 -0800 (PST)
Received: from localhost.localdomain (33F121a1.skybroadband.com. [51.241.33.161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c833280sm2106622f8f.40.2024.12.19.10.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 10:13:11 -0800 (PST)
From: Kieran Geary <kieran.r.geary@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Kieran Geary <kieran.r.geary@gmail.com>
Subject: [PATCH BlueZ 0/1] Fix SDP buffer overflow for DS4 (Revision 2)
Date: Thu, 19 Dec 2024 18:11:39 +0000
Message-ID: <20241219181140.423916-1-kieran.r.geary@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

I have a Dualshock 4 that has been unable to connect via BlueZ, since it reports a L2CAP buffer overflow when it recieves an SDP response on PSM19. This is known for Dualshock 4 (Revision 1) controllers , and there is already a fix in place for it in BlueZ. This patch extends that fix to also apply for the Revision 2 product code.


If there are any adjustments that need to be made, feel free to reach out.

Many thanks,
Kieran Geary

Kieran Geary (1):
  Set `SDP_LARGE_MTU` flag for DS4 Rev. 2 product code

 src/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.47.1

