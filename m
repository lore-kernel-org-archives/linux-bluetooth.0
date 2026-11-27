Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795769659;
	b=PR1mnPXzCjpa807YrcZ24I/Q802AzvtXChjAfI7u0yziY6cVY9MKszN3qO2L189lGSI8
	 H2ZmcKVAL5DzEMckFmX2AFxpSBF/CYmuhIoy/HwNTm9lYqIhuaSkDrkWNaN3sifS3SIne
	 mHMUly6kae8Cf4Y1Rk/FNaVqOXUb0PahYxiHamfy+YvBVfkygFnLurkvLtRyaaL4uf2Pk
	 DSNfMtHd8kJ8sHW/DFbzmgJ+SNtIliZqekcnwA8CCyndKjmPbKl/HwVUibtdwuCMVv68R
	 EqXORZTJEmUxRnvAdUoFh2v8bFChXIfZGec9naGbPr6/syCCcGcx8k2mLqad9fQ429Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795769659;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=SBdlVp6yrAAXIVKvOv5jmkIQ0ZdG1zCMdwQVVHV861A=;
	b=dKVEzo5F1IVIJ0V1S7NifYviRDFHTZ+0730e6BCDdqw+wrA2lr/pWbYQa6Y/V5Q6hKO6
	 xYrJInk3c9ifAhgDm8+48djRl1v1oqRloEzTwlfNWRv3W1lYfW3S+ZXIK3hq67qfIkFKf
	 0HnmuapgEdOA7YkAQiRJv4epkcnKDuNZWCz2dKUEwbTNTU25QR+d23sCu4rvgWEMq96rv
	 w2CAWKkbNy0CzSVooNUEHl/F8PcQNabty4/JIX8XCw9JkQMzvNrKF9iUl0v/Cm12f0xzp
	 y5f/c/ZbYdQLyMFt3JkxsjLBJm5IiQ3DxjxuHfyRufbEN/M/AmsEUMHK4zA1y6wkVlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="mq769/OU";
	arc=none smtp.remote-ip=209.85.218.47
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A863606A327
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 08:54:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A863606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mq769/OU
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c5187b42a2dso62331166b.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 00:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795769658; x=1796374458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SBdlVp6yrAAXIVKvOv5jmkIQ0ZdG1zCMdwQVVHV861A=;
        b=mq769/OUqolspBhJ0dmHxhJWQq5vtMCDBYLHxBCLki44+rB+VM/I26GEPBqdd9/IH5
         kgddkhuH++u084sU0vCFBJyGHuQZh80dCPevL5ApyFrsA+Wy2yhc8caam18MgdX4Mfja
         Zt+ypan6DFU/jdR2xHDx5rJkfcczGv0VNfJL2ii7hQV47sV+OryiOrvgwa9S38Zpmonh
         Fsi+g1Qklqw4oKM+7MZT3+Tecy2K6HwccdpsWfzlYmgJlcnAy0eCa8bQbHgR283pS0R0
         kQh/hlQXvI0YTn/pkoua+GQCWxXV8YmHbW/g37X3pJft5bJlhpnNLc90GRHyWqfcB7iD
         KtUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795769658; x=1796374458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SBdlVp6yrAAXIVKvOv5jmkIQ0ZdG1zCMdwQVVHV861A=;
        b=YYoMcmUc2Fm6buInRfvhUbW0fxFryz70DkRm1KVs+CjCakdlLu775bu1Gi8YxL5vIQ
         VwjiQbl1qu1Q/t17gWIGvXKeCQjTrLBjppewro66CAxyNzhaJOsH8hipIHSH2rtbjeKT
         FGl0yY09o/EU5IKwnXREomAzTP/Co2a//EbjnEebQpkhKZ2fy05wg8gmqoubolwpNHF3
         mWYPkSVcb75eX2kbl+otX+pyTm1weOe90eLIxYXiG8osJeLsyn5R4DiFRKHOxHMJ2EjY
         HA/QDKplI5zTsupkuZqff7gWtg8STz4pSSzYZObRuKMkH3wRC5lWYegjaXtO7COiiW/6
         3Z6Q==
X-Gm-Message-State: APuU4Z/kx8WiCQpll6T+RWYMUJmbR6Gb7Fu3nF3Ajq6qu+eg38NKbw86
	xIry25PRSIBjwZ+DJmGg4Fj4JwKrkXC36MVBdE9UFqHxXBW4fYqbYdFBKla9Nx0h
