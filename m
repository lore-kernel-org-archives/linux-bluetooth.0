Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794941874;
	b=W/VOTVbdwmofvoyweVtPu0mAvc0L9AbRDdpn7b2AsA14fmD8bxroJ32YvGCA8G6kPIl1
	 uyYQMVmKNa9yIy18JcHQZRDvVvx2wTvAPG1ehBUr717MzOr4ZsC3Fjzm7Wbi5IsPV3BCG
	 UlkwwUcfzNgqOk3oREK7IDhyb/V6rQmFS1qi5yrP6tioOXkh+ei9pI+2y3j5mEffyUNBA
	 hHSdbAtVUgtIZ5vEaI8znW53903APVDNszSWsN6L7Pm8GMBOjSRm1G/SpYzt0bsv7nGpd
	 /psuNUsSp12ArvzLxFX7r5Tb3j5XXFaoilckldpLfWJjukxP9bxU/DBUBUOiODNgzdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794941874;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+AEfMIF+mgvhpOHgGu+qv2X7Ms4sk4cTGBMC83O3Wj0=;
	b=B4XT60FLx+I2hf9RzC5cXBcsq47uzAa+X6z8V0VfT46D2uQoZMiQpbQnK1gZMUpq5A9p
	 xOGu+ZJQbftdUTXeKpgpvCHq51oMh0xTbdtlemwFX0GcumLN1kiY3FBj8KznNcGfzwjMC
	 0ftfvy4i+7DM5TJJIUwoEnNiB5+xH4DjlQSi7t5BBu/xZiG9Zn0aiFyhjm4by7eDBdWiV
	 byOoGuotQM3kNZQ4Vgyae/j8u5qgUGpiXwnfXsBIiTn5azg1pO+2v6XtfyAQw3sdqFNQE
	 BFswSz274cvhPeys4z0rxk0n9JrDF3aO5kI5GI2fxLDhgpbeQYGTbRuB6URcgerOmlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lsDkZBsP;
	arc=none smtp.remote-ip=209.85.217.46
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB126606A894
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 18:57:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB126606A894
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lsDkZBsP
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-7d2dbc0a8d4so41182137.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 10:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794941873; x=1795546673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+AEfMIF+mgvhpOHgGu+qv2X7Ms4sk4cTGBMC83O3Wj0=;
        b=lsDkZBsPb1Q06QF/VOkkB9MH7K2DQ7DJEYzySJQ8j9KGwMQ0GlvVAUA17QZjYUKO1g
         YScciPyrwrlxYXs2KzZ8zfOWq6OXWddhCgDxUQxxlOunEar2TfJo0QNZ2vc5GgPiPWc9
         Olq9V0hfEWE7dRj3zJiSEURZqddmsvgBY9R8ejuy7XsR9A49e2k8iW7F9IHQ/wiIRbNO
         SjEC24ZBuGfwyoQnvuZLG0lpx/oknVjsgAJ2IM3YWByNWH1nguP/wTm1gYfTt//KQr/7
         qsx2pKb4GCT6vz31fMEgEpXPH3n3zzaycpwPyVEpcsvzjrXChzUdSEDqPUnZ+JyG+c9G
         98tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794941873; x=1795546673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=+AEfMIF+mgvhpOHgGu+qv2X7Ms4sk4cTGBMC83O3Wj0=;
        b=2Ioy8d8Sv7+xc8xDBeg/sJkWEiFcCazIoV/PVyf5Zb9zp3+wF5xyTYlzL0nT/mRjqP
         O9+Nom1P35vX1rPZ4/yqKk/SOZ7QmDe7sBBFM8DWl7rONKHn44lQgyddNNjuf3Pn3lUj
         rJfCAkh3lPh8MoUzHDCBNIXu3ksqzLJpPbPnDojz0d1CeRFXlFvzcy3M9z9TwLMaSlDr
         R4TBZLORQtYOLvdErjABmaOqUhZKqSMgxnez8yeJUknowmqRmTawVVltbjH/o3bUM/6x
         lSsLpmHxLRu/bL/+3vfZvdzvkcIhD5YdHfV2mFdJC0wLFtA8865ppkMzbu97ugSUkBiN
         hH5Q==
X-Gm-Message-State: APuU4Z9mbrPF29EwvUjNocY72nhS2jg1zkaU+7e39n93OAR52FfOcp4f
	s17ZaiA1oYM48mAtreGEHoxyvxUvaDsy4WvyF9l0lxjAq0tucvuIi8uol2B0nw==
