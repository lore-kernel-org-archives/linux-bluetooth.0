Received: from out-30.smtp.github.com (out-30.smtp.github.com [192.30.252.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7346B485CD9
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Oct 2026 09:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791452106; cv=none; b=bE8kBGXurlmCfPWFyF5/OkVaO2wm4hBDbNAUY9MsQ2RlktoI56/IhVEeuWZWr8tlMp2/gE0H2oNo+nDcJH0PfPehC0vXe7mOKsN0gdJlz/aL0M7P7geX6F70OtocQta/fTr43UKZRdem+4Rwq5pyU6RUYb/tZ+wcssl7ljbLnhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791452106; c=relaxed/simple;
	bh=O8trReUNZe8HurDZwERPGoDxu8TZdg/JAJvFf45ebpc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ImiatCqfd2EMIR0FQg7uSvOWmZsGvyd1mHWchhj4ftVZ3pkcDdz2pMBrTQpEij6wvWAu1dzdnBRRjrkNSRybQVTnve9k0pYm/O4CGPBgX5VfjwiIkACCEIDtqIOOX5etAbnkrNcY4zqZtVc1f0zgTL1knW1rgqvVhJjWDRFWsRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=AkBDeAVR; arc=none smtp.client-ip=192.30.252.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="AkBDeAVR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1791452102;
	bh=RGWhjoWuwlb5Ecs+AjhzbEltDftaxlpbp5cHODCiJ3A=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=AkBDeAVRnilQk2CuagiLTwB0Zn9qCsy4sFrcqLkXEvRF1JavlowGP3Fvz28KeGdAy
	 c9Dbh4XGzWAhnHalbUVH8WIL3EqW+jtIPGcKiDm1PISzyXmDeqNGPGINi8vu8XPFHf
	 yb9swfXEkNQNb6YMPs7VwPaR+KOwY4DPM6HRJyYj6rrTAREFxbNTCOk3Qlb3RpREfs
	 ByVsXjvU0ML6ji7EUWjyFNkr8QjHuQOBralVxvsPzcLISU0fURrpfO7JQO+Km0aNOR
	 zVLPCb0DaNeomxl/Rma48YH5HKIIdTZcajABjVM7tw7dhJWm/jdroGKgN2hZzAwBNN
	 XR/Vrx3Cx4e0A==
Received: from github.com (hubbernetes-node-40f9bcf.ac4-iad.github.net [10.52.140.32])
	by smtp.github.com (Postfix) with ESMTPA id 94877321311
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Oct 2026 02:35:02 -0700 (PDT)
Date: Thu, 08 Oct 2026 02:35:02 -0700
From: Hui Peng <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1181248/000000-e7df84@github.com>
Subject: [bluez/bluez] e7df84: sdp: Prevent integer underflow in string
 attribute...
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/1181248
  Home:   https://github.com/bluez/bluez
  Commit: e7df844898637e6a366c380d9c2522be66eb86d1
      https://github.com/bluez/bluez/commit/e7df844898637e6a366c380d9c2522be66eb86d1
  Author: Hui Peng <benquike@gmail.com>
  Date:   2026-10-08 (Thu, 08 Oct 2026)

  Changed paths:
    M lib/bluetooth/sdp.c

  Log Message:
  -----------
  sdp: Prevent integer underflow in string attribute length calculation

In lib/bluetooth/sdp.c, attribute string length calculations subtract
sizeof(uint8_t) from d->unitSize (e.g. d->unitSize - sizeof(uint8_t)).
When d->unitSize is 0 or less than sizeof(uint8_t), this subtraction
underflows in 32-bit integer arithmetic to a negative/huge length value,
passing invalid sizes to memory allocation and length extraction
functions.

Add explicit lower-bound guards checking d->unitSize > (int)sizeof(uint8_t)
to ensure that when d->unitSize <= sizeof(uint8_t), the calculated string
length is safely set to 0.

Assisted-by: Antigravity



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
