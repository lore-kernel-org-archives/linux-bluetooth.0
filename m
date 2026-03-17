Received: from out-3.smtp.github.com (out-3.smtp.github.com [192.30.252.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305FE3ECBFC
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Mar 2026 16:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773765740; cv=none; b=QGQoS45lJZqHd/ewmvQhQbHzBKQebmwXRI++ZKRqeAx67emfmYmZ43JKRfdBRbMW1ndkBKCsYoP9/9eumxnTTGwJ9lgGcmEWKcARGwCMTY/h0s//H9NrkRZ7aVc/oOO9jV6PVOLjNq3aVAVXuPBzQp96XXGM35P7jpK8HAsPxBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773765740; c=relaxed/simple;
	bh=KIdhijAnOTE0mrvHSiy/iEgcqHEhyZvYgcv3Wzr11Pc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=g5dAfBfPPAtozFl+DZpPiX2qKEzzJgvOvUmr9RZC8yXfRyu/Y2RLGa/NShmxZtYHQM8ZaZUeQ5uEmF09von535bQCtZ5ESaE+SfUUajuIJkvlzAbAbK7UU4m5l1TPQtzIlqhR4YTNumsHWtrTqgAKcFV8Nj1rSW9LmK01nw+yk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=mtCIVi+K; arc=none smtp.client-ip=192.30.252.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="mtCIVi+K"
Received: from github.com (hubbernetes-node-a5f58af.va3-iad.github.net [10.48.207.79])
	by smtp.github.com (Postfix) with ESMTPA id 1FC6E2C1183
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Mar 2026 09:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1773765738;
	bh=K9FNcrRrN5bQQTycW9HgqufotOQdHQvrwWxc/1w+h40=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=mtCIVi+K60FE3P9Rxb3JT9LuxYlLC33MaQgNif65c4WFN+kC9YIToKIhHhJNoL0R0
	 j1ClxzewvBC+h4d4ygYvfC8Yteo5kE7H1Nac106VgPpgXco4vyazMuFBeyMhUEszoW
	 Kp3yhl/uiLSxTt8aPkVmuAE6YF4XxUnMyxAg4lnw=
Date: Tue, 17 Mar 2026 09:42:18 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1067554/4ff586-000000@github.com>
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

  Branch: refs/heads/1067554
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
