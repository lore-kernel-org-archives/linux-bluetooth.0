Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793370481;
	b=A4C94u60bgxZGwdy8VDwKjgi9bjEB/K2ePjw6GXNLFVV7voxqwmwYDUyaoF+Ay/6jUst
	 yX/gOYBGmoicX86AiVDzmHsESHJW91w1h6qazcXQE1GIy7H/1mJ+snvHpDG2WC2k86rgp
	 jxq7bPXq0Kqt7v4hzJIdXzZFiIqyiu4pvRH1dBt3TlkIbfvZHpIRh0Jtfg5+LNqiLFF0W
	 BtCC2keKrM12XAd86BMrdmWqiJNxHplDMpGByvuVhCey6h7gtMthUUIHjAeGQxMIf5XyU
	 ieg8InxH+Yk1ydin2Qrd5UpYkP99BOoGtWBZUK8JyW46yGmuZpKKBGEyLBhNppSqr7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793370481;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=amZBeu5tNKFqzUIhyyU/HFiGAGII22ZvjKQ3NAMEYW8=;
	b=mbC4dkCvjMtf/ymZ/DZqZ7LD2KHnuz+B8C8TPdxkckb/AGVcsIYXAqRwYIIZiWE762vk
	 EoB4ugiXxAu2eAVi5Oa/J6dic5JepRXQwENUMSnr3KqR9tgoChf0rcbqW77Dgk7ibldbi
	 gHUM7ytucGzhQ+3SHfSOPALmw03UJZq0PHiNUnHXbqnWtKuOnthMe0qdH92jCV7pYCO9t
	 yqPk1vckgnk4lnlIp5RuwXFQMBQXJJfcDB3mpqOlNc33kpPr3cZjzSzqfAwpmvVd5HXTx
	 Z3YwLpt6eN6f7uCcaeVswX1zdfxt4NR04PWqfUzdAzolAo0QkH+zsvYvrXjXFAHatjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p0yAIK+g;
	arc=none smtp.remote-ip=209.85.210.175
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5043C606A329
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2026 14:28:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5043C606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p0yAIK+g
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8a06ca6e8f4so500158b3a.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2026 07:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793370481; x=1793975281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=amZBeu5tNKFqzUIhyyU/HFiGAGII22ZvjKQ3NAMEYW8=;
        b=p0yAIK+gUJ2Zb+79DsbSiNrATj19f2/6+Zp0BnWDa/7DELemL2Y5EhzMmtVT7oQDFY
         LgBch5HIvWwnsmkYqSAMkLEsDlgYsxacAbRADoXVc6awQ6HnjZlB6FxWWjPpn9n5Zt+O
         XhkKIiQzXA4g2XuelD9kwIL1dd6Bh4gNPRyMoFnw2AVxY4q0CjYse3ylZsqYURHZYw5h
         lq+VhTWC4ffKAt8A0WZ7TtwE5EqQGBc87G9j3rvOR1vtlV6RGgpSU1pKCWn5gcPeJpFZ
         34b4blqPRqMr5pNvh1gvjP1dL0chGsr56F4cxV6143wN14QV0bAimTxJNHTzbjRJKEZe
         2y4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793370481; x=1793975281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=amZBeu5tNKFqzUIhyyU/HFiGAGII22ZvjKQ3NAMEYW8=;
        b=WvD5eK4KWPfWQtZRTuXTmQNv/o6ltN509hHDrg3xYLwTSXQisiZ2IA+mEu1Ar8eC5t
         BKRPiQXg8fPHgXoveacCPMXRQ1pf0FZcVNs50SPAOufqWa7ce61mJai+nxOypms2ejQb
         nQKPvUS60sMQ68yLP1UZBKL/GoZqV4TxVMs8OOsPWYpKFQR+Kvki17EPD3mh3zmkKwAm
         mYl3zQdGl0qxuQbivPcX0GPucLQuMkQNdY2UG5Z7PULz5twWY3r8llHpjRVqiHmam3Ps
         oW1Jls4rz2SYBg59PHoKlYcqx+YLFe3lOChcLJkiwh67XpsNGPihWgpeSwwyf5d+xq/t
         ow5Q==
X-Gm-Message-State: AFq9FYKH4/6w5gHNVp/9SRyH1vL4ov+lhvcVxw6d5x4F9OKoRmiCqrk1
	yNgvGd+la+jcxQbM7NV3CnlT35MqHeu0BLBkkLhnTCAVmBO3fxNiqq6u
