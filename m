Received: from out-36.smtp.github.com (out-36.smtp.github.com [192.30.252.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1F0237180
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 May 2026 21:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777931086; cv=none; b=p5JTF7qKUixJxSPYyFbZk2PceotQeK15QQ55TR0QkmHaKJ333FVCiq1OHfAnQ5cf87pVtCAXC2HqoGJVSnJd4EMLJb/lkBrdKtNQyPBCWjr0ZiABARXgUvqFgb7VezTeTYMXRkpUOU7d4jZI5oZZCFna2wtLLSbuNploGthzvjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777931086; c=relaxed/simple;
	bh=tmerYeRAZ99cCtYKnQ6YHzBh6+XJTF+tXMjnEAFCqj0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=SIQYujeqStphgLmI4IWXb20r0675HQ7YFFbBmeWVuiyPbhsde5wRu6PgLuFvP9ZjLnnDsV692YYHcpTO0A7GaYwm+CVYh3wxk21AMy7ETT+Mz/Fq2IFyRaLnEZvxBR1lpu8QTryyI3LCKpQQ0RgfrQCwF5qTLfNelGPWAVJvOLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=mk/5Dg/D; arc=none smtp.client-ip=192.30.252.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="mk/5Dg/D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1777931084;
	bh=FYSfLqgSNl+XJgCkPVC33YsbysnIQogUmZ0dgNnvFaU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=mk/5Dg/Di+V9aGr3udv73o7N+kP7SSbuz99jhqfNwipDQABJ8D97j2MUL7/ZCSMTA
	 aG9XysGY38U34riGrk1r/JSNS85FAA5oo1vx5IT33dz8A6TL7THlgkgZENPIKom7Iy
	 Wm4r+Zo2FHWhY+2f/10EUf7ze5x7I4ZsYHTz9KGc=
Received: from github.com (hubbernetes-node-40f9bcf.ac4-iad.github.net [10.52.140.32])
	by smtp.github.com (Postfix) with ESMTPA id DE218740C83
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 May 2026 14:44:44 -0700 (PDT)
Date: Mon, 04 May 2026 14:44:44 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1089499/000000-369b30@github.com>
Subject: [bluez/bluez] a253b2: monitor: Add features bits defined in 6.2
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

  Branch: refs/heads/1089499
  Home:   https://github.com/bluez/bluez
  Commit: a253b232bc1d99cef96a5e4209cdc00495232829
      https://github.com/bluez/bluez/commit/a253b232bc1d99cef96a5e4209cdc00495232829
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-05-04 (Mon, 04 May 2026)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Add features bits defined in 6.2

This adds features bits defined as per core spec 6.2:
https://www.bluetooth.com/wp-content/uploads/Files/Specification/HTML/Core-62/out/en/low-energy-controller/link-layer-specification.html#UUID-56ada5ed-4ae3-acee-198f-27ead57d86f1


  Commit: 369b30708d77e0a20b68f99527d989fa0d79b80c
      https://github.com/bluez/bluez/commit/369b30708d77e0a20b68f99527d989fa0d79b80c
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-05-04 (Mon, 04 May 2026)

  Changed paths:
    M monitor/bt.h
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Add decoding for Short Connection Interval feature

This adds deconding support for SCI related commands, command bits, event
event mask bit and feature bits:

Events:

HCI_LE_Connection_Rate_Change(0x37)

Commands:

HCI_LE_Connection_Rate_Request(0x20a1)
HCI_LE_Set_Default_Rate_Parameters(0x20a2)
HCI_LE_Read_Minimum_Supported_Connection_Interval(0x20a3)


Compare: https://github.com/bluez/bluez/compare/a253b232bc1d%5E...369b30708d77

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
