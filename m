Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D1242A792
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Aug 2026 10:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786531509; cv=none; b=cLP6Z+cUz27mIP400SqDglIWg5dnGGxgdrDOv33vTNeAwdNcPaPZOyZ+XQZ6bzBqFnx6aL4dfAesEvFoi21APG7wjFU7sTTYlas/xxY5NpxCJzVV1wSuIO5/06uVsplPg2eD9QMJuQX+p2tEpYDipXBRsJ1ytL1HLWJmArm1+dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786531509; c=relaxed/simple;
	bh=azsQJ2lNOhJryYO36jx2fiJIeWSghUk1w9JZCn3H55w=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Xs8iVjQE7uwkRjsoFjHDFH4WL3CWirMBTNDG0Tb7Dj2TLWpeDCZpOR5VDYQidgZono7yFCc+Sor+wu5fkGu2Bce/TCmryyCT8f3jHGl0wXGqi3Fyp52z84DxyCsK0ve58/zc8e97OCwgaSiv59mLgGQRbl554ia+CioM+udF7/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=jrM8WQ9p; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="jrM8WQ9p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1786531507;
	bh=haDq9JkNJZreHhcbOaOf4oIgf5qVUt1uk9VVHmMrWuI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=jrM8WQ9p+5B2eruXmIuiUTtF/7s6gu6ogSwQ6zP3LH+zrIA3S0fGZNylqc6Y6bjNi
	 e+FXDwU4HG+ysfaUlC7g6/MoEjWcvZNiqzhfbTFvzAsiSe5rxH/aJVwZTFUiiGAEzD
	 CP1GcpjxD/UWXmWNX5s9mjUKB1gnQhkL5QlsIcCY=
Received: from github.com (hubbernetes-node-33cd46b.va3-iad.github.net [10.48.67.78])
	by smtp.github.com (Postfix) with ESMTPA id 1B0462812E2
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Aug 2026 03:45:07 -0700 (PDT)
Date: Wed, 12 Aug 2026 03:45:07 -0700
From: Naga Bhavani Akella <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1144626/000000-fccc3b@github.com>
Subject: [bluez/bluez] 98f0ab: doc: Add org.bluez.CSDistance1 documentation
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

  Branch: refs/heads/1144626
  Home:   https://github.com/bluez/bluez
  Commit: 98f0ab44a09b3a469c46fa1bfd4a99942642258c
      https://github.com/bluez/bluez/commit/98f0ab44a09b3a469c46fa1bfd4a99942642258c
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-08-12 (Wed, 12 Aug 2026)

  Changed paths:
    M Makefile.am
    A doc/org.bluez.CSDistance1.rst

  Log Message:
  -----------
  doc: Add org.bluez.CSDistance1 documentation

Document the org.bluez.CSDistance1 interface, which
exposes the DistanceMeters estimate computed by an
external ranging provider registered via
CSDistanceProviderManager.


  Commit: bb83226955c4db71f9810208fa10da6143416ebe
      https://github.com/bluez/bluez/commit/bb83226955c4db71f9810208fa10da6143416ebe
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-08-12 (Wed, 12 Aug 2026)

  Changed paths:
    M Makefile.am
    A doc/org.bluez.CSDistanceProvider.rst

  Log Message:
  -----------
  doc: Add org.bluez.CSDistanceProvider documentation

Document the org.bluez.CSDistanceProvider interface,
implemented by external clients to expose per-device Channel Sounding
distance estimates that BlueZ reflects onto the corresponding device
object.


  Commit: 6eabbb4c9284acc88c7339d24a7dfc8db76d2d2d
      https://github.com/bluez/bluez/commit/6eabbb4c9284acc88c7339d24a7dfc8db76d2d2d
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-08-12 (Wed, 12 Aug 2026)

  Changed paths:
    M Makefile.am
    A doc/org.bluez.CSDistanceProviderManager.rst

  Log Message:
  -----------
  doc: Add org.bluez.CSDistanceProviderManager documentation

Document the org.bluez.CSDistanceProviderManager
interface, used by external clients to register and unregister
themselves as Channel Sounding distance providers via
RegisterDistanceProvider/UnregisterDistanceProvider.


  Commit: 5f86af84d08d860733e425026cc1955591b82e6d
      https://github.com/bluez/bluez/commit/5f86af84d08d860733e425026cc1955591b82e6d
  Author: Naga Bhavani Akella <nakella@qti.qualcomm.com>
  Date:   2026-08-12 (Wed, 12 Aug 2026)

  Changed paths:
    M Makefile.am
    M src/adapter.c
    A src/cs_distance.c
    A src/cs_distance.h

  Log Message:
  -----------
  rap: Add CS Distance provider D-Bus API

Introduce org.bluez.CSDistance1 and org.bluez.CSDistanceProvider1/
CSDistanceProviderManager1 D-Bus interfaces following the existing
Battery Provider design.

External providers can register a root path
via RegisterDistanceProvider and expose per-device
CSDistanceProvider1 objects; updates to their DistanceMeters
property are mirrored onto exported CSDistance1 objects via
btd_cs_distance_update(), emitting a PropertiesChanged signal.

The CS provider manager is wired into the adapter lifecycle,
created on adapter setup and destroyed on adapter
removal, mirroring how battery_provider_manager is handled.


  Commit: fccc3b9adcfec89b10f52fe83daf16e288de9f3b
      https://github.com/bluez/bluez/commit/fccc3b9adcfec89b10f52fe83daf16e288de9f3b
  Author: Naga Bhavani Akella <nakella@qti.qualcomm.com>
  Date:   2026-08-12 (Wed, 12 Aug 2026)

  Changed paths:
    M client/cs.c
    M client/cs.h
    M client/main.c

  Log Message:
  -----------
  client: Add CS distance display support to bluetoothctl

Track org.bluez.CSDistance1 proxies and append/remove
them on InterfacesAdded/InterfacesRemoved.

Print the DistanceMeters property on PropertiesChanged,
and show it under info option alongside the existing
Battery Percentage and CS Active properties.


Compare: https://github.com/bluez/bluez/compare/98f0ab44a09b%5E...fccc3b9adcfe

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
