Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9FF1DFCD
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Feb 2024 20:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708980784; cv=none; b=Qsfrfn/g+ViINVS/dETj1f2UxuxjEJKe3QzZ8MR5pqNGDSTimF6io+hpC4QmZ0CScmksxskZtNsNGVGahs4wN2+K9kqeuJ/n/B1VnD0Gf4v8XEhGZ+nHqj54K5ekG4HBC1TDyson3Dxw+bX9bPPcKcaB8QCbjoJAECpqeVQXPlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708980784; c=relaxed/simple;
	bh=yAwVjnii4gOdKjVBPRKqszUhbHC1xKlL80xFSv2WaF0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=mkreZwecPbAJgDvWA90UY/qoUYq71e6SCI//7e8zc0YGrnXlr2mAZM/1P4JrgrStAkFbpffJAGDfFk8hNeoiBsT6MZBGl/xhyGBFNKiOFxO8ykomtpDbljneYHpI7FSABbHOOKei/KaoiIOuK8txCrwmBZHvDGYJB/92kWJaoe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e4t8aUs8; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e4t8aUs8"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-7d995bd557eso2068350241.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Feb 2024 12:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708980781; x=1709585581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ef5cxWS/DHX003FFu3ZV3XHChZLsTqEMaAm7lSIlAsk=;
        b=e4t8aUs8l3u4Jssmh9B/LwQtUErGLg/A8C2fkpLMQShYNrdgiIU1CvIabg9wL72eIc
         u3pZkoZrCed17ENUagCWHHyAWICi5/DhjMJA07lXDAZembr4Ibd7oT2wvwdXZNBnpSdQ
         qNwuk23djj4v48qOLjHnNMPipUgMJpUzuRl+CI7/rOie53FfOUSjmtZ0WuHst6xSdbL6
         RLS5+Wgm6pw85e51T4PeD1AoUr75woHCP6oilEpHAVuQsfm9Mq0ItOWS8xfXUgq2gb+w
         cPNJrgnaDu7WHc8PGLoyZUVHJeXTHexrn/AKts3P2ZdnmVEL5wWJx+/HZCRNiWjK/X/f
         t7pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708980781; x=1709585581;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ef5cxWS/DHX003FFu3ZV3XHChZLsTqEMaAm7lSIlAsk=;
        b=JlVrFhAYw66I2fn9yEg27I4kJI0tDgQb3ZMSlPggqdosodSNK1wmHfeAIjiHequLVd
         elqwlg+QhkLYafEBCNTIY5OP4pyNW7MJ/K+Ry/5tX9gbiK9j8ldaddAdXpD9mNXKCL/I
         72GCxttrUnIQtdCayPh13Q8WNr03vjWSLc2UiJ/4wCKEoOwfRbvWSGPFcKTBwJh1SlpW
         82MGrVNRjoAu11ycPWL5J4l6Scl2HiNHpxoRP9nRlzRJ4AfBd6RV9RbhV/uRRIxVWnFF
         LqeAAv0EhNnXwOvMt5mzmaWoGDxlodl8b/KEB2XlpOIpoHfG8aY2OReXjJB/LU1qnX41
         euDw==
X-Gm-Message-State: AOJu0YwQYDg9Uj8dVhB8QhUotVsfadm7JC3/TG70GwGaZsiEVsqS7/Eb
	y1VH9/pdr+/452ofY/QZM1JJrdvui2sOm6EQgeN1O06bf/JC/PFEi3E1WZAx
X-Google-Smtp-Source: AGHT+IGovkOtfDuDowkV9AfIc7LPanE33ptM30EpAiEW2qlJm/nZjCziJJQHL5VijXdjVPaOn8RdIg==
X-Received: by 2002:a1f:c985:0:b0:4d1:3f5d:50d4 with SMTP id z127-20020a1fc985000000b004d13f5d50d4mr5031164vkf.8.1708980780207;
        Mon, 26 Feb 2024 12:53:00 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id eh5-20020a056122268500b004cc0afbce34sm722203vkb.10.2024.02.26.12.52.58
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 12:52:59 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/2] Bluetooth: hci_sync: Use address filtering when HCI_PA_SYNC is set
Date: Mon, 26 Feb 2024 15:52:56 -0500
Message-ID: <20240226205257.1671077-1-luiz.dentz@gmail.com>
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

