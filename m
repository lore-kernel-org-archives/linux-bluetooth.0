Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E6B435EDB
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Jul 2026 16:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783614605; cv=none; b=bzHaqMqomItf2PXrZb6nhuFNVWc224ajDLN+3cZbX63QWyOBHWdPBZ0TA8wyhUzDcdhCbOlSFbZTv30dlBkbv1lR/rhUM99K5UQLYGCHTEXd9lRJl2bAZNJwxjb/iGu1rJJi62Ys8SFJTAsoZJ10Fb7cDW+nCQ+fBKARMZNpYwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783614605; c=relaxed/simple;
	bh=7tZklapM1H/RNnJ8zFC76Yi3gHLeqMCxOj/jVlZ6HKw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=uh3xPEcWnrEqfZ1ZvTAFDxOYXdey9OFFDF0bEc0QEwdykRgTUQ7XooXURewam36UuEHZSNIjE8xAg5WuSJ2rwHMvdZi4Mg6bJKldAnF9EZug9m4fX+7xoQzdmQRPx+5AoEPVmq3dlhsDzgdsCgFuL6iUGxtkZHeuWiwhzuRnTEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=lejwSubn; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="lejwSubn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1783614600;
	bh=0x/TKhD5Hg6PQKEzFwi7Nr4v14bGQ2j2OnR/CM1V78g=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=lejwSubnccHylULW69bEEDSSbomiOX0HDtcclvhkOrdCO/DGgPbZqscpv4rjzRMTN
	 /rSqCQH5s0il2It7VWsf5/cIdf8zQeWyui8pmS69V/NuGAm6Xf/SPCu1kkY1aftSDi
	 Z3pCD4n/s0tJSfJhculMma3IDBo2YZOx/V4b+l/Q=
Received: from github.com (hubbernetes-node-a2572ec.va3-iad.github.net [10.48.143.43])
	by smtp.github.com (Postfix) with ESMTPA id 61B87281195
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Jul 2026 09:30:00 -0700 (PDT)
Date: Thu, 09 Jul 2026 09:30:00 -0700
From: Tom Catshoek <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/5c1c67-82af2b@github.com>
Subject: [bluez/bluez] 13b14d: shared/bap: Use util_ltv_foreach to process
 metadata
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
  Commit: 13b14db95089382701f54a46e6ef0120b69d4a62
      https://github.com/bluez/bluez/commit/13b14db95089382701f54a46e6ef0120b69d4a62
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-07-07 (Tue, 07 Jul 2026)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Use util_ltv_foreach to process metadata

This makes use of util_ltv_foreach to process the metadata entries
instead of attempting to iterate over the entries manually which
probably only works with the exact same order as used by PTS.


  Commit: 9e9f0a370c591c126c39225f5f50b88915d11095
      https://github.com/bluez/bluez/commit/9e9f0a370c591c126c39225f5f50b88915d11095
  Author: Rahul Samana <rahul.samana@oss.qualcomm.com>
  Date:   2026-07-07 (Tue, 07 Jul 2026)

  Changed paths:
    M gobex/gobex.c

  Log Message:
  -----------
  gobex: Fix use-after-free when cancelling SRM PUT transfer

In SRM mode put_get_data() queues the next packet during encoding of
the current one, so transfer->req_id and pending_req->id can diverge.
When g_obex_cancel_transfer() cancels the queued packet from tx_queue,
cancel_complete() frees the transfer while pending_req still holds a
callback pointing to it. Its G_OBEX_DEFAULT_TIMEOUT (10s) then fires
on freed memory causing a SIGSEGV.

Fix by clearing pending_req->rsp_func if it belongs to the same
transfer being cancelled.


  Commit: 82af2beafc39510e2c4a439bf44faea711d6503f
      https://github.com/bluez/bluez/commit/82af2beafc39510e2c4a439bf44faea711d6503f
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


Compare: https://github.com/bluez/bluez/compare/5c1c679ec304...82af2beafc39

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
