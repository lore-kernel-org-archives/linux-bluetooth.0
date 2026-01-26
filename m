Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21A723AB8D
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jan 2026 15:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769440630; cv=none; b=ND1kHPxpy1wGDt2+zCYu3XoruRcpO4iTAUUZLjx2XXkDoo1KU9eWa9PLS1a9Ly+IWWjH3cStBe8PnCR4FP64i04bvI9RCiVN0JRVlnSxXnlWRvYl9hwmN8PAF+XiRLpRafdxsmgajY/ROaedQrYb+8buE3L3H3eNUHbbvco4Ohk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769440630; c=relaxed/simple;
	bh=+25JQMxEiXCUFkmlfKMCUBkotbycyeXwaHiNBsTSc8w=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=TcJLPCSZUQKp4/kkKoSHF4lO7j+SwWN2LhvIADAggx1L8KuMOS//qn2akEQrpUo4PoZDIDRaInfIobeqCd+pyHjVotYZ9Uame9WDD5LhpLBGeU2/a5vrBF0nCtyTgZraBX7vv9Gw2mtGRA2XNKaryMNPRmi7g/qrAj54kHzbiwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=N/8TTywy; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="N/8TTywy"
Received: from github.com (hubbernetes-node-4b22668.ac4-iad.github.net [10.52.145.55])
	by smtp.github.com (Postfix) with ESMTPA id 16B2B401253
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jan 2026 07:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1769440628;
	bh=y61TsLCTrEtRA+ZQXFeGAPfJt18M8CyuD7um95/SPbQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=N/8TTywyoqyXk50Qmy4pifj29KwrBPVhMrOCkfJ+c0ijwVqAjjeryePTm7hM48NKY
	 D04sREWCSrtS6l6k0VFn1Y99wtVMQ5va5yEB8pfL4dewSDZFmUsHJoQPBzHDwuZG4a
	 ld/SSelMajMqJXMHWHKOMeWh8rsghFm4xMtglaXU=
Date: Mon, 26 Jan 2026 07:17:08 -0800
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1047158/000000-72e7b1@github.com>
Subject: [bluez/bluez] 72e7b1: shared/tmap: Fix TMAP/SR/SGGIT/CHA/BV-01-C on
 big ...
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

  Branch: refs/heads/1047158
  Home:   https://github.com/bluez/bluez
  Commit: 72e7b19e2f16e42cda81cb12343f88fcdac0be92
      https://github.com/bluez/bluez/commit/72e7b19e2f16e42cda81cb12343f88fcdac0be92
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-26 (Mon, 26 Jan 2026)

  Changed paths:
    M src/shared/tmap.c

  Log Message:
  -----------
  shared/tmap: Fix TMAP/SR/SGGIT/CHA/BV-01-C on big endian

This fix the following error cause by not converting the role value to
little endian:

TMAP/SR/SGGIT/CHA/BV-01-C [Characteristic GGIT - TMAP Role] - run
**
ERROR:src/shared/tester.c:992:test_io_recv: assertion failed: (memcmp(buf, iov->iov_base, len) == 0)
Bail out! ERROR:src/shared/tester.c:992:test_io_recv: assertion failed: (memcmp(buf, iov->iov_base, len) == 0)



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
