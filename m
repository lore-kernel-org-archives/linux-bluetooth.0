Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F9E1917ED
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 May 2025 17:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747935813; cv=none; b=dxvL3/3Hn/taiIZ+iLT3PpWAUfRxaFg+V1o80PMoBGBzV7FHMSf8x9i+X7G2c/TKKUxs7Q+tPmh2I3uFFqGGqC8gIZPKb41DaIxpJXzu+ypMkeuNTEfeSLBy78f2e1tKfEQlmfxxyO+N3z1X7qbGiPxkb7kFwka0OIFpwDMeS4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747935813; c=relaxed/simple;
	bh=pqOoWgoRDv/16SC6oDHqLqO28HRR4kn4qf+uytm2tNs=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ojR8j7Tiee6/3zpsm33R8wEH4kfSpHdUgVUtnEh/VMMFlhtAk05sNMafbYB7xM9azdl4JViMfi+yy9NzqKnAK8BDt7eO+1skZWzpdf7tTavph977S6MCbHWA9phLzKMr7Oo8YKgWjNUndrAYQHqz2tRISuCTuhtegPqPqZlf4yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=MTlMt9et; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="MTlMt9et"
Received: from github.com (hubbernetes-node-ebf55ae.va3-iad.github.net [10.48.221.11])
	by smtp.github.com (Postfix) with ESMTPA id 347C48C033C
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 May 2025 10:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1747935811;
	bh=na1p7tgRefB+ArKJtaqHu+3i/evxKQX0dNnX/+JD/wU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=MTlMt9etKKZW9qBoHfN4nq4AkE/J1tIcjiHGciYJc37ZhuN/SKV5wujLagd4wZXgJ
	 OSmQSvtj7G4433TtPumBgPHUR/HMcI32IFzkKRgF9jLhBIKHWOcyHBLRX9STZiWF/Y
	 H4RfJpug1hNgmgNlTkf8t5pq67JqqxxxIWwoh5fA=
Date: Thu, 22 May 2025 10:43:31 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/965496/000000-9e97cb@github.com>
Subject: [bluez/bluez] 46055f: org.bluez.Adapter: Add AutoConnect to
 SetDiscovery...
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

  Branch: refs/heads/965496
  Home:   https://github.com/bluez/bluez
  Commit: 46055f408a37333591841b0f72adb20f0adfda9a
      https://github.com/bluez/bluez/commit/46055f408a37333591841b0f72adb20f0adfda9a
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-05-22 (Thu, 22 May 2025)

  Changed paths:
    M doc/org.bluez.Adapter.rst

  Log Message:
  -----------
  org.bluez.Adapter: Add AutoConnect to SetDiscoveryFilter

This adds AutoConnect filter option to SetDiscoveryFilter which can be
used by application to automatically connect devices found matching a
pattern.


  Commit: 837d9ec21084607047a69e25af47278390fc2505
      https://github.com/bluez/bluez/commit/837d9ec21084607047a69e25af47278390fc2505
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-05-22 (Thu, 22 May 2025)

  Changed paths:
    M src/adapter.c

  Log Message:
  -----------
  adapter: Implement SetFilterPolicy AutoConnect filter

This implements AutoConnect filter option in SetFilterPolicy method
according to its documentation.


  Commit: 5815f1177fbcda07c39e90f77ed39365be96ec71
      https://github.com/bluez/bluez/commit/5815f1177fbcda07c39e90f77ed39365be96ec71
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-05-22 (Thu, 22 May 2025)

  Changed paths:
    M client/main.c

  Log Message:
  -----------
  client: Add scan.auto-connect command

[bluetoothctl]> scan.auto-connect --help
Set/Get auto-connect filter
Usage:
	 auto-connect [on/off]


  Commit: 9e97cb682e5d0c65632aede7770394412dfecc68
      https://github.com/bluez/bluez/commit/9e97cb682e5d0c65632aede7770394412dfecc68
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-05-22 (Thu, 22 May 2025)

  Changed paths:
    M client/bluetoothctl-scan.rst

  Log Message:
  -----------
  bluetoothctl-scan: Add documentation for auto-connect command

This adds documentation for auto-connect command.


Compare: https://github.com/bluez/bluez/compare/46055f408a37%5E...9e97cb682e5d

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
