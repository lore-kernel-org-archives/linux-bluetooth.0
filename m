Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A49280C02
	for <linux-bluetooth@vger.kernel.org>; Sat,  6 Dec 2025 14:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765031534; cv=none; b=gUngkMfS0l55Ryl8m/p78Yi5PnoV4CZwicUGu+GDYz4Xq2m5puPICaLtuM9tALFp+IV9dqzQnFFX1tyxHzeG3gauqqVSyg346ykjBK68b3Nuu4xbrR3IwqnBQWgupJIXSNQXfomZtxgu60z+nepEIq6nW0x83OjbKYRHZg/JNwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765031534; c=relaxed/simple;
	bh=Y50GgWTIKeBIJTwsKpa9PwWNicpBjGf3THVUOz6zlcE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=UiAZtciqaWot9E4G+OIqGNE3oS0Bb8ZNhu6E3oUceTr3vOagMDnM35rS1jxKpY9lIX1R8YM/JLpp3x9aVkRgPwfGoC3h225aGA5/op9j4dDE655gqIPM17eNh1F5GaVbgBffKzJVGhHqKxO98IUCZ4Bhi+Xg88USgRCiwTPJ/r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Yb7Sf2xZ; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Yb7Sf2xZ"
Received: from github.com (hubbernetes-node-0a50dee.ash1-iad.github.net [10.56.201.89])
	by smtp.github.com (Postfix) with ESMTPA id 4524B1404B6
	for <linux-bluetooth@vger.kernel.org>; Sat,  6 Dec 2025 06:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1765031532;
	bh=nDvrXAKAmrhyKcyptKtyKbQduY10T60661JY68frdNM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Yb7Sf2xZVy3Ip+7DJES9THoCss6v4QBKvSUdnY4il5sG6e6V5BBEdbEbyi5epotPG
	 8mAZoSJ8HiJ+hYZXHaavyu3wuii/0iUa1puqu7Fr7rJPlOR1cqKqAVhOvowicBRoYy
	 A9gyVsy+jx67LCg7DrA66IlUb5iuU35v7SxSEhNU=
Date: Sat, 06 Dec 2025 06:32:12 -0800
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1031084/000000-d569e5@github.com>
Subject: [bluez/bluez] d569e5: monitor: show ISO timestamps and fix their
 handling
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

  Branch: refs/heads/1031084
  Home:   https://github.com/bluez/bluez
  Commit: d569e5a50cee2b8c44af0c54bfc013f57c9b17b9
      https://github.com/bluez/bluez/commit/d569e5a50cee2b8c44af0c54bfc013f57c9b17b9
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-06 (Sat, 06 Dec 2025)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: show ISO timestamps and fix their handling

Fix ISO packet size checks, taking timestamp presence into account.

Also display timestamp value if present.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
