Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F30024A078
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 20:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784664566; cv=none; b=IMC41oFpu3MKUPoYNMY8JHnjLQy6N0syrQrgmhDfRqOtDhQCd/rXVJjQG1fu3y/NkKFszMZZZMFLeqqio2Ov+ld5wAxWM1iKzI1VaJupDRSRiKGMsFFNSGSWt5okC/hxIFnSb/yYBZpkk9ay4Z2dFk/31OoSxnpReCw3jFtKJHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784664566; c=relaxed/simple;
	bh=iqJ+P4sbZ9NJZUpB7zxVe6CrtDQp70MONGoD2TZLnk0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=XIms8CvpX6GpLH55fFhDKkxXWDHXvU67vIRMGKTJE8Lwb/f0Hid5mjrKP90lGb6DzkiemXr1gfyGlerW9fzXS5Wpk345mia+6XF+KTXvrG9wrP4d8PSaVglH7qa8tlZldMHeEc1rH11KtAf70UO9KSiCKpD4NAEt6D3saND3SXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=XEOePrnX; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="XEOePrnX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1784664564;
	bh=lZYKGKiEN30Jft22qbVZ7iCdberKx0hmPTYBYw8Q2eE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=XEOePrnXdtcZT86mOVCxpvjcY69oT3h4Nb3R0KyQE864ysMhLvDcjmgeuk4VWV84j
	 C0F2Yx2PGA5ECYXFmLiznVPLECWWwv+7allLZ/peLn4az4sbKKT19s/o0NblBFjGoa
	 0PaVU5M2EhgeJ7sYAYqaL2inrUjqdwKb5EUX4g2g=
Received: from github.com (hubbernetes-node-bf6aff8.ash1-iad.github.net [10.56.131.69])
	by smtp.github.com (Postfix) with ESMTPA id ACEAE360C89
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 13:09:24 -0700 (PDT)
Date: Tue, 21 Jul 2026 13:09:24 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1114381/7da905-000000@github.com>
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

  Branch: refs/heads/1114381
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
