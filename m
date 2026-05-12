Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15B53CE48F
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 May 2026 11:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778585383; cv=none; b=cRAKaZegnxKTIvNZ5Z7kyAq1x1NXjgyyciqoPS8cI/9NrXYlAJwbI79A2pXeEkLfkeiFmZcnXmWKAFsjNtg1ILUysJMlLrNsQ2t01/TBnAK5MMl8zzmTtLzDOwIzkDQSTByTCCFbV3IYxDUE19665z1oY0NoUCjlkpYZfCp5jFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778585383; c=relaxed/simple;
	bh=92VUI+v4FAUApk6yUbX28pXNJA5xhT2pY/NywYejOas=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=gsmDWpnnG0oXdOF+Bg4cJilrJm7gu3ftjwcukRJT/Nr7LjqKuBLjdQGVX7AYgVd9ysE0fvRgPo2QTqmOFmdj8XRSHotSAna9mLeJl109CG3IhP/8yaW30st9MlfNkwI3NS6vbQYQgZMIyowLYS8pEWkj0vTCS0dTzRaC/HYccko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=RNGujEUJ; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="RNGujEUJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1778585381;
	bh=5+TtMrCMLCZu0ya+Z2ATIvAq0J/P6bKsoRMM3ZXRPns=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=RNGujEUJ4IcZTPtxTcWi0JGw772jndsAK8FxZl2BEiD18mY1Y8KmFKMPBwJUbS8S9
	 rd5rr/6+MHcl8GBqKe6+OMsib/OmuCsJzXfUSFW55Pci5KofZqoGc6vPGT2o8EHe3l
	 2QKPjuRJ2CZCR83GvBjmWMoRwWM19cARFmVp4yiQ=
Received: from github.com (hubbernetes-node-7a39a72.ac4-iad.github.net [10.52.210.21])
	by smtp.github.com (Postfix) with ESMTPA id 149CA78110E
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 May 2026 04:29:41 -0700 (PDT)
Date: Tue, 12 May 2026 04:29:41 -0700
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1093445/000000-c915f8@github.com>
Subject: [bluez/bluez] c915f8: media: Fix possible crash on exit/adapter
 removal
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

  Branch: refs/heads/1093445
  Home:   https://github.com/bluez/bluez
  Commit: c915f8eb390fba5588ce1425025d4a4274a3fbed
      https://github.com/bluez/bluez/commit/c915f8eb390fba5588ce1425025d4a4274a3fbed
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-05-12 (Tue, 12 May 2026)

  Changed paths:
    M profiles/audio/media.c

  Log Message:
  -----------
  media: Fix possible crash on exit/adapter removal

Nothing protects media_endpoint_remove() from being called multiple
times for the same structure. Before a g_free() call is made on
endpoint->capabilities, there are NULL checks, and NULL setting,
for every variable that might get modified, so a second call to the same
function, even though it's still using-after-free, is only
reading-after-free, and might crash at the first attempt at modifying
that freed memory.

The reason why this function might be called multiple times is because
in some circumstances, another signal might be received that the
endpoint is getting removed while we're already in the process of
removing that endpoint.

For example, release_endpoint() (which should appear in between
path_free() and media_endpoint_remove() in the below backtrace, as
that's the function called at profiles/audio/media.c:3651), will send a
D-Bus message which it then waits for the answer to, meaning that other
D-Bus message could be received while we're waiting for the answer, and
then destroying the endpoint.

 #11 media_endpoint_destroy at profiles/audio/media.c:231
 #12 media_endpoint_remove at profiles/audio/media.c:314
 #13 path_free at profiles/audio/media.c:3651
 #14 remove_interface at gdbus/object.c:742
 #15 g_dbus_unregister_interface at gdbus/object.c:1499
 #16 g_slist_foreach at ../glib/gslist.c:837
 #17 unload_drivers at src/adapter.c:5932
 #18 adapter_remove at src/adapter.c:7088
 #19 adapter_unregister at src/adapter.c:9504
 #20 index_removed at src/adapter.c:10693
 #21 queue_foreach at src/shared/queue.c:207
 #23 process_notify at src/shared/mgmt.c:349
 #24 can_read_data at src/shared/mgmt.c:409
 #25 watch_callback at src/shared/io-glib.c:173
 #27 g_main_context_dispatch_unlocked at ../glib/gmain.c:4451
 #28 g_main_context_iterate_unlocked at ../glib/gmain.c:4516
 #30 mainloop_run at src/shared/mainloop-glib.c:65
 #31 mainloop_run_with_signal at src/shared/mainloop-notify.c:196

in profiles/audio/media.c:
 231         g_free(endpoint->capabilities);

See https://bugzilla.redhat.com/show_bug.cgi?id=2467980



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
