Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675B34C77A4
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 22:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781042883; cv=none; b=o1UH1nFk7dIJ7iM/bX/wTtKdalaz9xYliHAUKBk9XL15FodhiNM9TBF1DHgZ31EqfCJ50JoO9eDU4riJcMbHbWsksd1zs2UjYeYBhfZbFSrHg5K98ufz2T7MVtOtWgEUSkNrUUv17AtVKtGtR5AxRKCneVrZXBJF+RQM5Tallx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781042883; c=relaxed/simple;
	bh=RJZlqmljVrX9NaWET7koCFlKhKM8SO49s9qOzIk3Ov8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=rIxNIXAup2YSjZhjBzvDuIxtWIRWk+3USqFFNvQw78bugJ7cm0yUXt8axBkvE66aHLzq0u9ylEEUUxq2ZCYXj9Ope3H/0B4cGmHrL1Gkb3Im837Z23gr3bo/PlP2iLC4eDomd3wtL4xHLtUeqCAOt87oI+buX1mj9PeNwjraCkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=KmEtFLym; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="KmEtFLym"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1781042880;
	bh=yctXNPGihIWd7GCB5PvLgCRkaDvFIazqeWFl8mHbZ6Y=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=KmEtFLymc+jPDqLnuDCYp2njwNleE7Kw/NFWZckcZpOzrWDy8c15j/ZO/BC9zHOSw
	 1ictnnl947cLoTQQIb7eMvGeTZnWROLpBX3dIim5UM50OnGhTnVSNPczo/Aco141Vb
	 kPe32FMTIpdj8v8wpJ4PLnW7cAzgb98D21AQbWWc=
Received: from github.com (hubbernetes-node-b771e61.va3-iad.github.net [10.48.222.43])
	by smtp.github.com (Postfix) with ESMTPA id 9C8FB500873
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 15:08:00 -0700 (PDT)
Date: Tue, 09 Jun 2026 15:08:00 -0700
From: =?UTF-8?B?xaBpbW9uIE1pa3VkYQ==?= <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1108830/000000-029590@github.com>
Subject: [bluez/bluez] 029590: avrcp: Abort continuing response on fragmented
 CT ...
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

  Branch: refs/heads/1108830
  Home:   https://github.com/bluez/bluez
  Commit: 029590df103af1e37e72c3936604e23829155036
      https://github.com/bluez/bluez/commit/029590df103af1e37e72c3936604e23829155036
  Author: Simon Mikuda <simon.mikuda@streamunlimited.com>
  Date:   2026-06-09 (Tue, 09 Jun 2026)

  Changed paths:
    M profiles/audio/avrcp.c

  Log Message:
  -----------
  avrcp: Abort continuing response on fragmented CT replies

Send AbortContinuingResponse when a Get Element Attributes reply
arrives fragmented, as the CT side does not reassemble fragments.

Fixes PTS test AVRCP/CT/RCR/BV-03-C



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
