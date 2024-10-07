Received: from forward100b.mail.yandex.net (forward100b.mail.yandex.net [178.154.239.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8F11BC5C
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Oct 2024 07:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728287154; cv=none; b=IJmB0yqEPlP7TrDvjrW+9jQVZXqTlvYp7XdH94JIeoOmfDfFLQBonqZx0n72tgIA2tqHDg1lzZwi2aenk/thS8w4i/sZ+d9/LJ4dwyBezJYVLTx2uLX4hLMfEgjhIkeIFvAUA1d06ZNBSPyPZXNNPEHGX+e3bDnh6P4HPKjmnLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728287154; c=relaxed/simple;
	bh=x2zbooBF33TYaBLRUcwYwyzT5+3QU3mG04Ez/Vc29Fw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mLPDnuXUkQ+jI2Aou9TGxKk+lLKjR1YDmdovuQsv4q1d9awcydOpaA8PGus1ddlTZzOyDQ+7p1IcMW9uuIqxak4/VOD8sfhf023VxDb9NR2KU7L0sN92FncLpHnea9HNmTNSSno6MoyOGc3hpwzGoYeyGo9d++/l5MRKyO3qpqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=vioV+SzY; arc=none smtp.client-ip=178.154.239.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="vioV+SzY"
Received: from mail-nwsmtp-smtp-production-main-17.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-17.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:aba6:0:640:703c:0])
	by forward100b.mail.yandex.net (Yandex) with ESMTPS id 0786F60AB3;
	Mon,  7 Oct 2024 10:45:42 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-17.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id eja7oaf7WqM0-5vxSF4re;
	Mon, 07 Oct 2024 10:45:41 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1728287141; bh=fGDwIrAyo1ywJtzlqnxwdOIxL8rYhs73gLcpDxH2zSo=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=vioV+SzYvXrS7zzgZ/EEt+iWApwweApwdAOc/aFbnabjaiu3Se/URPniZAc3OO0Jj
	 eGqnRO4wPah5AC6a42C1p82wZNgePOQWmFMIZlyEPhZ5lpKT6yI/GFieT4fhcK6AKz
	 9WGOcjVHAT42PQIIQYHVswrpJxqI7VWtsbPFj+y4=
Authentication-Results: mail-nwsmtp-smtp-production-main-17.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>,
	syzbot+03d6270b6425df1605bf@syzkaller.appspotmail.com
Subject: [PATCH] Bluetooth: do not send mgmt commands to device which is going to close
Date: Mon,  7 Oct 2024 10:45:38 +0300
Message-ID: <20241007074538.109613-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Yandex-Filter: 1

Syzbot has observed the following race between 'hci_dev_close()' and
'hci_cmd_sync_work()':

T0:                             T1:

...
-> sock_ioctl()
 -> sock_do_ioctl()
  -> hci_dev_close()
   -> hci_dev_close_sync()
    -> __mgmt_power_off()        ...
     -> mgmt_pending_foreach()   -> process_scheduled_works()
      -> settings_rsp()           -> hci_cmd_sync_work()
       -> kfree()                  -> set_powered_sync()

That is, 'hci_cmd_sync_work()' makes an attempt to process a command
from (partially) freed 'cmd_sync_work_list', which causes UAF detected
by KASAN. Fix this by marking the closing device with HCI_CLOSING bit
very early and rejecting new mgmt commands for such a device.

Reported-by: syzbot+03d6270b6425df1605bf@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=03d6270b6425df1605bf
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 include/net/bluetooth/hci.h | 1 +
 net/bluetooth/hci_core.c    | 4 ++++
 net/bluetooth/hci_sock.c    | 5 +++++
 3 files changed, 10 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index bab1e3d7452a..492723a22e68 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -345,6 +345,7 @@ enum {
 	HCI_UP,
 	HCI_INIT,
 	HCI_RUNNING,
+	HCI_CLOSING,
 
 	HCI_PSCAN,
 	HCI_ISCAN,
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 629c302f7407..95f55cfb6da6 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -501,12 +501,16 @@ int hci_dev_close(__u16 dev)
 		goto done;
 	}
 
+	set_bit(HCI_CLOSING, &hdev->flags);
+
 	cancel_work_sync(&hdev->power_on);
 	if (hci_dev_test_and_clear_flag(hdev, HCI_AUTO_OFF))
 		cancel_delayed_work(&hdev->power_off);
 
 	err = hci_dev_do_close(hdev);
 
+	if (unlikely(err))
+		clear_bit(HCI_CLOSING, &hdev->flags);
 done:
 	hci_dev_put(hdev);
 	return err;
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 2272e1849ebd..ff43718822d4 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -1671,6 +1671,11 @@ static int hci_mgmt_cmd(struct hci_mgmt_chan *chan, struct sock *sk,
 			goto done;
 		}
 
+		if (unlikely(test_bit(HCI_CLOSING, &hdev->flags))) {
+			err = -ENODEV;
+			goto done;
+		}
+
 		if (hci_dev_test_flag(hdev, HCI_SETUP) ||
 		    hci_dev_test_flag(hdev, HCI_CONFIG) ||
 		    hci_dev_test_flag(hdev, HCI_USER_CHANNEL)) {
-- 
2.46.2

