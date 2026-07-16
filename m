Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D35941D63D
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 15:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784214643; cv=none; b=Jg7PFdn0K/qmmwDe4Iermg4HYqrr38lLgAEDOYz46Yq4/FiDJKiUnxLyw51VeO1XbBtbCYWMr6XkVWTmoyTDaJLAxyqRmo3yUweq2cb+OFM0S0Pg49kgFhjc2tRKoEqvo5qlHWPuARjYiQN+xZOIBsg+VHjcFeQTUVTwpWup/Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784214643; c=relaxed/simple;
	bh=A2HwWBps/bP3d8PjcA0rU2MMASUWwJAykPFRSwaJLDY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=W97n0b8SOPpicFX118lFVvX6G5UEzIexbamvt9kQoD0lpKvfXWIbL/IJW6gvJUXXm/VZQkTC0eCOvXhkBA35yeLUvA+OchD6PLQkjKZ9sD5Sw5MH56xras2J8d7E2krr8dP+2pUL2q/io3lroSGaDQeTdCXtmXx1XefCiAeHvew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=X9d5fmAB; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="X9d5fmAB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1784214640;
	bh=GVJQ0XwG16j1fqJrD3X0hoJZbrDyphagJYi7K+OXUu8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=X9d5fmAB/0BVwEvH63zyxxAssOrq2fcGKL7/mDZoxITQ4D9AKgATzxN8EL8hhfITO
	 7fJyZSGz6jd+CHRecojbPOhkkJ64jLfELxQcyXKsEYRN490nqBSWPPmlsXE7kja8IN
	 /aWNJVVpkWdimRyhpLV/PASB1sih0YOU2HjB2/ZY=
Received: from github.com (hubbernetes-node-6c7c246.va3-iad.github.net [10.48.65.47])
	by smtp.github.com (Postfix) with ESMTPA id 28FFC801100
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 08:10:40 -0700 (PDT)
Date: Thu, 16 Jul 2026 08:10:40 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/30db66-ae5d5a@github.com>
Subject: [bluez/bluez] ae5d5a: monitor: Fix build error
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: ae5d5a1e30323b6e73fd529c3c63f9f68fc07000
      https://github.com/bluez/bluez/commit/ae5d5a1e30323b6e73fd529c3c63f9f68fc07000
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-07-15 (Wed, 15 Jul 2026)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Fix build error

This fixes the following error:

   36 |   return __builtin___sprintf_chk (__s, __USE_FORTIFY_LEVEL - 1,
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   37 |       __bos (__s), __fmt, __va_arg_pack ());
      |       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
