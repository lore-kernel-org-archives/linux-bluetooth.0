Received: from forward206d.mail.yandex.net (forward206d.mail.yandex.net [178.154.239.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AC319F40B
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 May 2025 18:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747938296; cv=none; b=TdO7dviQGUIXI44IMOqz174T+ygD0IqAhk27m9xaNvQtZV7OTUN4rFhKEgdB0JD4bmmjD+NDBzqfdxe6zmT21R6Xm/60fGENvSImzBGJC+Ff3LT3NBWA90+ZIYkr29R2wvIyeGbCsFJtp6TFEVrxO+xdEJcHopWJ3vendW3fsdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747938296; c=relaxed/simple;
	bh=b9JpZ7gOFHK3CIAcOVi8v6aXc5/LytOgbpjtpKPQ4E4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u4pCDrcAfViUWBpjCVXdw4AnrYnBA0wRN55sLquW9Yf2k+1pLl7j2TQrdO+RbQobHA/fWGHTthgMaf+ajDwWPTjgueM+/AZnBe3TXq6LQHc7UWFTGRQgajpgzQMXe4ClRvlYqwkpsjknmXb01ftxEtMtrbK/GmdJ47UDioAKU50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=gnfM2kff; arc=none smtp.client-ip=178.154.239.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="gnfM2kff"
Received: from forward102d.mail.yandex.net (forward102d.mail.yandex.net [IPv6:2a02:6b8:c41:1300:1:45:d181:d102])
	by forward206d.mail.yandex.net (Yandex) with ESMTPS id DCF3764B19
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 May 2025 21:17:05 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-95.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-95.klg.yp-c.yandex.net [IPv6:2a02:6b8:c43:7c8:0:640:150d:0])
	by forward102d.mail.yandex.net (Yandex) with ESMTPS id DA46C60908;
	Thu, 22 May 2025 21:16:57 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-95.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id uGUDVP1LdGk0-Sx0ks6wP;
	Thu, 22 May 2025 21:16:57 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1747937817; bh=RxVLOaSpiQ97kJc2PsBBLM/FNBKpqhQwhBV+ZgCh/HU=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=gnfM2kff9ffKdKcEaD0/IWWg2QnlFNNe/c/ffKyx/h4x/GeHQRKm/XnjfV+5kXJwN
	 a4hOz3B6V5K64Id7lw4DMIPVexRHmDDiM8tVYV8IPU0yTMf1O7p7UYNGxURZfhf6Sa
	 6Ys2VvXbRNbYIb4E9Fgwh8KLPtqpwD6gUYCOASzM=
Authentication-Results: mail-nwsmtp-smtp-production-main-95.klg.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>,
	syzbot+5fe2d5bfbfbec0b675a0@syzkaller.appspotmail.com
Subject: [PATCH] Bluetooth: MGMT: reject malformed HCI_CMD_SYNC commands
Date: Thu, 22 May 2025 21:16:02 +0300
Message-ID: <20250522181602.908248-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In 'mgmt_hci_cmd_sync()', check whether the size of parameters passed
in 'struct mgmt_cp_hci_cmd_sync' matches the total size of the data
(i.e. 'sizeof(struct mgmt_cp_hci_cmd_sync)' plus trailing bytes).
Otherwise, large invalid 'params_len' will cause 'hci_cmd_sync_alloc()'
to do 'skb_put_data()' from an area beyond the one actually passed to
'mgmt_hci_cmd_sync()'.

Reported-by: syzbot+5fe2d5bfbfbec0b675a0@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=5fe2d5bfbfbec0b675a0
Fixes: 827af4787e74 ("Bluetooth: MGMT: Add initial implementation of MGMT_OP_HCI_CMD_SYNC")
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 net/bluetooth/mgmt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 46b22708dfbd..86f4d0f172ab 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2566,7 +2566,8 @@ static int mgmt_hci_cmd_sync(struct sock *sk, struct hci_dev *hdev,
 	struct mgmt_pending_cmd *cmd;
 	int err;
 
-	if (len < sizeof(*cp))
+	if (len != (offsetof(struct mgmt_cp_hci_cmd_sync, params) +
+		    le16_to_cpu(cp->params_len)))
 		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_HCI_CMD_SYNC,
 				       MGMT_STATUS_INVALID_PARAMS);
 
-- 
2.49.0

