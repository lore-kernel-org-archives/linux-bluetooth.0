Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A01A32
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Jul 2025 20:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752264042; cv=none; b=Cn5/N7vf+PEnio4+TTxHqlv+uE/Uaw5ur60pmKmiL/8EdiSS6QhJHI2CX68RMH68VR/nCF+J4J7f8thVr8sA1CZAgjFw/N9ejLqAg+Sj29jlOuRcC6+O7giJg37rl9zTzs+T4oJBmLPHH6sXLcDvmbrWvYMy9C30kKoIZrwgcpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752264042; c=relaxed/simple;
	bh=f96HlJ8ruXvar9iLhw88xd5Ph+NyqmHzUPtQRCEJ/DY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=dowZO2hpYwgLdtHJ3eTg3ek65LqnCA37xhDrualG/o35gOGzPkrqJmE0nc04BJIdka+Jhw0dkY3ARJSVtbziFYij+Vu2o49zIGqpW7YSBN44cmJa/D9jvvQDIVc5nZ1BF31/3TeVdbiOuoMzplrEdheoqyvPFIvSJvwS0paZ++8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=jKb/9neb; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="jKb/9neb"
Received: from github.com (hubbernetes-node-dc10950.ac4-iad.github.net [10.52.153.32])
	by smtp.github.com (Postfix) with ESMTPA id 0944621252
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Jul 2025 13:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1752264040;
	bh=rcSqGl8SctqJGJVd4yTSOD31hThP+U7qy4B1aDe0ix4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=jKb/9nebIsHStNpCZ3BxeSQDpT+3vKyfMND+X5fODY/w2C2nl3aXOjTW44V2WSbmm
	 7ZLHInZFwhACQGuzzOmb9GjbH5en98rbFgxb0vWxDTJDplmunaiB3GOqdu4kEEnpjD
	 zX5xuhUH0CiYkzUuez3HW1nOUKWdHVmKPeLAEOes=
Date: Fri, 11 Jul 2025 13:00:40 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/981640/000000-8b6c28@github.com>
Subject: [bluez/bluez] fb33aa: device: Add btd_device_bdaddr_type_connected
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

  Branch: refs/heads/981640
  Home:   https://github.com/bluez/bluez
  Commit: fb33aa12910d5bab124a890aba25f18c8aeb5d7e
      https://github.com/bluez/bluez/commit/fb33aa12910d5bab124a890aba25f18c8aeb5d7e
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-07-11 (Fri, 11 Jul 2025)

  Changed paths:
    M src/device.c
    M src/device.h

  Log Message:
  -----------
  device: Add btd_device_bdaddr_type_connected

This adds btd_device_bdaddr_type_connected which can return the
connected state based on the address type.


  Commit: d453ec447a19aa631623048946b89afb1bc4e51d
      https://github.com/bluez/bluez/commit/d453ec447a19aa631623048946b89afb1bc4e51d
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-07-11 (Fri, 11 Jul 2025)

  Changed paths:
    M Makefile.am
    A doc/org.bluez.Bearer.BREDR.rst
    A doc/org.bluez.Bearer.LE.rst

  Log Message:
  -----------
  doc: Add org.bluez.Bearer.LE and org.bluez.Bearer.BREDR

This adds bearer specific interfaces so they can properly be operated
separately.

Fixes: https://github.com/bluez/bluez/issues/1350


  Commit: 8b6c2872a4016681421fa16da8360494527ffa3b
      https://github.com/bluez/bluez/commit/8b6c2872a4016681421fa16da8360494527ffa3b
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-07-11 (Fri, 11 Jul 2025)

  Changed paths:
    M Makefile.am
    A src/bearer.c
    A src/bearer.h
    M src/device.c

  Log Message:
  -----------
  bearer: Add initial implementation of org.bluez.Bearer.{BREDR, LE}

This adds initial implementation of org.bluez.Bearer{BREDR, LE}(5)
interfaces.


Compare: https://github.com/bluez/bluez/compare/fb33aa12910d%5E...8b6c2872a401

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
