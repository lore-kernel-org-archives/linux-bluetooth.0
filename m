Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795048381;
	b=tE3IhGeB6fLZrSs8/qlgij7mPnY+B+fevA7nE6Ikq3LyWYqBZKYvxmfAKyU31LXV63xC
	 dmtj4VFJSfLhTRx3debm2of+c3zG21fx+0dH3BDhAFoOtMwS8auqIthj5cGPt8HgVud27
	 dD+zb3G87/7sJsPmKBjBxHjKPZWxcBW5Hxu6rj/puOO5sZXUZDdz5C9IDtvt0H/i8qeGK
	 poCe3EwswasycOOt5kTJWFx0K7unLU1WD5iS99hBZ+DL4ZA4FovyM6a9niGlqYgKPzIeV
	 BTL0sirxKj/YdswMr5jBObfiVkXLK9BuU0Qu3yo+TChqhT/yRtfO4ujePGkgZf1vpcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795048381;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Oyv+zZaC2K16XZfAzO+oJb53GrDyj6EgYT05QBQnKwU=;
	b=mWKgfUSdWxkrCSDcVImp2Ea+Jo5dfNiD+9KuLHugE//XnFuIfesmF0qrjaTaQuF4mXiP
	 04PjswU/SbTT22Cm9Sbsp1pvYVDdTbSeDH2y0FwSt858K8Nyvi1lsWZ5ASXCgwTki0biv
	 KuegwUXaFdzZuNk6tyFs2kxPNtK82wIrncpTOzdnrTEPsZH265dtaFpGR/9q95AqwHYHk
	 GQAQ+StOC2NFnOAw/aXkZ0goqLlCG6mRJV1ttEVmrUpYzlNkkjh6KTsUGJKLEXS6bkXcd
	 OvmB0WHgm5kyVESaAlp7KcH5F3WF/BLxUL83+sYp0wWCITjgPiudC7syCOfUAJrebeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="jcqfWJC/";
	arc=none smtp.remote-ip=209.85.210.177
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67AC60A260C
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 00:33:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D67AC60A260C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jcqfWJC/
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8b3577deeb0so916608b3a.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 16:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795048380; x=1795653180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Oyv+zZaC2K16XZfAzO+oJb53GrDyj6EgYT05QBQnKwU=;
        b=jcqfWJC/732c6uAJiFk3AJI9b4rTnCa6XuGW7z/SAAsy+ZNnTPC0rvfA023iqc0Dtt
         eUdC2f1uwx1rF47jkcbJyKAA0VzlQzhtj/bl+YB89Z7w9LREbQe6bccT2KhO2cT5UN20
         YdnzdQaX6sryjJ4R2IJzbDNQbBKGShKi1SmSsJv3NvBN3DC9lFkU9++v4F4gPQ2TTMqV
         7FCuK1GoL0K/ntZmjh4AdRxPnR/k2llNqr05s1TnN/nt/Vff5A/OAKqEnWaw/Dx48TTE
         pp2Ny9VKFRV1TSE8fO7JbfFj7C6zv+J537GEq0c8zENLHtTnl8agEZABCHbF3Q2ZgzwM
         7QUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795048380; x=1795653180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Oyv+zZaC2K16XZfAzO+oJb53GrDyj6EgYT05QBQnKwU=;
        b=miKtDYZK9lc0x5JdmVZ8KJ7rf8WyqpkjeF7GXVkMJGuZwwFFYxEO4Ncb4+tZrTwyRV
         F8QJxK1wESv/1vDAmBvd6J/u6Fz2O4LkCrNB4JR+2gf5Nsa1i5yLCM0kJwmGjUocByeq
         pH8Na9a5CYs3dsUAzsBuByEzwJs3wxBzDXISQ5Fs+wsmadsaMALwpde/J+syWUl87ZLC
         UYL3BZWrF+kgsZT8knQr2PKrTmPRoMTW4sIXSVM/ivXC4F/azw9yCfjmyEEuFtEhi/DZ
         3sIrYMCMr20dqzl7rVBueT20TEhVBileL0k98SA3qcvAR0tPDh8XMVGwvSX7Y5VqYhQJ
         dy1Q==
X-Gm-Message-State: APuU4Z+Tiia/RFHy2rM4K4KPkNkCddBygxTLx8VbjVuomrjaYpdMjmzT
	aoZesKW/p0SRiNC38uytcmlT5jLfqJWtpFKbwtbvx0oCPiAWwk1oUMrw
