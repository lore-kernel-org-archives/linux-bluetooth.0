Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0EC8526A
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Feb 2024 19:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706814629; cv=none; b=BmKjblBcb9ySyVTFyAH6rEtMc/VLw+srKUphRsJSF+zv5ytsOtWJdTzvKq1Zyj/3ACYpEtDXMxZ0Kz+AdU6uZp4vR1ZmNUrGSt7bN45f0oWAqPCOjKYgoU3edcy8VlRUq4DWqYu//87EUobShdAq5evHLfSGWVOKQc2H+cY1ijI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706814629; c=relaxed/simple;
	bh=AAOtZ8xC+h1vmDpGmod5czlcvsYkjYt1Bxoa+kp7CgA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EVjqco66Aeim8xVDM3OHt99Hi4J6rE7lzeV0XBSN8lxSC2JYzzFXc4r1sxfF/qh1xUDT7Zl2HRFxwgoTM/WYRdP0TjNCgMwLX0Tl+U9ckRZWZIRog7G1C1eH5QwrbBjyji5MFZDbhYqsOKWVno/T3CgQgdpAYIglCsAX2jYpdA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ew+6pOfz; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ew+6pOfz"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3becd4658e1so684097b6e.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Feb 2024 11:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706814626; x=1707419426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G+0d8Hy5JsXKOl1rOEs9vku4hGWhA4odGKzZJQAiN/U=;
        b=ew+6pOfzkzXwihaPelTzMyREvbRxLBlSKAkpRvBdUv6cp1ZULkiPfLUpkzqIUhf9ej
         1nWt9drO50zFpFrH65ojq5TNMaBEEvwBwzAGwikusYoRJENNRrmczr1TF+sM42d1lf2L
         j+VgsbXPMz1xxcVo9n78odaYY8xFp1HKiq+iNs15Bc7mavULdAmjj6vjhgihhj6LGPD/
         o9f8lexIMHFvTZLyQYheC92kMuF14y9Gyl2jspeabvT5HCY2LEVeDFUKCOk5PopNYDGX
         9tWURnsk1AUMz5Bey8JEQxTcJT3KT2j48PP1iJTuyTs0v/tkr0QFBi1OgjmrhoD3hZE7
         lUGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706814626; x=1707419426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G+0d8Hy5JsXKOl1rOEs9vku4hGWhA4odGKzZJQAiN/U=;
        b=mZW6nJylWr6bUkVDdrsicd3V2u6GHXUY/HeMBxseXsrKrzUUR+pCggxPXZvpHIhMDm
         6vhJSl4AiZ0aHhVoRqU4H+jLvXVvtR+Yv4CqMuNJ5vrvdQ5+RA5wRtB6SB5j4PDddF7u
         /uM4VbAEJln16OY1l1H+dV7pW9fVQuHZp2hXCGztvOff31jgT0hk7WsEwKuR1an3eo7j
         8W3Rv5jwdT3Ps8wlR09ROJ90+vPeMSn2TKHmWebZj7NMMercOP/XpGJQ5dLSt88UuFGX
         wp9iS0OVvPQziooP2kuZc4A1RMiaLfhkqWh7QYIvldyLRloySbpg5HcwideH9uJIpSwg
         /slA==
X-Gm-Message-State: AOJu0YzpffRLOs70aAu7EvGUZwVB8TevzPK6eC7NTwicE1x6sypAdV66
	pq6GVnISSzbdgzSvUgr4z4R6MVJZbYkt/80ud8Sny1dAEYjC7SzDxwRLLLKx
X-Google-Smtp-Source: AGHT+IE8VaVyhEsMQPL2ek17p+Ifb9OhURY3vC9mpQ9ft6wpCeNj1L5a6fyl4Ha5dzsArJ4TkxSgcg==
X-Received: by 2002:a05:6808:2024:b0:3bd:cacd:332d with SMTP id q36-20020a056808202400b003bdcacd332dmr47266oiw.40.1706814625732;
        Thu, 01 Feb 2024 11:10:25 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id db16-20020a056130239000b007d2e2f14bd4sm35912uab.29.2024.02.01.11.10.24
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 11:10:24 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 5/8] bap: Fix crash when a broadcast strean setup is pending
Date: Thu,  1 Feb 2024 14:10:13 -0500
Message-ID: <20240201191016.1122194-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201191016.1122194-1-luiz.dentz@gmail.com>
References: <20240201191016.1122194-1-luiz.dentz@gmail.com>
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

