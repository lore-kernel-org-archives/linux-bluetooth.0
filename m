Received: from forward201d.mail.yandex.net (forward201d.mail.yandex.net [178.154.239.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76CD302753
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jun 2026 15:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781710763; cv=none; b=dAL/psp88wncpMK4Ej4GxtFJXHA9sS4whp8o2p6J+qWHIWKCpeZHHoOf6Z79TkRfVYcmO82A1dt4tF4/zwjEPlw94ctVbPUfdVejlHtsP1TULuK3Fe2ny0eE/r8EcoITZkcrSfty+FHZLx5wEY2z7nBCNt61by18LvzkyfZ8BnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781710763; c=relaxed/simple;
	bh=hAde8Pi+/J3tXRLFcIp1JY71AVclSjljsSJIuztIfbk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oW0+5c6GBgZmyVl+n5rApM9OynL+6QKxcnjy71eAtv9RbMMPzdBMB4vKlU66WbiEitE3356JyA1OUnHesSBGeu5rzTu0+PCAHjJSqllr2M2vAkvXBClDYADGMqBAv828q0qC6YOjqsDGb1fSKD7djkpNSPOURR+qzoNWt70azXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=e4pb889F; arc=none smtp.client-ip=178.154.239.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="e4pb889F"
Received: from forward102d.mail.yandex.net (forward102d.mail.yandex.net [IPv6:2a02:6b8:c41:1300:1:45:d181:d102])
	by forward201d.mail.yandex.net (Yandex) with ESMTPS id 0F31E83231
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jun 2026 18:33:14 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-84.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-84.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:26c5:0:640:cf7d:0])
	by forward102d.mail.yandex.net (Yandex) with ESMTPS id ADB10C0120;
	Wed, 17 Jun 2026 18:33:05 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-84.klg.yp-c.yandex.net (smtp) with ESMTPSA id 4XTjtvmg8W20-GlYhcsjH;
	Wed, 17 Jun 2026 18:33:05 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1781710385; bh=MwCKNo3F1q1xvlAAlFqH+RRQoQhg+3zLSBDivGPBqx0=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=e4pb889Fab756JDTE06ypDA1V/wqX5XzYzNTNuURSLlSo0ItovboKyE/kwiuVMCMh
	 atkF58mdGk3XrUFLlqlwjhHU4CWk3fSQS6u8LauaZu+Ond3b4zMeJp1pCzyYmpU6II
	 SB8EUM5GCx2FcBPllJ2sXss9/7U8vmBys+G/R3is=
Authentication-Results: mail-nwsmtp-smtp-production-main-84.klg.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] Bluetooth: simplify force_no_mitm_write() with kstrtobool_from_user()
Date: Wed, 17 Jun 2026 18:30:19 +0300
Message-ID: <20260617153019.981515-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify 'force_no_mitm_write()' by using the convenient
'kstrtobool_from_user()'.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 net/bluetooth/hci_debugfs.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
index 0635e4641db4..aadffaaff20e 100644
--- a/net/bluetooth/hci_debugfs.c
+++ b/net/bluetooth/hci_debugfs.c
@@ -1161,16 +1161,12 @@ static ssize_t force_no_mitm_write(struct file *file,
 				   size_t count, loff_t *ppos)
 {
 	struct hci_dev *hdev = file->private_data;
-	char buf[32];
-	size_t buf_size = min(count, (sizeof(buf) - 1));
 	bool enable;
+	int err;
 
-	if (copy_from_user(buf, user_buf, buf_size))
-		return -EFAULT;
-
-	buf[buf_size] = '\0';
-	if (kstrtobool(buf, &enable))
-		return -EINVAL;
+	err = kstrtobool_from_user(user_buf, count, &enable);
+	if (err)
+		return err;
 
 	if (enable == hci_dev_test_flag(hdev, HCI_FORCE_NO_MITM))
 		return -EALREADY;
-- 
2.54.0