X-Gm-Gg: AYBFou0xxwcXyleJr3qSXLpcvZ2UWqzLrTjbYhDDjLQtYGPrMPqOz9WY5DtmziNS2g4
	UBnEKUNUGvjbdLygMUzN+Bfugm6y/ox2dpK8ebAPGJKIeYJM7aILzu7DpN9pABqH3s+e0ltNX5q
	fuBeRDyCd5mbT59MrcasDPZR7iTb23Ska+RbR+RalZlIYO5TLWPbxgUE/LnX0HMl+X/u+TDCCaY
	vmkCoHcBe+IKa9h3P3UPb7j928LZ2o2HbegLjlsWRKVAq2CX03slai/W5M+YEL7c8PKt7YauSBx
	iTFO6TNjDjQ96m4SOUvf3goWiHL9sp38wY5XUIle6lLcXSU7a8ohTynpmqc9mSCEm4k8FEsbsB0
	O2rH+4YUsHovizqGvVBqoP0EbKd5SQxxLumSU6/2RJ4V1c9BF2TWlDFIlzzmsbko3PaKQkEvEpP
	TddgIvlGpA24RGuy8msiG2rJSD5JRVpK76gYxlrZhqhxWBntNzN5mYC6QLy5hNoXvXC+suY0Zkp
	Nw3430kMl5FVAwWaAUz1VTlL5YW6lyb/qPYmYMTVoF7qI9UtQRRt02Te9E7pL5axE3q1HoBR2se
	Qv9bAFsCfe+YI1rNq57ktNc6
X-Received: by 2002:a05:6a00:2888:b0:89e:7bfa:f884 with SMTP id d2e1a72fcca58-8c5d2a739afmr3595149b3a.18.1795048380112;
        Wed, 18 Nov 2026 16:33:00 -0800 (PST)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c5cba3313dsm1975051b3a.53.2026.11.18.16.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 16:32:59 -0800 (PST)
From: Cen Zhang <zzzccc427@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH v2 2/2] Bluetooth: hci_sync: Use controller handles for periodic advertising
Date: Thu, 19 Nov 2026 08:32:46 +0800
Message-Id: <pm-bluetooth-objects-candidate-0245-v14-e37270232af59a877004-2@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <pm-bluetooth-objects-candidate-0245-v14-e37270232af59a877004-0@gmail.com>
References: <pm-bluetooth-objects-candidate-0245-v14-e37270232af59a877004-0@gmail.com>
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

Management instance numbers and controller advertising handles differ on
controllers with a single set: instance 1 uses handle 0x00. Periodic
advertising data already sends adv->handle, but the parameters and
enable commands send the instance number. The completion handler also
treats the command's handle as an instance number:

  Request worker                    Controller / completion
  create instance 1 on handle 0
  send periodic parameters for 1
                                    Unknown Advertising Identifier

Snapshot the handle under hdev->lock for periodic parameters, enable and
disable. For instance 1 using handle 0, update periodic_enabled under
the mutex after the command succeeds. Its completion handler cannot
distinguish that instance from global advertising by the handle alone;
keep the software instance number in the request, as the existing
remove-set and random-address paths do. Use the same mapping for the
advertising set in periodic transfer and both BIG creation commands,
which obtain the instance number from the same broadcast QoS field as
hci_start_per_adv_sync(). Keep the instance number in software state,
and send no HCI command with the mutex held.

Fixes: eca0ae4aea66 ("Bluetooth: Add initial implementation of BIS connections")
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---

 net/bluetooth/hci_sync.c | 72 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 63 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 4475d674375fd..42a577f201a19 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1817,11 +1817,15 @@ int hci_disable_per_advertising_sync(struct hci_dev *hdev, u8 instance)
 	struct hci_cp_le_set_per_adv_enable cp;
 	struct adv_info *adv;
 	bool enabled;
+	u8 handle = instance;
+	int err;
 
 	/* If periodic advertising already disabled there is nothing to do. */
 	hci_dev_lock(hdev);
 	adv = hci_find_adv_instance(hdev, instance);
 	enabled = adv && adv->periodic_enabled;
+	if (adv)
+		handle = adv->handle;
 	hci_dev_unlock(hdev);
 	if (!enabled)
 		return 0;
@@ -1829,10 +1833,39 @@ int hci_disable_per_advertising_sync(struct hci_dev *hdev, u8 instance)
 	memset(&cp, 0, sizeof(cp));
 
 	cp.enable = 0x00;
-	cp.handle = instance;
+	cp.handle = handle;
 
