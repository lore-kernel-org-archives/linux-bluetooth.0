Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768F327587E
	for <linux-bluetooth@vger.kernel.org>; Mon,  3 Nov 2025 10:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762167459; cv=none; b=nLzr6L7ssiUNR01MeETDbUdDc1PRGtYSiYPx8euj3CG0gt9OaJREIZcX7b+kt5SJRchlZCENhuX2jpRnWXEU0rvNodX9hZFoNGXuxcBqoJfQTTCjmFr0/r1z4XANq76w8THFETKjLTnU04b55CwVLjfV/ipND9SA+yOY12IqZZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762167459; c=relaxed/simple;
	bh=UyVyVil5XnofPaaz4mWapwQi6zPbnw6gLYifwdiWP+c=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=OQ8m4wqCFXKKlME222RhWixjPmSPD4L07zQzwQzu2i2O8DitaAx2d9Rg39qZauVbRwWd9fnm8IW+UQIhlaHwGr6PQrSMcmowWYa/cszxQyCQIjqabvv9NblQigKSVfdRcwXl/BruaP6gGJ9QTIRHx7HxwxPpfDEhQrKQYOsycDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=f0+379cu; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="f0+379cu"
Received: from github.com (hubbernetes-node-51c66c9.ash1-iad.github.net [10.56.226.86])
	by smtp.github.com (Postfix) with ESMTPA id 85AC86006F1
	for <linux-bluetooth@vger.kernel.org>; Mon,  3 Nov 2025 02:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1762167457;
	bh=Ta/MujHHoYxfwDPYVstlS3vjy2gP8gHsuKt+pe8/u28=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=f0+379cuGjhE9ncRJesWiV59X0TnnG11OqKSbe4XsYkYfmHOxyQuehilmoms3RufV
	 lTiQ/d+eP7VIWjrQpBgupEfOqk0q9zP391wvN9gVGHhQx3WhN9l2qJaiL+vMG/VDr/
	 FRWu2VSX6UBhP++9QORdunlqF6gN6SjBRSzI7UEo=
Date: Mon, 03 Nov 2025 02:57:37 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1008427/771cfb-000000@github.com>
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

  Branch: refs/heads/1008427
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
