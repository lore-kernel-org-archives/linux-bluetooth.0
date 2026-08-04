Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA71B41D4F4
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Aug 2026 20:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785874299; cv=none; b=CgAguFV6XjhUI5eVNymeIGvLVZe4A4WlKqRtIxTjth16JlzwNaZd2wDh0U6NZ567chCCenfDWtpjWIBmYZ8E2O6NUbro6fz3OzoCT7/vEapnJAKFFkHHc7QYufRE/HXGQlULxgXO8DYC8q58dzOHK3dvdJBWOOEIxnZxc6E3bbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785874299; c=relaxed/simple;
	bh=0AkHeES9ZswgujTKFaUOQLOnNIUaPOXhf1okk5bPals=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hihzfA7M35bGfFgUKU44NACXEHLa9MRCDQWpQLgIDDb6IJHuzZyMLE4pSOwdS7J5oRKBX0uoU2+r5nTg7IX5Qs4vwRiySsvsra4MgWnGHWMfEk0f5WQb+jSu12h8Dlew1IBfUUGldcd5QgJYjihdtIquztoXR4bZjEfEmvv4+sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f7oSi0Xx; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f7oSi0Xx"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cbb8b54fcf8so165117a12.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 Aug 2026 13:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785874297; x=1786479097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SdrUj1nL9osT2IIbWiWs65XkA7mnBrnNND8JYh2/c2A=;
        b=f7oSi0Xx9EvbfFOWxA7ZmJ8Xcwrphb+YJN+uGCdLTRp41A/8/u+ocYKs2ZVEHynQ7P
         1LJGoxPqNsuIuhc6EHqzBVlQms44YQJbxqquzZC4j3Pqtd+aE62SZsxWr//NYEfT2CJe
         XGXQcQMZDqjOG8nVBCq6l4pdXeNiPUPT1pmw8tJjlsGmn1PXChFJi7c9+Sb4x/4i7u7Q
         gpsA7iJDIhrXibpxekuOPX650mf7Fl/OaF8cHpyngj8GSjVOg4JvMg4evSoLhHKqxYbw
         p2P++cX/a5BPLL39SshtA3jaj6tykIol8t8BqCJUSJ7UE6cSLtLXU9/rxaN46ZuMDL6U
         FEQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785874297; x=1786479097;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SdrUj1nL9osT2IIbWiWs65XkA7mnBrnNND8JYh2/c2A=;
        b=pR6HeONJVRWFnXVXMHRPKptHzfNp9FWKynEbrqk/TbcVylBVnakuK2f0LGkB24lirK
         xxOKNBTWMbf+zh2O/ylCSfzWuE+Bv+WSfahnjC66o8Q7JQzuZ9NNrB43wdf8nR4VRIGM
         ic6blxWBLk093g6v5pkGmlbXWN4hjs0rZpWm1FzOO4hTpv33rZxh9caJtUPghXKd3oHm
         uPPYJKsyDUHWuoG++CmMvSx5yP0uMMPHp+mzDfP94xKI1TE7ZYJ/C76+vB7MqrrTLWu7
         p6S0IGyZ3itkiAuXCDnGZbz2c1fxacKbwiQHhiiZdPPC0dzNeAqrBukbHUu7znC6Q6Ix
         tH6g==
X-Gm-Message-State: AOJu0Yzh1hPp0ta9tX7tJZ1hvolAs6bv4hWidNRJAREs3ANYqf1V9QkG
	C6wFMb85/Ld7vWMP2OHnLJLdKCdwpcKQ0MVsSZ9HIRNR6575iXPiGi0jiGH3BSsG
X-Gm-Gg: AR+sD11i1+Sve+EG56tSW03ZKNfpHqIoxjTstL/6AO7ISEWiNsqWwe7WwqxC7Kwjtof
	EGgM43r6mnoSpsIkK1hH3fMGRiluXEikKLpod8TxYf58Kx2pX3yCgEVmma4YhYwP0I9Tn6wpt7v
	E+MECq/ESSbtNehCnIoOsSN27aF/CXntaVBKGIMO+0rXb4tMMjAVbtle1FLQD+NrHknrfSxAcqJ
	pw1Z+3FOvbtCEM8Q8ejEeLblH9BP6VD1wQGziJiTsxzvqSlNDa3GzXm6Egkzi40xnRjM7iV2/Fa
	8FUBjar6QRUk1dh3Y3FtTnfMfmUframlbpvO+7lt/Z/5pc482t3eXCYM6f1dtWFTQj+BT2w9QOZ
	jTOSuNEFAX3hD9KsQa0+y4rVZTEbKF13zXAElvCR86WK98nKB+LP6cJZq5AWMsaYN5eaMcnMDGA
	pBh4yYq5OaL8QhEfRKnckJJzxVTg+umjlIUk+CmqlyTrz+Xh3tupKNS8CG6ASl2U9It+TaOXhY3
	LMIDjej1upaKgxcVupa7zUGnYb0VLQHN0CHXY24vOmH+r6L5fPwEM2zIYz33fLPBAx0LRoLBR0Z
	Nr9OOzvJ8STaaoM67dPBu9yodZr0+w==
