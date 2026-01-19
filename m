Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E494D3904E3
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jan 2026 16:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768840101; cv=none; b=L8jBCFPQBgua3SJkC2eq94alRoLkHu94nt0uTrcw0frJNHBoFrEJFrPld+cOc8i/PMeLYYOv6A2mlnhwq+Hn9SHMu7KQDtJ4ePP97Z6cv+nI1jpb+Diq3EZSiNGkVOB0dh5dZZl72AhJeAy5Cr0SI0cpNXnd1S1b9TCFLQzo8tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768840101; c=relaxed/simple;
	bh=lyapmE91kTeIAiAyoda2hJFabyIMLodJAPuzrm/KUIw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=rc938ZNSm5QEtSLWb6VAL2bXQK/B19925WtaXNQQKvmKA3hUpPEv44JBc6YgCxBhWXnMhOtL8sFm9FHxw2WUkt8ZIUDBfHUTnLrKpHPILVci5TD/RZ8h301Zk/nlBxEr65bq0clKXtu4UlwuJhoHryxCe/F3DuzY1Y+BBUG5aRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=IEG3fUZA; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="IEG3fUZA"
Received: from github.com (hubbernetes-node-1aef3a5.ash1-iad.github.net [10.56.131.73])
	by smtp.github.com (Postfix) with ESMTPA id 403E0921244
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jan 2026 08:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1768840099;
	bh=uRUPPTkWNbSQsVPiwT7qNgECLxiK5xfE4Gd4uqu38JQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=IEG3fUZAQRRFB9dyeQ4fJNn4yRHs14h2iL+RZtFvnSgKXhOhSFPzAx+KrxP6htT5u
	 GmZF1GeB0clg2Tgkz6i33UjF9R7FA40B1eh1eP/qtJ1sz5NSjcrmHptKOamzEub1I/
	 oVIm2Z7t636QPTap042XlTZ0pKsqo4SxyndlYcuI=
Date: Mon, 19 Jan 2026 08:28:19 -0800
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/62fdc1-6a9117@github.com>
Subject: [bluez/bluez] d6f86b: shared/util: Add missing entries to
 bt_appear_to_str
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
  Commit: d6f86b07167b0c055c4d86275ee211fd667243cb
      https://github.com/bluez/bluez/commit/d6f86b07167b0c055c4d86275ee211fd667243cb
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-16 (Fri, 16 Jan 2026)

  Changed paths:
    M src/shared/util.c

  Log Message:
  -----------
  shared/util: Add missing entries to bt_appear_to_str

This adds the missing entries to appearance_table to it can properly
decode appearance values as found in:

https://bitbucket.org/bluetooth-SIG/public/src/main/assigned_numbers/core/appearance_values.yaml


  Commit: 6a9117531e39422247112238033f85a5077b6fb9
      https://github.com/bluez/bluez/commit/6a9117531e39422247112238033f85a5077b6fb9
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-16 (Fri, 16 Jan 2026)

  Changed paths:
    M monitor/display.h
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Make eir and ad print hexdump

This makes eir and ad print an hexdump so user are able to identify
if there is text encoded into them.


Compare: https://github.com/bluez/bluez/compare/62fdc13ed2ef...6a9117531e39

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
