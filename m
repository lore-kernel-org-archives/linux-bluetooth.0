Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F7A6216A
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Feb 2024 15:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706801914; cv=none; b=JiDJJs8h9IJiPFg8M8hcrCcn3Mxdi11R0/tVydrdC0vTHiesUBvZKCn9wkzT5B9iYMprp9/k1qSYgl8xy9Y7PmbtW7WFOHAvLp7xUYwpR42C5tkE7KW4n0aiFNmh4ONcEayS70ZdhEcEHrlGYyjtrfNr115arOFk6PUuD5cyBN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706801914; c=relaxed/simple;
	bh=AAOtZ8xC+h1vmDpGmod5czlcvsYkjYt1Bxoa+kp7CgA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jVi8g7N8wBkSiyPPGv+iu6X1Jy4ecUlzrQ2Jmp60XeNMJ5qBNVXZblvjYF6ls/4zcKal9hgLS2Gt1QMzg2RYXyrQLKS1L/75f2cDlMY6LSOpwDHF9QztrC7+sHTcyRmSPBOC/ANy5lOQnGS5WDSKUKClVmnJtIC/bHF073ykp0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M/Yk0EOT; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/Yk0EOT"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-7d5fce59261so540822241.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Feb 2024 07:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706801909; x=1707406709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G+0d8Hy5JsXKOl1rOEs9vku4hGWhA4odGKzZJQAiN/U=;
        b=M/Yk0EOTn7+IstCmDI3xA65DZKMtmyKxH7Q8xfiuZI+wnDedQlhwN1+7Rs0ARlL/Kq
         ROS2Ez7/qW/FDlRXmgrVHv/o8kt/C1iOxgKPMpv84v9st3SOFK379ox3DyauxZa+1x4r
         JUee9MQsFnOF/IHtJUN7KvlNnJR6ifqRktYPee4nRcY1BSnjiVAi9+82JopVJa9Taryq
         iqwsyVK6wvTrY1Tw19bqEzxLFhK8h0WtH6m0/S3xv8288eRPcyA7MebwaTVaBhMlnoGD
         IM/BjpI8i1BUHYtbGz1Cw8Vn8xIcaao0kKdx3f3aACfiHfKFRU4sZjopERLeijQxUdy1
         s6tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706801909; x=1707406709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G+0d8Hy5JsXKOl1rOEs9vku4hGWhA4odGKzZJQAiN/U=;
        b=LP1cpMIPiy7kQKlnr4uGq221N9fknAMHdqjVR5v65q61oJ9VAf6d+XurWw30bGZB8n
         KOIWCYYUCcBeCXUW86jSCpfhsIniQW/B8gdniRw7sVdOxt8010oyrXaBYel8ev5zML/m
         eAK5B+VjbdUkvncpDqtelG7Ob7XkIZoSZWFZxpqBw8EDEV4Yb7QCRAFhANpAwujKF40t
         odSSzCT4tT1HnxVkva2HGZ4h4NJ48+offHilWjrEagpNiv+BT3rTIxwjYlleNfR4EbKh
         Nop44JbdtmwSvVlmbhuB6GTzIs3tmLbEcOsmnykAFlBrMEpAVBmeoaQSR9TJtSaRYQ/X
         q7fw==
X-Gm-Message-State: AOJu0YwXn4/ptRgIghD0AHGP2avlRRa4RbM1rBGC0bNNXDPYhPpEsCRf
	5ejFStciD7DQBKrujJUHT4ZcGwqxYThMZS61104r6ypXBYMonb5VIBAYroy9
X-Google-Smtp-Source: AGHT+IEjQmPCBzwR1qPhysfcKse1zn/wg0SuW3g8IKIvAl/7o1i1at6TO7MmqTPwmTt3gsGSa0mS4A==
X-Received: by 2002:ac5:c76b:0:b0:4bd:3d31:353a with SMTP id c11-20020ac5c76b000000b004bd3d31353amr4544564vkn.4.1706801908920;
        Thu, 01 Feb 2024 07:38:28 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id ca5-20020a056122400500b004bd503f054asm1624586vkb.42.2024.02.01.07.38.27
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 07:38:28 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 5/5] bap: Fix crash when a broadcast strean setup is pending
Date: Thu,  1 Feb 2024 10:38:20 -0500
Message-ID: <20240201153820.1016507-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201153820.1016507-1-luiz.dentz@gmail.com>
References: <20240201153820.1016507-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the following crash when a broadcast stream setup is
pending and the device is remove:

