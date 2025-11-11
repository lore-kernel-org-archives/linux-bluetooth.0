Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE61352F94
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Nov 2025 21:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762896158; cv=none; b=ja0sBvK9Eig40d7QpKsMeczEYEkaGPpOgn6XsS85GaU+z+cZtFdDl3o54Rf5ft89mIryhhbqKWJ2NAWybW7GhMnAn5/oEKvuThqv2bw/cNzDQbzDSyfU4v/zZ8n91o8EQoxpVUhAWnC1burckKI4FSxIlFImB845coQb6eSVux8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762896158; c=relaxed/simple;
	bh=ZH5VtiqDalp2xMQ1D54vdHvYlh/n1NlabtT8qhvCcTo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aATMDGXiCAsrKeDlvBn0hglpXO1J00BS0awlslJUODgyIIQ9rdJTZ2F46MyM+ejX87AkBKhncLxaS9HO6L0s3/YZSGVfyo6hmm7ct0XUAYW+m7xcMsixekRo9w2wxL0tjFL9AI0kjLK2UyWNKqe9WYzl315XoAMJLaDUD0cxmNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CfTKf4Nm; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CfTKf4Nm"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b8c0c0cdd61so116291a12.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Nov 2025 13:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762896155; x=1763500955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ML77KBw/3xTy19mztw7NCAax5w4urkATCMTcBcXa/Gw=;
        b=CfTKf4Nm4UQDtPLHjLod5E2T6kvlKjyLsMletzFHvIfJ8gyc/Oy9Z2kkmUZzjindl8
         KjnUOCfy48OC4JeBrB9qw/fde4wCc9siEytJV7r4GXARtn7+XWlU2OvOOPqQTya6srec
         0JQrt0j71y7IRT631oLPtfKrNJ4+GeOX0O6A7NeEYFa19ieI89zMrGIYjfBAhjYIXU9s
         7wJJ1WbRsCC+q/7DDvvtcogu/NFPgTlN4t6gb7zu4KWO8iEWbtOnR/GYz6nDB6htF5gC
         +mdc0B9QjP0VcqNSHaY4uphEFpMj2YjOFxgMlnFIsopT7pFy0Pb75Ano6Yoie64DEymq
         3zSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762896155; x=1763500955;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ML77KBw/3xTy19mztw7NCAax5w4urkATCMTcBcXa/Gw=;
        b=E0huM7WRB0hky9pr9EdCbBnmJYJ8tsmbOwO54060A/CpNkhwj4lyHq2kv2IE2CgWzc
         rkn0kGmyKNZ5AoG7rxGFIVwjOW4otF+WFq3dbufXNFj4AMk0jN4m5r39q8cVSCRr1cGo
         I25Sqgww4mRE6u7klOfOr3AFPLXWdGT8cEAsIN53Zj0aQ3f7kZY3z/z841WBUGMEcBtR
         fb1zYfUZAEZ0cri7x1jZyQ4rW1UJpujxY9KCj5QsXM8f82X7vbZ0d627flX/NMKZbQAZ
         H6YcnJYBm65X1pumzlkVmrn5hvIHaaIr899yOlZRe/JeIUsZRUTVmJNdWJTt6ONdMjoy
         b4BQ==
X-Gm-Message-State: AOJu0Yy7WtafDpoujp/lHD5FTAe528mLZcCFdzTJZEdHWFA4Em2rhFZQ
	h077H7ArDjuEiQjsXnPNwh9simSiYgrVvkt3j2PS7BTyJTfzkFsEEpV2DeYwo/FR
X-Gm-Gg: ASbGncusa7+p5CZjkdJRx49KPpxY4i2/K0QdE8iHG9V2ZK6q5onob8kFQQrO2ouf/4d
	jINKsWxaLveTuz0jlVtcyRMy6RQUiR/tr3tEj0dbUemey+wF0fIO69xF8fMpGq2ynp/j7Ck6ry+
	bW5lKEzK1z33Kq5VSfbzqSHWwGrJ2kv7H0NYGLaIC/3z50R9Gb3qr8nOLvdSfpjTOtwSUi/mUWh
	qE4rSeolnwxDdWG+iM4M0wtqVtX77ZzDARL0APwbDd7uju7rcbsK8uGT8Z88nzhy2y6TzFzUp2K
	lCJvTXlw2BMS+5cN79J9HrXb/nHQHVRl88sdCNC40HZgpK0O7TcS3mX+hwgv4KpAATFIuYMY/wA
	d060iUbdF95MW0XOdi3wrhAUK0irJgkMkv/5572uJSnYNz28nRFLMx0vbgO8ZpEZfm8NBjPSbtd
	jPIM6SpQdjJG2gYcQcLZxEpZJMoBenOtFELb5vlIWAOS/jsH0aA15qsDEPjcNepUfmQ309OtCEE
	4tXBToo6WmU
