Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA96762EB
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Sep 2024 19:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726081589; cv=none; b=RiHnZ6zPaBkyv2TDCMvB1wvx4R+yD1Wsk5sfkvPMVRlebHpnkcdHoKKcdzOPfLujujGQ/aU881mn25M3kLmvCfuJJCAd4gZAPrL0qTJbiWKLtsoPfH9HttZAY3s7rL1FGkSAAhoNQQtBfLD/bdWGiocdF7tfx4O4xCM+RIHdWL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726081589; c=relaxed/simple;
	bh=pfsUI5hrS2rK2T2PgCn3Oj2oBpudB7u3OaWtfzHl9oM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Kr8JuCkG1sH0s0OtxNGF63p2s0cKl1CMnOMfFhfA5SoQ69ZJn+uHmJ+29b0ACxbgegD5aAqA1Mhg0fUWe6Cd6rCKn4RiM9gzI/+gFfWtuxNAmGeFN85hwe1RmRoptDmla6najLEhhXpLvLPMjtH1fgYnl3+wviNCtVX7LPgMNhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=grAapdO+; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="grAapdO+"
Received: from github.com (hubbernetes-node-4f32464.ash1-iad.github.net [10.56.166.36])
	by smtp.github.com (Postfix) with ESMTPA id 4F6B01412F4
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Sep 2024 12:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1726081587;
	bh=kOCEcj+SDQMgE1dM4iBbMaHDy6cikTwEP+eBwKZhbcs=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=grAapdO+fG1BESaMHd2An8PW1be0+U97UIDRF5qFTbTJK+YW/M6bVyPAEQa/9SpXi
	 qx+Cecl/dvksXC7xKtU/l523HMr1azk92euQAy9zhw2Lp2oAW68urpxqW5FzYgO/4i
	 SNGPejWoYBeF2jBbI2f79HgJM8Edw2BiSurZdWMI=
Date: Wed, 11 Sep 2024 12:06:27 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/615fc3-d8a4b1@github.com>
Subject: [bluez/bluez] d8a4b1: build: Fix distcheck
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
  Commit: d8a4b126c1d7ef1cf8994681ccb413b59bee29b5
      https://github.com/bluez/bluez/commit/d8a4b126c1d7ef1cf8994681ccb413b59bee29b5
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-09-11 (Wed, 11 Sep 2024)

  Changed paths:
    M Makefile.mesh
    M Makefile.tools

  Log Message:
  -----------
  build: Fix distcheck

This fixes the following errors like the following:

../../mesh/mesh-config-json.c:31:10: fatal error: mesh/missing.h: No such file or directory
   31 | #include "mesh/missing.h"
      |          ^~~~~~~~~~~~~~~~



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
