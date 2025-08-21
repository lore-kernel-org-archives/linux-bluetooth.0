Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FDE46B5
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 Aug 2025 13:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755784553; cv=none; b=dFwBwq56k25lqldxeJ+IF3pYjMCz1ujbPKy1GI+0C3hUl7XR2BYaAGebjTvKSRqoeK9qIoktFK9O60AvD6Q6+dTpcVV1ctCTjD+RHFT6x8cgo0fqumt0qnJaZEqlJpCgzx4Chdx55lMTPvfKVgeL7ogajPUbzUajbRssd4x4u2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755784553; c=relaxed/simple;
	bh=omjfCudaLob7/hbPgDv0t8LxRCXi1mA9F97R/OSoAps=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=A8uHstdFs+SHIthf35P1lcgPAhGhI0jPk7nlzu6EV+ZnOVYClmlA8MmE+zLn0rd/RzjUcXnZbrJ9WNviXxdxaHJMOIAN/xDPIyuGPL1YgwqYErq3Fs98Z9f95d9/3th/gCsaaDeRUie/sWux4lHUYe0qzXhoaa9kxuFvvbNrvvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=At1u0Qie; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="At1u0Qie"
Received: from github.com (hubbernetes-node-e2296be.ash1-iad.github.net [10.56.168.30])
	by smtp.github.com (Postfix) with ESMTPA id 311C61412E9
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 Aug 2025 06:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1755784551;
	bh=ew9xuKUq9+cy8knChvN5AOh9oienBNyniBIVbHfInwg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=At1u0QieWOs1i1fUpjD5xdRZpjpV+yiUf6Kq14o+oo7QB2NWPsTrlqdLT7+0vjxfR
	 OTtAQcN+C90aQjHc4xugGYHBBfrzSZyor2ZIr0nfavtqgP/cjK+FVZ4/FEQG+GiEQX
	 TOgNclIB+eRU+r68wAiNFOkERVOAGmCVHnvQrYok=
Date: Thu, 21 Aug 2025 06:55:51 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/994059/000000-d338b5@github.com>
Subject: [bluez/bluez] d338b5: monitor: Add support for -K/--kernel
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

  Branch: refs/heads/994059
  Home:   https://github.com/bluez/bluez
  Commit: d338b5f0cb4a2e714309366187bd8e09fd56a864
      https://github.com/bluez/bluez/commit/d338b5f0cb4a2e714309366187bd8e09fd56a864
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-08-21 (Thu, 21 Aug 2025)

  Changed paths:
    M monitor/btmon.rst
    M monitor/control.c
    M monitor/main.c
    M monitor/packet.h

  Log Message:
  -----------
  monitor: Add support for -K/--kernel

This adds support for -K/--kernel that open /proc/kmsg and attempts
to print messages starting with 'Kernel:':

> monitor/btmon -K
= Note: Kernel: BNEP (Ethernet Emulation) ver 1.3
= Note: Kernel: BNEP filters: protocol multicast
= Note: Kernel: BNEP socket layer initialized
= Note: Kernel: MGMT ver 1.23
= Note: Kernel: RFCOMM TTY layer initialized
= Note: Kernel: RFCOMM socket layer initialized
= Note: Kernel: RFCOMM ver 1.11



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
