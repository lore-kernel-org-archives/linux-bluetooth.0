Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795378436;
	b=AsZ43mFgC3fV2avAua5N+ka2yWEL+ib9zhtsfiZ4HiB3PY93AMr5BIPOKdvZogoaKTT7
	 JttL1qn75HAYHnt3NlBzxBYjV4dM0AGYzSpsmfueFfQ5WfoXX5FciFhldF5EzlKGtdQJi
	 WQ2uaREPaEILsKg7LedoLMO6FtRwr4Ty4U0e9fe1gDMMidI93EQ5yZB/C1P+waJOMl0ap
	 jhxGKTEK65xizstUNglE9NRabwVTAaGB+sL19sVkaWsiDwTvCqMe8xrR2UuP/Mj+EjJ05
	 Y3linyeWHPxpuChsQc8sp8DbaS9HqskcYjfQ6uZy8RIXv5RcSmp1SR97gLZWbEMRE4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795378436;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=fk9YO7HW/YmKUTAStXTkV+hzUKUgJEGQkzOvyBJXy14=;
	b=qjNZlH+RjvstvI+P1H9ZYNykE6839Vcj5AWLXPSzG6xXr7N1tjnkuTyyCy7gEDDiS45U
	 RftV8n0dog28q7rsUV809Uz5oTyZWX72dE8Vz0TgWfOzuB2j7QGfG2caTnd9QFlnjGdee
	 HoqU10nasMd+dVlyAhsLskNJQnOM1wWlKxZurtmSWeaWODNK2sOgomGVWq67HswoqkCQH
	 Nk/JbUhv6waeS+j+hWSuIdELBIzQ/1CvlWzxL6nNqILqJDgjgyH90hMKhjBL9gLtyHCQF
	 5gJ5Hzts0zRLcYC8SgQLCm6ywJnNm7LPk8waPW/uHzaq8gPS2cYtEfl+LQBV2FseZ7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=rDJ2IYaR;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE31D606A31A
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 20:13:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE31D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=rDJ2IYaR
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4a3e706b5dfso1705987f8f.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 12:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795378434; x=1795983234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fk9YO7HW/YmKUTAStXTkV+hzUKUgJEGQkzOvyBJXy14=;
        b=rDJ2IYaRpiuzKp1tVFv+WD3aSPeP5zl//6OwmV0YKD8h9Eq0a0CXqnLVABGWC1Daey
         CwfSZ4ZhLQbo0K9S+fS3v/QYYf5z0rjI9PfEYxMsrqsttwb/vbVjx8rs5EPXkd2/jBsX
         P8D3inbPatABcZzUTr74w/AjxCDmZJ/KtF0As=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795378434; x=1795983234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fk9YO7HW/YmKUTAStXTkV+hzUKUgJEGQkzOvyBJXy14=;
        b=UWVCSfUQ5J2qdTcsELcuaFaKCP6C9qUS9SCWT4Pc5Dl/X3/JYjw4iW6boEpnwjsMCP
         8Q/BJz/IRElSJaltZb1axtoWKr4COs0wCKRv/dZ+Pvb3wKiURbIHIXM6+lgtrNkgJa/Q
         hiTozZh66+151A2jTh9bJK+IJzEwSkPpW0WtcLlcCRJjuw1i5cIoIat2TCFoB6xeMjqU
         WkUiuhchacOmqlT4XBdVyRNlO5RtEDSgn/YUl1pTdKjUN+YC/SB/FPOe9JVXBBBliki4
         tH3q4UsOZxVhMdpQyZqSeMvc7RYZBm29xE112rGK4kzOb3AT4HPIpe56XoC+8D7dX2uu
         BVZw==
X-Gm-Message-State: APuU4Z8+qYFLWgVr8Th3ev4gZ1ISyK8XXTFSwg/RUV4UsoXVBbXRO4dC
	2SDp3B5+13LrZmBWrQp5kju53Ata4kF5YdM6Fne1N1gzCwT9/Ifu2x4tflZyUk/IOGPViUpj9pX
	2nbbX
X-Gm-Gg: AZFdTZcrTd59xZugKhcgDFblIPIEEkV5aBorLw7NDkPub/3Ks1MZSkFxy2JdW9MhAGW
	NuXmRZAr+rcbhH6Sdwwo2NKiBtPXMtrJYahvc+otBdC1F5Y6UHCmfHtLPHzlw19Mri8kkRPQ9wM
	VT7cJrhEwH+ZILf19wtACMamhOFr8NxrfFRMvKWuxEdWSLilv/xi3T1pImYvFmPE43hJ4r2r0WD
	R3xctqBcWC7LIkoBiX9HJ8yo/bb/vE4aqyIb0DGi22W4SpKeqWSVJAPzKVswSMxeg2Hpsh52qwe
	Au+WKk7Q5C5Vl1ESBMuu++ERg+g0DjJVpRg5IAWVtRt4SbZsm6HZ7iWBITvigusutSBjIt1khVr
	Qgx50dhWFYdyJz+tokmEvA2u8dkEc9R686E160m2M+8AqldwtOBa7i7wQYjVbjQqkxj2csASw4A
	ooj5bepw2wHiMemUCa7zXfFne8oA8UhHfUTHn1u2l9AVoGfrjva/Dt41N9EPNQ3ACJdOzBQYBCZ
	GH+u+3dSgGT1CeC1PwZCkuczqtslStIbnJRk2gr0hYnKGbR2Ot3drhc06F4+dvNFdIyOHhoZ2Zj
	DUJxd3/JiiKJY3y+Fz7GZjEJipRnK9sB4X4u3eGT1qr+Karvpw==
