Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793759282;
	b=ZZa+knZ9IUZuds4wQVqHs6I5Bywru3LtN/9Ub+oILtzSWhTLq+3i4Ep6yryOyo01+PmL
	 7Ce+fHUgSnQnTr7ylwFWxDb4rKX0OUgN3xxLvpAqAWzA9sz8wau9M/P7F9g0PsR3N84Uu
	 pjX/7uHkvfsNcI3FvHS86y1fEOnkERgzzD1crBN/aS7Z2166Uh/vcnZyGCzlyKjc459L0
	 rCKQf0g63D50sJb3uoUXS+TZCHeDMhnLLHCRq+gbxYoV0ewvTZQJj0+HHO+dpwbl35vUs
	 NZ5TRGgcCMRpgxnp83lKymkHad0d/E+pDebtuNy8NRC0Zq8tJ7kiic9CT/9a1+fDzCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793759282;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=ukk19TjiT58WsMOJ5y87WbYGqrr01VsH1D2qhFOa7Bk=;
	b=h9jEvOMV0dJQ/6ThqzDMMHRjLwzfxcU3O0ArKDCbu91g4/T2WdYmem7XUdYSGIIsHI4D
	 VGTaFTZKOZ8haUzIZsHPZcnvTka4McKaygHsGLpNpG9/tilLe5Ouk1O8Mo0LUFpQy67cc
	 tTQZUhyCV8iGuFbttQWnfJ7YYLrLcQf3yhG+RPwmk9m9hgi28762icF8VX4Iuarx4Fs67
	 G9uDMQuzoXB9LqSiZ5pCdoMQJkE+bqNR6oD0tYcsCDju33IBnu1rWYVuq6GzLa31Zi1p3
	 5Ju/LqPP/xYxYDzbSdZFpXCZlKOon5mC+7oU59ybHk1g5wqwLHbwb2XG48Sz1ermtVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.21
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21166606A31B
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2026 02:28:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21166606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-01 (Coremail) with SMTP id qwCowACXvvgvmOpqlZs+AA--.9821S2;
	Wed, 04 Nov 2026 10:28:00 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: free the mesh tx if queueing the send fails
Date: Wed,  4 Nov 2026 02:28:09 +0000
Message-Id: <20261104022809.1484148-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowACXvvgvmOpqlZs+AA--.9821S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ArWUCw1fZr13Jr48Ww17Wrg_yoW8Xry3pa
	90gFn8Ary8GFW7Ja1xXrWkAFWq9r43Gry7Cr4q93yFyrs8XFW0qry5WryjvrnYvrZ2yr4U
	AF4kKFnxCa4kCFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkmb7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
	AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
	6r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14
	v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xf
	McIj6xIIjxv20xvE14v26Fy26r45twAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxF
	aVAv8VW8GFyrJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
	18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vI
	r41lIxAIcVC0I7IYx2IY67AKxVW7JVWDJwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Cr0_Gr1UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUyGYpUUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgIBA2rqY4LLJAAAsI

mesh_send() puts the new mesh_tx on hdev->mesh_pending through
mgmt_mesh_add(), which takes a socket reference, and only then queues
mesh_send_sync(). The cleanup on the failure path is guarded by
"sending", but that flag is set from HCI_MESH_SENDING before the queueing
and err is only ever set when it is clear: when sending is set no queueing
happens and no error is recorded. The guard is therefore never true on the
error path, so a failure of hci_cmd_sync_queue() leaves the mesh_tx on the
list with its socket reference held and no worker to consume it.

Drop the stale guard and always release the mesh_tx when the request
cannot be queued.

Fixes: b338d91703fa ("Bluetooth: Implement support for Mesh")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 net/bluetooth/mgmt.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 282ce65f19eb..067d4f5d961e 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2544,10 +2544,8 @@ static int mesh_send(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_MESH_SEND,
 				      MGMT_STATUS_FAILED);
 
-		if (mesh_tx) {
-			if (sending)
-				mgmt_mesh_remove(mesh_tx);
-		}
+		if (mesh_tx)
+			mgmt_mesh_remove(mesh_tx);
 	} else {
 		hci_dev_set_flag(hdev, HCI_MESH_SENDING);
 
-- 
2.34.1

