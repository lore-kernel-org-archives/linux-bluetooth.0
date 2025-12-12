Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A8430BB80
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Dec 2025 08:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765526974; cv=none; b=AW4D8+aiZAsleV7etK9E8pUM0kchCX9RDi2Mzf22OcLiQ4NQCLs6ISRXb1lnfwJy2AjwziKUw5KJ6giLDhxo/rd1G1DVuV9Cx3iQ8lp2C9uWTSVRjrBXcBcodIJJR3hnElqDG8fG4JsV4SbjJrz7UcYOHBkv6w9earOc+AykLrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765526974; c=relaxed/simple;
	bh=b3+1BSHKEriE+BOOjhyU+Q5HfXx5Jit8fTz6x7xXDrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ug3ot3cRkpXqTUcXzvfWWgQToMTKj9nm3pivs5IF+q6p/8pefSEsOgs/mTaszxoVPF2ED2G544YqLva6jLs61treNeyadEmgHm+YCjxA3qHKZWGCBtBPjpcQctHGIzHCdxWLztRLJEFRb4GPoZICprMX2rY49JP+osz90ppvngs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=XyZtPXYs; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XyZtPXYs"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b72b495aa81so176682766b.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Dec 2025 00:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765526971; x=1766131771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IDvoRPxfo0UTLmrRXNNxMV8vgJCyHqctKOanwR/car4=;
        b=XyZtPXYse1eMN0KSWaAZfoGQE3dDkt+gh2G4oaoot5GdsVECXtOX796AczaiHWD/1A
         m5SqP19L9dtRgH2jr1ncDN1s9n48By5oRBjeTVtYqVxG2LPbPMaHLy9+TUeP9VWl6+Wp
         wfk7jTDkPjSl4/BJ7MqiwmYu/ed7z7Mmv7TownGiCC9FD0pJnlDrFVMvMhktrRe1ZPA8
         zUn1GrhWUOYXfl6m/0ufYM0+mynh7Fnnklh6kwJFf075udBwGuNy7Ju7+z8foDF944um
         T2golp8ZMK4/dsQCCTlnFcQ5uhSOVTdAg4Ff0LJGsvvArgKwuGH3s1/9XB7Ul7ay7CwW
         IZtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765526971; x=1766131771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IDvoRPxfo0UTLmrRXNNxMV8vgJCyHqctKOanwR/car4=;
        b=LxrQ8x+bThOjQg5r1zqj0FnobxsnhcNJJMzcf2NemQImCLFRYFNMdoujmLfP06Z19M
         lJPurGUOyGJQoTjZriARSudYEZshGwMHbu//4+paewjZtv1RVT1+l0JtRvbI4yVNj8v8
         K2HoAJcYnlJ1gC6ofMCyUA0IG4KUd4ppAAMt3OJxLsuu8ItQF3RhxeLNyiTob9F52Yld
         TUGA6+b3EURTJnGSUbCd3l2VhlLJtA1FvXc0xEfhzURAaSG4ab59z0KSiqaZTq4BFSpH
         QcH3yAWZ7MD6sBswvaamzZJ8w7VJSCqwK2w6Iby+EhIxlGtDp/MIMYAnbnsU2iOdfhvf
         Ry7w==
X-Forwarded-Encrypted: i=1; AJvYcCXsinc3+QBwuV4+1/+1SQq5L51IAp9LwwJg9U6y5u9srR/47/Si+YqRfw5dqFMzLq+Pa78E6uwqxwgTc7pRH+w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/EveSQsKUp81aOxvVdUNgagdaaZMkt8XW53uh/HqaQwfTK0I2
	HfM7BXe20QJIAOGtMpx0wLMfqGAOvlw9RqsOA7ep1YA2daOEAlIyZqIozxWBX3q3Gfo=
X-Gm-Gg: AY/fxX6+2NZGvjACPGbgIxLSS1a4ckNVioH7s6uJ2qDd2m/OlR0qnx5iU8aV74SNChq
	ShMfI6aw+gzd/NC3KoOFm8CBxNo6L1Fx80T7ygy88Vy1eGUN5dp0UYq+qsKe0fTHFybMhZWxzAs
	kbvZ/15qvlE38LPFBq1owwPh2p7Awq0W4IMj/tbLYXFHQmwciq0YQzLKOBdnYVOGxtiLZ0c1bwo
	z9jrQ1qvJWkF5dCnp/IOOo5QeMYNhVlzKJ7y0aI/d+pnDwll7sr4vi5H6FAFP/z/EmGN8EIp5pJ
	f63v8U7OQgCGZvTfDDa6WNjW4+ZO/d20rRtmiHWqoDQ2MA9MgD5oe6jpuDehc+ItgUqW0aR4Azy
	mjsunupVLTqkDD5g6oYOJqcOz9vUO3r9RfzfFSXjJrz3M9EtTHaxeyu6//XS54CtMreTv09JEG/
	EJwZFgkJSDVcCBWqXm2TiVAWr72QWe6xIKXrRIZS8FDJHF8KxJli3EgMILBc4M0H3whs9KEFwko
	/I=
