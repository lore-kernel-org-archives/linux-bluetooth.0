Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9103B3888
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2026 16:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784134709; cv=none; b=G7GNp24gv8fwoSkdvLwvNFvJHzxduO6A3B/h+85Rhoj27PzTc1QbIq3iT/NgpAcHQaZwFEK5wIRb9IVh5o0FUoQB62c2tWrRCTbZElLxLr+AStNGzOZGxLTs4MZyW0PfRg0IjOjChmYBzFd465TdYqdzzSNGteTYy2UdeeiuCm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784134709; c=relaxed/simple;
	bh=qLivqnPAXUO8qNIiXVHPRcoMaEOI8RQTWbC90Dkshxk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=NUarTdPMMOcxOgHd8ZXSYB180Cg756nY2Zcj1WgMUdrlUMcg9tAbHqWHQZIrfSsi3eEmr6R7nF9xzpKjil+qcQNRugV1Blv3mkoblniP+Voyul/iA0Omx40LdxYCjxY7xgJ2n6yI6jyrOCWTI/0DcCrIoT0A65Yqsjw2AdktMN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=gyJihjXt; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="gyJihjXt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1784134706;
	bh=wa64JUcZ8P3uzMf5/5lm5SGNZZ5v2WtQuSoSRpZO3cE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=gyJihjXt5CRtTVItaCkt/g1Fp50EWicBm3otCISKlh9En//0X1/n33YOOy9sEteA8
	 U02gffinMgYCsLUbneXG/YdwSpgknMEx1/CCCmkMZPJlSer5ZimHn39TR8TNokqs3d
	 hpLlm1KLJPAEhVeIGpAJDab3eIzt6P6Xtk4nY91s=
Received: from github.com (hubbernetes-node-17fa618.ac4-iad.github.net [10.52.149.47])
	by smtp.github.com (Postfix) with ESMTPA id 210FB941284
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2026 09:58:26 -0700 (PDT)
Date: Wed, 15 Jul 2026 09:58:26 -0700
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1128272/000000-758541@github.com>
Subject: [bluez/bluez] 758541: profiles/audio: fix UAF on external media
 service ...
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

  Branch: refs/heads/1128272
  Home:   https://github.com/bluez/bluez
  Commit: 75854126b5d17c81e1fc127ca2914711a0b60004
      https://github.com/bluez/bluez/commit/75854126b5d17c81e1fc127ca2914=
711a0b60004
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-07-15 (Wed, 15 Jul 2026)

  Changed paths:
    M profiles/audio/media.c

  Log Message:
  -----------
  profiles/audio: fix UAF on external media service teardown

Keep media_app endpoint/player queues in sync with object lifetime to
avoid stale pointers during proxy removal.

When admin allowlist reapply removes audio services, endpoint/player
objects may be destroyed through non-proxy paths first.
Later proxy_removed_cb calls queue_remove_if() and matching by path
can dereference freed endpoint/player memory.

Fix by:
- adding media_app back-references in media_endpoint/local_player
- unlinking from app queues inside media_endpoint_remove or
  local_player_remove
- setting ownership when app-registering endpoint/player objects

This prevents heap-use-after-free in match_endpoint_by_path or
match_player_by_path during service disconnect.

Assisted-by: GPT:GPT-5.3-Codex



To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
