Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BF81AA7BF
	for <linux-bluetooth@vger.kernel.org>; Sat, 29 Nov 2025 16:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764435073; cv=none; b=Q5U3GXLegI3lQjIE96+jINCILH7PToVqq178ABl6WzO9FS9BgE7eio+mgdOFjTGEjYb96CRPPPBXmfhbnPQeB89Q8CiQGmjHJqv7Qy614M4u1TKxZmKcvf51SGBjIVB7csJoGLgRDo6BioVIqHATeW7tRjvRrgD2ztczseiFAtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764435073; c=relaxed/simple;
	bh=4ZFuPP0dSHxAUPC42sa7t2uBltHBwmsLrAA8agN17Wo=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=XQKzc87tham9jU43pOZUuYz2S3XMrnjQa0I32Rd01z55ylb3S6iP+cvUU4EJXNPVXOuc455txtjUG2mS+NEdq2Vtq2jrNAd30u55zcbfWDponJMUZn3APEbji2M/Z/31Sx8ZQGy1IrkUu15ck/uqdtPPfn0uyHV0QXNPS7X18so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=kRUC+dyw; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="kRUC+dyw"
Received: from github.com (hubbernetes-node-530f5b9.ac4-iad.github.net [10.52.206.108])
	by smtp.github.com (Postfix) with ESMTPA id 1B709202F0
	for <linux-bluetooth@vger.kernel.org>; Sat, 29 Nov 2025 08:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1764435071;
	bh=iAhEtm6iDEPREZh7c3Yzo2Zk1EekBvRWezfsraWId+w=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=kRUC+dywolEVnZanLhW/MXrdBDQ5/Skbv+770+tLycwTn1FMHV35qsjnJVBH6Fs27
	 dWOHPq2T3aM7waYDqO9sNNZ+NcI+kKV7bxneWWWJxFoigmgR0YYnQQxPEBrBGT4Clw
	 iGs6Ntqb93ZsYsPaiK0dtt2e8ab7Bk2JhhWQNACs=
Date: Sat, 29 Nov 2025 08:51:11 -0800
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1028907/000000-76c2fa@github.com>
Subject: [bluez/bluez] dba0f9: sco-tester: add timeout / close during
 connection ...
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

  Branch: refs/heads/1028907
  Home:   https://github.com/bluez/bluez
  Commit: dba0f97b9f65d3dcd1878cf507cde768c4b2c43d
      https://github.com/bluez/bluez/commit/dba0f97b9f65d3dcd1878cf507cde768c4b2c43d
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-11-29 (Sat, 29 Nov 2025)

  Changed paths:
    M tools/sco-tester.c

  Log Message:
  -----------
  sco-tester: add timeout / close during connection tests

Add tests for connect timeout behavior and kernel corner cases:

eSCO CVSD - Timeout
eSCO CVSD - Close


  Commit: 61281d56bb5d308de0bde799b8307d88bc7d50da
      https://github.com/bluez/bluez/commit/61281d56bb5d308de0bde799b8307d88bc7d50da
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-11-29 (Sat, 29 Nov 2025)

  Changed paths:
    M emulator/btdev.c

  Log Message:
  -----------
  btdev: implement Sync Conn Accept/Reject flow

Send HCI Connection Request properly for Setup Synchronous Connection,
instead of proceeding to Connection Complete immediately.

See Core v6.1 Vol 2 Part F Sec 5


  Commit: 75cd750ecb653d79eb086b750821c4372be67c06
      https://github.com/bluez/bluez/commit/75cd750ecb653d79eb086b750821c4372be67c06
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-11-29 (Sat, 29 Nov 2025)

  Changed paths:
    M emulator/bthost.c
    M emulator/bthost.h

  Log Message:
  -----------
  bthost: add bthost_setup_sco() and accept incoming eSCO

Add support for bthost initiating SCO connections and accepting eSCO
ones with BT_HCI_CMD_ACCEPT_SYNC_CONN_REQUEST.


  Commit: 76c2fad61c095b8c9e420b28aaae92a78a6708b3
      https://github.com/bluez/bluez/commit/76c2fad61c095b8c9e420b28aaae92a78a6708b3
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-11-29 (Sat, 29 Nov 2025)

  Changed paths:
    M tools/sco-tester.c

  Log Message:
  -----------
  sco-tester: add socket listen tests

Add basic SCO server tests:

SCO CVSD Listen - Success
SCO CVSD Listen Defer - Success
SCO CVSD Listen Recv - Success
SCO CVSD Listen Send - Success


Compare: https://github.com/bluez/bluez/compare/dba0f97b9f65%5E...76c2fad61c09

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
