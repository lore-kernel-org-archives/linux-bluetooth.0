Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3822E0B44
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Jul 2025 14:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752072707; cv=none; b=BNO7XhneqHDFyMn/WaBH/DXEBYsqdEdZV0dbcL4wn9McC+v8UOGRpBeOQf5J3Iuti5UIl+uvpgtZH6HHdr8gGVviQqtnPa9P+WO3Wf2AX1u7+WnNeAaTXPV9fPth9TGBY6u9Oqdv9RKDCSDTQrTN6njW5mhhP1qYh/XilN99AP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752072707; c=relaxed/simple;
	bh=/jjHi2OxRUXgZxpLJOFHuJqR7ezOvpheaWygwfQFjjI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=bNSfKC3aU3DAI5MVTkUbtxtIg2Gd314FVeyh/M3SGjFH8oMAz1LWPOfd8QeyQydo42YjzlwQ9c0zz8ZdpQQVTjRrNx9wWNeR0uH55eWWC2hH2E0tVDJdgYNQFji8oCIZWXGZ8yii9j6ZaruUmqc7McrZ8j5PVU2L9PP9AbXcoOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=QLN2uiUa; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="QLN2uiUa"
Received: from github.com (hubbernetes-node-5edbc32.ash1-iad.github.net [10.56.155.40])
	by smtp.github.com (Postfix) with ESMTPA id 326739200F5
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Jul 2025 07:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1752072704;
	bh=n1tqdpOrzogPDfsudFShgCJUWfogpgLNmqcoLa6Cvjc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=QLN2uiUaeFX0c1a27J+154hrJvbVi/GcllvJvW98nqQcvQivD/NcdsS1MIpJijfXP
	 JPNqK1gIzDsW1RarG+vh9AYbG5hldPI6/xZ0p/Z3uKLz6vQxKK62GYbIHofA7pzCft
	 pfzCO31ZA8QMTrhfUYYaSK62FypOKyyMxNXuNtoQ=
Date: Wed, 09 Jul 2025 07:51:44 -0700
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/980566/000000-886bc2@github.com>
Subject: [bluez/bluez] 886bc2: obexd: Remove --enable-threads option
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

  Branch: refs/heads/980566
  Home:   https://github.com/bluez/bluez
  Commit: 886bc2b6051844aa6a4ddfcfdc1d0919ad76c558
      https://github.com/bluez/bluez/commit/886bc2b6051844aa6a4ddfcfdc1d0=
919ad76c558
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-07-09 (Wed, 09 Jul 2025)

  Changed paths:
    M configure.ac
    M obexd/src/main.c
    M obexd/src/plugin.c

  Log Message:
  -----------
  obexd: Remove --enable-threads option

Threading support is always enabled in dbus since version 1.8 released
in 2014:
=E2=80=A2 libdbus always behaves as if dbus_threads_init_default() had be=
en called
  (thread-safety by default)
so remove the obsolete option.

Note that we also require glib 2.36, which is newer than the version of
glib with GThread support built-in:
[Since 2.32]
This function is no longer necessary. The GLib threading system is
automatically initialized at the start of your program.



To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
