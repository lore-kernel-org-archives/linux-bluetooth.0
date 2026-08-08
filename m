Received: from mail-wr2-f2.google.com (mail-wr2-f2.google.com [74.125.225.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEC02EB0F
	for <linux-bluetooth@vger.kernel.org>; Sat,  8 Aug 2026 19:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786215815; cv=none; b=nDG87ZMTcSYvcmExzDcg2oSY38fXze+/YpVGb5kGtxDhxWijCWBL2AdFB0jpYEXEzk6pKyr+O1EE0eYqWPAThMvo20xF5d940oWVzByCcA76fBr7NHhpzCbhqDoofvi8mqfqUnBMahIN0/tqHnbF+a90FrsDp8Aa8MtvtzQQdJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786215815; c=relaxed/simple;
	bh=1pDjkMQQ5RRAASdTcvFVATsv9HIonuRZ3FqLVdxODKk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=D0ZfVO+N9LqoC0fqw02MOhinpynpGIn/PQD4ijqgyo0OSVprAl909Pn3eOqlpeZD4L+TSF0EMlQ+EMxldiHrC1T1F6kb2YNle0rHtskdwz4jAlY7//73FJZBHxeRMQy9x4BL/0sJlV+y71IXp6mQQRm4lQqFYIW5L4g2UaVR6ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W2w3EUno; arc=none smtp.client-ip=74.125.225.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W2w3EUno"
Received: by mail-wr2-f2.google.com with SMTP id ffacd0b85a97d-4730b8edae6so228281f8f.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 08 Aug 2026 12:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786215812; x=1786820612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TqlevcvsTYj6ztwr3YP/EjSdp2J1GEIRed0PkRdn/8E=;
        b=W2w3EUnoWpiLomCZNfOGXSrnEaq3gF1m8ub/mZoYrA57U/jzyztWu23vbR1q+s6azZ
         MaTa0nxm5KipDXGR4CBxTIJrqeDchPDNysdGwZWmtLnmTu0krdsCLrWgRXO7M+FQoZHi
         DG3r+hgQYZN7W5N3tAnWiz1X17h1RgiiNcphs6NXK+MPTNSoquzXQeX7sm3SmS6P+vFN
         wJi8Yz0Vqq4/Lwz87th8Tmx0jFjI2Br1swgEIWCuXM8vg6X6bAGIRfxrcDbwfQ+uStjI
         79MIR/CDOeHAQJX+OgvY9TD2C5zcWfJgjFjVywOXRPcjWIG80dOfn7Aglb0g4tmHwaF8
         UvPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786215812; x=1786820612;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=TqlevcvsTYj6ztwr3YP/EjSdp2J1GEIRed0PkRdn/8E=;
        b=iXP9Jhqkuj0hwoGtR7uH87T1RHLs+2BQKL8qhQ8EGYybP8nViCWwsfeQ7GaxBz1agq
         vU33i14dt+aD2wN97keFQeY0CUQBhYC8j2fj9M8G4SL3/E8gjsUYQ/Z4KLnjLc+PY/ft
         wk9Haj1nwprp8guhqK47Xg6t8SCLksLfbOQrIq9rVZArVi6uwv7Gxh6nrxtdUeaVq6x7
         +aJyY52AiVhVq7JT5iZ7wjaCyKtuZ7O7pvy/3RbLwTTaIf5UyOLBdaISwL2hFMXeL2+2
         5TTlzQspEHxYUcBi3lTwJKuDGWRYGgBLxJBd576XA0/9tUXfaNXhSGQ3+MPAcnN2Az0q
         /qPA==
X-Gm-Message-State: AOJu0Yyq9q1QNTRn2K60k5Js9eG/+IWNJYlKhFA53VPPdB0gCyieC2z5
	QkblkxZ94/FyTTEwVdymgeUjf8aOBGEo8OFJKJYLD32p7QudSyx74y7XaAb7WsK4wWM=
X-Gm-Gg: AR+sD10tcjBxA8v9vbuKVSAeSwtSLaiSXDzdWyabhNLymRNIEdFIy3xGNpxmnBVYp+B
	ypn6pzJC+/qU6M7VObkknr1pOVKfweCTGzt87sQz9DXuD1HRh3CzUtU1+8XcOhKl33IMd9QEBpv
	xzSfQiw4moiwbh74/NU5yjARnXveHy9M8L6SbBdCdljUkEs26NkfHdbRRp0QK/Ipj3K549a1MKx
	1N5CAVj6ZOew1qUzpw8G5JOhQcAwdOh73GZFuRWpo6ctA7pUtCv8uYws6cXF6R9pZ8RLyOcjvUR
	hZF8Ksz2Dqr9PJlse6uPNUaXB5fat0O5aainhInpVB/8OJEH29TlhXFWEaN1eDEstAdqiPgZsmo
	TfxrE7a4u3+x6xHdkwnOXfllqnavphmB1UJo5ViW1Lart/CUwk2gBgvUbUM14Ft682tff5CNlAe
	3By1T9bS5oBWXmsS/k6qzRzl9QM1ScSsRyiri0kk594/Kh+kmmnJgwN9c7EAgzs8Xww/8SSTcgm
	YLSHIVLJ6wc
X-Received: by 2002:a05:6000:41d3:b0:45e:e1a4:c4c3 with SMTP id ffacd0b85a97d-47fec628b57mr52144896f8f.15.1786215811671;
        Sat, 08 Aug 2026 12:03:31 -0700 (PDT)
Received: from arch (user-109-243-3-173.play-internet.pl. [109.243.3.173])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021fb89bsm16087082f8f.30.2026.08.08.12.03.30
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 12:03:31 -0700 (PDT)
From: z4pdyy@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] client: Avoid scan prompt when discovery is already active
Date: Sat,  8 Aug 2026 21:03:29 +0200
Message-ID: <20260808190329.126211-1-z4pdyy@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: z4pdy <305461556+z4pdy@users.noreply.github.com>

Check the adapter's Discovering property before prompting the user
to start scanning. This avoids prompting to scan when discovery is
already in progress, which previously resulted
in an org.bluez.Error.InProgress error.
---
 client/main.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/client/main.c b/client/main.c
index b5cad8afc..b8087c449 100644
--- a/client/main.c
+++ b/client/main.c
@@ -2297,8 +2297,20 @@ static void cmd_connect(int argc, char *argv[])
 	proxy = find_proxy_by_address(default_ctrl->devices, argv[1]);
 	if (!proxy) {
 		bt_shell_printf("Device %s not available\n", argv[1]);
-		bt_shell_prompt_input(argv[1], "Scan and connect (yes,no):",
-				      prompt_scan_connect, strdup(argv[1]));
+		dbus_bool_t discovering;
+		DBusMessageIter iter;
+
+		if (g_dbus_proxy_get_property(default_ctrl->proxy,
+					"Discovering", &iter)) {
+			dbus_message_iter_get_basic(&iter, &discovering);
+
+			if (!discovering)
+				bt_shell_prompt_input(argv[1],
+					"Scan and connect (yes,no):",
+					prompt_scan_connect,
+					strdup(argv[1]));
+
+		}
 		return;
 	}
 
-- 
2.55.0

