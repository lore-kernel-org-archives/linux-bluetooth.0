Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9210121577C
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Feb 2025 16:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738687777; cv=none; b=tOol2ZXWO4Ud7gS1DEG8Plbuy+p8W4k1oMDv7bJZKTkpBC+jPmWc3CY71ZhDBm9ETr0aUPo3WBMGsJzkkiT2qW8/zDlFN4z2N8TT9hAyzHFlEXjbf+i5863BUx/+ZAGD8r9hI6yqePsfUsyLXmyVePC3l5cEJOvlTWF5vK5/K60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738687777; c=relaxed/simple;
	bh=er5wmXE9BycKwFgE/5FiVRthZhGScW8nN8LWk7AEA40=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WHWiOfuQ00xFEOno7X0jbOIrPVxmvF1Bm/HxehF//Akfyjzj+SKsozmcSqQXz9fVclncYYS4+dcrUHCYXC9kwBEiw8nHRMVfLOccRrEwChGLy0IujSew34epsRFZZQjq/1956xyT/bZEI7bm+FuIJOVfl0AG8CEITk/50uU8vJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iI8dV8Xu; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iI8dV8Xu"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-4b60c221587so3472388137.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 Feb 2025 08:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738687774; x=1739292574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H6j6nJvQzcn/Hs52cmJHx6qoZdl4l2nrD13rdy1DRQA=;
        b=iI8dV8Xulmy6pBOxXWzC8gTh8/LEyNVrO1DmGGlECV1aiB8Bsc8+UafEIyuA/QL5BZ
         p9NVlwayzq5i4Pipp9TyrYMZvrotrRwgXjMSJKArXcxidqtv9qShlFlC/sj8fxZ78n4h
         hr2ku3b9khGYoVlX9JdBYLb0yYGGU5C+gLtAyerJOAGWe3NeoY8GvV9Oe8NLHQodF5Pt
         QxISWXKu30luuTl6JHOSmczjYOAu5x/gj9QZvhzSv2lxq2zzgBLhh/2I4vZx0eey1k49
         XMIGNgCyFukwiSchB1LdxQiFPYlV4I5EBo7+4dG7HmCMpyfIlJxJSARtFJw6ndN4JLDZ
         MDlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738687774; x=1739292574;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H6j6nJvQzcn/Hs52cmJHx6qoZdl4l2nrD13rdy1DRQA=;
        b=xEwgDI/JycPT9qdr3ilXfffpDczgmgPRPB0/ELvTfcI+GCw3w/hDNkTScsWttshWyf
         kynQdRb61oCtyNqFxIzhHgsLU3JKgVt5KZkc2k6HlzkPBph60HkSzCNbWOhqLUMTK3uK
         8kD2eT9CuJLzSzMQKe3wDZDg4EgGWsj2dyvfweyMLy3+B0W6g+MLRKVBFRu7DL637wx3
         qGKGv0PSTf+0QfSopwnDQ9Pp2qYcsZ3/BrPObU8CHRCaGIwbpGSgLS802Elgov8sfVfq
         4DBi4xAbneMD+avI8FfaP6L+ZHjhpMOq7Dei6k0bnWJBstXNPZfJBSF8x8Upi5IBF1kH
         y48A==
X-Gm-Message-State: AOJu0YwPn8xPrxU/WsGtf8XBNeGeU6IhxSKFpb22ntnRe/7OMKrZFbZf
	2Wtno65XNVbsD5im3aLQeJTchK5jkINKe93+otXt06af6+axI9MNgMgH/mdUbuU=
X-Gm-Gg: ASbGncveSNQkcXtz6lpnQc+vzsMOG8gi6+P4jD6hXZNxtPRfAPjQGFZMVTLkRQ4STfq
	CN2fgg+Uj2RK2S8fdcpz5ahey5squH3BPbTSCtEb8gs4Z7bVRoADXOmbn2yXadYdHzDSQA1ZIjW
	tmLD6+8vR6nwvyYZ0nlRE5lzYiYwxMsuchdLKiakxPU/Bfia1JuEbKzyPuikHsI0v/ULUFQCzFh
	pre5j1AMRWpwRDT6+8FJgWMqemtDzwGshowMGnlynKXROGApg9xxXN7WpHp3H+rQHA+ws5MGjau
	4EdDb+5AGRUw4g1uODN8ewLGU3B8sTOXASf66IGRKmHnKKIXScU1ShSDhhzeBR4=
X-Google-Smtp-Source: AGHT+IGw1Ef/dHpyISuQkBtB/IWksGv1RF29ITsjDWzMCepFaJSIOKJUzv6LxryENHe+sH55J4GWOw==
X-Received: by 2002:a05:6102:800e:b0:4b2:5d10:58f2 with SMTP id ada2fe7eead31-4b9a4fc15bdmr20035685137.14.1738687772712;
        Tue, 04 Feb 2025 08:49:32 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-866941f13c6sm1991882241.33.2025.02.04.08.49.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 08:49:31 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/2] emulator: Fix Werror=stringop-overflow
Date: Tue,  4 Feb 2025 11:49:27 -0500
Message-ID: <20250204164927.2839802-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250204164927.2839802-1-luiz.dentz@gmail.com>
References: <20250204164927.2839802-1-luiz.dentz@gmail.com>
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

