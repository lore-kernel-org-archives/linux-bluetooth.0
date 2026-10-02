Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DC13DDDB1
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 Oct 2026 05:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790919990; cv=none; b=OcPDS647CbpF2FrjQ2mMZkAYaCUaM7FOAsRGJW3EOghqOv7kH05kQbESZ42tTdaRwpU2ildDH6vY9krFOst5lnJOMoGhMEs5JEV/nRivDZPAEFLFTW9KrxADW6+38dWQCk6S/Gys5STHt11cYMYp6QX7TI80eCVwHjUFqPrFii4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790919990; c=relaxed/simple;
	bh=6/qSMBhaPAYLCIRr2oleWp0Di+44LB1E17GC5wD5B+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M1eTkZayz1m1T1S3KgWlt7zhRzbTBLW9pRnQutW3URiD2pgs+XlxYo2I7tnXXK5CmFpD4s4r3EFY4S+3nYOXTdxHSHyQiZBZzcvqvSh/Zt8BQlKD6MAUsSaLmQoq374ou4WcvWC1gEup3ZH7BpVzoJqvvX1PP3raWM/iPfAZaEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=simpleble.org; spf=pass smtp.mailfrom=californiaopensource.com; dkim=pass (2048-bit key) header.d=simpleble.org header.i=@simpleble.org header.b=N9zBA/AE; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=simpleble.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=californiaopensource.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simpleble.org header.i=@simpleble.org header.b="N9zBA/AE"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-34c4a0870d2so2485299eec.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Oct 2026 22:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simpleble.org; s=google; t=1790919987; x=1791524787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CrNaVKyAYZRYTn19Qi2niTjkfAOzaSMQgCY/c/AjH6Y=;
        b=N9zBA/AE5PUZU91xGvDWEEQN9MwT936b0LRNoaC7PxeHc2DJ6UaxgCF1e2p8VFDwY9
         xLyZn0VN+qq0iUa57m6ozbVyCu+QnwuBnOkYy3w7VNCsYPyA9XJpNGQEXAy0qz2V5P9x
         sc6XdzIEmT48Z3e1Bw/xkb4mMCBcb9xJZPH/BLz3e/rgOQ9lTW9loXo/1ttMTppbLPBL
         LHe0nBdxuk42tElaKBgBnon4Df4F9iYc0HpbujbGRmxsOVYFClnzzJeFWsDQ68UknvgO
         GX8CY0hvxpsBJNDk0UqFxZ4L3rZV4C2xWMdyGU0dJ/zLsCNsbOPeBcacLklIL4hdEPyz
         gVdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790919987; x=1791524787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CrNaVKyAYZRYTn19Qi2niTjkfAOzaSMQgCY/c/AjH6Y=;
        b=oCRX4DL8anTtoMyK6jJplj2Q1P5gZT/xFGbRy6UNw4/vnODLZyN8YQ4mYqHNv2I3dv
         RQYkmEUbm6gEW+RA1rUwutymKCo3YkNziqvudVdS0Odr4OvV5Mok80A3e/+/DiVPAV3O
         0v589NXjNAPyZLCToS1ZV8xZCyvTNMfJX1w5fqbVPJ/LNOvjJeHu7DIv4fYFEsRrp98S
         VVMpvv7mWnQil9TyaAb/MXov53brlVKtvt7AmBjrhOsGYQsz3dag0yCb6i/wCFiR7nkN
         X874mbMZ965ZCGS4wXXimt5+G0ZmUZvNHOCSGWwNfNVibV0OMdigWvjEy+Ych+FpxBOX
         egEA==
X-Gm-Message-State: AFq9FYL5qEBq2dVLYkS65ZUf2MdQJ9/0vze+zxq6dShhHu7ECMUM3/sd
	KZnSYjBm3ulw/ssHXliIZeOf3UWs6XZbteYvgCCYHjbgLNHpXr9x6Y67LllxjbSHaITuzHXC3E+
	McStxieI=
