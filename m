Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0271A285
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Jan 2026 20:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767991191; cv=none; b=JCW6L83DC32mJr8IEGCv0++C0l4JfuAHdqFj1+SGMUQ1jqqKe0T72FC1gNSstSrEzuHoOnOVO0m1w7dcviBtIlqjdiccxQlv9FbgECLCoH9uQEE5nQKWKIifb1THN2MOZqZWOUGtpaQ+gNiFtV68zZTdAD/DbgOH52MvXXB0NSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767991191; c=relaxed/simple;
	bh=6ugEhsEOYVGUtCEPYXwbDTrI0YnOKez3SYNNNgg13eE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=HaXZWS7Mk2ySCCV8VmYKboWHxDbM9q4i1tj4ubSq4qKSK5QbJcKqDeGULPqg8yzywVX2c732Bo3xDN1WLYOYr29WYkq06DMt+0czgCyimdoy9l9/KmLOGPYeZLoctua6ipZGNiH39a37vJA4D8XR6irXQjttH1Ys4vjOk4ZGJMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=SrNtX5Dd; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="SrNtX5Dd"
Received: from github.com (hubbernetes-node-aefbcd8.ash1-iad.github.net [10.56.209.13])
	by smtp.github.com (Postfix) with ESMTPA id 1C3DE14114E
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Jan 2026 12:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1767991189;
	bh=X/RBZq7MGe9VzM71zeNNF928RKBOIGNWU6vvRDOFwgA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=SrNtX5Ddj1LJ6JJoNmnLEounVlSOHe+Mu+dek6JuYiHp+foYbYc2MZkxCmHMUthnu
	 zrbt9lsc6quKXRzIVVOp34Ej464Z8Z0U3+BHP4UsL1Bj+svUGu7UT3M+x7Gq3ab6bS
	 jBmOFix1w5+eKTZiYc4WwFLXULfHunjik/awSH30=
Date: Fri, 09 Jan 2026 12:39:49 -0800
From: dalegaard <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1040617/000000-3361c4@github.com>
Subject: [bluez/bluez] 3361c4: device: fix memory leak
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

  Branch: refs/heads/1040617
  Home:   https://github.com/bluez/bluez
  Commit: 3361c428ffcf8bf4f1ca3af5d277a6157a6fc5a5
      https://github.com/bluez/bluez/commit/3361c428ffcf8bf4f1ca3af5d277a6157a6fc5a5
  Author: Lasse Dalegaard <dalegaard@gmail.com>
  Date:   2026-01-09 (Fri, 09 Jan 2026)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  device: fix memory leak

device_add_eir_uuids creates a list of added UUIDs, but it was never
freed.

This was found with LeakSanitizer from the following backtrace:

==764182==ERROR: LeakSanitizer: detected memory leaks

Direct leak of 16 byte(s) in 1 object(s) allocated from:
    #0 0x7f3c7db20cb5 in malloc /usr/src/debug/gcc/gcc/libsanitizer/asan/asan_malloc_linux.cpp:67
    #1 0x7f3c7d870afa in g_malloc (/usr/lib/libglib-2.0.so.0+0x65afa) (BuildId: 8b07c017773317c7341f72bb8ca4a7a78b323f37)
    #2 0x7f3c7d88e31f in g_slist_append (/usr/lib/libglib-2.0.so.0+0x8331f) (BuildId: 8b07c017773317c7341f72bb8ca4a7a78b323f37)
    #3 0x564fa6ad9153 in device_add_eir_uuids src/device.c:2451
    #4 0x564fa6a6b2ec in btd_adapter_device_found src/adapter.c:7481
    #5 0x564fa6a6c5cd in device_found_callback src/adapter.c:7607
    #6 0x564fa6b9b73d in notify_handler src/shared/mgmt.c:337
    #7 0x564fa6b91ad8 in queue_foreach src/shared/queue.c:207
    #8 0x564fa6b9ba3f in process_notify src/shared/mgmt.c:349
    #9 0x564fa6b9c899 in can_read_data src/shared/mgmt.c:409
    ...



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