X-Google-Smtp-Source: AGHT+IHeyrUIhI68db/u51fxRe26pbqUxpR5tNRuOVM2VMrH9A3LQUK+QM6QK97/qCgE0PIxKDZHdQ==
X-Received: by 2002:a17:907:3da8:b0:b70:b93c:26cf with SMTP id a640c23a62f3a-b7d236f77f7mr104437466b.6.1765526970683;
        Fri, 12 Dec 2025 00:09:30 -0800 (PST)
Received: from localhost (p200300f65f0066082ad4229ee042f7ed.dip0.t-ipconnect.de. [2003:f6:5f00:6608:2ad4:229e:e042:f7ed])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b7cfa5d0b2csm498924166b.66.2025.12.12.00.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 00:09:30 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Rob Herring <robh@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Yang Li <yang.li@amlogic.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-serial@vger.kernel.org,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH v1 2/4] Bluetooth: hci_aml: Migrate to serdev specific shutdown function
Date: Fri, 12 Dec 2025 09:09:07 +0100
Message-ID:  <42ae20ba70ff6fbbbd9b846ac9acd0f7d58451b0.1765526117.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1765526117.git.u.kleine-koenig@baylibre.com>
References: <cover.1765526117.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1654; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=b3+1BSHKEriE+BOOjhyU+Q5HfXx5Jit8fTz6x7xXDrM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpO82oZ0+ufEWq9BUz7hwiwmpxKZNjR7wVzyr4h ZGJh85xmXiJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaTvNqAAKCRCPgPtYfRL+ TtERB/42rvY7gjHYPHZyLWJgAXlhqzGYAqtP+GP+5kdzrAbEsNDdSD23dV+619mDjcSsuap4ZqC LgVdWJ7lQ5o6mxtwhCc0nkvtvyUYbhe16QCyId97/3m7B+KHLrmPM8jFeJ0B4h+sh/kEHJsCPAZ H0NeXrZ2JXziLZkzwpxskyMzx3MzasvNzSX85x+OYrcv7w6LI5Hq9Xz1KWTR32pWaE/ZEixvpsA s7bzY/Pl0FyrBdAyiIiz0z/c+gEUSjsTjLnQODOM7BuCPjaBkor4uSY28m28d2xoJH0e5NSJt3t 3BHh/mNxXp/8eKmZ2+cseQb13X+WmULqSPJnjsJLvgO20ZJQ
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

This saves a cast in the driver. The motivation is stop using the callback
.shutdown in qca_serdev_driver.driver to make it possible to drop that.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/bluetooth/hci_aml.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/bluetooth/hci_aml.c b/drivers/bluetooth/hci_aml.c
index b1f32c5a8a3f..4981c82d634d 100644
--- a/drivers/bluetooth/hci_aml.c
+++ b/drivers/bluetooth/hci_aml.c
@@ -677,13 +677,6 @@ static const struct hci_uart_proto aml_hci_proto = {
 	.dequeue	= aml_dequeue,
 };
 
-static void aml_device_driver_shutdown(struct device *dev)
-{
-	struct aml_serdev *amldev = dev_get_drvdata(dev);
-
-	aml_power_off(amldev);
-}
-
 static int aml_serdev_probe(struct serdev_device *serdev)
 {
 	struct aml_serdev *amldev;
@@ -714,6 +707,13 @@ static void aml_serdev_remove(struct serdev_device *serdev)
 	hci_uart_unregister_device(&amldev->serdev_hu);
 }
 
+static void aml_serdev_shutdown(struct serdev_device *serdev)
+{
+	struct aml_serdev *amldev = serdev_device_get_drvdata(serdev);
+
+	aml_power_off(amldev);
+}
+
 static const struct aml_device_data data_w155s2 = {
 	.iccm_offset = 256 * 1024,
 };
@@ -732,10 +732,10 @@ MODULE_DEVICE_TABLE(of, aml_bluetooth_of_match);
 static struct serdev_device_driver aml_serdev_driver = {
 	.probe = aml_serdev_probe,
 	.remove = aml_serdev_remove,
+	.shutdown = aml_serdev_shutdown,
 	.driver = {
 		.name = "hci_uart_aml",
 		.of_match_table = aml_bluetooth_of_match,
-		.shutdown = aml_device_driver_shutdown,
 	},
 };
 
-- 
2.47.3

