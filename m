Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.191
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793176397;
	b=X4dqxzxkCsaTpCkTsHLyvBqKhAmjqnFsmlRMroBDqRFkWxkyF+Ug/5Z0zJQDk4v4kKjp
	 ovzbndkgl4V50JkHJX0bxzU3JqW4+iBG0AxqsoiIgvXyeUDXQjoAXMk1rvVJOPBiS68Jd
	 tfGZYmWT1YL8rxgt+ty32j4cuD69+h8MW5TsfH5vm53FNFqALmPE7bpUL/oAeI6c3CKfA
	 ItEIZBnkqHVYT/Xjcfzq2QIKUIvMhInhKmEyhLEYfPIMANGfvuSTDMDKOhuhS7e6oDNRs
	 r4A+XpA31TdLeqKY3nVMG+q5eVS2Z7fVOBpvC3QiC7F6JJrhRqkdCHk5a/NH90bdKqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793176397;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=QLm/yffEnsJh1miThy9hpGDyLWes9YsIW3RPGR3pfmg=;
	b=CHohtx44xA3gFm2RJTSJW9dMi5k1PAfXzlWxKT51FB/ItAuXndjrmGu5Tpk4SKYrbI//
	 bKnKeQPffck1rVzRo4DdH8cntd90e2KOn3nBk3G5V17tRUpF1Qz6v6h+HQlPsT9P1zz4/
	 r6cRAdn3URKchuqjVK9UyJQI6AqFBYCETl4g2QzYULVGRa5NhYklWm+dDyCP117X4Yv0C
	 RL6Eelm2breq4jbE3F4aTKkwJhw8tJe5tguIe63dAkM8t4NFFVNQWHV7eIG0wMLzq2YMJ
	 YBs3b6LYNVuHc3lTgcrw1s0+uYcwI5/mmksSqLM1zqyS//kr+rhNaw4shBuL6AZJuKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=EFEIcqG1;
	arc=none smtp.remote-ip=203.205.221.191
Received: from out203-205-221-191.mail.qq.com (out203-205-221-191.mail.qq.com [203.205.221.191])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98556606A31D;
	Wed, 28 Oct 2026 08:33:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98556606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=EFEIcqG1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1793176387; bh=QLm/yffEnsJh1miThy9hpGDyLWes9YsIW3RPGR3pfmg=;
	h=From:To:Cc:Subject:Date;
	b=EFEIcqG1ftzq6iPwATXsX5KoH6eyYvPd4fSMH5jQqKPcrK70dcNB99dj4MlCA/jsd
	 8e0CgmhmSuB7j3C2L8Uh6rDXLd+iv1GHUq0DyQCmMZud0kWPaDPKsrKN7yG/YJ4D6i
	 kpDUs73HVx4IoHS8GRPZx1B0R3h1dHWk7kBWHcMg=
