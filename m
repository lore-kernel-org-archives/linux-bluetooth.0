Received: from xtrwsrct.outbound-mail.sendgrid.net (xtrwsrct.outbound-mail.sendgrid.net [167.89.101.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8C0341076
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Dec 2025 19:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.89.101.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765828228; cv=none; b=hJ93xAt5+KCYGP674P5ndO9YxiRQOg04rX3KsjQWp9OYxxnLpWtqeLKTgCL/umZfY565VoB/pPGwGauH2V0n41PDWxISWmVR7+q2Dh/gTS26t1OapXq1QXHfehG6wKJIJVNDLGMvoqV2og0UE2ypoV1IqeJGpJu9MH3zVjT91AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765828228; c=relaxed/simple;
	bh=Dkr/Xs3KxjNKI+4687jy3mQ52x7TgUGK0T4LpD7Q8a8=;
	h=Date:From:Message-ID:Subject:Mime-Version:Content-Type:To; b=HTlqgrgqQ/xgHhEre7M6Xtl5I/6HOV+cfpl80Pqlyw25rzSrCw8TWPYgoVNCTk8AiRMu32A678DouRf/PnGg9zZvMqauMB6h3v1XH6l3dWFpGveBPqe7SRjdLL173Mo74jRh282+uGcebcvJz6Fsf34yv7QFWTlOGjtG2NsukOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=sgmail.github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=NwR88Bq+; arc=none smtp.client-ip=167.89.101.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sgmail.github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="NwR88Bq+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	h=date:from:subject:mime-version:content-type:content-transfer-encoding:
	list-unsubscribe:to:cc:content-type:date:from:subject:to;
	s=smtpapi; bh=uIQhzGlB50ZjBXdwFi+8xkoN6bOfuS6koondZ08qb1Q=;
	b=NwR88Bq+s0It4bkNuG8sHOumIiKpCe3pFfzo8Kodw1ciPGopNSiMeMwut1gM4KbHxTr5
	tFJrQi2jTHlwlFAYqVXKj6I+VEGo7nJyADVmknMy9FVZ/z09n1szrdzyPIcEWehZDtNdQp
	ZVmlk+5FFVFtpLgudBlFcVL3BLE05Nxb0=
Received: by recvd-canary-7fc4469768-hzrng with SMTP id recvd-canary-7fc4469768-hzrng-1-69406681-70
	2025-12-15 19:50:25.637276146 +0000 UTC m=+3617316.214482710
Received: from out-24.smtp.github.com (unknown)
	by geopod-ismtpd-9 (SG)
	with ESMTP id dZn3zpDsT-ahnMCxPClbdw
	for <linux-bluetooth@vger.kernel.org>;
	Mon, 15 Dec 2025 19:50:25.614 +0000 (UTC)
Received: from github.com (hubbernetes-node-0d93c7f.ac4-iad.github.net [10.52.202.74])
	by smtp.github.com (Postfix) with ESMTPA id 32BB9640978
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Dec 2025 11:50:18 -0800 (PST)
Date: Mon, 15 Dec 2025 19:50:25 +0000 (UTC)
From: BluezTestBot <noreply@github.com>
Message-ID: <bluez/bluez/push/refs/heads/1033273/cf6d79-000000@github.com>
Subject: [bluez/bluez]
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All
X-SG-EID: 
 =?us-ascii?Q?u001=2EyVDaIUJfOTIVaBYkJvNzXFDwUvSfXABmYIMG7o2yQ0XjHiQN8HeKlKfUQ?=
 =?us-ascii?Q?+TD5y9uUDiSc3WCQ=2FbFOxbFL1vD479ITsVE1zKd?=
 =?us-ascii?Q?bKdRtSV5uFxSpn3ytY0ve+p6Ls2=2FEh+iW6lV3gT?=
 =?us-ascii?Q?+t+whlTBmVAoJlfxSEm0BSnXT13K7vmRnLHllOY?=
 =?us-ascii?Q?2nA0VCgdweC8zMiV+q8gbBdYxWPcpBu2n6CiTqS?=
 =?us-ascii?Q?nxzCHCsjvU8e1BES=2FcW54s69bxWXlRa=2F0Lx06Uy?=
 =?us-ascii?Q?DgsKtBOjTQyf+QLWCNRPX28rrw=3D=3D?=
To: linux-bluetooth@vger.kernel.org
X-Entity-ID: u001.h3RSp2myFsXwI84tgZKC3Q==

  Branch: refs/heads/1033273
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
