Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C290A3368A5
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Apr 2026 21:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775078638; cv=none; b=pOuCGukSrFH4LrGrRU41aqvksTIYiWWrh6SOmaNUoN4gDhbibFiBoJY9gpvQY4u8bzYa1+L5VK04fjScvoF5FiCBRFJpYE/yWZoqdvxgd98EC7r27dJvWOVgR87/vSxv8jBDkBdOgacF5o8aBudzNJ53yChEal3g1EY6sUY9+Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775078638; c=relaxed/simple;
	bh=59fjzYUw7fqaqGp2YJq8H9Xm0UAHRwa1+c/dblkv7SE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=bS5/Po+OBCJgGMxjFbSuqOuImebk2qv9/yXKSPU/2o0dpjPMHksQMQd7v49X3jI0oDJolPHGVGxb5iMIGTMs/ZjCre3lzGqbhX57B3Iy4Ek5mrsfaTGiqaYi4/AXJp753SdrSKAOYyVw1vA1yP/wRGSzSsZOnOKlOhVkv2EhMT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=LdQlMtvx; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="LdQlMtvx"
Received: from github.com (hubbernetes-node-d8eb6f9.ac4-iad.github.net [10.52.144.43])
	by smtp.github.com (Postfix) with ESMTPA id F25E8640529
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Apr 2026 14:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1775078636;
	bh=oywiMif6Bxutjd7apqI4H76LimLWjqB0aKx07ZXt+0s=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=LdQlMtvxNEQ/jQH9jFVC+AqqD2Pc24Ax5Iy0pOO3ARmBV8DSx/nxjFuNmPw41K79r
	 NwIV0/v/4+HNYsT25O2lgfMFw2pVS794Vz8oBZ+VuNWW8OQ7DA3q6NcJRUvrFcZQDk
	 gycjAMplsQnMjULZ7P71UQPBkMlKbeEh+/0V50Yg=
Date: Wed, 01 Apr 2026 14:23:56 -0700
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1076045/000000-1e294a@github.com>
Subject: [bluez/bluez] b36d2b: unit: Add unit test for new MIN/MAX macros
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

  Branch: refs/heads/1076045
  Home:   https://github.com/bluez/bluez
  Commit: b36d2b00c8d0c0dd1471921b2aa0704860dfd3af
      https://github.com/bluez/bluez/commit/b36d2b00c8d0c0dd1471921b2aa0704860dfd3af
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-04-01 (Wed, 01 Apr 2026)

  Changed paths:
    M Makefile.am
    A unit/test-util.c

  Log Message:
  -----------
  unit: Add unit test for new MIN/MAX macros


  Commit: 1e294ad65ec8001956c96375ea6e816e26b1aaa0
      https://github.com/bluez/bluez/commit/1e294ad65ec8001956c96375ea6e816e26b1aaa0
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-04-01 (Wed, 01 Apr 2026)

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


Compare: https://github.com/bluez/bluez/compare/b36d2b00c8d0%5E...1e294ad65ec8

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
