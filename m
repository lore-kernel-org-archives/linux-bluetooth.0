Received: from mail-qt1-f194.google.com (mail-qt1-f194.google.com [209.85.160.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E66400DFB
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jun 2026 07:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780473118; cv=none; b=BYsyaqwXGlEb0PI8G645big5WxMiYU7MrhzVUWboj0s/pn9m5ETKSPsvYUktfm2XrfX4ljRXS78SVtfm5EAkams060qn9JeDA/SHvHg3Eemsw6gDZ0lh7sL8djbQXGMCEQXwjqx89fhhDp3fZ8bXzCzwfroSaW/unh3/YDePZ4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780473118; c=relaxed/simple;
	bh=HFQnlyGMtu6XnVNHtVmKaEi9Si0QC6+UMnDjK0T/lJc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cwDqOva/yO9+JzFDAiW7yV5+60KEdN5Y0CDORKIK76MaMpN3gCrRcw2XBugkpjvYja+X+U1TqMG5txlxux5+y8Upaafe7PdCIuEsGGiSxw6wT/qpnrVP8YQXHIWTq9zZv6Db6qh99Vdw3LmCWXNkG1QzcUsTR7cki7UUIAgkVm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CyUnk0dZ; arc=none smtp.client-ip=209.85.160.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CyUnk0dZ"
Received: by mail-qt1-f194.google.com with SMTP id d75a77b69052e-51758478240so15130931cf.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jun 2026 00:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780473115; x=1781077915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=FyGMsCURDgvAJb24/tJx3kSbx6+tiPPr8AW+9MPyDfk=;
        b=CyUnk0dZ12ymypXsDdyYAsrdil8JFjAAMoD448I1nYh9fQ+OsOTUDvr3jpE1X75+Sy
         hqdAOXom/Yfa2B8ATtDkxjpBoAcgqZVPrPWoXvj7bLuY/yCmM1vC6jU1a45ltKdS+ciq
         8cn6POHI2Dc3GWVK5wfIqsJ8pbaMc6DjgGk2uJOXWjzyWWxlNaKZEWB/3hJNlJ3hw9sC
         Pg39jP5z+q0iI64ns3RWPLBGPYgp7DgocF9Cvgry8b0BqMBo1/2Xje7AknyDf663Pw0C
         66utZ+gPoEhD4z+gcvtKwoNmLY3HiRC9f9C/8cnqHeFgyljoTJ3yxrZ5Y3GYPvYOwmgh
         42pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780473115; x=1781077915;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FyGMsCURDgvAJb24/tJx3kSbx6+tiPPr8AW+9MPyDfk=;
        b=rFREWusDrN1X78MLhflpY7w7V4fAbc/gFfS33zARYrXqDkNzuDTc+hMrpSn0OilDTL
         ziOFton0aW5q7B6O+cdCt1Xw8obwYGW5vdPCrpjF8PTudQ+pvc2jbHFZq54M8h3WGEtJ
         4QLcwWLCgGochLdni1ow4FApFdhs+f3uDK+QTMfmXupoHnZjU8DA6MDKvJTYudCbAPk1
         mdEmKFSLgBoH9YZ1FjV1TOIDa1DQFic6J6I7tKmW5IPbcJ0fA679RkK5N1bv+akF9eoG
         htTx1654TB9idYXLSGDSDKhh2Yc6pLgZJhxuLpQSTMqhGb6E4ZzAyKgsj6ThNLEoy7aQ
         kdqg==
X-Gm-Message-State: AOJu0YxuDC2xl56r7++joGBP1fO7bHoj2c/sN1Ic6nepksmrFWAPJxEk
	gqy2bO2fTWzOE0xYqLMZVylP9q+S7Wa8xnwOcXm/s0q9n5vjdb6ImkWzBpEHICleDOoc
X-Gm-Gg: Acq92OE/Y4j/ZD1rwNF32l5GyF6vXguiGXlJe/ifeCKYIs64OhFxmo+6x26t0siFihI
	pSBJwnEynKA2qg8He2YJd43CqCE5cG0n2FHPDOOwzCM4sSRC4lMSPpnxdLCri2YCf/GTG2KPFWv
	eAhlb5BQb4Inib2Y1/br1MVOhq42C7LQR2rdtVWPhZbi4cHMjvBR97gMSuojWWi5afdrto8/M8S
	+uJrzn+WgTD7NYmMDRsqA1XRv/Nb8F+K7Vs8jheKMjYORPgxtTZn98Xac6YVAPv+R/sBmYWn6aQ
	oE3I+/lg1Us4jj88Qz0TKL3MqfIY/XD/hh1i8T63SSO/IBuIPI2Sf+bHeIfwCQjnvQHlypbWisx
	wPUefQDwjh4GAV3uS7Y+5kNWR4yPOlYyJWuyp9la6deq3mAey9aoKQ6pHefxbVrXi1Z7Bv9mSxR
	myiljaTsrBZxoiG9r2Eld5XmL2zUlBZWUyRflukrTUd91cDIgfmaLmqWEub8TUC38HrwBR3rdOs
	A==
X-Received: by 2002:a05:622a:8c1a:b0:517:5969:570a with SMTP id d75a77b69052e-517786ca1d1mr32082341cf.43.1780473114673;
        Wed, 03 Jun 2026 00:51:54 -0700 (PDT)
Received: from rainbow (static-68-235-46-233.cust.tzulo.com. [68.235.46.233])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51775a2f5d7sm20292101cf.0.2026.06.03.00.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 00:51:54 -0700 (PDT)
From: Jordan Walters <jaggyaur@gmail.com>
To: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] Bluetooth: Fix Use-After-Free in hci_unregister_dev
Date: Wed,  3 Jun 2026 03:51:34 -0400
Message-ID: <20260603075134.246832-1-jaggyaur@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The hci_unregister_dev() function fails to safely cancel the cmd_timer
and ncmd_timer before freeing the hci_dev structure. If an asynchronous
event or timeout occurs during device teardown, the timer callbacks
may execute after the device has been freed, leading to a KASAN
slab-use-after-free panic.

This patch adds cancel_delayed_work_sync() calls at the end of
hci_unregister_dev() after all teardown procedures have completed.
This ensures the timers are fully flushed before the struct is freed,
preventing any use-after-free conditions.

Signed-off-by: Jordan Walters <jaggyaur@gmail.com>
---
 net/bluetooth/hci_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 28d7929dc59..3db1b3738b5 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2698,6 +2698,9 @@ void hci_unregister_dev(struct hci_dev *hdev)
 		rfkill_unregister(hdev->rfkill);
 		rfkill_destroy(hdev->rfkill);
 	}
 
 	device_del(&hdev->dev);
+
+	cancel_delayed_work_sync(&hdev->cmd_timer);
+	cancel_delayed_work_sync(&hdev->ncmd_timer);
+
 	/* Actual cleanup is deferred until hci_release_dev(). */
 	hci_dev_put(hdev);
 }