X-Received: by 2002:a05:6a21:3a82:b0:3c3:704d:57c4 with SMTP id adf61e73a8af0-3cb85ded954mr1345451637.12.1785874296874;
        Tue, 04 Aug 2026 13:11:36 -0700 (PDT)
Received: from buraq.homenetwork ([2401:4900:1cba:64bc:9c33:24da:1dc9:e38b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315863b761asm12411618eec.1.2026.08.04.13.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 13:11:36 -0700 (PDT)
From: Muhammad Saheed <muhammad.saheed.iam@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	marcel@holtmann.org,
	Muhammad Saheed <muhammad.saheed.iam@gmail.com>
Subject: [PATCH] Bluetooth: hci_sync: Disable legacy instance's ext adv before setup snapshot
Date: Wed,  5 Aug 2026 01:40:51 +0530
Message-ID: <20260804201051.484885-1-muhammad.saheed.iam@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hci_setup_ext_adv_instance_sync(...) only disabled
HCI_OP_LE_SET_EXT_ADV_ENABLE before setup snapshot in case of non-legacy
instances (instance > 0) and never disabled the same for legacy instance
(instance == 0). This would lead to failure in setting ext adv params
with HCI_ERROR_COMMAND_DISALLOWED (0x0c) error like below, when toggling
the discoverable/connectable property of a controller with advertising
enabled.
```
$ btmgmt advertising off
hci0 Set Advertising complete, settings: powered ssp br/edr le
  secure-conn wide-band-speech cis-central cis-peripheral
$ btmgmt connectable on
hci0 Set Connectable complete, settings: powered connectable ssp br/edr
  le secure-conn wide-band-speech cis-central cis-peripheral
$ btmgmt connectable off
hci0 Set Connectable complete, settings: powered ssp br/edr le
  secure-conn wide-band-speech cis-central cis-peripheral

$ btmgmt advertising on
hci0 Set Advertising complete, settings: powered connectable ssp br/edr
  le advertising secure-conn wide-band-speech cis-central cis-peripheral
$ btmgmt connectable on
Set Connectable for hci0 failed with status 0x0a (Busy)
$ btmgmt connectable off
Set Connectable for hci0 failed with status 0x0a (Busy)

$ dmesg
...
[   21.970527] hci0: Opcode 0x2036
[   21.970529] hci0: opcode 0x2036 plen 25
[   21.970537] hci0: skb len 28
[   21.970539] hci0: length 1
[   21.976099] hci0: result 0x0c
[   21.976105] hci0: end: err -16
[   21.976114] Bluetooth: hci0: Opcode 0x2036 failed: -16
```

Signed-off-by: Muhammad Saheed <muhammad.saheed.iam@gmail.com>
---
 net/bluetooth/hci_sync.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 307fd47f8459..4626dd15ed8a 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1144,6 +1144,32 @@ int hci_update_random_address_sync(struct hci_dev *hdev, bool require_privacy,
 	return 0;
 }
 
+static int hci_disable_ext_adv_legacy_instance_sync(struct hci_dev *hdev)
+{
+	struct hci_cp_le_set_ext_adv_enable *cp;
+	struct hci_cp_ext_adv_set *set;
+	u8 data[sizeof(*cp) + sizeof(*set) * 1];
+	u8 size;
+
+	if (!hci_dev_test_flag(hdev, HCI_LE_ADV_0))
+		return 0;
+
+	memset(data, 0, sizeof(data));
+
+	cp = (void *)data;
+	set = (void *)cp->data;
+
+	cp->num_of_sets = 0x01;
+	cp->enable = 0x00;
+
+	set->handle = 0x00;
+
+	size = sizeof(*cp) + sizeof(*set) * cp->num_of_sets;
+
+	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_EXT_ADV_ENABLE,
+				     size, data, HCI_CMD_TIMEOUT);
+}
+
 static int hci_disable_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance)
 {
 	struct hci_cp_le_set_ext_adv_enable *cp;
@@ -1369,6 +1395,10 @@ int hci_setup_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance)
 			return -EINVAL;
 		}
 	} else {
+		err = hci_disable_ext_adv_legacy_instance_sync(hdev);
+		if (err)
+			return err;
+
 		adv = NULL;
 	}
 
-- 
2.53.0

