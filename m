Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3C730B51F
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Apr 2026 17:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775842498; cv=none; b=H1XcYj+8hfVT8M2DkxVnsSDb/XZB+5Mf3YXpLpElUaFpnbq47Xi6+1DQR8AdXG871Eb0zJdxk3vBfGNA1lK4eTxCVC58Ff6FzSJg6BdwwITX3ATej5siat56wumBIc8DxAru6AxntzxmSF36FHOtoosZ9w/kGA+J68U/Gmth7Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775842498; c=relaxed/simple;
	bh=DYw7oNNqEGz4ESlBhGL7OiIoItzBIY1f9AUIG+wjyw8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b6rB86u0kp0PKN77ATLhNdwrBea2YTxdaYb+59mQ7C3QTutYSj8e7wCYPtJYgmkTar+/uHN7ROS7vCQLf/WZVAbhmjzPAnPXLSLHoby3MsQZYxjiCxEVYS27kIkaH4c9CPIWsH0wsFvJL6xFEbMnBuNINYrBXPb1wH7c5G2nhdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qlrp1ZP8; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qlrp1ZP8"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-483487335c2so25409235e9.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Apr 2026 10:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775842495; x=1776447295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/pLuXGk4XEx5958UjMrbFYUUsyqqJwTgYTzxJrMDu/k=;
        b=Qlrp1ZP87eQvFJUtSeKn0aBF76hRL/Wg6vLuntEvoQZ4IOpH5aFSSwxtEfzCyr/nFi
         /8aVSMunWwTOrwNDyDJ/PiNfnoN8uPRo2Qs+7z9qZm4/yFi08GuiMfUTyD0TzPGwufuv
         UIZVDUy9vftJkJlkKZsg0tUCnfu/AwdEaQXRS0gToUF/yXN2qAuhYOoMdbNzknz1kDtg
         Yy+DVd5KEX9g+HePRNRWrC2fmwN/dWiOqwL9+9j90d9/o4RJ2olSDJp88VWjubT1viOL
         RFgGiOus6uIbiTCEEdE+r9vXokIthR5+bdFPqFP2N9fioTedXfwO5eE/suthgfMW2tst
         s1Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775842495; x=1776447295;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/pLuXGk4XEx5958UjMrbFYUUsyqqJwTgYTzxJrMDu/k=;
        b=IpZoqJH/4J8Kv5hlP4U2XxqGXcNkPcQnWnney0ZRHwtVOEpOmN8eK+TDT5C3SCtMrs
         L1V6HHtmqreOohd4AHstSsdK3RR3t5TdjUHQziCPl8XFez768q6ou2WxqThQwvVwCTec
         RXO0cNM4n/sFIZqUYESoHxvZCj4/DATMlspxPVQRaB3MamrCOkF4ECFTOijsnubWERmc
         VS8cHnLN8p0qtlRTqgny0T8Ol/GAuy/P7loPGva+PxDNFztUSZG3wBMIlFKL6kIquQyO
         dGRtVl4OiF8F3Eakd+lrLCPlfzjhWyYxnkDZP/Ww0k/h0Br2cu5SMdb9x8gdnbuBZ2Rn
         al1g==
X-Gm-Message-State: AOJu0Yw+0Gtm3h4+fFfdYYsbZXd017IF8WJEqB96N7/JNYIJEjDVCUk9
	NQvhyngnyjtIJcDIbwahLRyJN+khKi6zUunFzCe3cwVKa+//tmuHgkfl
X-Gm-Gg: AeBDievu07coPHuGt87oaf3YamFq37N5YzVOAWQSl4eYyZMhxRTmXOi6FR9nhDMnK46
	s0BMopwM0380XQBbRoFbjR+qWZMWPj7Cy7Ho/EuTAWPpUFU6pnnxC3cV/N7Wv2OFWVYPug0vBE5
	/rvEeHESPE7f0FBVFiqaCYDgMSfqMa97tSGgMMZRHpOR851otfAP//JDiAsH9cQlT3qdLxOSkI7
	14kHV2A+IJ8LKFUl2bwj9yYZHIFJFBLqMiDjKHmzWjqMa2gXKPz4b4/Sf6jWaFjXB6l2v92Svl+
	Ibn6pa86BmyVVYJFaxWuJBumApDhrbsUf1PllOB6wSSg7CQrEiqKoXQuGRUMI+zxZp8zWJGjWCa
	cLVXd9nGkhAWP56zXbRxDHLfkS/bjvh8Fr/wiT5Zd3CDTr6LsN6s/p+VYQtqQEXtf9N2MJgqkKI
	ThaJfmE8FHhet2bH/irE9dar2xKjZQPtufQW4FgtgXOGrA7oqc0Ojdscy2zG/td7E+O0w/dxaOA
	MUKJAkTY2er
X-Received: by 2002:a05:600c:8709:b0:488:945a:ed63 with SMTP id 5b1f17b1804b1-488d6655adfmr58259555e9.0.1775842494835;
        Fri, 10 Apr 2026 10:34:54 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d531f229sm119327525e9.3.2026.04.10.10.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 10:34:54 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 net-next] Bluetooth: hci_conn: fix potential UAF in create_big_sync
Date: Fri, 10 Apr 2026 18:34:51 +0100
Message-ID: <20260410173451.4797-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add hci_conn_valid() check in create_big_sync() to detect stale
connections before proceeding with BIG creation. Fix
create_big_complete() to handle the resulting -ECANCELED error
and validate the connection under hci_dev_lock() before
dereferencing, following the established pattern used by
create_le_conn_complete() and create_pa_complete().

Without this, create_big_complete() would unconditionally
dereference the stale conn pointer on error, causing a
use-after-free via hci_connect_cfm() and hci_conn_del().

Fixes: eca0ae4aea66 ("Bluetooth: Add initial implementation of BIS connections")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
---

v1 -> v2: fix create_big_complete() to handle -ECANCELED and
  validate conn under hci_dev_lock(), matching the pattern in
  create_le_conn_complete() and create_pa_complete().
v1: https://lore.kernel.org/r/20260408155638.95927-1-devnexen@gmail.com
 net/bluetooth/hci_conn.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 11d3ad8d2551..feebe933efc8 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -2130,6 +2130,9 @@ static int create_big_sync(struct hci_dev *hdev, void *data)
 	u32 flags = 0;
 	int err;
 
+	if (!hci_conn_valid(hdev, conn))
+		return -ECANCELED;
+
 	if (qos->bcast.out.phys == BIT(1))
 		flags |= MGMT_ADV_FLAG_SEC_2M;
 
@@ -2204,11 +2207,22 @@ static void create_big_complete(struct hci_dev *hdev, void *data, int err)
 
 	bt_dev_dbg(hdev, "conn %p", conn);
 
+	if (err == -ECANCELED)
+		return;
+
+	hci_dev_lock(hdev);
+
+	if (!hci_conn_valid(hdev, conn))
+		goto done;
+
 	if (err) {
 		bt_dev_err(hdev, "Unable to create BIG: %d", err);
 		hci_connect_cfm(conn, err);
 		hci_conn_del(conn);
 	}
+
+done:
+	hci_dev_unlock(hdev);
 }
 
 struct hci_conn *hci_bind_bis(struct hci_dev *hdev, bdaddr_t *dst, __u8 sid,
-- 
2.53.0

