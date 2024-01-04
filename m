Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BBF24B20
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jan 2024 16:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="KZB47CkM"
Received: from github.com (hubbernetes-node-0fd4e2a.ac4-iad.github.net [10.52.200.26])
	by smtp.github.com (Postfix) with ESMTPA id 6C3FB5E10EC
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jan 2024 08:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1704385128;
	bh=bkTTXBdz/xphGxWyYT6WSNNp0p+/28wgy1wGwoZ3OJU=;
	h=Date:From:To:Subject:From;
	b=KZB47CkMJCFBCHl2+fUH3NSMU2ExQdFfvnim2HQvfVT6ZVTG0c9HtqqpzvnW6R/4s
	 OLpf7quuVjaDvknIk8F9du+wpAbJ30xIjcGPsox5cguOTUNoa2ULejGPascrBt52Fw
	 LS7Yh6hswVygMi33H3ukuZ4LozICR3A9jtLl6k+k=
Date: Thu, 04 Jan 2024 08:18:48 -0800
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/60d601-1c321b@github.com>
Subject: [bluez/bluez] 36f057: audio: transport: Fix crash on A2DP suspend
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
  Commit: 36f057d7f66c62fd01e0cf27cfe816bfd5be5d21
      https://github.com/bluez/bluez/commit/36f057d7f66c62fd01e0cf27cfe816bfd5be5d21
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-01-04 (Thu, 04 Jan 2024)

  Changed paths:
    M profiles/audio/transport.c

  Log Message:
  -----------
  audio: transport: Fix crash on A2DP suspend

Commit 052534ae07b8 ("transport: Update transport release flow for
bcast src") introduced a crash where it assumes transport->data always
refers to struct bap_transport which causes a crash when the transport
is in fact A2DP.

Fixes: https://github.com/bluez/bluez/issues/701


  Commit: e4764af7622825a9d7dfd4ecc2066733b03f5dbf
      https://github.com/bluez/bluez/commit/e4764af7622825a9d7dfd4ecc2066733b03f5dbf
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-01-04 (Thu, 04 Jan 2024)

  Changed paths:
    M profiles/audio/transport.c
    M profiles/audio/transport.h

  Log Message:
  -----------
  audio/transport: Refactor transport operations

This creates a struct to hold the profile specific operations to avoid
having to check UUID, etc, to determine how to proceed with each
operation, it also attempts to decouple volume logic from A2DP
transports since it should be possible to support it on devices
implementing LE Audio as well.


  Commit: 1c321baca7815cd7727eff89b2307d27d328fdbe
      https://github.com/bluez/bluez/commit/1c321baca7815cd7727eff89b2307d27d328fdbe
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-01-04 (Thu, 04 Jan 2024)

  Changed paths:
    M profiles/audio/transport.c

  Log Message:
  -----------
  audio/transport: Fix runtime error

This fixes the following error cause by assuming transport->data would
also be a struct bap_transport:

profiles/audio/transport.c:328:16: runtime error: load of value 2, which
is not a valid value for type '_Bool'


Compare: https://github.com/bluez/bluez/compare/60d60166e4bf...1c321baca781
