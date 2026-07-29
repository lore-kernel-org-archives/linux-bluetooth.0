Received: from out-8.smtp.github.com (out-8.smtp.github.com [192.30.252.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5D13FFD
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jul 2026 04:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785298771; cv=none; b=oQD0EbfP/J0DHTEHysr9eI3Y3lk0vo2ycJcOs+luqvNH3UuS5WDy4EdVn8D9UKqgcyDieR2R8Zonn/EQ6LihGRTIo+nd2hkZ/HGcOk8etwWHajoxOZ9XSiXQIP1+7erz7o2wTI9bmCfM86cIuyRSnbACG9vws0+wGGVMC0Rc90A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785298771; c=relaxed/simple;
	bh=qeJX4i964RouK0vCG+46y5TwsyBON4IKggBgkp04qC8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=kffjpX5eW6ZPVdu5+jMz1U1IwwDhUiu9xszT5RyosVcO9nw6Pd/qnqdtBiD6Ez30k8VPO5xJp+VrQU1X1G3A485PF1dEVYURZDJut2E4Lnr6S20wbkv9g/OIFNNs4r/XvQG5/aQSwZCRgjJo9JCYoTLs4HXZi37mCYJwp8LF61c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=ZHm2KNke; arc=none smtp.client-ip=192.30.252.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="ZHm2KNke"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1785298769;
	bh=JwrxDPILOkgX0Fm9q2gV11VMRJQJmHMhyCgXyx+yOik=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ZHm2KNkeveecbbj3eE0gKKnFCYYBeML7AJHS0EJaDzLIKaesoMu9l62FFa/L6JvlU
	 dE9kJNOSKrs5uBWitmASS4gSXi5Apcp2ffoogBiDqDasQDdt+7VMElYkSEFy5Q+pM/
	 /MHINUK56BL5TgU2QcIvkNJEcjybkwIEhuMqlz24=
Received: from github.com (hubbernetes-node-8ce31fb.va3-iad.github.net [10.48.68.72])
	by smtp.github.com (Postfix) with ESMTPA id 0C7AF780A4E
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jul 2026 21:19:29 -0700 (PDT)
Date: Tue, 28 Jul 2026 21:19:29 -0700
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1136288/000000-6ed544@github.com>
Subject: [bluez/bluez] 6ed544: bap: fixed the return value of GIOFunc
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

  Branch: refs/heads/1136288
  Home:   https://github.com/bluez/bluez
  Commit: 6ed5445be6363264dd47ac2949763b4291d3e776
      https://github.com/bluez/bluez/commit/6ed5445be6363264dd47ac2949763b4291d3e776
  Author: Yang Li <yang.li@amlogic.com>
  Date:   2026-07-29 (Wed, 29 Jul 2026)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: fixed the return value of GIOFunc

The GIOFunc should return FALSE if the event source should be removed.

Fixes: 322c39a64 (bap: Start BIG sync after receiving BIGInfo)

Signed-off-by: Yang Li <yang.li@amlogic.com>



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
