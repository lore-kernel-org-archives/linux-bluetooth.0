Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B3225F780
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Mar 2025 13:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742823692; cv=none; b=VHXhWqcfiv3R/afuUJRICudgwG9GbJJCO6CwppwJWCfhxA8HCxeV/2haQCDO93i1KuL+2o0Wy91/gQf+LYvo1j+wDvQgV3T6KXnnWNfQ/SB8lBYt7RDxdul+2tDaWJFPhBed6RujCuNwz1wa8g4TCzLPWZkT7vNe5X24HCpgfBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742823692; c=relaxed/simple;
	bh=6M2KwkVehYTn4tKLU92RILSeR/qXao2q2Sq6wrnF2vI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EW1JmANpWteShQbo7FCVDqpt2M0z2tpvoxnrNqZVTB+uZdF8/sO7iu4dxdgdDyfic2HqLFAUpSiKgFjG7Dprn4siTO+awUJASXUokwdF8hB/Srhmjv+95cIb6xDEeMp9p6DXxMtt2D6rcJgERJoX7kjQrwP5IMG9+p4r3Y9XDr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l27ip9Gr; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l27ip9Gr"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-86d6fd581f4so4862617241.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Mar 2025 06:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742823689; x=1743428489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RuYRLbUicIv2IY5VaipSHbaYdhol8Fsaq1RRboNi1jE=;
        b=l27ip9GrdDasImjRysqykpBN0SZlxGwKvKCf6Xnxw8DWogj/+xyotTmutM+HKiFBi2
         jRpfTPJ3fV9BDWQRDKXV0wF6O81Sh7A2I6oLxM4dmf1PIPtGz5Pr1triTYT72Vm11jsL
         uy684mnb7m1QtXb8GAZUEw+ue+GIYg4W5dS34DKs2dq6DPyaReVL1dLWofW3mXZLF78y
         tmWWFFg0owgeR4aTXi9qC0k5g4Oi3OhiyGkrGP5Lwz/O+SequDvJVADFHqERWt/obL6L
         dQUcb7dpuxXbgKs8XvWhySzAutnbM139bk5eMLI3ync+mP8NNmyE1w9HJODb6suhFIdS
         qgTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742823689; x=1743428489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RuYRLbUicIv2IY5VaipSHbaYdhol8Fsaq1RRboNi1jE=;
        b=nJtFn3YgI4mG8B/yWgl/Iww+48ILMqyE1iCw1tLkvSLI+/UBCS4RbiGHLpUmkoJA+I
         onfXnA9UbDMKc1ZngDHkaKIPqWWtwkWV1L5eR56uuA0f3p7LU5+Lp/eTKnfyb0aEQrHp
         K/jSG5DxWlab2G67EeVb6Tem/cLAp49QYnenS6B4vXpBIxVmk4v/12NyNiuvpXyXoDo8
         Lzgb2y9RdKb4LusoQkUwCddi4XRnkadmQdvpUU3gv1NZeGflWU64d4Sm1Ax1qqhQvXAI
         akiCAxUsG8ADBsiGnKwr1DD2EXLAaSWsvrJfqAP3ggLBsMKliRYtP6MQbnI/AbXHZmEY
         w0dw==
X-Gm-Message-State: AOJu0YxMtm1kBCC7BSego5a8nOel3LT6T9vz1sPwGkJOaDgVsE306Kdf
	QXImrIop9GmhfhePQsXfYYscUwXMQ1nBMwWR8tnSlbr8BY9oTNALRuHeBib9
X-Gm-Gg: ASbGnctsW1mOKkxU+BYS8JEsTwOYAkmE6j8IhNwBpp/9LMbGnf5+gJcqK3PsaDuIRPd
	fNOBD7KRmPAdDzIxksjxOQj50Y9G+SXR6UNsP/Ncku5NyYCcBg5oSW18Kg0q3lSMydYBd4Snnmd
	Hj1W7VEzbu/CwHhpJGUYH9OwGEUqhlehf9kALYIT1owwzoUBgd62YJe6sPHl2NJtEoNVU8QHdgu
	U2TwpESWBWcibR1ezeWnq2QI7Vvr7X4D13rOUrELmOCzgXyULDgAe32CZGo/bcmU7ZgloAREDJP
	1DEjNeY6pc8tR1P0s0WzlOEOvjaafXkxope5YhYD/UuNxxmkWkRJYswSvGhZjRBlZPARfsx9fLV
	V/YXt/ILbpUNQGKssFn0UvUQ9
X-Google-Smtp-Source: AGHT+IGtBwYb5RoSrbQoNI/NljsCTR+GSjiElZQL6fY0erdIjdffARGfwakCedekTcF4Ils18eah4Q==
X-Received: by 2002:a67:fc98:0:b0:4c5:2e31:8818 with SMTP id ada2fe7eead31-4c52e31881bmr1921486137.4.1742823688548;
        Mon, 24 Mar 2025 06:41:28 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4c50bc11d7asm1564850137.12.2025.03.24.06.41.26
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 06:41:27 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 5/5] monitor: Add decoding of MGMT LL Privacy setting
Date: Mon, 24 Mar 2025 09:41:12 -0400
Message-ID: <20250324134112.2108216-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250324134112.2108216-1-luiz.dentz@gmail.com>
References: <20250324134112.2108216-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds decoding support of MGM LL Privacy setting (bit 22).
---
 monitor/packet.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/monitor/packet.c b/monitor/packet.c
index b186431cf135..15f741c61489 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -12999,6 +12999,7 @@ static const struct bitfield_data mgmt_settings_table[] = {
 	{ 19, "CIS Peripheral"		},
 	{ 20, "ISO Broadcaster"		},
 	{ 21, "Sync Receiver"		},
+	{ 22, "LL Privacy"		},
 	{}
 };
 
-- 
2.48.1

