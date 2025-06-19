Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E5317E0
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Jun 2025 14:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750343525; cv=none; b=ZuEr7I9ihkk/UqO18NbmIrWUZ+56prW88EQNzGNDczS5hnagc78kMa+sIrTJyH/p4ILo9nCn7pmmSJCDj3Nj1+ogWZOKS5uGCoBn7momh7qHF16PERNjBlp6k5RNgW4t+PJOWIMGX3B6Dk37HQr0NDQphEK8jsLFdkeLUEnvybs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750343525; c=relaxed/simple;
	bh=nipWzABDoE//g45tm10Gwws8geq+E85WSJMnfly+w4k=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=kWSE/s/wDtyMpXZgmQhixhqXjLrvOmD+W2dumOL6edyGjv71EQkgK6XMV1fRP12FwK5yqXQ96rTzdX3wu9yiz1R1DfZuMYGM8cc4xcC7Qa/hBlN4eG6h0fm4DFXp9McPqFZ315SIygfydVvcwi4VT38glDU3/TE+55ORehU8ZlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=LAYSXm7w; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="LAYSXm7w"
Received: from github.com (hubbernetes-node-40dab46.ash1-iad.github.net [10.56.203.12])
	by smtp.github.com (Postfix) with ESMTPA id CBE451410A7
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Jun 2025 07:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1750343522;
	bh=wSvmhxIGiIsZrqpqMhDwWCBKas8/DHs6A/Dx/hobySQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=LAYSXm7wJtLsSpOhxauduFeXvnq+EQZ+vIveo/i33/3TnLDm1AIJ/gbdxm8EvAgQ2
	 84TU1KZwBfmgpICF3ReWBHxVCa79XC7ZQ8lO2vIwcTZiWREjzM7ebOVtymhe7DzDXy
	 okQuaK1Sq5DnjjODjBU025PGuS2EPSyvJGVcKzEQ=
Date: Thu, 19 Jun 2025 07:32:02 -0700
From: Adrian Dudau <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/973861/000000-ed138e@github.com>
Subject: [bluez/bluez] ed138e: tools: Expose the raw advertising data
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

  Branch: refs/heads/973861
  Home:   https://github.com/bluez/bluez
  Commit: ed138ed3467dcfb78375ccffc2ace3fc28cfc8ec
      https://github.com/bluez/bluez/commit/ed138ed3467dcfb78375ccffc2ace3fc28cfc8ec
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
