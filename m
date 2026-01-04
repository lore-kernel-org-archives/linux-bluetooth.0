Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE4D21348
	for <linux-bluetooth@vger.kernel.org>; Sun,  4 Jan 2026 21:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767560531; cv=none; b=sT32MOKadwAIThuZfPOH4Uih1nsbL7OUXeckVmxoXwmc21wBphSLv8O7/+zsKovvLd9sxGO/6JjLPD/gb88NPiOMBI9oM0WggKwho/ruHhF2VRtrmyULallBsyulE785pSgBeRGFPtoA3HkvIItulIx9CmOGraygFUrhzpRXHuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767560531; c=relaxed/simple;
	bh=py6WSn6TK8e+t2PRCVrwN3OGersHQz9EoMlCCbwxHP8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=qT9Hdrns4sJdLnu9WQnRyDsahAYz6Wkbdt+HrZjqZ6ZljyKg+XJtCTT7cO69Xy9IHgQlzcKz4CyYYDWvYFJcKZkxv21YBIHh5kfS6mMDuKg0iDJddPJHGv2Q3sIYGraYU8cnk47ZSIX/pkNEtJLrJQhh/ISnHO9n0tbLv4bBevg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=TugfGpl5; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="TugfGpl5"
Received: from github.com (hubbernetes-node-c1fc992.ash1-iad.github.net [10.56.173.14])
	by smtp.github.com (Postfix) with ESMTPA id 45E90600394
	for <linux-bluetooth@vger.kernel.org>; Sun,  4 Jan 2026 13:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1767560529;
	bh=NMAWNfoDaMakiQ58hdE+mfe+dOWbpn2AsvYWboOZBRM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=TugfGpl5il8Pb6/yN3kofCJ2BLFkOkf/xExvEOWMLHPCGDf6hoOtNZHNkmmWAQt8Z
	 6c5x+pj0s2QNp7I9eO/E99Qa9JS+WYMgjzV8PmReEZQb1osif4aGoZ8qgZnaAmPVg4
	 8UD4cnaJL+JB/6UYVAHXXKQ1fjqE8ccTPkAjxWKs=
Date: Sun, 04 Jan 2026 13:02:09 -0800
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1038262/000000-3d339e@github.com>
Subject: [bluez/bluez] db6bd3: shared/bap: add bt_bap_stream_is_server
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

  Branch: refs/heads/1038262
  Home:   https://github.com/bluez/bluez
  Commit: db6bd37055237b33a0c8de1d1b8e47c955700fc7
      https://github.com/bluez/bluez/commit/db6bd37055237b33a0c8de1d1b8e47c955700fc7
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-01-04 (Sun, 04 Jan 2026)

  Changed paths:
    M src/shared/bap.c
    M src/shared/bap.h

  Log Message:
  -----------
  shared/bap: add bt_bap_stream_is_server

Add function for determining whether a given stream is a BAP Server
stream or not.


  Commit: 1a1342dea39091cf8659b7468339ba82dd2bf2af
      https://github.com/bluez/bluez/commit/1a1342dea39091cf8659b7468339ba82dd2bf2af
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-01-04 (Sun, 04 Jan 2026)

  Changed paths:
    M profiles/audio/avrcp.c
    M profiles/audio/media.c
    M profiles/audio/media.h
    M profiles/audio/transport.c
    M profiles/audio/transport.h
    M profiles/audio/vcp.c
    M profiles/audio/vcp.h

  Log Message:
  -----------
  transport: clean up volume set/get for A2DP and VCP

Cleanup uuid comparisons in device transport volume set/get. These are
unnecessary because the transport->ops already do the equivalent check.

Use separate functions for set/get AVRCP volume, to avoid mixing up
AVRCP and VCP volumes.

For VCP send volume update notifications on all transports, since same
volume is listed on all.

To avoid interspersing #ifdefs for A2DP/VCP in this code, define dummy
functions in headers that behave accordingly.

Fix the bt_audio_vcp_get/set_volume to properly indicate when VCP is not
present.


  Commit: 3d339e05d5d7a29a38232a5a7cf6aca820472aa8
      https://github.com/bluez/bluez/commit/3d339e05d5d7a29a38232a5a7cf6aca820472aa8
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-01-04 (Sun, 04 Jan 2026)

  Changed paths:
    M profiles/audio/transport.c

  Log Message:
  -----------
  transport: distinguish BAP mic and playback volumes

BAP Unicast has two kinds of relevant volumes: playback and microphone.
Client Sink and Server Source generally correspond to microphone volume.
Broadcast Source and Sink do not have microphone volume.  Microphone
volumes shall use MICP, not VCP, but currently we confuse them.

Fix by distinguishing the VCP / MICP cases. The shared/micp
implementation is incomplete, so leave those volumes unimplemented also
in transport.

This fixes setting volume on microphone transport changing the playback
volume.


Compare: https://github.com/bluez/bluez/compare/db6bd3705523%5E...3d339e05d5d7

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
