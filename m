Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B2E368D74
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 May 2026 08:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779436887; cv=none; b=LQ/Jd9UgvW34PVC+cfMJ4lDYRMSyeNBprWNAa6jRJmcKRNVS0mbDJ8ts8jx6uFBMsZDmTYGItKFOZfMUddt/vqeYDZkJZyUHsYh2SARV8x4H2QVe64941iSk3XyLjxiCD/ur3Tw941w8JjbRtUGkNZOYEcnp0JwqIO2mznTq30A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779436887; c=relaxed/simple;
	bh=nBalcQq4Zcej26kcMsM5CDjtAiqswch9JvdWJpWZ/Uw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=kZGs9em7Y76D8oGMQGQKxUpZgUKoOEWts1gZbrQBUYtb3MrXQ8pNndFxn2RtVyJkHr5fihOeIPg+g+AKm5+8r81Ss/zyXVCfyTHhxXDIXHDfzPhiQ2lR4CXBDwYdjwtoYLO8Rd/L1zrd7nT1XAHCuykjiiZ0RxCIUtOM73hWKy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=lthU6DLm; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="lthU6DLm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1779436885;
	bh=K2287Qsc2FXe/gaCssPltymz9zYxi3qVyKC6CagOaUY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=lthU6DLmTYiHrsUjx1Otmumd3oio4U9mk+JwYnf/bldSkEzH3OqBejrA3DiHQj615
	 gWeegK1syN145e9Ne3rZm5IXpZAGlYmM3F8qY/4x2mDCicsGbhscFpy7z8Y5n6S1SZ
	 HK0I/3tVQlhdCgL2E4+oRs+vpTqEdH/3+X5k4Kdg=
Received: from github.com (hubbernetes-node-4eecc93.ac4-iad.github.net [10.52.13.14])
	by smtp.github.com (Postfix) with ESMTPA id 832D0781080
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 May 2026 01:01:25 -0700 (PDT)
Date: Fri, 22 May 2026 01:01:25 -0700
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1099150/000000-f00fac@github.com>
Subject: [bluez/bluez] f00fac: obexd: fix PBAP PullPhoneBook failure with
 ebook b...
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

  Branch: refs/heads/1099150
  Home:   https://github.com/bluez/bluez
  Commit: f00faca1eda199fb974b5c58a0011f9e86318954
      https://github.com/bluez/bluez/commit/f00faca1eda199fb974b5c58a0011f9e86318954
  Author: Zhiyuan Sheng <zhiyuan.sheng@oss.qualcomm.com>
  Date:   2026-05-22 (Fri, 22 May 2026)

  Changed paths:
    M obexd/plugins/pbap.c
    M obexd/plugins/phonebook-ebook.c

  Log Message:
  -----------
  obexd: fix PBAP PullPhoneBook failure with ebook backend

phonebook_pull() in phonebook-ebook.c does not set *err = 0 on the
success path, unlike phonebook-tracker.c and phonebook-dummy.c. The
caller vobject_pull_open() in pbap.c declares 'ret' without
initialization and passes &ret to phonebook_pull(), so 'ret' retains
an indeterminate stack value when the ebook backend is in use. The
subsequent 'if (ret < 0)' check then incorrectly triggers and rejects
the request with Internal Server Error.

Fix this by setting *err = 0 on success in phonebook-ebook.c, and
initialize 'ret' to 0 in vobject_pull_open() as a defensive measure
to guard against any backend that omits this assignment.

Signed-off-by: Zhiyuan Sheng <zhiyuan.sheng@oss.qualcomm.com>



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
