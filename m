Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26BB494279
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Oct 2026 22:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792190531; cv=none; b=KJzqYphSFAsboGLKj7XR8IB3Q5gPUXQGXRUyo5zhBPD4uEE1N7Od9Vfx/JT7Sf64yR+55tamc9NV3g+Ogtju8Ovq74vOMbr/OFXmasFVSLLaaryQ3slQ3RqV6mbb6m/nZs3NEj3fUNQ81EUm1HwB/RqlsLfWQw5TcCVJlC+yqy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792190531; c=relaxed/simple;
	bh=vYC8oFCR3y3JzoWfoZwRW2XVBkm3n5khvgyZmzLajUE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p2htJNW7IdczSUnNX4jahoA8TRCR48yCQnurAQABTBcf1L/ytpEOReYhh7M1GvuR1qaDN+2VhEInhJ5wTdnnHH652MgAIXvDJNvIz4GIEJPQPxtXWF8TdntBCj6cmOHQHcReUa3s4RoDvJwbRvHXBUATZWTIYrcNo+ODoZat+5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pKrSKxmX; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pKrSKxmX"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-35ef6b49813so719099eec.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Oct 2026 15:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792190527; x=1792795327; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/l9+j2YEi0wsUZAOdgS3OC5lz94M0JZRvjejxfaxlyM=;
        b=pKrSKxmXH063bWfoHK8r6L1iZ2KxK2oKS+m9WVp1rCfHK0BHbVrAAJo/bcgu8vthB0
         x6PISzTa8kZoCdjrySUs660xnIAdXgkmySmT2bTuKgVTUpqTa+SUEHNfdphC7V7aOJmL
         6LC50Q7uajnvf7EIFZUXn/wl6HIfley8salw/DCl4xDYVBpt9ljY5oQkhUtd5eS/RdM5
         MG0FEHx/WldhRHcdtOKupnzuWSr/DAuz8C3HMwzgWt1SZFvJuiI67QhJ86KY4NsAQEcf
         YDs20z7B39BS7QbYs8TCglAOETLn+roT+cD3esrOywTUBan4z8dzjZMnt4ERF+0UHk+A
         Idcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792190527; x=1792795327;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/l9+j2YEi0wsUZAOdgS3OC5lz94M0JZRvjejxfaxlyM=;
        b=nRhkEZH2z+O38dpNuBClsNA5mpghYP1hzzP87nCQ9+Biu4++/HVBa99/fXr8PnKLmr
         q1EM1ef84K6r+spaz2Yk8bXvLUKcTYRDD6NRyYQuuVhqQYwJe/iPaU1z1BTwj7fc9jvL
         tKTOj4065HKKD7jP3S25l4YyPU+a9mKHBeqs+nxwoJoL63IgHDR71Gdz78LbT5vaBWds
         SdtyMYLlE7q8AX9Y6rWpQgmF7uUlnEzQtdI7pGYQf0OpyNetSrhbs0/PBDZUGWdEWiNa
         ZEg8WcJMsFRa15IpEgPU81zP2lQqd6qCrLQ+OfS6vMJoY25Z/Dq4uAJVIAafvtx7+HJF
         Rscg==
X-Forwarded-Encrypted: i=1; AKwUvBxVlMlAJE6o1gx+PnpKc9qgnBCffaGYuloWn9vDJzQ/8XB+THYb9kISYamSDOhfn3vNia/ItqGeUxyCFJWTHsg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKKMeloPjRhg4eTuOtZNEATNkpJJS4Vf9xeONYQwdwAr0mUdHio
	s6knN6TuKM+R1qqNOCYAHaymqF+b9EuhPtBQOE8d8fABmqJKTUEsrYk2
X-Gm-Gg: AYBFou3KrCNCnvAJZq0nhW1xLIG55Jj4rv8rhJ7SR5FaNHgvR9PwpF7oUhNe9N9pppb
	O1mdkAoiJo2UX/FAzokXb6EHR17XfuJ3Tvb63C9RpC6em3hJL07nwu0iMlFApOkQFO3gsDa0CQZ
	Ffvpin5R5Ql0jkxjcygvLtn+8+NPjF9plVimQcIY0O6elvyyfH6o+z6d55k/GcDIdCXy8V3GJ3H
	0sWU4rXlQ/dQGrOr8CQw+ZgEFr+vcUZvC8E+ZOpooQSPs8tCuwqwPIO4Ql9j065jPVnI6okP3AR
	TFOacyxWtUx4vtPbk1DPfaE6/eJhoSWEcd9EFBv+2TxdZloe/clSkHVA15kyj6hhm4Xw6tKfYku
	PwjKgDvrmLImnmUFidz1sOuTaR8mMxm5hzdfcQEtWQpIv3B95eIadh2AODdbM6gyBeHw+/7tWVJ
	E7s17QhN6M38WvSqtrIjRiCKk4dgkftv1ccxBT5theloLDDJox9dbwbhfNgLM62u4HqZrr2LM+e
	cSwJNaG0tK+rZHXLOw1up+TBX79YQSdKSEGViPsA+fwXzvOxFdirImtx5YQArY=