X-Received: by 2002:a05:6000:46cb:b0:48e:5db7:fd6c with SMTP id ffacd0b85a97d-4abad6a441fmr12930797f8f.4.1795378433797;
        Sun, 22 Nov 2026 12:13:53 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:f8cf:a1d9:90ed:c978])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab69bf630esm18812737f8f.16.2026.11.22.12.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 12:13:53 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH 3/3] Bluetooth: hci_sync: Fix closing all BISes while their BIG is created
Date: Sun, 22 Nov 2026 21:13:50 +0100
Message-ID: <20261122201351.2854661-3-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261122201351.2854661-1-simon.mikuda@streamunlimited.com>
References: <20261122201351.2854661-1-simon.mikuda@streamunlimited.com>
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

LE Create BIG does not wait for LE BIG Complete. If all BIS sockets close
in between, the cleanup removes the advertising set the BIG is being
created on and terminates the BIG only after that:

    < LE Create Broadcast Isochronous Group
    > Command Status: Success
    < LE Set Periodic Advertising Enable: Disabled
    > LE Broadcast Isochronous Group Complete: Success
    < LE Set Extended Advertising Enable: Disabled
    < LE Remove Advertising Set
    < LE Terminate Broadcast Isochronous Group

A Realtek controller then stops answering commands:

    Bluetooth: hci0: command 0x2039 tx timeout

Wait for LE BIG Complete, or LE Create BIG Complete v2 after LE Create
BIG v2, and delete a BIS closed meanwhile as one of a created BIG, so
that the last one terminates the BIG first.

Fixes: eca0ae4aea66 ("Bluetooth: Add initial implementation of BIS connections")
Signed-off-by: Simon Mikuda <simon.mikuda@streamunlimited.com>
---
 net/bluetooth/hci_event.c | 11 +++++++++++
 net/bluetooth/hci_sync.c  | 20 ++++++++++++++++----
 2 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index ab875b90a143..eeb27bf249ee 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -7881,6 +7881,17 @@ static void hci_le_create_big_complete(struct hci_dev *hdev, u8 status,
 			continue;
 		}
 
+		/* A BIS closed during LE Create BIG is still bound. Delete it
+		 * now, so that the last one terminates the BIG first.
+		 */
+		if (conn->abort_reason) {
+			i++;
+			set_bit(HCI_CONN_BIG_CREATED, conn->flags);
+			hci_connect_cfm(conn, conn->abort_reason);
+			hci_conn_del(conn);
+			continue;
+		}
+
 		if (hci_conn_set_handle(conn,
 					__le16_to_cpu(bis_handle[i++]))) {
 			bt_dev_err(hdev,
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index bdb173440176..d6e0b0fe10b7 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -8962,8 +8962,15 @@ static int hci_le_create_big_v2_sync(struct hci_conn *conn,
 		cp.bis.hdt_rates = cpu_to_le16(qos->bcast.out.rates ? :
 					       hci_hdt_tx_rates(hdev));
 
-	return __hci_cmd_sync_status(hdev, HCI_OP_LE_CREATE_BIG_V2,
-				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
+	/* Wait for LE BIG Complete, so that the cleanup of BISes closed
+	 * meanwhile terminates the BIG before removing its advertising set.
+	 * An HDT capable controller reports it with LE Create BIG Complete v2,
+	 * which hci_le_set_event_mask_sync() unmasks for it.
+	 */
+	return __hci_cmd_sync_status_sk(hdev, HCI_OP_LE_CREATE_BIG_V2,
+					sizeof(cp), &cp,
+					HCI_EVT_LE_CREATE_BIG_COMPLETE_V2,
+					conn->conn_timeout, NULL);
 }
 
 int hci_le_create_big_sync(struct hci_conn *conn, struct bt_iso_qos_ext *qos,
@@ -8989,8 +8996,13 @@ int hci_le_create_big_sync(struct hci_conn *conn, struct bt_iso_qos_ext *qos,
 	cp.bis.encryption = qos->bcast.encryption;
 	memcpy(cp.bis.bcode, qos->bcast.bcode, sizeof(cp.bis.bcode));
 
-	return __hci_cmd_sync_status(hdev, HCI_OP_LE_CREATE_BIG,
-				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
+	/* Wait for LE BIG Complete, so that the cleanup of BISes closed
+	 * meanwhile terminates the BIG before removing its advertising set.
+	 */
+	return __hci_cmd_sync_status_sk(hdev, HCI_OP_LE_CREATE_BIG,
+					sizeof(cp), &cp,
+					HCI_EVT_LE_CREATE_BIG_COMPLETE,
+					conn->conn_timeout, NULL);
 }
 
 static void le_enable_encrypt_complete(struct hci_dev *hdev, void *data, int err)
-- 
2.43.0

