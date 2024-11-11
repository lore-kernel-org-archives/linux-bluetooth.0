Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BFC450EE
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Nov 2024 18:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731348876; cv=none; b=GUHZUpih6p95XPysLJlL35G8w6a3+pKYLYhkNcnXWbiwMjEe6o/ZyJL8AbwXDe0NP8y/nsFuPXlhcmT+bRnJu1162QGNgGRFkq6zerVt0lxwTa8pNnn5io+tgvv3b2omUzjFmcqwZSMCSX6b7kZqifkQVsPjKCvvf1zwrzLAxOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731348876; c=relaxed/simple;
	bh=O4ICGfK4C2d3hyKT+1bgcjfcJZQQg7193nvnTYMPIjE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=DKrSL0NWrOMwRwkMVZ/TFuSj0y4XGL2xn8y3w9PHUyDTJDMDxFzA0klzcjl5RsBKS+FE/0NolR6+u2v0bFl3z0Y34tdgKKzia9iFevqw5TN0QCe4MVN5QJfAArPwWMygwmTL41vWIX5rHarbzloStJpAMC1DhsMkv8Ijw95ALcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GDbCwxFA; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDbCwxFA"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-84fcb020503so3513344241.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Nov 2024 10:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731348872; x=1731953672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=OMlSFoA8L/sIxWzu2nmhkIxrw8FghzKXoC/QXgvI1Sc=;
        b=GDbCwxFAc60JrHgFDvcLNdOv9beNpX90WagLdNXS6nRfEoldE8/TySKaw25+lukN2G
         O2ACn62yhIs/fHfr1zj6j+R6f7KUnsW6oNwLJsvDwx6Bkczm/xYQMik+QQ4TiZYDu4o4
         4dnwGDcOGpuFoYbiw7umBTEqsXiEyxCk2LzzG+TUb8Hb0cWvW8/zPC6j47zAHRdx1RA2
         UUXD2PKz2IHW+Q+i6GO6Tq3do7Xbn064IYgKYpdfy5LYlIB24uCOmuQwLV+uUuJ9+QMg
         Sxe8wzPSUfscXOh6nbWniivvJzcQevrqtPnEr78aARW64p33pHgOgqhVNqA/kBZFSLPO
         L3Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731348872; x=1731953672;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OMlSFoA8L/sIxWzu2nmhkIxrw8FghzKXoC/QXgvI1Sc=;
        b=RZ3slLb/1ARvqIF38tXjA00FIGxv0P+y0QivBu6IaJ8LlZ25Ns1FYONCG38Cvq91lX
         ROVT4EwQGUjsHTxuHKcGfFSSkooqJb+IQnXX6VMF2saIYKHpq79HgehQz/+kYpTiGBDs
         T56F27R9EkQol4oHM5mOk+15sJ/XsGl100rtN6b/5lMECdOZFoz3XUKA7ieMHkdXYHZ6
         Nhu0NKCRLg7GtaG1wO7dzEw7VjoCAif+U54w5XbVTkSrtRTIo0tPeqylPnmP49WR7SQn
         fGTfsJlzEgN9fOkZQ8nSSS6eqEMPlgqyoMyJi4QrVE3zwck5ZcEpl16gIF56tFcpHLak
         OdPw==
X-Gm-Message-State: AOJu0YxEx0gVslCUrKmgZXitHf6ZQOXlMB/UKMSKouXHrDQX5+dH+Ksp
	6iZ32ZeDaUohoeuC4keiDD6H3yjYASWC40NJeZEzDeUD19g9WoSa3qQ4lQ==
X-Google-Smtp-Source: AGHT+IHXSfijZNF/G8+vtggGWqyM2chTgemp1Go/NEoJEmltimrZJPZWKy6Ebnm2INrtxqlZPFAxQA==
X-Received: by 2002:a67:e290:0:b0:4a4:87a7:88ed with SMTP id ada2fe7eead31-4aadfd8a381mr11532319137.2.1731348871997;
        Mon, 11 Nov 2024 10:14:31 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-85655790ce3sm1850671241.32.2024.11.11.10.14.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 10:14:30 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: hci_core: Fix calling mgmt_device_connected
Date: Mon, 11 Nov 2024 13:14:28 -0500
Message-ID: <20241111181428.726441-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Since 61a939c68ee0 ("Bluetooth: Queue incoming ACL data until
BT_CONNECTED state is reached") there is no long the need to call
mgmt_device_connected as ACL data will be queued until BT_CONNECTED
state.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=219458
Link: https://github.com/bluez/bluez/issues/1014
Fixes: 333b4fd11e89 ("Bluetooth: L2CAP: Fix uaf in l2cap_connect")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index f6cff34a8542..f9e19f9cb5a3 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3792,8 +3792,6 @@ static void hci_acldata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 
 	hci_dev_lock(hdev);
 	conn = hci_conn_hash_lookup_handle(hdev, handle);
-	if (conn && hci_dev_test_flag(hdev, HCI_MGMT))
-		mgmt_device_connected(hdev, conn, NULL, 0);
 	hci_dev_unlock(hdev);
 
 	if (conn) {
-- 
2.47.0

