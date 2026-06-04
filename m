Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0222F3B8407
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jun 2026 17:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780593710; cv=none; b=BelcSsNgvtI9vL7dZCbl9jGMb0Iu93HU04rz4dC9mFOu+BxLj7z3eh7WyObW4bm9aNoeZ7+X5srN1ADKpgUpydRhlPZR9BvV9MJ3Gv7LZK9ys8jFnA/MRj5Vum51CD585grfgiBXzTpNAXy0hRH6B+e6HJv0gV2DAw3t+COYkfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780593710; c=relaxed/simple;
	bh=kjJZoX6sdVagT/8/VJwiP+UTCXPmSkocRXvqD6YeSto=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=C1szucg5AKlsOuewJ0dnKddwqkB0On7zAYc+jyt4Ydu/KK6TDepG7ZkY3z1opgM9nE+v3oqguuOadD9M+xbDITI0Jd7YznVc2lbxpQ+DYxXOQaUfiXltUMn2eDi7oFoOZQBT5YmkyAhRCCXvTNFt8NU+h/IAOEwWEcZMWJGGR/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Wp8fOiMY; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Wp8fOiMY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1780593708;
	bh=6xeqbwP1Wqi/nGi6RTGCh9XUC2B8IXagAKYHaJSdveI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Wp8fOiMYVOH5X4AbrpTUPtw/+zIFTEHzoEtW7SiXiUHC+6FmgkQDmFkBbGNBSN1m1
	 kCTq5Z4XTmBpxkDhZ4Azy5E3jYkVwjuhdXmfbq0bcq7CD0Kw6EHOss35D/7CWu7BUP
	 cgyqMQ4sJwKdZ6QZiLC3RBb8uowZViZGtr89kyc0=
Received: from github.com (hubbernetes-node-97b9b4e.ac4-iad.github.net [10.52.160.15])
	by smtp.github.com (Postfix) with ESMTPA id 310C37807B6
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jun 2026 10:21:48 -0700 (PDT)
Date: Thu, 04 Jun 2026 10:21:48 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1106123/000000-ffc843@github.com>
Subject: [bluez/bluez] ffc843: adapter: Fix using case sensitive strncmp for
 patt...
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

  Branch: refs/heads/1106123
  Home:   https://github.com/bluez/bluez
  Commit: ffc84378133f5a80135d60b7fa8d6842b8ae41ff
      https://github.com/bluez/bluez/commit/ffc84378133f5a80135d60b7fa8d6842b8ae41ff
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-06-04 (Thu, 04 Jun 2026)

  Changed paths:
    M src/adapter.c

  Log Message:
  -----------
  adapter: Fix using case sensitive strncmp for pattern match addresses

When matching discovery filter pattern with addresses shall be
considered case insensitive since its binary format that can be
printed using either upper or lower case for the range a-f/A-F.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
