Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795641125;
	b=jbf20ri7mkRTFWHo6j6d2U/OvijfriEyZaW2doOxA0TG9ws+vRT5n0zopzEpYmsQccR/
	 J4WYyPyEtHChflzubQb9W7CiRs+wp+k/qp0XgtLUAVakljD7/RL6epvdGFlIsueCuRfoU
	 04y0KezvN7JR10YK0EDFER/C7anlxrofbXvGDahMFc+h5zsBBYnddnuuuztBLl+zpiiPG
	 GGMmwQPEp/Pp85mlJbtTcLXGLsPaE/4C+Z4uTKJ0I8rvpJaT06TQm0UPyXoNSJvZPkT4S
	 1tZjrapbL1nacylE2CGXPchSU0uipa4olEdY+QfEt0FY2ovvNPbRsXHXNPRLInM8wMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795641125;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UKABnKxxs62zNzsmB/Bf+eyh0NdFxRkFtYZxqIxxR64=;
	b=A/cACUe+PW8NRTMyfEu/W1WRSLMDwkMmCtsVegZjqtePq3kAtAHa88YfYDU1IJO1kKs6
	 MNP3nRj7APqpE5k0x+VO4MvHjmB/KzYw2byApIaytCErzAQvlwvsaW5kv3FgF0orjxhkc
	 zTO27e+XXgnTfv25M1rfK0WDS/OWQttRpBqpjEAv5y7L9zRp5uZjNRPUuych6p3dV1vZy
	 zP1cv1w91BRIfZlf3W3T/WXob7IlIe5RfH7sAZZgGtRNmXkG3nk+lm//nGcp6tNLYYk72
	 fojLn4Yhmw4I1B+Ro8AYypH6LT/TBNn2xIwkOSrjyVdBfBtZoWJINqJnZvVtZS9DpLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="UyLq/f+v";
	arc=none smtp.remote-ip=209.85.222.51
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B08606A327
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 21:12:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43B08606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UyLq/f+v
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-990a39ba4fbso1692574241.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 13:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795641124; x=1796245924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=UKABnKxxs62zNzsmB/Bf+eyh0NdFxRkFtYZxqIxxR64=;
        b=UyLq/f+vJ+RjhLDffeKhK+uhi2oJ1MwMAq2Yzwk35OjkMrOhLzPd4TXlE5rEnQTpls
         5GaYzsAQpmG/AilsT457OKeKcOpjyYZUiHxb6hiqHmIWEZX0P6l9rQQIfDcYG+Rvqvlk
         Rl5AsjnUAjnxJOiDA9zoWk1aACnEUzEu2TnS9amnh1UAOR6BBKku3sDs7qodfa5LwFBG
         RVpfgOL5lfcGz+nYTi20f5wX7jPc24qPo+mh7Qo7O49UItoVLhxqfD24lwqgixv0occ8
         kHgRLeqNlK80fIemzyT29mK7HqGPjus0Ryz9Y/JH1vziUAW60ph9rdJzvFNrOnVYxs/B
         UX4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795641124; x=1796245924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=UKABnKxxs62zNzsmB/Bf+eyh0NdFxRkFtYZxqIxxR64=;
        b=l9Xg6NEgQgL7L9Dd6VyJ5uIHhz/A3nfA1JAORiAmkAifdRSoOZBKTd44pdiVMMNKgo
         in7pLo1anLl3xcfs8M4HKmZhTFeeSt4JxQiFKg5SrPCDb3rl2NlDIHNp/t7UylFoWryk
         Ml5dJKfgC+ILd0WhRQOqDQo0Kvw/oo5WHvM0T/uWqDuwQ6kq5U9VZzA9zVlIHVb5Fpz8
         jtBDqoPCvdNl52f42JcTfuVAzQYOYqkyeS/nBU9ocal0O4EGqazu+ZizYcMjJSkxLDnm
         oAXtUcQ/Bm6AwCzS1w536VBqD1wtah7d5JtWl6bONWUuR+qkaopiP+DGV8fM/IC8SUHw
         8l+A==
X-Gm-Message-State: APuU4Z+QxMC44go3/iG8lqVGqpnMGCfScbGSvonQd3we9DOjmGmcq77A
	4HmQFuzUK0idh/3dgx3RRZGyQMNmytUMmG1lvEdAnRY8e1lf626uWxqbgZ5bDA==
