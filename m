Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEB113B79F
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Feb 2024 15:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709046943; cv=none; b=Zvv2c2Lw3cUBgfATsQTEb0iQLfhTvME0LFm87Xl7x6QlokPIRn9vzWtHup4yhgb/Dnsqq/SoP+rt3jyUeau3+hbzQr9XJr2/Q7BFGVB1q/ULLLA4AsCrxDU4qv4pJMXQNnEgvbw5CtfqtGeBRtl2aF6h90ZQx7P7QIrpBPXKkoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709046943; c=relaxed/simple;
	bh=yAwVjnii4gOdKjVBPRKqszUhbHC1xKlL80xFSv2WaF0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=SulodrN2ieI1z1OQyt8HTUIq+RyRifywJK09umbe3Zm0MkxAOV8CJfOySxeMKhuLsA2HH5LMPXXCBNhZlCkcT3YO2oQ+oLi+5B09xXquY4Mlf6v03uGl7INiSaIKtPoFLHkRHX+BP8Xaja89COIFx2wndQuJAZG7Q9F49LJommk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rf8zr39p; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rf8zr39p"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-7cedcea89a0so2806644241.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Feb 2024 07:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709046939; x=1709651739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ef5cxWS/DHX003FFu3ZV3XHChZLsTqEMaAm7lSIlAsk=;
        b=Rf8zr39p9t/dabDyn5Ja252EUcK1lWVSlmrHivicSqFJ044G0jYmoxmTVKt9SzFf8P
         aF+mJD9jpavnfSzJrHE0VGpwF5djjF+punSsECm1Q6WeDbuWyPuZkZD30qcyc9rXsDmf
         jA5Ojr/qK+BUaxv5x6NCqRSltM57EJ/bQXzPv8UdsyLAqICwCAwnb58xAs2pMEXcpcZz
         J+MHGUIsepEZ7bkN3FyiXqWeuY0ih8cvS0NSfAF82gjr3UylcVO3w1ogpMIuzsPirmUa
         GrTfw2L7uYnrXCbCZ/9/GPR9JRo5qPHC1A0IZBxScMSU2nAXRqN8WO3rxTzRv+dxfmzl
         bNtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709046939; x=1709651739;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ef5cxWS/DHX003FFu3ZV3XHChZLsTqEMaAm7lSIlAsk=;
        b=eug+baUL3BZiUELzBExV/Ju3dRJKxXlBV1ewuPu5yam76CwwMYW3B5pRsvpuX0Ynd5
         rgvZbUiRzu6Nv9xcnsX/0pQZWFNnrRhABJvDix7LBnz5z2wrcr8WECwwMv8O9yFYWtK9
         R01n4SA6XUL4EWEfqWZnlwrgjb1yzkHd5SVLOO/krCeuZiS2moF/mcCm6XwQ1CUvvvph
         olNVtCZGc4LmTkgsv4JpVXoGThNRul4dzZ/GiE4Ku7WK/ITYLKubJmCtzsQu5Ok9Ubwq
         o67sBFpDLL8VjW+UJXXiwU9tpSSaFD7jajnNc9UJA5WmnPJx85O7DdX5eKftlV8iA9i9
         7b4A==
X-Gm-Message-State: AOJu0YwyNWl2TX55qrq9lea3bsn6DrbJFn89ifhThGwGCnKgj1ms03MR
	mwEiKwFn14GxSdux1wMic8tDZI0CR3Y47EQDpCrwFGG7GmdZrYunst//PAyC
X-Google-Smtp-Source: AGHT+IFGRSn9aYsaMrzn6FwP3Mh5bOaD7OoW6gy1GG81FwWp2d61gfB3LJ+GZSoOya8/1WhznIWpug==
X-Received: by 2002:a1f:da81:0:b0:4c9:907e:30be with SMTP id r123-20020a1fda81000000b004c9907e30bemr7270225vkg.13.1709046939098;
        Tue, 27 Feb 2024 07:15:39 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id h28-20020a05612201dc00b004d335f1bdb7sm32726vko.37.2024.02.27.07.15.38
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 07:15:38 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 1/2] Bluetooth: hci_sync: Use address filtering when HCI_PA_SYNC is set
Date: Tue, 27 Feb 2024 10:15:36 -0500
Message-ID: <20240227151537.1884044-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If HCI_PA_SYNC flag is set it means there is a Periodic Advertising
Synchronization pending, so this attempts to locate the address passed
to HCI_OP_LE_PA_CREATE_SYNC and program it in the accept list so only
reports with that address are processed.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_sync.c | 45 +++++++++++++++++++++++++++++++---------
 1 file changed, 35 insertions(+), 10 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 669099cf9b1a..ab609089ac4c 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -2566,6 +2566,16 @@ static struct conn_params *conn_params_copy(struct list_head *list, size_t *n)
 	return p;
 }
 
+/* Clear LE Accept List */
+static int hci_le_clear_accept_list_sync(struct hci_dev *hdev)
+{
+	if (!(hdev->commands[26] & 0x80))
+		return 0;
+
+	return __hci_cmd_sync_status(hdev, HCI_OP_LE_CLEAR_ACCEPT_LIST, 0, NULL,
+				     HCI_CMD_TIMEOUT);
+}
+
 /* Device must not be scanning when updating the accept list.
  *
  * Update is done using the following sequence:
@@ -2614,6 +2624,31 @@ static u8 hci_update_accept_list_sync(struct hci_dev *hdev)
 		goto done;
 	}
 
+	/* Force address filtering if PA Sync is in progress */
+	if (hci_dev_test_flag(hdev, HCI_PA_SYNC)) {
+		struct hci_cp_le_pa_create_sync *sent;
+
+		sent = hci_sent_cmd_data(hdev, HCI_OP_LE_PA_CREATE_SYNC);
+		if (sent) {
+			struct conn_params pa;
+
+			memset(&pa, 0, sizeof(pa));
+
+			bacpy(&pa.addr, &sent->addr);
+			pa.addr_type = sent->addr_type;
+
+			/* Clear first since there could be addresses left
+			 * behind.
+			 */
+			hci_le_clear_accept_list_sync(hdev);
+
+			num_entries = 1;
+			err = hci_le_add_accept_list_sync(hdev, &pa,
+							  &num_entries);
+			goto done;
+		}
+	}
+
 	/* Go through the current accept list programmed into the
 	 * controller one by one and check if that address is connected or is
 	 * still in the list of pending connections or list of devices to
@@ -4220,16 +4255,6 @@ static int hci_le_read_accept_list_size_sync(struct hci_dev *hdev)
 				     0, NULL, HCI_CMD_TIMEOUT);
 }
 
-/* Clear LE Accept List */
-static int hci_le_clear_accept_list_sync(struct hci_dev *hdev)
-{
-	if (!(hdev->commands[26] & 0x80))
-		return 0;
-
-	return __hci_cmd_sync_status(hdev, HCI_OP_LE_CLEAR_ACCEPT_LIST, 0, NULL,
-				     HCI_CMD_TIMEOUT);
-}
-
 /* Read LE Resolving List Size */
 static int hci_le_read_resolv_list_size_sync(struct hci_dev *hdev)
 {
-- 
2.43.0