X-Gm-Gg: AYBFou36uerMSjEHqOcTWekgKwSwKwjQe9iF2bEN2moCCsKVzyConzQDaLJEDEF7MX0
	S6Z4DkQ4Fev5+lsIY+xJ+v2lHJ7OLxdC4dO7qp3aBciF5YVxUiHo5gmeQpQwV7yUS/U45N7AyYr
	rEOlAPjWrJ09u26m/9ixy3qN+ayAAOaZcEeXkAQBp9S0k86Nc0cfVWo1QMRsy4LfqvMseFbpZIK
	pqFCaqQutpZfnHzemUjiGZaUSvRPxGn12x//rU1dVT5nSsGh+YjoVDzPXCff8roJg3G/hSf9x7y
	3BX800KmRAXgHWJQdjMSFrP3QlikbgGppulAvhr/mr8OZW2B66Wk/xaBQ7SI00Vp8JCoHB38Y3Z
	X6K8sze6RmKRszQF4LCfqrAlg4oi2WghyKbAoIV9ku3d/NIZIAFrA3OtfkvU6M+6gY3GAxEtYg7
	iFtS1qXaASjZppRXZFCr1BGJkif+GgxFnJ6e4aK79zOLR+Q5RGwMG6vEp1B9XtCIWTS1/PZAQsg
	bdiOxmlylcPPCvKwFmEFN7qsD8i23nk/3OWSw26vFOh6tGBO48lOHdtqXA2ChyRzfpY7v6iqii5
	UrM7Wkfgt+zZ2IdHFHi1/cUKL0BUVbHClSsxMANJ
X-Received: by 2002:a05:693c:65d2:b0:34c:c5e8:6dc5 with SMTP id 5a478bee46e88-34f15091cf6mr1882523eec.12.1790919987459;
        Thu, 01 Oct 2026 22:46:27 -0700 (PDT)
Received: from localhost.localdomain ([147.185.47.151])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34f15019999sm3064217eec.29.2026.10.01.22.46.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 01 Oct 2026 22:46:27 -0700 (PDT)
From: Kevin Dewald <kevin@simpleble.org>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Kevin Dewald <kevin@simpleble.org>
Subject: [PATCH BlueZ v2 5/6] client: Print Connectable in info
Date: Thu,  1 Oct 2026 22:46:16 -0700
Message-ID: <20261002054618.30994-6-kevin@simpleble.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261002054618.30994-1-kevin@simpleble.org>
References: <20261002054618.30994-1-kevin@simpleble.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This prints the Connectable property of the device and its bearers with
the likes of info command:

bluetoothctl> info <addr>
...
        Connectable: yes
...
        LE.Connectable: yes
---
 client/main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/client/main.c b/client/main.c
index 314aead..35cd427 100644
--- a/client/main.c
+++ b/client/main.c
@@ -2026,6 +2026,7 @@ static void cmd_info(int argc, char *argv[])
 	print_property(proxy, "ServiceData");
 	print_property(proxy, "RSSI");
 	print_property(proxy, "TxPower");
+	print_property(proxy, "Connectable");
 	print_property(proxy, "AdvertisingFlags");
 	print_property(proxy, "AdvertisingData");
 	print_property(proxy, "Sets");
@@ -2054,6 +2055,8 @@ static void cmd_info(int argc, char *argv[])
 		print_property_with_label(bearer, "Bonded", "BREDR.Bonded");
 		print_property_with_label(bearer, "Connected",
 							"BREDR.Connected");
+		print_property_with_label(bearer, "Connectable",
+							"BREDR.Connectable");
 	}
 
 	bearer = find_proxies_by_iface(default_ctrl->bearers,
@@ -2063,6 +2066,8 @@ static void cmd_info(int argc, char *argv[])
 		print_property_with_label(bearer, "Paired", "LE.Paired");
 		print_property_with_label(bearer, "Bonded", "LE.Bonded");
 		print_property_with_label(bearer, "Connected", "LE.Connected");
+		print_property_with_label(bearer, "Connectable",
+							"LE.Connectable");
 	}
 
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
-- 
2.54.0 (Apple Git-157)

