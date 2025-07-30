Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFCA4207A
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Jul 2025 13:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753883720; cv=none; b=BoU/JWPPpazGRvx10eSCugk7OWgm+UzCF9JsY+vovhc321DY+ybachKc8zIEslXZ5uxspkCx63ProzE3yqOU4Af/Npz3DRW4me/RnhZ3wYp4pl7Mib4wa4SiroLiZNQoMZ8FwBBE2UTFJdm71OVZeihfiaIEhbFzzb0JH7jCg5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753883720; c=relaxed/simple;
	bh=i6QO77lZbfidzWi1a2HbbbdI2z1HD5ywDgtQEk158iQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=XfIUz7uSj/NhscdnwpVTAhi4yaHYdd8U8NoUiTDiLEHeEgrGc1xh6yC3cIHxJLtlDcYew902UzNA2KKONmUq0dqKLhQYcN5znm5EX9xM9kn/AN6c0+A0b92OyqckMXhyhvaXDXvXdwYQvLvnLxaoTfX0SvAgOVTdmCvsxexpxMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=JAPYZwgN; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="JAPYZwgN"
Received: from github.com (hubbernetes-node-eb1de73.ash1-iad.github.net [10.56.166.35])
	by smtp.github.com (Postfix) with ESMTPA id EF859141291
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Jul 2025 06:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1753883717;
	bh=SSqSrGQzvpynTaBb/yn3woxDLL0hoGk/OHj5eNi+Uo0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=JAPYZwgN20qmN9L3cDCqe+Ia8vGhG5uFjiX4ab3HBHoMqF/M5S4ZHJvY9UYoReomz
	 KEGcTaBQ0iC8aAEcvPYhmN6B3a+zyy/Kc1csB/kxObNCD4Meh2jBkL6ryEET4aFn1L
	 cs6yCioaNGLbfIOxj1HTAHEJA4MMZ850l34eSL70=
Date: Wed, 30 Jul 2025 06:55:16 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/986829/b5136d-000000@github.com>
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

  Branch: refs/heads/986829
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
