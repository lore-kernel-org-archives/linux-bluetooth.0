Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D283B95F9
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Sep 2026 20:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788466900; cv=pass; b=Dz+B/nGwdeHvQtDtep6ymqfDC6Ajo43LfGYGEmYG02fbJ2mMq+0j20r7YF1EXJ4LmPeBT/o054JPTg0vXIxTP7dwnb2bGNVxXhkRtRc9YsMA0qjOSX7p5wbd0DFcgs7Yl5bmHr58d9Ed/pJdyNGOeKX+YANfNCdu4jsZlNiAJkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788466900; c=relaxed/simple;
	bh=Lf/AbGaGGUHsOyfzesdz/Ipd9kgcwblQEMlBn6c1NPE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cf0nwVz731b+I7/gRRzA+WqJ2OdsLc6Zou3OmXvd3ejyE1npnMH402E8bQ/ol/78XJqVTco+nPA1bKXsQIo52Drbdon42Nr68UlscPKMWLCpeJxb41qkDKUG2nsFVNIK+/Za/mYs3g2juHiYztYdQyIP7+xjXLRNVaXk+8+fBOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=rafP27/x; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="rafP27/x"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4hbWFq4VbfzyQZ;
	Thu, 03 Sep 2026 23:21:19 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1788466879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fyYq4EQAUMljtc9tlCagPDnqnhK/J81qzsJWcMjmZl0=;
	b=rafP27/x3lxrM77CoKM347Z1OUirlkmXAC2DpzMfrNMNs8LcH+0We+bNeYcqhtX82kL3oM
	SfJ8p3bSu49TJVtaPNjPuhC8TrHruTTsB12W7taLVXbw5/LfbNd0ODJXKNpeZPHCwLf/L7
	suoAmLHjMDxgID3GfIPm0XFSdj2QEMM=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1788466879;
	b=BYkO+kaQk/jFSJ/Cs9C2Zrxl49U8CYdPVPCRRxI3dq4e32ddRQtQ5niJaKhOgX2Kd90LOH
	wfN33MnK46VKCxGCWvifadSmBxmUueNLI/heWA4PrxUivz1NnpWtgXq9WkhVM8n7rgmXrs
	XqFPDx78NeoexHGauiRqU98ZUKTyI5M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1788466879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fyYq4EQAUMljtc9tlCagPDnqnhK/J81qzsJWcMjmZl0=;
	b=OEAb3T42qih10aaWqfYQCQz5ceuLRc8DudBvu5AREXImMOmthDu7QhXcPNTI89ILQcAL7y
	rBn6vUqdPEvCYV7clFMkw0fcO+8VAaUPE2jH4BIehGkaNS5vJHoyR4nPijj/e9RasdX4Yr
	IL9I5z8l14REiizgjdADyJz4Kyv4H6I=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ] emulator: btdev: fix inquiry_timeout() inquiry destroy
Date: Thu,  3 Sep 2026 23:21:17 +0300
Message-ID: <835710b340044363cabea364ab73d98ef409b6bf.1788466641.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

inquiry_timeout() removes inquiry_id callback, whose destroy removes
inquiry_timeout_id callback. Doing this from the callback itself frees
timeout-mainloop.c timeout data under it, leading to crash.

Fix by setting btdev->inquiry_timeout_id = 0 first to avoid the early
free.

Fixes ERROR: AddressSanitizer: heap-use-after-free
READ of size 4 at 0x7b9d9cfe0310 thread T0
    #0 0x00000049ebbe in timeout_callback src/shared/timeout-mainloop.c:33
    #1 0x00000049f270 in timeout_callback src/shared/mainloop.c:245
    #2 0x00000049fbbb in mainloop_run src/shared/mainloop.c:104
    #3 0x0000004a286f in mainloop_run_with_signal src/shared/mainloop-notify.c:196
    #4 0x000000402a66 in main emulator/main.c:261

freed by thread T0 here:
    #0 0x7f7a5e6ee4cf in free.part.0 (/lib64/libasan.so.8+0xee4cf)
    #1 0x00000049f591 in timeout_destroy src/shared/mainloop.c:226

previously allocated by thread T0 here:
    #0 0x7f7a5e6ef41f in malloc (/lib64/libasan.so.8+0xef41f)
    #1 0x00000049158a in util_malloc src/shared/util.c:46
---
 emulator/btdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index a53bd8252..bb4d55e74 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -1104,8 +1104,8 @@ static bool inquiry_timeout(void *user_data)
 	struct btdev *btdev = data->btdev;
 	struct bt_hci_evt_inquiry_complete ic;
 
-	timeout_remove(btdev->inquiry_id);
 	btdev->inquiry_timeout_id = 0;
+	timeout_remove(btdev->inquiry_id);
 
 	/* Inquiry is stopped, send Inquiry complete event. */
 	ic.status = BT_HCI_ERR_SUCCESS;
-- 
2.55.0

