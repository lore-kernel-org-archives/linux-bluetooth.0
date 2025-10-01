Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EFC2D640E
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Oct 2025 19:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759346048; cv=none; b=HyenCWD4qA7iU4m6xs4s0+CVEIAOOc1N7TbAZKo9DA3+BgEriI9NZVWH6/zdGDDO5gb74Pwh5E8PIpfgPXiDVOwGrN3wX5DVxe9eFHY6uJw/6DAgWgRlA6maDf6P+toAXufKGThU8XJpLGinFk32VZJgfIR57LJPuu8B9i3lVQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759346048; c=relaxed/simple;
	bh=p8zJXE/TxvmLVJJEMydEmEGRGy1q17AXH9ICU36aeNE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CIn4ru8Nv7jco6vbq3/0ZHtOnOAyQkHK5UG6DgfoVN3Xj3v7fxcvqc9GdTGG97MqTWTd49KzMWxPJy336n+lyzw5XTpA7oEgh2fgCzF+X/hsoiAl8JNTZ5AXaj9hTTbni+ukcn6Nol86OMlW7trFQbyHMGBDadCoKKwiKMENC5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C2wdNT/a; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C2wdNT/a"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-8e2e9192a0aso121797241.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Oct 2025 12:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759346044; x=1759950844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RC+8kIqRaXCMTLhxqkEOpX/jlNHck0RTjV4aGnXLp2M=;
        b=C2wdNT/aJU3iQzoN5An5QHF8pnfxJdzflBOUnuEPzwiSMZaCsPBQq+jhV7VjF38o9E
         RqevfjhHx1QNAfMyepUdzBVsgw6u4O8n7hNpoyDNlDQ5j8Kngl1t/pexF7LF9CV0EJsw
         HuCwppEWWNsiWd7xNp7PgXnHTvfv1P7lajGC97rddMIL1/kbxniQCJtjtpfq2PUjFYQB
         JQI3Vrwvj7hOt+aLy3JWJSnYoN2+wKiFl4SQtSXio1Uq2ksYbNBL/AvgRc9ege8Gpih8
         3xW36Z0kF3fa5FWRbM1ksSSPxaL5wy2yeqTZ+wCP9hffai7f/DmM9Q4uQ3gZ7yB7nZvP
         WNVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759346044; x=1759950844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RC+8kIqRaXCMTLhxqkEOpX/jlNHck0RTjV4aGnXLp2M=;
        b=UwgTk2/FFyzZ6Wct/apU8VFzNGCwsyI+lAYfKAJpzb9ru1wutG2L81NpBrb7Arh9iO
         lc/61pS3jr42Mz0rCv3ZQ1u4z8s8lzjyWHXirJd3wKUWUp71lluFeOZ2ao+3lSJCvfU3
         wdRPs/9S02ars9WxC4kDZrdfoZp71c4SitQuNhgajAMWTy81zl2Bn1nxpQO9NWssdbsF
         B7h3fjjr0N4VbBq127F3t0pOHi6a424rvcRNVmgCxMM2Z7hWxUbRl/YYX3LJIt1diD9e
         G19nz3/RL5b/nQ3tz/YmjLkaZetLeCMqWmbDCq/jrYLuV1O95/wwpDsX+w5vC8l+eC+4
         +ZZQ==
X-Gm-Message-State: AOJu0Yztl2WjghOhq6cmn5lz013Ld2W0TVQdmG6joo0HuLXyfWk1zOGN
	7SiuNYtvDtR+FGdMzd42Cawb9mXGz4JhxlBvuZrKUm4U8xtbrR4IH+bazsyxSlKv
X-Gm-Gg: ASbGncu1JAT1FvN1wW5tFXLMm8LiHldLAES8t8x/XnNe2Q78o0Sn0LKvvGCg20LH6f0
	CgGAAPxuSAJKQbdIGhhTs0hiBPohIrfBbdwAuqhHlEBXHGAW1hk6P0KZAAJhB0tpi976MqZAzgq
	T1eCWQP83tACMmg0l1oj6uXywEC7cfXK4gqX5I+1GwPSP79VKlArXYsd9cdda/CrQgouh9G7BZe
	0CxVJ9vXCkuAVgqodBnk7EAsfZh8PcIvT6r93HwR1z3z3k6CvsZcHCpfl5bNiPLXzPfVHDLn7YT
	h5w5EeDoJdSgF9rXr888NvkA96IV+eZatwdAbL8CearopRu7VrQ1992NP7H38x7tDSu4ANFN0DG
	ytAX+UXob2s59Ag5z3j9cV8QhaWE0SGJLmiPXEDUbXoLfqwxJnOc5L/Osk7AOKsbgFlZdBp0ZQA
	Brixf+bvNuGg9FYA==
X-Google-Smtp-Source: AGHT+IGjlU5V6CiEPOOOIH/lUmh8OX+MgGKXqWL5Hr+VEaF8Ok53++Mj69zwVVP32zJ0BzngI7rRnQ==
X-Received: by 2002:a05:6102:32c5:b0:59c:6e9d:23bb with SMTP id ada2fe7eead31-5d3fe6bd4f0mr2516120137.17.1759346044252;
        Wed, 01 Oct 2025 12:14:04 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5d40c4eb7bcsm110004137.3.2025.10.01.12.14.02
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 12:14:03 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/2] client/player: Set QoS.Encryption if QoS.BCode is set
Date: Wed,  1 Oct 2025 15:13:52 -0400
Message-ID: <20251001191352.77542-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001191352.77542-1-luiz.dentz@gmail.com>
References: <20251001191352.77542-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

QoS.Encryption must be set in order for the daemon to interpret the
QoS.BCode as valid.
---
 client/player.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/client/player.c b/client/player.c
index 598ad7f6dfd7..bb193dafeba0 100644
--- a/client/player.c
+++ b/client/player.c
@@ -1870,6 +1870,10 @@ static void append_bcast_qos(DBusMessageIter *iter, struct endpoint_config *cfg)
 
 	if (cfg->ep->bcode->iov_len != 0) {
 		const char *key = "BCode";
+		uint8_t encryption = 0x01;
+
+		g_dbus_dict_append_entry(iter, "Encryption", DBUS_TYPE_BYTE,
+						&encryption);
 
 		bt_shell_printf("BCode:\n");
 		bt_shell_hexdump(cfg->ep->bcode->iov_base,
-- 
2.51.0

