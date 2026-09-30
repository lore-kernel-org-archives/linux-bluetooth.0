Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735DE52120A
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Sep 2026 14:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790777441; cv=none; b=NLZoejXzoN+9Y2iOLz7xuNKVQeHcTzUaLncR/R2K5G21uB+1Yp4uoxotctMGSaF+tf864RU4oWDMrLZtcao6BAjKX8tvyinWRT7m80qGxpGSyPPuRUaWYoOcZGdjOxGNAAX+qT7/vvr4kX4VyO36zZUTiyGhbIaCC1aHWLP19JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790777441; c=relaxed/simple;
	bh=WJmiwokzQ2J3VNABVAUK0Lg1rPF9gvxfpsJIW9hGvUs=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=BF6+vDhMd2XSKjJZla5KfVB57OIJ1XdWHHWDF94vuHMXDUa/4pnht2ZVbMd7SWxXEKxnZnxGfkYg31I1vgBNTqrjyh5i45uS283jCBmFdgH9RsJroVm6h8IjQDl6LBp3XWvDBA75+sfZU72jhYdueVzbXCYHojBya/d+fdfLo4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=cpnRF3RN; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="cpnRF3RN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1790777422;
	bh=aofwVZlunziLXYyKxm5D1Cm1GnPCNKb2wom99ZUnBDU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=cpnRF3RNR2OE5wcKMiS/4OgZHmrhg8JtzISSunSAkHM1B2twBzZFAFx+d84J+mpU4
	 OcV2phyyxhrgwchFE2by5ATtni8O2YDwHGObtoVnibdhBA/gJO/ppklX9bes+JeIOB
	 GhKxOjXMeZvklvzL+ABQEHFRrdAbJicaKVgphM3XHOIiRCjd3mnfrtzTXiOj6OGJuI
	 ciQ1AZ717v8He2d0ii12VlXMPgJ29H+JmT44kqsIvq1ZJlPauWtvmja2Ih6iwcwEg6
	 2cUJb7fqXrY0oucEyDTiQ0Q0T5B4k0jon0kd0VB6zenp3OwdKkv5EmrOL3/Ybao+Zq
	 Ta8Zfy9vykN4w==
Received: from github.com (hubbernetes-node-a4ab643.va3-iad.github.net [10.48.138.21])
	by smtp.github.com (Postfix) with ESMTPA id 499CD18143E
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Sep 2026 07:10:22 -0700 (PDT)
Date: Wed, 30 Sep 2026 07:10:22 -0700
From: devgianlu <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1176731/000000-9da276@github.com>
Subject: [bluez/bluez] 9af06c: shared/gatt-db: Always notify service removal
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

  Branch: refs/heads/1176731
  Home:   https://github.com/bluez/bluez
  Commit: 9af06c7096caf1dd02209dc8f46ed980f0b096ee
      https://github.com/bluez/bluez/commit/9af06c7096caf1dd02209dc8f46ed980f0b096ee
  Author: Gianluca Altomani <altomanigianluca@gmail.com>
  Date:   2026-09-30 (Wed, 30 Sep 2026)

  Changed paths:
    M src/shared/gatt-db.c

  Log Message:
  -----------
  shared/gatt-db: Always notify service removal

gatt_db_service_destroy() only notified removal listeners about active
services. A gatt-client discovery keeps services that are not active
yet in its pending_svcs queue, and it only drops them from that queue
through this notification. When such a service is destroyed while the
discovery is in flight, for example through gatt_db_clear_range() after
the link drops mid-discovery, the queue is left pointing at freed
memory, and discovery_op_complete() then dereferences it:

  gatt_db_service_get_active (src/shared/gatt-db.c)
  discovery_op_complete (src/shared/gatt-client.c)

Notify removal whether or not the service was active. The other
removal listeners already ignore services they never saw added, since
services are only announced when they become active.

It is reproduced by connecting over LE, reading one characteristic and
disconnecting about once a second, so that the link repeatedly drops
while bluetoothd is still discovering the peer: on 5.72 bluetoothd
crashed on the 15th connection in 4 runs out of 4.

The same change was found independently in
https://github.com/ownback/airpods-bluez-fix.

Assisted-by: Claude:claude-opus-5-5


  Commit: 9da2762fc2d1ff895a45a2be4073c58d2af66f1e
      https://github.com/bluez/bluez/commit/9da2762fc2d1ff895a45a2be4073c58d2af66f1e
  Author: Gianluca Altomani <altomanigianluca@gmail.com>
  Date:   2026-09-30 (Wed, 30 Sep 2026)

  Changed paths:
    M src/shared/gatt-client.c

  Log Message:
  -----------
  shared/gatt-client: Fix double-queued service

discovery_op_create() loads every service already in the client
database into pending_svcs, active or not, and discovery_found_service()
then queues an inactive service again when it finds it. A service left
inactive by an earlier discovery that was cut short therefore ends up
in the queue twice.

If that discovery fails too, discovery_op_complete() walks pending_svcs
with its removal callback already unregistered: the first entry removes
and frees the service, and the second one dereferences it:

  gatt_db_service_get_active (src/shared/gatt-db.c)
  discovery_op_complete (src/shared/gatt-client.c)

Only queue an inactive service if it is not pending already.

Assisted-by: Claude:claude-opus-5-5


Compare: https://github.com/bluez/bluez/compare/9af06c7096ca%5E...9da2762fc2d1

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
