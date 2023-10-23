Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD70C25B67
	for <linux-bluetooth@archiver.kernel.org>; Mon, 23 Oct 2023 23:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbjJWXiq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 23 Oct 2023 19:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjJWXip (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 23 Oct 2023 19:38:45 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B2FDE
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Oct 2023 16:38:43 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6bd32d1a040so3861871b3a.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Oct 2023 16:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698104321; x=1698709121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ndh89zcQFgKzWc/18mb7lQWoCl948jtv7vQuR09UCMU=;
        b=eNvpmHzdKoHCvkorUSOIV5gopjACMTytam0Ja/j33Op5XilGH6M/vVbqK8mmbVwZvW
         ZSlgvqaozjRLC5RTwPXow4lFmQSuODHRd2rRazaZlUcDcPsfBEr7T3pXxyUi4tWByiK5
         HVSL9p48il2JVLsJgqINYrN8ksi4u7CmvTq7LhfcJXdwyomiT+nWQLFdz2VD6zMA+h5O
         HWgdemPDJjGyhyOjc/VVPDTQvUrZ9y2U2zSwWxuAM0NqYVhOXpNZdEkQoD52jUyqmfAT
         SBi6oRC5286UT/tl97w+TY9dJppiUeQV2rtkvCHsRL+KA3SUZ+EbV/Q0oOPdLuXb8qCq
         t0Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698104321; x=1698709121;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ndh89zcQFgKzWc/18mb7lQWoCl948jtv7vQuR09UCMU=;
        b=tOqL5uiYCHPd6xaXWPDlqvnzqJTmw0WWHVJo15PFfC9xfSpEotNkZ6LxmlnE6t6vFv
         XWmt/yWzR05fwk50alf9Etjl6Jm91SzaJSmUNkBnuzHTapIfoERWY5tLqoQE68UFUO42
         7Up5UeE1y71THE5f9IfDkPjVnr/IcsZqkVKimoGdtOdewAVA5vYmVCpec7/WtD3F3aK3
         P24TFonA+DXi1C0cW3xduPOfvPtdnVTS+78o9PdPMJGGNMqFCJ9FF8UXYPL9VfXVxxEa
         VmZ6ESv7MVcoEQTYbznMEF3xlu6BsMrYtdtzr7i82StXwwXbGtTrMnzQA/d3pNEAUAxX
         hA3Q==
X-Gm-Message-State: AOJu0YxkScggtf8KPV/eBvQJ49ii0SXMfM15hUlIs8DS/umpiFa+2sug
        Hbfp1j72Yt1JEDS1d03374Rj+XlGjboNfXtn9EQ=
X-Google-Smtp-Source: AGHT+IFroyQ0XbJMblHHvvOSS9nufEs1ThTiumAGk9z7ZhkRqAgUtfCUuxMS80+h2mUObL63MVjr2A==
X-Received: by 2002:a05:6a20:da88:b0:17e:2afd:407f with SMTP id iy8-20020a056a20da8800b0017e2afd407fmr1478947pzb.9.1698104321512;
        Mon, 23 Oct 2023 16:38:41 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id x4-20020a170902ea8400b001ca222edc16sm6441316plb.135.2023.10.23.16.38.39
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 16:38:40 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: Fix not notifying when connection encryption changes
Date:   Mon, 23 Oct 2023 16:38:39 -0700
Message-ID: <20231023233839.3700728-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Some layer such as SMP depend on getting notified about encryption
changes immediately as they only allow certain PDU to be transmitted
over an encrypted link which may cause SMP implementation to reject
valid PDUs received thus causing pairing to fail when it shouldn't.

Fixes: 7aca0ac4792e ("Bluetooth: Wait for HCI_OP_WRITE_AUTH_PAYLOAD_TO to complete")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_event.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 0849e0dafa95..5b6fd625fc09 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -820,8 +820,6 @@ static u8 hci_cc_write_auth_payload_timeout(struct hci_dev *hdev, void *data,
 	if (!rp->status)
 		conn->auth_payload_timeout = get_unaligned_le16(sent + 2);
 
-	hci_encrypt_cfm(conn, 0);
-
 unlock:
 	hci_dev_unlock(hdev);
 
@@ -3683,12 +3681,8 @@ static void hci_encrypt_change_evt(struct hci_dev *hdev, void *data,
 		cp.handle = cpu_to_le16(conn->handle);
 		cp.timeout = cpu_to_le16(hdev->auth_payload_timeout);
 		if (hci_send_cmd(conn->hdev, HCI_OP_WRITE_AUTH_PAYLOAD_TO,
-				 sizeof(cp), &cp)) {
+				 sizeof(cp), &cp))
 			bt_dev_err(hdev, "write auth payload timeout failed");
-			goto notify;
-		}
-
-		goto unlock;
 	}
 
 notify:
-- 
2.41.0

