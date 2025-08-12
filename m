Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34F72E3711
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Aug 2025 02:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754966460; cv=none; b=bFbsD4I9YBDHtMZGnW9kZGFB7qK1gvFoco3tKSloO4Iw6B23t1bM8nI4S/HHVLJwGHLFSHpFn6pqW0n45xBl/CiMrQcnSDx/uHNFjq2vb5vtq6gRts6seC6he77FPEIe1xyeg7/OHaelAm6DjSBBZ7OpiVvadhp9xkS90T3aEYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754966460; c=relaxed/simple;
	bh=XJaIErbix0mKF3rrbMkyKuIgGvGHQarw6zwzIfuveFc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ilijs5Dwkwxs9ppYQ/XExrxi+ttJlhTgniRc7QGWu5Ab+i1904pdxvVCm2MvJMFyXyA5kvihVDoKbbhWSbfEIXxHJFtFd3CVuS1cty0xvxbLTErg/uUWn7Evvs6IqD7Cp40kzE56QAATIOKgfy7j8PO0ZGsOxn8lcjDU8I4zW9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=dm94ZIrJ; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="dm94ZIrJ"
Received: from github.com (hubbernetes-node-b43dc93.va3-iad.github.net [10.48.141.37])
	by smtp.github.com (Postfix) with ESMTPA id 025194E05E6
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Aug 2025 19:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1754966458;
	bh=O6yuttQ8+dy7HJ5LgnMXCl43X84gwi+VPsWEXWZa4GE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=dm94ZIrJdDmhHeHifoAr1gngZchVBiltTCqR8CgwGnXl3KUzbc2W8aHzTTJ7PgyMB
	 3CGGsBYBLLeAXlq6uiix5D8OSGE405o87yuyEjXCUs+QOcfeJ4u/Ex15JzlXEt2baL
	 Hj8120hNO6mlx+p2TvtLm+/+AtyzctC9aNpZGeUQ=
Date: Mon, 11 Aug 2025 19:40:58 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/013b34-8a304f@github.com>
Subject: [bluez/bluez] 8a304f: shared/bap: reset local ep state on stream
 detach
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
  Commit: 8a304f7fd9607850052fc6ac9c13c63c9d36205a
      https://github.com/bluez/bluez/commit/8a304f7fd9607850052fc6ac9c13c63c9d36205a
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-08-11 (Mon, 11 Aug 2025)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: reset local ep state on stream detach

When removing streams in bt_bap_detach(), they are detached directly
without going through normal state transitions.  As BAP Unicast Server,
this leaves local endpoints to the state they were in, so they persist
if client connects again.  This is not wanted.

For server streams, clear the local ASE state on detach.  At that point,
the ASE is either already idle or the session is detached.

Don't modify state of remote endpoints (BAP Client streams), as only
remote server should do that.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
