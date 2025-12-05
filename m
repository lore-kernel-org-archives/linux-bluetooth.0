Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7970F4502F
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Dec 2025 23:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764978661; cv=none; b=GXHHnGIZjYgNg5fWac6tnJw0GzePR4V4Af5nW5A1LKAtRpzHLf3z/y8AGqOuqWr67ApUkZLhfCl2hH5rbibOQHSJF9uJUrBpjDOqS63l8WJtVQ6NSIwCshuXBjEapvYVyGBLUv6DOKr6095RXAVfrHmlEO/p1HNwZJ1GwkR+kUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764978661; c=relaxed/simple;
	bh=VIgTeGken+0tI8HZ2ZYo5mXkTk+Ub3OVOd+vDwjVSTA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W4Bs1OFugOc9wniYBMTRzX8DfShaK4atFtLGVVszUPj3ONXsEXE/j41DunpNCrJGlf2ycQ7BrdDwoObsktJp6Da8TjiHGHnnpNCcxmpZKnuj4pFQ7YDoNhQgxJUPjPdrHdHTu8RH0NOqaLqpD7w29ZbTtHY2kYtITIZgrnzbxAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cma6Wvr+; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cma6Wvr+"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7aa2170adf9so2245905b3a.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Dec 2025 15:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764978658; x=1765583458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LLPrDTj6kIWqKXJPJunMPSyzCOpstvyGODfWTxl4IU0=;
        b=cma6Wvr+ZbtfsXo5kYVgRANFtITo1/UGAICc4Kh/qhvD7Qpsl9kkZEIsS5zpjaL/Bz
         Xjm4yaWddiUaQVm+Bbi74Fzk5a+hsLbU2k+7J5LAm0NcrWe2Lhk3LSEKR5b9+hLqjzM3
         RuG08y+y643sKSKk2bNI1INGSsT9kZcGjLGVBT4IZ4/iYyIyFK2VxoRVIfbOkx7PAt8Q
         fBzkudil642PAa0UgKGIcFPaowopLP0LmZeaoF80dtWKALtpQRooaensfpEafhIo/wdM
         NMhIiDFGP6OMTZpp72C5F6P4hIucGWgesbwaFDjopbLLRB6gRJFnrnbRJGsTglfVytr+
         1qDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764978658; x=1765583458;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LLPrDTj6kIWqKXJPJunMPSyzCOpstvyGODfWTxl4IU0=;
        b=qoHHZnrHcU2A8J4bGmWWweAvQByRE236OcdF/DzFuCs2C082aGRgRmFpHRbWChde7X
         U3o4wSE/HAxyaHR1kXZ+7yRW5PIcO2ZdySTWkhYyYhT/C77BmVm+8VJMuMSEGziQS/8M
         L2aDBDiBCYizHkOWIqzJBsMlcN6hP5Rtv70P79gjGXXiXj32/16lYWNXD5wr+pZaLem7
         KDXWq8rY71vVZplefwead+27ShYbywbLihqHdXKo+sMn7zXhkz/y8jdZgiHGr1RcPdpG
         FOiJH7e2ZAn4hKFKQYn0iDWxN4kgecJU9paTs/0zV5iWTziwQaHlGj6OGYzH00Cl7Yfs
         GXAA==
X-Gm-Message-State: AOJu0Yy3o/Ij6NkwTSUwG1jjZwQPmFV3cEcoqVhMsYvSU6P14cWGVL3B
	Qg/QaIhhrWKR23RzXXd9NRrfnc/FQ6rZG+2uRMS3FVHrOH0L2qWff9ayZ/DC+6Y+m08=
X-Gm-Gg: ASbGncsWNIiH4E9NWenoVwCcPvZ/ZI0lV4Kx77kJqkRWM0h6W3ig7Fb6+W005e9U9oN
	2Gw3y96FiHOts0wtjlFazONKqEORBNbIdF+jPPqCj+HODVzq7pvGT+CgzLGLuETI1O5SUHPTwWG
	GqGUyQI3AOfy7D8NWnYBgL7mtqi7i+twHpf5M9XgKUjZhDnBM7zUCyLFxtinz6GqntI7grPLtJe
	cyUBdepJijZFFTvkHqU3JcBaVUs1ZwMn+PFZp4ZM+PbUSl2WZAvyr4sURwBA8e92ff+f7AkIxfH
	KgWzi3tCj4VJ27UFZ7mRyjK6/am5uOu2Nz9QwNsXDq+CdUebE4BZ3PWhOd5xPPkRt02nYj1pgfU
	xH1Dqp+6Eru1KO+ad5Emi3mkcVRgNmlAnlSCHGzh4RnLYI+vu3szfP76v4LdgEJkgJFlHUYkY5p
	4GYTWKg6rP9mSl54ip/6MJGH6FSp4p
