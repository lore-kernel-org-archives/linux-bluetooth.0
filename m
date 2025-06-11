Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F674287519
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Jun 2025 13:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749648021; cv=none; b=Ad4r0q289KaIC02HyQeeSfM0uGYYIYY4CUSB0Kh1w/4W1nGXExlhxsr6jbPbsS1Tgd57NvEEZmljUWUU+KE5AYH6suBFBTrYFdSH6Pxzmdd6M0dgZlgPmDmRj3d1ySEnkowDRCZJ6dEduuIjVgBWPf3g3N8eq0YDLgv8nylhj9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749648021; c=relaxed/simple;
	bh=VvFQf+HPuwvxiPO2CciFWT3wBG7LYc3T7itTWZ/gR60=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=oBpOVIJBUYcFtVMDIMNF49/8i8XKnXxdDQFvkVLnwYq8prZiFok94CND/mGnfuIJM803Z0ER+UsXSf/L/vKZ1XiIuKXwPGTCZXlTeIvN6nytefBXZSzZ/DPu1Bs/O0lKdfMXwMit1qxSxGSHLe1zivju4DSqPR6k7pG4RdEpdHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Zhv/cSog; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Zhv/cSog"
Received: from github.com (hubbernetes-node-b2708b6.ash1-iad.github.net [10.56.146.44])
	by smtp.github.com (Postfix) with ESMTPA id A3FAC141358
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Jun 2025 06:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1749648016;
	bh=9l8VzYod/q1reIAyNxk+SdV73RlwfILTXqF8KK56G+0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Zhv/cSog30UZO+NBPu+00qcrk9StRDuy8xd6QOHnFtFSp87myuVQQZ9FtH96GkfpI
	 TBtTy6kkSDxGVqsHylUGRBmjchr/wZwSgewowiGPPhW8ptyJTI4afRsHw1YyzUVuFI
	 kIIOruDki+OSTwbcuOsgOCz+Uh3/XpAJD9o464u4=
Date: Wed, 11 Jun 2025 06:20:16 -0700
From: ValdikSS <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/970839/000000-60476c@github.com>
Subject: [bluez/bluez] 60476c: doc: sco.rst: BT_PHY is read-only
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

  Branch: refs/heads/970839
  Home:   https://github.com/bluez/bluez
  Commit: 60476cbfd54697ff3620ad1d86d5c94fc684bade
      https://github.com/bluez/bluez/commit/60476cbfd54697ff3620ad1d86d5c94fc684bade
  Author: ValdikSS <iam@valdikss.org.ru>
  Date:   2025-06-11 (Wed, 11 Jun 2025)

  Changed paths:
    M doc/sco.rst

  Log Message:
  -----------
  doc: sco.rst: BT_PHY is read-only

The kernel is missing BT_PHY setsockopt support, as of 6.16-rc1.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
