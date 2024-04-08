Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1C8847B
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Apr 2024 19:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712604741; cv=none; b=DTJFKAYSMBZkZH2Fa8dVt+dErRet4luo5i4E4LE37tuYrdQLWQVFhO1qsGxTZICgymwIAxcIOYSy7hjcLaewd9Vfkq/Xft6rtLjiJ5uRAEMoU13ApKCOULyFvBq2SHZFM2q+/aKARrRr/widcywhboN+4DJ0VjIQ3M4RFlfCr+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712604741; c=relaxed/simple;
	bh=psN4Cpsv2a2GXtbEvAMd3heLQdqpROcBfxQUpRfx/II=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=n7svHfjKhByzWS2w/NwxRTjrOczkSbxj5GlEsBbZPehhWCJOKVcj/mSZ6QWdTQToRB7TR5gZl6kvISReo3Ygif59d2C0Q/cYvF0/1BWVzZV0fzDrvaqHKNQgQyp8mMkChrA8Vq03U7KJ89b60MUdKJQwveW9n19ae1xq/R8405I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Ipi5CxHa; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Ipi5CxHa"
Received: from github.com (hubbernetes-node-9cb19bb.ash1-iad.github.net [10.56.143.42])
	by smtp.github.com (Postfix) with ESMTPA id 640F46004F5
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Apr 2024 12:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1712604739;
	bh=n+nCs3P5IVPKP+wyINgGSYNYPptBbry66XBUP/q6dew=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Ipi5CxHahoIps2diNVzdl93dKA7knILNKa0WOrXsT/g2qylY6rsnTsQhqo+WrGL6C
	 VKvihHQwPaO6u6rva0FjAaj9u9bIsMbj7Qy/ZxDHc8ouPGqQjGWH16v3XOvLF6ALMk
	 NmuQnqWDT4+UxQjQvY65jGxskJAYzWv5cuQg5SUw=
Date: Mon, 08 Apr 2024 12:32:19 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/98bed1-7604a5@github.com>
Subject: [bluez/bluez] ea96d7: input/device: Fix not handling IdleTimeout when
 uh...
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
  Commit: ea96d7d18bffb4fefa29828aaadc6b4823869ca7
      https://github.com/bluez/bluez/commit/ea96d7d18bffb4fefa29828aaadc6b4823869ca7
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-04-05 (Fri, 05 Apr 2024)

  Changed paths:
    M profiles/input/device.c
    M profiles/input/input.conf

  Log Message:
  -----------
  input/device: Fix not handling IdleTimeout when uhid is in use

When uhid is in use IdleTimeout was not taking any effect, this also
attempt to force the destroy the input device node to make it useful
for users that don't want to keep the input node forever.


  Commit: 94c4f445af66c553a479742fa0e7f32360ad2ae7
      https://github.com/bluez/bluez/commit/94c4f445af66c553a479742fa0e7f32360ad2ae7
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-04-05 (Fri, 05 Apr 2024)

  Changed paths:
    M profiles/input/input.conf
    M profiles/input/manager.c

  Log Message:
  -----------
  input.conf: Change IdleTimeout unit to be in seconds

This changes IdleTimeout unit to be in seconds instead of in minutes
which offer better granularity.


  Commit: c6dea886985e37e2380166fe8a49494fa695e660
      https://github.com/bluez/bluez/commit/c6dea886985e37e2380166fe8a49494fa695e660
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-04-05 (Fri, 05 Apr 2024)

  Changed paths:
    M profiles/input/device.c

  Log Message:
  -----------
  input/device: Add replay support

This adds replay support when uhid is in use and the input node is keep
while disconnected:

Fixes: https://github.com/bluez/bluez/issues/777


  Commit: 7604a577c9d7bf15c9144b8154842ce277afec90
      https://github.com/bluez/bluez/commit/7604a577c9d7bf15c9144b8154842ce277afec90
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-04-08 (Mon, 08 Apr 2024)

  Changed paths:
    M monitor/att.c
    M src/gatt-database.c
    M src/settings.c
    M src/shared/gatt-client.c
    M src/shared/gatt-db.c
    M src/shared/gatt-db.h
    M unit/test-gatt.c

  Log Message:
  -----------
  shared/gatt-db: Fix gatt_db_service_insert_characteristic

gatt_db_service_insert_characteristic shall not attempt to insert the
characteristic attribute handle on the next available index as there
could be descriptors in between so this changes the way
get_attribute_index calculates the index based on the given handle to
properly skip indexes used by descriptors.


Compare: https://github.com/bluez/bluez/compare/98bed16d254c...7604a577c9d7

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
