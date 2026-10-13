Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B0D497B9E
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 18:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791916363; cv=none; b=t6T2Kv/wq84GzjlFzvAIL1L5SQtxAj8wI6G9ND/QhSYp1hGZUNn9IkgVWP1V6u6Cf7QYhJrnje4C3HbqJWwUOxfa58oe5QofGriO70dVzohQcTVrjKXmAUEozjLShl6OjGKIkF6UaC1I2npHtZfYZwWMIF/LssXqUslYk4RmGfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791916363; c=relaxed/simple;
	bh=OCpNWYlSCmiS51yQlm5Y42VWfk84K6m99nE2+tshA6w=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=mXO/0O3QxaT9xdpfAu4YSF341DNgWoZLoX2NwIj1DHo5GmlHfsO587WKrDnYFmWVU3J/iRFY6p/feR97gfqAqBveZuVPOTNnD/0I0aO8xv8xFLy3fF2y6rNduTIDBMSjHq92JKb8/0mP7wZGVAPWCbvbQxP9A+OJFQx0BaXmG8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=ZyxmcNS3; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="ZyxmcNS3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1791916359;
	bh=fBwGcRxbL+0MTqXSptDqy+626JAjwnvDBB+rAi2VE74=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ZyxmcNS3hmMjf2t5owC793FtYmPCaQLQaOAoNp1Jyzh287DzMtEp2TGPuH/yXlh1w
	 sWq9U59yZzjyQjVqFcYevFJqQHV1GpVRpBogGUIvTq6EErF/4QQkuHPbxa0XZsJ6Pt
	 01p9eQ13y5nBkYkUF+KjUNpo0s8AW5dEVaH1fZV8h0sPOremOgBmc+YMFOc2pGcU+o
	 wEmY4rb2R6/F1518YE77Au8wWqOfTzX2oMkhf93Gl6mrtlMorZE/p3SPGtxVYVEBEC
	 8H1JHRZjO7aB5eAR59hquphOwvRg5ooJUb9+4bcoTCy4Ko3FR1oHGVV7n6Ws2CL5lA
	 /zYAxEPmJ3q+A==
Received: from github.com (hubbernetes-node-6e38296.va3-iad.github.net [10.51.99.32])
	by smtp.github.com (Postfix) with ESMTPA id 56C5E500C92
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 11:32:39 -0700 (PDT)
Date: Tue, 13 Oct 2026 11:32:39 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1184865/000000-6d647f@github.com>
Subject: [bluez/bluez] 6d647f: test: functional: connect instead of pairing a
 bon...
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

  Branch: refs/heads/1184865
  Home:   https://github.com/bluez/bluez
  Commit: 6d647f300a566ad5a1d9b2ff54af0935d427e86a
      https://github.com/bluez/bluez/commit/6d647f300a566ad5a1d9b2ff54af0935d427e86a
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-10-13 (Tue, 13 Oct 2026)

  Changed paths:
    M test/functional/test_bap.py

  Log Message:
  -----------
  test: functional: connect instead of pairing a bonded BAP device

The hosts are shared between tests, so a device bonded by an earlier one
is still bonded when a later one pairs it, and pairing it again fails
with AlreadyExists. cmd_pair is meant to connect it instead, but it
checks Paired, which is not set until the services are resolved, so it
can still issue the pairing:

  FAILED test/functional/test_bap.py::test_bass_past_transport_acquire
  AssertionError: Failed to pair: org.bluez.Error.AlreadyExists

Check Bonded, which is what the pairing is rejected for, and connect the
device instead when it is set.

Assisted-by: OpenCode:claude-opus-5.5



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
