Received: from mail-dl2-f12.google.com (mail-dl2-f12.google.com [74.125.229.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80343769ED
	for <linux-bluetooth@vger.kernel.org>; Sat, 26 Sep 2026 17:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790442252; cv=none; b=dPv8/ClnqvB50fKtdsOHzRLj8iRmoWFO6/rtkDznXakKTaVYWHG3wJbdzQZd0+dBBxCo8YuvmxvB7/UzV/LK9jDMl70bit1Vi3M8C1O+F2ZZWtX9LleiIRHyr9uYod0JYTAcuky2zRbevzshIum5k6LN922CsdJ8Lr2NoBC1Mxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790442252; c=relaxed/simple;
	bh=inMJoch2yghjdV4xO7nIz2vYijRVDjnXOVGSDrF05pE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mHpVS3C2/UuHK6NZING5gjL++7TLD1X+43Jf6552PiS+cIEj0LzRNl8JPt/OI7/gG6nTiSPI5U9eEUX/vo6DCxII2S3GeDQWccGtiW8emYtw8V0Nfwpr1goikdNls1/8ihfDHpcJZDF47IEmr3ZbNY53mEDwmu9cgWTtkDIQZtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sCCHN8jN; arc=none smtp.client-ip=74.125.229.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sCCHN8jN"
Received: by mail-dl2-f12.google.com with SMTP id a92af1059eb24-141a5d476aaso46033c88.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 26 Sep 2026 10:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790442250; x=1791047050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WRViZuXEz1jF5ev0OclSbo0VNbuCsP09mnY0HfqPJoY=;
        b=sCCHN8jNE1jb0ko7cOQeRkgEEBA1ROn9aaMuaGoaMO2K5NCCd5vDwRPdA8zasvsHFj
         4fLpo7GZEXTOhreEjMKeuNlXtkMp0bVavi0oD1SQcfQ0s1VzNZL4WOh1MA/yqdNaOERN
         v7CwC++xIuf+xRykj5OaRwW8uHSe+BgzMc9+yO2BrIPNOMGRgoFiRn/eGBBtrQDDNdz/
         mLaR7VsZDXmcOWBgY07RHBTWKv0/U/EH9nGm/JN1xhRetRCfo4yW9ypNr2+nFvafVbVe
         RuFnNZvWBkYpJlDulKc2G+LU7fcO4V+iqM5L4zdUkfPzyitR1U6lw4yr56yUGKdLPMO7
         zxSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790442250; x=1791047050;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WRViZuXEz1jF5ev0OclSbo0VNbuCsP09mnY0HfqPJoY=;
        b=JhcBez5aEMYnM8YhR2BZh5fQ30IkEReCMy8Ti9BBNc2P5UXMaKWWFy83c6lUlw5lVg
         vja3vofDFYD9u1PIr613aWHZ3TuBTy5kqMc4udJRA2Jxk8SgQW+pEB7LLS6k/W5aL4xu
         L+4tiJrrczlXVyy+mLAFe7zSECQhOVf4PF+pQsq2dMx1GyugNC4OaFn5oJtLYxPYZNl8
         G2iNcexIFRG5pDF/mjKKgunELGZNcubDkK3UkhVQ5q1EFWiovW10dufAZv3iHgVrNfkY
         BfcecF80lbaMTmvBGWB4RJ8MDrW7PVMOjjd29oZw9TAWm7Lnn0234Rp5vjI7sm+1elF+
         Z0/w==
X-Gm-Message-State: AFuF++mI9a3t6vRBf1YKFnxRQDEGL9rLH8FdgjL6KQvuIo3E4fdPrFi8
	0eb4opIdDEYjqfeuNldAE9C++asASUsorEzvFPiaqAt9oNQkPT2CBV+t
X-Gm-Gg: AYBFou0Q5mcmm2V3QoARh62ACcQ9ddwXlFc2DN3k4Y4vdpRAychDHf5MevMH6oH3R+d
	5CWlnCTXAu8ohN/XkCOBS65kjX9C4tWkbvYWjukZiEWtjx+9W+oqobREP7FPGWAAwRk9tYpvybk
	tY9zqn7Z9udwxLD9V/U2ILSbtWmhBfq/D2TvkeZWojmDgVmewMV16gw0o/n7gruHV+u9XYQtn4F
	MxYehsY5KzUudtDQYdgngiVYLMHsihJZWzps3LqPBWNTjBS8l3MQysoMjr2ToMvTZtHV+Oypmr2
	j0qjXHKf4mOquIKNBRQ03FOgZNwXOJbz1Sf6ykkM6b1SeiQCpsSMPKjxkDLoT9hR8fZkb1gkIo8
	pSfBTd/6OImJRPCCH6LUIn/WcC1KmIQKb8enU1uCRZ8t72UVZPM7ZBHzfYKMpczNAjUcaugYEpc
	P2dIyO9f7L+v9nZoDbeSRweceG0sUux3MgzL+UvVMiC8VEW0RiuEv2Q4WhFXUmKpxHDLlAP1KkQ
	w0T/cK5CCYaupL3b2CXaQv+AVpVd42e4h7cTwnWzKhj01osQTxXTh9tDhS6gjZX3+49uw==
X-Received: by 2002:a05:701a:c919:b0:143:3240:89ac with SMTP id a92af1059eb24-146cfdcef79mr6053761c88.2.1790442249577;
        Sat, 26 Sep 2026 10:04:09 -0700 (PDT)
Received: from localhost.localdomain (95.169.12.199.16clouds.com. [95.169.12.199])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-145a7318afcsm13343905c88.0.2026.09.26.10.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 10:04:09 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Gustavo Padovan <padovan@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>
Subject: [PATCH net 0/2] Bluetooth: Serialize TX scheduling with teardown
Date: Sun, 27 Sep 2026 01:04:01 +0800
Message-ID: <cover.1790407061.git.nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TX scheduler drops its RCU read lock before using the selected channel
or connection. Teardown on the separate request workqueue can then free
that object while transmission is still using it.

This series fixes two distinct lifetime bugs using the existing device
mutex:

  1. Protect channel selection, transmission and priority recalculation
     in the ACL and LE schedulers against channel deletion.
  2. Protect connection selection and transmission in the SCO and ISO
     schedulers against connection teardown.

Please apply the patches in order. Patch 2 depends on the ACL/LE locking
introduced by patch 1: it uses a lock-held SCO helper for their nested SCO
calls, while direct SCO calls from the TX worker use a locking wrapper.
This preserves packet scheduling order without recursively taking the
device mutex. Timeout checks remain outside the critical sections.

The transmit path can sleep, so extending ordinary RCU across transmission
is not a suitable substitute for the mutex.

Validation: rebuilt hci_core.o after each patch and completed a full kernel
build with CONFIG_BT, CONFIG_BT_BREDR and CONFIG_BT_LE enabled. Both patches
pass strict checkpatch and apply in order to the stated base. Runtime PoC
replay and runtime lockdep testing have not been performed for this series.

Chengfeng Ye (2):
  Bluetooth: hci_core: Serialize ACL scheduling with channel deletion
  Bluetooth: hci_core: Serialize SCO and ISO scheduling with teardown

 net/bluetooth/hci_core.c | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)


base-commit: 165768bb70265b5c38cf0b73fafd75be235f8b14
-- 
2.43.0
