Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097FD18FC80
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Oct 2025 05:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761196574; cv=none; b=m0xB/Rlt+FGjyu4X/FJBJ9ueEdC3wfhGgsDF0gP2KUU9GiYEcAoEkuIwQCyDHbmC0HDYKjWyIQCH8IJkNSbxxRH7yaX68pNsOf2Gb4QX0rBAk/+X2WRSeH3NtqFOguIoENnhV6zTjiA+7phbOherKNrbTtKzdav/wJ0/7ByT3GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761196574; c=relaxed/simple;
	bh=Hu4CiVFpG2E9IzyrmzgMZHBAa9lZV7Srj7W/2uMKaWY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=KCXPgoBkQXUDEt2lVH1Wzh5sXsbMoUNIompVpui22p120YJdk+ysTqEauC/3pEfoGPmL5SyTDll8kot0/w/AcWzCadTSrpMj9skWlealIxto7T2HHAKLWAkxZCgg3EDrzHKmvB3+x5gEVZ5GXmXB7TE0mxqebku1abxAzJk1R1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=GawNSz/T; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="GawNSz/T"
Received: from github.com (hubbernetes-node-bcb3747.va3-iad.github.net [10.48.221.70])
	by smtp.github.com (Postfix) with ESMTPA id 1197FE04C1
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Oct 2025 22:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1761196570;
	bh=7UzXOttgzrpInylzuBEhhhK9y/M8x3LN9/KOikq9opo=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=GawNSz/TPV/EFifxCsD3t1JoU51tRpSJNAT02ZaYXfO+cPtuUH2a1HD/+Ty+8gSv9
	 Vm7VQXBCIKla2954bN/ILNNIJ78IuM40AX3MmBRzm1UuwGJS30i/xK3Kog9X7SbHHF
	 Vk/9KuNGQiKkMuEWCaE+cg1ILvTXKQciW8DzXsfk=
Date: Wed, 22 Oct 2025 22:16:10 -0700
From: Alfred Wingate <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1014817/000000-708285@github.com>
Subject: [bluez/bluez] 296105: build: Support setting the cups_serverbin
 directory
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

  Branch: refs/heads/1014817
  Home:   https://github.com/bluez/bluez
  Commit: 296105922d043027dfd06fd176d3bd25f43545ee
      https://github.com/bluez/bluez/commit/296105922d043027dfd06fd176d3bd25f43545ee
  Author: Alfred Wingate <parona@protonmail.com>
  Date:   2025-10-23 (Thu, 23 Oct 2025)

  Changed paths:
    M configure.ac

  Log Message:
  -----------
  build: Support setting the cups_serverbin directory

This will be needed in the follow up change that tries to fix distcheck
properly.

Signed-off-by: Alfred Wingate <parona@protonmail.com>


  Commit: 5075f61e0e6521a40609dfb65a81f94b222e228a
      https://github.com/bluez/bluez/commit/5075f61e0e6521a40609dfb65a81f94b222e228a
  Author: Alfred Wingate <parona@protonmail.com>
  Date:   2025-10-23 (Thu, 23 Oct 2025)

  Changed paths:
    M Makefile.am

  Log Message:
  -----------
  build: Fix distcheck by hardcoding non absolute paths

To make sure it doesn't fail lets hardcode every path that could come
from pkg-config.
(I managed to hit issues from dbus **and** cups as I have them installed)

You can learn more about this type of issue here.
https://bugzilla.redhat.com/show_bug.cgi?id=1123963

See-Also: 9cc8b97b8 ("build: obexd: Fix make distcheck")
Signed-off-by: Alfred Wingate <parona@protonmail.com>


  Commit: 70828589dcd6e43220729d6659b65bbc82c9e97b
      https://github.com/bluez/bluez/commit/70828589dcd6e43220729d6659b65bbc82c9e97b
  Author: Alfred Wingate <parona@protonmail.com>
  Date:   2025-10-23 (Thu, 23 Oct 2025)

  Changed paths:
    M Makefile.obexd

  Log Message:
  -----------
  build: obexd: Revert "Fix make distcheck"

Bug: https://github.com/bluez/bluez/issues/806
Reverts: 9cc8b97b8 ("build: obexd: Fix make distcheck")
Signed-off-by: Alfred Wingate <parona@protonmail.com>


Compare: https://github.com/bluez/bluez/compare/296105922d04%5E...70828589dcd6

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
