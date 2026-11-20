Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795213615;
	b=cqmKAnV2CIoB/rU7XOjSP5QmR7hJ+7/ZJ/nJo0Q6CIZhueL05wCwIEAtrPqmQQ7+gEy8
	 Xe8up5lYwHYrNhRxuQf5ZPu3dSm+wsyk23xMuJoLPpRbVAmP0WDpfP4GgykdsgDLUMwDK
	 eDVDrmepmVeJhVrMte646+FcPTlGX+gTUlWBGQaGlUMVVayyW4/bkq4Oy1ub0qtp9P3CP
	 BbzIsqGGhMAvFQ11n42d+2NjwssDJu+8eFM7s7hZQxQ/SY5UZPjlpJtNunRNPZtuMRLMH
	 89ZAgZhSEjX5XJLTn9O4syPbDumNL6lB5wAsf0t6gOpmlANYR7x4VvanSMNzRQ6zrBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795213615;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=yBI3DykBcTF9tWQp+AAl/WWHa3FuDurnYiSblchHTCs=;
	b=vx2rb1lDtJZEWyipanlkFJfk6MIyzJy1M2HNLiPcFsc007hkZeHEOr5Gq/esXNJAT7+S
	 o0qPcQ4yhCWlL/3Ca73SdB3oMiyjWMvhMpgBQFC1IxMmU4Sgxpz3Hi0P8OvtRhg6h2Z4g
	 MsVgS2VKCT5KDG2Z09Uo3ZCDlx5yT/tlDDdiSDeSR6jjjP/e+s6HrQejZOHb47LMsP+QZ
	 P/FfGmrtHKirf29lGVXT+8SlnkJcFiX+ImxxszRnpr7NTqoOhIyEa91zSHsIroOdBMhbo
	 hnCaP4X/vW0EJBdszsk6bhc63/kPZ7RysVtYQotlkKmA5C2/Q3nEMRO4T1/mZkbXXOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mErSNOk+;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA548606A6AA
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 22:26:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA548606A6AA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mErSNOk+
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4bb609d9bf4so2477675e9.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 14:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795213604; x=1795818404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yBI3DykBcTF9tWQp+AAl/WWHa3FuDurnYiSblchHTCs=;
        b=mErSNOk+ZQDbNeJ6Z4VSvBRcpStrSIDwertXPMM8tO3i5L46jFvb7eGsg8y4CzPyxF
         Znot6Ei3fuBvM5I6Kx0XDGZRaTLtUr42LRLG1y42KZNN7fs17wTTGK/lFdCpnNoMo2vy
         7DowMkM6v/OsKjMVtp9NNe1JLigpn0fT7RNr2qGwq0HTBAOZ7NvTq0ZKyNdl6mWm7yMl
         Qq0ooyOE3OkWiTO4o46waomiW/mG6jjVXlR//sl+um71JEbRb0c0y51IFDhk496O9+lI
         x28Fsg4sQbq1Nx3VOtleBFWS62eUc+9BysupGKGft9BWOenWrOvGNa1OPBdvINLnbPcp
         6u1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795213604; x=1795818404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yBI3DykBcTF9tWQp+AAl/WWHa3FuDurnYiSblchHTCs=;
        b=Q68MzhVnxG93ivKUYTRJtOHvCksexMp8ORrv5Eyn0V14KWFMcKe37nHeT6PbcGrUDf
         TWwZ67Jix8WZiQle91wpsAkzQ9V58EPHbNwTBbUysLdImyYmd86PMEWUXZ76MMcPl8oo
         qFWlk9fxEnPNP/v75e9PCyzJ0ay2ea+PJnB9b4UtfqtoN04yHX8LCfCBtCJQHavI3CBJ
         +eAW6Kpic+/WU+RxhtlwyGTT2qvTRSmOrC+pqziRBP1nbWjKq5TpoAvzBtcQL4XeBgG7
         HYpWmjA05SwZF5Hv83KBNH1at5D5eKsBSGQ3D/66NUsLtmnlZkeQ/jFKh1l2QEQr3cNc
         66zw==
