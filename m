Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6E61F3BAB
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jul 2025 14:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752591229; cv=none; b=vFyPBZjVTyg1Xbt+KRIWcnTzw9wLPpsBAX14eL9zs+DGRMMB29xPGSLkI3k8ODW5cY21c/mCqqqr85W9lX2s+RuUfPOZ16EIk3RXTr4XolQRbt6ZpT/4PqrGhyfbS43TlHBKHlB8aPpB5PNsPogV5yQGtaSfmIUX+vzJiJozeTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752591229; c=relaxed/simple;
	bh=5+pqNg+l8nHMy+FuQ9ezgHzUm1bXPvNC9wDELwVGnuQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=E29FxFMAkjd1uBYeSTLbDli2KapXAMwVFghma5QWIPSSGxvipGiXItfUy9xCL00wJfsZ2ceXlhEsjJDh0QetVPEVuFDDmY2XmSGjL5ruKViiskeh2RCB3ZGI4r94COAQF4L4RjoQHAL/U8gryHz8vF5mQbc+wTqw5/GVWYA3biY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=cr4ac39O; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="cr4ac39O"
Received: from github.com (hubbernetes-node-2ddca15.ac4-iad.github.net [10.52.139.39])
	by smtp.github.com (Postfix) with ESMTPA id D89CD2094F
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jul 2025 07:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1752591226;
	bh=+O/620k57gV5mAEPEr1NuwwRiqtZLRZgh2YWGzCrAjU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=cr4ac39OtULB5xmtFGOQ/9VK5vJnS2BkN9gncAoPNwYq6J961TXY0Phl87Ve9ayyw
	 zU7hKnxuigwPbklCQnffO7SkK87bRdkSW9cvoSiybkJrD2CFUc7cuINAYyTiJjPoN5
	 xGUOfP5YweYkYoRNmVeoUzxruPhnceuz1rP6jFvw=
Date: Tue, 15 Jul 2025 07:53:46 -0700
From: Christian Eggers <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/981619/000000-60400b@github.com>
Subject: [bluez/bluez] ec2fb7: mesh: acceptor: increase interval for
 unprovisione...
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

  Branch: refs/heads/981619
  Home:   https://github.com/bluez/bluez
  Commit: ec2fb7a08ba66fe210e75e8484d5740dcaf4ff61
      https://github.com/bluez/bluez/commit/ec2fb7a08ba66fe210e75e8484d5740dcaf4ff61
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2025-07-15 (Tue, 15 Jul 2025)

  Changed paths:
    M mesh/prov-acceptor.c

  Log Message:
  -----------
  mesh: acceptor: increase interval for unprovisioned device beacon

I cannot find a specific interval for sending unprovisioned device
beacons in MshPRT_v1.1, section 3.10.2/5.2.1. The current interval of
500 ms seems to cause interferience with normal advertising messages,
maybe this is controller dependent (seen on RTL8761BU).

A beacon interval of 1000 ms should be sufficient for scanning (e.g. by
a provisioner) while allowing normal advertising messages to be
transmitted.


  Commit: 3f1f6b91e37585187b23a2260d14f9e7d26bc94f
      https://github.com/bluez/bluez/commit/3f1f6b91e37585187b23a2260d14f9e7d26bc94f
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2025-07-15 (Tue, 15 Jul 2025)

  Changed paths:
    M Makefile.mesh
    A mesh/gatt-service.c
    A mesh/gatt-service.h
    A mesh/pb-gatt.c
    A mesh/pb-gatt.h
    M mesh/prov-acceptor.c

  Log Message:
  -----------
  mesh: add support for provisioning via GATT

