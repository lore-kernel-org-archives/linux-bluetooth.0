Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAAF285CA9
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Dec 2025 08:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765526972; cv=none; b=XZ/6nK+wVIghaaTugjkS/utq3jMoKpOXNtOQGpjmbXmGP0aw20UJBZrqm3gLe5XfvZf0lpL48dyT7WQRbs1E5DBupvw6E8sjXa56pZLZoxsGUtaxvii7379tFVvSjITu54Gco8f0f/FQGuQ3uN1n8Xr4jPGEsB1G8+yb3vetU1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765526972; c=relaxed/simple;
	bh=IofNINamgUaxUD/ozHNMzT73NVVktMKx/C8cq9MkyxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ua0eQ+DjDlOA7fSzWpla7o++5Em1AZtR50ZNRgR+V2I+WO9ZAHmFmFMbcRAEGcLlalta85vDTqmgO99yMiOcwF34vONL/TkJg85oRk3JJKCyOdsq5vR8tUOQptG8ro3yIsCti/p0FLI1jgCpGT/bXdMXubPOAYCLzJVQNcFBa5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=dD2XmTOl; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dD2XmTOl"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6498850d3f6so1223665a12.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Dec 2025 00:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765526969; x=1766131769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m+39K34vOi8xVQNaAaMN1cV4zjvBZg7Po2C7wx93ufM=;
        b=dD2XmTOlMothUQmH6NlmG5erdDdoYR34KL0j6gqbnhoQ6U2UJoD8Pzoukcx/MBJvVH
         zj0yNe5ZTRBXEGwyYFwpHHWW3buJ9GjicCOFkIHOGb+eHBb9JhMG++LtNrHKcbJscjiL
         kOEsM+9QqwzuAVmMEptyM3/L8LFnVY6IYdso9Z22azFOMnR5cD/n1RBCct4mgJStXfIU
         IkfTD/b93XWG5zhZJcBB1Khw+BxRTkN6KrPNm9MUnzyz+uF4mj+EOAT28f9qexkaLiH/
         qB5Lv9PvMWd9Yj0e92sRwIcRnkexdLKKj58f63os9QVZYn5mPj2ecjkqM1k3UUEkVG4N
         hW9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765526969; x=1766131769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m+39K34vOi8xVQNaAaMN1cV4zjvBZg7Po2C7wx93ufM=;
        b=r7IZT96VGD8ZJWa20RxHPjuLT+6J2/T3m+jRVWt3EeYiEHpScU6N/4v5/Wsx3urFBD
         9GQZrgrSz2IHBO1tsWsRg91IsFZTB22n3KyX+sBPAQeju3uvKiiXMESFsi/Syoi+vNCj
         88TBBFU2typzyIT0QfJ/DJx+6pjWcJMFGOGR1rZjaDk0LIV5Ba4kvdHNXA3g0Sd96vYw
         AiTTxE2WxHoo7mt+RoE/WRxo+oEruqt4BHYVV69kDQwPJ+QOR2E8qUc2UcdwG0CHsF6V
         0TGLTjOz8j5rcDOZHXS6fje0PpYjfscgBpZsrcVIVeJnWeoAoStMmOKJgjEIV230lCg/
         vAmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfCe9YeuulHdPH+mMftB1ayx6CQmOdimZvFdg2Cm3k1ltz+tiGHSmcf8UNQuYJii/20KIK+ao9SJdZrJkFsQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO5RaPNAGzbfhD0asTlIkAH3U9sMnPxSkSsNa/59Xbwb8V4k06
	1wB2YPrX+Ga9BEHzNae1is7pwmW7zvJTQdoWK/sfyWKjQRTTkTjsEGm00AEZdIb/fIA=
X-Gm-Gg: AY/fxX5phGROeIrXA8lEP6PeKceSwfRLlH6hB0hRahGjL59U0gsVkGuu92+2eQjTO38
	KSTC9E0PDOFr5d7UFbfqPoj9oWyPTSzuruWCZL9cI5WNq0Qpkmufv8vzLokq3qseN24+zx9fg44
	0Z9CBccGFtGALQuX3SD+hFQ2jhnll4ti/mZjZsSD/0xhs0rIY5eZVIqhvpQmRwHkcskyj+ktpMJ
	fvCyhrWKheJj63YLRj4KhWsc0xgVjrO1ZLgvLyEz1HWkI7zTBk6YVAvwgan8AyjhrLsg+G/WgUE
	KCPREU0quysAwv10mcq5Rs0VlwXcshnQhyCEG8E9SIp6aj5HAnvMrz7Usy6dtU3jFHl+XFbF/jA
	LbTA1v+QyLRQUJKLQv5+wZmcbQgOuLW9EAIy67wTFZ7KSdVN4DVMsgvMUr7nEdxWVgEvl7itZWB
	kLG+GkV/XeOSd6N6oq1+OwkmMsyz4SNGCVEkOUrWKt+s0nRrykMfVdE1WwvloG1z9zSgNSd6Wlv
	+g=
