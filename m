Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D765267393
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 May 2025 16:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746204045; cv=none; b=lD1iA35c81h0zpMv83KKGYwGz+I/o57pQlwMhoNMoNVm/d9NxDoEb4MVNuxzaTrYd0gavEKF5GwrxXZpUZ5WrsvdRenZh42tfDi+2gW9D9QfNnINgjbQ0knO4EuYfx4sBzyK8VV3ObTPpXT85rrWOwp9qOZoWxGlr/YCLXyBoac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746204045; c=relaxed/simple;
	bh=0cUKiWPJf3Bo3tL2PP8Q2hEMqtzmrk0y0SH162EFXlM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=GyZz3qaxGmJjQ3bykTYnUBLwVai92/yhDShVmdxymDH909QJP7EunI0tA33rg4eOT75smP50IG2pp0TPJaOZJCvHDJsPUg7fy5LhzXH9QhMoPSIpNqCVeJi3Kky9UgG/Ta4BTA+liLoZq3ORu6dmvIU5xFITBwQi0diT8Yx+Hhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=a2SMHj80; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="a2SMHj80"
Received: from github.com (hubbernetes-node-d98ef1c.va3-iad.github.net [10.48.141.18])
	by smtp.github.com (Postfix) with ESMTPA id 9A3E54E0A16
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 May 2025 09:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1746204041;
	bh=ci2tvLDyJv+Enq+Q9qm8bZZlEGrAP9LZ6gJH7aXUxhw=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=a2SMHj80jxbrzW9oXhPqth2ArQiUDVdV/zdOCFC9GiLIbt/TTsjeUsjhGdJ8Qp62q
	 EqiwMq8N2ZhdLZznKt9lGW6suiHeIlH26jANFmdepbVCsQPRe90OYAyr09ZYCxZ8r0
	 LyKol+twUvlMa5uMvzR1SEl7EZCsGVLys2ZxYjBI=
Date: Fri, 02 May 2025 09:40:41 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/959149/000000-571b64@github.com>
Subject: [bluez/bluez] 571b64: mainloop: Only connect to NOTIFY_SOCKET if
 STATUS=...
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

  Branch: refs/heads/959149
  Home:   https://github.com/bluez/bluez
  Commit: 571b643cfb11348feda2f526279526168b2d726b
      https://github.com/bluez/bluez/commit/571b643cfb11348feda2f526279526168b2d726b
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-05-02 (Fri, 02 May 2025)

  Changed paths:
    M src/shared/mainloop-glib.c
    M src/shared/mainloop-notify.c
    M src/shared/mainloop.c

  Log Message:
  -----------
  mainloop: Only connect to NOTIFY_SOCKET if STATUS=Starting up

This makes the handling of NOYIFY_SOCKET conditional to only when
application attempts to set STATUS=Starting up which means it is
intentionally requiring it.

Fixes: https://github.com/bluez/bluez/issues/996



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
