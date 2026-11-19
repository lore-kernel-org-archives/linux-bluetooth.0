Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795087466;
	b=Jr/39NOwuo708jqMqCCALgtNkhD2argdf865teKnxbuS2Ba+AOQa5zA7+JT3bePieKud
	 9k1EbekAiDeXGMBe51CrwKJPQMr7YxH2ckRkySfXmMyhlOhQ64RcnJ/62xRZdEF9rJJxD
	 oLUxVTH3sw6BXIZMWQmx624Aob5IJrciSy2ot54KPAi0ho+eICQoXVm1eCW1Kh1VzzlDQ
	 seRW7wQmgRAwVCd4FTBLg081HiISlQ0yavzLtUznDHAGGJBS5TCGT+rcY0wPlOsL9nWwh
	 agXwDTq8JaLQuGz/6DNlcALE5eceGCkh/fTXjXaCtvFF6ARnn0gz82u767F/E+SmtEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795087466;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=/1a2zhpdMOBK0mOqw/Tno4RXP4oEFs74drCisxFYseU=;
	b=ModzV+Juclj47MqZpMBPYVLF5FaFTHkk7e0clnVX7I6HdAxcP4ux8k1yODkP359PlIyH
	 o9D0gvRnvy77rkSdxiDap+BVyY1M5dMN1TzMNszEEMZVj+D+67PN0wIzFTUkj7dcHMVZw
	 SFFvpPJ9WWBbzR0O9hNWAti/kYET6/RceOBECCCnTs8vJh26UyMo6ShLsoT+NPt+ol57r
	 cRlyV6aBtql4t2Uyt8s18i/hglQuT7uGyK7ijyo/8yPCVOzLQ922Gb3tiKx5ltxhoy325
	 dWiN+BFPYgBxx79lVfnH1IUkqKVWxRlVG8zyyhSJFf5qZTdfzFbMPYrrGrPd6LsYZEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ISpxDJ5D;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDC9606A32F
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 11:24:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5FDC9606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ISpxDJ5D
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2f02f04a426so3455905ad.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 03:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795087466; x=1795692266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/1a2zhpdMOBK0mOqw/Tno4RXP4oEFs74drCisxFYseU=;
        b=ISpxDJ5DVGF8N/aDoxpxQdXM4+cJL6qMmIH5RKsZQMoGzMcIXLk4VJfefJXnTwINzV
         4Ku7wouKuWuV0Dzw8z1IBDzEC2rtaKEJtKIj/Px36IRP/VBEOsFy7B0la+qImczYSi2u
         T/rq4CNWanmRV600ZLKCDKttYVJdniPRZ4bc2ZaJx6kfkNn7YaAYUUh3RM0sRNMapcr0
         SugVjQMLwU/9Faln1uxt/pC72FprBdrkp1SXmTJrJcdo45jpoy+FfWJVf68cwBspkjWQ
         NQgHgLIJ+USu0JknlFUXV2LIqLOWAwma8/dQm6dy9mrlGYI9qHEUABczO4OoMpuUYcgy
         PxOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795087466; x=1795692266;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/1a2zhpdMOBK0mOqw/Tno4RXP4oEFs74drCisxFYseU=;
        b=a8eb2eWinyCniYh/0qfB1EtoIBHzkmlSDxLnV7rlp7jsNwlDtRv5EhcUraUpvs6UZk
         CQYPVX7r6IaGTQFGLimX1Q6PmRtFdzixTrrZ9qfH2Oz6WZS7Y+PYRE9Z00a/WUlgJOsr
         KMAMb4fpkbVG62KIg7qKzKvqZwj3xWyW/DTCULqe3GedTEFlPz5X5lO4qLbe0n38yOfh
         Z+pot4XVGmfmD74U/hCZcbD0wzzMwoyYp/noDmw8jyV/waHCIG4lcdoJ0oC7+66YwBhr
         BqPB4OTuH57U9FHSMISMtBRasYv9X5/xOiqmyaFNeUmsmrNv/tkHvGZ59TORcV4smdeB
         Z6rw==
