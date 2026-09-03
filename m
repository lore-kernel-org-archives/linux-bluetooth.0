Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF34390CAA
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Sep 2026 23:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788477211; cv=none; b=neqXwhSP5KFiIW0Gkq35m6t+oxFgoA9HXFNG/QOoO3X9+OtNOOnZSYIwNVu0T2jOIxlOkr70nJxEsOiaktTsYXSa5GQrvH4RoEKmBLob/di9LOz/+7XsfAIG55Uk0mPpd6Nc79L6g+FapIVmaeaTmEx/ye7dLSvThN8nbnP5ZZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788477211; c=relaxed/simple;
	bh=HNKbxE+4VPXTbNfgY72NVokT/L4X/x5HBEL3ppahaik=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=SedVCCJwGOMpZQExSwym9TW34bpOjvmLXuNuDssT0pzPKvsDer2/STIMbJpJ++L8qFEFLeq1c6rJmAtUhvx0lxH/4SZ2kNvQ4zOUplI47ymFJmeJVOnTM0zCmvmwXBNUUvMU615aaRDs7Kgp+bc5h+q5rgyaPC0LUSZPJShUa+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=iT6px+yi; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="iT6px+yi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1788477208;
	bh=i8LnsEu2WYbkPe3vnD1Ym5iFgqbHdiUV3ZVJXdaVVjg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=iT6px+yig4zw+WB1IP3dUBMEJ5e4KyiIeRXNWv8sv4QB5fFtmiZjBpz3XnITQWmI8
	 YoPM+FiyMRCXHRJ83+Euh8WXiAbnMaBxWL+KMnG7ejGd/5ggzneWywt2+FneFv17Bp
	 00u9gHHVCEnt+oH4+tvxOyffGX0wYwG7FGN/RGqw=
Received: from github.com (hubbernetes-node-ee4f0e2.ash1-iad.github.net [10.56.207.112])
	by smtp.github.com (Postfix) with ESMTPA id 82FFC36101E
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Sep 2026 16:13:28 -0700 (PDT)
Date: Thu, 03 Sep 2026 16:13:28 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1157432/000000-37b825@github.com>
Subject: [bluez/bluez] 37b825: adapter: clear discovery_found list before
 discove...
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

  Branch: refs/heads/1157432
  Home:   https://github.com/bluez/bluez
  Commit: 37b825c7d0206b7662f3d1663245660f2493bd85
      https://github.com/bluez/bluez/commit/37b825c7d0206b7662f3d1663245660f2493bd85
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-09-03 (Thu, 03 Sep 2026)

  Changed paths:
    M src/adapter.c

  Log Message:
  -----------
  adapter: clear discovery_found list before discovery_cleanup()

discovery_cleanup() tries to reset RSSI of devices in
adapter->discovery_found list.  When called from adapter_remove(), the
list contains only stale pointers as devices have been already freed,
leading to UAF.

Fix by freeing the discovery_found list in adapter_remove().

Fixes AddressSanitizer: heap-use-after-free
READ of size 1 at 0x7d5b585e033d thread T0
    #0 0x000000772b1a in device_set_rssi_with_delta src/device.c:7121
    #1 0x000000772daa in device_set_rssi src/device.c:7150
    #2 0x0000006aa808 in invalidate_rssi_and_tx_power src/adapter.c:1732
    #3 0x7feb5a35557f in g_slist_foreach (/lib64/libglib-2.0.so.0+0x6257f)
    #4 0x7feb5a355b56 in g_slist_free_full (/lib64/libglib-2.0.so.0+0x62b56)
    #5 0x0000006f67d2 in discovery_cleanup src/adapter.c:1747
    #6 0x0000006f904f in adapter_remove src/adapter.c:7219
    #7 0x0000006f9de2 in adapter_cleanup src/adapter.c:11165
    #8 0x000000418ca9 in main src/main.c:1719

freed by thread T0 here:
    #0 0x7feb5a5434cf in free.part.0 (/lib64/libasan.so.8+0xee4cf)
    #1 0x7feb5a337bb4 in g_free (/lib64/libglib-2.0.so.0+0x44bb4)
    #2 0x0000007519d7 in device_free src/device.c:963

previously allocated by thread T0 here:
    #0 0x7feb5a54424f in calloc (/lib64/libasan.so.8+0xef24f)
    #1 0x000000751fee in device_new src/device.c:4963



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
