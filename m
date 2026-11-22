Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795361698;
	b=4bqGXO0X9N91c6axipWtLKCp2n0LFufctga5FVeVCrgx1zQUoGGZeeZ7CjqTe2fZt9z/
	 jpGT4VpMsSsTtaCLrA/EX9qUKvXu2IsLMkV6QW8Gi2TDzoTSEGwW+jsEfqF8JG6rJIh+Y
	 YqlXKSSlMOpfaMLPynlBtzE0ma8tyLSUIA5bZiV41f9fcHwh42uEaHuC1v8CsVkxrOOJK
	 y6/CPvq8xAJJ51no/86dE+5sXVduNia6cvJ2KER2FDbe9azqgd9KRSd0LCXh5hpen2ew0
	 CN+OsfcYXKhiOMteFZ2xmciMVUuhJqcdm56MCAyIHQVWZ5oO0GUCC/TVIEHUO5COQsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795361698;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=VnOgWs5chjKCzxdsBH6XaIQqIQq5zDw8vKraoc1abxk=;
	b=XuHX5rhGEIdjF2SpjEZa7cGo0Pp8nJhYOkjCGrSHEr5oZOKDhjrnDhZfI4tltoy6tsA1
	 qhvn+RjLUKhbdgoZr/5tTACqf6CVAeK6HmKqE0Kr0MjGtkqEKYla1Y4OeceUIXY9MHf79
	 N2dk807KJWfIO3xBrrJnjCXRpjU3ladMV+lgDD1ZDdJLuubixvL+yTdrInu9kuR0gMN/p
	 vvrWMhUG6ay1uUBq7ikP4c9QG9ofdmHDP2sQAz0EZ2PHg1vI25iJZvkX80t8RgQa7xg0r
	 VT7s0rohHaPSiwQVs7iypof5hcMfLOcNLpN0xAM0SaLZummccvLOi+EusJmp4V8CnQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=CjwbwgrR;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B897606A320
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 15:34:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B897606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=CjwbwgrR
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-492fcbfaa88so1495533f8f.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 07:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795361697; x=1795966497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VnOgWs5chjKCzxdsBH6XaIQqIQq5zDw8vKraoc1abxk=;
        b=CjwbwgrRKO0MBWI0XmKfA2OLp/mD4OwzGlhCJsuCZocgoeQk/XWXPX3SU7+mwZbg2J
         vMZOfrkA/ClqaVKk8W5OOBmvzvKMN1lWQgI14wxNS/Wyh797W/mHb0lkVHsxx37K/lzc
         u8kqofbfQGgiknMdDq8wUgion1etqbz80kCv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795361697; x=1795966497;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VnOgWs5chjKCzxdsBH6XaIQqIQq5zDw8vKraoc1abxk=;
        b=YN2LXeYA7UGl7V+J06I3rPAcBux7K99Ez0koYSYR7CR1E8MV/EKtLCtzYMBhhsk3en
         t74udrUlfLghQLnP7R3ZdvNc+8vdxqgng2CN7SmfTBhDjmyORHfEk8Hc3o1/n2jWb0no
         Eett4p+xsQdjnGDXogm2FNIYaYyzAXhKaDy779cIO5+QHUbkMmRlsKRrl7Lnsnrs/4ZK
         garMwCQI4n6CKDuJckXdf4he9G6+OXpGuFaIaF8bWw+O6TxiZWj5o9lK2qGZKeTDbtL9
         Y+jnHUjSoTjde6YtyoZGJtS/vlmZcBQHfSFd3g8lf3J8GPS85nqim2GnlZdqGUBxYU7+
         Z8fw==
X-Gm-Message-State: APuU4Z8PcVHNWC76ct8CJxmKHRp0ONh//vLaC3suEA0KpDj2OtsANzW8
	BsKyhqfpdQjm9ALT8wOFQLtpFDd1vEMt7PUnaN5dY2A2pnL6xIJ5Czozon7dmP0a0pxG3WzFUxt
	OFhY2
X-Gm-Gg: AZFdTZfou7FxmMIx5NFqE2rc1+1Jdq1oa87Po48Tk2M62nD5saUThdyZc3YK+hu6ULs
	fJGBV5DQEFWJ0Co5x3ZcTa9mmLi+Ub703r8IiKcPiRKOp3jFhD/4Rablc41z9A3nX2SuRoLHCuY
	xMxJaxYUbRrtZBQoNpQCSSaVkxtSpJP7eU4YsaUjG2jnEJuQ9+rWGPzLYDVtucOURlBk7HGZXQx
	nnXAXFJZBEMOJpsxLKeVHggh9BPsXlS9GhWFUKFI8GITA4aeDgrCprf8cx1bxY0skQEdm2UoSaO
	mS2D2lWeWbQs1KZtT2tcVz8uS6s2pBof63xVwPED0p0INn8+JP5AeskaIw9GLfPcvxn6kYbYBEN
	8sK9gMhpxLz/QMKann73c/zCgFg1T51/MT1epEsJl2pbPSoEpSyIbQkxJZrbsgsvdSr/iDZQsqb
	Fg2QzIOFLsLOEzesmbemCU7Z5OnJxbkMC9cfEKxszEW6r7UihwJ3/pPXKpCT3AMkcd5gyX994IV
	vb9BM5UxoEkoXYBb2rLOs12PQBem6SoBEfb5DcWRSKizQeZIgUApSS5oWXYM5p/LkveiiF/a3D4
	qtvjzYOG7/GMVKLgC1X71a7p3+vs7DcYHwpw/FoZSvVEGrP2Lg==
