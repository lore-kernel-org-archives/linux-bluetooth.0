Received: from out-42.smtp.github.com (out-42.smtp.github.com [192.30.252.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91955319851
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Apr 2026 18:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776449385; cv=none; b=L/ozCzQyM5K+/tcOQncPbGywph9EtZbx4fVh6iqq6O+39Bf0r0ulpJ/QfgPSq9LuQtc1uBHmdWgeZWvK9xDA+Jzuv5bWYcw2p+ROQkJd11aePAdjeV15UnDV2EZJl7mYRt9kEXf9Skr1tbkOYYknOq6SLuQ/hrnPAWOQw+qVCQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776449385; c=relaxed/simple;
	bh=XSSE91Zx7EtCSHzZ0O7M7jEyjpgnZ8GrWxB0OwkeNKk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=mGIkc3uHhf/sRNVeYw+wmCUkeH8Iwi1R060AZlz+bTgVBuD+wFOBULmUDym9WmvAggifo7TjzmGzvgWr8fCISdDU0jLgogxSWA5JVzk3bDNhMNF58Sz2R63pq7MK4VOoCv48YQDlB0wBvQVUUs7SL16d7EfijhbDZ17mQU8uzng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=HDooVp0P; arc=none smtp.client-ip=192.30.252.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="HDooVp0P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1776449374;
	bh=gwlIAD7UM777QxuBVVOErc2nY7VLx+59m4j+ym4PJWY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=HDooVp0PNpNhtpF5Damm7r7nA7NyqpyirRhS+CJTH/jKPXHjmMZ/0xNRqYQRRwwMS
	 IM78hRSJw3Uk9Q/iqXOs1JAlrCk4oVrIZE1a07WA1mvOCF5qLi9+G/AmvP5E21V5Oc
	 WuVZyiIP0+JGKOL6ekKGP3hUJnG9gJkLuFk8oH3g=
Received: from github.com (hubbernetes-node-582b3a7.ash1-iad.github.net [10.56.209.88])
	by smtp.github.com (Postfix) with ESMTPA id 93A488410FD
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Apr 2026 11:09:34 -0700 (PDT)
Date: Fri, 17 Apr 2026 11:09:34 -0700
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/ce07e9-73c694@github.com>
Subject: [bluez/bluez] 08e11b: unit: Add unit test for new MIN/MAX macros
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
  Commit: 08e11ba7262feb9333d75b046ed5702e05350c5c
      https://github.com/bluez/bluez/commit/08e11ba7262feb9333d75b046ed5702e05350c5c
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-04-16 (Thu, 16 Apr 2026)

  Changed paths:
    M Makefile.am
    A unit/test-util.c

  Log Message:
  -----------
  unit: Add unit test for new MIN/MAX macros


  Commit: 73c6943f06363591d9fe77b241a8acef7e74ae0e
      https://github.com/bluez/bluez/commit/73c6943f06363591d9fe77b241a8acef7e74ae0e
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-04-16 (Thu, 16 Apr 2026)

  Changed paths:
    M client/mgmt.c
    M mesh/prov-initiator.c
    M src/device.c
    M src/gatt-database.c
    M src/shared/gatt-client.c
    M src/shared/gatt-helpers.c
    M src/shared/ringbuf.c
    M src/shared/uhid.c
    M src/shared/vcp.h
    M tools/advtest.c
    M tools/btgatt-server.c
    M tools/hcitool.c
    M tools/parser/rfcomm.h

  Log Message:
  -----------
  all: Remove redundant MIN/MAX macro definitions


Compare: https://github.com/bluez/bluez/compare/ce07e906e499...73c6943f0636

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
