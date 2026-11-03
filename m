Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793690879;
	b=jZTW31Nkj+SDEKHhstBoFaja5z/p/mkU1w2FEGf3g71ZyfpRmdomskFELJz4aep0YSuu
	 l0HWEHvNZ2ZwfqU2GfwOtMBbf/tfZqUPrNDST+E/UOySdcGAcTxd5Z4giajDkRVG+JUKB
	 oAseHX3fumlDeY10kHjzoEJgLHF3bQJD+jYU/UCL1H2kLI6qQS/cAXHojHQHXo9uVmwri
	 hxP77K509WrrsH2PAxvLhPwfXtn8m13cIrWfoURwmjkSrIe8zCU5O+zLTjpGxnTRZlx7T
	 YauaDaVgpru0jURzd+u6EauZsqrwCHxb6MLzxLb/8Rm1Obkljrn19h+W1gHbtXwKvOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793690879;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=X615zU9ORSEAQUv8Nz+s0hDCGEZaTV9qWtlk0faDhI0=;
	b=XgKl+30eBMojY8kSm22cYthfEx/aQxIW88ExUEGQDpdUvkYHHx70XdnrpxOQnn5ttR8s
	 eZ6362mQvZj33NC4XH0hICP43zmLlDpwrI/ZeBOoj1otU3zApz7E5xPP+daY+zrk4GVaU
	 WTftY4LrlpSeEtZ3v3vQg6DpLWyHNjbfsaKgo9l2Pkcpn7vyHIPpiXPPHAacT+iYuyyxa
	 DKrfTm1swUbWZ+YsMFlDJa3nr0z669xP8zlB3Ay6KgjtEkB/SWUoPzAMzy/AnPCWlbP2f
	 xspyzgi/PV6KCj6WaC9A4cY9k3pncZDZMmqFY8VGUn2qdcnKqC5MO7nS96XtpczGeNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simpleble.org;
	spf=pass smtp.mailfrom=californiaopensource.com;
	dkim=pass header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b="lRpboS/b";
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB66606A32F
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Nov 2026 07:27:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CEB66606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simpleble.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=californiaopensource.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=lRpboS/b
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-3514b90bb89so7993272eec.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Nov 2026 23:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simpleble.org; s=google; t=1793690878; x=1794295678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X615zU9ORSEAQUv8Nz+s0hDCGEZaTV9qWtlk0faDhI0=;
        b=lRpboS/b5QjN8qiWwTaZRiNVFKF910Y5CR9kapChUZJPKuEX/yxii6EcepsdC6Ym0O
         y0NPXP3dErnz+lmA5gq8eV99l2FPyKx1qstT9WTe0w79BmF+H2p/GtvXdwZSI3NuNIdG
         Oqcu+XKWCX3KvFSXiJmKDmqEmn0aYJQ14wcgRtntB3cEy91TFZ79KntDWfbJF3SkppAT
         D6iZqs4k9URNwq26TQT58p6vi3DOOLq5qLKzEyUV2KDxGdLUOHw3GhC7/UPvZU6rEfSd
         aELn2tM2y1LKZ8BOUo6tHnO+8RAseEFaWIVh4pk0xSAERG8EHei4JdWqylJ2fkjh0573
         U+/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793690878; x=1794295678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=X615zU9ORSEAQUv8Nz+s0hDCGEZaTV9qWtlk0faDhI0=;
        b=alLA5c/N85XwYmT0K7g4ldIzNd+g5SsY+8tehOF6gv1vf7qCnRqxrbLD4GPwMOrWzF
         s79TutkvjIY8cyO8s0oCSz/l9ZA593BXkd2bn9X/XD96zMlABl8ySOaXpjqi0Pr6mVU5
         OVzNDMvP/OKHShAoEs/S580qkNn1yWvVX3aLyg4C/hdDmNbtokpaft3fzBlKrxlD8osa
         6+E5agPq0OwyB7uXqPLVO96aDnZ7gK3vD33PPNgWM4TdvaigEcphAEZJ9npRIk9DLuhg
         ukvINQfy8Z/LPC5ii4B8BLZDyJBdbARTAond3aVJk3tR/4K7C4oZucTBkZHHIH2KV87Q
         VaBg==
