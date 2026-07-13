Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908FE2D97B5
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2026 20:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783973573; cv=none; b=Z1L2JHPYceb5RhUnriI+0bey816eQlDxRKGWAltNBmQJQEu/OLbUL0MMjMuIviS0ux0K3DcKKOh1qppT95JcClDiJ/J5YJnzzCERlNVH4pb1oZgLDUhgIcTQDguNamJZ9j2BomSV57Smfz2Ggdh0b3Wt3gr1jyAag4H/E5q8E7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783973573; c=relaxed/simple;
	bh=dZbgT39H/vAYbKFV4IT923qPAyzxwmn/LVyKHeZIptw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Ml9m0G8Q+BOIJt9HHgFdUchB6huwnV6bcd8RPQ/92AXtoAYBlXfMxpm8RiYf+h2xwI79f1poW9bjwUx3g+9FcbDQMf5j6oQzcfND4PbetcXSekPTodymHfQJZv3bz3uRRf82NXrMR/WEsPPCxD1OaSjz01OXbYPz0/E4kJ8PkaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=HDLxXzN8; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="HDLxXzN8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1783973571;
	bh=dMKY6+rQ8ncITHesd8tzIT2CKvPx9edyEjmU2hlWU8M=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=HDLxXzN8Y7y//UianbVl9WNWK2cH7krmYnAkJePfXilu5uS/sDjh3A4YhGrAG/DoN
	 CbWF6zhg5/LQ6WtlIoTGyiDCsdUX4B/ZfMA/kqLua1p31reQ/RGiAu7ZMsA62BKWVf
	 CC/o8zNArTO7CZNw2wn+N4gT7alqb0HD7glUH3K4=
Received: from github.com (hubbernetes-node-fe8622a.ash1-iad.github.net [10.56.208.27])
	by smtp.github.com (Postfix) with ESMTPA id 725413611E0
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2026 13:12:51 -0700 (PDT)
Date: Mon, 13 Jul 2026 13:12:51 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1125775/01a66f-000000@github.com>
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

  Branch: refs/heads/1125775
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
