Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC11523B63D
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Jul 2025 18:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752086900; cv=none; b=klS9mxudlztd5j+O+GCGXsCdVp5YqNpkzwx73Xx/1gYjujS6Lwa7HXNR814c1pArkJaslR0B9Qbma+SPxHaWFr4xlXJDRungalnTA3OIBW1QpehoydTcWOLlB8j1Xt4Su1Mt6/rdc06YcZ0hpFub6bknFUAb4QZco5MvamBvZwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752086900; c=relaxed/simple;
	bh=FvbGbvm/vuphHhOURkBmutv7RV9cnEvBQDwQiD3tJ7Q=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=OQzIwAnRYt/qqeSL1GgaHeBRWyxetJ6xf6aUJkO+R/rQeTvNmrsgicrbUBlCPM7PAaswIX4v6haZVuxPpk+QD2Zj3OoT+OU9TYkpoEiA3HFreznaHF+NI81s9qWSUjWHdijTt5MgbFCLtIAGIU8mFZDV/ugPPXuCrxFO678GY24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=c9RbBlmm; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="c9RbBlmm"
Received: from github.com (hubbernetes-node-8fa6df4.va3-iad.github.net [10.48.164.11])
	by smtp.github.com (Postfix) with ESMTPA id EC66AE02EF
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Jul 2025 11:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1752086896;
	bh=LuwoQV6Zp+p2cnUw8RoN6eWYaJ+uiTfOqkdg4JqWY1A=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=c9RbBlmm1PXROmJH/BWQ5j8G5vqY+85D6o1IbrSx9BBOpuiIiJxJ8XeuQ0BmbmMkk
	 GOhhemyfaazz8442A2bO131Woc/1NXopr9pSkS6p6O1th0lzkaXN241JM1f/WScxwx
	 rNisbeqyTgjyWaEQ3D31djke7fbgNiMi4U1vN/jI=
Date: Wed, 09 Jul 2025 11:48:15 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/980429/877e65-000000@github.com>
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

  Branch: refs/heads/980429
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
