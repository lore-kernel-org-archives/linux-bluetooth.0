Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAB2201278
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jan 2026 16:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769187208; cv=none; b=RGF0V8AEZkFQ+m6YB7PRdzWZA5vS7v5vYaBtnAks1RpI6tycYVT5OQwMK/gMqAwGzh+4TolfmZUjTdDaAyKcexcfc2QSjs7Nbk8MBCxcerht6CZ0j/ZxwVwcrBDpdUi5KcJQR3kEB/n01ZUfmnD9EzOECP+EC4eVpL74xVxdYpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769187208; c=relaxed/simple;
	bh=8bqCPeDaXtY2rmqPmKB93Tlrjr1qKRXF69pNrV5V4zU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=kvaAtm/UvGQGuJ5C88S+qkC7PQ3Z9YxO2QB01vtpxiW55cjuKLB+vJBh8AtzygYUkgTdOsa7tbAlcRa6BH6bkmMoU7kEQnJwILiw7/GNrLigO2wINdRHBkxVINzvwI0W2Wnx4SiByJM/9yRvKwsHid6mtTdrRv4jG6H+/1meImo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=hhRIuK3B; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="hhRIuK3B"
Received: from github.com (hubbernetes-node-9806290.ash1-iad.github.net [10.56.225.55])
	by smtp.github.com (Postfix) with ESMTPA id A12256012D2
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jan 2026 08:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1769187206;
	bh=7mlwjJgr28h23cZnfzTmkkODk3gCJewR98bYyNbxxEQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=hhRIuK3BK71CATMvTaABNGokTzKeA58TVGBAypFjyPOiD6LqxLoNJk3lZE4XK2RW6
	 PEYzS0XjYLBs0ST2npGqxPcDsSeUSyjIYSX8h32PbTP4MYEYjhB47E3sQRJlQcv4iy
	 5WS5fg15L0RMIWEfTsm9R/XaMrCsjUU5f7KzqCNY=
Date: Fri, 23 Jan 2026 08:53:26 -0800
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1046379/000000-f10d3a@github.com>
Subject: [bluez/bluez] f10d3a: plugins/admin: Fix storage file location
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

  Branch: refs/heads/1046379
  Home:   https://github.com/bluez/bluez
  Commit: f10d3a3c35ea996fa038746f256df78447d86d4b
      https://github.com/bluez/bluez/commit/f10d3a3c35ea996fa038746f256df=
78447d86d4b
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-01-23 (Fri, 23 Jan 2026)

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
