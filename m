Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA3220012C
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Jun 2025 18:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749149690; cv=none; b=loJMiojqj5TJuG/sbkQMALE1e5Q3lKuNEeOEXKGMOBJmbF7oxIOLubvJecldXr/5xrNp7zKorAWuW4Q29cj/UkgykLkb1a6PP4ya11y+avmlAJ0TlVxcegi8tovoJCICwFJAIqm9mIJNkWRU6vrfLpBCnC1wm6wKgxjOiLJisU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749149690; c=relaxed/simple;
	bh=hkTSDJqHI2hoSIYF5X1rTkjcrdpmvIG78PoFlimhBQk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=DSQr0sgvf8E/xghEYrZAER3o2wFHznwgwqYaK0s/W7CZ4tLIU+0ge63/LHwM7UhEx1vlq6ilrpnq2e+hEf+vg+uFIskBSsHjHYh7PPzOF72NKhQZTomVBFzWwrsDuTP2fcTWD2tzEdPYcypC3iHV4h9SSV9x+zGfb3nKNdOYl+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=R830dFPB; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="R830dFPB"
Received: from github.com (hubbernetes-node-f291013.va3-iad.github.net [10.48.205.52])
	by smtp.github.com (Postfix) with ESMTPA id 6F2D2E1126
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Jun 2025 11:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1749149688;
	bh=0WXFsN32gcz2UPb6N3diHeaHlIQT6KCZoZK4HQua5bk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=R830dFPBEdfSCPZeHUw0lylA/Gd3n+oZ0ppK+sKNQnsxD8omzA9i6gOiLFl88Mm/q
	 dgwp7QBT/BEFCZkU9CLeGd3zUWdn15eYS/lRVoxBWYVqngcMosvN3eMzT4PuaGFqcD
	 3sODGkHstUgnmNEJhx0OyyRTOwSVL1ETEmhMeyyI=
Date: Thu, 05 Jun 2025 11:54:48 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/969028/000000-f0f469@github.com>
Subject: [bluez/bluez] 0c3aba: shared/shell: Add support for -EINPROGRESS to
 bt_s...
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

  Branch: refs/heads/969028
  Home:   https://github.com/bluez/bluez
  Commit: 0c3abae5900eae0b6abbcf84afef197f32deb933
      https://github.com/bluez/bluez/commit/0c3abae5900eae0b6abbcf84afef197f32deb933
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-06-05 (Thu, 05 Jun 2025)

  Changed paths:
    M src/shared/shell.c

  Log Message:
  -----------
  shared/shell: Add support for -EINPROGRESS to bt_shell_noninteractive_quit

This enables commands to call bt_shell_noninteractive_quit with status
set to -EINPROGRESS to indicate their execution is in progress and shall
not exit in case of MODE_NONINTERACTIVE but it can proceed to the next
command for MODE_INTERACTIVE.


  Commit: f0f469bcca9572c6f25d436fd2d5ba89edeb6f55
      https://github.com/bluez/bluez/commit/f0f469bcca9572c6f25d436fd2d5ba89edeb6f55
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-06-05 (Thu, 05 Jun 2025)

  Changed paths:
    M client/advertising.c
    M client/main.c

  Log Message:
  -----------
  client: Use -EINPROGRESS with scan and advertise command

This uses -EINPROGRESS with commands scan and advertise since they need
to keep running in the background so they don't exit but shouldn't block
other command from executing in case they are invoked from a script.


Compare: https://github.com/bluez/bluez/compare/0c3abae5900e%5E...f0f469bcca95

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