X-Received: by 2002:a05:600c:3b9e:b0:4a1:cf60:dcc3 with SMTP id 5b1f17b1804b1-4bb88820687mr219295545e9.29.1795361696661;
        Sun, 22 Nov 2026 07:34:56 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:f8cf:a1d9:90ed:c978])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb90660cb4sm183440175e9.2.2026.11.22.07.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 07:34:56 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH] Bluetooth: hci_sync: Write the default page timeout to the controller
Date: Sun, 22 Nov 2026 16:34:50 +0100
Message-ID: <20261122153450.1532145-1-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
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

MGMT Set Default System Configuration takes a page timeout (0x0007),
and Read Default System Configuration reports it back, but nothing
sends it to the controller: HCI_OP_WRITE_PG_TIMEOUT is defined and
never used. BlueZ's PageTimeout in main.conf therefore has no effect,
and the controller pages for its default 5.12 s. A page sent without a
clock offset can need longer than that, so connecting to a device fails
with a page timeout that a longer setting was meant to avoid.

Write the page timeout during BR/EDR init when one is set, as every
reset puts the controller back to its default, and write it at once
when it is set while the controller is up. Zero, its value until it is
set, leaves the controller's default.

Steps to reproduce:
1. Set PageTimeout = 16384 in the [BR] section of BlueZ's main.conf
   and restart bluetoothd.
2. btmon shows no HCI Write Page Timeout, and connecting to a device
   that is out of range still ends with Page Timeout after 5.12 s.

Fixes: 17896406ff35 ("Bluetooth: implement read/set default system parameters mgmt")
Signed-off-by: Simon Mikuda <simon.mikuda@streamunlimited.com>
---
 include/net/bluetooth/hci_sync.h |  1 +
 net/bluetooth/hci_sync.c         | 16 ++++++++++++++++
 net/bluetooth/mgmt_config.c      |  8 ++++++++
 3 files changed, 25 insertions(+)

diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index 59cb918d1405..26333d27bd96 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -132,6 +132,7 @@ int hci_read_tx_power_sync(struct hci_dev *hdev, __le16 handle, u8 type);
 int hci_write_sc_support_sync(struct hci_dev *hdev, u8 val);
 int hci_read_clock_sync(struct hci_dev *hdev, struct hci_cp_read_clock *cp);
 
+int hci_write_page_timeout_sync(struct hci_dev *hdev);
 int hci_write_fast_connectable_sync(struct hci_dev *hdev, bool enable);
 int hci_update_scan_sync(struct hci_dev *hdev);
 int hci_update_scan(struct hci_dev *hdev);
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 638589f77081..c1e03ce5c1c2 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -3915,6 +3915,20 @@ static int hci_write_auth_enable_sync(struct hci_dev *hdev)
 				     HCI_CMD_TIMEOUT);
 }
 
+int hci_write_page_timeout_sync(struct hci_dev *hdev)
+{
+	__le16 timeout;
+
+	if (!hdev->def_page_timeout || !lmp_bredr_capable(hdev))
+		return 0;
+
+	timeout = cpu_to_le16(hdev->def_page_timeout);
+
+	return __hci_cmd_sync_status(hdev, HCI_OP_WRITE_PG_TIMEOUT,
+				     sizeof(timeout), &timeout,
+				     HCI_CMD_TIMEOUT);
+}
+
 int hci_write_fast_connectable_sync(struct hci_dev *hdev, bool enable)
 {
 	struct hci_cp_write_page_scan_activity cp;
@@ -4522,6 +4536,8 @@ static const struct hci_init_stage hci_init2[] = {
 	HCI_INIT(hci_read_local_ext_features_1_sync),
 	/* HCI_OP_WRITE_AUTH_ENABLE */
 	HCI_INIT(hci_write_auth_enable_sync),
+	/* HCI_OP_WRITE_PG_TIMEOUT */
+	HCI_INIT(hci_write_page_timeout_sync),
 	{}
 };
 
diff --git a/net/bluetooth/mgmt_config.c b/net/bluetooth/mgmt_config.c
index 834220072450..1ed6a07abad0 100644
--- a/net/bluetooth/mgmt_config.c
+++ b/net/bluetooth/mgmt_config.c
@@ -135,6 +135,11 @@ int read_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
 	return ret;
 }
 
+static int page_timeout_sync(struct hci_dev *hdev, void *data)
+{
+	return hci_write_page_timeout_sync(hdev);
+}
+
 #define TO_TLV(x)		((struct mgmt_tlv *)(x))
 #define TLV_GET_LE32(tlv)	le32_to_cpu(*((__le32 *)(TO_TLV(tlv)->value)))
 #define TLV_GET_LE16(tlv)	le16_to_cpu(*((__le16 *)(TO_TLV(tlv)->value)))
@@ -268,6 +273,9 @@ int set_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
 			break;
 		case 0x0007:
 			hdev->def_page_timeout = TLV_GET_LE16(buffer);
+			if (test_bit(HCI_UP, &hdev->flags))
+				hci_cmd_sync_queue(hdev, page_timeout_sync,
+						   NULL, NULL);
 			break;
 		case 0x0008:
 			hdev->sniff_min_interval = TLV_GET_LE16(buffer);

base-commit: 4fe38719e6738feaa90486e36b0790dd5d960a96
-- 
2.43.0

