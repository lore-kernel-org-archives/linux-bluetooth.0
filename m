Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED80927CB35;
	Thu,  8 Jan 2026 06:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767852226; cv=none; b=M2WXjZIYecj53gJyf9JE+DZtDZE1Q+R/5AfcCaSFs3PEg19STEvMNjBwN/ZXAUCVxWZpjp3lCZ1rFz61j0dGq9IJivd2AS2tRsTNpAwZ4QPtW1YfUG1GjrkYjdwJJqhKMGrsxBlVEFcpsglpG77dZNhZCt6K7EKWFELMYmQHFjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767852226; c=relaxed/simple;
	bh=CKyNq1NWChj7ya9Oq1lfLc51ZJzMj2XpH5L/WpPvnB4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=f3oOC88xoCMRTv8/Ta6PoMa5EnqrZaUEk/AN2IrI/y7weGab6KSNmxyMq8NLI3pDrZ1tx4tfNhC5AcdDFzMkCk8GQnCCy7ihPaSm9gEQbwMSr/RayPotq+TUPMi7kH07gHwqZG2IP1DO5Eq9uxSYLAjFki7+forHoRfDSf8b45s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MqyStlNv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MqyStlNv"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6AFE0C116C6;
	Thu,  8 Jan 2026 06:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767852225;
	bh=CKyNq1NWChj7ya9Oq1lfLc51ZJzMj2XpH5L/WpPvnB4=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=MqyStlNvhSJehhLBp5Vi6w17IK0L2Dq3vpluTRbD8Ww0FLvjdAeLnon7z85jGOPrb
	 zpiPvi+Uail5mYv5Y96t8+fdn1Od++aTWdMz9fXUxxq2RTjjMnla8AnQzl/Ywi5tfV
	 tutO2Qie5IAdAcjWPGl6h8WxBYLJ2mIHRBFh8u2jOGdi/53yU2YWymuq4H1jYTJFip
	 2moBcVTD2LeN4988/H+R+YfjNh7Zpcf+su3tncRFUYGwGX5WlzjcSdvvrml9BI+7QG
	 anqTIiBb6RGZPf3psx190nw7aYVzR2DclVW26NtTj69HcI4g1Z6nr3tcDLsSFukw8a
	 WDozL9b23dFMg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A4F2D1489E;
	Thu,  8 Jan 2026 06:03:45 +0000 (UTC)
From: Yang Li via B4 Relay <devnull+yang.li.amlogic.com@kernel.org>
Date: Thu, 08 Jan 2026 14:03:43 +0800
Subject: [PATCH] Bluetooth: hci_sync: use HCI_CMD_TIMEOUT for PA sync
 commands
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260108-pa_sync_cmd_timeout-v1-1-cd35538a9e12@amlogic.com>
X-B4-Tracking: v=1; b=H4sIAL5IX2kC/x3MQQqAIBBA0avErBNMyqKrRIjpWLPIQi2K6O5Jy
 7f4/4GIgTBCXzwQ8KRIm8+oygLMov2MjGw2CC4kr3jHdq3i7Y0yq1WJVtyOxJyrpZPt1FihIZd
 7QEfXfx3G9/0Ayt2KJ2UAAAA=
To: Marcel Holtmann <marcel@holtmann.org>, 
 Johan Hedberg <johan.hedberg@gmail.com>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yang Li <yang.li@amlogic.com>
X-Mailer: b4 0.13-dev-f0463
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767852223; l=1484;
 i=yang.li@amlogic.com; s=20240418; h=from:subject:message-id;
 bh=1O83adufpo4acrwmwduYN71Xx5kLK1t2Ua61MN8F4NE=;
 b=Cdlv16KMn8w2ybeFmj82eYRvMc/rq6vK4TcvG8hY0i4gE/k261AUGaJUWe+POH9g6agJFzfJh
 3TzIpqOOZ2LA0g9KViPi8yqnM/1iNsoMXR9V3V+rxEYH4G5pehtBZmb
X-Developer-Key: i=yang.li@amlogic.com; a=ed25519;
 pk=86OaNWMr3XECW9HGNhkJ4HdR2eYA5SEAegQ3td2UCCs=
X-Endpoint-Received: by B4 Relay for yang.li@amlogic.com/20240418 with
 auth_id=180
X-Original-From: Yang Li <yang.li@amlogic.com>
Reply-To: yang.li@amlogic.com

From: Yang Li <yang.li@amlogic.com>

PA sync HCI commands incorrectly use conn->conn_timeout, which defaults
to 20s and is too long. If the PA Sync Established event is not
received, the command remains pending and causes userspace timeouts.

Signed-off-by: Yang Li <yang.li@amlogic.com>
---
 net/bluetooth/hci_sync.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index f04a90bce4a9..58292b01f062 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -7159,7 +7159,7 @@ static int hci_le_pa_create_sync(struct hci_dev *hdev, void *data)
 	if (conn->sid == HCI_SID_INVALID) {
 		err = __hci_cmd_sync_status_sk(hdev, HCI_OP_NOP, 0, NULL,
 					       HCI_EV_LE_EXT_ADV_REPORT,
-					       conn->conn_timeout, NULL);
+					       HCI_CMD_TIMEOUT, NULL);
 		if (err == -ETIMEDOUT)
 			goto done;
 	}
@@ -7187,7 +7187,7 @@ static int hci_le_pa_create_sync(struct hci_dev *hdev, void *data)
 	err = __hci_cmd_sync_status_sk(hdev, HCI_OP_LE_PA_CREATE_SYNC,
 				       sizeof(cp), &cp,
 				       HCI_EV_LE_PA_SYNC_ESTABLISHED,
-				       conn->conn_timeout, NULL);
+				       HCI_CMD_TIMEOUT, NULL);
 	if (err == -ETIMEDOUT)
 		__hci_cmd_sync_status(hdev, HCI_OP_LE_PA_CREATE_SYNC_CANCEL,
 				      0, NULL, HCI_CMD_TIMEOUT);

---
base-commit: bdb9aba465a85122bcba01a6154e237b9843e25b
change-id: 20260108-pa_sync_cmd_timeout-ff46f67b5d2a

Best regards,
-- 
Yang Li <yang.li@amlogic.com>


