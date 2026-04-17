Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE42361640
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Apr 2026 09:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776418959; cv=none; b=CWHuQhxvpUJ4vV1Kwn/e6+btpfb+byFgW14hYvqvTj0qJ38aMwRBenpijqguFGNJprcnYEOllCbwHzEMTfdQW7f0MheYCyfM+AbWdBLpGsjfanXjfZzUH4c+2I7fBAU3IGIS5Uabp+j7DxXkwuqUJRAVwCa/JTEfJkc+mEoh07Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776418959; c=relaxed/simple;
	bh=6S05W5FrIircX1/j8SWrSXSr7WhSpQnvNZ8CUYjU9A0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=HEdxnn4n2n7L9UlgiMvWtDtyh1Mz5A2WFRtNrm67juBhTCfHkbdt7cvTjJ+EnbPYWabzMbS4wfAtYWfxO446tISl6N1BRtEKDdkMIxxerlDpee88AZ3YYoK59hvC4MtdQ5QnzVZEvDlO4l7ZlxW5L6XfSRvKVMZPUmohAD20VJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=R1K9W5zp; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="R1K9W5zp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1776418957;
	bh=Q2hTzsMEaQnuBj6W08X0GzgsGpkexFS1aXepr+3H1tU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=R1K9W5zp6MmB4XfeBe1VcpD/1mD/cJUSSZCtXRQJkkKa+9S0u56iudqCRJS8IJdil
	 kftogd994JgiHSBQsWv+sXzpwEpXQOQy0/1Bipmq3D1724Uh0Jwv1CL2QaGS0F4qW2
	 KOeFyOe+K0aAQywzfPPP7pqn5WeT6Mt7ZkkcdWOU=
Received: from github.com (hubbernetes-node-a6ce019.va3-iad.github.net [10.48.204.59])
	by smtp.github.com (Postfix) with ESMTPA id B0CCC8010D8
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Apr 2026 02:42:37 -0700 (PDT)
Date: Fri, 17 Apr 2026 02:42:37 -0700
From: mdzik-sue <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1082418/000000-5bea6e@github.com>
Subject: [bluez/bluez] 382bc2: transport: allow setting Metadata property on
 broa...
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

  Branch: refs/heads/1082418
  Home:   https://github.com/bluez/bluez
  Commit: 382bc2eaa84325d86c86e1aff6fa023cbc34e2ca
      https://github.com/bluez/bluez/commit/382bc2eaa84325d86c86e1aff6fa023cbc34e2ca
  Author: Michal Dzik <michal.dzik@streamunlimited.com>
  Date:   2026-04-17 (Fri, 17 Apr 2026)

  Changed paths:
    M profiles/audio/transport.c

  Log Message:
  -----------
  transport: allow setting Metadata property on broadcast

Also fixes a problem where 64-bit iov_len was incorrectly initialized with
32-bit value in dbus_message_iter_get_fixed_array().


  Commit: 90435903ddcfdc9a5bd461bc766f8ed0cb9287e7
      https://github.com/bluez/bluez/commit/90435903ddcfdc9a5bd461bc766f8ed0cb9287e7
  Author: Michal Dzik <michal.dzik@streamunlimited.com>
  Date:   2026-04-17 (Fri, 17 Apr 2026)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: run callback after setting the broadcast metadata

Without this callback, dbus property setting will stall.


  Commit: 8407969f173f2d0434adfca2773f497045f0fcad
      https://github.com/bluez/bluez/commit/8407969f173f2d0434adfca2773f497045f0fcad
  Author: Michal Dzik <michal.dzik@streamunlimited.com>
  Date:   2026-04-17 (Fri, 17 Apr 2026)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  audio/bap: fill BIG and BIS for receiver

This is for some reason a missing feature.
We receive QoS structure from the kernel via BT_ISO_QOS, but BIG and BIS
are not set there. In fact it is even impossible to pass them that way,
as it is only one structure per remote device. That's why we have to parse
BASE data to extract BIS and set it to stream->qos. BIG is not present
explicitely in BASE, but we can use subgroup index with success.

As a result of this commit, MediaTransport1 object has now a valid BIG
and BIS set in QoS property.


  Commit: 5bea6ed98c93bf3b7e0499bc80082f487c03f93e
      https://github.com/bluez/bluez/commit/5bea6ed98c93bf3b7e0499bc80082f487c03f93e
  Author: Michal Dzik <michal.dzik@streamunlimited.com>
  Date:   2026-04-17 (Fri, 17 Apr 2026)

  Changed paths:
    M profiles/audio/transport.c

  Log Message:
  -----------
  audio: update QoS dbus property after it is set

Dbus set and get on QoS property use different data:
- get uses bap->qos
- set uses bap->stream->qos
This works, because bap->qos is a copy of bap->stream->qos. The only
issue is when we set this property and then try to get it. We see old, not
updated copy. Simply calling bap_update_bcast_qos() fixes the problem.


Compare: https://github.com/bluez/bluez/compare/382bc2eaa843%5E...5bea6ed98c93

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
