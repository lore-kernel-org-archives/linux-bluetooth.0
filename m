Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793759282;
	b=Z+yEGsueTg2kVlTzuzMBUsAl3+MJcAQpKQPlxiBd01Ju5GMxSzaPIGrHXyl0kwu7Verx
	 mm5ANaNZuvVVTR6/6qgAe9j+2lgOTilZTbQCyxOHxEaI2XhLHRw1xzRKyfVAuSJhkXm6B
	 0Urbi+Al1knQClA4VCMlM565iVCOZEkcYFOylUr5HZFNfQW4C35Ye651h6EGqA2vGVxom
	 5lbMLlBA/Jng7NUNAcpH51szxY8k1dDzE0RcKUOyy43lo0P1LG2V5CFIxsNwslBINaxjN
	 +RH4d1YfIN7/R7ysgwwpamsfW4+yAPzFnmMrol5HphYNHnaoieYSkx/6ObhKCCflmDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793759282;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=bH/i0jKkHafjhB3mU9cgCTehdVGRGWkl7cSqAhuiFrA=;
	b=WbBRzYIpPSRnFYGESh8aIwSEHUdAQksw8adnHctkL94d74+2adxRWGr2C2V9TtvqVnB9
	 Wh+yMA0e4Tw5a8uJtP+8nMb7iLDqMfZJ3PuQahp25KMaxBzBSplc/AwdICpguj89nWtTh
	 d2kl5z80Y8TN4CYhvd9Ljw9ldrhs/VxFSzEO4uClRXvlqbJXVt7LXyukHqXCwxsYfl4co
	 GNKps6kn4CnIF4nhQk71gDmFt44kTcDksFlAoSlefwTtpT/SghPpHdw/VsouFjQYTvECu
	 Vn2yuWLMZMTvudDtTn3hpLNERI61RAjeNhlAgvI6sZxvn2dBM940xxR470am2OVkAYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.21
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30770606A326
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2026 02:28:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30770606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-01 (Coremail) with SMTP id qwCowADH8_0vmOpqkJs+AA--.9695S2;
	Wed, 04 Nov 2026 10:27:59 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: drop the pending command if the adv monitor queue fails
Date: Wed,  4 Nov 2026 02:28:08 +0000
Message-Id: <20261104022808.1484131-1-vulab@iscas.ac.cn>
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
X-CM-TRANSID:qwCowADH8_0vmOpqkJs+AA--.9695S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw1kKryDJF4rur4DZrW5KFg_yoW8Gr1Upr
	Z0qF15AFykJr47JF1fJF48WFWIvFnaqrZrCrZ7Cas5AwnIqrWrX345tF1UZFnxZrWkJF4j
	yF1Dt39rurykA37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRUBA2rqY-nHTAAAsP

__add_adv_patterns_monitor() links the command into hdev->mgmt_pending,
which takes a reference on the socket, and then queues the sync work.
When hci_cmd_sync_queue() fails, for example because the controller is
not running or is being unregistered, the work never runs and the
completion callback that would free the command is never invoked. The
command therefore stays on the pending list and keeps the socket
reference until the controller is unregistered, and it also keeps
MGMT_OP_ADD_ADV_PATTERNS_MONITOR busy for other requests.

Remove the pending command on the queue failure path, matching what the
other management commands do when their queueing fails.

Fixes: b747a83690c8 ("Bluetooth: hci_sync: Refactor add Adv Monitor")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 net/bluetooth/mgmt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 3b9c82bd2f02..282ce65f19eb 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -5542,6 +5542,7 @@ static int __add_adv_patterns_monitor(struct sock *sk, struct hci_dev *hdev,
 		else
 			status = MGMT_STATUS_FAILED;
 
+		mgmt_pending_remove(cmd);
 		goto unlock;
 	}
 
-- 
2.34.1

