Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC65A1D79BE
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Dec 2024 16:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733157949; cv=none; b=dNb+DfvTItj17j2JJ3vcf/E0uCSyT2+K+mSJxm+nlooLNdtRGuxCrFt6SyzmhYTl7jqupI2PdgIsMQux48TYOXGPVLDhvzExhVe/TKh0VbflODARXMTuU1uFgc0zgkUh9XQg1SYXQnsydE4xNfQAuVMw1Nct04jrIswXEA0EeZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733157949; c=relaxed/simple;
	bh=ibwAwyZUX2Uaodkwtv9U1wGdZMePqGtjQUPrSJ8xnxA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=FZXt3LwY9TJsJrZN89RWMPBaCWfhVsxVSNhGv6ioVf6Wgh2xfzDwKhoky1fSgTErKjpJ//aUexb+sUlzUwyBvIML6wC4T6AU27WTvM+nh+RjRBzR0YyOlKbz9YGTukyRbWZemifJcHp+NC5LbXce8HJCA1pPYIK5/j50oOwBjWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=KRtOuP52; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="KRtOuP52"
Received: from github.com (hubbernetes-node-fd794bf.ac4-iad.github.net [10.52.148.30])
	by smtp.github.com (Postfix) with ESMTPA id CC2E670072C
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Dec 2024 08:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1733157946;
	bh=8Yn6RJ8E0nwSsVqy5tFycsEMLjpMV2BjVIc7IZvXM/g=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=KRtOuP52sOYlQzzYdTEMiMDBwtYT+1XFxsVLAXXatgJP2O+tTmmEg6siv/D1YS/go
	 1NW0YKYHmiKESiAmM8a6RRBpo3FGt2FKotdDsIlVUqN5/bU1F45Q/3FdKLkNDne0X3
	 5n4YghyLlF287mbC3dyZdugv9QVW2M5BVpe8a1qQ=
Date: Mon, 02 Dec 2024 08:45:46 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/501492-d280c9@github.com>
Subject: [bluez/bluez] d280c9: BNEP: Fix the BNEP Unknown Control Message in
 PTS ...
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
  Commit: d280c9346cf0e3f563174433b3aca997d8d88978
      https://github.com/bluez/bluez/commit/d280c9346cf0e3f563174433b3aca997d8d88978
  Author: Shuai Zhang <quic_shuaz@quicinc.com>
  Date:   2024-12-02 (Mon, 02 Dec 2024)

  Changed paths:
    M profiles/network/bnep.c
    M profiles/network/bnep.h
    M profiles/network/server.c

  Log Message:
  -----------
  BNEP: Fix the BNEP Unknown Control Message in PTS testing

This change is required for passing below PTS testcase:
1. BNEP/CTRL/BV-01-C

PTS sends an Unknown Control Message with only two bytes,
which is considered incorrect data. Therefore, add
responses to error control commands.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
