Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F011D53F
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Mar 2024 14:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710426731; cv=none; b=tXmogLK6HPEMvmtZT7bYeGFPau4ONtWQMx5w6nfNe4cOFMF/msQQ82d0WcCfvMG8A7GED6LIv0XUavK2xS5BBatjnmaGWS/CUKty1Ct9OnMrPYGg/WIDBYZ1XC318Wb+HFaQcjl5Fj4Jx9ALBsACIXyJaahnp27v4/+aZgAZDq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710426731; c=relaxed/simple;
	bh=d9w4H8zemO9ZzLLT3CflC9gRWVzeOA8YvYoyPsu5VFA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=FViLFALRVoJDWsmBrwANpvfSejceCcagCpNGz51PQYJkWz6TipHQbuJkLBCl1jW5TqxLXhR5IbvyEw/KvXGMRSbOBF99qKWRzul2akx/ciwoL2cstmVYcMC7m1ry8mXdnJBX+WnbdeFkbzhewt1if6nzq8enypzujfkDNtvvwdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=f7+HrdUL; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="f7+HrdUL"
Received: from github.com (hubbernetes-node-d8d992d.ash1-iad.github.net [10.56.159.43])
	by smtp.github.com (Postfix) with ESMTPA id 6EFA46013B5
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Mar 2024 07:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1710426729;
	bh=Fra/H1lNzi3Jy9h9PZnUBP7Ma8kioahANq7VpI93qPg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=f7+HrdULXGDwhjrkhVji0cS/ZYVwKEmpPaKFG+ar0URuH/aAQc5zPiLzdfRAiUtCQ
	 UNnbsFYsyiJ/5/zZ6KtjQVRFg6d06F7xSkqK2S2SZ1DsvYP5UqkT/h+Cu7JD3iR4BU
	 MO4VqqO0nxpjkfa8ikvAlNiCqyuXwDRXQz00/6KM=
Date: Thu, 14 Mar 2024 07:32:09 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/3ad367-0959cb@github.com>
Subject: [bluez/bluez] b56131: build: Fix make distcheck
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
  Commit: b561318193bde11cf5c87b7207bd67b795897f2b
      https://github.com/bluez/bluez/commit/b561318193bde11cf5c87b7207bd67b795897f2b
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-03-14 (Thu, 14 Mar 2024)

  Changed paths:
    M Makefile.am

  Log Message:
  -----------
  build: Fix make distcheck

Add missing file src/shared/bap-defs.h.


  Commit: 0959cb8f5f462b2011d64f8599e4567f98821e77
      https://github.com/bluez/bluez/commit/0959cb8f5f462b2011d64f8599e4567f98821e77
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-03-14 (Thu, 14 Mar 2024)

  Changed paths:
    M unit/test-bap.c

  Log Message:
  -----------
  test-bap: Fix 44.1 KHz tests

44.1 Khz where broken due to change to LC3_QOS_UCAST which now properly
sets the framing, so this changes the test vectors of 44.1 Khz test to
properly set it since those required framing.


Compare: https://github.com/bluez/bluez/compare/3ad367874630...0959cb8f5f46

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