X-Gm-Message-State: APuU4Z9h3LUByTMCcJaLvxXCB4gv/ywBtu8NWAIaI+E4NznnjKr5Ukfn
	ykQdcG0uTOqL9O3A5r7NKO91jSJO4y9n5iyWQLAjRQAftjMPIqKpVpjW6eGFcw==
X-Gm-Gg: AYBFou2DHsBibZKGo4hFQ5jkJSQy7V4wFDykDZUYo4LhY6atOgm6QqokxLEjv6h5uXt
	Pl7u3EUUvkmj+FNVn/63+d9inFEDx32lOH87cQdyfUQJOLcDQ/UZ1k9WfbHRQc/VSXUxNSzVat7
	Hzz0T5nFmqBZfrGVg90f5p9otS5S+M9YRIL9wqEXEg8Z5922T9ypOpmNoFMvAw/z63sdT1Jr5r1
	yJAi3eFwGcc5djVmtCdGpQXnfETipAK+VLHu1LspeNE/jYH4VAUKkxyRxi/x8le6jUYLMNWlE4Z
	B419q5eUmxorDm7yX8R3lCYVvIm0NM/E/xaEJH76ZQ+YHfen3A3VSCYQIVZL96nyBJWEvKkDr9O
	jC/b4xEUCbiqn53F4Mbqz5gwDf8xbE8HdXTD4piwh87+TQZkpkwGd0nx5nPy8MdCCxDMwqyrs6b
	ZfIA7in+p+UDTvyIDT7PSrK4GfwhcAbQmnRZT3+7UWv1OdszuBIg4HnVbDvvLOrJ1vQgE+mw2A+
	XmmNz9rvFFEGbE0Tbh7eXHxo7g9LAeYkafP7bDeDX9Dhn1hREKcLgxH0cn0Kn8TiwfnmlUoDrVf
	KI0ImWtsfPWD9CgqKJyRYJEl2aJOX+jJtuCnCRtWTlTi75hzhhfhT53txortUDMRTCSk0w==
X-Received: by 2002:a05:600c:154c:b0:4ad:5ec2:d3b3 with SMTP id 5b1f17b1804b1-4bb887f43d8mr98643815e9.1.1795213604146;
        Fri, 20 Nov 2026 14:26:44 -0800 (PST)
Received: from schinder.fritz.box ([2001:9e8:b39e:f00:df5c:2a51:ff8a:45b1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb90660cb4sm23698785e9.2.2026.11.20.14.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 14:26:43 -0800 (PST)
From: Roland Schober <rolandschober1968@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Roland Schober <rolandschober1968@gmail.com>
Subject: [PATCH BlueZ 3/5] monitor: Fix reading beyond a short Mesh Beacon
Date: Fri, 20 Nov 2026 23:26:22 +0100
Message-ID: <20261120222624.150321-4-rolandschober1968@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261120222624.150321-1-rolandschober1968@gmail.com>
References: <20261120222624.150321-1-rolandschober1968@gmail.com>
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

The Unprovisioned Device Beacon has the beacon type, 16 octets of
Device UUID and 2 octets of OOB Information, but print_mesh_beacon()
decodes the OOB Information of a beacon with 18 octets, which lacks its
second octet. Require 19 octets, and dump the octets after the OOB
Information, not from its second octet on, if there is no URI Hash.

Fixes: 0ba12681f3e4 ("monitor: Add basic decoding for Mesh Beacon")
Assisted-by: Claude:claude-fable-5-2
---
 monitor/packet.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index 4f63cc0fb..6646dc147 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -4205,7 +4205,7 @@ static void print_mesh_beacon(const uint8_t *data, uint8_t len)
 	switch (data[0]) {
 	case 0x00:
 		print_field("  Unprovisioned Device Beacon (0x00)");
-		if (len < 18) {
+		if (len < 19) {
 			packet_hexdump(data + 1, len - 1);
 			break;
 		}
@@ -4218,7 +4218,7 @@ static void print_mesh_beacon(const uint8_t *data, uint8_t len)
 		print_bitfield(4, oob, mesh_oob_table);
 
 		if (len < 23) {
-			packet_hexdump(data + 18, len - 18);
+			packet_hexdump(data + 19, len - 19);
 			break;
 		}
 
-- 
2.47.3

