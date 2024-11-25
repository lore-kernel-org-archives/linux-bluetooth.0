Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D1210E9
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 Nov 2024 20:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732567640; cv=none; b=WNID1vhR3e6nXDfVGSHcE8j62/2LTQyW8MoBZ2U7loLq3umq3GC3nw4oa5q1GT3w9L4FTMfTosv9H09Y8bEpR/GHlIsLzfJHFSJzLAlxCDaxbOvW6u/oLbq+6gKxmmjQ+fkN0ukK7Tn0ONBZFRaiSfmT8Y6oPe0L+Dp2joQ5mlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732567640; c=relaxed/simple;
	bh=4RB9Bhd+OvBAoP/kExxI8yrn+PnjunhZ98CU+S6nGRQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pbqEpTKk3Qb1KraRyQoS3aitzBPUti+kT2zihEdWVtRZPpvRm2COvgVn9ByIhqwyRNib76tgrjhcKsnGvmWoRRyA88SpJD6zcqdwQX852JwUQ2k40yFL/GN4RdYB0/vuHakgIHva2Yio1rdo5AzYkEIvKmZT0irbAihij0UB2EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nRcjfl5t; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nRcjfl5t"
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-4aef1e4c3e7so912207137.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Nov 2024 12:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732567637; x=1733172437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=13KyXqVJ7CXhcg/u8WLMjzep0wQrlTm9JcS6PWLL8pY=;
        b=nRcjfl5trHcrd709l1rqRYjfZRuHoLTNYBa5LyMe7Y13ayCl34Z2HqerllM+z8FGLY
         qXBiXmPXAFb5aNum+FxGUdw60Cm8e5lIlxMBY+35bGYPtkvgRxw3NiyUnGxAUgBiuhB/
         VZ3qDcxyfbC3t5DELEOys1UCsEp4SEMFr1ej/VuP1PlezJUmhlcBQaMwXL+T2xFD6REE
         9gJLvpRAzdWviacp03VqEa9KJ5AbrWh6g3xXUTYuy12yuoGUCsQ/G23xcGz8/IA2Kyo8
         v4whN9Q2Z72zGK0Sj9RZC3jYOhQWjHDX4OFrwcol31R40wYCxz1niMypuKKHoU4KuL/a
         hZRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732567637; x=1733172437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=13KyXqVJ7CXhcg/u8WLMjzep0wQrlTm9JcS6PWLL8pY=;
        b=wzEGyS+L4heKYt3kS0K/gpiypIlIfkrOrxNoMTZPclLYgUlRUfRKtFZgyrfouqSjM7
         gjzprjKdn112hR52qvM5+Zb0aIz4DaXkS+mVgxjV7z0o3HNbVId43PJW+jC7ZaESWVEM
         cYi8DEGxc+rG/jumOe6QRklyB7VNHqUMAkMK+60RMYOGc9h/f3uslHr/e6HzkxHO9FGB
         7AX6MHEkGZjza5irerk//q8P1LeRj5p5RRcKNFMSi27KVzK+FSjvx5i+YqjQ81izCFJ4
         5HEAtf9oeOG1ArlmfQvpw82TnNOX3DHo9zZxjeQXb9djyEj+UpEdGrCOxUaor3BwVda3
         ND8g==
X-Gm-Message-State: AOJu0Yxw2QguoMifCvbQZfEZE1GulvBOXlWAtdvlbCA1UMf59YaRisPc
	1uIVw98KARY+N7g9ZceL4PlKvcwV/i48GtTm+8OGpSfTW3GKzUtGjCRKCA==
X-Gm-Gg: ASbGncuCidAqKJVgLiJSS92IkRfcZ6MIre6/ewgDILPSs9W6l92aVRCbmByW5xdZkkH
	+qch9ZXNxTmA+3paPnKMMOdtPn9c8Br8PjtX2K+6zTV8YmgkgN2kgq3aBb74/JSCn8LRqGGU+ph
	ji5O8QfUFgCOAyO2YsMFmycfdMiIi7O68V4Gwo6AtHhVZbI14/Sw+cDcElS2NLMKz98JwZPgV3Q
	LksInf/59xgF8IPSoT64n8lv4hKkYZhd+Yx8RWIXrr6Or8Cdc/11Y/PkKolSOAEhiOYh9YpejUA
	p599mKbEPYJX2O3cXICHnw==
X-Google-Smtp-Source: AGHT+IFyC5oXfMjRkSYxWn645iEkbjoUBJ9qNL4oDKHalz9dU8eqjzSgJnLFU8jidH64Hij/Qt3cgA==
X-Received: by 2002:a05:6102:e06:b0:4af:3923:bf51 with SMTP id ada2fe7eead31-4af3923c0d8mr190093137.25.1732567637211;
        Mon, 25 Nov 2024 12:47:17 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-85b4e8205fdsm73829241.1.2024.11.25.12.47.14
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 12:47:15 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/3] monitor: Add support for Address Resoluton flag
Date: Mon, 25 Nov 2024 15:47:09 -0500
Message-ID: <20241125204711.719853-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241125204711.719853-1-luiz.dentz@gmail.com>
References: <20241125204711.719853-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds proper decoding for Address Resolution flag.
---
 monitor/packet.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/monitor/packet.c b/monitor/packet.c
index f1a42925a8fc..06eff64dcd84 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -14418,6 +14418,7 @@ static void mgmt_set_exp_feature_rsp(const void *data, uint16_t size)
 static const struct bitfield_data mgmt_added_device_flags_table[] = {
 	{ 0, "Remote Wakeup"		},
 	{ 1, "Device Privacy Mode"	},
+	{ 2, "Address Resolution"	},
 	{ }
 };
 
-- 
2.47.0

