Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795244581;
	b=U24NflwFU2/aADLuBueSa++W7k3ZmhFes9zYit3IFNDQ25c7dc+NLGyLBBHjKt1c58YY
	 F9fhYv8lPwFdimZHWcRWCwxanC+C6uRmVvFsAIsq8phTWxteh6D2cehUNintgsehVw324
	 9d7wQWHLpB/g2jADGZ5T3pptQUM+6BexXj1fJKnm0rh535zrJaC52v3PpEBV6mPRaR09c
	 iV6iXjMBXAQrGgzGakZ2JhIKqhQoKPiiw6JEWoQgrQ4IvkmuvAPzbt1P0reJBsEWzcLSY
	 AkzHJRFk0mTCrFxgxCi9qwJxFVMhv23dZY4lvRPFUhg7/a05uvZCzCst6wVIn2Wcjtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795244581;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=EWDbsrVkRWC4HFqWsX65D8yUGLkpn215xh1jwQhzrJA=;
	b=khd8nazQfucoaxbDN4t2A3WVTKSkjj5TYSGaUPoasbXFJMQJgv80rv/D5ITrPNXbQ8Mk
	 Zh05KEW77eTJgs0cg0Ayyh9tHZFC2E42UzsLIzghplva8tzufQ0DsBeSLW8IDCR0kMpms
	 l2q9hMD0ibvmNNq8jKzRVHRQDwZPCG+8AUHIAmQ/6caRezk9p+JoFlyxOMQ0o45lyHb5K
	 JFJ9TTTIb1yen2CJnglrnQM8IvBRwZ/rn+tnNmHBwiHxfZKqVDTzmg/lo7eHsYLr+SM1Z
	 nJ54UYXlDxwkmdIik0eE2QrILvzIX115ENuijBlhAoBMqbyd81k5O9hDmVBXEGPlzEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OJ2kO9j3;
	arc=none smtp.remote-ip=209.85.210.173
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8B4606A32A
	for <linux-bluetooth@vger.kernel.org>; Sat, 21 Nov 2026 07:03:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C8B4606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OJ2kO9j3
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-89d6bd67045so777308b3a.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 23:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795244581; x=1795849381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EWDbsrVkRWC4HFqWsX65D8yUGLkpn215xh1jwQhzrJA=;
        b=OJ2kO9j3DdVXXJD3XHJUtyoaumraB7SlkqMIahn9wBpYGK7LgMvEUFsfGdE30J4PuT
         sKF+mpcmgJtVbtQpTbFyqeKz0a/FXVdXhoaVwPveZAzuQ4UzRzS5x6zik6hGFhPcIi1e
         O09coAoFvWxsY2XeFTCgA7xOr0CBx54KSXKD0CFX1Ukf0mX7o1oLThdh5thXHyoP/LAg
         uTb+gz74dB58SInLG1o3ZCzzi3rDQq3+AJWBLxCFTSHoJWEFFhEesaL3ioFltUJ40POR
         8GaUpL/etXOfSXjDT+4C2MeX88/vEwmIeaYjkYfzj78RLvY6U9RD/9G2QHtrr62b94oy
         gSmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795244581; x=1795849381;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EWDbsrVkRWC4HFqWsX65D8yUGLkpn215xh1jwQhzrJA=;
        b=fxToxoTfl6sB7m1TQdhw4Rr9saXSCexUOdgMZ7H2WMcjBfgato+79kWhVYK0sn2/pO
         mrYf8lUCW+N7M+96BRT6UwAmamtz59P6lLkQTt6aLi6ye4EiXQ+fRDWYdHuv3m38VGi0
         VyLo7nznHnPpVUtvepE9fG9dbMM89xm4Aof3iSSlnzUGqW0fdpgSxsFdR9QCUYPg2u1e
         GblnoJ7+eIV53y76UoxqLEpwUfMo2XO5JLNMzHI6rMF7kf1rR3lskVOslBmscMDrChaT
         1No5MjM9Tv/zk/0/5nCngpVjQKjjiH8aZTxNcKyhGlX7WonCewCZlxsEbcOn3CaU1L9D
         En6A==
X-Gm-Message-State: APuU4Z/DWzdP2y+/yGhjhuS9kayfdfE1MyNSIFydaRKdPQDAWVsc8Df+
	5ikr1ZMd3NTYMjuOWtPoeAtcqz4Km0GRv/zSvT1Sfdze58fJrry6xxr9
X-Gm-Gg: AZFdTZflLBxcJTH0ciLy/Idc5ozXd/q+6lRByH4mhSyN4OzyoH+wQZ7jMqH2Jtpn+kE
	m10UgSuBG5oIvhbIc/l/nu79J4mvXh5hpOHHblcnqBwJoeHmj5AK3hTRmKfHdgV9iFHLpY5S+nQ
	255oJBRshsbBbhwpJFXSw7L7Y7k8Jd4+1H8tqHYZjGkbA1J8gDid8BgTFohhTEKf1hKYX+zSo9O
	RqiKwJMTek+mzRZYlf3rOIWjFEb9GvvtZ+Fc70dOlKNzU53Wx+oIUXrkU+ERybXO80xy12zJMGC
	ehik0o+sC4eH028hdWHSAuMdVptCEnUMrGXlUtFEM9cbpZ0mt7UQAanjF/hVb+cqNuftefw01p0
	cANc+xS16/zc4/0Q7NGLBxfDP+SAs/YX3OaLNe91ieL0G789g0le54t4+X8YyMLCH2A4K72jMUR
	CpC2g1BzeaPMaBzypHHf6Mb4PpHy7HdMLnFS26BFL/EW3vbeuP4Ew09BYcXhbrfltFHtVbhA/ks
	Kguxy4KGLESfUF5T+tewNEIC5489bzFhZ/BOukuG3iBsIybfgflrsy7W5fLWriEeVoBqMoz8l0T
	9q4yeYIV+caI+eJ82GRryuC8
X-Received: by 2002:a05:6a00:84d:b0:883:4a94:8132 with SMTP id d2e1a72fcca58-8c7dd9d6a17mr4587991b3a.20.1795244580532;
        Fri, 20 Nov 2026 23:03:00 -0800 (PST)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87285c89dsm2477793b3a.13.2026.11.20.23.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 23:03:00 -0800 (PST)
From: Cen Zhang <zzzccc427@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH 0/2] Bluetooth: RFCOMM: Protect sockets during teardown and TTY handoff
Date: Sat, 21 Nov 2026 15:02:50 +0800
Message-Id: <pm-bluetooth-objects-candidate-0218-v8-da37c8a6b33c9d2d8efc-0@gmail.com>
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

Socket notification and TTY handoff can outlive the object which made
the socket's borrowed pointers valid. Keep the listener alive across
child unlink and notification, and finish old socket users before the
TTY replaces its DLC callbacks.

Cen Zhang (2):
  Bluetooth: RFCOMM: Hold the listener across child unlink
  Bluetooth: RFCOMM: Close the socket before transferring its DLC

 net/bluetooth/rfcomm/sock.c | 17 ++++++++++++-----
 net/bluetooth/rfcomm/tty.c  | 20 ++++++++------------
 2 files changed, 20 insertions(+), 17 deletions(-)

---