X-Google-Smtp-Source: AGHT+IHqtUjR9AK6Xdgf8SoYOs6ZCuO4Usm1biq8GKZ3+XzJ+AAD1+70Vk7s7uNElqtHtg/Ytk/3gA==
X-Received: by 2002:a05:6a20:1588:b0:35b:d302:e7be with SMTP id adf61e73a8af0-36617ea8edamr827409637.2.1764978658085;
        Fri, 05 Dec 2025 15:50:58 -0800 (PST)
Received: from localhost.localdomain ([73.221.165.73])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bf6a14f5d0fsm5617170a12.23.2025.12.05.15.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 15:50:57 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH BlueZ v2] device: Limit the number of retries on auth failures
Date: Fri,  5 Dec 2025 15:50:33 -0800
Message-ID: <20251205235035.552388-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.43.0
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
autoconnect for the device once we go past the failure
threshold. Let's also implement an expoenential backoff in our retry
logic to avoid blasting our retires in a single burst.

Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---

Changes since [v1]

 - Auth failure detection logic is moved to device_remove_connection()
   which seems like a much better place to make this decision and it
   also has access to low level disconnect reason that allows us to
   detect Auth failures

 - Added exponential backoff timer to space the retry attempts out


Luis, you mentioned wanting to have some kind of signal to users about
this event. Do you want a new kind of event or do you think that

   string "org.bluez.Reason.Authentication"
   string "Connection terminated due to authentication failure"

that's already emitted in this case is enough?


[v1] https://lore.kernel.org/linux-bluetooth/20251111212201.1130-1-andrew.smirnov@gmail.com


 src/device.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/src/device.c b/src/device.c
index 52e3663f8..3b2c9514e 100644
--- a/src/device.c
+++ b/src/device.c
@@ -77,6 +77,7 @@
 #endif

 #define RSSI_THRESHOLD		8
+#define AUTH_FAILURES_THRESHOLD	3

 static DBusConnection *dbus_conn = NULL;
 static unsigned service_state_cb_id;
@@ -306,6 +307,9 @@ struct btd_device {
 	time_t		name_resolve_failed_time;

 	int8_t		volume;
+
+	uint32_t	auth_failures;
+        guint           auth_retry_timer;
 };

 static const uint16_t uuid_list[] = {
@@ -2824,6 +2828,8 @@ static DBusMessage *dev_connect(DBusConnection *conn, DBusMessage *msg,
 	else
 		bdaddr_type = select_conn_bearer(dev);

+	dev->auth_failures = 0;
+
 	if (bdaddr_type != BDADDR_BREDR) {
 		int err;

@@ -3898,6 +3904,13 @@ static void device_disconnected(struct btd_device *device, uint8_t reason)
 						DBUS_TYPE_INVALID);
 }

+static bool device_auth_failure_retry(gpointer user_data)
+{
+	struct btd_device *device = user_data;
+	device_set_auto_connect(device, TRUE);
+	return false;
+}
+
 void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type,
 								bool *remove,
 								uint8_t reason)
@@ -3978,6 +3991,27 @@ void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type,
 	g_slist_free_full(device->eir_uuids, g_free);
 	device->eir_uuids = NULL;

+	if (reason == MGMT_DEV_DISCONN_AUTH_FAILURE) {
+		/*
+		 * In case of an auth failure, implement an
+		 * exponential backoff retry logic. We disable auto
+		 * connect immediately to prevent us from retrying to
+		 * connect to this device again and start an 1, 2, 4
+		 * second timers to re-enable that knob in hopes that
+		 * subsequent retires will be more succesful
+		 */
+	        device_set_auto_connect(device, FALSE);
+		if (device->auth_failures < AUTH_FAILURES_THRESHOLD) {
+			device->auth_retry_timer = timeout_add_seconds(1 << device->auth_failures,
+								       device_auth_failure_retry,
+								       device, NULL);
+			DBG("Auth failure, retrying in %d seconds", 1 << device->auth_failures);
+			device->auth_failures++;
+		} else {
+			DBG("Disabling auto connect due to too many auth failures");
+		}
+	}
+
 	device_disconnected(device, reason);

 	g_dbus_emit_property_changed(dbus_conn, device->path,
@@ -5408,6 +5442,11 @@ void device_remove(struct btd_device *device, gboolean remove_stored)
 {
 	DBG("Removing device %s", device->path);

+	if (device->auth_retry_timer) {
+		device->auth_retry_timer = 0;
+		timeout_remove(device->auth_retry_timer);
+	}
+
 	if (device->auto_connect) {
 		device->disable_auto_connect = TRUE;
 		device_set_auto_connect(device, FALSE);
--
2.43.0
