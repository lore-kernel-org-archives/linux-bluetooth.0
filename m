Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655285581F6
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Sep 2026 17:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788887890; cv=none; b=mhRHytFky1A2FN0ZchSy2W2BkJYTNPTl/5FREP8tbufJufsOY4ibuoevYn54oLRAQhnwfvT62nh1NP92Xa1gB9N18IL+yX7xfQGKPdbfrgyOwdA92uz/0ZnNkP8oI3DxrVE0obqZpM3JqkmdJNvvU0OIVnEzI6nBQWpfqV9EJSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788887890; c=relaxed/simple;
	bh=TEXDYbeDN6/4lCn3B5/c6ObD7ArpwqZuxT21ojiMnls=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=hWbxG0rPuiW/AlAuoLcwliH6h1YlJrK2DhCax1rn4HIcrzQjWQHXRqbFbmN/2XiW78ofap4zxf3WuhSbY/SDi/3YyigB/Sg/Ot1c4y3FDUo0q1bsfOJ94cg9j7S5v2uoVfyqk5WFDgbuvv+QErJQWKSZc0NiFW6p1z/6IdjupdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=NBX1c8f2; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="NBX1c8f2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1788887888;
	bh=xI4eXl7z01ZWx2Qn5XeNrJj8NRM64cDIL1i6QqWowYc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=NBX1c8f2MXpU5r8KI8Y1EvuNhb+zPTK8aW5e2hV2Qcnis8qXMXVYwZwzTDaNhKJT4
	 +6YPr3E8Xl57xb51sBrXhBjOEI58BoqzHwpAGwECKUiktPWPifID2oLXGdaSvSK1Jt
	 LaGAhtTAmDf5aEekEOSBoVxam38s7PWAqwz9r22I=
Received: from github.com (hubbernetes-node-b1426d1.ash1-iad.github.net [10.56.84.27])
	by smtp.github.com (Postfix) with ESMTPA id 7B2BF367E25
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Sep 2026 10:18:08 -0700 (PDT)
Date: Tue, 08 Sep 2026 10:18:08 -0700
From: Bhavani <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1160130/000000-394aa8@github.com>
Subject: [bluez/bluez] 7c04cb: rap: Add OndemandRanging configuration option
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

  Branch: refs/heads/1160130
  Home:   https://github.com/bluez/bluez
  Commit: 7c04cbcb418d32a30cfb467f1cfe0bec17b3df20
      https://github.com/bluez/bluez/commit/7c04cbcb418d32a30cfb467f1cfe0bec17b3df20
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-09-08 (Tue, 08 Sep 2026)

  Changed paths:
    M src/btd.h
    M src/main.c
    M src/main.conf

  Log Message:
  -----------
  rap: Add OndemandRanging configuration option

Add a per-adapter config knob under [ChannelSounding] to let the RAS
Initiator use on-demand Ranging Data delivery (Get_Ranging_Data/
ACK_Ranging_Data) instead of real-time notifications. Defaults to
false.

- src/btd.h: add bool ondemand_ranging to struct btd_le_bcs.
- src/main.c: parse "OndemandRanging" into
  btd_opts.defaults.bcs.ondemand_ranging.
- src/main.conf: document the new option.


  Commit: 4a8187e114426d90a34f25badf8f1118a54071a2
      https://github.com/bluez/bluez/commit/4a8187e114426d90a34f25badf8f1118a54071a2
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-09-08 (Tue, 08 Sep 2026)

  Changed paths:
    M src/shared/rap.c
    M src/shared/rap.h

  Log Message:
  -----------
  shared: add support for on-demand notification handling

When OndemandRanging is enabled in main.conf, allow the reflector role
to send on-demand ranging data. In the initiator role, handle
on-demand ranging data notifications and the associated control point
opcodes.


  Commit: 394aa8756fd2de2e4816ab61d0c74d07b30f9019
      https://github.com/bluez/bluez/commit/394aa8756fd2de2e4816ab61d0c74d07b30f9019
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-09-08 (Tue, 08 Sep 2026)

  Changed paths:
    M profiles/ranging/rap.c

  Log Message:
  -----------
  profiles: honor OndemandRanging config for RAS Initiator

In rap_accept(), call bt_rap_set_ondemand_ranging(data->rap, true)
before bt_rap_attach() when btd_opts.defaults.bcs.ondemand_ranging is
set, so the initiator uses on-demand ranging data delivery instead of
the default real-time stream.


Compare: https://github.com/bluez/bluez/compare/7c04cbcb418d%5E...394aa8756fd2

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
