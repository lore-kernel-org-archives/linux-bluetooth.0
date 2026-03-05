Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD78B37F725
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Mar 2026 13:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772718676; cv=none; b=ep7RSmUb/OYa+1DVTa9nQh6H7BYigdJxJiI8kK4Jytct7TWr85cNKwciqyrQSPuS3t87qBEtS/9aX4RTUk4hg6ks+Q0EHThaSmQv2vGt0y61f75FJNidSOxE8j7fiFxUWfmz7I1/YezYrYa6TLStjLhX42sOF0hOV0fjw63cILM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772718676; c=relaxed/simple;
	bh=pbaRsuAakiM8r58pYNfV4RupOPW6NFqIVXI+pRF+P2o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=J/QHajg6MLs9aud/jWblxb5/OmifiQ/2T+KeBBcIyiqd6T1tNfcxaJfGaoyflyJvq3YM+PM6qxhi3JfZfIuL0Onu5HZdcQCy3J3rV8jIIODss8+fxocvZkfhE9wduaDA5NSds6fOAsQ76euapx/gSBZx7B1VS2eOvbAtMzyZvY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1vy96d-0004A7-Ut; Thu, 05 Mar 2026 14:51:11 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac] helo=dude04)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1vy96c-003tY4-18;
	Thu, 05 Mar 2026 14:51:11 +0100
Received: from [::1] (helo=dude04.red.stw.pengutronix.de)
	by dude04 with esmtp (Exim 4.98.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1vy96d-000000028Fy-2eQs;
	Thu, 05 Mar 2026 14:51:11 +0100
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Date: Thu, 05 Mar 2026 14:50:52 +0100
Subject: [PATCH] net: bluetooth: hci_sync: fix hci_le_create_conn_sync
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260305-bluetooth-fixes-v1-1-43effb810fba@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIADuKqWkC/x3LQQqAIBBA0avIrBPMMKKrRAu1KQdCQy0C8e5Jy
 8fnF0gYCRPMrEDEhxIF39B3DKzT/kBOWzNIIUcxCMXNeWMOITu+04uJG2knpYVGIzW064r4hzY
 ta60fnO2TDWEAAAA=
X-Change-ID: 20260305-bluetooth-fixes-b2c85a0aeb2a
To: Marcel Holtmann <marcel@holtmann.org>, 
 Johan Hedberg <johan.hedberg@gmail.com>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Michael Grzeschik <m.grzeschik@pengutronix.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1943;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=pbaRsuAakiM8r58pYNfV4RupOPW6NFqIVXI+pRF+P2o=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBpqYpPxrLG49ioY3799R5WhcIGl4sjbeFn913+k
 2Wqhaax3eSJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCaamKTwAKCRC/aVhE+XH0
 q5dND/oC7emb5rl7B3LK6Vv4loPAysnjSRauQ9EbjsZ+9oSXT2jOY1Mi7y4qw+Ojjny9iG2rbJr
 q7BV3YY+mwNUWv7z5VuwVPIfsPUewiQ+g4u4a6curtHR+JWmivIPiqnW2PPA3idC/EKQ75BFgc6
 UY1Xf19+ODOZCEnCb7ubKrl3k/ivpe/XAfXN0+O+i/IT0UmqEw0XP9AhKGzB3TksGMSRKaRbkeX
 DCQb8eY2WxJXA3x05JJCx7jgpEeMsgJB4Bg8RHqueHFNXET6Jlp8sqDDlQFlRnukIy2A4ykuoJA
 v09LGUivG67QZ1fckra+Nfvs/XKpEKw2OnvkFhlt8J9OTkmRJr9nbqhqAElVUkpyMEMDZAab6ZW
 oJS7FbCm9RAF2H+SnIVJn30RE7wgtU/gaKcDqrECtjVH9vCj9mXu4wbkuhVJ/c+J69pZziIAjAM
 3SbSiL8MqyrDHfVAJNBVXp+PnHMDw9tWJveK3rCHJ+BhrqBZ3wFbS6GnXxyDut8Xiv50/L86QxU
 dCv9/tcoD94IJ/aBqQnNXG9OUctpmpQRyYRWu7T4i9UG0v+r6rLqFivgAJL/9UC4yrIyXUeIInf
 ibLite2XbhUbh9ynMJEWx9bTWPBnVKYljaopNmoXBWdrXWUjnFojBl8WrL4BSHeKdhVsIYHKcrm
 DVQ4cCWwKJlZvoA==
X-Developer-Key: i=m.grzeschik@pengutronix.de; a=openpgp;
 fpr=957BC452CE953D7EA60CF4FC0BE9E3157A1E2C64
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: m.grzeschik@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-bluetooth@vger.kernel.org

While introducing hci_le_create_conn_sync the functionality
of hci_connect_le was ported to hci_le_create_conn_sync including
the disable of the scan before starting the connection.

When this code was run non synchronously the immediate call that was
setting the flag HCI_LE_SCAN_INTERRUPTED had an impact. Since the
completion handler for the LE_SCAN_DISABLE was not immediately called.
In the completion handler of the LE_SCAN_DISABLE event, this flag is
checked to set the state of the hdev to DISCOVERY_STOPPED.

With the synchronised approach the later setting of the
HCI_LE_SCAN_INTERRUPTED flag has not the same effect. The completion
handler would immediately fire in the LE_SCAN_DISABLE call, check for
the flag, which is then not yet set and do nothing.

To fix this issue and make the function call work as before, we move the
setting of the flag HCI_LE_SCAN_INTERRUPTED before disabling the scan.

Fixes: Bluetooth: hci_sync: Add hci_le_create_conn_sync ('8e8b92ee60de5341e9db83c11f75a525e555e2b3')
Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 net/bluetooth/hci_sync.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 121dbc8208ec231210505135187e769028c17483..3166914b0d6ce3e56ced2f9a7914427296d38c48 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6627,8 +6627,8 @@ static int hci_le_create_conn_sync(struct hci_dev *hdev, void *data)
 	 * state.
 	 */
 	if (hci_dev_test_flag(hdev, HCI_LE_SCAN)) {
-		hci_scan_disable_sync(hdev);
 		hci_dev_set_flag(hdev, HCI_LE_SCAN_INTERRUPTED);
+		hci_scan_disable_sync(hdev);
 	}
 
 	/* Update random address, but set require_privacy to false so

---
base-commit: c107785c7e8dbabd1c18301a1c362544b5786282
change-id: 20260305-bluetooth-fixes-b2c85a0aeb2a

Best regards,
-- 
Michael Grzeschik <m.grzeschik@pengutronix.de>

