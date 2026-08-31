Received: from out-32.smtp.github.com (out-32.smtp.github.com [192.30.252.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4CA345EDB
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 15:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188681; cv=none; b=kSRyOF0qDld0c7teaF80KlEZTQ5e4cMPcPf6fiXnkCdgSStRTa0a3cfyvQ3AR7L6pccoU0l7RIxsf0BUMu7Y1c+WSuDWIMYIaL40FaIh5mYNs5RT0udyr8D+G11EPAAEn5uYMvEqJNH3wowURdOILgDFChImxv52/kBcITnPKCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188681; c=relaxed/simple;
	bh=TWZXHCZ7yYQlXh59uFa9W9pc9Fy055+CbZAE7jxT4ZA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=KNKUe/gzzJNBTS+ObRxDqtJLOq+18EQwIqSQAXMmPJrLkG253PVb+/yxh6/I8JSr/px5xJUz7OpQRe02AaZEXlrPBDNXN/3XoZExqfMP1OEEs5prXN1qap1hPtxrcBOqlvGpjEZWy41+ND9WXZ2R8gq/W3dN3qxN0ww5kdc1Tcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=OlSxJvq1; arc=none smtp.client-ip=192.30.252.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="OlSxJvq1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1788188678;
	bh=fbEcZKVmjsiclD3HhG4YfCaCp3O18dgEhh+TcYzucWI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=OlSxJvq12XExKKnSGLjGhtJcb4JWp7YkMXPnZrf4Wo2JKQhC5tnXtGpmbef+PVq5w
	 AP5FHS3+gIEUp6e5xpVbyZAIoPayXweCx61joqnLpQjSSa3hHFuTj3GCuoF+41hBCF
	 FdJon/aG7zgQnNHXaKr6bCTq7TEnWfsH62g3n5jQ=
Received: from github.com (hubbernetes-node-2c345fe.ac4-iad.github.net [10.52.132.23])
	by smtp.github.com (Postfix) with ESMTPA id AF574325ADE
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 08:04:38 -0700 (PDT)
Date: Mon, 31 Aug 2026 08:04:38 -0700
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1154589/000000-38f8e4@github.com>
Subject: [bluez/bluez] 38f8e4: transport: Fix use-after-free when replacing a
 lin...
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/1154589
  Home:   https://github.com/bluez/bluez
  Commit: 38f8e4dc7d4e6180501772f0e6f3dd90c9cba7aa
      https://github.com/bluez/bluez/commit/38f8e4dc7d4e6180501772f0e6f3d=
d90c9cba7aa
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-08-31 (Mon, 31 Aug 2026)

  Changed paths:
    M profiles/audio/transport.c

  Log Message:
  -----------
  transport: Fix use-after-free when replacing a linked transport's owner=


linked_transport_set_owner() unconditionally overwrote a linked
transport's owner pointer. If that transport already had a different
owner assigned (e.g. its own Acquire request was still pending when the
paired transport's owner was set), the previous media_owner was
orphaned: its D-Bus disconnect watch stayed registered and its
->transport back-pointer kept pointing at the transport. Once the
transport was later destroyed, the still-registered watch would
eventually fire media_owner_exit() and dereference the freed transport.

Tear down any pre-existing, different owner via
media_transport_remove_owner() before assigning the new one, so its
pending request is replied to, its watch is removed and the owner is
freed instead of leaked. Since media_transport_remove_owner() itself
recurses into linked_transport_remove_owner() for linked streams, also
guard linked_transport_remove_owner() so it only clears a transport's
owner when it still matches the owner being removed, preventing it
from clobbering an owner that was already reassigned during that
recursion.

Assisted-by: Claude:claude-sonnet-5



To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
