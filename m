Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3B033C502
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jun 2026 19:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780601586; cv=none; b=Kd8PaO2aiX9NbUDPHWjSyr7i6Y5vK9mcXKKsdNFU+EZ1FgkNlc2Ee7pBikATdYMQI3yM7P4dEhB72O2IxrrO2a8lpuLsXDo59+4VTyMSgMU02wegTrTgTQZOSCT/ZtmuW9uSkcSZ/SGA5fmaXvViu4o6H7hn+Vhcxxl5DcGXAs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780601586; c=relaxed/simple;
	bh=iX5UgEaZNcihYQO+K5utFANMKFC9IkM3FCHMQoKy7KU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=dW+TwXuXu0jwlVkqSQagYCDRdv+/Nqjl47Lqzg0wFjFc1ZZRebQAi2GC8CItjX1WAk4zxcWgZZ4FuOWOv+fjLK7t1K52MJ022SlNoJsLqZvwTxKYyH4pgbAb327qGqaa6CV5qCyD5CReFpK3LR9dNb6G3DnrZc8HGCjMMnYoelM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=H7aoF4wE; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="H7aoF4wE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1780601584;
	bh=Ma+TZBtvdENHSCO+EasEXLPReqwO2ZHb9yYnd2zIk0c=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=H7aoF4wEZFa87Tc37pKpkFbmmIP9Jdj0aSnYxyZ/RDMsUuEgYjD+Hn3fTArNgeUWA
	 3vevk6A7npU8m8Mh3E/JFIC9UOeiWWfVrTc3wRd28+Cpt8MDxUAjsu30ZUYbE2xKRd
	 feC5s8rTSyUlugWAtFwL7Ps+qlljsGUpXy6af3sA=
Received: from github.com (hubbernetes-node-a19b22b.ash1-iad.github.net [10.56.193.29])
	by smtp.github.com (Postfix) with ESMTPA id 6BE5E360D19
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jun 2026 12:33:04 -0700 (PDT)
Date: Thu, 04 Jun 2026 12:33:04 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/2a6968-c6bc42@github.com>
Subject: [bluez/bluez] e60d07: build: Support libical 4.0
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: e60d07255327db3fc4e3a28d7fcc792cd42c34d0
      https://github.com/bluez/bluez/commit/e60d07255327db3fc4e3a28d7fcc792cd42c34d0
  Author: Funda Wang <fundawang@yeah.net>
  Date:   2026-06-04 (Thu, 04 Jun 2026)

  Changed paths:
    M configure.ac

  Log Message:
  -----------
  build: Support libical 4.0

libical 4.0 split off some vcal related functions to a separate shared
library, libicalvcal. As libicalvcal depends on libical itself, first
check for libicalvcal being available, and if it fails, check for
just libical.

Closes: https://github.com/bluez/bluez/issues/2090

Tested-by: Bastien Nocera <hadess@hadess.net>


  Commit: 646014a6a246fe99df27da12d2de7bcd2e04d0df
      https://github.com/bluez/bluez/commit/646014a6a246fe99df27da12d2de7bcd2e04d0df
  Author: Wei Deng <wei.deng@oss.qualcomm.com>
  Date:   2026-06-04 (Thu, 04 Jun 2026)

  Changed paths:
    M src/profile.c

  Log Message:
  -----------
  profile: Set L2CAP IMTU for OBEX profile listeners

The default_settings entries for OBEX profiles (OPP, FTP, PBAP, MAS,
MNS) have no imtu field, so ext_start_servers() creates the L2CAP
listening socket without an explicit IMTU. This causes the socket to
advertise the L2CAP minimum of 672 bytes in L2CAP_CONFIGURATION_RSP,
limiting the peer's outgoing PDU size and degrading Rx throughput.

Add an imtu field to default_settings and set it to 32767 for all
OBEX profiles that use L2CAP. Copy the value in ext_set_defaults()
and apply it to the listening socket via bt_io_set() after
bt_io_listen() succeeds.


  Commit: c6bc42d696610bfae4e5dc193e1d39371c6b3e0c
      https://github.com/bluez/bluez/commit/c6bc42d696610bfae4e5dc193e1d39371c6b3e0c
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-06-04 (Thu, 04 Jun 2026)

  Changed paths:
    M src/adapter.c

  Log Message:
  -----------
  adapter: Fix using case sensitive strncmp for pattern match addresses

When matching discovery filter pattern with addresses shall be
considered case insensitive since its binary format that can be
printed using either upper or lower case for the range a-f/A-F.


Compare: https://github.com/bluez/bluez/compare/2a6968b40378...c6bc42d69661

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
