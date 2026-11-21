Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795245077;
	b=nkd3s42EFSnOgTAP7qlSz8byorZ+xDwFS6LaB/Z8epx6J4YyQFEgVTjryYEJi3bkVxfQ
	 Dsne2834oWNEv67BTFFbQCExT0IF6L+q7eFFB5bgZDKYbPpLOGyeSx0g5Caeetxp/BjCX
	 k8dRjKA0F5PyPSNoL6fGBfVw1buY3x3H1z3xuyXw6+LjOf/XQslJ/0872L2D0x4lEeib1
	 gS70V7J4+ivso8Vjkqrq09OhzH6vFRIHadAjvSYbh13pTV/ZQxhFRzRTfU3jqFZB8vUl8
	 KTUcAnFavmdT2kqbGitoshQAm0wB7uUkw+GfHlPYQPUfUBUG/8WJe+C1bAIc0g/WolQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795245077;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=AmSy7sh2RQvyLBJSkgLlzK1tz/VS/54y0ytSBL1layY=;
	b=OLgP6AIuYocf3tYfxQMh+02zjjWqGZ1vPcPev/9DNzdWoqrteBTUf+do/WuD1x8wytwE
	 hanmKfI/Jcft0OCxYCw/pzsfWrwEI2q1ozlg1b3ALE0+qsB3esokWsLdLDaHjASVL7SzH
	 PJFUgc86zd1Er5Asvz6yz02lMV5KzBk8Pyh49RG7+I4CZ88TxsaA/bg6R1TW2wND+8SDg
	 3wApTYpbT4xf3HVqOw5gdaO065qtq0aLOhXDL/Q1UF90mzbGfdHdHpwt47wMPYPVtCsWR
	 DyUSGMVqe4YWpBeF6mRlafBVzXsbARRV/GwXupCsgyNhnRFDQ0rShQhnopfEQtKHxig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="b+/szk3T";
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B203D606A320
	for <linux-bluetooth@vger.kernel.org>; Sat, 21 Nov 2026 07:11:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B203D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b+/szk3T
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3adac5c10e3so971171a91.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 23:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795245076; x=1795849876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AmSy7sh2RQvyLBJSkgLlzK1tz/VS/54y0ytSBL1layY=;
        b=b+/szk3T1w6AekUraZZuKPwggB0AMdY/uVa3uEJqPz4fPQVwmhFUCc+AY7+MCymwlB
         2GahBw7aXUQLkTniNV6is3ed9WLVKAH2N/Q4AYkTJUmTv+06zfggjzQGmMTyWgEJooVC
         2dye+pKsT/FNzHpM2JqN0x70Y3tjS3aPrJm8WaPOnD/S1OfUsEj1BhkULIdHYlRCCAds
         LJdeDQqkQ8ouxBiIe1TU/0Vytdims1W2TKOdMJiGWoiGzFm+DHsy+tbWeILPpC9HyxCg
         N9+0bigGbpkok8M0fx36ZsyjgwAnrGoaXYWoF6X2hd9YXntxXMjVN0qvAjglqyOXkU6w
         EBDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795245076; x=1795849876;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AmSy7sh2RQvyLBJSkgLlzK1tz/VS/54y0ytSBL1layY=;
        b=GaVM5jDh/MEANYaDZWJ5woD1is+yVLV1TcqHFYChOU/ZPfZUkezSUeZaV+39CVokq2
         gR77vdHCYpak1zuFpkydtpLpqFUexvU3S3i0bdvarsJOalv3UPIEIHF6imkQFO0g6BpO
         zBdzIZFB0+wsOTGGvpZqSswiVZUNgFcUaJkEqpKwg7WxLYogYpKyUHQaigTsZC57dY1j
         z2Lv+vHZZy+sbQsQHCVIUq0uy5OiCn/gvzEFJpA9DeSdn3Zlakph70Ov0hwRlY+L2yJz
         X8JNOOQtV8oUxYDCPbOU/BnUde1HF33LYNjCFPRH5p01h1+y8/exlPcnt+EMUW65EM7Q
         4C4g==
X-Gm-Message-State: APuU4Z9EuZ10u5F4aD/tGumHquuYQ3BGl9hqybd5LqlePO2bsEBoSxsQ
	19Uxr03ca+12WYDa+cndQsZbF6GhtD3phrl3cFpYikJ+pZgIIzimaYUlXePghg==
X-Gm-Gg: AZFdTZePOnvNnbGjdlN8VAMSa+bITniFNXZsOQBZaXL1EnI3mS/4lKJ8DK4M8tD0zWC
	PLfLP6WWOUmooYJVim27CPFo0uDrHKM2UiEqRVg7s2Cn5mWDK9yIQeLYgkRWFEHQwChMT3JeGFK
	2QpZ+bIyrzFaETE+NR6ONjwmUbtWBmj1Kf0pfmJGHQSe0f3t2YmCnsaojrZuIPjAxjkwUHidRGu
	d+7OrR2HudBZ4Rk6CXAcXC+R7O2vCsBaVtkeMB/wKEbcGW51U0bAV4S39khxmJBSJ3Nlf47ENAo
	NRzKaKKzYxmJtM90AKiIFqqpevaFuMOQ7Lwfc9LTOYs2zFGfnonInzc+fwz6FQba9+HwipvXqEc
	jsxr49Vd+JzKNPR7pQA9yoxmF2FslIlO7q/mHe1xtl7D1MyUcLS6YjeVYFjN5JcWbywqiU2n8P/
	JOGc7htMVUTxsoQdIWmq5KyYjtDurRQLbqKyXPlUmEOrvvrMnoP5uliGknqoOADE1KrLS7wOaMF
	ZkpAVkzBCsNb6zsll4WUhC8oRSii9TdTfXjhNsLErgG5LX5GvKCs2cPijZrhaeet6hUmWSqX1aF
	UivCmTRukGuSRToworcXOqMn
X-Received: by 2002:a17:90b:4ec4:b0:3b4:1926:9e96 with SMTP id 98e67ed59e1d1-3b41c8ff5b6mr4583519a91.35.1795245076015;
        Fri, 20 Nov 2026 23:11:16 -0800 (PST)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405d11753sm10614548a91.5.2026.11.20.23.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 23:11:15 -0800 (PST)
From: Cen Zhang <zzzccc427@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH 0/2] Bluetooth: 6lowpan: Protect adapter use and notification lifetime
Date: Sat, 21 Nov 2026 15:11:08 +0800
Message-Id: <pm-bluetooth-objects-candidate-0228-v10-f6ced931e2322aa5c7b3-0@gmail.com>
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

An adapter remains discoverable while asynchronous netdevice deletion
is pending. Protect lookup and ready-callback use with RTNL, and close
the delayed-notification producer before deleting its embedded storage.

Cen Zhang (2):
  Bluetooth: 6lowpan: Hold RTNL across adapter lookup and use
  Bluetooth: 6lowpan: Disable notify_peers before netdev deletion

 net/bluetooth/6lowpan.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

---
