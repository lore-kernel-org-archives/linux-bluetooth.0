Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15186279DA6
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Jul 2025 14:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751381748; cv=none; b=K786cjIitvvndfnIZqcVxhLbbitj6BWEx0wCD4S3nF5t5gzxBYw6+WeZh3Qk0EWtRxThv3nRXe2Qo8uSoJTqEC7Bo0YckPg5ogt0Zj4fmGnnsrodUpLoxCA4eCcPxmbJrRFoSn0+CzYwVH6EcUPB4w2+4pw48F8VD9ZD7O9rKpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751381748; c=relaxed/simple;
	bh=SMcrI5CJbJsbLoWtqJ2TPW0BbQapqvEGiqp8kEVw/3k=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=PZBGHBFuFtAkWWRD2pS8dshtAs42PQ5kkgEGFCWwYfUikiV7GiYQxdMvAHa6rmcAqZWfnyu8iQ6utH/kjwa4etWQ52otCP/zjs3+Ur4rObJUSs4Q+riUruxC3EWaA7lX+HkR6wogKBgscPKt0Yij2RrqqBo8JvB4ZjdBCoQ9zGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=G2xXy3Z3; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="G2xXy3Z3"
Received: from github.com (hubbernetes-node-8911680.ash1-iad.github.net [10.56.158.23])
	by smtp.github.com (Postfix) with ESMTPA id 291B360091F
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Jul 2025 07:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1751381746;
	bh=7MZD4bEtci/NLpid/3WYfmsC8zknCw6DV8fvutl4QE8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=G2xXy3Z3iZK85eKCFrFSYcydpZsrIiPM6A2iPxKxSJ6hcRe1JvbxwEbcddPsw4v70
	 dPAEW5MuOChGlodQxeu4kqJqt6z+spEr/cbrmf+m/8coBR54Q4v9fgu6hLjYpZKTQg
	 PX82L9kvp9/WdD70O6KYgKoHg/rjXRpY6M0BdUSI=
Date: Tue, 01 Jul 2025 07:55:46 -0700
From: Christian Eggers <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/977765/000000-189ecb@github.com>
Subject: [bluez/bluez] 5810cb: mesh: acceptor: increase interval for
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

  Branch: refs/heads/977765
  Home:   https://github.com/bluez/bluez
  Commit: 5810cb647382acdd368fe31e568ad36b4318c185
      https://github.com/bluez/bluez/commit/5810cb647382acdd368fe31e568ad36b4318c185
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2025-07-01 (Tue, 01 Jul 2025)

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


  Commit: 796b0e6a6588b63354ee3733ffc589982ecfa62a
      https://github.com/bluez/bluez/commit/796b0e6a6588b63354ee3733ffc589982ecfa62a
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2025-07-01 (Tue, 01 Jul 2025)

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


  Commit: fb20d62fda1d971e0e0679866f109c353ab1de93
      https://github.com/bluez/bluez/commit/fb20d62fda1d971e0e0679866f109c353ab1de93
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2025-07-01 (Tue, 01 Jul 2025)

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

FIXME: net.c: determine whether data shall be sent via mesh_io or
gatt_proxy


  Commit: 189ecb870d7baecc6b5aa96df9d39948117198e5
      https://github.com/bluez/bluez/commit/189ecb870d7baecc6b5aa96df9d39948117198e5
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2025-07-01 (Tue, 01 Jul 2025)

  Changed paths:
    M Makefile.mesh
    M mesh/crypto.c
    M mesh/crypto.h
    M mesh/net-keys.c
    M mesh/net-keys.h
    M mesh/net.c
    A mesh/proxy-cfg.c
    A mesh/proxy-cfg.h

  Log Message:
  -----------
  mesh: initial support for proxy configuration messages via GATT

Implement reception and response for Proxy Configuration Messages
(MshPRT_v1.1, section 6.6).

ToDo: Apply configured filters.


Compare: https://github.com/bluez/bluez/compare/5810cb647382%5E...189ecb870d7b

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
