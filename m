Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF70A2A8C1
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 Aug 2025 14:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755872041; cv=none; b=R0OJjSorztf7FEv1Cr7tG9FYEIuRKFcE9PILV9pakM0P126kq38TdR4ynFOqO9Sj34YseTqgTyga5Z9+3uvD4Ol/X6WUoI9Kz8FXI9mY/3vxBSrj+3y39ovmTblfD62TZ6vANXfgxcbW2xm/KSsId3b+NnPtXfgy6zpN1gRLqWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755872041; c=relaxed/simple;
	bh=dTSfSKS2sFAxdn0w/Us+4+ZcP888ZT6no9D3FlKuJi0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=lPVYb0M7xmoiBnyCHgVIbFpGMsaF7EtR9dIBwc9AA56f2VubMEY+rHOWpU/AnNT7NEelDuEFwcvq5i470ODKRYg/1El/ajjw2P+FPJwr/ru+cK9k4NrKP/L/+jfQRs8JqwSjADchnMsQqDLyLAKGl8Z1dvU/pxtYjdNVVR7qgkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=iChXCPKs; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="iChXCPKs"
Received: from github.com (hubbernetes-node-7407999.ash1-iad.github.net [10.56.226.69])
	by smtp.github.com (Postfix) with ESMTPA id 28D37600405
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 Aug 2025 07:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1755872039;
	bh=AiSvjtbezzHQHIZIJMaX85bfiBM7F148odquw/41av0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=iChXCPKsPzeEPxKcEEuOnRRvLS/cWTZbs4pssfBxTWlGUlvhGb+3R4JMarGSJ7zPK
	 rDW6JWpsLDkUafLYa3aezAH3CQr04UCsj4P+9iAD4iE4LyfiO/gkXq4cH93kOHbB4U
	 GPwKl2gFqAeaTUr0InGZ+nC2OqMZyg7RGbsUVzZk=
Date: Fri, 22 Aug 2025 07:13:59 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/994029/2b5b44-000000@github.com>
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

  Branch: refs/heads/994029
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
