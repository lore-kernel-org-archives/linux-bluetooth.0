Received: from out-5.smtp.github.com (out-5.smtp.github.com [192.30.252.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC8E21018A
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 May 2026 08:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777970014; cv=none; b=EjywQ5bNbY8w4DTy2u0qTijRvTtDFOJ1UtvdOllHiRL3wDNBfFOIerRLn+7lKesgi4/DYQu5GI3+tMAiECi3A7UYosBf6ZR5WOctBO8d39cCeT46XauVg4bKzbi5b58UbBeMVxufsEgXOc8xWC1muNjT4irEhNbqNK0PyWrEluo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777970014; c=relaxed/simple;
	bh=WDY6ruCZ7g4/H1xL3s6kVavhtAaU7mwBBwq6yIkjywE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=PMuEpGR5RbdywslngO+E/Sl08wjHTYpschp9G1Zmp+GlGmNqbEPB3kV/4EYy9onGE8ifpRYq4fNYP+vJYGCcteNriZI221Z0KUu3YxjQJBFX+VKdiBJWYLmHqLJEhjvHVxsFVd9ZACm27nZZGOA4kD/Xar7IvautYI4dj5cOr3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=bMxkZ+rV; arc=none smtp.client-ip=192.30.252.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="bMxkZ+rV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1777970012;
	bh=LRA4I40ZJsay3gNaPDkkehdG/IFa5b1Q0vSa9Vq6wWo=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=bMxkZ+rV/Gdz6QPvwEuO9KVZYrJsH8LoRs0NdCJLGLHrAkg9kvn9V6qE5c9oIbJSE
	 GWMXPQayWtabWgINhHhVwMk8RMcr8iIqM6bhfuDuV1jv0KqX954GXJTdhoQG6k00jM
	 HzywIRIWhgqwL22LsJBcoW/0QE7nZFo5qFBzT2AE=
Received: from github.com (hubbernetes-node-a5d2e72.va3-iad.github.net [10.48.124.72])
	by smtp.github.com (Postfix) with ESMTPA id 18461780FBC
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 May 2026 01:33:32 -0700 (PDT)
Date: Tue, 05 May 2026 01:33:32 -0700
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1089698/000000-79975d@github.com>
Subject: [bluez/bluez] 897689: mpris-proxy: Fix possible crash
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

  Branch: refs/heads/1089698
  Home:   https://github.com/bluez/bluez
  Commit: 897689ffe9c0ac36fbd508b9d754a557d1ee84be
      https://github.com/bluez/bluez/commit/897689ffe9c0ac36fbd508b9d754a557d1ee84be
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


  Commit: 79975d8d2f524ad50eb840c5137eb80a45aa6ea8
      https://github.com/bluez/bluez/commit/79975d8d2f524ad50eb840c5137eb80a45aa6ea8
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-05-05 (Tue, 05 May 2026)

  Changed paths:
    M tools/mpris-proxy.c

  Log Message:
  -----------
  mpris-proxy: Avoid session->obex dereference

Protect against trying to access session->obex variable that might be
null after failure to create the session object.


Compare: https://github.com/bluez/bluez/compare/897689ffe9c0%5E...79975d8d2f52

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
