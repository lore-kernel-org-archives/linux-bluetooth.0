Received: from out-5.smtp.github.com (out-5.smtp.github.com [192.30.252.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF1B39936B
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 May 2026 09:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778577739; cv=none; b=JCvFlUwAzhyEdu00I/TAoFH3oW9fy8hG9+UorntO/CpwVjojrHRh2Yt2rZq7Igl7QhH/c2JQfWwWnfK/8jhuWzIjzdtdAj/De6Up8aipAJT5x/q+/vlE2nvmaCxExXb/dIeCpJeqMEfStHIbscdcF63LzIYSnxfP3W10qdus/NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778577739; c=relaxed/simple;
	bh=1brf2TuUZBWPzN4MoOAZdxr2ZoFrpW0A5/yTcbV5HSc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=lJMjDn9emFrQi8RjrWLkn9g1p7ySdIUVDZbEoz+/NobOEyr2frOxuJ8WHlkhavI1IQjrY0p4Dgs10G2BgDjW+s+fYdZqfYrraqF8++ejfMhVT4ie6poDCBlQ5PkyX1K2bYkZ6WccFOa7nweGCHMmtKhG7byFMK8YB6HlJMxoJkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=CIwVXwAs; arc=none smtp.client-ip=192.30.252.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="CIwVXwAs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1778577735;
	bh=YJC5zszYO9tXdLcAlO6zvA5b3lByYo2IyLC0R78hV4c=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=CIwVXwAs83mDw73DVvqg6ksapeeQ/ae4ccyp8MpX1U5YIn9bLnofVscBtHtryR+SG
	 mRrklPbKMpm2DethWvkU7OxLYiKNjM35kCDvE0ETS/QU0zp+7PFyaY6lKAfyro0JTy
	 roeDnQ3yfmsEShu3KdOvpwvxy5ppy3d4H6by3qMc=
Received: from github.com (hubbernetes-node-5e42fbf.va3-iad.github.net [10.48.14.44])
	by smtp.github.com (Postfix) with ESMTPA id 6274578122C
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 May 2026 02:22:15 -0700 (PDT)
Date: Tue, 12 May 2026 02:22:15 -0700
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1093372/000000-88b4a6@github.com>
Subject: [bluez/bluez] 88b4a6: pbap: Fix not checking Database Identifier
 length
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

  Branch: refs/heads/1093372
  Home:   https://github.com/bluez/bluez
  Commit: 88b4a67b600e6fe2427c69629af229d292ae6076
      https://github.com/bluez/bluez/commit/88b4a67b600e6fe2427c69629af22=
9d292ae6076
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-05-12 (Tue, 12 May 2026)

  Changed paths:
    M obexd/client/pbap.c

  Log Message:
  -----------
  pbap: Fix not checking Database Identifier length

Database Identifier is supposed to be 16 bytes values.

A paired Bluetooth device acting as a PBAP server can overflow the
heap in obexd by up to 239 bytes into adjacent allocations by returning
a DATABASEID_TAG application parameter with an oversized length.
With both length and content fully attacker-controlled, this enables
standard glibc heap exploitation primitives (tcache/fastbin poisoning)
leading to remote code execution in the obexd process.



To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
