Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795076200;
	b=v8ATjJBcim9k8qTGTPig4VrRaXLKIh2QpT18be8q5L7FugemGEaoihLw+cOKd0mIzeWT
	 oPX9GGBUBE//fRqHAP7rgfyKFqLBOn01Pkq8yAhfozLfe4eOlXRkjQ+gDP25BSBUlwheC
	 dtaDSr5FGOLAsdokscq04+DyLUhgaqt9ZWWIUhUKOURtuLC3inT2BHFik5VBSw9G7b768
	 nDN5p5V3P83NzAHbsghBmKbJipMysaZ43dtoil39bL7Gif2+SizPJP6mlweCHhtZD10bS
	 laD5uMX84EYsSrEGaEL5XTsuiLcmYyub6mxLU1ctRHhpwV1zL89XxK5sujppgg5o1Aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795076200;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=A/bYZ29NrtRIdkD8/EDYGJpEcNeUykUIFsmz03k8PU8=;
	b=KZJQAyiE/Eh33o8fbGnvD9yCXVXboGqfPfu67MqY6r01sW3sFMS342aOWXSmpz1omXSS
	 sx04Hk7bRrK4i5zGtiscz83vxDDcjbQFCtOx0awZZmcGSe0a/tJTTIJlPA7EMaNuLIvv+
	 xETP7F+Zl1OhldHg616bdX2YHZw1GY1Wozmc+xoMkbZ90nyS4I8LbHkVDK4EtfPQNzZiL
	 9DcvzFt6xToBmrCj2i39+AdMjrZJeRPI8NH2GvCscFw17Rn3xlLfGo4P9ZqzOXMcH+lGL
	 Jqy5P8XjBwr9E1SvhnlZilcPMhwCk4w4QVMuppaAJWAIAgj2+0uGrjJV21LLv7fVDDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D7ic4Edr;
	arc=none smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B8C606A80B
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 08:16:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1B8C606A80B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D7ic4Edr
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6b75c0f5fe8so330427a12.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 00:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795076198; x=1795680998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A/bYZ29NrtRIdkD8/EDYGJpEcNeUykUIFsmz03k8PU8=;
        b=D7ic4EdrGPVCZmTP4SCXHq3KUX/OyQzFeITSuQi9gryFG2OhdNyZH2LcICu/ACX2L7
         ZOltreYYi2pzLeKjyZokOw9PtlOyEV4RcdIdwVm52Qwlz80M9ascnUW61oFM2S5Iki7j
         hmBHlLNEUR/mQkz2NFoXj3ctq3xISVDjLqmEVvesua+Ynze0oOAvKVGH0KmKNsV1/V7G
         jbhbyoWZr8gIqCXvxZ8q0WiXlyBOvHYqLtJrJ4qv4Dp2IYhtAw2BhRRT8jiydbRD0iuZ
         mHdJXHswM+R3J+m6yvLJEK177EjVBI/SoZCqAQ1LEvsYaRWaltTiCam5i/Hl7E+Co+R5
         /vzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795076198; x=1795680998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=A/bYZ29NrtRIdkD8/EDYGJpEcNeUykUIFsmz03k8PU8=;
        b=K9R6REVRVmd9qlTRUvmabdgtn9nAavrvkMClJNXVbQo/O5aTIbFxR1/wn8vX6Lq8yt
         ++X+Ulx65pPKxPIh5gKkB2LuDpTj/W/1+rzbrZMuTUUT1xz2fBDorWK7opnKHhsFT5BO
         j78slg/A9ZnOTEuNmq2iBZ5bEksEsTWv8Fher0qIlXC7goWhafa/3E/PKCHaIOnr9yiy
         CbW2BAJVZ74cAuwkp7d/w6EWkwlEu5Y0yFBoX3ib6/wixRAJVl4Ivc5N6T4sC3JNq25Q
         MYAsmDqfLZvBhC9pKzKPKUdatn4mfoe9QuMtdJpzYToW34ZrIoI/n0uKlvkjJOaxdzXj
         +qqg==
X-Gm-Message-State: APuU4Z9Gmeu/X4Jy+VlFrfEBCBBz50n4mLrduxgG87I7il9lP/hytR8j
	DWYUWQifTwRsff2PsRVNTYlnogWfhjyBT5QPN/0Ocw3iSsXOYgoMk6idMrBThjhu
