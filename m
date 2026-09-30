Received: from out-41.smtp.github.com (out-41.smtp.github.com [192.30.252.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E7F3D8900
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Sep 2026 19:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790795880; cv=none; b=rk0xmZKD4vFbKFWOIlb/lBkBMXlL8shDffGYnOBP1CsQVcZ0n+dvMZdwj32j51+FsX3yfnkB3SrDOyVJBEiBPd3A0Mh1Om85UnfxgXrr7+OA87RyBIJb4hYyu8ia/3WPJAgUuDI2SaVy0d3OXxWKHpfrU1Fed3EOvtfLRFMCKl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790795880; c=relaxed/simple;
	bh=QfXyKxR6G9h+i6i5hLopceX3Te9NNZb2G3EpLHgyeec=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=fgTA0hjKhdUmSXhXok0fg5K3PI8AN6kp42J1d0USzlaawfsun7hWUe3y05dubTWEkoxRBgETLO9TjaJZIbg97c0lYVQzqVdoITP/lWr1Fi/eaACN4rV+V35W50HpTB4RED22e253S2vf4n2RIEv1OonCKA8qkkDHt06qvxh+aIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=iQjRXhOw; arc=none smtp.client-ip=192.30.252.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="iQjRXhOw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1790795878;
	bh=GXLxdGMIxM7RoKBgTVO5/hH8kibHIZtUbsjorxLiC+0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=iQjRXhOwyL5uuyLiGRQHZ1Eu6oVW4gKxSISu8bSFp7D+8T5/f5pndmWPX2fPje+HC
	 Cqhe+50y9lC3kuh2v8TIzPFCfiZ8BUWh7rfNHknQiZUNc0Km6OHguX2Syv6KRdDEza
	 cGAATxHIf16YX/dP4w3EU1eZgqkMzzlYmH4zCoFCgXODFZ3olRhbouwblahvF5sg1C
	 2d/DqhKVrQ38yOGSawkx5DU9TbDTcXvY01+IqiPuPdq/JmiRESO/Y83X5mgIom5UZ6
	 D1m1jJ5kyGejSyfohPkSIjDHQmTe+9nMWSlKdVqBUV6tdlSAlAEXhFTlPU3z4nb2Hn
	 Q0lxHQabcFUhg==
Received: from github.com (hubbernetes-node-c74f062.ash1-iad.github.net [10.56.190.37])
	by smtp.github.com (Postfix) with ESMTPA id 7F3F28409A0
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Sep 2026 12:17:58 -0700 (PDT)
Date: Wed, 30 Sep 2026 12:17:58 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1176758/645bd5-000000@github.com>
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

  Branch: refs/heads/1176758
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
