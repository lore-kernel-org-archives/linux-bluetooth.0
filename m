Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795472616;
	b=MXEefMhTOctKxLglnavgCsRnsCDJ+mEh1fuh0WCOw/3v/sh8WCsKCD3AfUSXVQj5+c9L
	 c2k+9xTin5mGQSWPbK4l6H5NxSGZINd3B+SG9NNefNEvgOEs4sUAXIeBMlZxG+Qby7k08
	 Lba/1QdsUiPYKCzj3lanmmyxWqlCNpkVAtObPkauENiAiilMtuf5vQGYesPUeK2z+r/sU
	 GrYwxHhFjfBNkCgIkKie03Z9r5DIm5no7l6RE4DYV6V7JDSI6TDsyPOTYl2SECzrwEDMJ
	 uCUkA5h+zAaiwQ0yqC6VroJjmMqe5HoDL9DLVJP+JLHObn6NAR6q0njqp+8qqI/jllw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795472616;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3V+HVypldNzo11w0bqpA0iQ7+Jer4tTEa/Eelyx5n+Y=;
	b=I0jELVNsd2K2o0y0B4dHHu9Qxo0ALYDZH8c78tqxbNg6bRfTFMiTO3o3/h3MrbUFAn57
	 Sc0cAcPR7Yi/2DK9flMKfzoUVSSmirZm2otckCAzBapGAAiicYwz/c8bT9J7fHzFAE9YK
	 2SVHdzTqNGjRDDIFO8dTXGV9G4RkvDqGnREJJi0Z741OQQYph3ETgblcoE0yJzMSIs7+Y
	 PoIiONaXLhsIBpLCPKuyVqitRhFoIy0hsww9C+Nm/o6hyISdD+BHn6QFFEsVNRFaaMmwr
	 MLVCNNETgavC7XgqyJ7ozU/Y7lCHRpjyZ+Dn3meKXWQJjBiIk9by2UFG8gKQq5kUHKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k2w0oljD;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00F4606A336
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 22:23:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B00F4606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k2w0oljD
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-49083b985d2so244226f8f.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 14:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795472614; x=1796077414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3V+HVypldNzo11w0bqpA0iQ7+Jer4tTEa/Eelyx5n+Y=;
        b=k2w0oljDLaM9FAYv6yOtIo+hCHXBqT7mpz6R5PbFmVHBO0go05cTQFqcADSICYdcEa
         qUwi+Rsv+NlmlUKa9/za9RgPNFnTAJk6droAiO6my10NF6y3+m8qJrwxtOFUv/XnWwIH
         aokvzyxtJFJjaSWHDYT6ZBnECCP93Yoile70eXwGJ7oRdAveUjEdzVD3ohFls16zGI4J
         pKSSUUu8W0nx/VaflLovCOyyFRYKF+1TvuKYuYKVrscYRm19YOhthv83vfcX3M3Gwjfb
         7GfMRCuLOWfDxoeFaG4I9hPfGv1jvUMVIeL0YuoXeTRKfm7uqwHElzTrz19ueCwVwUo/
         Aomg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795472614; x=1796077414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3V+HVypldNzo11w0bqpA0iQ7+Jer4tTEa/Eelyx5n+Y=;
        b=drc7dbjl5EFoxO7rsphIgl/akGU9kCEQDLX6DVVw8b+37vYFZmd3psEBg67t7DLjxL
         DGCbbg78CAN/98QOunWayoyTqpIlElwNZJv9z3osKX5bQCLETcu3WUOTjCy83AKG9KJX
         PimeBDSCM8dGttuX064upUdGcspw5YJDB31Lx11vysVe82H5ctiP6DLWCbccpvBi1n8u
         iUDo3LmXb7/Pnd9kMD9R/WB1svEVk9r+oVA6r8AnYIjMj8UR7Dgh0yVmGK2nxkz+DjSh
         0ncc7obwvbEkuyyqPr6lCa3WtqW0alg0o+hJFpgzrhTMXqK/3YDeOEZPtDTrOM8QHqIF
         Y6pQ==
