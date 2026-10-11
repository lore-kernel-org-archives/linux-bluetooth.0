Received: from vtj.irix.systems (vtj.irix.systems [82.76.27.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557EE40B102;
	Sun, 11 Oct 2026 22:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.76.27.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791756855; cv=none; b=Kgr0VJFehibiFjSspAq6FSWmbsZhQwBNteFddG7Mu4a+aJE4hhBv7Fq54Rm4d+wnYc53yKYvnn8ntkt4N/mX9Jj8I1HKNllJLThcMnJGyGG1NYfsZz0FMBkchVFcU5B+2Uw5j3BRpiR0qh9gjcEcXajLikrFPmxpCzr2JxMOh0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791756855; c=relaxed/simple;
	bh=1b74iChqc5NtQbvny2oGmv4lWDkMHIm73DJ3k5t/lng=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Eq3lrGWJyJTSxTwQbUhKM31s493+CXrSmr0JmS/p3vdUadwSKDpqAAi5mv2XL2W6vmra5mqEgpQp+9tdImKHqv6I5mNMEnh122T8axvDxE10AN/JSvq5fV4i2TyL143eFiDK1wtq1xakxc60voUEsYLc4iB1w7nF/WCB3NU/fqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=andrei-z.com; spf=pass smtp.mailfrom=andrei-z.com; dkim=pass (2048-bit key) header.d=andrei-z.com header.i=@andrei-z.com header.b=G2WFGrop; arc=none smtp.client-ip=82.76.27.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=andrei-z.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andrei-z.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=andrei-z.com header.i=@andrei-z.com header.b="G2WFGrop"
Received: from MAILGW-HP.hp.vtj.corp.irix.systems (localhost [127.0.0.1])
	by vtj.irix.systems (Proxmox) with ESMTP id 9BBD793D;
	Mon, 12 Oct 2026 01:08:20 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=andrei-z.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=sig1; bh=sbFvtNblSOKcTq0tGj4bFEP7FjquI1wze4iWYGm3Vy0=; b=
	G2WFGropWeTtorVuLmXggmqAJ04FNXw0PSKOtv7W0LiprptFi574u2Sly2eCEUcc
	8fcBWX1+bSCJ4X/3KCj45olookTO9amrdRE9QK16yf4dVzKSe+sGAT6ODeirdQ4p
	AFZsDPqbaKpnXBP7SWWkFZfKw5CIdL2d6zfb0S7l4nBLCAkVdbonhjlF8GOcdXdz
	3Iurus7p4kZIY7LdREnUvyY+Ax8UF8ANodmLoz+IQESJy/ZqjOIkoErpsVIGpL+U
	31wsbnkaOz0VYivYK37cnnYxoHDsPmRKLBIFsBKS6qzx0JqKeSuZpIT+ddyR9RHM
	K3aRIIPTN05CZA2CFDdONA==
Received: from VTJ-MX.corp.irix.systems (unknown [IPv6:2a02:2f04:1:9c24::6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by vtj.irix.systems (Proxmox) with ESMTPS id CDC28990;
	Mon, 12 Oct 2026 01:08:18 +0300 (EEST)
Received: from workspace.corp.irix.systems (2a02:2f04:1:9c23::c) by
 VTJ-MX.corp.irix.systems (2a02:2f04:1:9c24::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 01:08:18 +0300
From: Andrei-Alexandru Bleortu <me@andrei-z.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Marcel Holtmann
	<marcel@holtmann.org>
CC: <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>, George
 Moussalem <george.moussalem@outlook.com>
Subject: [PATCH] Bluetooth: hci_core: program a public address set during auto off
Date: Mon, 12 Oct 2026 01:08:13 +0300
Message-ID: <20261011220813.1815075-1-me@andrei-z.com>
X-Mailer: git-send-email 2.47.3
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

When a controller with a set_bdaddr callback registers configured, it is
powered on, mgmt adds its index, and HCI_AUTO_OFF powers it off two
seconds later unless something powers it. Within that window mgmt counts
it as not powered, so Set Public Address is accepted: it sets HCI_CONFIG
and HCI_AUTO_OFF, removes the index and queues power_on. hci_power_on()
then finds the device up with HCI_AUTO_OFF set and takes the "already
up" path: it never opens the device again, so set_bdaddr() is never
called, and HCI_CONFIG is never cleared, so the index is never added
back. The controller stays up, invisible to mgmt, with its old address.

Close the device first when HCI_CONFIG is set, keeping HCI_AUTO_OFF, so
the open procedure programs the address and the configured index is
added as after any configuration change.

Seen on the IPQ5018 Bluetooth controller of a UniFi U6 Enterprise, whose
NVM carries a placeholder address: setting the board's address with
btmgmt right after boot left hci0 up with no mgmt index (bluetoothd saw
no controller); with this change the address is programmed and the
index comes back.

Assisted-by: LLM
Signed-off-by: Andrei-Alexandru Bleortu <me@andrei-z.com>
---
Transparency note: developed with an LLM coding assistant (Claude),
which traced the bug while bringing up Bluetooth on the board below and
wrote the change and this message. Tested on a UniFi U6 Enterprise
(IPQ5018 with George Moussalem's btqcomipc v5, Linux 7.2.8, BlueZ):
btmgmt public-addr right after boot now programs the address and the
mgmt index comes back. W=1 build of net/bluetooth and drivers/bluetooth
on next-20261009 is clean.

 net/bluetooth/hci_core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 3ea5ea726..f37f10936 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -908,6 +908,16 @@ static void hci_power_on(struct work_struct *work)
 
 	BT_DBG("%s", hdev->name);
 
+	/* A public address set while the controller was still up from its
+	 * initial power on, which mgmt counts as off until the auto off, is
+	 * only programmed by the open procedure: close it to open it again.
+	 */
+	if (test_bit(HCI_UP, &hdev->flags) &&
+	    hci_dev_test_flag(hdev, HCI_CONFIG)) {
+		hci_dev_do_close(hdev);
+		hci_dev_set_flag(hdev, HCI_AUTO_OFF);
+	}
+
 	if (test_bit(HCI_UP, &hdev->flags) &&
 	    hci_dev_test_flag(hdev, HCI_MGMT) &&
 	    hci_dev_test_and_clear_flag(hdev, HCI_AUTO_OFF)) {

