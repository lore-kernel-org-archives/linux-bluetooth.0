Received: from mail-dl1-f65.google.com (mail-dl1-f65.google.com [74.125.82.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EF35CDF1
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jun 2026 04:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780461636; cv=none; b=YTdsAw+GQA2IRxnW1BozshsaZH/ikqu3UBMqDTWQD2SwJpRUPjOCVZWYJVVKFmYYmpANxAKbEGGz31nBunhzHv1XusnZxcgp185CmvgQnIQYRCwfvUJ8mHmIZvAhMw5hox5lMavkXrYCSIJmfofE59ybe5VcRJJbTjU1jkY3BaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780461636; c=relaxed/simple;
	bh=jbJB+R4ozivXYHQOOPDuj5qPhGaHKfeIF476MxWyL5Q=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cmDuMKvmm51Mp0w1hSMDyBogvIoeiNsgK74N6r1cayeKOuxVsorRaYV4cQ/lA9izhbWEx7jxDwozAQIsGANGuuOJmKAl1nW3V8UxgDQyLMPrJVZ3Xfnmkf0oqC8Bit8FVv9Cxg7hVtUh0MfcFaZilQtziVrtplXtSIA0OUjXeHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L0WC0o9b; arc=none smtp.client-ip=74.125.82.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L0WC0o9b"
Received: by mail-dl1-f65.google.com with SMTP id a92af1059eb24-1363fe80fe8so14972753c88.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Jun 2026 21:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780461634; x=1781066434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=YP63hiu04Z6Bd+ZfkWnYMNBnsF0xwtb8q+rYnz3wXwE=;
        b=L0WC0o9bVV1BxvKZeWtb9E7UklVK5+rXBhNz8Ze1P3Do2tJeX2IL2lNUBKF90zQyFU
         E9zWaBiX2M9NBM9aFHNblpdrKJdfyC28OLFI0vhj2NdyNyAHEkx+opSRJp1z3VkKQ1EO
         oQ304ODZPDOmtd6teV0xpYKIhktNOQrE+H55jrMR5RTQyRAHvuo4pOmAtLDG2o6Dx95R
         rZws0p7xtY2/cHIb0HWL/1gPdgptS/pGMBfk7O4hyYwmfsO7UUc21AJlIXcG0kceKVaA
         Rm7Bdjm+rpweRQtb5U0bJZXh5Ej9ZIGkntWK9p1ylJaS0gQIW40mslSjQILdWCSoTxE+
         sGOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780461634; x=1781066434;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YP63hiu04Z6Bd+ZfkWnYMNBnsF0xwtb8q+rYnz3wXwE=;
        b=Mec60V7G27LMxJQk6K8voVWjcKTrIzzvB/MBBYg6IObp1KhUfCaV4Q3CAbDJrjZhYz
         E10e/v4bCtObOqxwuxxewD54YHHhklHHD7QkEb89y+DLGFpmcT1hhCbfNpRpwXDhHFZY
         3CdH0V2UJb0ecmCN0bRJdVykq9mRaqUI7qiIyRLgoXi9mvO1F7NvbrqacOtVEVnF72/q
         +vAflVr7CCbhz6wUb3UOBJ34Udn1jNs7aukHth3CWLVifZKXKfafKmOI9EqNRqG1dMpL
         g7MopyfQC07iJaGHBIm0yAirPiyi9A6RmG4WP2bEKqtsesVASozlOWCTnpnsOzntcN2W
         it0w==
X-Gm-Message-State: AOJu0Yyzz69pSONPnARUwTP/SyiOAqI8paVXWRD5JJMRjV86hBbmVCND
	lpqjx7iqxyTHvw8oXOAUZAyF/cZH7VRPg50hh6N0bIVFsZjT1rZzPm+gQrx8f5Iq5BRm
X-Gm-Gg: Acq92OE0S1N6Y6yxdc6YaGQTmqGqkDdtKY0GDNztR4oVl40SbyQnwzNfgiLVNf+kfdt
	9jW7LlMGefNJiLg+KPRlplTrGp8kkQ9KQoyOKkKDOXj0JL41lgV//WnqKeH79+N4FxPZHWGM7ie
	/K5ypCybF+e/mbhx5sAheia54m2gMc7cR6UtluXi46T3P62yjC1njbXG8w3IwA/OeggOuQWN13F
	ivVOaUx92GDAZU2nuPHFx8Yq6zUgKI2o1TuxsKzGF0MabmyqNqgbBKeUtwlyDWeIs+D5XVFsNlb
	/VkK9kQ2VKyMkgi/MH0EceYi7tPyI4wTWi4TcQuL9BHpeFvFTSPxbJ/Ui3IJJ2uxnSUCmdZKHiH
	bzn5Cos8UE1qieL4QPyHzF8cE1n5QKYMMPxMNhNX3xOBS4PYDBDYS/f8xQT015ZArG/P8sPZwZc
	YM6xufd8iq8imYyqXb3P+AnDrZ+kUUUsdb6HMv
X-Received: by 2002:a05:701b:2918:b0:133:1d3d:f93e with SMTP id a92af1059eb24-137f6bff151mr240434c88.42.1780461634153;
        Tue, 02 Jun 2026 21:40:34 -0700 (PDT)
Received: from rainbow ([142.147.89.221])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137f549fa04sm1180687c88.5.2026.06.02.21.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 21:40:33 -0700 (PDT)
From: Jordan Walters <jaggyaur@gmail.com>
To: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] Bluetooth: Fix Use-After-Free in hci_unregister_dev
Date: Wed,  3 Jun 2026 00:39:25 -0400
Message-ID: <20260603043925.228091-1-jaggyaur@gmail.com>
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

In v1, the timers were disabled too early in the teardown sequence,
which caused deadlocks in CI testing (mgmt-tester and mesh-tester)
because the HCI teardown process relies on these timers to safely
time out the HCI_OP_RESET command.

This patch adds cancel_delayed_work_sync() calls at the very end
of hci_unregister_dev() after all teardown procedures have completed,
guaranteeing the timers are fully flushed before the struct is freed.

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
 
+	cancel_delayed_work_sync(&hdev->cmd_timer);
+	cancel_delayed_work_sync(&hdev->ncmd_timer);
+
 	hci_dev_put(hdev);
 }
