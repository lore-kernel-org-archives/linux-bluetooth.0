Received: from vtj.irix.systems (vtj.irix.systems [82.76.27.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910F8403B00;
	Sun, 11 Oct 2026 22:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.76.27.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791756570; cv=none; b=YdXOVp7I5h0Xky7YFTYFlIcyl5N8FmvZsthOuG2RIT7WBT5ikfyksZCnVcAXUTPq3GSX5691JSTbRyagHYjdlQTIIO9vJqehYY1WVmFZWKwqLCmsxei4ohC5TgPRdFfhoAyPbh4rW3fGvym7yRYXhlvG2cmmNZvozTeVnDIdOKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791756570; c=relaxed/simple;
	bh=eElrNEwKmyZge6zzjRe3ExXpadFazkZIHmyrkyJyDhw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s/lTuvU8+FFJk+I49tVy4K4n+VrqoGNr5NhdG3EoYiCTBFwDGAKk6o1MJBrTwy5a6L5R98eH2zdTCrVNloG+3c+A8yJG9CPqGAJwicwmHw7u6blNEC46+9Br7VMwjPn/YaNRAxJyRKgzU6ei6d9j72J3uz5iN4BYYNHCNxVMj2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=andrei-z.com; spf=pass smtp.mailfrom=andrei-z.com; dkim=pass (2048-bit key) header.d=andrei-z.com header.i=@andrei-z.com header.b=UdeEE26R; arc=none smtp.client-ip=82.76.27.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=andrei-z.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andrei-z.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=andrei-z.com header.i=@andrei-z.com header.b="UdeEE26R"
Received: from MAILGW-DELL.dell.vtj.corp.irix.systems (localhost [127.0.0.1])
	by vtj.irix.systems (Proxmox) with ESMTP id C53838D45;
	Mon, 12 Oct 2026 01:09:26 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=andrei-z.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=sig1; bh=cVkZ4sX/tPPVKK5sGLuN
	26L1bCAFWnGrnKL5Lxp+Kn8=; b=UdeEE26RzvKlfCU78RSlDg0QzAui/IOwCi6F
	YXQaaADMyvkQyglV3DM0i90+qcZwoQId69FhRDXzhREyOc8X7bx+NkKE4ef09eOj
	5BCbFD1z+fmmpB3jO66b6dm6R0J7v04UzVKN0oaUaRd12o+AKjC9JRBc8rA4BWPA
	iFYZ17oI6OyjJl2dvVFndKcFR+IjseKyiw1iU4tnAoA2Hcj8ygxFTCc+McW4zVWj
	YtAElBHCYyo+kgcJVe90tbRaphjbZIXefHxdZGJvUEamUKQPFgwrJJFuwKfHidvk
	CpJdbfi3c/odn9YV2cOMG8KR7NJlCWvEjiOVVAtzL/2hUd1p5A==
Received: from VTJ-MX.corp.irix.systems (unknown [IPv6:2a02:2f04:1:9c24::6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by vtj.irix.systems (Proxmox) with ESMTPS id 85EDD8C81;
	Mon, 12 Oct 2026 01:09:24 +0300 (EEST)
Received: from workspace.corp.irix.systems (2a02:2f04:1:9c23::c) by
 VTJ-MX.corp.irix.systems (2a02:2f04:1:9c24::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 01:09:24 +0300
From: Andrei-Alexandru Bleortu <me@andrei-z.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Marcel Holtmann
	<marcel@holtmann.org>
CC: <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>, George
 Moussalem <george.moussalem@outlook.com>, <linux-arm-msm@vger.kernel.org>
Subject: [PATCH 0/3] Bluetooth: btqcomipc: fixes on top of the IPQ5018 v5 series
Date: Mon, 12 Oct 2026 01:09:16 +0300
Message-ID: <20261011220919.1816407-1-me@andrei-z.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260709-ipq5018-bluetooth-v5-4-e476c41f03b8@outlook.com>
References: <20260709-ipq5018-bluetooth-v5-4-e476c41f03b8@outlook.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VTJ-MX.corp.irix.systems (2a02:2f04:1:9c24::6) To
 VTJ-MX.corp.irix.systems (2a02:2f04:1:9c24::6)

Hi George,

I brought your v5 up on a UniFi U6 Enterprise (IPQ5018) and needed these
three changes on top of it for the controller to load its firmware, to
survive an unbind/bind cycle and to take the board's address. They are
against your v5 as posted; please fold whichever you agree with into v6.

1/3 keeps the dot in split firmware segment names (qca/bt_fw_patch.b02).
2/3 deasserts the BTSS reset before enabling the LPO clock; a probe after
    an unbind otherwise fails with "gcc_btss_lpo_clk status stuck at 'off'".
3/3 sets HCI_QUIRK_USE_BDADDR_PROPERTY: btqca skips the NVM tag parsing on
    IPQ5018, so the placeholder address (50:18:00:00:5a:ad) is never
    detected and every board comes up with it.

Three notes on v5 itself:
- Unloading the module (rmmod btqcomipc) with the controller up hangs the
  SoC until the watchdog resets it; I have not looked into why.
- It uses HCI_QUIRK_USE_BDADDR_NVMEM and HCI_QUIRK_BDADDR_NVMEM_BE, which
  come from a separate series that is not in bluetooth-next or
  next-20261009, so v5 does not build on its own.
- Its btqca patch no longer applies to next-20261009 (btqca.c moved on).

3/3 works best with "Bluetooth: hci_core: program a public address set
during auto off", sent separately to linux-bluetooth: without it, setting
the address within two seconds of the index appearing leaves the
controller up but invisible to mgmt.

Transparency note: developed with an LLM coding assistant (Claude), which
traced these while bringing up the board and wrote the changes and these
messages. Tested on the U6 Enterprise with Linux 7.2.8 and BlueZ: the
firmware loads, hci0 stays unconfigured until userspace sets the address,
then scans and advertises. A W=1 arm64 build of drivers/bluetooth is
clean.

Andrei-Alexandru Bleortu (3):
  Bluetooth: btqcomipc: keep the dot in split firmware segment names
  Bluetooth: btqcomipc: deassert the BTSS reset before enabling its clock
  Bluetooth: btqcomipc: take the board's address from the host

 drivers/bluetooth/btqcomipc.c | 24 +++++++++++++++---------
 1 file changed, 16 insertions(+), 8 deletions(-)
-- 
2.47.3

