Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3809134CF
	for <linux-bluetooth@vger.kernel.org>; Thu, 31 Jul 2025 20:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753993129; cv=none; b=Q69akqGKMJqF1cy67Mf4k3S62GRFz7yNKLGT8GGpb4QcdsokdB1ocqjr612MHhyeEcmYa+/DkBtFt8IXWQeXMug2IrGxzMWJiHlNaJMseVqHZgRlXK03tbFP/Vq2vDguJND7vbB3mN8dF7j5g41BV3oBDMp0m9g/xIFz8GC29aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753993129; c=relaxed/simple;
	bh=n79YG8z73zPrVIeIBGcaiVMw6rZlL03ms1fPaYGb17s=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=i1NZdMlcoVJVuJhbfqy32gT+kNaUR6pN35sAml2ed72bv888HJjWtmw6uSj6SDErYkkuJm/z5W/8UVc4QumLU2iEUvcRWf7IN/+irKQl3GWfbpZvbNK1yZqdXQLiOgyOoaRf3i18YAjpuF93fSQ3S95dxtZRk9XubGTdg4vaEqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=WlfQoJqm; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="WlfQoJqm"
Received: from github.com (hubbernetes-node-4c2b199.ash1-iad.github.net [10.56.154.40])
	by smtp.github.com (Postfix) with ESMTPA id 1C66C141189
	for <linux-bluetooth@vger.kernel.org>; Thu, 31 Jul 2025 13:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1753993127;
	bh=Q0xRnRP04kFE2URYzyWm16ekfw07W+6jUpwdWLCeJ7k=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=WlfQoJqmhq/G69l4f4KC8Vvwo3sgrToZnUJiw1mvS5/dYXoIYicFTOdEAjMBH9mwU
	 6IgH9xfzRb9Hw77gWJucan0eV/dqhASVFV5KLaKFG1TwILKs0oUN5Q1bU3iltkI1dJ
	 jxl4CktnUIO1chxeRwDXF3rIKe51O7UBghH2bi+I=
Date: Thu, 31 Jul 2025 13:18:47 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/987469/000000-b222f8@github.com>
Subject: [bluez/bluez] b222f8: monitor: Add support for logging host packets
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

  Branch: refs/heads/987469
  Home:   https://github.com/bluez/bluez
  Commit: b222f80538145bc3f0857533dd6ac2a8bbb7e863
      https://github.com/bluez/bluez/commit/b222f80538145bc3f0857533dd6ac2a8bbb7e863
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-07-31 (Thu, 31 Jul 2025)

  Changed paths:
    M monitor/display.h
    M monitor/main.c
    M monitor/packet.c
    M monitor/packet.h
    M src/shared/btsnoop.h

  Log Message:
  -----------
  monitor: Add support for logging host packets

This adds support for logging host packets so their timing is
visible in the logs:

l2cap-tester[41]: < HOST Data TX: len 12                 [hci0] 15:50:02.974141
l2cap-tester[41]: < ACL Data T.. flags 0x00 dlen 12  #83 [hci0] 15:50:02.974199
      Channel: 64 len 8 [PSM 4097 mode Basic (0x00)] {chan 0}
        01 02 03 04 05 06 07 08                          ........

> ACL Data RX: Handle 42 flags 0x02 dlen 12         #170 [hci0] 15:51:43.269961
      Channel: 64 len 8 [PSM 4097 mode Basic (0x00)] {chan 0}
        01 02 03 04 05 06 07 08                          ........
[45]: > HOST Data RX: len 8                              [hci0] 15:51:43.269976



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