ToDo: Consider moving dbus_client instance into separate singleton, so
that no destruction/construction is necessary when switching from GATT
provisioning service to GATT proxy service (see next commit).


  Commit: 1152e8d156784996d1e5e7460babf37b9535af8c
      https://github.com/bluez/bluez/commit/1152e8d156784996d1e5e7460babf37b9535af8c
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2025-07-15 (Tue, 15 Jul 2025)

  Changed paths:
    M Makefile.mesh
    A mesh/gatt-proxy-svc.c
    A mesh/gatt-proxy-svc.h
    M mesh/main.c
    M mesh/net-keys.c
    M mesh/net-keys.h
    M mesh/net.c
    M mesh/net.h
    M mesh/prov-acceptor.c

  Log Message:
  -----------
  mesh: add GATT proxy service

MeshPRT_v1.1, chapter 7 states that GATT provisioning service and GATT
proxy service must NOT be active simultaneously.

This patch only implements the GATT proxy itself (so that a GATT proxy
client can exchange network messages with server). Relaying /
retransmission of network messages and propagation of beacons will be
handled in later patches.


  Commit: 805dc2e1f0f84eb07b025ef40c4d810f4642aeda
      https://github.com/bluez/bluez/commit/805dc2e1f0f84eb07b025ef40c4d810f4642aeda
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2025-07-15 (Tue, 15 Jul 2025)

  Changed paths:
    M Makefile.mesh
    M mesh/crypto.c
    M mesh/crypto.h
    M mesh/gatt-proxy-svc.c
    M mesh/gatt-proxy-svc.h
    M mesh/net-keys.c
    M mesh/net-keys.h
    M mesh/net.c
    A mesh/proxy-cfg.c
    A mesh/proxy-cfg.h

  Log Message:
  -----------
  mesh: gatt-proxy: support for proxy configuration messages and filtering

Implement reception / responses for Proxy Configuration Messages
(MshPRT_v1.1, section 6.6) and proxy filtering (sections 6.4 and 6.7).


  Commit: 5e0dfaee9585263d4ba028a7d22e8f398dc59380
      https://github.com/bluez/bluez/commit/5e0dfaee9585263d4ba028a7d22e8f398dc59380
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2025-07-15 (Tue, 15 Jul 2025)

  Changed paths:
    M mesh/cfgmod-server.c
    M mesh/mesh-main.conf
    M mesh/mesh.c
    M mesh/mesh.h
    M mesh/node.c

  Log Message:
  -----------
  mesh: main.conf/cfgmod-server: allow to enable proxy support

The proxy settings in the config file and in the configuration server
only affect the _relaying_ between GATT and ADV. Provisioning via
PB-GATT and connecting to the GATT proxy service is always possible
(MshPRT_v1.1, section 4.2.12).

The actual relaying of network messages and beacons is implemented in
the next patches.


  Commit: ed106a098e95493ee720eb369dbbc7f600b8e36b
      https://github.com/bluez/bluez/commit/ed106a098e95493ee720eb369dbbc7f600b8e36b
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2025-07-15 (Tue, 15 Jul 2025)

  Changed paths:
    M mesh/net.c

  Log Message:
  -----------
  mesh: net: proxy relaying

Implement retransmission of network messages according to MshPRT_v1.1,
section 3.4.6.3, table 3.13.


  Commit: 60400bf0a7cc56a5642e04d906272fde45814676
      https://github.com/bluez/bluez/commit/60400bf0a7cc56a5642e04d906272fde45814676
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2025-07-15 (Tue, 15 Jul 2025)

  Changed paths:
    M mesh/gatt-proxy-svc.c
    M mesh/gatt-proxy-svc.h
    M mesh/net-keys.c
    M mesh/net-keys.h
    M mesh/net.c
    M mesh/net.h

  Log Message:
  -----------
  mesh: gatt-proxy: propagate beacons

MshPRT_v1.1, section 6.7 requires that:
1. Upon connection of a GATT proxy client to a GATT proxy server, the
   server sends a beacon for each known subnet to the client.
2. Upon processing a SNB or MPB with a new IV index or flags value, the
   GATT proxy server shall propagate the beacon to the client.
3. When the GATT proxy server is added to a new subnet, a beacon for
   that subnet shall be sent to the client.


Compare: https://github.com/bluez/bluez/compare/ec2fb7a08ba6%5E...60400bf0a7cc

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
