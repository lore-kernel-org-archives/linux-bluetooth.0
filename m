Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794359396;
	b=L2MhE4Ct5saPT5/ct/hiyxLQQSsArDBOQ3Z+jR/gPIfT+wPXYGCn6UU30cFmuFe8Qcyz
	 wpK3mYvPDxcOLIgfmpMLoXmB6D/ZqKaewImrFtqKPKZMkp/i2g2BwAn9wBw2J5nh4NJRU
	 CAnOMz9ltHN3ZmODBLONCjM9nBIanq1InERbP8ak+ZkhxJCbp5oUov12UAtu5t9PQ/q32
	 yip0Fvc0qMDsTgxmiHWBgaCmOhwGtFAzfq9YIY0U06lCM2RGAKLTeAMSkCO8e6tLstica
	 +Vps7nd9m+hFHH0cyOg/9J/ciPfdltFqpcH1SgxEUnWHnlT8bkwDNSdOLPCs6E5oD+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794359396;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=XIg5sdIC6+mChlXQqkw9i0dYVMO4CZL6M9ntWloVWrs=;
	b=SOtlbl47bdAO2MjGGj93JLPKbFlRJEGnMirmOQDkukkm1p9WBhT4vslAsuEL+V43z8KM
	 BPJZI5c/RKMuJNDf8iOz0jaFy9w3hRA+0KrzyLUdYBB/T+aj2er5S8A30TP9c3bFIK/ps
	 MIqxCgiaBMSutoLwIQN9UKrAK7hK0vw/A8IDm5GBD9fpczc/OhNp5gdRS+zlV8/gpzL1G
	 u8roLJ2D+jb+9aXqUDycN7YJd7jHJhTL9Yl40ISAzKHvQvM6NpIPS8zgjowWA71NiRmVA
	 2NzUrn71p3uNyQgDUW+swTDRDw5/iAQlT0f3uWWqMX8QltMvoa4XUHfxZWGokjjWM7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GqBEVVBl;
	arc=none smtp.remote-ip=209.85.215.177
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C5F606A31C
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 01:09:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60C5F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GqBEVVBl
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cdb2e0062bbso1058239a12.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 17:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794359396; x=1794964196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XIg5sdIC6+mChlXQqkw9i0dYVMO4CZL6M9ntWloVWrs=;
        b=GqBEVVBlkh2RmhkBil4ZEX0oFyXXbtDoZWqEZoWgEc1usaBYIbSjcO0dfbAcSR4KZr
         60QD9Ajy+Oe3WvxGU8zTzbBVf6+ml5wt36CS+xJN549bfdE3j/NGSgULG0UtdEech8Z1
         7jXXbMG/QNG9zyjD06oAwa2VfxLxn96n2HPD/bYUPBVabD81KCitoOWk5PGj99XcC2qI
         FVw3lLVPZ8nq9RtWnuC0ywA8FU6qvfLtSfyJi06vqLFoSVvXI/gDBaKSqYdfZKE7PwZM
         bmdUiA0L2EmkOJAFt7gESQvLfSAQnVyOUfQ9r2iT2I6LhmPIcKNHfvOjNuu2XgCixxPE
         PphQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794359396; x=1794964196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XIg5sdIC6+mChlXQqkw9i0dYVMO4CZL6M9ntWloVWrs=;
        b=sJsPKNQJ51EJVnZODl0aYrDBAmcB72K4mGBSikrdVQmLQfGFBvjyj9xPCe0P5oWk2C
         3ZaB2AbXZzzynBuqbAR7dv8vIjUH+HBZnfEq9htGFps2LbsXfS3UyZazdfrxFOR9F83a
         i5vWeA1xQVPWoerD8bpsStdJU6S3YhnGiqdwiUQgrvjgfuF4Ux0/6ilPQHvBvuHNNWgB
         rgrmrL4X29qJZN+dv16Yq200zvrRbhLXutjFc9F6U3jLt4rVEsM1ZSxXpBZ0G54NdaL2
         cAoz2f1q+H9jnP4wylXwDHjMlPK5qT2pGc1gqaLrkh4Ud2OomI9/Y+kwevSTa8nCNVRH
         Mp8g==
X-Gm-Message-State: APuU4Z/2mQc53YRE1X68Owf8Iq6YKYpgMUmpSgbO/hnA7/pXMgqU0b5H
	nd1GLMbUZb668bKRVtkmekFsz8VkWoba9uTrH9k6YUAU3ItbkzBf3X6zlWPkfNHZ
X-Gm-Gg: AYBFou0JeEWlDenZ60ntGe1w7LZmWzArQMHp+6Q1utU+6Xq1lb1Sxo8sdFOQ1Jeci3l
	6EKrqpmFCQXd8osjApBeLibswqIUrt8Rrbwonh0cqjAhYP7+rl4BklGqPAYhkKPS7TcOmI9tp2w
	Yjfz52CQsTIqsr2F1b/2qFfNtZfkHh7+4W8JQPmU+KG7bZ8Okt3Usd7X+WXK1bgIfIBZdUDfNxx
	Olm9bY72XnC+i2U42DpeD+uuLOXwr3sFYA5RgqbSOwTLFvloQkVeedbX5WiT8nhbI9VTH5I7kyA
	fcNNsZAOIa1wFiKrFeRiDL+7fbf7mvPgUJA6NjkLybzJnSX1mlKjNxeZZRe+/FHhoGIxE4o5ylc
	2fbtMpar/3iD1ImS0locYNUPWqQKT9zfKFI6MtwnR1IxTO8Lhl27K6HOLJ3COscB0v+7Y29ZfKC
	Iy/hUMAgSHUrwG6St3R0hglnifJyC+nD23OvLULqMto5vlhZ+gS0ndnXVh9cJChGMxvRNcZpzWd
	oc7unRMaLYfr0feHWq8RAE/tiR95gtIKhZrnyHYax1vtRciyVjX6CXCP4mboC7iYwdb7o9mGDjq
	lMmHol2/aOzqO/LVhH9bMUMDAy/MG1JFJViMrhOtd+w1C023kJzKlWN5xxPotw4Guj8meEInUqI
	=
