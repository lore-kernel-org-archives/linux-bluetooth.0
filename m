Received: from forward100d.mail.yandex.net (forward100d.mail.yandex.net [178.154.239.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3337B263C69
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 May 2025 08:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747730577; cv=none; b=Uhf/DBH2AEuGyWUv9g57aPbELijXP1QI6tgUqFdwZJVKOa2PuVDY0001qt6ioTwQpQkRoL/fJUGd69bRfC0Iw/LxDtLoaAhb3zkygApmSCTAKutczRJYJrtXkadzf/ddNGPk5ubv0hJpW4Yz2ENueYQ3vE00hBMVf8p25pcnR1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747730577; c=relaxed/simple;
	bh=uk2eADjbCkk5tMYU+fRK6B3rMnise6hWqMrnxpB3yhs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nHEfJU0h2H+n3kiveUegEbgForfvoaAD8/pPmbVapTfY+9zTtWUl7DD8kXrj9PYqc4ujT12hkB/mbulYUrDy/5dhmJ2eHkx10dPLBOPQjsp1pgBw0xhf3P3aW+dbgAbL1HA/uKklyzlO9xEcEzqw+ntj7yzfB10XmylZVlLRzkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=sHbbGf0A; arc=none smtp.client-ip=178.154.239.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="sHbbGf0A"
Received: from mail-nwsmtp-smtp-production-main-78.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-78.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:c54a:0:640:3e90:0])
	by forward100d.mail.yandex.net (Yandex) with ESMTPS id 28125608ED;
	Tue, 20 May 2025 11:42:45 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-78.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id igID4OvLZGk0-AWqGAegJ;
	Tue, 20 May 2025 11:42:44 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1747730564; bh=YnzdabmcOM9QwNXhvovsvbC0bjy6VQBO3BQurtaPhmI=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=sHbbGf0AILTx+68IKWpK52W4Ba5rwI+y6uga+FW75WEVBsi0Y8jaP8kV9/i68J/Y2
	 g8rZPMsuFn9+Jshbz1sf9ZBwUCZYnrRO4K6Rapra0nfB2bgFtuPfPddAa6xGOF3vUN
	 SFY86ZHoDtYYmAgOkmRmHcbmQdAUwiKMEugxB2qM=
Authentication-Results: mail-nwsmtp-smtp-production-main-78.klg.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Brian Gix <brian.gix@intel.com>
Cc: linux-bluetooth@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] Bluetooth: MGMT: iterate over mesh commands in mgmt_mesh_foreach()
Date: Tue, 20 May 2025 11:42:30 +0300
Message-ID: <20250520084230.502667-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In 'mgmt_mesh_foreach()', iterate over mesh commands
rather than generic mgmt ones. Compile tested only.

Fixes: b338d91703fa ("Bluetooth: Implement support for Mesh")
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 net/bluetooth/mgmt_util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt_util.c b/net/bluetooth/mgmt_util.c
index e5ff65e424b5..3713ff490c65 100644
--- a/net/bluetooth/mgmt_util.c
+++ b/net/bluetooth/mgmt_util.c
@@ -304,7 +304,7 @@ void mgmt_mesh_foreach(struct hci_dev *hdev,
 {
 	struct mgmt_mesh_tx *mesh_tx, *tmp;
 
-	list_for_each_entry_safe(mesh_tx, tmp, &hdev->mgmt_pending, list) {
+	list_for_each_entry_safe(mesh_tx, tmp, &hdev->mesh_pending, list) {
 		if (!sk || mesh_tx->sk == sk)
 			cb(mesh_tx, data);
 	}
-- 
2.49.0

