Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C569519BDE
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Nov 2023 22:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="glKHthNQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89133C433C7;
	Wed, 22 Nov 2023 22:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700691492;
	bh=pXFt8KxeskxjDuI8ULnmxTHFdpsi5bDQYyGvBUP0idU=;
	h=From:To:Cc:Subject:Date:From;
	b=glKHthNQb4E6cjtC2SuFlrOYnN7It85p9TOtJ0JMC6aWadKlgzcoRO06Dmw/whaTC
	 NbwX1bwg/a0Uim3ArNlImVetSYLA4oxmr7C5q+rmkWxGtdntO99QZfFdqiH2f78VeE
	 dlNw3RHFZB2gNP/Ap1/dz5HFByoKjRdqhhXO9y5/vtI2DZtqFnvdbbhFxu+CAoGjpB
	 1StCDTO9rSvyrhd2NgieezOF5gCXCQwnd2CtDUxzx+NGI6TQsOWPcC+UzUWYJ8HqYW
	 am9ZpkKIN4LimfObGivje5pIysb5yeR7pgqfqcQppqIC1fxo4hYGwEbK5Aq3LfE2TU
	 5u5dqCrUP4JkQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>,
	Pauli Virtanen <pav@iki.fi>,
	Jakub Kicinski <kuba@kernel.org>,
	"Lee, Chun-Yi" <jlee@suse.com>,
	Claudia Draghicescu <claudia.rosu@nxp.com>,
	Ziyang Xuan <william.xuanziyang@huawei.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_event: shut up a false-positive warning
Date: Wed, 22 Nov 2023 23:17:44 +0100
Message-Id: <20231122221805.3139482-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Turning on -Wstringop-overflow globally exposed a misleading compiler
warning in bluetooth:

net/bluetooth/hci_event.c: In function 'hci_cc_read_class_of_dev':
net/bluetooth/hci_event.c:524:9: error: 'memcpy' writing 3 bytes into a region of size 0 overflows the destination [-Werror=stringop-overflow=]
  524 |         memcpy(hdev->dev_class, rp->dev_class, 3);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The problem here is the check for hdev being NULL in bt_dev_dbg() that
leads the compiler to conclude that hdev->dev_class might be an invalid
pointer access.

Add another explicit check for the same condition to make sure gcc sees
this cannot happen.

Fixes: a9de9248064b ("[Bluetooth] Switch from OGF+OCF to using only opcodes")
Fixes: 1b56c90018f0 ("Makefile: Enable -Wstringop-overflow globally")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 net/bluetooth/hci_event.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 5b6fd625fc09..5651e96e78da 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -516,6 +516,9 @@ static u8 hci_cc_read_class_of_dev(struct hci_dev *hdev, void *data,
 {
 	struct hci_rp_read_class_of_dev *rp = data;
 
+	if (WARN_ON(!hdev))
+		return -ENXIO;
+
 	bt_dev_dbg(hdev, "status 0x%2.2x", rp->status);
 
 	if (rp->status)
-- 
2.39.2

