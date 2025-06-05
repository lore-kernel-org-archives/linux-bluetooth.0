Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5B11FDE33
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Jun 2025 19:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749151454; cv=none; b=KjrABNbYVvKI/VY520T9zGKt1UvLLGVgnNfvEGZNBQCbC+Cao4P4MNgPUz03i0O4iyMiT+Tyfeg17gSQeeabRr0JTwP1VnEH7MKO+8GQL27xgsI4fR1DkiWXkh0aEYc6evt6LfvGM4vCJojfZ98Y557m83ZoH7ZyvIfAvO+9zxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749151454; c=relaxed/simple;
	bh=ycvua4U8XLI3EPqigufRsW5x13RVsFSzKJqN44hjMBc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gvNKVx2ZupJk4XJjbNABG6KuG5XORf9rf3JsXGbA3BVNOVWMQrufvR+Z2LpQACyebzKdrMtd8ZN2nkUnOmGYhBTogMYUyKcjzTIHE/7Gm3Y08T8q6lrMiSmTAmEWC3EK8pWkgZKJwHwbseXJXCtUpebxRGCp/bmHvlFdZEXl8ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WE/wgsrI; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WE/wgsrI"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5308b451df0so456524e0c.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Jun 2025 12:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749151451; x=1749756251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=frflxyDm1sgNuKeg54vyT0ZCvDO/mqpxFvzNJ4dF8kg=;
        b=WE/wgsrIzbW6pp4H1qA6m61zUGxYzQjJAO2eIxIBF3UzXDdGmngcE1j+dfM84shrs2
         qVS8h0Qzt6SwVTb/Y+iA6EqrGUthrQO05EfLQkyNFvrLd0EJukc/gA1Fv+tOqIjDJT1d
         EA6IhWdLZ4gI9QS6Hff38afd0HgyE9y/kYV39+xeRqnaKgNMhlq1nlVAi3MxKmxoxtkc
         IaJgatFqLNbEABHzxR9f40Nk1Qq5+sy6kSVh4Uj4Yzx5sY39AIskFkJU+IeXiJYIoMAB
         NrkqwJVngnaxj/7O23o8K6knoDU9ioW7NucuhtWkwL54B2OTe1Z1YBB37Zgmjapm36kg
         nGfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749151451; x=1749756251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=frflxyDm1sgNuKeg54vyT0ZCvDO/mqpxFvzNJ4dF8kg=;
        b=nVINb7tZ20J4gjXMt4jG2Od8ivEd0JIDmTUR/1laABTQoM+c1ZmWoC7ODO1taHiETW
         ShIZ9xxDvaVOMYX8+L8ixj8pgYkes5cb+el9gto61xaEtj9lPIHUvZlkaSFgeJ0o7LLq
         V/jwF4gEE4bot7AsA53ktaqLFx0kRUnEtlTyT+hN1/qori5/q2rz0tonuhvzE3/cwdjk
         UgXxHFhTOfY8+9l9qBP2T9tuYSD56JGTgctpdtcfYkVojapQGF9PK0xqrck4KEoUG67u
         p8aMCnbNm5xC1BLwVEjwSRSdC8h5/YvtH3Sjy3V05at8ceuimX5RVYalh0H1MiEdEOvb
         CVtw==
X-Gm-Message-State: AOJu0YxmBlMnck7vBUVWIBuN774DqdhCwTFels2DU35NDsnvnM0O4a4R
	PkYP2NxHPV118YE0o1XlBwWMV2Z1hSQuEmKeyzCv0GntJoBhGfWNcqqM1w4QiR7LOKk=
