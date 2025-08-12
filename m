Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C4C2F0696
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Aug 2025 21:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755034361; cv=none; b=QF31lAiCR1dqT0q1uOz8Xb4I40/pT+qR8lSfGHuSLhJ/sZx67CojYF1QzancoqWCNXJ1RYc5MqJRLj96xkLTAxXQBZhNRYDfcFNOpyLBWye3TVs8KosXcbTqRtkAum5tvovn+eWM1N3yFoie9507YcafHl/L/7N9fUWfxmfN++8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755034361; c=relaxed/simple;
	bh=kJuxpXWnE+/Y6XQy7AdCWhWfRu5RHxBi17ZhJfWt3Sk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=WHauhojsysBcVG2RcgwM0CFPuddOBNOxTQ7wsyhPWaYo6Azd3KrdafLGBmwlmyL71m+kYvDuUjTT1gy8QYGeowe1sbf0xcVmdrywSiq0vxuXRxU3qr4vlOtgtPwZ+zmQxHodsaJFlIzHa0MuCQYWcmLkkIO9yb8srotx3WQKtf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=cTZNF6/O; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="cTZNF6/O"
Received: from github.com (hubbernetes-node-06ca12e.ac4-iad.github.net [10.52.178.31])
	by smtp.github.com (Postfix) with ESMTPA id 1E2CF70045A
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Aug 2025 14:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1755034359;
	bh=OaEi2CBzqvc+IssYVKWohGukvC5jdQPe3Y/hACZ62+Y=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=cTZNF6/OW5/zBvCNg+WJENgHVIj7HhiCObZCzG4IeN1VRZK6q7e0BRfPngeWHCUjh
	 MdTQSlbQlrepTSRpzlGPI3jEel+oHJWtHoooXc58Fm+WER9QNkZTtAflAUk5pehA4m
	 aIjQhCd0Cx7dmsIP3ZHtFwGWyiUVzZ3/tDqtgXRI=
Date: Tue, 12 Aug 2025 14:32:39 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/990735/000000-2777ff@github.com>
Subject: [bluez/bluez] 2777ff: mgmt-tester: Fix tests failing due to missing
 LL P...
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

  Branch: refs/heads/990735
  Home:   https://github.com/bluez/bluez
  Commit: 2777ff17a372895a89ddacb3d55acc7ed7799f3a
      https://github.com/bluez/bluez/commit/2777ff17a372895a89ddacb3d55acc7ed7799f3a
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-08-12 (Tue, 12 Aug 2025)

  Changed paths:
    M tools/mgmt-tester.c

  Log Message:
  -----------
  mgmt-tester: Fix tests failing due to missing LL Privacy

LL Privacy setting now depends on LE to be enabled first which was
causing the following tests to fail, so this removes LL Privacy from
the expected settings:

Add Ext Advertising - Success 22 (LE -> off, Remove)
Set Device ID - Power off and Power on
Set Device ID - SSP off and Power on



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
