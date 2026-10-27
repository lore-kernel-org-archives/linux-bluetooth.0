Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793119910;
	b=neshPzpUYk4hv/C24B+c3ItayUx2jMTy+L3aJNUorvrH0kcyqXp70O5adWiXY0Xd4Taa
	 +CnBfVhvIgME9qsfMEUPMyLBdMxmCIPzKDVJPv38vGKvtloXVeGf4zlH0nBLf5dWbLVsg
	 8HvOvP6Gnr1D+MREcDK8tDnhYXxP7JJNRfPXqGiKwwTzTuYyFYy1FE6JBVtVBd4LWjJE7
	 VIyj4o43bZgDJe6AlwFRloqJgqHPAJeLipXz6+r2fNuTYo1dOPC/GagnmeNhMrhVcjlnF
	 EoblsYSpSzlhoecc2OWgvuTtq9AIlQreODILaKAE0ygEFPu1KA7d2Ci4UceHzCF7O2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793119910;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=aAVYI7hzWz0Ro36eEs5zq4Y7AqRKeB23+7GHTzj26rY=;
	b=bYg1iLY6hzsqfPnJkbbwdbNKPoBJiK5jjA5M75DjmExcgLxQ5i6azphQQxtw/uvJia02
	 fbFr3iMNPaZGKnWLPG48aNJ518GQCQLUaMjBKzUeDiCIk8iaRbS7s9dDS15OlFYfq3Lsh
	 lJ3BspvB45rJZuaMB3cJkQTck6tj9ycrYpUY1cJKeqJCyMb6e7oliEceI9yGzyo7XJwdK
	 i9v7JEyQIOSFo1jRGCt8FJs7xbJhGyozROf4Xch8Qc+b3U0RPBaPyt80nDEF1jkpTngoZ
	 nvHybexI9+LeOvPvL1b2T5jfqnHOIdrr9N1U/0zmGva6jba2B3zqo+SH/qycrPF3eGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simpleble.org;
	spf=pass smtp.mailfrom=californiaopensource.com;
	dkim=pass header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=avL7x7D3;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAEB606A31D
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 16:51:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EEAEB606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simpleble.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=californiaopensource.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=avL7x7D3
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1a3c08d6928so20615c88.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 09:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simpleble.org; s=google; t=1793119908; x=1793724708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aAVYI7hzWz0Ro36eEs5zq4Y7AqRKeB23+7GHTzj26rY=;
        b=avL7x7D38BpE7bqjyGyVziff6PpmnBwDe9Yl1ufs/u922LMszIu0XxXweYGggEmAHr
         IM4w253lGOHOZ18/tKqehpt9vhoo+CXlPgMy0Eb9xpohhEuyML5xOs/dTndSslEU13zh
         bomgeHyT0/nPzCz/RrUtu6O8Ax4LJgXBm2fX0aZeXP/UFa6bRZzuhMXPA5oviyJ7fxYj
         tHsPpdHQlNzKFV1A2P+QB+kG1uXUY90i5Qgo3iHAWUEh8PhKfng908FY4i59d7QGtRth
         CYBKItmyf1J9aq0NhyyhVmTOU/GFKbWSy5ed8e7zMeLueaAUNP6TYsHTowL4Kv3WDqIC
         92Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793119908; x=1793724708;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aAVYI7hzWz0Ro36eEs5zq4Y7AqRKeB23+7GHTzj26rY=;
        b=H+zV+33uwLzoLbxEmB+9bUHl2CHHBb3/j9XOqdhpp58k3YHkTF6DDn+/dclaKnH0O1
         4epO6bypicnZ+zvH9CoAwLYx1vTJmOaRERaGsaE6Yhu+YPuDEiWPXGs0FraghUaal6Wg
         qPijUXawngNwGaPmseveuxlWYt5IqlQfYxBuFrHQXvYnFiyXCm3q13lcHTSIcqFDMsP3
         Q3s/QR6N77xH+Ed6ZRjHCMCYkBt3WURmFI+kmS2ia/5K4Gu75R/iaSe32xaZYckHs8Gb
         7bD7UGNqAhZ36P5y6D3GUbx3DBRYNgyxLkdBNY//mnRg2swbe8THiG6aV9nJkuS/xODc
         sJIg==
X-Gm-Message-State: AFq9FYLdpXtvZurmr8/l4zcBn6wDc0hqqVbqBOABSnGWlDms8907SAcp
	cAx8dk0Nw37qN2oWbf8i04kSIrnuYRiXgPm7NcV3MMF4any93GDOkZXQzeLL6MF/AJk20JHhkwW
	L+QOOrd8ttg==