X-Gm-Message-State: APuU4Z935WZAiIFl045zu6DXUvCHPqdlAObaw6Z5ESgtjdpIbN4NOZgC
	cJ4CzIqS4oQFpnarEHb056aqvZNOJCOUDc33WdaYHm9ks/lYeeOlyx5DFySwkiUOnwkCZMPB8yA
	gOn9sc5A=
X-Gm-Gg: AYBFou1mKG7J7OwpDRG5HG4JxCVV8CLLvBd2dpvxTGAub0RbN5IRT0pkz6TwIzpDaeD
	u8CS1gnsQILloyaprNoEH4j6mN6htmF1SZmltnUw1C89tddyJrva6UPgcdegY1eLOxUXy0aVQ4O
	ODdd/KGMvgkSQqSunjJT0U2nbvdd3KIYux4b1hazhDyVDyYPSVu1Y4dvzRSvW9Ti9tk3GbKJel7
	mQUeGLBkpr2/FWHgf6O/SYsGwnkAJVN9zkfeII13J3F2xG+ztsmLrR+PyH0LRjLKT9j9lPLvnCf
	uOyqfMGdyrCrqBoS7659IBEugqLjiQ9/Pqyiwc9Y20DulHTlgqSrFi7k7kKQJF5XM0bV6xQGDYR
	rKjqgTPD35NyzwN8y9+oVeMGRyNbxO4WmXAqnDOoIjS3yuFnsdZhBCPHyszkDTekGdHQ8PXHnmH
	JhA6Sbad7AaI9agrunHcPB9Cf+l/5gDLKaf3MS+PtMAcvFcmrgo4l97TkGd3IP30J5NDoxMQHsw
	mQKwqQAsTeFoAsZXVkjHT68KtIk1R8W/N2LIsQfV2fgJ+ONJ1qqgYms7TJYnz4tHOHwCYSQsvyr
	hECZD7WSgTac6lqyBu1c9aJVJ1OXDCjHUOjAv3IErDu+4FsDhLcoNh7h63IFmXC33H4svFPGZLP
	/E6kfYybpbWb3cMzjCa8PqQhU7fdof07+DPxq76ns+zVlfmw9MntafqhT98O6iNizCwsXj4AlHu
	lK7GUyqjksVzcgkQN8VQ==
X-Received: by 2002:a05:7022:b059:20b0:1ad:3402:733f with SMTP id a92af1059eb24-1ad3420f9a1mr18071081c88.44.1793690877655;
        Mon, 02 Nov 2026 23:27:57 -0800 (PST)
Received: from localhost.localdomain ([147.185.47.151])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1aed79b3dfcsm42437988c88.12.2026.11.02.23.27.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 02 Nov 2026 23:27:57 -0800 (PST)
From: Kevin Dewald <kevin@simpleble.org>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Kevin Dewald <kevin@simpleble.org>
Subject: [PATCH BlueZ 4/5] client: Print LE connection parameters in info
Date: Mon,  2 Nov 2026 23:27:48 -0800
Message-ID: <20261103072749.50979-5-kevin@simpleble.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261103072749.50979-1-kevin@simpleble.org>
References: <20261103072749.50979-1-kevin@simpleble.org>
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

This prints the connection parameter properties of the LE bearer with
the likes of info command:

bluetoothctl> info <addr>
...
        LE.Role: central
        LE.Interval: 0x00007530 (30000)
        LE.Latency: 0x0000 (0)
        LE.SupervisionTimeout: 0x07d0 (2000)
        LE.Subrate: 0x0001 (1)

Assisted-by: Claude:claude-opus-5.5
---
 client/main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/client/main.c b/client/main.c
index 01ed00073..1131c2ae3 100644
--- a/client/main.c
+++ b/client/main.c
@@ -2098,6 +2098,11 @@ static void cmd_info(int argc, char *argv[])
 		print_property_with_label(bearer, "Connectable",
 							"LE.Connectable");
 		print_property_with_label(bearer, "Role", "LE.Role");
+		print_property_with_label(bearer, "Interval", "LE.Interval");
+		print_property_with_label(bearer, "Latency", "LE.Latency");
+		print_property_with_label(bearer, "SupervisionTimeout",
+						"LE.SupervisionTimeout");
+		print_property_with_label(bearer, "Subrate", "LE.Subrate");
 	}
 
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
-- 
2.54.0 (Apple Git-157)

