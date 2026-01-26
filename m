Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978B026299
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jan 2026 23:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769468434; cv=none; b=S5bxkJKg1p2inM6aKpa5MGpeHWaOHAD8jw+a+4Ypj5WFulOn+KX6vM8Xk306L9rd9NMb6VtF9jh5cYMvxMydZvhTgkh2lWwQUm8cJDvFPbfaveGy8ZsC7IUWPg2gqftbFd3E4pJMy1jbMphLcUI9olSrbD7GUtKY/1t4v9Rvfn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769468434; c=relaxed/simple;
	bh=6V50vvfA2MV0hlZKvR5foF6sA/v83XfIwNvGHOQWT6w=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=e6cowJNMmhhJwGQ98RuW2TnGwu3kREabq1jDzf7lMDexyOJSjp6TKj2A5QNgIaLf9i/SUrfgCd9OUltuUPIYrUMmmQPivBer+nKIEYIfmqWBj7mSpxdjCjK1x9nDbu10/ZgbLU0GO9yZaO7nBZZe43VwvZurwU34dbcIeCI6XSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=YYf4kXMh; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="YYf4kXMh"
Received: from github.com (hubbernetes-node-afc708a.ash1-iad.github.net [10.59.96.25])
	by smtp.github.com (Postfix) with ESMTPA id BF331140519
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jan 2026 15:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1769468432;
	bh=uZGcWmOTj4rmG5D6qoMc+YBwTo5KWpLFZU/dF8rfV2k=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=YYf4kXMhl4VBFmlQJvg8FMvBTN1fHYmNl+EiLCmEuvk7Z0LZU2OYk0HzAQE+8rAID
	 gS9pTJkPS+PCzC8vKy/jz9j199WPwyMAxiY7dd+80JrbbMfQPlyCnsfID2MDILeB3h
	 zWVMGAenCM8NTibzX+qKHkfA+VyhWF4Gsr2ASIXA=
Date: Mon, 26 Jan 2026 15:00:32 -0800
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/687c62-2d5afe@github.com>
Subject: [bluez/bluez] 2d5afe: plugins/admin: Fix storage file location
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 2d5afe34bb05fafcf3654dd7c413e586b4747268
      https://github.com/bluez/bluez/commit/2d5afe34bb05fafcf3654dd7c413e=
586b4747268
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-01-26 (Mon, 26 Jan 2026)

  Changed paths:
    M doc/settings-storage.txt
    M plugins/admin.c

  Log Message:
  -----------
  plugins/admin: Fix storage file location

The admin policy is set per adapter, as stated in
doc/settings-storage.txt and doc/org.bluez.AdminPolicySet.rst but
currently stored directly under STORAGEDIR.



To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