X-Gm-Gg: AYBFou31u+lWBfFF+U8ToAcGJJjGqZEhqI2n0PjsHvVKznWJHH4KIbkmVZd8soULaq7
	JC09ztNhf3mxUfCtSoj+mVFbx9XwKxiczWjJM50OFSGmJl/Cc4buJQTHo2qp7D8/hnK+GvT9wtm
	aH9M4T0JmCXrg/kRVkQ9sRHuIW8oRztXUgBIfMHQm0YGHkCBvBxb2F3hfApSm587gvOq0BwVP3v
	ubuE727IKZqPdg4txCY2wftRZB9eLDIJW2gQsjdKhqMw/ZhgytNL4Xhd1ZjGYI9Zk2P/JFJEgQn
	xVfVPa/Wxyv3vB0Lh06eS2YgZiuc28Z+UULSmx0lVe/Q3w6Irg0lQFsvPiKqs2l0JfP9w/Ry8N7
	bJi8FFzfm26Yg/yNW+sD1uQZNuqqHKaQ+OaDOTqmS9eoj4FWo1lhydo59KAkXPo3HsAUamUFg1I
	GHRaYcYLU7aRo5lNOcWTOh85fJUmFK5Ct6SqB5FHbVgVEpgDR5SzXU/rbBT4kBrFi8/ab/Sfnnb
	alXYZBUYtGXyTgKxH47ML6ls2Z48AWCGplK6IN4JTJstSXXB69cKLRIyfnpDToUi/SdMPPNL6pU
	JM0NfEKcF1uwYUcwXX34u46Q/Bn/SGYoiGwfWQ7awnk3jcdFRIj//dkE63o1E+EQRJp+2pETs1c
	QAIvxfMDNIsEokEGCqY7vKw==
X-Received: by 2002:a05:701b:4209:20b0:14a:d8fe:3390 with SMTP id a92af1059eb24-1a631c9284fmr820274c88.32.1793119907564;
        Tue, 27 Oct 2026 09:51:47 -0700 (PDT)
Received: from localhost.localdomain ([147.185.47.151])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-19894d5a10csm34399611c88.1.2026.10.27.09.51.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Oct 2026 09:51:47 -0700 (PDT)
From: Kevin Dewald <kevin@simpleble.org>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-kernel@vger.kernel.org,
	Kevin Dewald <kevin@simpleble.org>
Subject: [PATCH] Bluetooth: MGMT: Fix discovery stuck after a failed Stop Discovery
Date: Tue, 27 Oct 2026 09:51:44 -0700
Message-ID: <20261027165144.75105-1-kevin@simpleble.org>
X-Mailer: git-send-email 2.54.0
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Stop Discovery moves the discovery to DISCOVERY_STOPPING, and
stop_discovery_complete() only moves it on to DISCOVERY_STOPPED when
stopping succeeded. When it fails, for example because LE Set Scan
Enable times out, nothing else moves the discovery out of
DISCOVERY_STOPPING, as the LE scan timeout was cancelled before the
scan was disabled. Until the controller is powered off, every Start
Discovery then fails with Busy, and hci_update_passive_scan_sync()
skips background scanning, so devices set to auto-connect are not
connected anymore.

Move the discovery to DISCOVERY_STOPPED also when stopping it failed,
as start_discovery_complete() does when starting fails. This sends
Discovering (disabled), and the passive scan update disables the scan
again if it is still enabled.

Fixes: 0e05bba6f6f8 ("Bluetooth: Update stop_discovery to use HCI request")
Assisted-by: Claude:claude-opus-5.5
---
Reproduced in test-runner with a new mgmt-tester case, "Stop Discovery -
Scan Disable Failed 1", in which the emulator answers LE Set Scan Enable
(disable) with Unspecified Error: without this patch no Discovering
(disabled) event is sent, the scan is left enabled and Start Discovery
fails with Busy one second later (3 of 3 runs); with it the scan is
disabled again and Start Discovery succeeds (3 of 3). Freezing the
emulated controller while bluetoothd stops discovering gives the same
result through the HCI command timeout. The other kernel testers pass as
before. Only tested with the emulator, not with real controllers. I can
send the mgmt-tester case to BlueZ if you want it.

hci_pause_discovery_sync() has the same pattern on suspend, which I have
not reproduced.

 net/bluetooth/mgmt.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 3cb4f9ece8..06595175d9 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -6322,8 +6322,11 @@ static void stop_discovery_complete(struct hci_dev *hdev, void *data, int err)
 			  cmd->param, 1);
 	mgmt_pending_free(cmd);
 
-	if (!err)
-		hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
+	/* Leave DISCOVERY_STOPPING also when stopping failed, since nothing
+	 * else moves the discovery out of it: Start Discovery would keep
+	 * failing with Busy and passive scanning would not be resumed.
+	 */
+	hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
 }
 
 static int stop_discovery_sync(struct hci_dev *hdev, void *data)

base-commit: 47d4d9f67e92d56ef3965f2727f9c98a5a611368
-- 
2.53.0