X-Gm-Message-State: APuU4Z/CW5gqB8LZhM8cj7pPg1mX8VZ9+NhR2E3OxhgXdVJ6medvMtRd
	xTkoU5gZdMtEGEWz+nELEQHuRWGx24FoOTKJeG6fG+R7GaFx2mR4tBWq
X-Gm-Gg: AZFdTZeupZW9DBnBDfTRbpZVmyHr2vWStbXw7O9jsIYq4FAumYwgeg2YDvBMWbOjrHx
	DaT2rz/Ou5BdDTJBT06ogR4nceKqBB2vePVsJxJnN00sd2xbWgEXejAeclugWMPal36mUw+b5/n
	zc54xPUQcFTG5SIjVxtSIism3oEH0mT6vZFHG1Wl6yYUOYkUvMBZDeN4UgTvEdortlwD6mfktVy
	xJu1a5QRcYMiO0d4wJwEyYvhDOIBSIR47wsywtrqjVxCAzmIw5qp7KK0mMc7hCJnczTLTCz79NY
	rJ/pJjqrSGL2Y/+shoydfxq4uZhCpPgC/xpi7M+1RugTSKMeqbpBkmTXNdQfqqcREvbapp11wGo
	pgDAU972ZeuEEvQyXN79VdAI4oXjK4rZJvGxK715kdl7bLzJbvPtZVkPSiLL9qykCIQHcu0XKFf
	kAkqiw+DPOvNwS/SRnb0/9kcM7uPHtXQuU8af+NZ4X6NcA9t+8/biqfqAeDpTZi/ruGklfNWNZb
	hrRnmzaCFDY2I5614ypdcJwzbHrzB8BoQnZ44s2z2fc4p02yYb95wH4dPWtiIJ5P2GJs5bKw9kg
	5tpuucdTKa5jHvdvErtiu79ZqshOrynEbEcedIcrVleBjwCIiZP1dqjYiALI64nZo31CWgOq1R0
	t
X-Received: by 2002:a17:902:d2c7:b0:2ed:2305:5244 with SMTP id d9443c01a7336-2eff752ec1dmr60082795ad.46.1795087465193;
        Thu, 19 Nov 2026 03:24:25 -0800 (PST)
