Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40E533374A
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jan 2026 14:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769439360; cv=none; b=Fvjo6BoBBoV7Usryiip+nxsV61lmbsQPpZiStX7r3vVbobYq4gF/ffDMI/Z6eoZ5EEJF4lKAUMQai/WoyRm7Vwbrs980MAOMf2SfG5fdEpgAie5z3J6CgQHtk9Y47JuqtZMTK7qcrpu3rwU2DOvilth4NFjf1a/mvC0wGOTOV/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769439360; c=relaxed/simple;
	bh=pNDywTG6Y3kJMKSTXF0e/fotYC7CJ81/bF5vtVCaxmg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=hxlCX0RPtYDy/EVrtNArsvvDmc410BKMlZd5DQvBAJLEjjmoiFSGFcPZtqq1Qk6YLR8db0dXh48GBEP4Zqd+WHCaCBthU7/Qbn9CMpqClFTn0BRLIYfZ7wjIHf/CYeAlJ2cs4b21ojnOQvCHJ0elpESi+3cHP2kHCQ64ba6MCOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=dcsGfEAu; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="dcsGfEAu"
Received: from github.com (hubbernetes-node-76e7b7b.va3-iad.github.net [10.48.204.84])
	by smtp.github.com (Postfix) with ESMTPA id 1A0C23C0E06
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jan 2026 06:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1769439358;
	bh=8XnQbPBCyvmH9GdrTuHG1HoX/8UEVg1EaK/koReSBio=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=dcsGfEAu3T622lC6sYHt4Cb8X83MivYJmxDFBC2mh75MjgUTi8TtZC9Hjx1/v0w4j
	 vBXjSWHnMO2hGRfkbKCFHqjmHfcClr0cCuPkPU7P5Yfa9xWPMsjUuYvxW43UaHg4ZO
	 VleU+mTfapXjGgZ8xHvodDhIGdyI3BmLqNk5J6OU=
Date: Mon, 26 Jan 2026 06:55:58 -0800
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1047149/000000-618fd0@github.com>
Subject: [bluez/bluez] 618fd0: shared/shell: Fix not dequeueing command
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

  Branch: refs/heads/1047149
  Home:   https://github.com/bluez/bluez
  Commit: 618fd0e24dea5d6b8b76b5bc88b66e3dbb05a7f9
      https://github.com/bluez/bluez/commit/618fd0e24dea5d6b8b76b5bc88b66e3dbb05a7f9
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-26 (Mon, 26 Jan 2026)

  Changed paths:
    M src/shared/shell.c

  Log Message:
  -----------
  shared/shell: Fix not dequeueing command

If script execution started with command that call
bt_shell_noninteractive_quit directly it wouldn't execute the next
command since data.line wouldn't be set.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
