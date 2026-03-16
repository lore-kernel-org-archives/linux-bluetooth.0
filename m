Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD7F35B649
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Mar 2026 21:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773694969; cv=none; b=XqH3MOX0Vg4IWKao/apdY1UR9G8KlVHadugq5OrkJ/J5PO4MDirYyWwtfJstfFQpyujNemCSqSfrNOQjBDp61B31sjd95fNolXxs4e7x+acw0PGjLt8SQNqzDYPwcBAhOf/IbVOI3iOS1giEuvhxsi6/GI2MnOqmhF+JOEii4G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773694969; c=relaxed/simple;
	bh=Wkzjpy+WoCFtLkUWSa/7HqeFOLRtQGO+EmzKDnpC23Q=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=hqgaCMO46QP7mKtjMCyKKiQSRHPwfcIDLDJhjcl0PK1L7kfV8MSvw1EM1GB26Dndv3shMximMK+kG6b5fLybmI+WNGzk9YVeANVv3TpJUOgn6G5ZbAv3OdJ54Teg++MCkwFfm8wWSrUPMaxoDpaPvJBfMEVMVay/YFisvUPfGGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=j6NNOT1M; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="j6NNOT1M"
Received: from github.com (hubbernetes-node-4a2ce89.ash1-iad.github.net [10.56.150.48])
	by smtp.github.com (Postfix) with ESMTPA id 8C8821211B3
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Mar 2026 14:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1773694967;
	bh=JZzTWSBP7onlgoxxph7nxR6u2Kyvuj0mpWZKkTPuEIw=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=j6NNOT1M/yRAJcgZD7MSTogig7K42RpsXAXemmYFmujIXUFvRQJBktwY3Dks8VZOg
	 K4y0DkmQZfGFGfBp3wzcDt7HjmXvevhZHEajUpaZJK2TzRd33ks9i3kyc5Ms0Frg7x
	 N0FmtNQGM29s907it3gCNYDmqesjDPz0/EMqpSrM=
Date: Mon, 16 Mar 2026 14:02:47 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1067554/000000-4ff586@github.com>
Subject: [bluez/bluez] 4ff586: shared/ad: Fix not checking length on
 ad_replace_name
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
  Commit: 4ff5864082e63632638059c254a39aca2ae05f2d
      https://github.com/bluez/bluez/commit/4ff5864082e63632638059c254a39aca2ae05f2d
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-03-16 (Mon, 16 Mar 2026)

  Changed paths:
    M src/shared/ad.c

  Log Message:
  -----------
  shared/ad: Fix not checking length on ad_replace_name

iov may carry move then HCI_MAX_NAME_LENGTH in which case it is
truncated so it doesn't overflow utf8_name.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
