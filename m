Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F40D23FC66
	for <linux-bluetooth@vger.kernel.org>; Sun, 24 Aug 2025 20:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756067414; cv=none; b=K2H6xSkHYOAuGJs3Meam4JRt+PKUZzIgxUk0uEVc2gP7DRaxt0DUXIU2e7WyiGcZ2bu94Bj/aYW5tBt1B2mKObLyQ7yRzzD6GQ7E41qEmH+pDz4bzoE/QhiY5Dg32eMwRAKC85/Hg2RvN1yGhqXw2N/p4aY0S9P1JLWl9jizJiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756067414; c=relaxed/simple;
	bh=didT8Opvmaz/jW7i+5xhIKrcN+EMPoajXOByGUzRDSw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=t936eBt4F0kTG9UpjEGkrR8BxTyOpy0SmLV9vCUVW5YrEzPfQBR91nZ6e0oVRcJM4p/0DV0djxnjhyViO8pcNbyiRW/BWlpxDfFVcuIQ3ZPQQovLF/1/RD13NI/mokHQiVUZP29g8RC7S+jNEh7i+ujlCQ83Jht+s+2BUI18HRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=O4CIp76p; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="O4CIp76p"
Received: from github.com (hubbernetes-node-1e42579.va3-iad.github.net [10.48.209.67])
	by smtp.github.com (Postfix) with ESMTPA id 51E50E040A
	for <linux-bluetooth@vger.kernel.org>; Sun, 24 Aug 2025 13:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1756067411;
	bh=dj7UHUslcsTTo+UJrNn53ilMGNV9AScvr4AYL8rGQgA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=O4CIp76pjZ/Cd6dO7aRgllGMOrCVqUxVQ/+vAhzCfaHnKWwFZU4zWPrPm5cA4dlg6
	 ePVHdaTHxc7K/gkbeAKG/R3Twsn49dygOfcyqIV0D59bCwOi8duaj9+pbZzvRtEdzd
	 +ykIHv7TKLnbwfjoNq9Na+craqRq/uLtKwYuUTQA=
Date: Sun, 24 Aug 2025 13:30:11 -0700
From: Arkadiusz Bokowy <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/994977/000000-fd21dd@github.com>
Subject: [bluez/bluez] 116d0d: lib: Fix out-of-bounds write when concatenating
 co...
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

  Branch: refs/heads/994977
  Home:   https://github.com/bluez/bluez
  Commit: 116d0d3042099740cfb649d65e5343d4ecdcb5e1
      https://github.com/bluez/bluez/commit/116d0d3042099740cfb649d65e5343d4ecdcb5e1
  Author: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
  Date:   2025-08-24 (Sun, 24 Aug 2025)

  Changed paths:
    M lib/bluetooth/hci.c
    M lib/bluetooth/hci_lib.h

  Log Message:
  -----------
  lib: Fix out-of-bounds write when concatenating commands

This commit fixes the hci_commandstostr() command by writing new line
character in place of trailing space when wrapping long lines. Previous
approach was to append new line character to existing string, which
caused buffer overflow when there was more than 9 lines in the output
string.

Also, the last trailing space is removed in order to return
trailing-spaces-free string to the caller.


  Commit: fd21dd34497936f7550598b57518cbab32cf78b1
      https://github.com/bluez/bluez/commit/fd21dd34497936f7550598b57518cbab32cf78b1
  Author: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
  Date:   2025-08-24 (Sun, 24 Aug 2025)

  Changed paths:
    M lib/bluetooth/hci.c

  Log Message:
  -----------
  lib: Synchronize supported commands with Core Spec 6.0

Commands marked as "Previously used" in the Bluetooth Core Specification
Version 6.0 were not updated to keep the library compatible with old HCI
controllers.


Compare: https://github.com/bluez/bluez/compare/116d0d304209%5E...fd21dd344979

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