X-Gm-Gg: AYBFou0gQ9D61DesTwg/RPTKW3vOPDm2OfyuagrMv/kF/z6gESrRjXtZhdcB8nT71Ey
	Q3EVyA9iDL2mdV2aUwUoe7alw05W7t2qkqnvKZJXD5qinf0XAJu5mTcXCOsBQQBpibDIm9qXCSj
	iVaGEHV7a0crICr5ikpiPShDafKqbCv0ioIuGnlcW014y4EewWX/Cx8TTnpBImgveFh/RA+4Vxt
	a6s5fdpZgbZeVd54SRTtMgQsmkXvaWspr30pQXUcKbeX9diE7fFLrKtDY39tY1GNDUKpXuUJQwX
	IGKO/MffF7Pz7nbhk+inTOYjtI+GzRsDLihwjy1fHiKEzDLFWSlHfVLWHiVTtNzQuxwfWblW4w7
	4bNqjHm0WFwPy7tjMaBixLZ529QpDStGW7KV2gRyz45wCZDxuy3iYjUk7G3veNcWJVNcUtx3kxf
	DK970haSPZWlGUTvdhpeMfs0qGtwmovzPr+3ANENg929aVpaZBT4UsqE/n1ob20FGLzvMJLwxqa
	MqwDN7i1KrTmfUu0Ho4+pTVxlpNg0Gh3oaH0f5oy9qbwWsldlesuH7NwYpxZH6Wjn3jsFf3EHVS
	TU/b0vJRmdXnQ4pjAYlFdGBf8+lQrZ7O/Oyo
X-Received: by 2002:aa7:d290:0:b0:6b5:832f:10ea with SMTP id 4fb4d7f45d1cf-6b887caa7f8mr4323754a12.1.1795076197800;
        Thu, 19 Nov 2026 00:16:37 -0800 (PST)
Received: from schinder.corp.hoffmann-group.com ([2003:8:2:4::5])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b88a22e143sm2229580a12.29.2026.11.19.00.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 00:16:37 -0800 (PST)
From: Roland Schober <rolandschober1968@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Roland Schober <rolandschober1968@gmail.com>
Subject: [PATCH BlueZ v3 4/9] monitor: Fix advertising handle of LE PA commands
Date: Thu, 19 Nov 2026 09:16:16 +0100
Message-ID: <20261119081621.112623-5-rolandschober1968@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261119081621.112623-1-rolandschober1968@gmail.com>
References: <20261119081621.112623-1-rolandschober1968@gmail.com>
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

The decoders of LE Set Periodic Advertising Parameters, Data and Enable
print the Advertising_Handle with print_handle(), which looks the value
up as a connection handle. With a connection using the same handle,
the advertising set is shown with the peer of that connection:

< HCI Command: LE Set Periodic Advertising Parameters (0x08|0x003e) plen 7
        Handle: 0 (LE-ACL) Address: C0:11:22:33:44:55 (Static)

Print it the way the extended advertising commands do:

        Handle: 0x00

Fixes: 61563bd7b477 ("monitor: Add LE Set Periodic Advertising commands decoding")
Assisted-by: Claude:claude-opus-5-5
---
 monitor/packet.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index c290dbf7c..f358563b0 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -8704,7 +8704,7 @@ static void le_set_pa_params_cmd(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_cmd_le_set_pa_params *cmd = data;
 
-	print_handle(cmd->handle);
+	print_field("Handle: 0x%2.2x", cmd->handle);
 	print_slot_125("Min interval", cmd->min_interval);
 	print_slot_125("Max interval", cmd->max_interval);
 	print_pa_properties(cmd->properties);
@@ -8715,7 +8715,7 @@ static void le_set_pa_data_cmd(uint16_t index, const void *data, uint8_t size)
 	const struct bt_hci_cmd_le_set_pa_data *cmd = data;
 	const char *str;
 
-	print_handle(cmd->handle);
+	print_field("Handle: 0x%2.2x", cmd->handle);
 
 	switch (cmd->operation) {
 	case 0x00:
@@ -8745,7 +8745,7 @@ static void le_set_pa_enable_cmd(uint16_t index, const void *data, uint8_t size)
 	const struct bt_hci_cmd_le_set_pa_enable *cmd = data;
 
 	print_enable("Periodic advertising", cmd->enable);
-	print_handle(cmd->handle);
+	print_field("Handle: 0x%2.2x", cmd->handle);
 }
 
 static const struct bitfield_data ext_scan_phys_table[] = {
-- 
2.47.3

