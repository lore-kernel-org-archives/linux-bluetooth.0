Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334E41FE44A;
	Tue, 26 May 2026 13:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779803485; cv=none; b=JD8C/2BJnz+HzXVU1+K7u51kr577xacxyJhm+l9FMu7d4khOlR3oUQZVE5Z3UQ+s66kSpU/v4vw4hAqbSnrmUh7KF9zqHL5lUKD9N1RsLfIniPZbhP9bGnCx9ECpIgeO2nugNdMFsL5Qu8IurPYiXOnnWgVFS3FyIpFeYmHlc2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779803485; c=relaxed/simple;
	bh=vQUQe1pASHSJG4MNLG7fnrfrv2VJerlu3jh/gTp9Bgg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZCo2V4wBo0E9Qeu8ye3Il+dHl+ZfG8DsgqCDQuGQo1jUfcmnh0GP+cfPxp5SDEXjgv/FngXC73OPxxdwW9R9mY79EhwACx20k5t9uCME/Lw/yeQmKYqZjnRYfQbSFP7jhDXUYpcSQGRmWMESR41umuU7ej0B5KqfuFLPI2GTYFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=RmABoBwT; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="RmABoBwT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Z8/rR4xEc7BEvLs78RonuVsVc+Cbme4iJ0VrA+fCQZo=; b=RmABoBwTGjbxoIRxVM7bSrTqWg
	oeUsXHp0CLI013OuZBS19+j8vdFmoKh3yYCy8oFtR/FZvm+jjoI88ayz7ue6sYaAGYE9sXfVJ8lC3
	j/tkDcYTR3xmoTktCT6o0LNHAFoVIpHMW3L2V/IOluEHfU7oW39460O+fNmNrJuYzLFeIzdhgVH8w
	Tt0MfFlTgyQghZLJujcFEvBHbvZASoQHQHYlz/6B0bvylNy17hySC73GratrnF1ZnppHtz34EzQ90
	r3dmrIy+Xeo02eFZR8SGzbD67TUr/ckHblqve1gvyNT+OcSyw8W0hmETo4sJ4fZ09NQJIKBsO07Pf
	8ocE1odQ==;
Received: from 177-136-90-227.vmaxnet.com.br ([177.136.90.227] helo=[192.168.1.54])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wRsBj-008SdX-W5; Tue, 26 May 2026 15:51:20 +0200
From: Heitor Alves de Siqueira <halves@igalia.com>
Date: Tue, 26 May 2026 10:50:59 -0300
Subject: [PATCH v2 3/3] Bluetooth: hci_sync: Reset device counters in
 hci_dev_close_sync()
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-hci_send-v2-3-596977a9a814@igalia.com>
References: <20260526-hci_send-v2-0-596977a9a814@igalia.com>
In-Reply-To: <20260526-hci_send-v2-0-596977a9a814@igalia.com>
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Gustavo Padovan <padovan@profusion.mobi>, Schspa Shi <schspa@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-dev@igalia.com, Heitor Alves de Siqueira <halves@igalia.com>, 
 Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
X-Mailer: b4 0.15.2

Before resetting or closing the device, protocol counters should also be
zeroed.

Fixes: d0b137062b2d ("Bluetooth: hci_sync: Rework init stages")
Signed-off-by: Heitor Alves de Siqueira <halves@igalia.com>
---
 net/bluetooth/hci_sync.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 84d8f457c799..c11d5a1f2dba 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5390,6 +5390,10 @@ int hci_dev_close_sync(struct hci_dev *hdev)
 	/* Reset device */
 	skb_queue_purge(&hdev->cmd_q);
 	atomic_set(&hdev->cmd_cnt, 1);
+	hdev->acl_cnt = 0;
+	hdev->sco_cnt = 0;
+	hdev->le_cnt = 0;
+	hdev->iso_cnt = 0;
 	if (hci_test_quirk(hdev, HCI_QUIRK_RESET_ON_CLOSE) &&
 	    !auto_off && !hci_dev_test_flag(hdev, HCI_UNCONFIGURED)) {
 		set_bit(HCI_INIT, &hdev->flags);

-- 
2.54.0

