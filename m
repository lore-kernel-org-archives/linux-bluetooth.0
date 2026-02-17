Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97E71F0991
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Feb 2026 19:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771356866; cv=none; b=kNP89Qy0xT3B0NE87NXE1w1tPuKoONI4VfX3FJ8wdIqAiHQPYetMZR4M+ntJ+EOIx2ra4Ru0IMS6qjEGy6kds8n+SZlApmN82ZrOnJfrNULXdKFEBbGRWlKbf53MTSgm6pgXuUhEm18WCIOIOUkf1idoMwUJpdRCqYgJrFjtqP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771356866; c=relaxed/simple;
	bh=hsCnwFBmrb7ljgQu5DeejaXYGFyUFqRO9wP4coA7AZw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=dBDH3f7B+zDlFnyo+klVNTKroDG3bTkR5tSJ8KVB3md1CswjQCmvVe51TqDw/XzUCBZ3E5xvXvmOSSnoHCf99Kdi8mn3Vu/QTY0m1vwvkajbXQe/4n0b8MtEjMZAdXxbzugcxjEZ8UWjy8XUdZjMTOOLMJXbEKpyEWn2YvHYnvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=OlEJT0hv; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="OlEJT0hv"
Received: from github.com (hubbernetes-node-97ba547.ash1-iad.github.net [10.59.97.40])
	by smtp.github.com (Postfix) with ESMTPA id 02E1C600B98
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Feb 2026 11:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1771356865;
	bh=PxgRigoM8Tpa+mOt5y+QnNZerBSTt8yGvMmUS5L22fI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=OlEJT0hvcVRA2PlJvLJOBR5C8ULdDz/eXfqJzruaK0vq0MYpxmJ53UoGikR3a8Zvr
	 TR/GzT+7FBl/HEw4SpqQPUjSxkWrSh7RhE1cvJcUtjsWNfZk9+siNixs0GcJETMpfJ
	 hp9GVOosNRHw/dEcZPgp8AC9c1eh+ZZxwO8e5ptI=
Date: Tue, 17 Feb 2026 11:34:25 -0800
From: Rudi Heitbaum <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/feb4ee-450e99@github.com>
Subject: [bluez/bluez] 998452: client/btpclient: Fix build warning
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
  Commit: 99845224fd4aeadd5f2a860f1af804c5f127256e
      https://github.com/bluez/bluez/commit/99845224fd4aeadd5f2a860f1af80=
4c5f127256e
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-02-17 (Tue, 17 Feb 2026)

  Changed paths:
    M client/btpclient/gap.c

  Log Message:
  -----------
  client/btpclient: Fix build warning

client/btpclient/gap.c:2359:3: warning: Value stored to 'reply' is never
read [deadcode.DeadStores]
 2359 |     reply =3D l_dbus_message_new_error(ag->pending_req,
      |     ^       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 2360 |                                     "org.bluez.Error.Rejected",
      |                                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~
 2361 |                                     "Passkey mismatch");
      |                                     ~~~~~~~~~~~~~~~~~~~
1 warning generated.


  Commit: 450e99f0801faa22d9a622b8c0d961641b407d2e
      https://github.com/bluez/bluez/commit/450e99f0801faa22d9a622b8c0d96=
1641b407d2e
  Author: Rudi Heitbaum <rudi@heitbaum.com>
  Date:   2026-02-17 (Tue, 17 Feb 2026)

  Changed paths:
    M src/shared/shell.c
    M src/textfile.c
    M tools/hciattach_ath3k.c

  Log Message:
  -----------
  src: retain const qualifier from pointer

Since glibc-2.43:

For ISO C23, the functions bsearch, memchr, strchr, strpbrk, strrchr,
strstr, wcschr, wcspbrk, wcsrchr, wcsstr and wmemchr that return
pointers into their input arrays now have definitions as macros that
return a pointer to a const-qualified type when the in put argument
is a pointer to a const-qualified type.

https://lists.gnu.org/archive/html/info-gnu/2026-01/msg00005.html

fixes:
- warning: assignment discards 'const' qualifier from pointer target
    type [-Wdiscarded-qualifiers]


Compare: https://github.com/bluez/bluez/compare/feb4ee9dcd4b...450e99f080=
1f

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
