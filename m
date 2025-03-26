Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145B318DB19
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Mar 2025 19:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743017506; cv=none; b=qOFv5ISubqbOUqx8px8KAI2HWKXaIOG6GUbmqnmAaMn5b2V3WiTku0rvKVuL6tn6QL7pVCL6rQFXkquK9dR9rRQX5duwHmomwPj3sPWzz6UyVf5gm9kT+O/OX+a/Qk6X/md7l5Xpm97wVUjp/WRmpQ9EwLaUB3DFJSz7jLOJyp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743017506; c=relaxed/simple;
	bh=TzE4sWl67jzUR5nMTFd7OnUN0ibDp+vZF27lcsfobaM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qb0eSz5SDRglWbbMd4095jzleqDdaXItNqC3Sot/YNHUYL35BikI8U2gcyWqErlpd9QuWLvabSR6e8GG/BxPEuoSOYB0kw59+uLiE6ItGjK2NJOkNqIkVk/6sT2Ah6t0U/9Of5oTe6jp22NNkkVssAj1KK6gZ315FOGnvSj6xz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V983NCJO; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V983NCJO"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-86d6fd581f4so1144834241.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Mar 2025 12:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743017502; x=1743622302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T3SRuHLKAOKf7El2v2wYycMLbTwvDLlYXfZbdRUo32U=;
        b=V983NCJOGV0woxkfbVtsJF0N+TzKnNvBuWYSmWWDWyOg4kB+rJaZeRPhaj3Paxzk/w
         sV2HlloKNv3/5yg+lOfX5ygGbJ7AW6qnG2uJhFRRqDsqevXK/Mie1tRovVpz9siSXh06
         0062lnH2tMJOK06uyH/9eh3hPg9WUbP0j4tQP0/ykfwBWJ4zrkhRjSnDe6kx6Gs0PTrX
         A3pTQhm5u/HwsCVNc/aWegIGrQWiTdKdw3fCMygxLQeja6IEqnrm2go3g1buDubmJqsv
         yVs/zB1JDN0eS0/1JEVhZIkXvlfC7vE7UCoHU4uoOqpNiC9ItjHyPS8eAaL+5SFg46NG
         vskA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743017502; x=1743622302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T3SRuHLKAOKf7El2v2wYycMLbTwvDLlYXfZbdRUo32U=;
        b=wQ7UTPCVsDlNJDEPg535coYU3yZ9gW17rMg2N9woHTXkhAY4Yv5v1pkItLdFnXCxY4
         tu2iqnCnv51For4nOmzQizB/XlAcIV4OS1AeMZy2V8paWhz3BgJrWVr9qNKfE96HjQl3
         B3fGtvoXSP5rB+GjFwk7ZNzNV6wL7i865EmJ05fO/sbkD3RnE/Gbt7NWOzFjl2QlKR2q
         U7mVQzzGameDyIqu+7gPWolNKS3p0I+CFI5bssTAY+348fodn5v7fUhJ8Kb7tA9xL9Ls
         ea94sBhw8pyB6q5mZqvyUwaQWPL2Exw0VWMjrDYflgL9bN62xtgG2aKbc6sPoPNZHLuw
         nqcw==
X-Gm-Message-State: AOJu0YwY2YY4gsyDgzXQeE+FnwEgM67ABFmEQMSWA5nqTiE6u+GUqQzI
	5k/hGBOVyefRQZLUBvtIdovjl90ugwcZeyEMHfbdIOjDI9eh0UKRBOTmDofU1Ts=
X-Gm-Gg: ASbGncugPPUaI0ah0+TKsn2PtcKoStyhtb3RQJKMI2orqqX1tlu5iBnJeilJV60N8tm
	KI7u2tenK48+Uv3QhelUbY6D/hu1++zA5bFeilteKuh+XBQCu0Wtm42s7i4XuR2NaaGRHuJOkjq
	yVfiqr9H1n6/bY7M/sJB2e4EdnEYGp9QVg/1TZDu1tvuSzT7u5C0LKMxXWbHyBiQN/K3Dz9kTkx
	rMQAS9yYxpp1TdcGoLPK0dDrnUL19vxQWzJMhocl5WPOtEJi3i8Tzm/MhzKEjpUoWoBdo360YT4
	xEpgUA9mehjWCaOWc4gi6wKgbcI0zrKe1lCB+aOnABg0QTs2oiWhuosQ/fp0VwYBImrhU9ICVX4
	hPsPlBhZEH6PZrg==
X-Google-Smtp-Source: AGHT+IE9AQ3feGdl4+9BaeOVtY209vT1mEa1NymI1ViHEcOmnukaOjkysTX8ejSCMIj/Y9HHRNLcXw==
X-Received: by 2002:a05:6102:2b92:b0:4b3:fee3:2820 with SMTP id ada2fe7eead31-4c587072560mr1161717137.9.1743017502077;
        Wed, 26 Mar 2025 12:31:42 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4c50bd75e84sm2497804137.20.2025.03.26.12.31.38
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 12:31:40 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 2/5] device: Make Connect and Pair mutually exclusive
Date: Wed, 26 Mar 2025 15:31:30 -0400
Message-ID: <20250326193133.2718934-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250326193133.2718934-1-luiz.dentz@gmail.com>
References: <20250326193133.2718934-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes Device.Connect and Device.Pair methods mutually exclusive so
they cannot happen in parallel, so just as Connect:Connect and Pair:Pair
combinations the Connect:Pair and Pair:Connect will now return
org.bluez.Error.InProgress.
---
 src/device.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/src/device.c b/src/device.c
index f76c1ec3eabf..6a6c379fcbbf 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2629,6 +2629,9 @@ static DBusMessage *dev_connect(DBusConnection *conn, DBusMessage *msg,
 	struct btd_device *dev = user_data;
 	uint8_t bdaddr_type;
 
+	if (dev->bonding)
+		return btd_error_in_progress(msg);
+
 	if (dev->bredr_state.connected) {
 		/*
 		 * Check if services have been resolved and there is at least
@@ -2648,6 +2651,9 @@ static DBusMessage *dev_connect(DBusConnection *conn, DBusMessage *msg,
 	if (bdaddr_type != BDADDR_BREDR) {
 		int err;
 
+		if (dev->connect)
+			return btd_error_in_progress(msg);
+
 		if (dev->le_state.connected)
 			return dbus_message_new_method_return(msg);
 
@@ -3133,7 +3139,7 @@ static DBusMessage *pair_device(DBusConnection *conn, DBusMessage *msg,
 	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_INVALID))
 		return btd_error_invalid_args(msg);
 
-	if (device->bonding)
+	if (device->bonding || device->connect)
 		return btd_error_in_progress(msg);
 
 	/* Only use this selection algorithms when device is combo
-- 
2.48.1

