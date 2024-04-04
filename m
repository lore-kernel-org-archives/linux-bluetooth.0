Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71941391
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Apr 2024 18:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712255467; cv=none; b=SeiDaqO62juqtK0Y7WdqYI0GqFqdEDyVowS1P8nIX/n83snYAq5Qd1VKwvMg4q2AjHftzmAZlekBri6CyTMs4JZswU/sdNuIs5XQCVEmTw9Doms1KBFd3FksFUplazW3mPhWkVGuu/1wpYqBNrZLr9gKHlgKWyxsrXsa4/UZM+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712255467; c=relaxed/simple;
	bh=5MvbRHUxpUjnrTvwTr4K/d9h/+BsRGepOTHTB/QAmSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R3c0fzpczp2gYARu0cYXfh2yaCaXHRk3IGfYx9AQ7ZFt3WOa3obmS9vV9MtYMPDOZAWCKK55zpKvSjIhozR7/nltIPzoARPZVGRoBLF2S8mFunYUCUpf1DbJ3HXLrfG2pteBfnzirP5168ao6TkPrTcEv0GejEAeOz6zje+wjWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eFmqb62r; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFmqb62r"
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-6e6b6f86975so979416b3a.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Apr 2024 11:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712255464; x=1712860264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t7XAs1oVmXtPQ69chZaMcCwOGj6flcaWL3dZ95DHy9k=;
        b=eFmqb62rsVv2zX7UKFxkRNMy0HjanY0wxIvAoj2facXhd5aCHGfl+AEZdoZOK/E3Qa
         OYFvtNib0H9SwLNLnGk22qU5kISkwtdQQnNs2g9nBO6pWVmQCOoflpw//jdxFqNNFwkL
         AxJm8jXOvbOiBJ6UE2xZbGy7P/P8/ydOoZtVidnFeTFm6fFgi4a2WFzsuiha52s9WpMp
         asTUsNniAGCIICfs+ohg2JPEqXUrU8EHgYMAeNj+dR9hqqPkMvrB6wTlqc1hYKatmxFY
         ToiNn6ooBN0uZGdFgL6ambZ0rHexSfboWtgZlRM8aB3+e2OuAbn8OSEHh9yGCFekYeGh
         C9nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712255464; x=1712860264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t7XAs1oVmXtPQ69chZaMcCwOGj6flcaWL3dZ95DHy9k=;
        b=ZTgp0iDDsiEfoehsfHmFg8FpBYekzgyhwnWSEs8HGkRVvsWhlaO72f2wHSizmY7N2Q
         aiIexIPAvvdco1e6fyZCKbYdc20EZZZS0iu+2bFC5fmMUIJVh8d4eR8gAG6WQjrmpF0o
         Oid+t6uQqD7o7WifUUbl6KUqoR7Ay4qjKwh4j73xyKqgWwSAooLiqekZSMcq381Q1kj0
         R5Zw/Q2wib2+Uv4DAOGoYK/LZu+P+SHbn0H6ElCvfkGzPwFlwQmXRqLcbhbtJsDLoMPz
         jSAcJnLQlYsEuF6m3Vkcpj43hq9h0uf07gV9a/SJ8exu6trdbm01uuW53osvXgzrBzF3
         6Jkg==
X-Gm-Message-State: AOJu0YwWm5iPuMth3YGFvwKo8h9wHudfncxhBNbH/Y/Ie7FJ7twLQkN1
	eWllw3ajqRk7pVW86MkqJkrLEeXrZ0lVhetbGBHuoDp9k4nlmkmZNWMBuOzIgdOrbe2q
X-Google-Smtp-Source: AGHT+IFtmJWI1mqf0csojOnwNCjOfNP+HzPmQGPWEXvDzvA4Q59DaBTUnbDH45zUW+27aNd2UqrJwg==
X-Received: by 2002:a05:6a00:4609:b0:6ea:e2d8:487 with SMTP id ko9-20020a056a00460900b006eae2d80487mr3572368pfb.17.1712255464407;
        Thu, 04 Apr 2024 11:31:04 -0700 (PDT)
Received: from angua.lan ([2600:3c0a:e002:7f00::1001])
        by smtp.gmail.com with ESMTPSA id n12-20020a056a000d4c00b006ea8c030c1esm806239pfv.211.2024.04.04.11.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 11:31:04 -0700 (PDT)
From: Dimitris <dimitris.on.linux@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dimitris <dimitris.on.linux@gmail.com>
Subject: [PATCH BlueZ 1/1] refactor bearer connected test
Date: Thu,  4 Apr 2024 11:30:50 -0700
Message-ID: <20240404183050.334414-2-dimitris.on.linux@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240404183050.334414-1-dimitris.on.linux@gmail.com>
References: <CABBYNZJjSp74CoJU2RYCft_nQi85EWnk9JOvyxMH8YmAtON+8w@mail.gmail.com>
 <20240404183050.334414-1-dimitris.on.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/adapter.c | 2 +-
 src/device.c  | 7 ++++++-
 src/device.h  | 1 +
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 4bcc464de..017e60233 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -7486,7 +7486,7 @@ static void adapter_remove_connection(struct btd_adapter *adapter,
 		device_cancel_authentication(device, TRUE);
 
 	/* If another bearer is still connected */
-	if (btd_device_is_connected(device))
+	if (btd_device_bearer_is_connected(device))
 		return;
 
 	adapter->connections = g_slist_remove(adapter->connections, device);
diff --git a/src/device.c b/src/device.c
index 5e74633c6..74dd67a09 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3273,13 +3273,18 @@ uint8_t btd_device_get_bdaddr_type(struct btd_device *dev)
 
 bool btd_device_is_connected(struct btd_device *dev)
 {
-	if (dev->bredr_state.connected || dev->le_state.connected)
+	if (btd_device_bearer_is_connected(dev))
 		return true;
 
 	return find_service_with_state(dev->services,
 						BTD_SERVICE_STATE_CONNECTED);
 }
 
+bool btd_device_bearer_is_connected(struct btd_device *dev)
+{
+	return dev->bredr_state.connected || dev->le_state.connected;
+}
+
 static void clear_temporary_timer(struct btd_device *dev)
 {
 	if (dev->temporary_timer) {
diff --git a/src/device.h b/src/device.h
index d4e70b7ef..5722ca9ca 100644
--- a/src/device.h
+++ b/src/device.h
@@ -104,6 +104,7 @@ void device_set_rssi(struct btd_device *device, int8_t rssi);
 void device_set_tx_power(struct btd_device *device, int8_t tx_power);
 void device_set_flags(struct btd_device *device, uint8_t flags);
 bool btd_device_is_connected(struct btd_device *dev);
+bool btd_device_bearer_is_connected(struct btd_device *dev);
 uint8_t btd_device_get_bdaddr_type(struct btd_device *dev);
 bool device_is_retrying(struct btd_device *device);
 void device_bonding_complete(struct btd_device *device, uint8_t bdaddr_type,
-- 
2.44.0