Received: from G7XWH7K1F3 ([2408:8256:2e80:7371:84c0:a687:3d35:47b0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eff62876a6sm28540805ad.63.2026.11.19.03.24.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Nov 2026 03:24:24 -0800 (PST)
From: Zhao Li <enderaoelyther@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhao Li <enderaoelyther@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: MGMT: Retain the selected legacy advertising schedule ID
Date: Thu, 19 Nov 2026 19:23:59 +0800
Message-ID: <20261119112359.34543-1-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.56.1
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

Updating the currently advertised legacy instance can schedule that same
instance again instead of the next selected instance. Add Advertising
stores the selected ID in the original request after mgmt_pending_new() has
copied it, so the queued callback still reads the requested ID. Add
Extended Advertising Data never passes the selected ID to its callback.

Pass the selected ID to both callbacks in the pending command's user
data, and keep the request ID for the replies and completion cleanup.
Extended advertising controllers do not rotate instances in software, so
keep scheduling the requested instance there, as both callbacks do now,
without cancelling the rotation timeout or looking up the next one.

Found by code review.

Fixes: cba6b758711c ("Bluetooth: hci_sync: Make use of hci_cmd_sync_queue set 2")
Cc: stable@vger.kernel.org # needs adjustments for <= 6.5
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
---
Tested in QEMU on bluetooth-next f42f5cae154b with vhci controllers and
four new mgmt-tester cases. On an LE-only controller with instances 1
and 2, updating the advertised instance 1 through Add Advertising or
Add Extended Advertising Data now makes the next LE Set Advertising Data
carry instance 2's data; without this patch it carries instance 1's new
data again. On an extended advertising controller, updating the current
instance 2 sends LE Set Extended Advertising Data for handle 2 with the
new data, with and without this patch. The rest of the mgmt-tester suite
shows no difference beyond one LL Privacy case that times out
intermittently on both kernels.

No new W=1, sparse or smatch warnings.

AI assistance was used.

 net/bluetooth/mgmt.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 6ed3bf6f1738..075252d72cbb 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -9099,9 +9099,9 @@ static void add_advertising_complete(struct hci_dev *hdev, void *data, int err)
 static int add_advertising_sync(struct hci_dev *hdev, void *data)
 {
 	struct mgmt_pending_cmd *cmd = data;
-	struct mgmt_cp_add_advertising *cp = cmd->param;
+	u8 instance = PTR_UINT(cmd->user_data);
 
-	return hci_schedule_adv_instance_sync(hdev, cp->instance, true);
+	return hci_schedule_adv_instance_sync(hdev, instance, true);
 }
 
 static int add_advertising(struct sock *sk, struct hci_dev *hdev,
@@ -9185,7 +9185,9 @@ static int add_advertising(struct sock *sk, struct hci_dev *hdev,
 	if (hdev->adv_instance_cnt > prev_instance_cnt)
 		mgmt_advertising_added(sk, hdev, cp->instance);
 
-	if (hdev->cur_adv_instance == cp->instance) {
+	if (ext_adv_capable(hdev)) {
+		schedule_instance = cp->instance;
+	} else if (hdev->cur_adv_instance == cp->instance) {
 		/* If the currently advertised instance is being changed then
 		 * cancel the current advertising and schedule the next
 		 * instance. If there is only one instance then the overridden
@@ -9232,7 +9234,7 @@ static int add_advertising(struct sock *sk, struct hci_dev *hdev,
 		goto unlock;
 	}
 
-	cp->instance = schedule_instance;
+	cmd->user_data = UINT_PTR(schedule_instance);
 
 	err = hci_cmd_sync_queue(hdev, add_advertising_sync, cmd,
 				 add_advertising_complete);
@@ -9461,6 +9463,7 @@ static int add_ext_adv_data_sync(struct hci_dev *hdev, void *data)
 {
 	struct mgmt_pending_cmd *cmd = data;
 	struct mgmt_cp_add_ext_adv_data *cp = cmd->param;
+	u8 instance = PTR_UINT(cmd->user_data);
 	int err;
 
 	if (ext_adv_capable(hdev)) {
@@ -9475,7 +9478,7 @@ static int add_ext_adv_data_sync(struct hci_dev *hdev, void *data)
 		return hci_enable_ext_advertising_sync(hdev, cp->instance);
 	}
 
-	return hci_schedule_adv_instance_sync(hdev, cp->instance, true);
+	return hci_schedule_adv_instance_sync(hdev, instance, true);
 }
 
 static int add_ext_adv_data(struct sock *sk, struct hci_dev *hdev, void *data,
@@ -9537,7 +9540,9 @@ static int add_ext_adv_data(struct sock *sk, struct hci_dev *hdev, void *data,
 				  cp->data + cp->adv_data_len);
 
 	/* If using software rotation, determine next instance to use */
-	if (hdev->cur_adv_instance == cp->instance) {
+	if (ext_adv_capable(hdev)) {
+		schedule_instance = cp->instance;
+	} else if (hdev->cur_adv_instance == cp->instance) {
 		/* If the currently advertised instance is being changed
 		 * then cancel the current advertising and schedule the
 		 * next instance. If there is only one instance then the
@@ -9579,6 +9584,8 @@ static int add_ext_adv_data(struct sock *sk, struct hci_dev *hdev, void *data,
 		goto clear_new_instance;
 	}
 
+	cmd->user_data = UINT_PTR(schedule_instance);
+
 	err = hci_cmd_sync_queue(hdev, add_ext_adv_data_sync, cmd,
 				 add_ext_adv_data_complete);
 	if (err < 0) {

base-commit: f42f5cae154b90a0cb6d8232dc84c7614ca2e6a0
-- 
2.56.1

