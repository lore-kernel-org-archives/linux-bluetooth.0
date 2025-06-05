Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F39927B505
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Jun 2025 19:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749152088; cv=none; b=pg6mH4bPH5p1s/HvrkeFfmqqZt5XmXgnCyXBOOxnJqSpAc+BS0n90kMWusEN8JZO+ceK96+fwQL6PUt5CJ328B2sPK5GJpMZtqQ9x/gd609uMQ2zRlsL6E3uA1X4F3+1/EIQQAx8YiiMQxQxLu0ODKQu2944bMxlsrbFx9ITbEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749152088; c=relaxed/simple;
	bh=N5KIAM5+Z7/3NjRaDbQcCp/8ifITPRzi45Ebd7Cn3+M=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=W9IcHBgsa27nr1f7mwud/xtQG6oFotispLf6/vSFmAHd+6fXFIxfKbWKwvpbL2bBnxp2wnb7F2Sv3FbqnxUhWLDSltpP9n0s2MTQK+Kp2oecY3dcNhT9+X390v4Ow20/efruerENCrSAB4vco4MKFlAkvnut51dZ0ckIXwk07i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Dd6Dju5r; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Dd6Dju5r"
Received: from github.com (hubbernetes-node-50a23a3.va3-iad.github.net [10.48.201.72])
	by smtp.github.com (Postfix) with ESMTPA id 84D1A8C0861
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Jun 2025 12:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1749152084;
	bh=obdvsXGj8njSc+5OPHSILgF78WnwGK7mdBMvZO/vA7k=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Dd6Dju5r2C+SlWvvHyRYxVVOqBek1jTat6Wvv1/pzZQaMSYOgpYU7EpeAUP5riis5
	 LWJAllu6s0ALAQAtX26xynJgFc+diYc9FX43s2WloZfiP1rKip1kvzAMOuJQf3LDrE
	 EeHtQyt1/Ct/JN1Z2ae6/cxAvnvDi42LTm5Yg0zI=
Date: Thu, 05 Jun 2025 12:34:44 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/969046/000000-c5ff04@github.com>
Subject: [bluez/bluez] 486fb1: shared/shell: Add support for -EINPROGRESS to
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

  Branch: refs/heads/969046
  Home:   https://github.com/bluez/bluez
  Commit: 486fb1f757fc4f91353686ebf2aa34524b8424d6
      https://github.com/bluez/bluez/commit/486fb1f757fc4f91353686ebf2aa34524b8424d6
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


  Commit: c5ff043720daba670452c0cc913239fdbd1e5433
      https://github.com/bluez/bluez/commit/c5ff043720daba670452c0cc913239fdbd1e5433
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


Compare: https://github.com/bluez/bluez/compare/486fb1f757fc%5E...c5ff043720da

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
