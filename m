Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B9615FA81
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Jul 2026 14:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783521389; cv=none; b=DPmNonh2A6IjKovA4bBGkwROHEw5K3NWV62LoWVaHFaqWiWuaniQtu8PZ4Jvyw5aNVqx6hjioIjPYLbvbUjjeBaAml0MJmP5v4apCLAKsSanvYptdvx52a908ObnTpITLEd9qNJ+RKsfFcA0InswLrld1DH7ewImUgit6afnbgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783521389; c=relaxed/simple;
	bh=DyG96uTZuW+AF66FRjhChSNnMoLOWtUgSCzF29HWM4s=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=BM2LzWeseV4AQOdlWm6H6Vyp6qe5Qyp2PBanYwb2uFNqzb/eulYqO5EzPwJXrJ7mSWWuaTKQpv/+LkBWQ52xEcIw0s83VU8mzJIJvZnmW7xOm3Y7w2T1iczCUdHRp37p7mwSnMEV0AI89dW5SkxbZoQlFJ+0LCoeaFvAORNMTAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=hBfPVs/k; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="hBfPVs/k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1783521387;
	bh=fDGjKOdUgAHBZErl1982TF9YECW5TsQiDpySPNlN/nI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=hBfPVs/kFcenToXTtnmV3DFJJLPMhWMLHzPrzyafwtgtjS+S9++gMQlWFwgID0Cmz
	 7NV7MH0UwIi13AgkOx1aXDR49Q6gUQhqYiKyDz6AT0OESjKd9KQ5l/PuAOx+m2A+QN
	 xrGHMpzaaASOfoyodYRJEA/WN6EZGthPELw1Vub4=
Received: from github.com (hubbernetes-node-e5933d3.va3-iad.github.net [10.48.74.63])
	by smtp.github.com (Postfix) with ESMTPA id 81F081805F6
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Jul 2026 07:36:27 -0700 (PDT)
Date: Wed, 08 Jul 2026 07:36:27 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1107804/12ee17-000000@github.com>
Subject: [bluez/bluez]
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

  Branch: refs/heads/1107804
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
