Received: from out-7.smtp.github.com (out-7.smtp.github.com [192.30.252.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FA130B502
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 20:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781037122; cv=none; b=e7eGHXOW1kha/vKibK1p1QIw3rZyBiwimfclXSx2MDbSb4KV7kEArvUCk8h675vmUROB5TRRHIc1wIYuUImQo45vb2Y2xkiMz94xrWbl69zAfeOKBOgswVwolTBI8hZGwSUBVUpkB6CtPeXvEkG13gdCUmVsIhpEnQJ9eOFc6CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781037122; c=relaxed/simple;
	bh=VJeR66490mEclo3osoubhwIMhEFNds1HXTgYRKue40g=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=RCeGhdEG1emoTcKew2YZeml1y7wjM/Ea7y9XSTptrrHWtL+VruaZ29bMO7S8W55VQnaREc7le0gm7NXT+AZi324+x56UdZZdHhyCEOHB6JzwVc+9WtYv9FImeLpYHYI0lYgmCm93xq3nx/bK+clf22ebrBqE/VCkH0M496FbklQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=fGxAXeQj; arc=none smtp.client-ip=192.30.252.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="fGxAXeQj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1781037120;
	bh=a0jlsVpXI6n/g2OEp+aBGM+Yk+dvUIlKYN/d+PXY9wg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=fGxAXeQjJEWFtY/NezI534BHkKT928TOqkR+BSQXJ/w8X9u7b1cPJI2rrT8jFuP/X
	 cmgn45fLOKJdYnF/TVbOIy7nLp+EtW7nZGeIc6Oa4pxwAPFtF5wg+hYBNlmWk4xxgk
	 bqzwrOn4gLopoL/piqColW9gCd8j7NzyK3JtHu64=
Received: from github.com (hubbernetes-node-e82a096.va3-iad.github.net [10.48.182.37])
	by smtp.github.com (Postfix) with ESMTPA id B9D247811E2
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 13:32:00 -0700 (PDT)
Date: Tue, 09 Jun 2026 13:32:00 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1108786/000000-3cc2dd@github.com>
Subject: [bluez/bluez] 5e8164: btio: Handle EOPNOTSUPP from accept() to
 prevent b...
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

  Branch: refs/heads/1108786
  Home:   https://github.com/bluez/bluez
  Commit: 5e81648c163877e2f5091576203557e95601251e
      https://github.com/bluez/bluez/commit/5e81648c163877e2f5091576203557e95601251e
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-06-09 (Tue, 09 Jun 2026)

  Changed paths:
    M btio/btio.c

  Log Message:
  -----------
  btio: Handle EOPNOTSUPP from accept() to prevent busy loop

When accept() returns EOPNOTSUPP on an L2CAP SEQPACKET server socket
(e.g. AVCTP browsing channel, PSM 0x1b), the error is permanent and
retrying will never succeed. Previously, only EBADFD was treated as
fatal, causing server_cb to return TRUE for EOPNOTSUPP. Since the fd
remains readable, this creates an infinite busy loop that hangs
bluetoothd.

Treat EOPNOTSUPP the same as EBADFD by returning FALSE to remove the
GLib IO watch and stop the loop.


  Commit: 70fa42fd8f621ce76b4a0128aad37d624b7e4779
      https://github.com/bluez/bluez/commit/70fa42fd8f621ce76b4a0128aad37d624b7e4779
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-06-09 (Tue, 09 Jun 2026)

  Changed paths:
    M src/profile.c

  Log Message:
  -----------
  profile: Check if bearer is enabled on registration

btd_profile_register now verifies that the profile's bearer type is
compatible with btd_opts.mode before registering. If the required bearer
is not enabled (e.g. LE-only profile when mode is BR/EDR, or BR/EDR-only
profile when mode is LE), registration is rejected with -ENOTSUP.


  Commit: 672cde593161db95582039c27e94a63431e7706d
      https://github.com/bluez/bluez/commit/672cde593161db95582039c27e94a63431e7706d
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-06-09 (Tue, 09 Jun 2026)

  Changed paths:
    M profiles/audio/a2dp.c
    M profiles/audio/avrcp.c
    M profiles/audio/hfp-hf.c
    M profiles/audio/micp.c
    M profiles/input/manager.c
    M profiles/network/manager.c
    M src/gatt-database.c

  Log Message:
  -----------
  plugins: Check btd_profile_register return value

Ensure all plugin init functions check the return value of
btd_profile_register. If registration fails (e.g. bearer not enabled),
the plugin init propagates the error instead of continuing with an
unregistered profile.


  Commit: 3cc2dd3fe2be5ebc3f7a8ff2e3bb7f7bbab05b88
      https://github.com/bluez/bluez/commit/3cc2dd3fe2be5ebc3f7a8ff2e3bb7f7bbab05b88
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-06-09 (Tue, 09 Jun 2026)

  Changed paths:
    M src/bearer.c

  Log Message:
  -----------
  bearer: Check btd_opts.mode on btd_bearer_new

Only create the bearer interface if the corresponding transport is
enabled. Return NULL if BREDR bearer is requested in LE-only mode or
LE bearer in BREDR-only mode, so the D-Bus interface is never
registered for unsupported bearers.


Compare: https://github.com/bluez/bluez/compare/5e81648c1638%5E...3cc2dd3fe2be

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
