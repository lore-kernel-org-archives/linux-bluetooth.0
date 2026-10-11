Received: from vtj.irix.systems (vtj.irix.systems [82.76.27.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46D52EEE60;
	Sun, 11 Oct 2026 22:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.76.27.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791756765; cv=none; b=cOPv9eYpmcYfJDBrVDBOzyQNYI0eJ1Y9hKtacAnkD026YaDrTBrKwBIg/XX9pjYwen6OKD8dBRvmrE0NzEGggfT5DeJa54l94yK9YlG+ADRWimDy4aCsq1C2GnLAeSoTsCIezOGWFAuM34Xqz65k55PmBhAxNcpL+cEWO/vwVI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791756765; c=relaxed/simple;
	bh=8DH7BN6/rFlLHn4Kx/LYG92C+fCfjqdvDOumpWkDBHk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AUUKpgEgv2XDSkiEr+l+7vOHPBQ/FoCULMVPyH3ovkJ+OQvuZ/cUwiHJS3zITZvk6LyGXkSNtG4Dw0VBo7SzP1yZ8vBC3gByA7EFEPq5Pba8NASVhL146q3BvW2vbkpLT2WWP6D8EYmXR3Jmz71uqo94ePiNyf7S4wp8yrWCJz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=andrei-z.com; spf=pass smtp.mailfrom=andrei-z.com; dkim=pass (2048-bit key) header.d=andrei-z.com header.i=@andrei-z.com header.b=Mlp5kPf2; arc=none smtp.client-ip=82.76.27.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=andrei-z.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andrei-z.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=andrei-z.com header.i=@andrei-z.com header.b="Mlp5kPf2"
Received: from MAILGW-HP.hp.vtj.corp.irix.systems (localhost [127.0.0.1])
	by vtj.irix.systems (Proxmox) with ESMTP id ADACA991;
	Mon, 12 Oct 2026 01:12:41 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=andrei-z.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=sig1; bh=M59/VKkKUMyheZD/wOv6
	K6nK8h2w8/CWCgURVowxwWk=; b=Mlp5kPf2BFW1B4FoZlLNwxDijuPIXUaa7Mhg
	Izkh4uSE4aCd0FihjnnvXVjqlz44lgOdvjTUo9yG9864T8Dave6pt4Y1ngRLX8oy
	PMDv8/kSq0wiEOCFEzruNU0XmXv5rD6EiGLAZcb05X9HuEg4BPc10odlWyd0n+O4
	IadXBSKD7b8dTU6tRcxeWEjy6XwkMt7sZb+0w+LmLNarXXSxhvi82oHKtj/Ks9CJ
	8V+SjWHHxhzzKVhYlv3gYrPneSiLf0WzHsqRB2VuG0pZryDrdZfh3PggBSDxaT9X
	02Hlh4+LWrR+ZWz2JqoOFbFNczFrXYkL0/18Z3sVmK+nVbqQ1w==
Received: from VTJ-MX.corp.irix.systems (unknown [IPv6:2a02:2f04:1:9c24::6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by vtj.irix.systems (Proxmox) with ESMTPS id 309AB8DA;
	Mon, 12 Oct 2026 01:12:40 +0300 (EEST)
Received: from workspace.corp.irix.systems (2a02:2f04:1:9c23::c) by
 VTJ-MX.corp.irix.systems (2a02:2f04:1:9c24::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 01:12:39 +0300
From: Andrei-Alexandru Bleortu <me@andrei-z.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Marcel Holtmann
	<marcel@holtmann.org>
CC: <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>, George
 Moussalem <george.moussalem@outlook.com>, <linux-arm-msm@vger.kernel.org>
Subject: [PATCH 3/3] Bluetooth: btqcomipc: take the board's address from the host
Date: Mon, 12 Oct 2026 01:09:19 +0300
Message-ID: <20261011220919.1816407-4-me@andrei-z.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261011220919.1816407-1-me@andrei-z.com>
References: <20260709-ipq5018-bluetooth-v5-4-e476c41f03b8@outlook.com>
 <20261011220919.1816407-1-me@andrei-z.com>
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

The IPQ5018 NVM carries one placeholder address (50:18:00:00:5a:ad) for
every board, and btqca skips the NVM tag parsing on IPQ5018, so the
placeholder check that sets HCI_QUIRK_USE_BDADDR_PROPERTY for other QCA
parts never matches: the controller came up configured with the
placeholder and, being set up again on every power on, went back to it
even after an address was set through mgmt.

Set the quirk in setup, so the controller stays unconfigured until the
board's address comes from the local-bd-address property or from
userspace, and the core programs it after each setup.

Assisted-by: LLM
Signed-off-by: Andrei-Alexandru Bleortu <me@andrei-z.com>
---
 drivers/bluetooth/btqcomipc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btqcomipc.c b/drivers/bluetooth/btqcomipc.c
index 8513c1780..92a0d671e 100644
--- a/drivers/bluetooth/btqcomipc.c
+++ b/drivers/bluetooth/btqcomipc.c
@@ -997,9 +997,13 @@ static int btqcomipc_setup(struct hci_dev *hdev)
 	}
 
 	/*
-	 * 7.2 has no NVMEM-backed BD address in the HCI core; the board's
-	 * address is set from userspace through set_bdaddr instead.
+	 * The NVM carries the same placeholder address for every board, so
+	 * the controller stays unconfigured until the board's address comes
+	 * from the local-bd-address property or from userspace, and the core
+	 * programs it again after each setup.
 	 */
+	hci_set_quirk(hdev, HCI_QUIRK_USE_BDADDR_PROPERTY);
+
 	return 0;
 }
 

