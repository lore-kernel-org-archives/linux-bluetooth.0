Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795453182;
	b=pSxfeNUJ//WxHn5d4yGmU4LNlZluNaPyUrV1cMfRVKwBH1EUvE1T20ArpimfTCL5NbgQ
	 QcXrh28kLt1BRPPXotSN/56lbs8aKYfmjDDbI+iR1aP2qWrJSF+LHyURp1go2MSrSw/qo
	 al03rsmc05cgG9FjiwbpnMjgtm2EmEfaKVyW2O3N4fBCuKlbsYv1/2WFRuHa5xYxufXBi
	 R9c/DuCJ6Y7sKI9tLVoCGLmZJ4la2p3ARzAfwwJ5392h3d7AieRP6zuWO9efA6MQQSw9y
	 Ws8Gz/yew9ON2hvEQXuOO/h0WFmZw38/LdG/W0XCcr7kueO1zwHXvkb+yOgbV8bBYug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795453182;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=BnadnBrf9KhjiDVaAi+tm44lxXvlPk5YiBx9cQB8Cz8=;
	b=B56uFiJSxzhGF8PfMV/IO4e62aY4E3w3W0L7U68W7dlBa8ZhINyPvWOq0LC14QOLpi4A
	 awlQlnaJV3Ops0JMRU7xcNRjTNQCCOClA/PvuyQRDfsEyljhtINNufVaxKlAjz/MiIVNM
	 3AKZYXTYB1S59f/1tDgR7xs0fNoInst1t7s5r2aU0wrLVAR+9bXiD9zPHivJTBot93/Js
	 RF5Dnq5E43qfAHQQ8wK5uL5Qqs6SA9/niUzhl8hp+7Iuvh8muS55h2NCEc7T2LsIEbNNZ
	 LsAQQkMN4TL8aABd5QR1iwP7l8xkPOzXOqU9Q3icdLEFDi0nuACcGPZe8SDp4+jruUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=Zf4uPSR+;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA84B606A32C
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 16:59:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA84B606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=Zf4uPSR+
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4bb64c99d2fso34893415e9.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 08:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795453180; x=1796057980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BnadnBrf9KhjiDVaAi+tm44lxXvlPk5YiBx9cQB8Cz8=;
        b=Zf4uPSR+6wTPvghsmOZdTAsUZxh98A4zwwugfSqlcAn1kAgYduHWXKXcgViLCjZLYC
         1tSfjh4PhjctuEhA4ne2Xhuh+H4twDlD/2AkNzSmfxXD+EugdR8oQ/mA6KD/yn/PbtbV
         bzXc+ThX0nsj4aIe3w3HiGOxbToGaAaH1ITE0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795453180; x=1796057980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BnadnBrf9KhjiDVaAi+tm44lxXvlPk5YiBx9cQB8Cz8=;
        b=M4m70MtPkxBGhsehibsE5Kf8rt+kC94GPU614zP+00kphKjjU8ByR4E5byWYNx5W0i
         Ga2h90GF5i69AZ5UPqULcOP5ZMiDJA4GnB8qsg4IPuXlvJisvsozNIn1HGNtUxPnY5+9
         fhZyZHkieL12bSIAJTcMq4UCVuQ7UrEEnEHAnTWt5bZETxWIAZp8D9iWnaj3QuLShHyt
         B9edLYoFE/YRPibrIvf0YK7aZAl4lUyosyAAVejLrHbKejR07rbAdqOIBF7k/iwHRofK
         azxokCczE4qGgz1SkgzQHCu8uc7/6TWBI5nuMce0iBed9/ku2NU+756jz9Cmw7BCWKFS
         wMyA==
X-Gm-Message-State: APuU4Z/xoex7NlglVFzNMbP94bHs6ASRqIRcAw++SValKU63FyTejAKz
	DY2oolW3r0dSQrHvkpW6D5/N505j1PNEOQ7r+9RVrXt78z9KfVAS0BVGrpCBwXvu3K8O7dyFmYe
	pejg/
