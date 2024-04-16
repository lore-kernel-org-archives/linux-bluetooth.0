Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44181386AC
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Apr 2024 19:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713297252; cv=none; b=qs9In4Dwkmsa4YJN5jzOY7q/+HWC4/4R3JfIPkCq2rz7tpgFcopIZ8vqqf9LTh+1a8k3h+RDdt9zsIzC5u0l/HtNr9KhP7QSzgI2hzE9l9qAc+0cTjZ6nQbGFaY+KmbPsdnSdCfcVe1t9B9Wn5w0D2O7T8Zg3ulo58FAuxuvSq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713297252; c=relaxed/simple;
	bh=mcGMf9dnW1ZVnyy0HmEUCuqnX2LRmJqd3trb1lOwR7c=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=F4UJAA68EOFOrOiO7Yyh6MAzdqxJlIQT54gUtVc1/U33NObQ1pt/kRuDNIOzCYdt6g1hbK8LmHtRZ+UA9fliOGeoa5pL5Eos8ewvcqgGN5mZpESdCBu/67vIedp0KaEplSCA7/r7MeeJcfn+OZAsgbl3WON5AtyMjY6ZRzFXmJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JYBIlBAP; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JYBIlBAP"
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-479ffac091dso1648474137.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Apr 2024 12:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713297249; x=1713902049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=qIzFuZzNE61yUFVFZJeazlvytbdmPIliVOvYXRTlOfM=;
        b=JYBIlBAPEPv/EQfiHCt1gTVzG3W4rg7qwKh/jvw/8eldiKaX/70tCSowCyXNv5bLqm
         T3GlKClYcCtQ4E5laI/r7m0RPcH1LZoFUwU6w9WxlykLVwfHjMOE0E9Ry7rzlYQInum6
         T0NfwZ/K686W6Shhr13DqmOiW+l6DE7cZ2v91lGvRsD+gq39dpaW0KVX0s6/sQL5FF75
         KGbkfmKXezOAqC9iMPG9d0qkq0i3SMehM6osHmLTUBZ3suIu2Vt/OlocCIojt6QrOMqA
         HOemNZP8xTftQwYtY5NOJV2+qfGbgAoYO8OWtXovLD7QFMgOTHtiNIweYNt5PMZ09UJg
         gKgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713297249; x=1713902049;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qIzFuZzNE61yUFVFZJeazlvytbdmPIliVOvYXRTlOfM=;
        b=SX7tk6ISyJGnUvGvp1ds9OF52aYjkUlVDDUISSftb04CiIf3y0Z9OsRQ0lqI0/CWwu
         uk1b/hdGne5m/DgNMMlaG/tURNAC05IZC37DJD+jhQMrV2R9jnvklMezHKEcbgsIZrg1
         uWTsgh01XI5ibTAYBLCoJ8BFcGOOqw1CuYBclZ9aqdVVOGhKBI6kpNlJBj6LrKIRJ9HB
         io6C9XPC2PvGW20DImGOoRUpE8ZhC3ZozFb2pyiPvNJq2fuedjLlLOpTBbLGoosaBRDi
         sEUrCUgsocJ53AMufRi34roR9oxfKAkB1XLy+b2ID/yUp8IvkaIrMmJt3iZkNUMWuZ+j
         xtVw==
X-Gm-Message-State: AOJu0Yx67EfQbujrK48liWyyqlK1svbTWORbwUIKllAf/oksFTOjqGjU
	3AZcNMrZT7ak3M/1C2Ili0dsvGhrVmGLkWKXVjA/dbsH9KXNeK/k6VdSyg==
X-Google-Smtp-Source: AGHT+IGYI98GDo6nC+XTodtlo/1kbSvXYXbrt7ze3Szh4y5sJ2m6d6R4ypVTcyXbGFPHQaak1H5dPQ==
X-Received: by 2002:a05:6102:41a9:b0:47b:6718:6c34 with SMTP id cd41-20020a05610241a900b0047b67186c34mr11804638vsb.23.1713297248983;
        Tue, 16 Apr 2024 12:54:08 -0700 (PDT)
Received: from lvondent-mobl4.. ([107.146.107.67])
        by smtp.gmail.com with ESMTPSA id h13-20020a67cfcd000000b00476d2a0cc1asm1785953vsm.8.2024.04.16.12.54.07
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 12:54:08 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: MGMT: Fix failing to MGMT_OP_ADD_UUID/MGMT_OP_REMOVE_UUID
Date: Tue, 16 Apr 2024 15:54:07 -0400
Message-ID: <20240416195407.1153243-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

These commands don't require the adapter to be up and running so don't
use hci_cmd_sync_queue which would check that flag, instead use
hci_cmd_sync_submit which would ensure mgmt_class_complete is set
properly regardless if any command was actually run or not.

Link: https://github.com/bluez/bluez/issues/809
Fixes: d883a4669a1d ("Bluetooth: hci_sync: Only allow hci_cmd_sync_queue if running")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/mgmt.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 7129e70a0253..68deec968405 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2623,7 +2623,11 @@ static int add_uuid(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 		goto failed;
 	}
 
-	err = hci_cmd_sync_queue(hdev, add_uuid_sync, cmd, mgmt_class_complete);
+	/* MGMT_OP_ADD_UUID don't require adapter the UP/Running so use
+	 * hci_cmd_sync_submit instead of hci_cmd_sync_queue.
+	 */
+	err = hci_cmd_sync_submit(hdev, add_uuid_sync, cmd,
+				  mgmt_class_complete);
 	if (err < 0) {
 		mgmt_pending_free(cmd);
 		goto failed;
@@ -2717,8 +2721,11 @@ static int remove_uuid(struct sock *sk, struct hci_dev *hdev, void *data,
 		goto unlock;
 	}
 
-	err = hci_cmd_sync_queue(hdev, remove_uuid_sync, cmd,
-				 mgmt_class_complete);
+	/* MGMT_OP_REMOVE_UUID don't require adapter the UP/Running so use
+	 * hci_cmd_sync_submit instead of hci_cmd_sync_queue.
+	 */
+	err = hci_cmd_sync_submit(hdev, remove_uuid_sync, cmd,
+				  mgmt_class_complete);
 	if (err < 0)
 		mgmt_pending_free(cmd);
 
@@ -2784,8 +2791,11 @@ static int set_dev_class(struct sock *sk, struct hci_dev *hdev, void *data,
 		goto unlock;
 	}
 
-	err = hci_cmd_sync_queue(hdev, set_class_sync, cmd,
-				 mgmt_class_complete);
+	/* MGMT_OP_SET_DEV_CLASS don't require adapter the UP/Running so use
+	 * hci_cmd_sync_submit instead of hci_cmd_sync_queue.
+	 */
+	err = hci_cmd_sync_submit(hdev, set_class_sync, cmd,
+				  mgmt_class_complete);
 	if (err < 0)
 		mgmt_pending_free(cmd);
 
-- 
2.44.0