X-Received: by 2002:a05:7022:7f01:b0:166:780c:60b6 with SMTP id a92af1059eb24-18511ad84b7mr1500726c88.9.1792190526961;
        Fri, 16 Oct 2026 15:42:06 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:34f0:f27d:9a5d:56e0])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831c4d4675sm8252348c88.21.2026.10.16.15.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 15:42:05 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 16 Oct 2026 15:41:49 -0700
Subject: [PATCH v2 2/5] HID: hidraw: Introduce hidraw_instance() helper
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-test-hidraw-base-v2-2-153f67a20cad@gmail.com>
References: <20261016-test-hidraw-base-v2-0-153f67a20cad@gmail.com>
In-Reply-To: <20261016-test-hidraw-base-v2-0-153f67a20cad@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Michael Zaidman <michael.zaidman@gmail.com>, Rishi Gupta <gupt21@gmail.com>, 
 Heiner Kallweit <hkallweit1@gmail.com>, Andrej Shadura <andrew@shadura.me>, 
 Johannes Roith <johannes@gnu-linux.rocks>, linux-input@vger.kernel.org, 
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.17-dev-e56a4

Several drivers and subsystem helpers need to determine the minor number
of the hidraw node associated with an underlying HID device. Currently
they access internal driver data and cast the hidraw pointer directly,
requiring drivers to include the internal hidraw header.

Introduce hidraw_instance() to validate that the device was claimed by
hidraw and return its minor node number, or -ENODEV if hidraw is not
connected or hidraw support is disabled. Also use the new helper in
hid_connect().

Assisted-by: LLM
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-core.c |  2 +-
 drivers/hid/hidraw.c   | 15 +++++++++++++++
 include/linux/hidraw.h |  3 +++
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index e2944dbdc9e6..85433f64bda1 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2349,7 +2349,7 @@ int hid_connect(struct hid_device *hdev, unsigned int connect_mask)
 				((struct hiddev *)hdev->hiddev)->minor);
 	if (hdev->claimed & HID_CLAIMED_HIDRAW)
 		len += sprintf(buf + len, "%shidraw%d", len ? "," : "",
-				((struct hidraw *)hdev->hidraw)->minor);
+				hidraw_instance(hdev));
 
 	type = "Device";
 	for (i = 0; i < hdev->maxcollection; i++) {
diff --git a/drivers/hid/hidraw.c b/drivers/hid/hidraw.c
index 9129fabed181..949e7546339f 100644
--- a/drivers/hid/hidraw.c
+++ b/drivers/hid/hidraw.c
@@ -665,6 +665,21 @@ void hidraw_disconnect(struct hid_device *hid)
 }
 EXPORT_SYMBOL_GPL(hidraw_disconnect);
 
+/**
+ * hidraw_instance - get hidraw instance minor number for a HID device
+ * @hdev: HID device
+ *
+ * Return: minor number of the hidraw node, or -ENODEV if not connected
+ */
+int hidraw_instance(const struct hid_device *hdev)
+{
+	if ((hdev->claimed & HID_CLAIMED_HIDRAW) && hdev->hidraw)
+		return ((struct hidraw *)hdev->hidraw)->minor;
+
+	return -ENODEV;
+}
+EXPORT_SYMBOL_GPL(hidraw_instance);
+
 int __init hidraw_init(void)
 {
 	int result;
diff --git a/include/linux/hidraw.h b/include/linux/hidraw.h
index 18fd30a288de..3021454ba513 100644
--- a/include/linux/hidraw.h
+++ b/include/linux/hidraw.h
@@ -5,6 +5,7 @@
 #ifndef _HIDRAW_H
 #define _HIDRAW_H
 
+#include <linux/errno.h>
 #include <uapi/linux/hidraw.h>
 
 
@@ -41,12 +42,14 @@ void hidraw_exit(void);
 int hidraw_report_event(struct hid_device *, u8 *, int);
 int hidraw_connect(struct hid_device *);
 void hidraw_disconnect(struct hid_device *);
+int hidraw_instance(const struct hid_device *hdev);
 #else
 static inline int hidraw_init(void) { return 0; }
 static inline void hidraw_exit(void) { }
 static inline int hidraw_report_event(struct hid_device *hid, u8 *data, int len) { return 0; }
 static inline int hidraw_connect(struct hid_device *hid) { return -1; }
 static inline void hidraw_disconnect(struct hid_device *hid) { }
+static inline int hidraw_instance(const struct hid_device *hdev) { return -ENODEV; }
 #endif
 
 #endif

-- 
2.56.0.176.g3575e65682-goog

