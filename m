Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19DA1E9919
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Mar 2026 01:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773021480; cv=none; b=FWHmJBNgXEMBFu2jH1dRHbM7FiWpF7AR5zld9VaFxiL8x1HC+83nsRkz5sPmTUS8EB9e774OTniRpvkKE5/honmeYqKc7xjj0KnDMGh1VKjV8nVYig1wvvbVYtSQWGvqpH3vkcV96RIUyVOGM63e+vQABZCRSJ7ZwWRpiESGT1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773021480; c=relaxed/simple;
	bh=02mtRVK1gxyrdbCVBqJ6nILDjTF8541Z9I2rQ32RhrY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iQousMj4BDPEW4nKq5nI3/vWg/BFmxUVgXt/BvQ9UgagzT/kSgAXCRdfeWNG72FrKNu92Pi5hUMx7mJswN/AKP9he2EGz/gcyNjhHIZSdfAbaRPrjj3mKn2970CIzpKhkJqC/7WHk7Xmm8uvv+odgKMVx8MgnMSYhN9w4aRBRUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cv3F+06M; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cv3F+06M"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-506aa685d62so61333661cf.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 08 Mar 2026 18:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773021478; x=1773626278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1Pn+8Y12A59zX2llAXekOTAY5lIpuNk+pczDLY6k+nc=;
        b=Cv3F+06McxyLqFXGaAfBiNG6Yz48z391xIG0dYtgOle1ggXx0Nz4Hv395iG9SuX00u
         oHcHaVWhNwzpYmbyoTMREtoZLQVJ4ln+Ssq6VvGByQE3hrI0jk2MUcEdi2rAbXlRsDGe
         /QBC3OrkLqAm1BVuiw97af0JLk0ku4y0syMiGOeHvrWpnfkh1vbfZu0BxLCL9vRDbgmf
         c8kGGxb6tJfE40iPKORoUWZUjvWTb6Q3A/fGcvW/o8xBDn2BncSR/UvF+mqumAJlsFWm
         6cLbo67HU9F3Hc6MgpGn7APmcuCayO2VpsDnXtx++VVOsmKTBEIEJdLYwi//deKmVgeM
         JE8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773021478; x=1773626278;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Pn+8Y12A59zX2llAXekOTAY5lIpuNk+pczDLY6k+nc=;
        b=bA1gsduqU2STbylBoxoLlAr8h8A5UvwGDupg2WJq//kmpE+rAh018zM1nypxKtWIS3
         elYzNg0Nzx4dwDgE9Mh7ebJ5zbCl0Y2sqnScplOxvv1wyOOQoE5vsMYLrnn3v+tnXKPJ
         OC+rxiBShdySEEJHzyxduQkR1sXw8gz4g2AW2JqH2GKLCwe34PX1ks8xWWIY1P+bkgym
         saIf61p2gnSL8Lcfi40qsB8ctoE2ortw4kO8ads65oUdk8lkwiOb/S4e56CuFatbMHx0
         GJzmXAzJtGQ25nSKbMTDtnoe0JyldDw04itwXPDYHL2+IZqPdhL/pgEmkBBs3D+CH2ja
         Z6/Q==
X-Gm-Message-State: AOJu0YwNpR4RMoOM7tIlL9m0GeQq1KvcbhbOYzn5YHRPikCt8bjlk7o+
	ODPjXydDmEsYept7LMkEWt9WKPdA/Tl00mW753XqLXpyEJDBK4FQwpdIkBwkk/odqWA=
X-Gm-Gg: ATEYQzxAkqIvvcCKEHXistV4SARbzcL7JpwWQLj9QXWs3VFNfYB74t49kG9QQ/Th0Cz
	v7dXYwdSJltJWCOckTeTYt5X3b0uVwMOyU0x028TBGDR25OZo+sNjiwB1eq6ol6+FvBl0h12RlW
	h1W+gPXS7spjHg01/kzSAM0H7zkDK5aSnsckyCDZCVT4FOHLUudtCXjd8+XDkHXxNJ2B63qW/ht
	RS6lP0KaYnGhR5m7aNObh6Z8lgfDPodvtB8d0FGs5/Wg/nDRRdT35HOhtJA4KqP/vZTaq5ZDkdo
	XEk/wv4YyGjgnJYkr3C3X6ohZ3iK4dSVhMNb36x9cLDQUM/ejMMxXCmegx9FqrXKjiaIOq+hxMi
	anWHwYzu8Wc6r77wl735mJp02YlJ8VA6hMQlGWBfH72ReMjl1MCi9SmJxW5LjBc5fKxC2lVgKTn
	6qEXFWAPxknUxyZ3m0tFumTCPOgaJZzLnC6eUx
X-Received: by 2002:ac8:5cc9:0:b0:509:481:537c with SMTP id d75a77b69052e-50904815c2cmr76980981cf.45.1773021478344;
        Sun, 08 Mar 2026 18:57:58 -0700 (PDT)
Received: from gabes-pc ([184.145.175.55])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-508f6695738sm58616861cf.16.2026.03.08.18.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 18:57:58 -0700 (PDT)
From: Gabriel Woloz <wolozgabriel@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Gabriel Woloz <wolozgabriel@gmail.com>
Subject: [PATCH BlueZ 0/2] Add missing string to list of commands in mgmt
Date: Sun,  8 Mar 2026 21:57:43 -0400
Message-ID: <20260309015745.1720-1-wolozgabriel@gmail.com>
X-Mailer: git-send-email 2.53.0.windows.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MGMT_OP_HCI_CMD_SYNC (0x005B) command was not included in mgmt_op[] in mgmt.h - it prematurely stops at command number 0x005A. I added the command to the list under the name "HCI Cmd Sync".

Gabriel Woloz (2):
  Added missing command "HCI Cmd Sync" to mgmt_op
  lib/bluetooth/mgmt: Added missing command "HCI Cmd Sync" to mgmt_op

 lib/bluetooth/mgmt.h | 1 +
 1 file changed, 1 insertion(+)

-- 
2.53.0.windows.1

