Received: from out-7.smtp.github.com (out-7.smtp.github.com [192.30.252.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0E0414A27
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2026 06:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791960556; cv=none; b=jDk7gPD4KFdClt+Ri3CQVfjyavAS7MyA/a7Agbmx8Bmvvdo3IDq4avsF1PrxSDJ0e+aIiWHM85W63QFyH7UOZoBsKgWtIXuWjyc6qbLOVxWCBJziV8VnxXmYuqYA5I1tYpE6x6I7qWeOBGK1G4HMT1mC9HGoMqK+4MKXKYDXFMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791960556; c=relaxed/simple;
	bh=jyArMZ/gN0CAuz/It++qJ0tLwHKJ9VmUTunXfpEkoxw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=oNXHcbQpaYHuTocYfm+tObTxlsSfOoLGlmhdwignb9FwkSHEj5Y6C8FV2M6XmSK8+tchmD5mjfWxq4DEPF0bCUv2VZOBYnZjkfDbmAm1nqBtyQGUk8di9AjqyFXqEdJb7tmXr6BNVihi+TQPKCnpcFW8U5C8rcmJxKhky8wlIuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=c6VMTjCY; arc=none smtp.client-ip=192.30.252.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="c6VMTjCY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1791960554;
	bh=i6xwEmZLAzEVWoWssePCyCmHtfnyhfvZ1tSj21OKSkE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=c6VMTjCYiIM0VklbvJst8ZH0gyJ+q4RgACHJeVHuMKbpmRbflvFSnjUHcmllnuZqu
	 qA/tL/sWr+nxzydyiV6SGN/L/X/beBKoXMqEAAYRm2pstOZwEGR61cFesrcrmq1Dmi
	 h66XkFsdqFGyHLN1hLgRyQJr65a1Z4IM+eXmsExvOYuCw+2Sf18vUbZQIi0/H7bdeR
	 H+6YYGlzYyQem/UkjjgW3j59zwjsVq4uvb2Srllpzwsq8I9kmXGhuDUiZjwKkjAC10
	 f/YbQZLLTH7nUQ+S7GeO1LUeK6n9uFsCOtCUbgAFNyuYciW4kI3/tr0d1zpWHqnLt0
	 ZEql9twUMHsOA==
Received: from github.com (hubbernetes-node-094182a.va3-iad.github.net [10.48.74.105])
	by smtp.github.com (Postfix) with ESMTPA id 3275B4811EC
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 23:49:14 -0700 (PDT)
Date: Tue, 13 Oct 2026 23:49:14 -0700
From: cochcoder <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1185254/000000-841280@github.com>
Subject: [bluez/bluez] 841280: mgmt-tester: Add host-resolved RPA scan checks
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

  Branch: refs/heads/1185254
  Home:   https://github.com/bluez/bluez
  Commit: 84128041249c8910cdd3a6b9d479d3a3b5bb68a9
      https://github.com/bluez/bluez/commit/84128041249c8910cdd3a6b9d479d3a3b5bb68a9
  Author: Kyle Pepper <cochcoder@proton.me>
  Date:   2026-10-14 (Wed, 14 Oct 2026)

  Changed paths:
    M tools/mgmt-tester.c

  Log Message:
  -----------
  mgmt-tester: Add host-resolved RPA scan checks

Check unfiltered passive scanning for IRK peers on controllers without
LL Privacy, with auto-connect and background-report controls.

Assisted-by: OpenCode:gpt-6.1-sol



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
