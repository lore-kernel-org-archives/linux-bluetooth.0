Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620E733F8DC
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Mar 2026 19:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773777590; cv=none; b=VcEC+mcKyGnXzlJW3gxLX6ED/jOy5N+jT9s6bql8cSNioAok4b/SuPQ6NPW79QwzowRomSYQJHBMFHUHhMY0fGkDO2ASPHKVAiElflsclD2MqIRJdiBWYlZvQip4nHTpgQC+Cf7P5dY+/ZBB3/8pMgUDFY7UvyT4o2UZQwRZyAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773777590; c=relaxed/simple;
	bh=CT0W+CQIIgPbvV+xQJjwQuvUoPOkXDSA0Zce08oeY5o=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=f5kqsznuAnzXkwlGFT4y73QNfUWAi4z1/1eCXXforPww68KlHrHTLo080iPMlD8lB7q54Di5ZeLUoGbUoa1RvcyQ/9f7Z83ad+j0OETpBu1xpYK2T5z76SBS++/d/MCPPCiLCyNWRo4mp5zxzI594yKONTvFXfrpRZh0D7feTtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=KtGnysJE; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="KtGnysJE"
Received: from github.com (hubbernetes-node-d62017f.ac4-iad.github.net [10.52.182.42])
	by smtp.github.com (Postfix) with ESMTPA id A30A1301150
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Mar 2026 12:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1773777588;
	bh=pVYbaL17+btg0o4L+ADrWr3luYYfBZFFJlOF8GTtRzQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=KtGnysJE7x030/85sq/2ni/oOniYuI05jnL51Se6awpR4QeRkJLGCg5IOM9ID1DCq
	 mZCfYfQwiELgqFZnrUJQcN0KFUQzt6st6a/98+3IsD44koXqHYdzpjZpnI/waul1dt
	 l24q8EaSKTZfuvXjfKL+IHduNUIl5RiGxgC1sMvk=
Date: Tue, 17 Mar 2026 12:59:48 -0700
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/11d05e-52c2b3@github.com>
Subject: [bluez/bluez] 52c2b3: tools/btmgmt: Fix btmgmt --help hanging
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
  Commit: 52c2b37d90c008e9af5a4076f27d4c1912babfd6
      https://github.com/bluez/bluez/commit/52c2b37d90c008e9af5a4076f27d4c1912babfd6
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-03-17 (Tue, 17 Mar 2026)

  Changed paths:
    M tools/btmgmt.c

  Log Message:
  -----------
  tools/btmgmt: Fix btmgmt --help hanging

btmgmt when run interactively would wait for commands on its prompt, but
that prompt is never setup when the help output is requested.

Handle --help through bt_shell_handle_non_interactive_help() so that the
application exits as soon as the help content has been printed, like
other interactive apps in bluez.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
