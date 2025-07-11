Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A83D2AE66
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Jul 2025 17:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752255389; cv=pass; b=DcRW46om8SFt5jVawDNPN37B1EFT7f/dexHFOfjuFz+sBXCVzlI6byM1034rdRG9KXRZ7yJbagD9KDFflUQyfej8bSPeUBCvAXo7aDsLL514yM5gmCW4oI0+9IWwV02wZjX1jffX0mMnmrk3jg/cv9DGhhU1evBNnArAhgqc5uc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752255389; c=relaxed/simple;
	bh=0i9+MTkFnQvDUc9akGojXkt5l04XHqyVOW73Xb5GYQY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LJNVbTi1ZUxFRsW7bYdV13oQFJSnmkuTkucEgI96TjUpDgM3LLWEkQNTIOnI7dSOdP87VVn5M7w3EEJcsMuohWjowZc77KyKfdWLkZb0W+djUQEucNbciRkT5xjUhKaxdx6dEfmRD6/CG8tv3m7Em/OZDl5O7JgshWUZk8dWEcU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=urBeRwOG; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="urBeRwOG"
Received: from monolith.lan (unknown [193.138.7.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4bdzQq0W14z49Pv6;
	Fri, 11 Jul 2025 20:36:18 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1752255379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iOGL+VGecU3sEbTw9+m7Y2bxh7gzENMRvmXYTUDq4+0=;
	b=urBeRwOG8JIOHfXinM96KGWUiY/8s/kdt0SXT9SdsMBir/9D3P0cqI/gk2PgVW5IyGUjXW
	o6iy7gw/a9v03nyLcfzhNRz8dt0VIohGJKiGsdRL9+tUcLT5dvKRKuHfJnfZ4WWrvSTtd2
	au3RgBplC78WE//uHl3KMK2fzovUtotHWjs6T/jbfw1Hts6VfFfAw9PmHUa8jAc+JpNIBM
	3+HvhsXJmumNAorMZddVs3MK4ekJvXhC+o45cW/vBVrPSF5UP6JTPmsJwshpHAiQ9jZoUS
	dMKTkRAmoTDD7jjPa+JpV49ba7RZ0SmDV0xqIcaPOqumRZPEpLbR6cmETDHfDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1752255379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iOGL+VGecU3sEbTw9+m7Y2bxh7gzENMRvmXYTUDq4+0=;
	b=IT9QkXdaUGMwG8Tk8zoFtJGK8fIkDlhOVVjsW6yNos0L+RFw41BV/I1YoTl+FlprMIflJX
	pdaMPd88U1pMdeqhVpMKMDzKSdMlqb+sPfQJuY/0cBHscJ+7Lkk5647qWnSz6TkVvmTPKf
	NKNt4YmCL/Y+mtUkShyg3+zqFkPuqyaQeEaLq8cY3FSgVXNMobylQ4qyhIK9j/5BS3pGEs
	HXtX+DHMqZtDdOIw0Vnq2m+Xar6fLf0N/dDOqwwc7WNtZp4+WgzSX+U4yhUUzQHDki0835
	rwOAxZLqIeLZa41Lkw5rXt69MoXRyGxvsDxc+9QKq0Z4yKW+MoiZsW0ZIADK9A==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1752255379; a=rsa-sha256;
	cv=none;
	b=E+AumilcsBIL7IhbncYwjaTGREiD8wB0B1Y5d4/RJwsf8BfSCV9qbVK9i5xToSwyxqChYY
	td33By20RBDbL2L7WG6tzaA0pG0UOuPcymAaLH7wmoKf93AvbjuSMrRKTUAugFAREk3B5M
	Bs08QRqgitfG7KUDOxwKwDwQ/sMvQT1HRZ5oUyVmy8qTXBTVsfjOqXNs9LUJjBOreRbKed
	xL6jBhqUpZg2XrierAvAELtYYXdqgZmExs4k8nv60bluZzWdopi2mbpC5bJbP/KKoLdVgu
	SxRGkLNVFlA+E9MiqR42UvUE1oubD0sfnoRDemimiIusMfWN+aByoQjFJ3z+xg==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ] profiles/battery: handle reversed ordering of CCC and value
Date: Fri, 11 Jul 2025 20:36:15 +0300
Message-ID: <f16f76956a16625d436ded521cccd47a0786d117.1752255326.git.pav@iki.fi>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Order of batt_io_value_cb() and batt_io_ccc_written_cb() may be reverse.
This causes device to appear with 0% or missing battery percentage,
because batt->percentage is set on the ignored update so the initial
update is lost.

Fix by saving new initial value, if battery is not registered.  Also
downgrade warning to debug message.

Also check data length before parsing it.

Log (Sony Linkbuds S):

src/shared/att.c:can_read_data() (chan 0x7c31eea05c50) ATT PDU received: 0x1b
profiles/battery/battery.c:parse_battery_level() Battery Level updated: 87%
profiles/battery/battery.c:parse_battery_level() Trying to update an unregistered battery
src/battery.c:btd_battery_register() path = /org/bluez/hci1/dev_CF_D2_4D_EE_A2_1A
src/battery.c:btd_battery_register() registered Battery object: /org/bluez/hci1/dev_CF_D2_4D_EE_A2_1A
profiles/battery/battery.c:batt_io_ccc_written_cb() Battery Level: notification enabled
---
 profiles/battery/battery.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/profiles/battery/battery.c b/profiles/battery/battery.c
index 5be78ab14..2f5be48e9 100644
--- a/profiles/battery/battery.c
+++ b/profiles/battery/battery.c
@@ -91,16 +91,19 @@ static void batt_reset(struct batt *batt)
 static void parse_battery_level(struct batt *batt,
 				const uint8_t *value)
 {
-	uint8_t percentage;
+	uint8_t percentage = value[0];
+
+	DBG("Battery Level updated: %d%%", percentage);
+
+	if (!batt->battery) {
+		free(batt->initial_value);
+		batt->initial_value = util_memdup(value, 1);
+		DBG("Battery not yet registered");
+		return;
+	}
 
-	percentage = value[0];
 	if (batt->percentage != percentage) {
 		batt->percentage = percentage;
-		DBG("Battery Level updated: %d%%", percentage);
-		if (!batt->battery) {
-			warn("Trying to update an unregistered battery");
-			return;
-		}
 		btd_battery_update(batt->battery, batt->percentage);
 	}
 }
@@ -111,6 +114,8 @@ static void batt_io_value_cb(uint16_t value_handle, const uint8_t *value,
 	struct batt *batt = user_data;
 
 	if (value_handle == batt->batt_level_io_handle) {
+		if (!length)
+			return;
 		parse_battery_level(batt, value);
 	} else {
 		g_assert_not_reached();
-- 
2.50.1

