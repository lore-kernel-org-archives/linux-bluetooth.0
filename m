Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42902E3AF2
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Jul 2025 20:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751402093; cv=none; b=oEc5kazCb4XGmQpEHwel9nQY/rAajNU08K4trRgKJo09dAyBTN/5OS8KcHCxNdurLKfBOqAU8Ncp3Cet5bQjfnskzLWKKNzA5bc9BPaNUt3dUQeBpRspCiz7kLHv7Zz5R/ExAz8jOay0z5kaQZjG0KVxiDMALMTOgZQDsfOpLvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751402093; c=relaxed/simple;
	bh=C86osmLqvHhTZfHanG6OxWKha6gvsQ/Y7lGKOgPMrxQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=QzcIHB4tGtIRv2EDWXCssDCveCaNKzUZ9xiXlop70HWpm3qwpWzWkHQA3LCXD5OcUGLESg2C8iGvAr+ROrYl+4VI0aQnwHOj1832eObObywBv9rvXsFh0qKy6U8sWqWfUDYxQdktnlRHN0YaP7iUq/kNcgVIARs4fv37mL8VlKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MWmBzcl/; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWmBzcl/"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-5344894a85aso429680e0c.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Jul 2025 13:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751402090; x=1752006890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=s0ZZIuqUSLtiXyLnKbEHnrob65KpaZ3fbWpE2etyeJE=;
        b=MWmBzcl/6X0OvLt3SSEQFjSb2Heg0xwxzE19ClaQ6sAxbjiuOerddnG4W1DKnI58kN
         3NYRKZ3rEi8GeIt9I8jxC3TUbf7VVIzRxvbEAgGCLjnz7N9WDt9GSQaPe1WhmXGaenXC
         VgeU6rEQ+0G2KgWdKsXhCfrw78QY17k3FcSpYjTZv17I3W4Fgz6bUKbdwhn0AKXHJNYS
         4zmNIVpH4E+RdtUUeS0Fr7b74DhHEXZJGLNzMp3FbOxm1Ahk7vpc2uf2nCH6/IF+R0ZF
         yagHA7h9imARaqZbHnFO4OEe3BXTwcwUO3vV8XdI0lwWzyW68BOWLlDJCeoqJctNMfiY
         fGug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751402090; x=1752006890;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s0ZZIuqUSLtiXyLnKbEHnrob65KpaZ3fbWpE2etyeJE=;
        b=MWSMQuR5ifySRyOcPOcnNI8KR+ND7lx1f6yjR5MQ9/gm1WKlBacyxNMGoRIM833hYr
         fk/1DENjbX57kULZHqJjWzQmQyuykCkuD6aO7SrIDwkFviDoGP4KXqy5Ol0l3CmmfkkX
         eNyaCVij+gbsShU3/AMYktRwyUY9BsnfXD5BYKPqaI0KSFPbFER86/7CknucotUbSDa0
         jlPBnolFPOx0pZpbSo04JvPFC64Bh+OpHG21mdfOm5rmnw5IteUBPosd72IGjnVrMgSI
         CkKir4MUsjEOpjEHFyKZwXs/oN+Khhp4JYaIWR8vuOcF7GHhN/H3OzHgNROUaNWIV1om
         Zt5g==
X-Gm-Message-State: AOJu0Yz2xi2UsrYLSPtCs/IUe96xbubQVPX+GrIiYil0NJAPrRDXQIZV
	qePILrfDKEk5jYaCEAAU+9GxrJGm9HGJp8FThDa1co/4Hd3I+6V03+gX334hmHA1