X-Gm-Gg: AYBFou2hVzgZrwxIIIf9dtay5Sk2isLlza3suKsXg7Ps/DI5aDtkubmifnPcnYESfku
	nCyKp6rHaowJMyjvlMshlXIGwywCx9ac3SwM2XUuygwELL5QA4dQd29y2a0YGJixNNbuM1UtRbT
	73kl3Ph1UGs3VCCMz9ckhDGcJY0pCB4TLSixk06aQKTpjMfJEfQhlcLeu7ZW72YdyMtynrtUMFN
	9MfYufEFaPB2baNzGvKFtTzhkVuJhCcM3t021bqzJsZQyc+bwFCNylCHBt1slAk0z01OBwP6w0o
	mA7kXQfHf8GYQ4nWfk5JbSRLiNZmieNYMxBFKzwGqootgg6NUWnXpvt0ruNcuWdUYm0ZQqsFhhS
	sbJiUwgiZDmTSL6VJlDLJL8Lu93aiWAxYglvbO+FP3OJzrYikWOLkL4KMb7coVYv9ZeB6t+4avm
	4tAK8cKVqPVHzZq0SrbxDHAA1a3535YTt0xsCjiN2cuqYJNUOZCUNvKy9cIkUqu/2o7OmITWzxA
	ueUED+K3PW1+J93zid6ZJPMLhPCLKhmbCnDzDcafuRQHM4+q8g+5xaK5jhGchI/i7rxJ4aS/gmz
	3Xk3xTF7eqkkbuN0JXdtIrLP3MwNYhx/0DYYuzuwJqneV6WdcA+a6/CgNYtGsXaagrCBOTlSbGU
	2hOrv79HrwmtJmzJtXQKAAWKUrdGhF+ivmga5vOU6+WBdy7zBom/+vtGrDSromKetsLFiyHImav
	UwkhXxDyWDigxqzUmcvoAiiS3p
X-Received: by 2002:a05:6102:3c92:b0:7c3:8150:83e7 with SMTP id ada2fe7eead31-7d64d6db6dcmr4042735137.9.1794941872493;
        Tue, 17 Nov 2026 10:57:52 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99e4a1b61eesm357064241.3.2026.11.17.10.57.51
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 10:57:52 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1 16/16] Bluetooth: RFCOMM: Serialize tty device reparenting
Date: Tue, 17 Nov 2026 13:57:37 -0500
Message-ID: <20261117185737.3758255-17-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261117185737.3758255-1-luiz.dentz@gmail.com>
References: <20261117185737.3758255-1-luiz.dentz@gmail.com>
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

rfcomm_dev_shutdown() and rfcomm_reparent_device() both move the tty
device to a new parent with device_move() without any synchronization
between them, and shutdown tests dev->tty_dev->parent before moving, so a
concurrent reparent can race with that check and the move itself. Serialize
the moves with a mutex and perform the parent check under it.

Reported-by: sashiko.dev (linux-cd8016c2-2358-40f0-b65c-091f6a957f67)
Fixes: acea6852f32b ("[BLUETOOTH]: Move children of connection device to NULL before connection down.")
Assisted-by: OpenCode:claude-fable-5.2
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/rfcomm/tty.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index 198c7dd1a95b..274cbf5e36d7 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -123,13 +123,22 @@ static bool rfcomm_dev_carrier_raised(struct tty_port *port)
 	return (dev->dlc->state == BT_CONNECTED);
 }
 
+/* Serializes reparenting of the tty devices, device_move() doesn't protect
+ * the parent from concurrent moves of the same device.
+ */
+static DEFINE_MUTEX(rfcomm_move_lock);
+
 /* device-specific cleanup: close the dlc */
 static void rfcomm_dev_shutdown(struct tty_port *port)
 {
 	struct rfcomm_dev *dev = container_of(port, struct rfcomm_dev, port);
 
-	if (dev->tty_dev && dev->tty_dev->parent)
-		device_move(dev->tty_dev, NULL, DPM_ORDER_DEV_LAST);
+	if (dev->tty_dev) {
+		mutex_lock(&rfcomm_move_lock);
+		if (dev->tty_dev->parent)
+			device_move(dev->tty_dev, NULL, DPM_ORDER_DEV_LAST);
+		mutex_unlock(&rfcomm_move_lock);
+	}
 
 	/* close the dlc */
 	rfcomm_dlc_close(dev->dlc, 0);
@@ -187,8 +196,12 @@ static void rfcomm_reparent_device(struct rfcomm_dev *dev)
 	/* Just because the acl link is in the hash table is no
 	 * guarantee the sysfs device has been added ...
 	 */
-	if (conn && device_is_registered(&conn->dev))
-		device_move(dev->tty_dev, &conn->dev, DPM_ORDER_DEV_AFTER_PARENT);
+	if (conn && device_is_registered(&conn->dev)) {
+		mutex_lock(&rfcomm_move_lock);
+		device_move(dev->tty_dev, &conn->dev,
+			    DPM_ORDER_DEV_AFTER_PARENT);
+		mutex_unlock(&rfcomm_move_lock);
+	}
 
 	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
-- 
2.56.0

