Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3E823AE9B
	for <linux-bluetooth@vger.kernel.org>; Sun, 14 Jun 2026 12:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781438914; cv=none; b=d8PeGS/6WeDrG0kL1RmbVzb5cmJRBqdwqQ2se9tre/db43BBqn4K6DhV+MxgwlDKaXjsIEVuL8m4vyxgF+dCsRQPGf5R8s3ypk7fUSv1ZczYGbtTsUH9lArOt1jFF0tFoNfE+i9C1uAVs96Z32v9hjtI9TEdY4cmftS8QA22wZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781438914; c=relaxed/simple;
	bh=Ipvorna3Eb3pFE1avDnXupp7TDRjUpC5tT1yKMYhWK4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Ps/PI33VMQXsBrceIhtRizzE1c9ymjDbTzMJ1EBFyzYEPvbkkTAIjxKfwB0hVhfdQ+H+SJpMi2y+Q6MWPKOJ8LuHJHTfdA5aVHXi3sWQwNVuOrANWBxLxRmolLE0BTBmfi/x503k7QyZuHm4b6whSYn+KGVUhWdi/gyXL3Dob4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=i3Vff4VM; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="i3Vff4VM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1781438911;
	bh=bslRLJtkNE3dzGrMi2s2HhcL+tbUplZ6IpVcXaPMsMw=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=i3Vff4VMmXN4scv0g1F/GbY1NAkXgfyTGrJiTMezXAw4Q3ueQL0k08pxWEv16pYkG
	 B+25iIDf9ZxdibHevfeaZtl0yphuutZxDmz09vUY37Atu9Y/pnQeZpRZ9Ug8g9x/OK
	 DtRrFJT/jnF0TvcYv7ZjEgGz2BJJi1Gaemi0OKDU=
Received: from github.com (hubbernetes-node-8683ea7.ash1-iad.github.net [10.56.144.38])
	by smtp.github.com (Postfix) with ESMTPA id CC4B2601024
	for <linux-bluetooth@vger.kernel.org>; Sun, 14 Jun 2026 05:08:31 -0700 (PDT)
Date: Sun, 14 Jun 2026 05:08:31 -0700
From: =?UTF-8?B?xaBpbW9uIE1pa3VkYQ==?= <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1111249/000000-df5403@github.com>
Subject: [bluez/bluez] 038ea1: shared/bap: Transition ASE to QoS Configured on
 CI...
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

  Branch: refs/heads/1111249
  Home:   https://github.com/bluez/bluez
  Commit: 038ea13b8cc1c3e46a4ef8d4956af74696470a39
      https://github.com/bluez/bluez/commit/038ea13b8cc1c3e46a4ef8d4956af74696470a39
  Author: Simon Mikuda <simon.mikuda@streamunlimited.com>
  Date:   2026-06-14 (Sun, 14 Jun 2026)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Transition ASE to QoS Configured on CIS loss

stream_io_disconnected() only handled the Releasing state, leaving
Enabling, Streaming and Disabling ASEs stuck when the CIS was lost
unexpectedly.

The ASE shall autonomously move to QoS Configured on loss of the
CIS and notify the peer

Fixes PTS test BAP/USR/SCC/BV-167-C


  Commit: df54038451324d0a5be729ba7cd155b5a8c0b27e
      https://github.com/bluez/bluez/commit/df54038451324d0a5be729ba7cd155b5a8c0b27e
  Author: Simon Mikuda <simon.mikuda@streamunlimited.com>
  Date:   2026-06-14 (Sun, 14 Jun 2026)

  Changed paths:
    M unit/test-bap.c

  Log Message:
  -----------
  unit/bap: Add CIS loss test

Verify a Source ASE in the Enabling state transitions to QoS Configured
rather than Disabling when its CIS is lost.

Assisted-by: ClaudeCode:claude-opus-4.8


Compare: https://github.com/bluez/bluez/compare/038ea13b8cc1%5E...df5403845132

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