X-Gm-Gg: ASbGncs0eRLRfzZ3kWXnWtra0zZkOamUrTWE404vZiIdm0MPAnkBBiVmy4Jh9PABjgf
	IYqFaVRStFpjIVipVZKJ5R7CwsPpFpDBcYQue8OTq8Bn3yJbNV5JcWMg8N1p8FEP6Q93UDlDMuy
	VmqdR7VStbDmIWooaPhbAchcoQ1wWQxykQZmclYxNAMdx32/U8rYEeti6X3AnTolh2JvybYPHmy
	qiEfDq1ZKD43bVz1mRmq6ka+lRXqWPhYoFQzbK+jPoax/FyCsrhVYZrwCayFhp7t6ZR2kuEJoIK
	gyO9/oczPVnF5jZlz5H8MIceBpKwa3uAN58dAlLuiLBFIDmtban9m1Kx09/QTsWT3Wv131nnXDr
	fuTlFXMvJ/9QCkNBHgC/8XxOplwLue5Y=
X-Google-Smtp-Source: AGHT+IEGUe96QpO+yhj0TFVSolWyBs5J+AhnHr1kBbKwy5ZYtlkJ29T9XA1QO7DbsLhlO+sBDuOm6A==
X-Received: by 2002:a05:6122:787:b0:530:720b:abe9 with SMTP id 71dfb90a1353d-530e4875aacmr1132707e0c.7.1749151451140;
        Thu, 05 Jun 2025 12:24:11 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-53074c3472bsm13173572e0c.46.2025.06.05.12.24.09
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 12:24:10 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 2/2] client: Use -EINPROGRESS with scan and advertise command
Date: Thu,  5 Jun 2025 15:24:06 -0400
Message-ID: <20250605192406.909397-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250605192406.909397-1-luiz.dentz@gmail.com>
References: <20250605192406.909397-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This uses -EINPROGRESS with commands scan and advertise since they need
to keep running in the background so they don't exit but shouldn't block
other command from executing in case they are invoked from a script.
---
 client/advertising.c | 9 ++-------
 client/main.c        | 3 ++-
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/client/advertising.c b/client/advertising.c
index 382ae420e663..f9df1b855cde 100644
--- a/client/advertising.c
+++ b/client/advertising.c
@@ -18,6 +18,7 @@
 #include <stdint.h>
 #include <stdbool.h>
 #include <string.h>
+#include <errno.h>
 
 #include "gdbus/gdbus.h"
 #include "src/shared/util.h"
@@ -238,7 +239,7 @@ static void register_reply(DBusMessage *message, void *user_data)
 		ad.registered = true;
 		bt_shell_printf("Advertising object registered\n");
 		print_ad();
-		/* Leave advertise running even on noninteractive mode */
+		return bt_shell_noninteractive_quit(-EINPROGRESS);
 	} else {
 		bt_shell_printf("Failed to register advertisement: %s\n", error.name);
 		dbus_error_free(&error);
@@ -874,8 +875,6 @@ static void ad_clear_service(int type)
 {
 	g_free(ad.service[type].uuid);
 	memset(&ad.service[type], 0, sizeof(ad.service[type]));
-
-	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
 static bool ad_add_data(struct ad_data *data, int argc, char *argv[])
@@ -950,8 +949,6 @@ void ad_disable_service(DBusConnection *conn, int type)
 static void ad_clear_manufacturer(int type)
 {
 	memset(&ad.manufacturer[type], 0, sizeof(ad.manufacturer[type]));
-
-	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
 void ad_advertise_manufacturer(DBusConnection *conn, int type,
@@ -1006,8 +1003,6 @@ void ad_disable_manufacturer(DBusConnection *conn, int type)
 static void ad_clear_data(int type)
 {
 	memset(&ad.data[type], 0, sizeof(ad.data[type]));
-
-	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
 void ad_advertise_data(DBusConnection *conn, int type, int argc, char *argv[])
diff --git a/client/main.c b/client/main.c
index c2321952bd4f..d99a5158e35a 100644
--- a/client/main.c
+++ b/client/main.c
@@ -1219,7 +1219,8 @@ static void start_discovery_reply(DBusMessage *message, void *user_data)
 	bt_shell_printf("Discovery %s\n", enable ? "started" : "stopped");
 
 	filter.active = enable;
-	/* Leave the discovery running even on noninteractive mode */
+
+	return bt_shell_noninteractive_quit(-EINPROGRESS);
 }
 
 static void clear_discovery_filter(DBusMessageIter *iter, void *user_data)
-- 
2.49.0