X-Gm-Gg: AZFdTZew/kHgackVwmppbEbJk907zlA/LRCO/uZVC1eG6UemVLdyR5pRZGNyRaxid9N
	kUDRZljOK8SPdxSPbRNcYIcf9mZDxnEa2d9atVhaPn7TLngUCr+vOLiHf69qhOIa5RxuhK3zX9U
	1JTZkpWUnsHUD2o9oFhgpaewO0OnlyYFz5r0HnGs8LDR6iVzgnTPgf/Mrv883IknSgiNVgNFMmE
	PX7GvTKg9fotlaEkMhknFz7kQ+BL5PJNdtGYx+kauQ9k5WZt6NUihunRAWmn5gteKTqpT5p113i
	Li7L+ymXpp5CAVmelVWXV4PKWIc+EUaqJGpnBs2Gw7xVSOjqQHpTuYiWN2Pd2j6e0RtH5FvDYrN
	I/9B/Xk9fx0mTxFeww90Nq4yHMl78Xjz45+DF5AyNtZ7kmQ4pT6D/GuYfGWSYPTE+o+lk0U5IaU
	E1yfAetBwrFD/JxJZUDGdFtELGwvG6RxYujsIUydNczEQPqAwkmE/96NGqEHIA3fAc3zokt58JQ
	57SRxB/A5r9pfSmofk9gPKCTqM+K7V7lUIYVt3qZiCN/LY6V2YJe3KpLI05tBkMwuCUcmyRo9GN
	qIRODaL4FYutsKVySz2F6eqjqeIWNvY7Tm45OXIJs7VXjN1AMTEQqODKb61iaYP9safkO2JmH6R
	vXpGNb7Mkqd/o5pNF09RykGj4TdJOpfZVZw60Rh8ya9ya06L0X5LuAl2zGrd+CNdpu+CDbLw8wS
	cwg8kr
X-Received: by 2002:a05:6102:3f4a:b0:7b3:7653:5487 with SMTP id ada2fe7eead31-7d739697f0amr8679482137.32.1795641124112;
        Wed, 25 Nov 2026 13:12:04 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99e6e0686b1sm20199653241.10.2026.11.25.13.12.03
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 13:12:03 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 2/6] emulator/btdev: Add btdev_set_link_key_type
Date: Wed, 25 Nov 2026 16:11:56 -0500
Message-ID: <20261125211200.1955466-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261125211200.1955466-1-luiz.dentz@gmail.com>
References: <20261125211200.1955466-1-luiz.dentz@gmail.com>
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

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add btdev_set_link_key_type() to set the key type reported in Link Key
Notification no matter the type of the key pairing results in, so
testers can emulate pairing completing with a key that doesn't meet
the security level required.

Assisted-by: OpenCode:claude-fable-5.2
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 emulator/btdev.c | 13 ++++++++++++-
 emulator/btdev.h |  5 +++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 1140acd90e7d..7c630718013d 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -214,6 +214,8 @@ struct btdev {
 	uint8_t pin_len;
 	uint8_t io_cap;
 	uint8_t auth_req;
+	bool link_key_type_set;
+	uint8_t link_key_type;
 	bool ssp_auth_complete;
 	uint8_t ssp_status;
 
@@ -1906,7 +1908,10 @@ static void link_key_notify(struct btdev *btdev, const uint8_t *bdaddr,
 
 	memcpy(ev.bdaddr, bdaddr, 6);
 	memcpy(ev.link_key, key, 16);
-	ev.key_type = get_link_key_type(btdev, bdaddr);
+	if (btdev->link_key_type_set)
+		ev.key_type = btdev->link_key_type;
+	else
+		ev.key_type = get_link_key_type(btdev, bdaddr);
 
 	send_event(btdev, BT_HCI_EVT_LINK_KEY_NOTIFY, &ev, sizeof(ev));
 }
@@ -9458,6 +9463,12 @@ void btdev_get_mtu(struct btdev *btdev, uint16_t *acl, uint16_t *sco,
 		*iso = btdev->iso_mtu;
 }
 
+void btdev_set_link_key_type(struct btdev *btdev, uint8_t type)
+{
+	btdev->link_key_type_set = true;
+	btdev->link_key_type = type;
+}
+
 void btdev_set_le_states(struct btdev *btdev, const uint8_t *le_states)
 {
 	memcpy(btdev->le_states, le_states, sizeof(btdev->le_states));
diff --git a/emulator/btdev.h b/emulator/btdev.h
index 097021c01cc5..517c65a19cf0 100644
--- a/emulator/btdev.h
+++ b/emulator/btdev.h
@@ -90,6 +90,11 @@ const uint8_t *btdev_get_adv_addr(struct btdev *btdev, uint8_t handle);
 void btdev_get_mtu(struct btdev *btdev, uint16_t *acl, uint16_t *sco,
 								uint16_t *iso);
 
+/* Report the given type in Link Key Notification, whichever is the type of
+ * the key that pairing results in.
+ */
+void btdev_set_link_key_type(struct btdev *btdev, uint8_t type);
+
 void btdev_set_le_states(struct btdev *btdev, const uint8_t *le_states);
 
 void btdev_set_al_len(struct btdev *btdev, uint8_t len);
-- 
2.56.0

