Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3D7218AC3
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Feb 2025 20:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738700398; cv=none; b=pgGRMJkttJSgP9wR34KN9gfYu163Pn6uBF9Glpyit7ygI0pLE1qzxV/rIy/h/Qv/DIPM13rcF+vnuC2SNia8JC8kYQEkZ2fOUT3Td0XzfXMXHhZMIk4ZHrHy1OtWOnrguI49A7alZzaV1fwQANIvELI8AgJdUBhXZqM2+h3Jhs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738700398; c=relaxed/simple;
	bh=er5wmXE9BycKwFgE/5FiVRthZhGScW8nN8LWk7AEA40=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=my1s66ARBRK3b2Dl7nDBozyNEIcOystYur/MREoF7CNsYt+xjXCBWI3pURHbWdwOf8PVVVvIGkhsjeqtyjF57TZUuiyM1eLhxZdbWpGFumm8HB/Y9gb0KfWg/mLoqsHDTJ4z7av7YUf+zYuwCILPfqftssMNQdCaQlcuve2Y7Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PxAJLfll; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PxAJLfll"
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-85c61388e68so1214721241.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 Feb 2025 12:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738700395; x=1739305195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H6j6nJvQzcn/Hs52cmJHx6qoZdl4l2nrD13rdy1DRQA=;
        b=PxAJLfllSMgiZI1dRFy+KKFn2mCTrNe1yjeWQ/n1edHxq5hENKCS1iST4dD4/a0Tj2
         uSca5An1eC3UriCb9iSyVxfYrqoW5cY8X5jGm/9cB2ZpyasJ0dGnpZxaKF6d0NbP42yU
         R8PIZgasHwTHnMS47lDpUaCbIu9e+XDa8HdPvdbzOJWDsvmJYSxf96dcmbMUDu+cDO35
         HEIX2ja7ZQtI8//JuReIBBujZAd3MMlfKOLkwPVNALLKFxz82qHwz3qKoL65IozVbIer
         jJUYrWcXzLUCiUX49lhBPLHixi2ECq9pR65Gru0NIzRa272L/YZT3xEm0W26nuC/GGCJ
         NeWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738700395; x=1739305195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H6j6nJvQzcn/Hs52cmJHx6qoZdl4l2nrD13rdy1DRQA=;
        b=p6fhFpIQvgbdzXs8DtG6Vnt2ZRdFTfqX3bptivKS5Dws09a3fiFm3SaAmScc+fiKHl
         YytBrfj60CsadcMZhYKjThK4O4imi5ePY5dXcK7jFI/aB2cSP+ime614kYSEFkO8iKph
         txtsZWeRHG+5O67T8KpYMawttc/0eYYmBJSXTjEQ0HqSmyYJqNo/4aMXNHMWqSUmF7Dt
         ZMXeHQWAOZcc+LR9uumhJ6/oYfj7UJak9zFT7d5ikQRlQRambWBSoWjzLtJS0KDhprDG
         jW8MtOVUcFZWJqi2Nh2C6Mt4UbzNnJX8/J/mYoW1S5lkg7KQIQbCZFZFD/CgXG6C8DNH
         vtKA==
X-Gm-Message-State: AOJu0Yw6dlanvfJyv4qRK+KncWq5vgP1rZ4Iz9IeCh5v8hWnAacs2uyU
	vswuWtu8m7YVHUEh3ahS5hgFvs4SJc5a+Znbqb30vWczOjYdrKqHJJEEMBF6d+0=
X-Gm-Gg: ASbGncvnnfcSz/pYPlCHxyQDghsZx0Y89S+y8Bx0W9PnbjdydOOJvREHgx6zt0SWZ6m
	DmMEooYng0VRrUmWGvwV9R6JKJnEEjN3SO/o3BG23G7Q5pYG7PNfxvn8Wi4MPhT7aC/DyyNzLNF
	kd3BcRYnOSgPGWwDopb7hjZNKPtlEp3CGOcTNffo4oQiFvN/QARTG/h8V0ZchZqsQBBtFfBuWpI
	U8/OeC8u7kWtGIREAL1lJiAjUoZ7vFLKAqTIfcM1Qi4yYvXFx/iyNl0Jp8r2jk5h3Ku/5c8xYLn
	DtszbdB9UY+CRIkEcReBCT2M/DvRP0YFERFkuzcCxqaMPpOrNyrdyq4HS/kb9aA=
X-Google-Smtp-Source: AGHT+IHxM9GML4F3Pg6S9ycdRtuOAwZYpH/Ql2MlvzxSNN1ofQzpF3paxfBM4/TnAk+2LmURKPPYKQ==
X-Received: by 2002:a05:6122:8f06:b0:518:81aa:899b with SMTP id 71dfb90a1353d-51f0c4af5eamr459086e0c.6.1738700394755;
        Tue, 04 Feb 2025 12:19:54 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-51eb1be873csm1602232e0c.10.2025.02.04.12.19.52
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 12:19:53 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 2/2] emulator: Fix Werror=stringop-overflow
Date: Tue,  4 Feb 2025 15:19:48 -0500
Message-ID: <20250204201948.2883452-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250204201948.2883452-1-luiz.dentz@gmail.com>
References: <20250204201948.2883452-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the following build errors caused by buf being used as a
static from tracking progress of a packet when it is not necessary since
pkt_data exists for the same reason:

/usr/include/bits/unistd.h:32:10: error: ‘__read_alias’ specified size between 18446744073709490177 and 18446744073709551615 exceeds maximum object size 9223372036854775807 [-Werror=stringop-overflow=]
   32 |   return __glibc_fortify (read, __nbytes, sizeof (char),
      |          ^~~~~~~~~~~~~~~
emulator/serial.c: In function ‘serial_read_callback’:
emulator/serial.c:78:24: note: destination object allocated here
   78 |         static uint8_t buf[4096];
      |                        ^~~
/usr/include/bits/unistd-decl.h:29:16: note: in a call to function ‘__read_alias’ declared with attribute ‘access (write_only, 2, 3)’
   29 | extern ssize_t __REDIRECT_FORTIFY (__read_alias, (int __fd, void *__buf,
      |                ^~~~~~~~~~~~~~~~~~

Fixes: https://github.com/bluez/bluez/issues/1049
---
 emulator/serial.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/emulator/serial.c b/emulator/serial.c
index b74556b13547..f8062ae5eac3 100644
--- a/emulator/serial.c
+++ b/emulator/serial.c
@@ -75,7 +75,7 @@ static void serial_write_callback(const struct iovec *iov, int iovlen,
 static void serial_read_callback(int fd, uint32_t events, void *user_data)
 {
 	struct serial *serial = user_data;
-	static uint8_t buf[4096];
+	uint8_t buf[4096];
 	uint8_t *ptr = buf;
 	ssize_t len;
 	uint16_t count;
@@ -87,8 +87,7 @@ static void serial_read_callback(int fd, uint32_t events, void *user_data)
 	}
 
 again:
-	len = read(serial->fd, buf + serial->pkt_offset,
-			sizeof(buf) - serial->pkt_offset);
+	len = read(serial->fd, buf, sizeof(buf));
 	if (len < 0) {
 		if (errno == EAGAIN)
 			goto again;
@@ -98,7 +97,7 @@ again:
 	if (!serial->btdev)
 		return;
 
-	count = serial->pkt_offset + len;
+	count = len;
 
 	while (count > 0) {
 		hci_command_hdr *cmd_hdr;
-- 
2.48.1