X-Google-Smtp-Source: AGHT+IEzlGrl79TNMXh0+E8y6vGoHrdpNzZiKgqUJaUQ+39miOUiz05LCaElhLb6xCFbjtsagKR12w==
X-Received: by 2002:a17:902:dace:b0:298:2637:800b with SMTP id d9443c01a7336-2984edcaddemr7755225ad.31.1762896155430;
        Tue, 11 Nov 2025 13:22:35 -0800 (PST)
Received: from pidgey.localdomain ([4.16.227.147])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343c0491c3csm1587651a91.4.2025.11.11.13.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 13:22:34 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH BlueZ] device: Limit the number of retries on auth failures
Date: Tue, 11 Nov 2025 13:22:01 -0800
Message-Id: <20251111212201.1130-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently BlueZ has no retry limit on reconnection attempts in case of
authentication failures. This leads to a very unpleasant user
experince with, for example, XBox controller. The scenario is as
follows:

1. Host A is running BlueZ and XBox controller is paired and connected
   to it.
2. Host A shuts down (for example)
3. XBox controller is put into pairing mode and is paired to a Host B
4. Host B is powered down
5. Host A is powered on
6. XBox controller is powered on
7. Host A/BlueZ will start spamming XBox controller with connection
   attempts in an endless loop

What happens under the hood is:

1. BlueZ starts up, sees that there's LTK saved for XBox controller,
   so it adds it to kernels autoconnect list
2. Once XBox controller is on and advertising, kernel connects to it
3. BlueZ tries to elevate the security level, but is rejected by the
   controller with "Key or PIN missing" because the controller is already
   paired to another host.
4. Controller disconnects, controller goes back to advertising, goto 2

To avoid this, let's add a simple auth failure counter and disable
autoconnect for the device once we go past the failure threshold.
---

I don't really expect this to be the final form of this change, so
this is more of an RFC to get some feedback from upstream.

I'd also love to get some feedback on the following:

1. Ideally I'd also want to add an exponential backoff to the retries,
but I'm not familiar enough with BlueZ code to know how to go about
that. Anyone has any advise what would be the best way to implement
it? Assuming there's no objection to that.

2. It seems like another imporvement on this front would be for BlueZ
to get the "Key or PIN is missing" error code and react to that by
removing the stored LTK info. Does that seem reasonable? If yes, it
looks like the kernel actually doesn't pass that error code to the
userspace. Is that right? Does anyone know why and what's the best way
to go about fixing that?

Thanks!


 src/device.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/src/device.c b/src/device.c
index 91b6cc0c6..434bdf721 100644
--- a/src/device.c
+++ b/src/device.c
@@ -77,6 +77,7 @@
 #endif

 #define RSSI_THRESHOLD		8
+#define AUTH_FAILURES_THRESHOLD	5

 static DBusConnection *dbus_conn = NULL;
 static unsigned service_state_cb_id;
@@ -306,6 +307,8 @@ struct btd_device {
 	time_t		name_resolve_failed_time;

 	int8_t		volume;
+
+	uint32_t	auth_failures;
 };

 static const uint16_t uuid_list[] = {
@@ -7113,9 +7116,15 @@ void device_bonding_complete(struct btd_device *device, uint8_t bdaddr_type,
 			btd_device_set_temporary(device, true);

 		device_bonding_failed(device, status);
+
+		if (device->auth_failures > AUTH_FAILURES_THRESHOLD)
+			device_set_auto_connect(device, FALSE);
+
 		return;
 	}

+	device->auth_failures = 0;
+
 	device_auth_req_free(device);

 	/* Enable the wake_allowed property if required */
@@ -7320,6 +7329,8 @@ void device_bonding_failed(struct btd_device *device, uint8_t status)
 	struct bonding_req *bonding = device->bonding;
 	DBusMessage *reply;

+	device->auth_failures++;
+
 	DBG("status %u", status);

 	if (!bonding)
--
2.34.1
