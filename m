Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B88123AE9B
	for <linux-bluetooth@vger.kernel.org>; Sun, 14 Jun 2026 12:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781438917; cv=none; b=Rb3JmoWqQ/3Nd+v/fuBCiQnxp7+vQNHSALqMP3xI0RxHGpadkzrXCVkrRi3nf6UZg83EjiKL4/CRFRaDDYVpno0LpZ7TzXRxMR35cT2Mynk3X06PdKHhAgV16KJPwkmq/BnwY+rppb5i/kkSYRngTikl3eCjr43PcwnqdzHR9Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781438917; c=relaxed/simple;
	bh=qJoyAZYqPI6YI4C6Cp3gJNsHklEwQzCdAKWgJrHMWZI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Z9MsGnKa1XHlfAa7q825kr1kYawaTwTMA7L/2afOcOM2lhw2MqR9qtXmIgCc4pxLBlh96xNAIJR7vP8Hd15pK07oLCsLZcNZerkFG0s1JiVV1oJQf/rHvpVTRHA4OgT6QLbbF3ov9KE7osLm9b/T/pYC8i86ShY7KIzr1BGFEt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=lfmSVcFF; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="lfmSVcFF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1781438915;
	bh=rrxWPC42/A3bMI4Hx7sgyxR945Gvoi2OahoylejY+E8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=lfmSVcFF7BsHj72Qds6cNE3TAZuNRonAq0NP75Ru9BrJjcGkbwl1arzGZkZ0yvqvd
	 pFpIsRTOG+IbaAWFmarXZL4lJ/Bkb8eaeGP6TvOSIK+KIlKbMyWeE+xVEPN9lgmamV
	 1qrNblIiM3Z8/x5WSjqrnLeahC7UAjLu0EQLD9og=
Received: from github.com (hubbernetes-node-730cb87.va3-iad.github.net [10.48.178.32])
	by smtp.github.com (Postfix) with ESMTPA id 499F9280C8A
	for <linux-bluetooth@vger.kernel.org>; Sun, 14 Jun 2026 05:08:35 -0700 (PDT)
Date: Sun, 14 Jun 2026 05:08:35 -0700
From: =?UTF-8?B?xaBpbW9uIE1pa3VkYQ==?= <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1111253/000000-5b79ca@github.com>
Subject: [bluez/bluez] 5b79ca: gatt-database: Prefer notifications over
 indications
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

  Branch: refs/heads/1111253
  Home:   https://github.com/bluez/bluez
  Commit: 5b79ca3d0746d5f3baaf1cabc63c7daf898db7af
      https://github.com/bluez/bluez/commit/5b79ca3d0746d5f3baaf1cabc63c7daf898db7af
  Author: Simon Mikuda <simon.mikuda@streamunlimited.com>
  Date:   2026-06-14 (Sun, 14 Jun 2026)

  Changed paths:
    M src/gatt-database.c

  Log Message:
  -----------
  gatt-database: Prefer notifications over indications

When both notifications and indications are enabled (CCC value=0x0003)
we will send notifications by default.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
