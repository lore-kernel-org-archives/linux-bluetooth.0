Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E1335CECA
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Sep 2025 20:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757450664; cv=none; b=R89jZwHv6vUvp0emszei0+PVWoCt7GwwUhZkwoqFt/t4xEWFijFFxS9BWHue7Hpb219/5lm4rHTuNvooDl20HX0LD81DrTpOs65Tv8ZRkp4ddKCJf9m5gKbUhb+dINmucd+8Qj8C5bbxiqpdt9qrrYWy0WtQjCmLJp/YGmvzOsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757450664; c=relaxed/simple;
	bh=M8jmZ424bZwZQm1Mpv17w4Jhj3DFsKBVoUREJ73ARpU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=PM0vDL9EEfsVjAF70elLzXbvWqi0HOB7ReG579AFmAZAvclPab+QKxewMKJzipo0ikpzkEOhEazuUJc3RLsyOqVxLtTLO9Xdg4Nte3zs0FWj+Pj0yOJPbfUobUZLdra3v7t+/FJ3hO0DKLnS53GrN4dBAjxGwewEqCDfm/2wCXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=ZBZhyV3L; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="ZBZhyV3L"
Received: from github.com (hubbernetes-node-9d050e4.ash1-iad.github.net [10.56.143.35])
	by smtp.github.com (Postfix) with ESMTPA id CEAAE6007F5
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Sep 2025 13:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1757450659;
	bh=C90tG0clyBCyGeLegmrTnpgIx9BCVzuD+KP70AA1o+o=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ZBZhyV3LmwrH159ivERE7LHUudCxlCszyiwvh3uBCRCSu4GUYWU8oNivN5ZvsdUwt
	 5aRkb41eF59cNcKindD6ee1xla2wDBP8TZhNVvd/j1yM5M568hyqX9FC/7ktE/LizP
	 c5h0rY7lPP/U3fkx5NmlWHHR43hhefiW+VGW1/Ak=
Date: Tue, 09 Sep 2025 13:44:19 -0700
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/f9a98f-441f95@github.com>
Subject: [bluez/bluez] 393e81: main.conf: Add FilterDiscoverable option
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 393e81a7473c636a6a00f49d9246e8a2e6d5674a
      https://github.com/bluez/bluez/commit/393e81a7473c636a6a00f49d9246e=
8a2e6d5674a
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-09-08 (Mon, 08 Sep 2025)

  Changed paths:
    M src/adapter.c
    M src/btd.h
    M src/main.c
    M src/main.conf

  Log Message:
  -----------
  main.conf: Add FilterDiscoverable option

This adds FilterDiscoverable option which can be use to control if
devices in non-discoverable mode shall be filtered or not, the default
is true to adhere to core spec:

 9.2. Discovery modes and procedures

 All devices shall be in either non-discoverable mode or one of the
 discoverable modes. A device in the discoverable mode shall be in
 either the general discoverable mode or the limited discoverable mode.
 A device in the non-discoverable mode is not discoverable. Devices
 operating in either the general discoverable mode or the limited
 discoverable mode can be found by the discovering device.


  Commit: 2efd925db0b537c422d30283514e81816b673a03
      https://github.com/bluez/bluez/commit/2efd925db0b537c422d30283514e8=
1816b673a03
  Author: Roman Smirnov <r.smirnov@omp.ru>
  Date:   2025-09-09 (Tue, 09 Sep 2025)

  Changed paths:
    M client/assistant.c

  Log Message:
  -----------
  client/assistant: Use strnlen() instead of strlen()

Using strlen() can lead to undefined behavior.


  Commit: 441f95a9c146bcace5023847ff9fbe39eaf44716
      https://github.com/bluez/bluez/commit/441f95a9c146bcace5023847ff9fb=
e39eaf44716
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-09-09 (Tue, 09 Sep 2025)

  Changed paths:
    M unit/test-hfp.c

  Log Message:
  -----------
  unit/test-hfp: Fix MINIMAL_SLC_SESSION

Fix missing commas in +CIND reply.


Compare: https://github.com/bluez/bluez/compare/f9a98ff26e50...441f95a9c1=
46

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