bluetoothd[37]: src/device.c:device_free() 0x89a500
bluetoothd[37]: GLib: Invalid file descriptor.
bluetoothd[37]: ++++++++ backtrace ++++++++
bluetoothd[37]: #1  g_logv+0x270 (/usr/lib64/libglib-2.0.so.0.7600.6) [0x7feb557e3120]
bluetoothd[37]: #2  g_log+0x93 (/usr/lib64/libglib-2.0.so.0.7600.6) [0x7feb557e3403]
bluetoothd[37]: #3  g_io_channel_error_from_errno+0x4a (/usr/lib64/libglib-2.0.so.0.7600.6) [0x7feb557cd9da]
bluetoothd[37]: #4  g_io_unix_close+0x53 (/usr/lib64/libglib-2.0.so.0.7600.6) [0x7feb55839d53]
bluetoothd[37]: #5  g_io_channel_shutdown+0x10f (/usr/lib64/libglib-2.0.so.0.7600.6) [0x7feb557cdf7f]
bluetoothd[37]: #6  g_io_channel_unref+0x39 (/usr/lib64/libglib-2.0.so.0.7600.6) [0x7feb557ce1e9]
bluetoothd[37]: #7  g_source_unref_internal+0x24f (/usr/lib64/libglib-2.0.so.0.7600.6) [0x7feb557db79f]
bluetoothd[37]: #8  g_main_context_dispatch+0x288 (/usr/lib64/libglib-2.0.so.0.7600.6) [0x7feb557dd638]
bluetoothd[37]: #9  g_main_context_iterate.isra.0+0x318 (/usr/lib64/libglib-2.0.so.0.7600.6) [0x7feb5583b6b8]
bluetoothd[37]: #10 g_main_loop_run+0x7f (/usr/lib64/libglib-2.0.so.0.7600.6) [0x7feb557dcaff]
bluetoothd[37]: #11 mainloop_run+0x15 (src/shared/mainloop-glib.c:68) [0x662e65]
bluetoothd[37]: #12 mainloop_run_with_signal+0x128 (src/shared/mainloop-notify.c:190) [0x663368]
bluetoothd[37]: #13 main+0x154b (src/main.c:1454) [0x41521b]
bluetoothd[37]: #14 __libc_start_call_main+0x7a (/usr/lib64/libc.so.6) [0x7feb54e1fb8a]
bluetoothd[37]: #15 __libc_start_main@@GLIBC_2.34+0x8b (/usr/lib64/libc.so.6) [0x7feb54e1fc4b]
bluetoothd[37]: #16 _start+0x25 (src/main.c:1197) [0x416305]
bluetoothd[37]: +++++++++++++++++++++++++++
---
 profiles/audio/bap.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 7e87d12d02f1..26fd465bf560 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -974,6 +974,9 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 			setup->id = 0;
 		}
 
+		if (ep->data->service)
+			service_set_connecting(ep->data->service);
+
 		return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
 	}
 
@@ -2437,6 +2440,11 @@ static int bap_bcast_probe(struct btd_service *service)
 		return -EINVAL;
 	}
 
+	if (!bt_bap_attach(data->bap, NULL)) {
+		error("BAP unable to attach");
+		return -EINVAL;
+	}
+
 	bap_data_add(data);
 
 	data->ready_id = bt_bap_ready_register(data->bap, bap_ready, service,
@@ -2644,6 +2652,7 @@ static struct btd_profile bap_bcast_profile = {
 	.remote_uuid	= BCAAS_UUID_STR,
 	.device_probe	= bap_bcast_probe,
 	.device_remove	= bap_bcast_remove,
+	.disconnect	= bap_disconnect,
 	.auto_connect	= false,
 	.experimental	= true,
 };
-- 
2.43.0