X-Received: by 2002:a17:90b:1f87:b0:3ac:8897:7b9f with SMTP id 98e67ed59e1d1-3b182f0d1e4mr684386a91.43.1794359395635;
        Tue, 10 Nov 2026 17:09:55 -0800 (PST)
Received: from localhost.localdomain ([96.44.128.241])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-375218c863csm10085492eec.28.2026.11.10.17.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 17:09:54 -0800 (PST)
From: Weihong Guan <weihong.guan@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Weihong Guan <weihong.guan@gmail.com>
Subject: [PATCH v2 2/3] Bluetooth: hci_sync: Remove an advertising set by its handle
Date: Wed, 11 Nov 2026 01:09:39 +0000
Message-ID: <20261111010940.728149-3-weihong.guan@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261111010940.728149-1-weihong.guan@gmail.com>
References: <20261111010940.728149-1-weihong.guan@gmail.com>
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

When the controller supports a single advertising set,
hci_add_adv_instance() gives instance 1 handle 0x00, but
hci_remove_ext_adv_instance_sync() sends the instance number as the
handle of LE Remove Advertising Set, so removing instance 1 fails:

  $ btmgmt rm-adv 1
  Remove Advertising failed with status 0x03 (Failed)

  < HCI Command: LE Remove Advertising Set  Handle: 1
  > HCI Event: Command Complete
        Status: Unknown Advertising Identifier (0x42)

Send the instance's handle, looked up with hdev->lock held. Two more
things follow from the instance and the handle differing:

 - hci_cc_le_remove_adv_set() removes the instance numbered as the
   handle it sent, which for handle 0x00 is instance 0, so instance 1
   would stay in hdev->adv_instances with its RPA timer running, and no
   MGMT_EV_ADVERTISING_REMOVED. The completion can't tell instance 1
   from instance 0, which the MGMT Set Advertising path removes on the
   same handle, so remove instance 1 in
   hci_remove_ext_adv_instance_sync() once the command succeeds.

 - While Global Advertising is on, it owns handle 0x00
   (adv_overridden_by_global()), and the set may be enabled for it, so
   the controller would refuse to remove it, with Command Disallowed.
   Remove only the instance then, leaving the set to Global
   Advertising.

Fixes: e77f43d531af ("Bluetooth: hci_core: Fix not handling hdev->le_num_of_adv_sets=1")
Assisted-by: Claude:claude-opus-5.5
Signed-off-by: Weihong Guan <weihong.guan@gmail.com>
---
 net/bluetooth/hci_sync.c | 55 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 49 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 320c5ba0d..d4a4f49df 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -2110,6 +2110,9 @@ int hci_enable_advertising(struct hci_dev *hdev)
 int hci_remove_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance,
 				     struct sock *sk)
 {
+	struct adv_info *adv = NULL;
+	u8 handle = instance;
+	bool global = false;
 	int err;
 
 	if (!ext_adv_capable(hdev))
@@ -2119,13 +2122,53 @@ int hci_remove_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance,
 	if (err)
 		return err;
 
-	/* If request specifies an instance that doesn't exist, fail */
-	if (instance > 0 && !hci_find_adv_instance(hdev, instance))
-		return -EINVAL;
+	if (instance) {
+		hci_dev_lock(hdev);
+
+		adv = hci_find_adv_instance(hdev, instance);
+		if (adv) {
+			handle = adv->handle;
+
+			/* An instance sharing handle 0x00 with Global
+			 * Advertising doesn't own the set while Global
+			 * Advertising is on, and the set may still be enabled
+			 * for it, which the controller would refuse to remove.
+			 */
+			global = !handle &&
+				 (hci_dev_test_flag(hdev, HCI_ADVERTISING) ||
+				  hci_dev_test_flag(hdev, HCI_LE_ADV_0));
+		}
+
+		hci_dev_unlock(hdev);
+
+		/* If request specifies an instance that doesn't exist, fail */
+		if (!adv)
+			return -EINVAL;
+	}
+
+	if (!global) {
+		err = __hci_cmd_sync_status_sk(hdev, HCI_OP_LE_REMOVE_ADV_SET,
+					       sizeof(handle), &handle, 0,
+					       HCI_CMD_TIMEOUT, sk);
+		if (err)
+			return err;
+	}
+
+	/* hci_cc_le_remove_adv_set() removes the instance numbered as the
+	 * handle it sent, so remove here an instance using another handle:
+	 * instance 1 on handle 0x00, on a controller supporting a single
+	 * advertising set. The completion can't tell it from instance 0.
+	 */
+	if (handle != instance) {
+		hci_dev_lock(hdev);
+
+		if (!hci_remove_adv_instance(hdev, instance))
+			mgmt_advertising_removed(sk, hdev, instance);
 
-	return __hci_cmd_sync_status_sk(hdev, HCI_OP_LE_REMOVE_ADV_SET,
-					sizeof(instance), &instance, 0,
-					HCI_CMD_TIMEOUT, sk);
+		hci_dev_unlock(hdev);
+	}
+
+	return 0;
 }
 
 int hci_le_terminate_big_sync(struct hci_dev *hdev, u8 handle, u8 reason)
-- 
2.47.3