X-Gm-Gg: AZFdTZfGauURj5TOx4TCQ7tCCY5r1CtfMT6iJQcQf5eadyVoVT4cPG2qcWY9iphcEW8
	yegfKssa6zT8GShoQVZUKgZDLalFWUOISkt9bs1rwfLpKrtQQ/grm+l70GFSXq5xtHwrRmhjbmR
	TXuncJa/5/BQiDYnh1I3XDAljPQF3cqdh8u6uBczm19MfQPxbAp8V1NjWlYg/E2V/Dc0qJOABHT
	LHMcMdV91WIITJzDftVoh5ZLwdogAdMA0WmVKf2bdt09NK+6shHdLu4eLpGMgBjnAoZcMVTsMFx
	/QjgrPPCFVh99I8uqkBFSQ1z/XK+w6aVE0yMsN9Woyf36K4d9RszRsgwd2bKV+UIPApoc3khqn6
	NT17PBWsmfYAGn/z3U/XSszDlupuJ/U5B2xYb4b0NrWZtkOYxzgeS/56IbXfqtWcDrMbA3X1Zh5
	IKt74m85GBZ+q0lfhUXoxsPn7Y/7/7PUB/VVx0m32DQeB6BVzqx0pTIrv696zjXD8W3ob8nOnKO
	OGVfLAseAXFXhE24N57sDCe8IcX4z05lAMI4pLMcpf6mRxVvhrEnuwflSXuBa0OWOC3ef2l9tQb
	s3owBqMeJUMo15girWHAAKa3SW0EJyYyMb8=
X-Received: by 2002:a17:906:3e41:b0:c46:ae89:cd3c with SMTP id a640c23a62f3a-c513a3971a7mr1713568766b.1.1795769657588;
        Fri, 27 Nov 2026 00:54:17 -0800 (PST)
Received: from schinder.corp.hoffmann-group.com ([2003:8:2:4::5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513aea28f4sm870688166b.33.2026.11.27.00.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 00:54:17 -0800 (PST)
From: Roland Schober <rolandschober1968@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	marcel@holtmann.org,
	Roland Schober <rolandschober1968@gmail.com>
Subject: [RFC PATCH 2/5] Bluetooth: hci_sync: Disable periodic advertising before removing a set
Date: Fri, 27 Nov 2026 09:53:57 +0100
Message-ID: <20261127085401.263615-3-rolandschober1968@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261127085401.263615-1-rolandschober1968@gmail.com>
References: <20261127085401.263615-1-rolandschober1968@gmail.com>
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

The controller answers LE Remove Advertising Set and LE Clear Advertising
Sets with Command Disallowed while periodic advertising is enabled on
a set. Only a BIG enables periodic advertising so far, and its removal
disables it first on its own.

Disable it in the removal itself, so that an instance which is made
periodic over MGMT can be removed with Remove Advertising.

Assisted-by: Claude:claude-fable-5-2
Signed-off-by: Roland Schober <rolandschober1968@gmail.com>
---
 net/bluetooth/hci_sync.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index ee426ffeaa03..a1c723aad55e 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -2263,6 +2263,13 @@ int hci_remove_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance,
 	if (err)
 		return err;
 
+	/* The controller refuses to remove an advertising set which has
+	 * periodic advertising enabled.
+	 */
+	err = hci_disable_per_advertising_sync(hdev, instance);
+	if (err)
+		return err;
+
 	if (instance) {
 		hci_dev_lock(hdev);
 
@@ -2392,6 +2399,32 @@ int hci_schedule_adv_instance_sync(struct hci_dev *hdev, u8 instance,
 	return hci_start_adv_sync(hdev, instance);
 }
 
+/* The controller refuses to clear the advertising sets while one of them has
+ * periodic advertising enabled.
+ */
+static int hci_disable_per_advertising_all_sync(struct hci_dev *hdev)
+{
+	u8 instances[HCI_MAX_ADV_INSTANCES];
+	struct adv_info *adv;
+	u8 i, n = 0;
+	int err;
+
+	hci_dev_lock(hdev);
+	list_for_each_entry(adv, &hdev->adv_instances, list) {
+		if (adv->periodic_enabled && n < ARRAY_SIZE(instances))
+			instances[n++] = adv->instance;
+	}
+	hci_dev_unlock(hdev);
+
+	for (i = 0; i < n; i++) {
+		err = hci_disable_per_advertising_sync(hdev, instances[i]);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 static int hci_clear_adv_sets_sync(struct hci_dev *hdev, struct sock *sk)
 {
 	int err;
@@ -2404,6 +2437,10 @@ static int hci_clear_adv_sets_sync(struct hci_dev *hdev, struct sock *sk)
 	if (err)
 		return err;
 
+	err = hci_disable_per_advertising_all_sync(hdev);
+	if (err)
+		return err;
+
 	return __hci_cmd_sync_status_sk(hdev, HCI_OP_LE_CLEAR_ADV_SETS,
 					0, NULL, 0, HCI_CMD_TIMEOUT, sk);
 }
-- 
2.47.3

