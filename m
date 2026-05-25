Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5298E346ACE
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 May 2026 06:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779689012; cv=none; b=EyG7aBxF7rdLUF0XjZbtoI041ysL8FCk0SHzZxMgpbu0RswpMDUkgOmcnMn6US0c3mHesKjR2XOi6Saken/0lohOLQ0WbiL0LGUVL56V6bPQWpd+VurbVqAzJq1jju4964McOXoVGOjFmkRgOIgbLsqt8PWNd7JgpxeqkaKqfIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779689012; c=relaxed/simple;
	bh=udPVDriUJMumvQiEnYsJxHwLQg4LnuEg93HdN/N1MKA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=luyIOuJqpzrluZwXfc5LayuYz5oggyZo9oINj1coEWugHQDYUCp+hpDgrCphf0WknwE1LBhzUHRJXvYweZGlNbFaMLOFifLreWPir8YEpU+Fjgi/nHGhku+lwUsACCPBh9Ap0BOovP7ZRgAPEj5vCLTZjxJQQa+8P2iWhB6b9Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=LERTLAQO; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="LERTLAQO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1779689010;
	bh=m368f/SEnyev9BcgNHcTSmzUUqiH+AOBIpLGFVSdu+w=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=LERTLAQOyDwa9E/z2HHJXjAU3gGtdY0hPjvZm+cMmSa2hv/lS/H0GNzJ0gTNE9mMU
	 15/IiBtomTFiY3zio7ogKJYAdqi2cqHtqvejk3BDNJ3Jyfsbxe+AhVd5x56ArnDlkH
	 Jb3g0iu9P1jY5IdTf3hWOAs5snyTFiFAMC3Y3oK8=
Received: from github.com (hubbernetes-node-3d30342.ac4-iad.github.net [10.52.14.61])
	by smtp.github.com (Postfix) with ESMTPA id 8299820D63
	for <linux-bluetooth@vger.kernel.org>; Sun, 24 May 2026 23:03:30 -0700 (PDT)
Date: Sun, 24 May 2026 23:03:30 -0700
From: mdzik-sue <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1100171/000000-c2977f@github.com>
Subject: [bluez/bluez] c2977f: advertising: add property with advertisement ID
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

  Branch: refs/heads/1100171
  Home:   https://github.com/bluez/bluez
  Commit: c2977f7afda39ee27e97f62132352f73b9ad6a4d
      https://github.com/bluez/bluez/commit/c2977f7afda39ee27e97f62132352f73b9ad6a4d
  Author: Michal Dzik <michal.dzik@streamunlimited.com>
  Date:   2026-05-25 (Mon, 25 May 2026)

  Changed paths:
    M doc/org.bluez.LEAdvertisement.rst
    M src/advertising.c

  Log Message:
  -----------
  advertising: add property with advertisement ID

Identifier is an internal value, but it must be exposed to client app
if client app wants to use a advertisement in BAP broadcast



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
