Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E8517E0
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Jun 2025 14:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750343528; cv=none; b=Hcse3PjGqTdB4orY2TMLr9UiQYUtfAnlIAueSEPKih5YJToVql4JgSWIsvoyZZdAFJoV7zx+WYno5IE/haSUcQenpCFzA9gigro3i1L1fEEwY7e1rkT5A/H5e2eewSdI1mvGSNwrwZQX3FtGXvBJVhg6p/JuJSrSxXxLAwX+MmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750343528; c=relaxed/simple;
	bh=cEiFE/pVVt9pjY/n831E1qwutnS4ZeUh7x8zJv8x1SM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=m0vSAEKPkvNC/CKHLExVtPI34dYqCxI/KAxx50XjaFiHu3T8+kmJD2MXzf1OGm0qdfkuAePbJfZcWzWT6y7Rooyou7tN7iqP0qj0QggA2i58O4wZsqzJwFkMahAUnGG+iD5n3GlYqrNx5vOV/p3pma2lluG4dMdEZt4HV6bfaZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=GCmZCQFx; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="GCmZCQFx"
Received: from github.com (hubbernetes-node-f86128e.va3-iad.github.net [10.48.177.30])
	by smtp.github.com (Postfix) with ESMTPA id EB10EE12B4
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Jun 2025 07:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1750343525;
	bh=3MUYc0TUVWmssqJ2XHDV7n7iuomHFq+sOh55rjTwCMc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=GCmZCQFxFukP96pJoikaAoNemxWGdCcHpF6Ks2wW4nfcTNzynbM++lBhuKVHT6Cm0
	 4JrrNPQwicjCkQ89M3MoF8/4uaIzcrrWOuZSslFwjP0tgeCSy4B22dmxdrUxwUz17a
	 o8NE2zdsGrAo38b8jKCrsT2lVECXmRm/QZK5VXhQ=
Date: Thu, 19 Jun 2025 07:32:05 -0700
From: Adrian Dudau <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/973863/000000-acc5f9@github.com>
Subject: [bluez/bluez] acc5f9: tools: Expose the raw advertising data
 available o...
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

  Branch: refs/heads/973863
  Home:   https://github.com/bluez/bluez
  Commit: acc5f929f26b88bf601845f6148d485908f77195
      https://github.com/bluez/bluez/commit/acc5f929f26b88bf601845f6148d485908f77195
  Author: Adrian Dudau <adrian-constantin.dudau@nxp.com>
  Date:   2025-06-19 (Thu, 19 Jun 2025)

  Changed paths:
    M tools/btpclient.c

  Log Message:
  -----------
  tools: Expose the raw advertising data available on D-bus to PTS tester

This patch extracts the AdvertisingData property exposed by
bluetoothd on D-Bus. It will iterate the variable message structure
and will construct the eir buffer in the format described in
BLUETOOTH CORE SPECIFICATION Version 6.1 | Vol 3, Part C.

Signed-off-by: Adrian Dudau <adrian-constantin.dudau@nxp.com>



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
