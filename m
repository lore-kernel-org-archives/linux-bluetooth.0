Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793760810;
	b=0O/k/z1tYYWJFxwGO8fKaW2nlbtjNk0pS726zZbmEjqrjE8LdiuzcqwfQbczF3EpfYQ0
	 8ZRC+idjT5Skl77YNqPYdrDpnzDcfGVTYgTA3oCgUu7GH0NmuBzWsvMAriNdwpKBWVMIm
	 SW3BiyN/qvc237CG3Z97Ky4lnBBXRutwBQLurJYS36dfuHa3TP7sRpRWWCDAeycTtstk4
	 mpqC5pGV5Uj1qVlmZ6TQ/YlNSwJfZzKJHEQ5BsG9ep4I+HUg7yFAQGFO3dbi8WdJetsiS
	 PTuugS2LNDH1r9KWzGAWckGBhk79URPJGrDdt8hO0yI6naa54wN4y9uGEj8A1kA9ZGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793760810;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=gN6ju4CfNYfxfvlLO00Bo4eK2Bc9VTRWjB8sRdxp4rs=;
	b=PJMdexkcBhsJOGsHAEmhjIUZkEeMg2hcfqtUYMS2wTpZZFmx0yHqoFU//007s2UF6GRr
	 9pv0dKXMfKeyL+mLNlLn6pKezDIRVWMyn82mQN2n7GSaKO+h8tXUqVFS/LWVYgK+smOIn
	 954+HMv95nxgZHAFEq3HzboRfMH5HXGx5CAB8rachTyUHjfr8FQrH2awl6EF4lRzZCos1
	 ZKSAtF5vs4lVDjboC5Z7Gcl2PlHV6JIC9k/ikq/hqwTP9uN3WuaxebByQeVpmHwxfFmk7
	 ePaSsmE5JRByhC1tw8mMmGbmrRl8a3lxnWhQVI/L6bdnq8Mb3Mgv4uYkh0VgBTjqMNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.21
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DA7606A31B
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2026 02:53:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0DA7606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-01 (Coremail) with SMTP id qwCowABXf_knnupqrOQ+AA--.27798S2;
	Wed, 04 Nov 2026 10:53:27 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: free the ECDH tfm when a sample fails
Date: Wed,  4 Nov 2026 02:53:36 +0000
Message-Id: <20261104025336.1527270-1-vulab@iscas.ac.cn>
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
X-CM-TRANSID:qwCowABXf_knnupqrOQ+AA--.27798S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tw1ktFWxCFWUCFWrtFy7KFg_yoW8WF1rpr
	4agFna9FWkXr1ak3WUJa109Fn8Ca1DuF17G39Yv3ZxZ34Y9rW0qr4I9FWUJrWDCrZ2qF4a
	ka9Fyry3Gw1DWFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkqb7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
	AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
	6r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14
	v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xf
	McIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv
	6cx26r48ZrWUJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr
	4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxG
	rwCI42IY6xIIjxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr
	1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWxJVW8Jr1lIxAI
	cVC2z280aVCY1x0267AKxVWxJr0_GcJvcSsGvfC2KfnxnUUI43ZEXa7IU5Sg4DUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAABA2rqY+TkJwAAsK

test_ecdh() allocates a KPP transform, then runs three samples. If a
sample fails, the function jumps to the done label, which only fills the
debugfs buffer. The transform is freed only on the success path, so any
sample failure leaks it.

Add a label that frees the transform and use it from the three sample
failure paths.

Fixes: 47eb2ac80918 ("Bluetooth: move ecdh allocation outside of ecdh_helper")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 net/bluetooth/selftest.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/selftest.c b/net/bluetooth/selftest.c
index cdfc40e0016b..b91f7559d8fd 100644
--- a/net/bluetooth/selftest.c
+++ b/net/bluetooth/selftest.c
@@ -214,31 +214,32 @@ static int __init test_ecdh(void)
 			       dhkey_1);
 	if (err) {
 		BT_ERR("ECDH sample 1 failed");
-		goto done;
+		goto free_tfm;
 	}
 
 	err = test_ecdh_sample(tfm, priv_a_2, priv_b_2, pub_a_2, pub_b_2,
 			       dhkey_2);
 	if (err) {
 		BT_ERR("ECDH sample 2 failed");
-		goto done;
+		goto free_tfm;
 	}
 
 	err = test_ecdh_sample(tfm, priv_a_3, priv_a_3, pub_a_3, pub_a_3,
 			       dhkey_3);
 	if (err) {
 		BT_ERR("ECDH sample 3 failed");
-		goto done;
+		goto free_tfm;
 	}
 
-	crypto_free_kpp(tfm);
-
 	rettime = ktime_get();
 	delta = ktime_sub(rettime, calltime);
 	duration = (unsigned long long) ktime_to_ns(delta) >> 10;
 
 	BT_INFO("ECDH test passed in %llu usecs", duration);
 
+free_tfm:
+	crypto_free_kpp(tfm);
+
 done:
 	if (!err)
 		snprintf(test_ecdh_buffer, sizeof(test_ecdh_buffer),
-- 
2.34.1

