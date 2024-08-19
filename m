Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AB31DF67B
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Aug 2024 19:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724097072; cv=none; b=clD/F59dtdWenAXbtsQ38T+TlGl1uTUaxXN3Hhd/aqXGSwItUmzuCoj/T5BZGiQcoS11HlDBODzUnOi0aT0wPl4WmEZxmbgQodYpifb0q2tg8ByQ7E0DCCiTpFJXLZKkcxeGdq6bl6a6wI6qz05bcOTONULB/mexhrig4I6yr/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724097072; c=relaxed/simple;
	bh=7KPnfnidrY8ueUprYZEHt0DXgK7ZqUKwII+GLUeg9xw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SoQu3HM2yC8qpNixQgDIiMh0qAfdt0nJ6lC06sClVUhMKf284ByO49T/l7RaEKjmg8cjYlrT+QxETKAThQZD32OjQweo0vV8XlqTy8IPr4+JHOxNx0WTnU/s8oDpdXJYRvmPMCMMRFmpPBOklresCkoDZxE/FP7OmvWk7KvFKdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EbBkZIJ8; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EbBkZIJ8"
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-4928fa870a9so1386882137.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Aug 2024 12:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724097069; x=1724701869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r9huLJOFfcgn9eV+dzwtlWRoRu4uNcnHLi9VckJwzKo=;
        b=EbBkZIJ8qTgpnqv1Ep7Fogjf/2rx3KH8hXKlDQ7ugp2EIrDEifP9rMxKKx9AzCjo4+
         EhzSQ6PthBOZ+Zbtqzj5TjEzZYlMgB0oTYPG2F26n+XZglNPURHqOymWyIdOE2p2WsL/
         rabo4MyuXyxLWEq/f6sifVxiJla12ev+OAeoVe6kfLqgvAqoad2mJxBDSHR5LH7sjq4a
         WzYPFN1TKcbjlu3jJjm9mCLPkYZMWc20B9LSEkUq1U6BSsZvYaOdZTre8//XXYRnWzLo
         XCo0DqdWzlH+/zZ7wOHOVFGNhjG+mvTB+rdTrLg6zu5kr7J6kovQs5WTyW96PsR2rmkZ
         /Y5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724097069; x=1724701869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r9huLJOFfcgn9eV+dzwtlWRoRu4uNcnHLi9VckJwzKo=;
        b=Dh3Z/PHBxZWgbLAAjHQmXCLgZBzP0w1Y1mVPm0QggkDNTdm+gNX7Ooh2JZ8uxsXHDK
         XydkB0C/hrll0jnZ/afM9BC6uRk7oG6qRwYFUhn8c52K8YNFgOZf9OlJ3YGOlYnByVJt
         mNIVJ9Cy9ZnMTeCdolFKyA9wobYyvMUb/1VUKKgSokgHUkQJIINaTMl3kRQB+NPgnwm7
         h+ILMGLgiZVMPmQXMUPMjHgA+B/GcbxOoqj7cYAAIh2MTYuUXbXgoIqdLNk5Z4krV2eK
         fH8rFqdcpkmKKv4gDXGn02caQXCWblW60qcZdfjO2d5MEyLr3l5P0npddZnLBv5TOCz+
         izaw==
X-Gm-Message-State: AOJu0Yz+/mHQ0GqCXLFTDgMIzOcDfycpCwnWeaes3PyHeYT5gEwMKplR
	Ucpf9MXKtQxDnyPne9vwGXSJEOO6wr3mmvEqvo88HKqLd/IcnTPm4vv1NQ==
X-Google-Smtp-Source: AGHT+IEC/xpnBBIeYdcf2Xj7nMAnbLjKQph7RA4J4K6yjxwE7S5LgG5mfLCf9Tw0tMEoKoukghY81A==
X-Received: by 2002:a05:6102:cca:b0:493:3cde:e46 with SMTP id ada2fe7eead31-4977995cc25mr10345980137.13.1724097068798;
        Mon, 19 Aug 2024 12:51:08 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-842fb70fdebsm1274530241.4.2024.08.19.12.51.07
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 12:51:07 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 4/4] client/player: Print endpoint preset with endpoint.presets
Date: Mon, 19 Aug 2024 15:51:02 -0400
Message-ID: <20240819195102.37393-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240819195102.37393-1-luiz.dentz@gmail.com>
References: <20240819195102.37393-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If just the endpoint objects is passed to endpoint.presets then just
print it instead of the listing the presets available for the UUID:

[bluetooth]# endpoint.presets /local/endpoint/ep2
	Preset 32_1_1
	Configuration.#0: len 0x02 type 0x01
	Configuration.Sampling Frequency: 32 Khz (0x06)
	Configuration.#1: len 0x02 type 0x02
	Configuration.Frame Duration: 7.5 ms (0x00)
	Configuration.#2: len 0x03 type 0x04
	Configuration.Frame Length: 60 (0x003c)
---
 client/player.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/client/player.c b/client/player.c
index 5644b0d616c9..46863b1f4493 100644
--- a/client/player.c
+++ b/client/player.c
@@ -4299,7 +4299,9 @@ static void cmd_presets_endpoint(int argc, char *argv[])
 
 			return;
 		}
-	} else
+	} else if (ep && (ep->codec_preset))
+		print_preset(ep->codec_preset, ep->codec);
+	else
 		print_presets(preset);
 
 enter_cc:
-- 
2.46.0