X-Gm-Message-State: APuU4Z8BiXGVIu5e5HmaJzzwo1ivXvfQwZrXUaIHOoMCJJVGtShj2X+n
	UEARw7MvrZpeDUnx/j5R91O7iXDWroJaKNdm3kwWzB5oFSqcYeqR+13G9NB0pw==
X-Gm-Gg: AZFdTZecmtlGYYIO1vuUc9QprHFP5xuWJXM/DELl09dXHuJVrXvYpxStGYQrtNpMjGd
	WYczwQdmqFULdY1Jsolv5qCYFIb6e4/wLLN7k1E4ye6Ky+DxWL95IER33Fr3/Jeka4/oTKEjPxh
	eYZjebHhhxj0d8DvFA2EB0XBAvR8uR09bUYIbTsb7tVGi3BaYr2SfwBvGOupr4ezEbhl3HHGBV9
	bOZlHgC18DbGPWXB2Btx36A4gX8rG+JqQuvs4h1TXObW3A11Z/o6dN1J5l6QacKvPHKdWqjiaSB
	CPDaIIE0ODdjd8eVLtUUfTE5X8Z9J/aFMf4mZlMrVarji56wZeMkaCVtukjrio4xsGZs541pZs/
	A6UG5Vku2aze6becdxychHrdmUVvG2agfZVM78Vlt4eF0cKPp4WogSCtbZWLCSUmIfTCC7cvbT8
	GosGSHmD1nQLkrLrberwTk87rQ6DdxKblkCV9ne0RILCF3/22vVgtnzDAuVGDrXN8O9nxw4iwDv
	jTSqPqW0aQkp48tePtCouVgpPliyXC7I1JPfwJ1zzNxTmpTzU5gSljshPAcAls3baFVcWDz1Phh
	Azz4IHdKdOoM4EuqglAId5KY72lpEe1IkG6vINa0kyGCxvEW
X-Received: by 2002:a5d:5d81:0:b0:4a3:1468:c483 with SMTP id ffacd0b85a97d-4abb4b85a38mr25287392f8f.4.1795472614064;
        Mon, 23 Nov 2026 14:23:34 -0800 (PST)
Received: from schinder.fritz.box ([2001:9e8:b398:6b00:c303:57b6:d70:952e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4abbd84e661sm23019015f8f.18.2026.11.23.14.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 14:23:33 -0800 (PST)
From: Roland Schober <rolandschober1968@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Roland Schober <rolandschober1968@gmail.com>
Subject: [PATCH BlueZ v2 4/6] monitor: Fix reading beyond the Apple manufacturer data
Date: Mon, 23 Nov 2026 23:23:13 +0100
Message-ID: <20261123222315.223450-5-rolandschober1968@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261123222315.223450-1-rolandschober1968@gmail.com>
References: <20261123222315.223450-1-rolandschober1968@gmail.com>
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

print_manufacturer_apple() reads the type before it checks that there
is one, and prints the identifier as a string although nothing
terminates it, so up to 98 octets which follow the AD structure are
printed with it.

Check the length first and print the identifier with its length.

Fixes: 35b0d0c7c281 ("monitor: Decode Apple identifier and iBeacon data structures")
Assisted-by: Claude:claude-fable-5-2
---
 monitor/packet.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index 6646dc147..042a2ecb6 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -3763,18 +3763,16 @@ static void print_fec(uint8_t fec)
 
 static void print_manufacturer_apple(const void *data, uint8_t data_len)
 {
-	uint8_t type = *((uint8_t *) data);
+	uint8_t type;
 
 	if (data_len < 1)
 		return;
 
-	if (type == 0x01) {
-		char identifier[100];
+	type = *((uint8_t *) data);
 
-		snprintf(identifier, sizeof(identifier) - 1, "%s",
+	if (type == 0x01) {
+		print_field("  Identifier: %.*s", data_len - 1,
 						(const char *) (data + 1));
-
-		print_field("  Identifier: %s", identifier);
 		return;
 	}
 
-- 
2.47.3

