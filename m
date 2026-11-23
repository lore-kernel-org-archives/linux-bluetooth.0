Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795472615;
	b=vhQ5/ETUZpcQLsUiLQDpwgfoXrLjip9tyqQGCbW2ibqYPYgqqIMdC6aLti7HFzajGlfH
	 FKOGYvB43XP6SvPx1zf5wHEl7eNRpQyLHQ9RRkJkMTus0ub96A2RVGO3v5ero1L5v0ule
	 GT6spOBbz4yiRv35o0Sb6GB3ONxKT9wYzgYdPwDeHbXnzkV49SKOutZwPqcIjW3f20TAc
	 GK4HflJbzGHyUGOD34WClHW10hnbDjJhxEAkzOzvfvSB47STQPjDOVi2CIjWvC5o/0PKD
	 4KqxWO8CNv+VwPMNK+pl5iUo5T+nWdacrjdi2CrUlwpw9RWBqfhgMz1vQi5gzeYKRmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795472615;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=yBI3DykBcTF9tWQp+AAl/WWHa3FuDurnYiSblchHTCs=;
	b=3cXtD06m1Ies3SeTwlsTzBfH622gmGVJryXd/IB+NDZhkVVih/ZM1n6BIJB4OBXXT75s
	 3bjv7PRuvbANtk3R3P5mjer+ZsdESwD5nuhwIyrMVDpOzVyrjb9pniElIaINAP7/Ov0aU
	 4yrVTtej9nxaexdVprXTBrMLB0CzouX8baa0wjtRDbRcs5uu9Y3yQRwVZDGR92F48JLHg
	 xUuRWFE+KFU56hATGm2hDfn39cx5KzB7ootOqkp2wPo0JfrjrAcfjmLn2wdGqQJ8YWq6G
	 ZNLJAQa7Zhb6tOtN6RHdp+Y+kHgqVn495mOsOOiqEQpvqRYWIMWnEJDf0WP2q2nl77Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ep8rtv+l;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABBF606A326
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 22:23:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3ABBF606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ep8rtv+l
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4bb5f0c5348so1993755e9.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 14:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795472613; x=1796077413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yBI3DykBcTF9tWQp+AAl/WWHa3FuDurnYiSblchHTCs=;
        b=ep8rtv+lt0XeEjT8CuJNXqFb4LZtsbQF0PZlrLSR7dcO1Pir83NUssI/cPwAswcYz7
         MgQdtuFcJb/Je6Qpe7M9VdwycD4G1VioQvofFDzp5w727HtBF2vgE2AQagnZqZk31Fxy
         NG1z37nEBLIGP9Vc8WTe6VYpQx4Qsv4gAxPcjkLBmOF82Gwq04j++wi110WF7TvvagKg
         IcQR3F/iTulEfim90jXxJkpx/UC6tTptpxDLmBPoZbNu0O5rvQjLVaSgX5VgWzsNtS3L
         vT88ddbSQkGZwON8MY5aAzwgZVX40IaM7jz7XmyS4xejadbrBq31AqDaNUr0Hv4qxE0P
         TXmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795472613; x=1796077413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yBI3DykBcTF9tWQp+AAl/WWHa3FuDurnYiSblchHTCs=;
        b=d4dvcyk5RKHmPhgD4tJXQrPn0W60XqTX1UVTcTiN0H05ABrpWMJCaxTcl+7zmgGoIz
         8CDOhlVYKQeQ34CeRJ6eaFID1wqjArc0/kDL0+3EPZ/SXPuMDhvnEsMZb9CyODZu7nX9
         E/kzyttuqQ4PBe1R9CNIrAY2bbYXtzBEfBKfWJovUo8+mKyfGx6PJkQTq920q9TNujWn
         Cm1ly6CiFD6ccr6IIooJkBp6wKVm1/of4jXPI/Y8p9UToSnRUdpPa5SZt/1auboqLg+G
         9fus5STV+7KbWbQ/qDaIPRUnt99ISEK5DslvkjdJvWWa0dp1ogJyI9TZGZWSKsgw2/dK
         sJZg==
X-Gm-Message-State: APuU4Z/7umFL395qUKct5EkVCbYhwEau7v+iMvMfyKx1bhwg+FxstqqI
	GOvrZmmFa6KMgtHTQM4C4CmcyChhv5/GvlZMJpgKpDExBSqVqhiW0jt93TibNw==
X-Gm-Gg: AZFdTZfiGCGv+XGX0oxDRp5hFalykt7OCa6HX1du+y+r1BilZXfft6CNrXHxPE3/ZdI
	INitEwD83QaBh/oWA3wItPrL67W0YK8xdIwFHAKDQrJL03XHgAOfpirzLFDjJdNDB1SLJNX1/XJ
	ff0Ps8JIEcAJQpvyVWwnoZuUfQIUd+1mZEjlKvn6ZzAPdIeMoKpEbbJQMpv2KjXQ6UJmISzseCw
	QFCKn1t3PGg+3DISCSeWwjGEPtcfW/psqH6umAOHr0dYvUNQJTtAemVN/SvE/tYbxVq+MDmwk+F
	+bZZIBklZz+MAXHxLODYUNd2r17rrHdc9NERoouaLadHu9901lAgOdS6Qq458I/MgRpXTBThufI
	a3vhK483iEF1OVDvbJyrPxwasSnQQaEfXB8khu6ZW1Gr3RumnK4a7RbQYidE79RVbjB11RdWA/Q
	k4B0pKRrbZbgYnDaVuz6fI6nx05mWmlNSQWB2uU6nSEfGBcu2GU0PEzmocUe2X121jFNBYX3xFB
	ITeSgExZPE5wBKewKqxMpDzTXzGJlQbQp6RxN16H8jCxLI/b+R/1EL7Pn9iitIy3g1N4XsNB8/Y
	NyFGrLWpA7Rt9kwGLqbkmoA1hmXrbL0fYGovdYBD8FvENT2f
X-Received: by 2002:a5d:5e01:0:b0:4a8:eed3:770 with SMTP id ffacd0b85a97d-4abb47b25eemr26171187f8f.4.1795472613611;
        Mon, 23 Nov 2026 14:23:33 -0800 (PST)
Received: from schinder.fritz.box ([2001:9e8:b398:6b00:c303:57b6:d70:952e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4abbd84e661sm23019015f8f.18.2026.11.23.14.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 14:23:33 -0800 (PST)
From: Roland Schober <rolandschober1968@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Roland Schober <rolandschober1968@gmail.com>
Subject: [PATCH BlueZ v2 3/6] monitor: Fix reading beyond a short Mesh Beacon
Date: Mon, 23 Nov 2026 23:23:12 +0100
Message-ID: <20261123222315.223450-4-rolandschober1968@gmail.com>
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