X-Gm-Gg: AYBFou2XxEj8vUFKIoonwmfuSNYaskHwPdXkLzAhyx46RyfQloMkEdDp78QsPBIxaen
	SmhqSkmf4upx7cR2r2OFPKmadm8/zywbXl1DYeWK8rfsku+yYY9oAVuM2gH52IqaDcBZN+TfxQE
	cN6kz7aUa9iFQqEeE/4DUTgjxYGkqWQVfC/QNZq3zLvhbj/9NDsaeSsIluF+Vw+FHUVGhy5NkJs
	ix9420jaUCFPdC+JWTaTbvGkwUl6ZN/fH8Nkp2m4lG57oBnX0w3+CTXVy0RWOtmUjrBqD+ggu2R
	KD4icxMXs2aUYh5K2bhMPwkG3sSg9WqothL1Bf/Itn5NKm+bFijSCK2euNiQAQ5xcQbs+K4bILV
	AMPhIFcs8fhPjhd40gzFS4CrtFgQJndRr2cb+CE/ggfR9COsClEx8nPOYBFJahaIDf1BFkWmIQN
	Qn0g/6vf74XQnBSs+YvUVJKvnIgo6RGbfIYH2DYjcEFisoHksAxCL2rsoVzKpQd1DASuXKBvsUr
	/xNs5MsG1NuEQK+Fo5FhYEBNBUJx3CWVmXEyMZo1+VmXvXIVzk0IlYo6qJGoJi4hbv0c4Sl/hrs
	8ATFSf4b41VwQ9LzzdSyYvdA
X-Received: by 2002:a05:6a00:e85:b0:890:a995:1f56 with SMTP id d2e1a72fcca58-8a9bb7a254bmr2292332b3a.17.1793370480732;
        Fri, 30 Oct 2026 07:28:00 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aad43ab44asm74093b3a.0.2026.10.30.07.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 07:28:00 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH 2/2] Bluetooth: hci_core: Initialize advertising RPA work only once
Date: Fri, 30 Oct 2026 22:27:45 +0800
Message-Id: <pm-bluetooth-objects-candidate-0245-v9-6b34bc036455ad3dd4ea-2@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <pm-bluetooth-objects-candidate-0245-v9-6b34bc036455ad3dd4ea-0@gmail.com>
References: <pm-bluetooth-objects-candidate-0245-v9-6b34bc036455ad3dd4ea-0@gmail.com>
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

hci_add_adv_instance() also updates existing instances and calls
INIT_DELAYED_WORK() on their rpa_expired_cb every time, even when the
work is pending or running. cancel_delayed_work_sync() then no longer
finds the work, so hci_remove_adv_instance() can free the instance
under it:

  hdev->workqueue                 MGMT_OP_ADD_EXT_ADV_PARAMS
  adv_instance_rpa_expired()
                                  hci_dev_lock(hdev)
                                  hci_add_adv_instance()
                                    INIT_DELAYED_WORK()
                                  mgmt_pending_new() fails
                                  hci_remove_adv_instance()
                                    cancel_delayed_work_sync()
                                      returns without waiting
                                    kfree(adv)
                                  hci_dev_unlock(hdev)
    adv->rpa_expired = true

The work has been initialized on every update since it was added.
Initialize it only when the instance is allocated.

KASAN report as below:

    BUG: KASAN: slab-use-after-free in adv_instance_rpa_expired+0x139/0x160
    Write of size 1 at addr ffff888108d84b2e by task kworker/u17:0/504

    Workqueue: hci0 adv_instance_rpa_expired
    Call Trace:
     adv_instance_rpa_expired+0x139/0x160

    Allocated by task 560:
     hci_add_adv_instance+0x68d/0x9d0
     add_ext_adv_params+0x4d4/0xb60
     hci_sock_sendmsg+0x128b/0x22e0

    Freed by task 594:
     kfree+0x307/0x580
     hci_remove_adv_instance+0x230/0x540
     add_ext_adv_params+0xa43/0xb60
     hci_sock_sendmsg+0x128b/0x22e0

    Last potentially related work creation:
     insert_work+0x37/0x210
     __queue_work+0xaba/0x1270
     call_timer_fn+0x171/0x500

    The buggy address belongs to the object at ffff888108d84800
     which belongs to the cache kmalloc-1k of size 1024
    The buggy address is located 814 bytes inside of
     freed 1024-byte region [ffff888108d84800, ffff888108d84c00)

Fixes: a73c046a2869 ("Bluetooth: Implement Set ADV set random address")
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
Assisted-by: LLM

 net/bluetooth/hci_core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 2a29cfdee9728..79573193471bc 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1796,6 +1796,9 @@ struct adv_info *hci_add_adv_instance(struct hci_dev *hdev, u8 instance,
 		if (!adv)
 			return ERR_PTR(-ENOMEM);
 
+		INIT_DELAYED_WORK(&adv->rpa_expired_cb,
+				  adv_instance_rpa_expired);
+
 		adv->pending = true;
 		adv->instance = instance;
 
@@ -1832,8 +1835,6 @@ struct adv_info *hci_add_adv_instance(struct hci_dev *hdev, u8 instance,
 	else
 		adv->duration = duration;
 
-	INIT_DELAYED_WORK(&adv->rpa_expired_cb, adv_instance_rpa_expired);
-
 	BT_DBG("%s for %dMR", hdev->name, instance);
 
 	return adv;
