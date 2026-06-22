Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18733FBA7
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 17:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782148901; cv=none; b=DAnqkcFmuyf+DHLzoD521nmEocZ9GkgzDrM5SBgbYQt0Q5QIVPY3tc3Brr7ZfMmYEhkhOdiZPaC1WJZ9+zdBqxxiP2++U6FlpnW+JbjUyt1iablq0y7OmLItaEuK6vzMkIBpxzBMXprLzefzCwXe1LbmnzfPRwNW6YenDBmlt54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782148901; c=relaxed/simple;
	bh=AhJdrovcO3eNH9jtZ3BTrYYzTGXBG2N/GhNpq6zpxhE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=lGejqgUEMg8dEr9zW/tsqS3iPqiJNrwODltg3pLbIsDC0HtTkmgQbfL+/PoY4mMyre06P8QNdKkIvDxjDaJIE6QrVgnl+YC65SdVZe0LyjYuv5unlmS6deku0OYrVpXiYtcvLPdJZ+xSpXKy5MKFyYqpNCEp53CpW5/sjGLi3DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Qug5SAz3; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Qug5SAz3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1782148900;
	bh=Cg1PKggiAb8bmRbNUTIAg2k10y7FWILZzXm4qczt0V4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Qug5SAz3rj2vO2DAn1UEufTrJVmmaAS9uPVTarEAi4zkD3irWiPLCF2jqDAK82IuC
	 ggSJ2aBenVmE/QVm5GVGRWFBn7ZFm2WRrEvmVW1QH2HYNtQHCZXT8Gmh0g1UQFB9h1
	 SFgoJYNDSILc/NsRj+U5CtX7WtCGMuXmqoxaRxnU=
Received: from github.com (hubbernetes-node-6a47957.va3-iad.github.net [10.48.209.73])
	by smtp.github.com (Postfix) with ESMTPA id 197E418120E
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 10:21:40 -0700 (PDT)
Date: Mon, 22 Jun 2026 10:21:40 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1114843/000000-4ec0b2@github.com>
Subject: [bluez/bluez] 4ec0b2: a2dp: Fix handling of codec capability storage
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

  Branch: refs/heads/1114843
  Home:   https://github.com/bluez/bluez
  Commit: 4ec0b2ace3e8fdd90f8b85978b1713411c8e1413
      https://github.com/bluez/bluez/commit/4ec0b2ace3e8fdd90f8b85978b1713411c8e1413
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-06-22 (Mon, 22 Jun 2026)

  Changed paths:
    M profiles/audio/a2dp.c

  Log Message:
  -----------
  a2dp: Fix handling of codec capability storage

Codec capability is one byte long (max 255) the storage format is
02hhx which means each byte ends up as 2 characters so the buffer
needs to be doubled in order to handle capabilities of that size.

Reported-by:  p0her (_@p0her_) in TeamH4C working with TrendAI Zero Day Initiative
Reported-by: Michael Bommarito <michael.bommarito@gmail.com>



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
