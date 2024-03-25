Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECEC1946C
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 Mar 2024 19:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711395122; cv=none; b=oz6LWU36artIaAOUtgbojI5m/SU1qZ7vC+dpPSW1aa9YdxWxalK3PhX9XaTjGEC59z9FNXIAqGi+I7N63tXFvQhF1p8rXg5CJCIQe+FNxnqWTbu84DbYk2OZVfeeRunk5XGXC7vA7oKJIJ8yvQ4T2BhrbWa6pbBnvHLG0usU5p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711395122; c=relaxed/simple;
	bh=vKk6xUWIgIzl/HAu5Qosp84BMNLvwG/A4s+f9JdBbX8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=DTu25HY+MQ2OPuAwTH36YlfkAwJEVUTwZ3Pa7mLbkR59LtaK9ORF3LQE3cVKIWGuKWmh7wbKiJMsp5XPKWyBpASBj1lnloeA6/QpYAqEBxh5zz6y+T4QdadPLciuLkNQWi+74a6pMP+p6frJpjPXJ7u+QWE7F5OiH25Cxd0rCJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=hTK1GsOt; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="hTK1GsOt"
Received: from github.com (hubbernetes-node-98a4582.va3-iad.github.net [10.48.209.81])
	by smtp.github.com (Postfix) with ESMTPA id 68A2C4E110F
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 Mar 2024 12:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1711395120;
	bh=5UO8t/b4j6qZB+Z9m+yUcNUrdc9bJEDganY8bFn7NXQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=hTK1GsOtEFUM10Di6TISOPocr58Z7ozDe+Y/oc1AjGb8A3JRU5meSD0B8aL5eH4X+
	 MmmE16wOL4pRqW/WIMawkhKUttabv+lNNAy+jn0MGjguAoHqO5trTgFz7eMC1+2EqD
	 xXP0I0EU0W6AA9J4bm4I+5QK5WfLsCKgbYs4Vp+g=
Date: Mon, 25 Mar 2024 12:32:00 -0700
From: howardchungg <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/87cabb-150bd6@github.com>
Subject: [bluez/bluez] 745450: bap: Fix setting adapter address type for
 unicast
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
  Commit: 74545026520a35c48349796246b6423285e10b0a
      https://github.com/bluez/bluez/commit/74545026520a35c48349796246b6423285e10b0a
  Author: Vlad Pruteanu <vlad.pruteanu@nxp.com>
  Date:   2024-03-25 (Mon, 25 Mar 2024)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: Fix setting adapter address type for unicast

This fixes the settin of the adapter address type for unciast
scenario. Currently the address type is searched in data->adapter
however, this pointer is null and leads to the crash listed at the
end of this message. Instead, the address type should be taken from
the adapter variable, which is initialised using device_get_adapter
at the beggining of the function.

==321444==ERROR: AddressSanitizer: SEGV on unknown address 0x000000000016
(pc 0x5601d284e03e bp 0x000000000016 sp 0x7ffdb164b740 T0)
==321444==The signal is caused by a READ memory access.
==321444==Hint: address points to the zero page.
0 0x5601d284e03e in btd_adapter_get_address_type src/adapter.c:545
1 0x5601d27a3f78 in setup_connect_io profiles/audio/bap.c:1860
2 0x5601d27a3f78 in setup_create_ucast_io profiles/audio/bap.c:2053
3 0x5601d27a3f78 in setup_create_io profiles/audio/bap.c:2106
4 0x5601d27a57cd in bap_state profiles/audio/bap.c:2143
5 0x5601d29d30df in bap_stream_state_changed src/shared/bap.c:1250
6 0x5601d29d71e2 in bap_ep_set_status src/shared/bap.c:4395
7 0x5601d293d592 in queue_foreach src/shared/queue.c:207
8 0x5601d2975c84 in notify_cb src/shared/gatt-client.c:2257
9 0x5601d2964217 in handle_notify src/shared/att.c:1012
10 0x5601d2964217 in can_read_data src/shared/att.c:1096


  Commit: 150bd6e81b3578290d71197b6fde4d26e06ea6e3
      https://github.com/bluez/bluez/commit/150bd6e81b3578290d71197b6fde4d26e06ea6e3
  Author: Yun-Hao Chung <howardchung@google.com>
  Date:   2024-03-25 (Mon, 25 Mar 2024)

  Changed paths:
    M src/advertising.c

  Log Message:
  -----------
  Advertising: Emit features property update

Advertising manager has some properties that relies on kernel
information. Once we received the information from kernel, we should
emit property update.


Compare: https://github.com/bluez/bluez/compare/87cabb267935...150bd6e81b35

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
