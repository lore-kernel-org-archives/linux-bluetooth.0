Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E503A40A921
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 10:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784197261; cv=none; b=iGxWnbAS9RKUIa/EcfY+PGALr/hCzqGimkeyRV7u3N9/zKHREN5U7QJ9V3I6phBL8D/5WdyObL4hqEdniTPkCWlBid2nm4jyntmS92xCmeGL/ulrKEAwMNNr7HRT7ovCGwRAFCEnTTiSz/PUZbbT6zVP6zcQxuFou0U6SpYDo7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784197261; c=relaxed/simple;
	bh=Fbk7e4Hk7JEx/2t6IlQB6QHeSzmNg38xJkziZt1wnLQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=AFmUomipwNtM6T62ULVZfYgLGdFy+kD6kDyNRDUJL+sk0YQoLUHI9DjfvVbHpIG+wXUTc6V7gylaz2gZNN0wKlpkxWpqybdjFiHSXgwIlmwaiGa8AAZqo4mKbX4DWEl56ykCym6UV9swF4meYjgu6HpX0C/H3pcjBlMnEiiC7Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=VJgJtqJA; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="VJgJtqJA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1784197259;
	bh=cxhAZ2AbEBU14z7wvk0ko9P2arU8uQyyVD5f2q4nLiM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=VJgJtqJAnBWNzUYiDuKHrt0T2dC/fZ6a4zJykzHZ0sdMiWIwKun9GxZAUKpE4ieYy
	 wZ6gjYeKwZCzf0BWtSWqBXoXBJE0Y3xrSbQLGaogL7CALpEOJ8D44JG5sTr6vlSJqh
	 03WzixrTMNmUFGEsHFabpAKZUjmYWBtsKMsVTo8E=
Received: from github.com (hubbernetes-node-e15f3ae.ash1-iad.github.net [10.56.166.36])
	by smtp.github.com (Postfix) with ESMTPA id 119BF521032
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 03:20:59 -0700 (PDT)
Date: Thu, 16 Jul 2026 03:20:59 -0700
From: uos-eng <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1128714/000000-9ce798@github.com>
Subject: [bluez/bluez] 9ce798: policy: Connect profiles for bonded inbound ACL
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

  Branch: refs/heads/1128714
  Home:   https://github.com/bluez/bluez
  Commit: 9ce7989c8bad0224ac19fcd1899d37a9bbf59440
      https://github.com/bluez/bluez/commit/9ce7989c8bad0224ac19fcd1899d37a9bbf59440
  Author: Chengyi Zhao <zhaochengyi@uniontech.com>
  Date:   2026-07-16 (Thu, 16 Jul 2026)

  Changed paths:
    M plugins/policy.c
    M src/adapter.c
    M src/adapter.h

  Log Message:
  -----------
  policy: Connect profiles for bonded inbound ACL connections

When a bonded device initiates an inbound ACL connection (e.g. after
resume, the remote wins the page race), BlueZ accepts the ACL link
but does not establish AVDTP/AVCTP profiles. The remote's subsequent
L2CAP connect for PSM 25 fails with "security block" because the link
is not yet encrypted, and the kernel does not retry. The ACL link
stays up with no audio.

Add btd_connect_cb callback infrastructure to the adapter core
mirroring the existing btd_disconnect_cb pattern, invoked from
connected_callback so it only fires on new MGMT_EV_DEVICE_CONNECTED
events. Register a callback in the policy plugin that starts a
2-second grace timer for bonded BR/EDR connections. If an audio
profile connects naturally within the window the timer is cancelled;
otherwise btd_device_connect_services is called as a fallback, but
only if no audio profile is connected yet. The grace timer is also
cancelled on disconnect to avoid racing with device removal.

Outbound L2CAP is queued by the kernel until encryption completes,
surviving the race. The fallback is safe when the host already won
since btd_device_connect_services returns -EBUSY if a connection is
already in progress.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
