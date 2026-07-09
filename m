Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D25386C10
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Jul 2026 14:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783605813; cv=none; b=Rplixe5nAVHWr3iogjRCjUUvhiVWSUQ2hf3jiME/yOHgFAu7IDLctvzAcnx8vb6N3M9xnxmqR0iVnpxumftUW10NkqQ7SFBGXkSok926o83kHjNpvU4qTSOpq2FudfCVqejATxb45E3U8Zz/uRoi5gEZTbyoLSJixoTgBKc3yAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783605813; c=relaxed/simple;
	bh=k+0lApXVxwHCm8StKodNgSLqxq2wx/aOQ+yOyy/bTUM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=mXDprBI30ZbQvXfo3QLOONz0Z9LBiOngwHvVVMbbuVZdE1tLRI20Rb5VT53UxrlrtwTju/KCBeoxSSjBmPTv1OklFdJ9VuppsTx8UYWXk2TN/Cox2LmZFpK8w/E7uDGa5cWQFLnsP1jmwAAK+ppNvAoSXfSIrZONuVUnFjUjlMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=XEyhAROV; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="XEyhAROV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1783605811;
	bh=KrrgsKR7tow9j61KWMnhv+mvMJ+ZladxGaj5N52yZeY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=XEyhAROV/iw9hYGmrjLcf4E7ovPCBEhuC6qtis+obzA2sv3iutSfhmfaSCD2pN+4R
	 nstXaEzRaRZ2Rc53l+P39qm5fXOZERi46o9KxsJCleda73AZtPobqkH/17YDLgA60+
	 myeP3s2OnM70GZpjIBaw7pLG+Rc3S3AJQcVPlGJY=
Received: from github.com (hubbernetes-node-a33287e.ash1-iad.github.net [10.56.189.50])
	by smtp.github.com (Postfix) with ESMTPA id BE5F4360851
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Jul 2026 07:03:31 -0700 (PDT)
Date: Thu, 09 Jul 2026 07:03:31 -0700
From: Tom Catshoek <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1124682/000000-48278c@github.com>
Subject: [bluez/bluez] 48278c: adapter: Fix crash on UUID discovery filter
 match
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

  Branch: refs/heads/1124682
  Home:   https://github.com/bluez/bluez
  Commit: 48278c8a0ecf28a2c51f091dc86cc350457125b6
      https://github.com/bluez/bluez/commit/48278c8a0ecf28a2c51f091dc86cc350457125b6
  Author: Tom Catshoek <tomcatshoek@zeelandnet.nl>
  Date:   2026-07-09 (Thu, 09 Jul 2026)

  Changed paths:
    M src/adapter.c

  Log Message:
  -----------
  adapter: Fix crash on UUID discovery filter match

is_filter_match() looks up each discovery-filter UUID in the queue of
services parsed from a device advertisement. When that services list was
migrated from a GSList to a struct queue, the queue_find() call kept
GLib's g_slist_find_custom() argument order, passing the UUID string
where queue_find() expects a match function and the comparison function
where it expects the match data.

As a result queue_find() calls the UUID string as if it were a function,
jumping into non-executable heap and crashing bluetoothd with SIGSEGV as
soon as an advertisement matches a UUID filter configured via
SetDiscoveryFilter.

Add a queue_match_func_t helper and pass the arguments in the correct
order.

Fixes: https://github.com/bluez/bluez/issues/2282



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
