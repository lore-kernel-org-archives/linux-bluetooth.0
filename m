Received: from out-44.smtp.github.com (out-44.smtp.github.com [192.30.252.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616534E9C1D
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2026 20:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789675493; cv=none; b=kEibd2DI7rJHGWe4FLPtNXTPkjGag8dfNUqZtC3un+5RhXHPlXsFzb2SxXsITbeIv4J1Yn1ox3NcHz9F6B2wzn3d8K7hkvVzKUMwCUXr+YJHyJF/Gi8n08zyQ6vcOS6gz63h+Eql/7oeP2xeK2h60YBWSTyIkc3PgB0b/1jVQGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789675493; c=relaxed/simple;
	bh=nYHddoNLE0Y+iTLN6gJts05a0WC8/yDkdJXTgWuEfvM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Pc/weh2IqbcDADR6P7/ifQj7rEkpabmaTeJ3g7PJ+HVg5YOjny5LUxgrHe92gtBqOiw9nM2qs7JSBhnkkLIcHuI/QnHndGbzbTuMvD8+x3FZhbYgwP6kyjj6vAoFt/ke7ISrnn+mSwffJxwHP3zfBgAT16CrvZLtj3WORFfDY7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=IHKeuje8; arc=none smtp.client-ip=192.30.252.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="IHKeuje8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1789675490;
	bh=4x+MO7eo1g6x3GmC2nllrxFbfp6HV7GvEh1OKCcQ5Ew=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=IHKeuje8D1vASgjBdwZt9cw1+XWvRujVoZnrd0pFlyVgk6HfOhw4RAB/KZPaVOhcj
	 +gyyOrhW8s4PSayqFfrLtooA6hY9R4PwaVU3WAvoJcV0y2EMevNx47ORNNOhxSoErf
	 mWA/QzARsG2nxnGOfC6c+qb4u1lNc0YfJYOIC5QA=
Received: from github.com (hubbernetes-node-2aa5d28.ash1-iad.github.net [10.56.131.73])
	by smtp.github.com (Postfix) with ESMTPA id 695E18404C0
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2026 13:04:50 -0700 (PDT)
Date: Thu, 17 Sep 2026 13:04:50 -0700
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1167962/000000-c4dc92@github.com>
Subject: [bluez/bluez] b4e19d: shared/bap: Skip local metadata Config
 callbacks
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

  Branch: refs/heads/1167962
  Home:   https://github.com/bluez/bluez
  Commit: b4e19d5f2c4274f8a940de8dca1f61f75da8e5d0
      https://github.com/bluez/bluez/commit/b4e19d5f2c4274f8a940de8dca1f61f75da8e5d0
  Author: Derek Tern <1263187-dt@users.noreply.gitlab.freedesktop.org>
  Date:   2026-09-17 (Thu, 17 Sep 2026)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Skip local metadata Config callbacks

When reconfiguring a client stream that is already Codec Configured,
setup_config() queues Codec Configuration and then caches metadata.
stream_metadata() emits a same-state CONFIG notification for that local
update. The profile callback treats it as the peer's configuration
completion and clears config_pending before the peer has responded.

If the control point response precedes the ASE state notification, QoS
setup can run while need_reconfig is still set and fail locally.

Cache client metadata in CONFIG without emitting a state notification.
Keep genuine peer CONFIG notifications and server metadata handling
unchanged.


  Commit: d1ee415b32bf5ae2329aa28c3c0748e93d0ae8c9
      https://github.com/bluez/bluez/commit/d1ee415b32bf5ae2329aa28c3c0748e93d0ae8c9
  Author: Derek Tern <1263187-dt@users.noreply.gitlab.freedesktop.org>
  Date:   2026-09-17 (Thu, 17 Sep 2026)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client: Pass unicast preset metadata to config

Custom presets retain metadata, but endpoint.config copies only their
codec capabilities and QoS into SetConfiguration. Copy the metadata too,
and free configuration buffers on completion and immediate failure.


  Commit: c4dc9259521ad274cf200079316f51077b462edf
      https://github.com/bluez/bluez/commit/c4dc9259521ad274cf200079316f51077b462edf
  Author: Derek Tern <1263187-dt@users.noreply.gitlab.freedesktop.org>
  Date:   2026-09-17 (Thu, 17 Sep 2026)

  Changed paths:
    M doc/functional-bap.rst
    M test/functional/test_bap.py

  Log Message:
  -----------
  test-functional: Cover BAP metadata reconfiguration

Reconfigure both unicast streams using custom presets with empty or
Media metadata at ATT MTU 64. The second Configured notification arrives
separately, exposing premature QoS setup from a local metadata callback.

Check that old transports disappear, both replacements retain their
codec configuration and metadata, and both can be acquired.

Remove the fixture's redundant configuration command: SelectProperties
already configures both streams after pairing.


Compare: https://github.com/bluez/bluez/compare/b4e19d5f2c42%5E...c4dc9259521a

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