-	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_PER_ADV_ENABLE,
-				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
+	err = __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_PER_ADV_ENABLE,
+				    sizeof(cp), &cp, HCI_CMD_TIMEOUT);
+	if (err || handle == instance)
+		return err;
+
+	/* Handle 0 is shared with global advertising, so the completion
+	 * cannot identify the software instance from the command alone.
+	 */
+	hci_dev_lock(hdev);
+	adv = hci_find_adv_instance(hdev, instance);
+	if (adv)
+		adv->periodic_enabled = false;
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+/* Map a management instance number to its controller handle. */
+static u8 hci_adv_instance_handle(struct hci_dev *hdev, u8 instance)
+	__must_not_hold(&hdev->lock)
+{
+	struct adv_info *adv;
+	u8 handle = instance;
+
+	hci_dev_lock(hdev);
+	adv = hci_find_adv_instance(hdev, instance);
+	if (adv)
+		handle = adv->handle;
+	hci_dev_unlock(hdev);
+
+	return handle;
 }
 
 static int hci_set_per_adv_params_sync(struct hci_dev *hdev, u8 instance,
@@ -1848,7 +1881,7 @@ static int hci_set_per_adv_params_sync(struct hci_dev *hdev, u8 instance,
 	if (!max_interval)
 		max_interval = DISCOV_LE_PER_ADV_INT_MAX;
 
-	cp.handle = instance;
+	cp.handle = hci_adv_instance_handle(hdev, instance);
 	cp.min_interval = cpu_to_le16(min_interval);
 	cp.max_interval = cpu_to_le16(max_interval);
 	cp.periodic_properties = 0x0000;
@@ -1894,11 +1927,15 @@ static int hci_enable_per_advertising_sync(struct hci_dev *hdev, u8 instance)
 	struct hci_cp_le_set_per_adv_enable cp;
 	struct adv_info *adv;
 	bool enabled;
+	u8 handle = instance;
+	int err;
 
 	/* If periodic advertising already enabled there is nothing to do. */
 	hci_dev_lock(hdev);
 	adv = hci_find_adv_instance(hdev, instance);
 	enabled = adv && adv->periodic_enabled;
+	if (adv)
+		handle = adv->handle;
 	hci_dev_unlock(hdev);
 	if (enabled)
 		return 0;
@@ -1906,10 +1943,23 @@ static int hci_enable_per_advertising_sync(struct hci_dev *hdev, u8 instance)
 	memset(&cp, 0, sizeof(cp));
 
 	cp.enable = 0x01;
-	cp.handle = instance;
+	cp.handle = handle;
 
-	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_PER_ADV_ENABLE,
-				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
+	err = __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_PER_ADV_ENABLE,
+				    sizeof(cp), &cp, HCI_CMD_TIMEOUT);
+	if (err || handle == instance)
+		return err;
+
+	/* Handle 0 is shared with global advertising, so the completion
+	 * cannot identify the software instance from the command alone.
+	 */
+	hci_dev_lock(hdev);
+	adv = hci_find_adv_instance(hdev, instance);
+	if (adv)
+		adv->periodic_enabled = true;
+	hci_dev_unlock(hdev);
+
+	return 0;
 }
 
 /* Checks if periodic advertising data contains a Basic Announcement and if it
@@ -8458,6 +8508,7 @@ static int hci_le_past_set_info_sync(struct hci_dev *hdev, void *data)
 {
 	struct past_data *past = data;
 	struct hci_cp_le_past_set_info cp;
+	struct adv_info *adv;
 
 	hci_dev_lock(hdev);
 
@@ -8470,6 +8521,9 @@ static int hci_le_past_set_info_sync(struct hci_dev *hdev, void *data)
 	memset(&cp, 0, sizeof(cp));
 	cp.handle = cpu_to_le16(past->le->handle);
 	cp.adv_handle = past->conn->iso_qos.bcast.bis;
+	adv = hci_find_adv_instance(hdev, cp.adv_handle);
+	if (adv)
+		cp.adv_handle = adv->handle;
 
 	hci_dev_unlock(hdev);
 
@@ -8858,7 +8912,7 @@ static int hci_le_create_big_v2_sync(struct hci_conn *conn,
 
 	memset(&cp, 0, sizeof(cp));
 	cp.handle = qos->bcast.big;
-	cp.adv_handle = qos->bcast.bis;
+	cp.adv_handle = hci_adv_instance_handle(hdev, qos->bcast.bis);
 	cp.num_bis  = num_bis;
 	hci_cpu_to_le24(qos->bcast.out.interval, cp.bis.sdu_interval);
 	cp.bis.sdu = cpu_to_le16(qos->bcast.out.sdu);
@@ -8894,7 +8948,7 @@ int hci_le_create_big_sync(struct hci_conn *conn, struct bt_iso_qos_ext *qos,
 
 	memset(&cp, 0, sizeof(cp));
 	cp.handle = qos->bcast.big;
-	cp.adv_handle = qos->bcast.bis;
+	cp.adv_handle = hci_adv_instance_handle(hdev, qos->bcast.bis);
 	cp.num_bis  = num_bis;
 	hci_cpu_to_le24(qos->bcast.out.interval, cp.bis.sdu_interval);
 	cp.bis.sdu = cpu_to_le16(qos->bcast.out.sdu);
