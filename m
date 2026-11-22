Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795378527;
	b=KH7kjr0JjGN/NbA3DkvlRI1f+8ticv4+maWG7pdP/xB2Bcdn5Hi4+SM6pASTxHuqcZo4
	 tywKz15uwTU9QP4ulP84HpEUtIFzen60ByC6vkiGvUEOJ7zfh+LBg5dNRJrzw0elxFyNy
	 SW/aUH/kmHUAzpZUVxGrKUwswT28fEKDmyosrUSOM8hsykPcoqGcwNcxMgpHEgkvG5ekD
	 hdbrI2gNw6oNB0zYenu5IZGV1/BZemX4r5kMYWEGQG4XSaZc7Z/CsWyV1pGw4rFgJnxYP
	 s1FboYs1HvPTSa6XYbp+QD3AB3sY4QxhWfbLKBoIy4A3zl5Y4A/ad3nBwlZPJSA9dtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795378527;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=W/FP4mjTDcCLY4HxpXOsFu1A+aUvxayfSqVu/TYO4+Y=;
	b=qb08Pw4jPlEeEMyQjE8Tl8K3ZNpgySckXHyj6+RCae9lT2DA2bxXQSsj5qFK58v7wSzx
	 T2wSk0CLENNcvJbT56yHRGzWQQaMU7tP11SZzwN814PPiy6suIU8Icc/j9g0IKrYfHKuO
	 9WStWZKFPXqSskrVRWYqLziVsS3stR/CO5zf9/OPSV8bsHg+uQqTBQeNGUafv5zrMAGEH
	 72p3uz/BKMof2KEQInZp3lhAul0VTISRICoAQ/yeoEErcXlTlMhLFeK+pg0jZE9GIJD5q
	 okwigTnOX8VoNSiDdNsNEjVbFUAUa3k5OozFGVxdbEg7d9t5+E/AYbIq081ulIw3sjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b="P41Yi/AD";
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A29606A31E
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 20:15:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8A29606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=P41Yi/AD
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a9a8d6cea8so31935205e9.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 12:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795378525; x=1795983325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=W/FP4mjTDcCLY4HxpXOsFu1A+aUvxayfSqVu/TYO4+Y=;
        b=P41Yi/ADKKTqKOjaN9Rcp+B+lIoALKlPxR6tE7IjeELHQmy4Cx8Yr9lUphIWFRYH4c
         dM8zsb3IkYO7BPpC2ZXOQrJVf9RkDl+a9H6aoI4vPtBmRi+3tluL/JSPZc3JSSbLS2q+
         GYeF249u7dj1UxXGlRl9WIWUhcDkfDq29Muxc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795378525; x=1795983325;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W/FP4mjTDcCLY4HxpXOsFu1A+aUvxayfSqVu/TYO4+Y=;
        b=0cMehLOBDm/d3XJCnjJMPSs6lqMDccWyBCzl29Xc2+pze8Zt+z9dqouhE97DDJDT34
         ZaBTlKVMpmkSs7MRcNtC+t3BpvlbBxrkunwLOvFmjjaLIfCVaVso1BKlKCsQrKWf8zhn
         ZLe9X4WAmAyjFakLkCvVNaD+8GDbLtFBGX4jh6NNofr1An/hGckPTl2kxMYcSz5Rk1XU
         3bs8gR8XLXPeaAAkwvBBVHEf2qimy5yvD4nzy+POVRKOtv9MLxzpLg4czkAM36FDnfFr
         V4dhzooRV3y5rNbSBBkz1bNWkXBKRaeWIyAzXfMpAlL5omAM3X6IZ4B+ITm8C0/QfdHO
         VLtA==
X-Gm-Message-State: APuU4Z+BZ4m6Vk80snlKb+I7h5RhyRzB/wr9OXB5FPxwUcgrNN81gAlF
	MH2aoocC6SpQHixVfrGLYcNQSBp5feEubpIoyxpa43EwhGuWPW2OCbOE0+wkcvRq/jg8IJK8jUV
	CYSUZ