X-Gm-Gg: AZFdTZdulb++v9K/bn2+qTVLzZsg8PgBVJDD+J1WQ5kxhJQWOOXL7OuRH6RHwc4H7Z4
	Yhc1OkUoYp8hCnIidGirdj7ez5Ni6fpX0PGF84xqI/xf6DMfUFEV7OH+KnjZrXjn2kD3wMXU7NF
	5zGh1pB3pSzL7boRCECh3FJmDzHYjHOz5vu7DcSZYXyZcpUiIzEkSiqqJc6wCOS11n2uCfB3LSg
	mcr4DhXSs+7STVzMmzlmCpXp5LYJUAPMdnRJ8yOd7qD1Cb6cFDbIWKjILECtXJboEAlOWZbzYNs
	ZTjuedipb/WWiLtP25PpFb5pOyNHMRPiDFM+y9kZCQqJKds9tCqpnTYWGHsZiNCQYawBMkVQ1N7
	5KRzsT6wjkIgmFYnwS8d9F/KT9Fdaij/b32CmzImfAyGB4wQCQ7mJ1AltaJfwUkC1UYrYv8iOAV
	/7VDPV3gh0FGX3gZgXVtVpVW9elOmX6fEIDm4nWgjuz9cOayLjErOGwBp8x3y2ijswn0NgQcsHL
	qbh1JU6TI7DqvKg/f4G464Elaij976tagXrw2cx8arEFmt4GiRuapT/k6lacaZE7x03IJ+f2U5C
	yXqTb/iGZU4MqTa/J1MiudNVmWQW9k0mqiPiL0lhGeDlMUzp
X-Received: by 2002:a05:600c:4f10:b0:4bb:60bd:5398 with SMTP id 5b1f17b1804b1-4bb88804d35mr276648315e9.10.1795453180395;
        Mon, 23 Nov 2026 08:59:40 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:4fbf:a0ba:28e9:473])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb90660cb4sm289748185e9.2.2026.11.23.08.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 08:59:40 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ v2 4/8] avrcp: Fix byte order of TRACK_CHANGED identifier
Date: Mon, 23 Nov 2026 17:59:28 +0100
Message-ID: <20261123165932.470612-5-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261123165932.470612-1-simon.mikuda@streamunlimited.com>
References: <20261123165932.470612-1-simon.mikuda@streamunlimited.com>
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

The Identifier of TRACK_CHANGED, in the interim and the changed
response, was copied in host byte order. The identifiers sent so far, 0
and UINT64_MAX, read the same in either byte order, but any other one,
such as the UID of an item of a browsable player, is swapped on a
little endian host, and the controller then asks for an item that does
not exist.

To reproduce, with a target that reports the UID of the current track,
as "avrcp: Add browsing support in the target role" later in this
series does, change the track to the item of UID 2:

  btmon: EventID: 0x02 (EVENT_TRACK_CHANGED)
  btmon: Identifier: 0x 200000000000000 (144115188075855872)
  btmon: AVRCP: GetItemAttributes: len 0x000c
  btmon: UID: 0x0200000000000000 (144115188075855872)
  btmon: AVRCP: GetItemAttributes: len 0x0001
  btmon: Status: 0x09 (Does Not Exist)

Fixes: 9ab125a8ec20 ("AVRCP: Use track's UID in event notification")
Assisted-by: Claude:claude-opus-5-5
---
 profiles/audio/avrcp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index aff1c381a..fbd212511 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -791,7 +791,7 @@ void avrcp_player_event(struct avrcp_player *player, uint8_t id,
 		break;
 	case AVRCP_EVENT_TRACK_CHANGED:
 		size = 9;
-		memcpy(&pdu->params[1], data, sizeof(uint64_t));
+		put_be64(*(const uint64_t *) data, &pdu->params[1]);
 
 		break;
 	case AVRCP_EVENT_TRACK_REACHED_END:
@@ -1629,7 +1629,7 @@ static uint8_t avrcp_handle_register_notification(struct avrcp *session,
 	case AVRCP_EVENT_TRACK_CHANGED:
 		len = 9;
 		uid = player_get_uid(player);
-		memcpy(&pdu->params[1], &uid, sizeof(uint64_t));
+		put_be64(uid, &pdu->params[1]);
 
 		break;
 	case AVRCP_EVENT_TRACK_REACHED_END:
-- 
2.43.0

