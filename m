Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF737271A9D
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Oct 2025 16:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761323847; cv=none; b=u/Z20Luu3H503pnlb0XH0qhBrV1C16N2S9P/mgxjftRpRIQtjUt5X/qG4zEYyum3kRMxaIucjrmbjmK1jpuRwNwAwsVx1u+plqnrOJvLHG5jlhn+MGcyyOpYatOe/qqqNB1K7VWLP/gLAIySKQEeBO9henDGhVgfzv13TEsX6bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761323847; c=relaxed/simple;
	bh=hfjqCH+nuYKKWksqTSym42YjzHeV/NlHecUmXd8O1pE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=UcwyuSyIrixfw+WNv+I2KZfiFYnco6hGku8KoRfqNCFck6Cxse45tRFTj03jtQ23cJGB4UktB71RbERQSJKiHHmZD9KqT7OeJVTHOwhwmvbH/Gi4KuqGoSKI0h16Bfnf7Hhf8iEZXIQFsrk0qSMoYQ4SjkypzCwJtUD97C5d1j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=bBs9dr4c; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="bBs9dr4c"
Received: from github.com (hubbernetes-node-98a9fdf.va3-iad.github.net [10.48.183.51])
	by smtp.github.com (Postfix) with ESMTPA id 041E58C08F0
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Oct 2025 09:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1761323845;
	bh=/mxRk1IIbejlPtK6oMeDWw7VjAfC7Yumqb9tPmSXFy8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=bBs9dr4cwvypfZsKAxPfiRwXwjb8O5eds5GJWZRpYI7zYZWFGs19G97Jl7oXphGKf
	 wVWniQ9PoMAYYld6f/HS52AxRbgWE+t6TG1lOL4MBezxwnaQgfUmLql/ciBmjPqkJp
	 yXZNqOqJbzZWWap+4KbmlK6+nbD5um1Eyj7pNfAo=
Date: Fri, 24 Oct 2025 09:37:25 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1015549/000000-a0d59d@github.com>
Subject: [bluez/bluez] a0d59d: bass: Fix handling of BT_BASS_MOD_SRC
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

  Branch: refs/heads/1015549
  Home:   https://github.com/bluez/bluez
  Commit: a0d59d42992c98af8179a060d2db805755c1cc00
      https://github.com/bluez/bluez/commit/a0d59d42992c98af8179a060d2db805755c1cc00
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-24 (Fri, 24 Oct 2025)

  Changed paths:
    M profiles/audio/bass.c

  Log Message:
  -----------
  bass: Fix handling of BT_BASS_MOD_SRC

If BT_BASS_MOD_SRC is received and the sync_state is set to
BT_BASS_SYNCHRONIZED_TO_PA it doesn't necessarily mean that the device
shall be removed, specially in case the assistant and broadcast source
are the same device.

In order to fix this behavior this attempts to free the setups that were
used for the BIS being modified, then if all setups are freed in the
process proceed to disconnect the service and then check if the
device is still considered connected after that, only if is not
connected then remove it.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