X-Google-Smtp-Source: AGHT+IGWoL0XbNTGLHz8ZMU3qIOVibIWmHjvpfqntUFsxPPnIC82hljoVzU0mysv424t1g+zGsP5hw==
X-Received: by 2002:a17:907:961e:b0:b74:984c:a3de with SMTP id a640c23a62f3a-b7d238f0517mr103594866b.28.1765526969146;
        Fri, 12 Dec 2025 00:09:29 -0800 (PST)
Received: from localhost (p200300f65f0066082ad4229ee042f7ed.dip0.t-ipconnect.de. [2003:f6:5f00:6608:2ad4:229e:e042:f7ed])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b7cfa5d0b20sm509586566b.64.2025.12.12.00.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 00:09:28 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Rob Herring <robh@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Yang Li <yang.li@amlogic.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Maximilian Luz <luzmaximilian@gmail.com>,
	Hans de Goede <hansg@kernel.org>,
	=?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-serial@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH v1 1/4] serdev: Provide a bustype shutdown function
Date: Fri, 12 Dec 2025 09:09:06 +0100
Message-ID:  <ab518883e3ed0976a19cb5b5b5faf42bd3a655b7.1765526117.git.u.kleine-koenig@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2676; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=IofNINamgUaxUD/ozHNMzT73NVVktMKx/C8cq9MkyxY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpO82lAtuYw6Euh1IHnIa6xp9GNMOn1AaC2Ib0i 9lpX36+U8SJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaTvNpQAKCRCPgPtYfRL+ TqNACACH1o7gDLn5mSsNnqmEeWdHjGGepoGjub0UwowXB0KqPgYNHHlXzwyIqTZHOOQBkbFjNpf vyrAK2pkvbg+a/xWPkX58TZB60Swhut8sU610vYfNubAGFvQ0/myc/EzLQLw/ITKJTyef19yVdu KIOGWMTtaBKXjx9a+dLYM3o77G7gNlAxbbinORTJcte8D73D/fAzsdTHEtgmUaNiwNM+2BZnUTh 0Lgz13OMX3yedVsT2kd9+jx+4VwZV8U2oy9wXgqB9D6UjFWqmYO5gLX2vElXV5WASbcDmyxbnYe EMFzOL/CgtH8WJICT0P4sNqRSy1NLW6ffoZyYeejkOpKXu23
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

To prepare serdev driver to migrate away from struct device_driver::shutdown
(and then eventually remove that callback) create a serdev driver shutdown
callback and migration code to keep the existing behaviour. Note this
introduces a warning for each driver at register time that isn't converted
yet to that callback.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/tty/serdev/core.c | 21 +++++++++++++++++++++
 include/linux/serdev.h    |  1 +
 2 files changed, 22 insertions(+)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index b33e708cb245..40eedc15277c 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -414,11 +414,21 @@ static void serdev_drv_remove(struct device *dev)
 		sdrv->remove(to_serdev_device(dev));
 }
 
+static void serdev_drv_shutdown(struct device *dev)
+{
+	const struct serdev_device_driver *sdrv =
+		to_serdev_device_driver(dev->driver);
+
+	if (dev->driver && sdrv->shutdown)
+		sdrv->shutdown(to_serdev_device(dev));
+}
+
 static const struct bus_type serdev_bus_type = {
 	.name		= "serial",
 	.match		= serdev_device_match,
 	.probe		= serdev_drv_probe,
 	.remove		= serdev_drv_remove,
+	.shutdown	= serdev_drv_shutdown,
 };
 
 /**
@@ -814,6 +824,14 @@ void serdev_controller_remove(struct serdev_controller *ctrl)
 }
 EXPORT_SYMBOL_GPL(serdev_controller_remove);
 
+static void serdev_legacy_shutdown(struct serdev_device *serdev)
+{
+	struct device *dev = &serdev->dev;
+	struct device_driver *driver = dev->driver;
+
+	driver->shutdown(dev);
+}
+
 /**
  * __serdev_device_driver_register() - Register client driver with serdev core
  * @sdrv:	client driver to be associated with client-device.
@@ -830,6 +848,9 @@ int __serdev_device_driver_register(struct serdev_device_driver *sdrv, struct mo
 	/* force drivers to async probe so I/O is possible in probe */
         sdrv->driver.probe_type = PROBE_PREFER_ASYNCHRONOUS;
 
+	if (!sdrv->shutdown && sdrv->driver.shutdown)
+		sdrv->shutdown = serdev_legacy_shutdown;
+
 	return driver_register(&sdrv->driver);
 }
 EXPORT_SYMBOL_GPL(__serdev_device_driver_register);
diff --git a/include/linux/serdev.h b/include/linux/serdev.h
index 34562eb99931..5654c58eb73c 100644
--- a/include/linux/serdev.h
+++ b/include/linux/serdev.h
@@ -65,6 +65,7 @@ struct serdev_device_driver {
 	struct device_driver driver;
 	int	(*probe)(struct serdev_device *);
 	void	(*remove)(struct serdev_device *);
+	void	(*shutdown)(struct serdev_device *);
 };
 
 static inline struct serdev_device_driver *to_serdev_device_driver(struct device_driver *d)
-- 
2.47.3

