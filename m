Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BC81D53C
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 Mar 2024 03:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711423940; cv=none; b=FESr3JqSBW5uGIqLmJZPC/ikdshGI3+vdNTDUXrL5dVRwlvoe9TsGYU/hDW135LwCz3u8/LQJgVABkQ8vpPYLd6Rt7TRExSbpPY82mHfxnS0WWi1MNDwLgNlTUb+XNc+7FZSDwC/6OMVGfuvggczuP3s32y7WOWtUFyP0B996iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711423940; c=relaxed/simple;
	bh=qpBlFUnLsWrGa4M+7F/kKGgqRFtNm61ACE4heMSYxlU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=GLrDiClrlZCijRTUJ3F0BvovdgXgFdKhadqGIwhJ57b3B1pOiOt+KUMF95CVFNUz3wzTk5mOoFjiPLIBvK+P4gEmjHBcl8nbzKwOK28/VDvkPnShKp9mFxf8J+fHATBW9C6oLKIE7Oc9qCgu7tg6quxF8mIYm3+rgoAzXikwf9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=MqIFXV34; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="MqIFXV34"
Received: from github.com (hubbernetes-node-d499c0e.ash1-iad.github.net [10.56.15.25])
	by smtp.github.com (Postfix) with ESMTPA id D1B536005EF
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 Mar 2024 20:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1711423937;
	bh=iyi7KpXD0xFyqxbKA45GjHZlVUZ7fyKEtHpAtsG1BNE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=MqIFXV34pRjNMlc3dRli5YivseVB3niEfR6GIzNUrDEzCyEPIErxmVk1EbWLmYHEV
	 F9rpCWdTRyJJ16Kz60qAhHezqDUwHS+549ZPuhAZOt3ejHOTugzlmMf2QK6zmqKWa/
	 LIGq0i7R0IYIS/TcjAO0rsDdEqujaVMo0gaEdP9c=
Date: Mon, 25 Mar 2024 20:32:17 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/150bd6-41d6c4@github.com>
Subject: [bluez/bluez] 6849c6: shared/bap: add bt_bap_cancel_select to cancel
 ong...
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
  Commit: 6849c64e1fdbed0c18439878151dc19adcc7be2b
      https://github.com/bluez/bluez/commit/6849c64e1fdbed0c18439878151dc19adcc7be2b
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2024-03-25 (Mon, 25 Mar 2024)

  Changed paths:
    M src/shared/bap.c
    M src/shared/bap.h

  Log Message:
  -----------
  shared/bap: add bt_bap_cancel_select to cancel ongoing pac select

Add function and PAC ops for canceling a previously initiated
SelectProperties() call.


  Commit: 41d6c4e1c92fc6e0757b0f71ca5062671ff55235
      https://github.com/bluez/bluez/commit/41d6c4e1c92fc6e0757b0f71ca5062671ff55235
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2024-03-25 (Mon, 25 Mar 2024)

  Changed paths:
    M profiles/audio/bap.c
    M profiles/audio/media.c

  Log Message:
  -----------
  bap: cancel ongoing SelectProperties() before freeing the ep

select_cb() callback is called when the sound server replies. However,
at that point the ep or session for which it was made may already be
gone if e.g. device disconnects or adapter is powered off.

Fix by implementing cancelling select() callbacks, and doing it before
freeing ep.

Fixes crash:

==889897==ERROR: AddressSanitizer: heap-use-after-free
READ of size 8 at 0x60400006b098 thread T0
    #0 0x55aeba in setup_new profiles/audio/bap.c:840
    #1 0x562158 in select_cb profiles/audio/bap.c:1361
    #2 0x47ad66 in pac_select_cb profiles/audio/media.c:920
    #3 0x47661b in endpoint_reply profiles/audio/media.c:375
    ...
freed by thread T0 here:
    #0 0x7fd20bcd7fb8 in __interceptor_free.part.0
    #1 0x55f913 in ep_free profiles/audio/bap.c:1156
    #2 0x7d696e in remove_interface gdbus/object.c:660
    #3 0x7de622 in g_dbus_unregister_interface gdbus/object.c:1394
    #4 0x554536 in ep_unregister profiles/audio/bap.c:193
    #5 0x574455 in ep_remove profiles/audio/bap.c:2963
    #6 0x7f5341 in queue_remove_if src/shared/queue.c:279
    #7 0x7f5aba in queue_remove_all src/shared/queue.c:321
    #8 0x57452b in bap_disconnect profiles/audio/bap.c:2972
    #9 0x6cd107 in btd_service_disconnect src/service.c:305
    ...
previously allocated by thread T0 here:
    #0 0x7fd20bcd92ef in malloc
    #1 0x7f6e98 in util_malloc src/shared/util.c:46
    #2 0x560d28 in ep_register profiles/audio/bap.c:1282
    #3 0x562bdf in pac_register profiles/audio/bap.c:1386
    #4 0x8cc834 in bap_foreach_pac src/shared/bap.c:4950
    #5 0x8cccfc in bt_bap_foreach_pac src/shared/bap.c:4964
    #6 0x56330b in bap_ready profiles/audio/bap.c:1457
    ...


Compare: https://github.com/bluez/bluez/compare/150bd6e81b35...41d6c4e1c92f

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
