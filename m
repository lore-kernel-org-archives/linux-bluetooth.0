Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3691047B41D
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2026 13:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778075858; cv=none; b=AZfI6nmzcNO6RSNtSg5CbbGWnbqFpa1V060hdV2vyHAvidn20Djwrhfo+u+t4RB+hsplBXmU+U8WdrZbz8+ZzbbmcOk287QQJ9NGXL8OgtQFaw6Jz3L6BebK4X7yHV7rVOrXB5D3IwrBwp3R79bVgif0z1KgZECQV5qUPthHOtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778075858; c=relaxed/simple;
	bh=1dhQNn3pkespglHuuDmXr6tN2JS5kbK2R0ylpYrycnU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ecrOLjJnJdIsCgnEH/YQcg//rGfJCmSgyd0GfRHi8wCOPDuqjPAx57k5OzyhOveXkekFhNhszipCAqFQMspfHBcYhMyftZj7FtgYnbAyDF2P+UxuteiOgKF8NGp4XMPlJYwPOV45tKsADz/j2zIKyM8bCf7R6/FSB/oWjd6QC04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=fQiUQYfx; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="fQiUQYfx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1778075856;
	bh=EiXxehvO8QG8l/rPEEbvGEn1kFPVxaloi8PeZUVzqK0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=fQiUQYfxOQ/eu7yI+P+foK4WmWVj1Usp1GN8Eb/JlW4i2tZ8jYEQza5dmaIkvwXSp
	 qEXAP6zcxGFrdmcd9ksS5P9Up5CFmagSoryorFhOaIpd3nvQ6cRHFxb5V4Mf2/hwrb
	 XIKS0JTPRvfVg5Qrxni1Z0YhA0bcynbmcwvR8iwA=
Received: from github.com (hubbernetes-node-d165bbc.ash1-iad.github.net [10.56.224.90])
	by smtp.github.com (Postfix) with ESMTPA id 5615E3610FA
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2026 06:57:36 -0700 (PDT)
Date: Wed, 06 May 2026 06:57:36 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1090113/fae0c7-000000@github.com>
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

  Branch: refs/heads/1090113
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
