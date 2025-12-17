Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C34E2F12B7
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Dec 2025 19:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766000595; cv=none; b=FF7t6veZPG7yMfSxSFEKVTugzIpmD2dc2SkJXvHH21l0VVxtPpEUw7e3rrLD+ltB0aR+ofLm7RbanVfMJ7lENCiq+ct2/U9N6IZYqosSdGv+GJ7HtIPJyPPkYhy2LVhUqBpYSQvAH+XouXX7mzi+Z4QhbS5b39N9nkLLPTDBO5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766000595; c=relaxed/simple;
	bh=GipMu+KqP2Vedzo0PmUZiTYTRt/c4Hv2kfxDPU9nNos=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=d9fP/XQKfxGWqKPDhHayQx5YJFmVCETeOeXMzMrjdZL8qVYu6wqrDh231tJqEw6J1gSJ8C/UfFAU/eS8JMa0JyyhJ8gNXhLF0UCmCnKd4WLkjy4Z7w4WrloZRsFiBFwtztCbaDXUJvnv3f+4f70Tw8Kpn0MHcgDRB1HR9PTwjxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=eYNrDXl5; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="eYNrDXl5"
Received: from github.com (hubbernetes-node-5f624db.ash1-iad.github.net [10.56.209.106])
	by smtp.github.com (Postfix) with ESMTPA id 34913600A9D
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Dec 2025 11:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1766000587;
	bh=BgBk6pzHqM5RRAdnNMGVsSasTuQi02ving6Y9Hni7J4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=eYNrDXl5mflkhRV2mU8urror++3C3WYZh4ItN3Ot00H8162UEuRghqK0/w6/qVRYv
	 1uKnRYX6wyDRHBAa7L7v0Z53RkGd27iJh2mej3u6ZLtF01slJPLrZ9vjbKbRFF4BxT
	 xzkJErBqCtNFE/9plKCK17TU5XD8DRBXTK/WOvk4=
Date: Wed, 17 Dec 2025 11:43:07 -0800
From: ssorensenroku <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1034329/000000-4fd06b@github.com>
Subject: [bluez/bluez] c0d55b: doc: Sync default system parameter list with
 kernel
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

  Branch: refs/heads/1034329
  Home:   https://github.com/bluez/bluez
  Commit: c0d55bfbe5740fc4f17f3830aa6f0dea0790b3f2
      https://github.com/bluez/bluez/commit/c0d55bfbe5740fc4f17f3830aa6f0=
dea0790b3f2
  Author: Stefan S=C3=B8rensen <ssorensen@roku.com>
  Date:   2025-12-17 (Wed, 17 Dec 2025)

  Changed paths:
    M doc/mgmt.rst

  Log Message:
  -----------
  doc: Sync default system parameter list with kernel

Add the LE interleave scan default system parameters that were never
added to the documentation.


  Commit: 4fd06b817fa4859a918e686cb7ca0760f9bf52da
      https://github.com/bluez/bluez/commit/4fd06b817fa4859a918e686cb7ca0=
760f9bf52da
  Author: Stefan S=C3=B8rensen <ssorensen@roku.com>
  Date:   2025-12-17 (Wed, 17 Dec 2025)

  Changed paths:
    M src/adapter.c
    M src/shared/mgmt.c
    M src/shared/mgmt.h

  Log Message:
  -----------
  adapter: Do not send empty default system parameter list

If we have no default system parameters to set, bail out without
sending the empty list to the kernel just to get an error back.


Compare: https://github.com/bluez/bluez/compare/c0d55bfbe574%5E...4fd06b8=
17fa4

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
