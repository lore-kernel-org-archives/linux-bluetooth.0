Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415901;
	b=14ghh7txdVgH4K7mk9h++rDZ6e+KP+atxfLKhNf3xXgBSmMV8hbuTYBcTWZTmkmF5G8Y
	 WlP+61Z1gU3Io8tD0KZyP/vCsxP3Kxl+OlTovD+ZOxKadGsXncT3Wo/KjYjGVamY3BN+j
	 L9p3OiyKO30CzC4YZLW+ElsvSR8RWbo1eFYjyZH9fGbk7DwKnv+YBrsOfWeI1BgX2bQM4
	 aPubRbhZk3LKjKaFB6lW+jEiJ4nKzXf9xsh8NHHGWkl0daqR6w1X0LHRBM2crHLWcy6pA
	 J2/+MTAriShQ59vbL9/2YIUj0NbR+PKXFI9b/3WLbkNQ+0Rw2+NlGAZF9I/mMM5DeHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415901;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=XIg5sdIC6+mChlXQqkw9i0dYVMO4CZL6M9ntWloVWrs=;
	b=fO0y9zKS1Q0gxBqs0xm0qDdoxkC4pnv0UhrV29YQD3xC5CZfEM2sOMKKXFbvj+WcPGWr
	 YaX+5jZXSI2os+0liTI89pccBs23abIsraSqngGgOgcCoWeBwF0+m848zjTzpBcdk6Spa
	 TWfkmzGjXfl4U2FeDadjdW8WdEa9QHUhWpo3N7QvlwpLjyp9g530K0dryvt5Gyv/VSIYX
	 b9MWmrHbOKR8AkTAEsr0bQuH+rT7Ck7P4lhORXRy2vgLmvstMilQrJwNeNHAZ0PcQApV/
	 VoHDpDCa5BI70xF0ODN1BhsRTMcT1/nfP+y/ubl+71QYYNfj3XrT9CMYNLuZMBC0f/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jptEgWzO;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D71D606A891
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 16:51:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D71D606A891
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jptEgWzO
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-372bdb942dbso4331190eec.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 08:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794415900; x=1795020700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XIg5sdIC6+mChlXQqkw9i0dYVMO4CZL6M9ntWloVWrs=;
        b=jptEgWzO/ciS6gQlaSxyvgcnztxpeocjpoRMfK4bVX4+hz7NlbPORTpwm1bAQUjGas
         Te2/w7qQy7xPVBLOBbInl/HdBuoYLp5BRiW1XIPHJ/RrdReRGgOCRviz3Id/y6TAisy4
         jGXOGVAaaZ991ZuA5m97+Cz3QcZIM3F5tv8bkZx7lzRA0PtVBE9ECC18Bo6pGbwVbYf2
         yAA8gLFegdrcz9ilovANiqn+fW295jBchga6FrqUYb3yzBDEngxDQMMmdGodtiwhuqXb
         S7/Y9CNN8O0YSr7Q4Z2l+gw2mDlHC55ysgic4cRqwD6pFi/DzJH/6YKNdH7cqRrxhK1F
         wzWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794415900; x=1795020700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XIg5sdIC6+mChlXQqkw9i0dYVMO4CZL6M9ntWloVWrs=;
        b=rV76edP+UXUPZXBzEflGQZoFAHydhgOWuP5vzSxCWlX9+uDclvtSICwUixXV8WJX8i
         ikwb1clHGrGpjDMkyiKeqhNTWJMBdgybzMvY8IDogX577RipvZg1jwyi/6sXhaJs4yAP
         kwFbX2/cUc9SFoJS6nr4LOn5iQkzVKi226ZDTADCkZwE1xUce5SGVEpJH6JZMM5sK0lF
         QyYJ1KjMVfUDHuZd+0mcztNR8i7AA/LRQN0wvZ6rSNLj4VyuXFlb/Q2ZJ6HWP4Qg65oJ
         Vrr/y4yCxhu0SoA/Zpm8F+MMLqAE2NM8lqchsQWqCuUCteyG7MCAS29h67DConorqnKO
         TXog==
X-Gm-Message-State: APuU4Z9cNLH2KSoOCF5iszUJ+t7cP31N2BYa4kIlc8g+Lsf2OgzxCh4J
	r3nbCscjbs3b3Y+pe6MVWEshe6K7H7yTEjfk/WO/T5ReYdVjap+ATl5fD/knGTdpSXk=
X-Gm-Gg: AYBFou1o4dNMc7gIpaaRCC8EcLMbyU7Fxhsy/sY0TwSKFtSYwIdTPmk1mzW6HazbNwY
	Ow0d1fi3soxXh1EAsM2ApUgEg5MVjFsYwkWtwSd5WqcUTKzx+qPtLu/D8cJDJzw6kz2bh6wSISP
	4SF6ALoAERkt1xuO/M0zk7FBBhSlf7877bYKQv5CTSdnoBAzq7nfCvhA6/x32nmD32SlnwMIiL1
	jHcAeex6QzY9YiuUiXzREXwnmF+PJ6oaEmoT6UupYeu6Gj01vl4FvkXGZLX5ghCuGwI+wNpr8/r
	R+Shu5MW/F3XUyj+VQNFSmZ2QHpWmd/yquR7+0Yjt/s0Z6GUWrCxwkLVrOndU6B+ZgaPbYAh7ay
	rcjJtgPnAVz/Cu7yoc5ziRmWOj8nhxdPDbmg15EW0otKUtwmnMhiobDUvjVe8WAFiF1x/9sv52S
	MfBw9h8cKNPbKaIRIKxJXaBS5Io7LVmtON0skqWji4OjvnHOsg0H+VGd+GePFU4RLL2Kzl8OPzn
	EqnpLB88jzkas3Mdi8bt440DvFPRs8kufO+UAZsSM7LlJWoNZ54/BXbK56QE58QDpuvQaBg/0GR
	Hpu0WuTV/2aoD5TCbmODHD+n3oZe2BFwa6LR0BUsQYUuUEioD2f7L/X3V+XhtVir1SSYs7pxoXM
	=
X-Received: by 2002:a05:7300:cb13:b0:376:7cda:a103 with SMTP id 5a478bee46e88-37686d30378mr4419057eec.32.1794415900401;
        Wed, 11 Nov 2026 08:51:40 -0800 (PST)
Received: from localhost.localdomain ([96.44.128.241])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3752060899asm17119793eec.11.2026.11.11.08.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:51:39 -0800 (PST)
From: Weihong Guan <weihong.guan@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Weihong Guan <weihong.guan@gmail.com>
Subject: [PATCH v3 2/4] Bluetooth: hci_sync: Remove an advertising set by its handle
Date: Wed, 11 Nov 2026 16:51:31 +0000
Message-ID: <20261111165133.827594-3-weihong.guan@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261111165133.827594-1-weihong.guan@gmail.com>
References: <20261111165133.827594-1-weihong.guan@gmail.com>
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

