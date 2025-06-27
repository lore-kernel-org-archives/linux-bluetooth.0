Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FB429CB32
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 15:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751037527; cv=none; b=atNNw9p6I0SMVb/DNJuloG70c7edrAleUTn8OGO7dlhVkIbZ7mlnQiDLYyu/zfesgveIe8StAhv/xpHJkuKm9JaHYHHs0D5yWrj6UpKp1mTi9gHwXGSYbiJGSwGP/dgSa2Opgazvt//epRugoRwfFRGXVOkXDgxZiZa56O4sRok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751037527; c=relaxed/simple;
	bh=HqDr51MgXWWTcV4+XbssjfKK/LAu22jZRGTSHKzTsJQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mozbyHBUkzIOB6NX6ijgG5WTPDGV+S9jtxWoKguiIH+P4VPBOsAzDQ6a6JwDBw7IrDdKPYejwadIbsDY/4lSCSMg31Feuwyk7DT4WQNhpjGOHSCgNzIr3NjYIgSs1+CwJv42MUBDRlIicgztXqLzZVgxUOLHIhQB0b+qlBM7oGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZQJt5kTB; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQJt5kTB"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e7387d4a336so1997167276.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 08:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751037524; x=1751642324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pzttEAUdJp/JdFnz3V3+qkY752ni2dQTUPldaAuEhUw=;
        b=ZQJt5kTBnwotut0LrM4NocDup0CsxmMxFuPoe8gsoqIAZNdx9alhUzcoHnwjluPRz4
         G+AYdm55y3/mXiWx1OG5XjMQFEPmGf5q/Io7WpaXaguqFTNJB5bXBrTrgDqnAR4T+dP3
         jtuZJYGg/NTs8xYlwh2jDm8BdSgJ5fdfTu6myaCBNR6y04npY5vfZ4PjF0je+kAASiBB
         S9cLwCcPdefzJyeTz+tvFPcjCwap2OOsl8ie27xLaRVoqZA2mMIhVoeEmUudSLpl2MPE
         Aqq/Jwzji/E8BF+xVvDK8CDTRIWC+FwGPWqRf4YnVgl0CzLQeaYnFvRExq3KeXMhOIBu
         a/tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751037524; x=1751642324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pzttEAUdJp/JdFnz3V3+qkY752ni2dQTUPldaAuEhUw=;
        b=Xs/OUFpGLUsKf/m6qcNiZOMvUMw1WOlt0k3vJBTrG7CcsndXZ2AUI6mJji77DiBx/W
         +csm3llSFvJVz2fMI7pShmRpFbr3lBARFNJQERbLmkAPQ40fM2sTr4/6BB7oKqfRVh2u
         4U54Pru2l4n0LSavzxZzplIP7jt2FTgB0+zX3QctSSm8otgyvUs0KXLMRkGJf9qyyoLn
         Linal3gr1GPeaT+0Sg1bcglNAMF3Y5njwMvcEd/Y9QxYAO55AZVdU6gLCcFOXmUE2zMX
         8+EQ4Yo/t1IGAn/dCYvn0+wtougckAQosDev3PmNfD6l1fdO5sayQQVNnNgqD2jcQp4n
         OMzg==
X-Gm-Message-State: AOJu0YxllOtEM5086emP431Hfp4h6/rXppO0sk83Vb5H2YLOyFZ78DRs
	pakABNTZhLKE0RcdqZSbpMx2FR2IRKgVN3oAODuC5/YVgo+VzKiqVNdpvk4dypI8
X-Gm-Gg: ASbGncsSR0mSTbe+rpcZzQ0h11eBT37Sfj+PlCDY8p0m8oGGxVdcdwgO53iy2s8ltb8
	h41gnEG9osn6nDGnk4k3W7Sd7rCSEI2ou3BtGO2atAHzrnBD9GyUG11JM3pHNrK/28f1ub2SoRZ
	KjnFYcM8nzQu4FePbzpx7YoDX4+803fCswnXQisuRU+Q5yVLnFOuGxRDjol4VJ+rNDIh5GJuawF
	JvF/FPTPLnO7uvl5tpyVgGTvSKHUjihhUJoeaxDEKikpJ7LZtWs7fhjmg2dcvSdV2xPYhucsW/a
	mOdX6RUkznVCG+/XAWOhsvxrVgIe/B7SyelvCSPJHda73DmDuEKScfjv6cKXKbvQCkpu7o8FQ16
	HAI+H4mfRdbvpitky2zRYjwKZ8yW0boc=
X-Google-Smtp-Source: AGHT+IFfJSzdvOjuOH8+oYQrUEPzSdH17njU66I03PxHGXFns5e4s3qkD8lzZunlCBDcZVO60tVTEA==
X-Received: by 2002:a05:6902:100d:b0:e84:2a41:481c with SMTP id 3f1490d57ef6-e87a7b47a34mr4024999276.30.1751037523725;
        Fri, 27 Jun 2025 08:18:43 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-533091c252csm407318e0c.27.2025.06.27.08.18.40
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 08:18:41 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1 3/3] Bluetooth: hci_conn: Make unacked packet handling more robust
Date: Fri, 27 Jun 2025 11:18:31 -0400
Message-ID: <20250627151831.421443-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250627151831.421443-1-luiz.dentz@gmail.com>
References: <20250627151831.421443-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This attempts to make unacked packet handling more robust by detecting
if there are no connections left then restore all buffers of the
respective pool.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_conn.c | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 23ea56031dff..6ed69a4b01db 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1139,22 +1139,42 @@ void hci_conn_del(struct hci_conn *conn)
 	disable_delayed_work_sync(&conn->auto_accept_work);
 	disable_delayed_work_sync(&conn->idle_work);
 
-	/* Handle unnacked frames */
+	/* Handle unnacked frames:
+	 *
+	 * - In case there are no connection restore all buffers to the pool
+	 * - Otherwise restore just the buffers considered in transit for the
+	 *   hci_conn
+	 */
 	switch (conn->type) {
 	case ACL_LINK:
-		hdev->acl_cnt += conn->sent;
+		if (!hci_conn_num(hdev, ACL_LINK))
+			hdev->acl_cnt = hdev->acl_pkts;
+		else
+			hdev->acl_cnt += conn->sent;
 		break;
 	case LE_LINK:
 		cancel_delayed_work(&conn->le_conn_timeout);
 
-		if (hdev->le_pkts)
-			hdev->le_cnt += conn->sent;
-		else
-			hdev->acl_cnt += conn->sent;
+		if (hdev->le_pkts) {
+			if (!hci_conn_num(hdev, LE_LINK))
+				hdev->le_cnt = hdev->le_pkts;
+			else
+				hdev->le_cnt += conn->sent;
+		} else {
+			if (!hci_conn_num(hdev, LE_LINK) &&
+			    !hci_conn_num(hdev, ACL_LINK))
+				hdev->acl_cnt = hdev->acl_pkts;
+			else
+				hdev->acl_cnt += conn->sent;
+		}
 		break;
 	case CIS_LINK:
 	case BIS_LINK:
-		hdev->iso_cnt += conn->sent;
+		if (!hci_conn_num(hdev, CIS_LINK) &&
+		    !hci_conn_num(hdev, BIS_LINK))
+			hdev->iso_cnt = hdev->iso_pkts;
+		else
+			hdev->iso_cnt += conn->sent;
 		break;
 	}
 
-- 
2.49.0