Received: from [172.18.4.77] ([111.31.227.58])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id 84524222; Wed, 28 Oct 2026 16:33:05 +0800
X-QQ-mid: xmsmtpt1793176385t2ue1xls5
Message-ID: <tencent_884B14762AC6B7F8489E13AEA94994BD4F06@qq.com>
X-QQ-XMAILINFO: N7OyF/iLIkDUbM7oiISnnm88vjyhRdclEpC4X3/kKnrB+E3RWTXS47vF9U+sBw
	 FwVj+VXS11Irb0NC0z1/l6Tq2C44FCZW7jBI+6gTV/qk8msloq0QVN9OAWuBEUJWSwoCho5IHWNc
	 9mQD8Ig0UDtGZtrsTKp0ErTDVrrCw15Ty9nBK79CLBJuzD12DQrGtT5evSnaj0Dv+vwOBcmynog7
	 y1MHuKjvebccbDx7BLhxQyrLrR7ZJ57yXdV1QZesqk54yoaTaRviTjkveCKehREPsHj7OIemmXnX
	 7/3SWkzXPaP+D+L0+KORDVr3YgRwY6PFwRw9BAOG7Yg99Z3wytV7f9eUdeEWpim39SCW7v/PWP+j
	 bMfmzlvKt+Fm85gSWvogJPPIK7oDmX2hHnjwZRZ0TxSyE728P4Gxto8RlukEyoCc013bT83iEEYK
	 JyA4HXzbqe2F+lz92cW8MK7rS/Lowc6NrtzGxw2C3x6CScl14H7YxHshzEucylWOpGxMr4cuiA2B
	 OPgAsTZ3vMUaaWnSR6VsVoCrC5JmIgzoT6zPGZ9L5ZCOHZ3ErLjiWmJDg/gnxtECqIcfhIL150AC
	 PMN5DDeoRulxLGndANsZ7Cng26TlsALKpJdN4n+dcLAGW7kF1ybK9SEd96jAcsHH5CxUk+Cw8Fg9
	 c30nzDVD2qBDqQcHCh6eefN7nJi7ryDYZHINWQZFVAvkd9WwY5eXikzYataeS9srUgOu4aplOj+e
	 hB7MaXinOCppkMc1QvLgLjcNO6SIiWVS/8r0867dSqMgzVcaS0KOT67ITDnCA7LiYyy1ujc7LF/8
	 hHz4wNmF2IuDetB9NfAK6TI3XD0tAVqpDIUfWx7qdF99/wuOlws2r4hSz6ZbIYPBLeHvuxp+JphD
	 eu+Mhi7WEr7pi3gI/h5sB/qsjSy3uIO6HZG3LQvKnN7/iwUOvCmriWtM2jYoNdAzPjiO87zmkEto
	 w3RhH9oSvIIMEJlDAOlN7cwB4/2tWMoMeb1lTyXkCkszjRpuLtLeCXd0CjIweMkyVAJKsVK/5Ck7
	 0ZEubdagW1iJnkUpAa2srUl/iqjDWVWltg8cktUBZ/AVdaMGZGRmyLrXVqJw06L9ocjtb0+G8oeB
	 0NvFNYct+Rzh+Rx/um7Oa2ccmxWA==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
From: Yang Guikun <yangguikun19@qq.com>
To: marcel@holtmann.org, luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_core: Check HCI_CMD_DRAIN_WORKQUEUE in
 hci_cmd_timeout()
Date: Wed, 28 Oct 2026 16:33:04 +0800
X-OQ-MSGID: <179317638494.33108.2879635829580596112@qq.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Bluetooth: hci_core: Check HCI_CMD_DRAIN_WORKQUEUE in hci_cmd_timeout()

hci_cmd_timeout() runs from timer softirq and queues cmd_work
unconditionally.  If the timer expires while hci_dev_close_sync() is
in drain_workqueue(), __queue_work() sees __WQ_DRAINING and warns:

  workqueue: cannot queue hci_cmd_timeout on wq hci0

cmd_timer is cancelled only after drain_workqueue(), so the window
between them is reachable when an HCI device with a command outstanding
is powered off via rfkill.

hci_cmd_work() and handle_cmd_cnt_and_timer() already skip queuing when
HCI_CMD_DRAIN_WORKQUEUE is set; hci_cmd_timeout() is the remaining
unchecked producer.

Fixes: 525daaea459f ("Bluetooth: hci_sync: Set HCI_CMD_DRAIN_WORKQUEUE during device close")
Signed-off-by: Yang Guikun <yangguikun19@qq.com>
---
 net/bluetooth/hci_core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 209244fd9391..3333333333333 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1441,7 +1441,10 @@ static void hci_cmd_timeout(struct work_struct *work)
 		hdev->reset(hdev);
 
 	atomic_set(&hdev->cmd_cnt, 1);
-	queue_work(hdev->workqueue, &hdev->cmd_work);
+	rcu_read_lock();
+	if (!hci_dev_test_flag(hdev, HCI_CMD_DRAIN_WORKQUEUE))
+		queue_work(hdev->workqueue, &hdev->cmd_work);
+	rcu_read_unlock();
 }
 
 /* HCI ncmd timer function */
--
2.39.5

