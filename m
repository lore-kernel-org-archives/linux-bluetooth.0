Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47F930216D
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 May 2026 11:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777981296; cv=none; b=FUy2u+qK0YeI9uWtPqQ8LtdOZZKMXJis7G717r8h+SshBujyYPbAkN3yL9eQe1Ugv7lQeRksn+tL94HWOsxELrDJ5cmGNpQ1NGQcYIVKQqq5WtFtkSm1RRK0XyIkjm0yAmb3DZk3YYRN3NeZo7FuNtwaReHJjkIhx7x41x6UvRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777981296; c=relaxed/simple;
	bh=zr9spUj0ymRMR52+69d318czWg2ygG4OCElTW8zmE8Y=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=jJGlW+jpo9yIcsA274IHJB91Gx8DiNEVNOYSyqf+oSxHgLUSAmYGIB71HuIQKNiUp1NfTrrvz1G889ZRHOZatthbXwPNBIpU9lsctUNWwZASVCN6IvQ/SZ+FN1R5mN3P2nZRJG6WAn2Z/vML2n8dTUo5MNIgMZo3X8y3Mct75r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=ii1B4d2u; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="ii1B4d2u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1777981295;
	bh=QGuKubXY3UkNIfyDLcbT3rpDT/qmtfciLub58NumtTY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ii1B4d2uKoKMfmG/Tbcv/6jteyayf6IFTS34vFvUExjkjI+HBqqJJdipzgN0rHW5E
	 gcz3mbOuK5Fb6PYCg4siIGFRCxp7ntqjLuHYGEUVyxm2v+0xkC2KlfoMOoHCF+6hnx
	 RP0Ss2GcmSMCzhERGqTzngoVixLWzP3SmZy8ZBLE=
Received: from github.com (hubbernetes-node-33a0412.ash1-iad.github.net [10.56.192.51])
	by smtp.github.com (Postfix) with ESMTPA id 0AB73361197
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 May 2026 04:41:35 -0700 (PDT)
Date: Tue, 05 May 2026 04:41:35 -0700
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1089833/000000-5e18ca@github.com>
Subject: [bluez/bluez] c769d9: mpris-proxy: Fix possible crash
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

  Branch: refs/heads/1089833
  Home:   https://github.com/bluez/bluez
  Commit: c769d9067d1ae278388d81103e7ede3d921c9fed
      https://github.com/bluez/bluez/commit/c769d9067d1ae278388d81103e7ede3d921c9fed
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-05-05 (Tue, 05 May 2026)

  Changed paths:
    M tools/mpris-proxy.c

  Log Message:
  -----------
  mpris-proxy: Fix possible crash

find_player_by_obex() doesn't check whether session->obex is a valid
pointer before dereferecing it, but all code paths that assign it use
create_obex_session() to assign it, a function that can fail.

Check whether session->obex is null before dereferencing it.

 #0 find_player_by_obex at tools/mpris-proxy.c:2819
 #1 obex_property_changed at tools/mpris-proxy.c:2929
 #2 add_property at gdbus/client.c:373
 #3 update_properties at gdbus/client.c:399
 #5 properties_changed at gdbus/client.c:537
 #6 signal_filter at gdbus/watch.c:416
 #7 message_filter at gdbus/watch.c:566
 #10 message_dispatch at gdbus/mainloop.c:59
 #13 g_main_context_dispatch_unlocked at ../glib/gmain.c:4451
 #14 g_main_context_iterate_unlocked at ../glib/gmain.c:4516

Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2466640


  Commit: 5e18ca222abc7a7744fe9f2d47cf2f6cb8efb191
      https://github.com/bluez/bluez/commit/5e18ca222abc7a7744fe9f2d47cf2f6cb8efb191
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-05-05 (Tue, 05 May 2026)

  Changed paths:
    M tools/mpris-proxy.c

  Log Message:
  -----------
  mpris-proxy: Avoid session->obex dereference

Protect against trying to access session->obex variable that might be
null after failure to create the session object.


Compare: https://github.com/bluez/bluez/compare/c769d9067d1a%5E...5e18ca222abc

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
