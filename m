Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50272F7441
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Nov 2025 20:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762547479; cv=none; b=jRpAywe2CgtusuFfhrcpGZBIg0CHRq18CMG+1OOrhzD/cXINm1p9ZmaKXDGwr4rZ/4H1dbsoWE+9vOxU/r1GsDwq3lnyyBmBKttSnnLJZ1Zdj5PLAGyusGqiL/pP0hFlJG8uZkEQiIke73LQUStXQAa8WxwkjY+sMWhnDpOrinI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762547479; c=relaxed/simple;
	bh=3/Yc7UaHe7wsho5eDCSelTMzudrZzRI/Icui5trJxzY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=EL5Z7rIYMItRuLrC7X+QzkrJBpxBYnjRXpSp32oqczBgtpel+vi6ik4rGefxjvgXs0rH/fkQDVkTNPR0albSLywDHmxNV/EW7zF7b3DYtWS3j5KoyHYxdaAcxUh26UnKnzIiMFa65Tkh5ADUXZeULPIlSUeD9tP9vpDGkg4DXDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Lwnm9JZt; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Lwnm9JZt"
Received: from github.com (hubbernetes-node-4151e64.ash1-iad.github.net [10.56.206.77])
	by smtp.github.com (Postfix) with ESMTPA id E2A3060063B
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Nov 2025 12:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1762547476;
	bh=k++Lo1JBmiWb5WzFyoJFSCn7G8oNYUihZdSOwfWw+BI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Lwnm9JZtcbvjIhHblENXm1BjmFUfrAp4eYA0lrm0znUBFcN0gn8sgegbtuMKwNbhk
	 LDXA/bzLt0dTyzPCI0VB4fVo5BxYdne9uBnV/KxyqRofe+8xiLilJoHevStOZT5Hii
	 fROtAAAdns3Kufhnzj1BUIvijqj+wBPr1+fkBo3M=
Date: Fri, 07 Nov 2025 12:31:16 -0800
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1021075/000000-1b3bd7@github.com>
Subject: [bluez/bluez] 27eb90: emulator: Generate PA Sync Lost
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

  Branch: refs/heads/1021075
  Home:   https://github.com/bluez/bluez
  Commit: 27eb90249173369fe000749a1d7e1a4ab81b7f2f
      https://github.com/bluez/bluez/commit/27eb90249173369fe000749a1d7e1a4ab81b7f2f
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-11-07 (Fri, 07 Nov 2025)

  Changed paths:
    M emulator/btdev.c

  Log Message:
  -----------
  emulator: Generate PA Sync Lost

This attempts to generate a PA Sync Lost whenever a PA is disabled and
there is a remote synced to it.


  Commit: 1874de0a078158798e78debc09ba373bd83a9d91
      https://github.com/bluez/bluez/commit/1874de0a078158798e78debc09ba373bd83a9d91
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-11-07 (Fri, 07 Nov 2025)

  Changed paths:
    M emulator/bthost.c
    M emulator/bthost.h

  Log Message:
  -----------
  bthost: Add support for terminating a BIG

This adds support for sending BT_HCI_CMD_LE_TERM_BIG via
bthost_terminate_big.


  Commit: a4c24d8af5c4c7b7307c8fb2ba3ffe74486f0aac
      https://github.com/bluez/bluez/commit/a4c24d8af5c4c7b7307c8fb2ba3ffe74486f0aac
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-11-07 (Fri, 07 Nov 2025)

  Changed paths:
    M tools/iso-tester.c

  Log Message:
  -----------
  iso-tester: Add tests for checking proper handling of Sync Lost

This introduces the following tests to check if BIG/PA Sync Lost are
handled properly:

ISO Broadcaster Receiver Sync Lost - Success
ISO Broadcaster PAST Receiver Sync Lost - Success


  Commit: 9f1669ae9412b4443ea138cd82d33ed88310d328
      https://github.com/bluez/bluez/commit/9f1669ae9412b4443ea138cd82d33ed88310d328
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-11-07 (Fri, 07 Nov 2025)

  Changed paths:
    M profiles/audio/bap.c
    M profiles/audio/bass.c

  Log Message:
  -----------
  bass: Fix not cleaning up delegator properly

When BIG sync is lost, or the assistant modify removing all streams,
delegator should be freed to so the assistant can start over and share
another stream.


  Commit: 1b3bd732173925a05528676873a8c5d1c6eb04f5
      https://github.com/bluez/bluez/commit/1b3bd732173925a05528676873a8c5d1c6eb04f5
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-11-07 (Fri, 07 Nov 2025)

  Changed paths:
    M btio/btio.c

  Log Message:
  -----------
  btio: Fix endless loop if accept return -EBADFD

In certain cases, e.g. ISO Broadcast Listen, the listening socket may
get into an invalid state (CONNECTED) if the PA Sync is terminated
causing an endless loop of accept syscall.


Compare: https://github.com/bluez/bluez/compare/27eb90249173%5E...1b3bd7321739

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