X-Gm-Gg: AZFdTZetwq2LzK3lnJkWF5Ms6Mt6bk3BFn3mh0jO18urYVBYRf9IzDTb4zHbwUBhG2F
	rJs/92H9E/WQOikH8osDE1DZHRZU+KsbWUgupK7FLGJMVnmIv4VE4C3vGxBiHWlMJDauLjRFepQ
	rJ7730hmfMAo90YMwGQ1c3x+ScD5T7GFznYjzjMIyCq/grliEt1IqJP/lfyyu+C7ZkIuGC/QQ6G
	ORhc3jcDLBngpjzu9gUZ1tJp9fj8pKogJCFriDvQ+EEYpdKE53wBuGr+nMgIZPYf0s0+IA8nzcM
	+IN1bwaREmTYnqRSOzQzTAN/unjzLV9ytVRo3OVZ1h/PGuq7bGcs1AFu3cSQySVH4sIHQT7MCf3
	043ccw8iqBRapWPH/WwjhKrJ7nE2sXzsQw0OdlqB+YZhowB96IaNH8e03lZ9ceu2pzXyGJ2/mE+
	Qu2y9pgraEN9lnUWIADfL32UqbXRk3VpXKktqv9q3iqZUl6qZf/GA1tbXzRGOCq99BgFnuwtQC5
	oeFUPhp219YK7D1sKyWnLFmtyMT5pseAqSGXJuSnUA3IY5cvDPiFkjgCi5GcOoHHcMv4GIMI7WC
	Q+Q53F2VXX/wBNob6V+FdFJ9dQVfKeUXrDx7EJYQWfnOmDHH0w==
X-Received: by 2002:a05:600c:37c6:b0:4a1:88df:8a2a with SMTP id 5b1f17b1804b1-4bb88812a84mr198902935e9.13.1795378525214;
        Sun, 22 Nov 2026 12:15:25 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:f8cf:a1d9:90ed:c978])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb90660cb4sm202724465e9.2.2026.11.22.12.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 12:15:25 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH] Bluetooth: hci_event: Don't report a cancelled PA sync as failed
Date: Sun, 22 Nov 2026 21:15:18 +0100
Message-ID: <20261122201519.2859075-1-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
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

When HCI_LE_Periodic_Advertising_Sync_Established is not received in
time, hci_le_pa_create_sync() cancels the request and returns
-ETIMEDOUT, which create_pa_complete() reports to the ISO layer.

The controller then generates the event with status Operation Cancelled
by Host, after the command complete of the cancel, so it may be handled
only after create_pa_complete() has cleared HCI_CONN_CREATE_PA_SYNC and
the next queued hci_le_pa_create_sync() has set it in the connection of
another request. hci_le_pa_sync_established_evt() then takes the stale
event for that request and clears its flag, so the event the controller
generates for that request finds no connection and is dropped.

Handled earlier, the event is either logged as received for an unknown
connection or, before create_pa_complete() runs, reported as a failure
of the timed out request, which create_pa_complete() then reports again
unless "Bluetooth: hci_sync: Don't report a timed out PA sync twice" is
applied.

Ignore the event with that status.

Fixes: e2d471b7806b ("Bluetooth: ISO: Fix not using SID from adv report")
Fixes: 41bf23338a50 ("Bluetooth: hci_conn: Fix not cleaning up PA_LINK connections")
Signed-off-by: Simon Mikuda <simon.mikuda@streamunlimited.com>
---
 net/bluetooth/hci_event.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 039bcea98a5a..ebddf5d62f35 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6814,6 +6814,13 @@ static void hci_le_pa_sync_established_evt(struct hci_dev *hdev, void *data,
 
 	bt_dev_dbg(hdev, "status 0x%2.2x", ev->status);
 
+	/* HCI_LE_Periodic_Advertising_Create_Sync_Cancel is only sent when
+	 * hci_le_pa_create_sync() times out, which create_pa_complete()
+	 * already reports.
+	 */
+	if (ev->status == HCI_ERROR_CANCELLED_BY_HOST)
+		return;
+
 	hci_dev_lock(hdev);
 	hci_store_wake_reason(hdev, &ev->bdaddr, ev->bdaddr_type);
 

base-commit: 4fe38719e6738feaa90486e36b0790dd5d960a96
-- 
2.43.0

