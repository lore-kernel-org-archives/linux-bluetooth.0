Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1593E2185A6
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Jun 2025 18:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749149689; cv=none; b=FkZwbMM0hkUjsuJsa0ZC7hZW3LxR8bprPtI9Mt9qAj4T/uLUjqjMVTzLaLh56B+2JCIq955b89c9jX0/HGd9pF6WPNrcYZF/zWUYYq7RdoWcNiIZPaNRvxteMcuIQEeqpJS8VGV1xDrv9URpCkXPXqyaVILfjyX+ONBx3zYw2H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749149689; c=relaxed/simple;
	bh=QW2izeEP5B/C0UlxvS70OrX+2t0ssDqRqQhZqucbaSo=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Sftf98jaVrxrDwdl2aqxJvbkn0VwgdbPejWp4qbjIBRlXyuR++39nw6AvUkqfovJ45kMXdN7nSHAMdkXXcwZkJIOwjnvvIFp5kYlJ/sk6MFmnU6Yxj4wxrejy/6G86VEGu4txrMyNRicnjN5JgZZad1dJvRJyFxnXdar9ophNi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Enh1dsxb; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Enh1dsxb"
Received: from github.com (hubbernetes-node-a670f64.ash1-iad.github.net [10.56.163.31])
	by smtp.github.com (Postfix) with ESMTPA id 06E25601372
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Jun 2025 11:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1749149687;
	bh=eCOQ25cycoE6Ai614wqLyrNfZPczaHSW1UdQ9u1tduI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Enh1dsxbfwzsNyY23qjU3jIU8KZuPHwW9UxIL9X7Nf3U3NeIF5jw8pxxbCWAMVm6y
	 LxYdJPjo7AGJV5jGW0rAxoMsceF6vW52wcVdRUVqQMc8nHTJle7AJJOIycXCU9VzL9
	 B1Ba/KY1M3CgkAT3Om7G4EvQrT/hGXxNshBSJ9Uo=
Date: Thu, 05 Jun 2025 11:54:47 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/969025/000000-07a45e@github.com>
Subject: [bluez/bluez] 3c38d1: adapter: Fix exposing coordinate sets if LE
 Audio ...
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

  Branch: refs/heads/969025
  Home:   https://github.com/bluez/bluez
  Commit: 3c38d1c73ae8c2bbb2b62ab330657f0e5f816e4c
      https://github.com/bluez/bluez/commit/3c38d1c73ae8c2bbb2b62ab330657f0e5f816e4c
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-06-05 (Thu, 05 Jun 2025)

  Changed paths:
    M src/adapter.c

  Log Message:
  -----------
  adapter: Fix exposing coordinate sets if LE Audio is disabled

This fixes exposing non-discoverable coordinate set members if LE Audio
is disabled since it may lead system device setting showing them to user
that may attempt to pair them and end up not working.

Fixes: https://github.com/bluez/bluez/issues/523


  Commit: eb5ddecbaff013d08cb5c5840ff25bdc7ac0b21d
      https://github.com/bluez/bluez/commit/eb5ddecbaff013d08cb5c5840ff25bdc7ac0b21d
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-06-05 (Thu, 05 Jun 2025)

  Changed paths:
    M client/assistant.c
    M client/bluetoothctl-assistant.rst

  Log Message:
  -----------
  client: Add assistant.list

This adds assistant.list command:

assistant.list --help
List available assistants
Usage:
	 list


  Commit: 07a45e579ce26967cbf1a434bec4fec95acf6e88
      https://github.com/bluez/bluez/commit/07a45e579ce26967cbf1a434bec4fec95acf6e88
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-06-05 (Thu, 05 Jun 2025)

  Changed paths:
    M client/assistant.c
    M client/bluetoothctl-assistant.rst

  Log Message:
  -----------
  client: Add assistant.show

This adds assistant.show command:

assistant.show --help
Assistant information
Usage:
	 show [assistant]


Compare: https://github.com/bluez/bluez/compare/3c38d1c73ae8%5E...07a45e579ce2

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
