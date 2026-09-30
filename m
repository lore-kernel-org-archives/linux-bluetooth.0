Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF364F30D1
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Sep 2026 14:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790777437; cv=none; b=E/EhF6VD7uW8ji7VCKgIZw1XmmPkASH3eN3lcQ6LBNxQObWXFNApx528D/vACLs+T9e/5HZ8iC8xnTeTEuI81Rn9wJAC5wzjykNTtwX01i0yKc7Vzps2D4ug+zDnk29tuHdtINfyU+7PILE3etu0RCmlJKMXI4AUGlyrWThVmyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790777437; c=relaxed/simple;
	bh=S4yL7OEjQ6Qtx5e85J8ugtBRt+vKxIlesh/mL8QyH2E=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=UxOXeOXNFk1Z1oCJ6oCmE5ljPvG7fxsxEiKYSEUpZpLohE4tMpazLLXWRYGDNZKxMmDNXwZ+SQICd2qwQ3Oj4jyLvX6C6HxliLxd/LAghyMuDxFRWywY1ujwJ7F0Mu29RNzJbgi6IZxt4/RG1u2ReiIn7Ge+EBK1MwghL4rim1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=lnCEFvKU; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="lnCEFvKU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1790777418;
	bh=lDW9Zpspt8X/UdJi2FNs35KBYIIegm4KzXQsQvrTQw4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=lnCEFvKUN5nNiK7mdjY5jZ62AQYZNQp+iOpDeC9E+Vw0T7GWzayVShJSUeR6E8xpD
	 uMCMWbBrI6WqjWo3eeaTxYZXTJo0Ff9zbolc+8KNG95vq1kUgZeSubNiPPGuJ7m7Ym
	 rcLfcCzwaKB5n/lAb0TRWLBSXkYZ25e6tUsh0tVYvW22cG4tyVK9Kxj1H26+eaSWSx
	 a0idwstABVmYAlyq0gcXNwqeDzMsgHB3InYVse29VYCy0Lhxkt1+Q7ABYCKJEHEYrD
	 1g9pf0XSWn9HCSAK/3OOYzwMQVYPvWJskD/H0idmZ2v1gcSH7FLYCh3fBFJrh9XCez
	 dzxrZmoPzwerA==
Received: from github.com (hubbernetes-node-4b7d16d.va3-iad.github.net [10.48.130.41])
	by smtp.github.com (Postfix) with ESMTPA id 2407F28061E
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Sep 2026 07:10:18 -0700 (PDT)
Date: Wed, 30 Sep 2026 07:10:18 -0700
From: aluvalasaitejaintel <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1176664/000000-e70640@github.com>
Subject: [bluez/bluez] e70640: emulator: add generic HW rfkill test tool
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

  Branch: refs/heads/1176664
  Home:   https://github.com/bluez/bluez
  Commit: e706401fd86e46a6e3240fc8eed880d0f8d7bebc
      https://github.com/bluez/bluez/commit/e706401fd86e46a6e3240fc8eed880d0f8d7bebc
  Author: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
  Date:   2026-09-30 (Wed, 30 Sep 2026)

  Changed paths:
    M Makefile.tools
    A emulator/hci_rfkill.c

  Log Message:
  -----------
  emulator: add generic HW rfkill test tool

Add emulator/hci_rfkill, a standalone tool that drives the
force_hw_rfkill debugfs hook for an hciN device and verifies the
reported hardware-block state against /sys/class/rfkill. The hook
exercises the generic net/bluetooth rfkill path for any HCI transport;
it does not test the driver's hardware interrupt or register handling.

Support assert-only, deassert-only, and toggle modes. Validate the
hciN argument before using it in filesystem paths. In toggle mode,
if asserting the block was written successfully but subsequent
verification fails, still attempt a verified unblock while preserving
the failure result. Do not attempt an unblock when the assert write
itself fails.

The optional -r/--restore mode snapshots the adapter's up/down state
via HCIGETDEVINFO and restores it via HCIDEVUP/HCIDEVDOWN, following
the raw HCI control-socket approach used by tools/hciconfig.c.

Usage: hci_rfkill [-e|-d|-t] [-r] hciN

Signed-off-by: Sai Teja Aluvala <aluvala.sai.teja@intel.com>



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
