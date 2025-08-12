Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DC32F8BCF
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Aug 2025 15:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755014151; cv=none; b=NQCmz4U3X5YWx4b0HiMGnABzuKqCQA1+lnAue7tUac8qf5tsie00BS7CuaJZj8Zn+o8hhvTpB4H5nse53U9poNNZMBnPXSZZX3W4o/KPkU6lBpLRHp40zUygdNBiB4xq519rlkgdSXDroHpOjxumT8aBE6ScU87acjPgwq7mKWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755014151; c=relaxed/simple;
	bh=mJnJR/P7h4rYTulm4H5fMQjvFhXcvG169ZB/45G1xA4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WtsMPwNLxoKjT1cS31eJQEDM+Vj++DKSs9SMbf/vTANF/LxP7gRIMC++mNKTlIQq8YKP1lW3wjN5OFvfnjbLK2rnYtQA6kC1jrM9+uS6IdAvsbJVzgoJOmkrEUKYdWCgFFRq05ShuWLbHmB1++BM7+tG5MlfuXl6ydmYebQ/Lmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=TgBezgBi; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="TgBezgBi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1755014147;
	bh=mJnJR/P7h4rYTulm4H5fMQjvFhXcvG169ZB/45G1xA4=;
	h=From:To:Cc:Subject:Date:From;
	b=TgBezgBiofXFoC8C+4fPenDtyS+DqTdERR6OlW4ynuEouzrS1pLSWm2bquxhQKPUB
	 qPKlw6F51qatqU7V5uqsY7hw4Mpu+mJKI9ATiPhMxqxUTDvCox9M0chUboqlFHPSi5
	 /hb9aXeOAoYAURiPilt2pgTmeko1pMtZ7TFOstXxghIGPxgVNKocgYcp3iFgNSxS36
	 JvG+zXADJ7UZpHg5wP4D9IlUtZw+2ahEJA4hf3YonKsrwlQ00l4ienzAHKd4204DHA
	 szDkM0x/KoVSQZBe/e0ZZO7elGJmRBv/VnNWxUqIgucaLD+sXnKF3qlILaVCnQ0z7h
	 97gIARQviktZQ==
Received: from ryuzaki (unknown [81.56.51.115])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: denittis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C3A6817E053B;
	Tue, 12 Aug 2025 17:55:46 +0200 (CEST)
From: Ludovico de Nittis <ludovico.denittis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ludovico de Nittis <ludovico.denittis@collabora.com>
Subject: [PATCH v2 0/2] Bluetooth: hci_event: Fix connection state issues during suspend/resume
Date: Tue, 12 Aug 2025 17:55:25 +0200
Message-ID: <20250812155527.995119-1-ludovico.denittis@collabora.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series addresses connection state synchronization issues
between the Bluetooth controller and kernel during suspend/resume cycles.

The problem seems to be visible when using devices that very quickly try
to send multiple reconnect events without waiting enough for the host
to fully resume from suspend.

Fixes the issues reported in https://github.com/bluez/bluez/issues/1226.

v2:
- Add an explicit check for hdev->suspended
- Include the btmon log in the commit message

Ludovico de Nittis (2):
  Bluetooth: hci_event: Treat UNKNOWN_CONN_ID on disconnect as success
  Bluetooth: hci_event: Mark connection as closed during suspend
    disconnect

 net/bluetooth/hci_event.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

-- 
2.50.1

