Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DBE372B31
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Apr 2026 11:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776425669; cv=none; b=i5sYCNWbAZXw/AC1nDJDoxDCYgLVEWS8CJ7A/GXdTY/GoA83DniP95vNueqNg0E5VTcNvDbrZiWdDfzskKfnsvZu1GFoZgRHxLn30XoqDIivSHlpZ3N30uRiXugHEa7oGkMVcr6ea3Bv5HjuSZhWITa1u+5CcJ27HV9gwFRRGT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776425669; c=relaxed/simple;
	bh=dkmSxwretijcqpRvVzRxfmwXKw+41ZoXbOHSxXGwz6c=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=eTBwYGGhMXyOj+778p2bIh5MZ6/dJxdAijb+0co6QWP+SlKCc0/b0NRId6Lm+RijPpPnr7MD58SCvHTwlnuV2mKLiP4hdaL+WvO0X/0M+sLheK9hdM9hv7bnjkDiSpheHOebME6XI+xG8WaVMsK1UlGNyarVlWmyVf07ZFgP9e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=GBurzB7J; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="GBurzB7J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1776425666;
	bh=YDogZoNhaq2uF1JPfgpwl0eKPli+ybUbqtFr1jUNYqE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=GBurzB7JovDzt15y82ubnt6+cHur/jde8eMmm2uwMnJB40TeHu+rgj5cjvBOf/QF+
	 c/MHjVa277L685ckcTB9w+9aayFhhG1rIuukftJnyWZrfe3CIZ3qb9V+BDK/gsp6BQ
	 Aba4dey0gM7Nir+W2wUf5Kow1VW3GBLBx9AYqOe0=
Received: from github.com (hubbernetes-node-9479665.va3-iad.github.net [10.48.173.14])
	by smtp.github.com (Postfix) with ESMTPA id D7886501104
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Apr 2026 04:34:26 -0700 (PDT)
Date: Fri, 17 Apr 2026 04:34:26 -0700
From: mdzik-sue <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1082491/000000-b7162b@github.com>
Subject: [bluez/bluez] 43c234: transport: allow setting Metadata property on
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

  Branch: refs/heads/1082491
  Home:   https://github.com/bluez/bluez
  Commit: 43c23455f1f30d126504078c0d647702a78af402
      https://github.com/bluez/bluez/commit/43c23455f1f30d126504078c0d647702a78af402
  Author: Michal Dzik <michal.dzik@streamunlimited.com>
  Date:   2026-04-17 (Fri, 17 Apr 2026)

  Changed paths:
    M profiles/audio/transport.c

  Log Message:
  -----------
  transport: allow setting Metadata property on broadcast

Also fixes a problem where 64-bit iov_len was incorrectly initialized with
32-bit value in dbus_message_iter_get_fixed_array().


  Commit: 2a503234334acab7ba5894f0c2320ced08df1dfb
      https://github.com/bluez/bluez/commit/2a503234334acab7ba5894f0c2320ced08df1dfb
  Author: Michal Dzik <michal.dzik@streamunlimited.com>
  Date:   2026-04-17 (Fri, 17 Apr 2026)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: run callback after setting the broadcast metadata

Without this callback, dbus property setting will stall.


  Commit: d393df9970cd00104c4dee6d38a2f7b9217d60b9
      https://github.com/bluez/bluez/commit/d393df9970cd00104c4dee6d38a2f7b9217d60b9
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
explicitly in BASE, but we can use subgroup index with success.

As a result of this commit, MediaTransport1 object has now a valid BIG
and BIS set in QoS property.


  Commit: b7162b86c92159830569c451417866809d707b05
      https://github.com/bluez/bluez/commit/b7162b86c92159830569c451417866809d707b05
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


Compare: https://github.com/bluez/bluez/compare/43c23455f1f3%5E...b7162b86c921

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
