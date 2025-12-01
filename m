Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324493101B0
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Dec 2025 13:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764594463; cv=none; b=GFl2jUvvdqKrGCIoFkL/QjM8ZhcgFYZIIUw31uI58VpBOKJME2T4f9DlxSnLMdSrVivsrWWO4abbLcMpl4f1OMxx/JOrxSHO9DdzMOZnBtJLQAUi1KosqISfR+QhjdYi4vqSZ0Lb90/Vwe+6wu36y6Inq2OcqgO50lWB3mrykD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764594463; c=relaxed/simple;
	bh=QOggjRq/yBPxMM3sWE44K+FYgk37ODiM90UovXx+OAg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=XaPMKUz2NRIGnAc88nnXkis0auIoWI3sB2NTW18uaYFySWUJmKXI9Ql64q1Kd5e0kfJ/AQIFvrYTSUDWySPvVE4eGfURYtXIeAAYoCwMMmghpz30FCroUh/hWN31d92qioR827KrHMKEMPEeeYUjODuOzNOSIEEzDgDoVmZjvnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=aRUbQznk; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="aRUbQznk"
Received: from github.com (hubbernetes-node-9977079.ac4-iad.github.net [10.52.143.36])
	by smtp.github.com (Postfix) with ESMTPA id 5477020445
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Dec 2025 05:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1764594461;
	bh=JoDrWBlIjxqSf8i/mACtK7DKKRfwogFvQa6J0RtdmhQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=aRUbQznkQYpYhlMECMvrIQTEHqBL8xSSUwPkYeXi7V/eoU7IWBnMGt8OfSWL2nz+S
	 VcK/895EO5IP5eKUd0rx2d5trHoHQZszvOfpHEWp89MWl2f94vuWCRsNrGpYIZZtVY
	 W9n52DrOD4hvCsf8J+QlW9U4lijmYPO7GMqdeYwg=
Date: Mon, 01 Dec 2025 05:07:41 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1018491/5d2fa5-000000@github.com>
Subject: [bluez/bluez]
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

  Branch: refs/heads/1018491
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
