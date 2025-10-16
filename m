Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB071B0437
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Oct 2025 13:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760621846; cv=none; b=MyvazZfsIZm+WuOCtOLAMtr1W0UL+svI59IkvdUp3lsH9gP60/arOaHkvn1Y9fAPpabM3bSD6QrBM3tH/APIgMDHHR5g7ambcOjplH1xTz6qxsBKeg1qopgtUlm3RStxC4/H6HZOxkf77FxrdIh2GNzC5+CsKs6EXgn4JYV2WKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760621846; c=relaxed/simple;
	bh=3m2ZNXIa25hOaKB0YwZm/1vkLIDGYW6sLq1gUDrZECQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=pXIdZ/1zjZHOKC/znu0yUhKAbU0bHwUCK8lYr7kaiTD23q8s9VbO1wQFe5xYAFPVeEX8q3ObmsiRT7UOKYBhTeJC9tPkC+1bVFnR+AwHF4gZIivZ1Vfsq+D5leqnZZ/jUPx10As8qtkZALBLvtD8qJtypZ55ChGyp5zTynq8TK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=KPxhTk71; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="KPxhTk71"
Received: from github.com (hubbernetes-node-bd650b1.va3-iad.github.net [10.48.169.35])
	by smtp.github.com (Postfix) with ESMTPA id A719C8C057F
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Oct 2025 06:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1760621841;
	bh=cLKWmUw9XJCLyx2Xa62Sqew7jlPZh9QusRiGZSddn5s=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=KPxhTk713IiQLVVPG1WESqxwjFh+Gu2oIk3PTpLCLfildURC8JR90rWzfP6P0hErg
	 NRGRs9q1j2y1ct87F/Vw3CZqpA8hgvFYSQ97X1xhWOBWrFgcFDuDbtU6yTq+zr2esG
	 CHQ/UsqYp1ODuFBsinC6d5QBiLr7630VxunBfzzM=
Date: Thu, 16 Oct 2025 06:37:21 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1012365/000000-34dd68@github.com>
Subject: [bluez/bluez] 34dd68: mgmt-tester: Fix handle value
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

  Branch: refs/heads/1012365
  Home:   https://github.com/bluez/bluez
  Commit: 34dd683473493fd9c3e1838cbc8df324778caecd
      https://github.com/bluez/bluez/commit/34dd683473493fd9c3e1838cbc8df324778caecd
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-16 (Thu, 16 Oct 2025)

  Changed paths:
    M tools/mgmt-tester.c

  Log Message:
  -----------
  mgmt-tester: Fix handle value

Recent changes to emulator has changed the ACL handles to start at
handle 0x0001 in order to use dedicated ranges for different link
types.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