X-Gm-Gg: ASbGncvDPc9vL5uHyru9U6qkF7u6zhnqUlRyPvqs7MxiX5PW5xC6CN6OgSJ49159P/o
	jrTanzLc9YIdEShKNbntZbppm1xJsLzFj71Dbgfx/gYQ50NmJyBX9KY5kfX6DeUXb/5TW90723n
	cW5QVn+9/w5Ds6Bfp4bMxmHOLyIOqXRt374Yq0fFRwofhcJ9ufwSdcAn9ULZBqNdkyQx7VvQJvE
	Ku2bZRQyoyKG+4Aj2RkP2qoY7kP32yStuiPvyY1wEaFy8h++pSUEbkDQ3QxMurSO8IrGwBB9ShP
	07kZI5chuhiRSSH8GkbqOEwSPpGQ+aEyvO9glIhR3IvAKPqGSlnJ16G/DMuwE41ajnd4QXyaFPI
	aTqljV044R5CopA5ghy07bA3kAPvQ0wpjVbVz25hD2Q==
X-Google-Smtp-Source: AGHT+IHpOFc2wQg+BdBvNPuJyhwCfTLf7mHsth5G2S8+ElnqHfFcbBdWcTiHWat+cGjvAym4eTIzng==
X-Received: by 2002:a05:6122:378d:b0:520:61ee:c815 with SMTP id 71dfb90a1353d-534585a3057mr419352e0c.10.1751402089893;
        Tue, 01 Jul 2025 13:34:49 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-53310392a87sm1663011e0c.41.2025.07.01.13.34.47
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 13:34:49 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] error: Add dedicated error domain for BREDR
Date: Tue,  1 Jul 2025 16:34:46 -0400
Message-ID: <20250701203446.1227837-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds dedicated error domain org.bluez.Error.BREDR for BREDR bearer
and then use it on the likes of btd_error_profile_unavailable.
---
 doc/org.bluez.Device.rst | 1 +
 src/device.c             | 3 +--
 src/error.c              | 5 ++---
 src/error.h              | 1 +
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/doc/org.bluez.Device.rst b/doc/org.bluez.Device.rst
index 646e2c77ec2d..61c394dd2d0b 100644
--- a/doc/org.bluez.Device.rst
+++ b/doc/org.bluez.Device.rst
@@ -49,6 +49,7 @@ Possible errors:
 :org.bluez.Error.Failed:
 :org.bluez.Error.InProgress:
 :org.bluez.Error.AlreadyConnected:
+:org.bluez.Error.BREDR.ProfileUnavailable:
 
 void Disconnect()
 `````````````````
diff --git a/src/device.c b/src/device.c
index 2c741d3913e4..2892b75e7e25 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2685,8 +2685,7 @@ static DBusMessage *connect_profiles(struct btd_device *dev, uint8_t bdaddr_type
 						BTD_SERVICE_STATE_CONNECTED)) {
 				return dbus_message_new_method_return(msg);
 			} else {
-				return btd_error_not_available_str(msg,
-					ERR_BREDR_CONN_PROFILE_UNAVAILABLE);
+				return btd_error_profile_unavailable(msg);
 			}
 		}
 
diff --git a/src/error.c b/src/error.c
index 41dd90400426..e61baeef7928 100644
--- a/src/error.c
+++ b/src/error.c
@@ -130,10 +130,9 @@ DBusMessage *btd_error_not_ready_str(DBusMessage *msg, const char *str)
 
 DBusMessage *btd_error_profile_unavailable(DBusMessage *msg)
 {
-	return g_dbus_create_error(msg, ERROR_INTERFACE
+	return g_dbus_create_error(msg, ERROR_INTERFACE_BREDR
 					".ProfileUnavailable",
-					"Exhausted the list of BR/EDR "
-					"profiles to connect to");
+					"No more profiles to connect to");
 }
 
 DBusMessage *btd_error_failed(DBusMessage *msg, const char *str)
diff --git a/src/error.h b/src/error.h
index 64297f4376d0..47602d39ba81 100644
--- a/src/error.h
+++ b/src/error.h
@@ -14,6 +14,7 @@
 #include <stdint.h>
 
 #define ERROR_INTERFACE "org.bluez.Error"
+#define ERROR_INTERFACE_BREDR "org.bluez.Error.BREDR"
 
 /* BR/EDR connection failure reasons */
 #define ERR_BREDR_CONN_ALREADY_CONNECTED	"br-connection-already-"\
-- 
2.49.0

