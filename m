Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A575447ACFD
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Sep 2026 18:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788460102; cv=none; b=BDBSrWcQU1VF+xBhSiTV6oq3q34mVHqz2+YJdLCsJfuriq4BM/AnqpksR3TCBClhrGy3FlefzwXJ11TSfrBRbbBXUFmERlotv9uuyfTXGxkrdmrPmp7a4Uv6eA824ZFIj5Nj6FXisUGN4BBr3F7CGq6rpAOoO7kNr07lb8RVqyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788460102; c=relaxed/simple;
	bh=nKSfzypBLsxsd0ZPfwX0Fn1Mb4UeM73YQb8YEykuUSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jctLSG5RphtA/aeZgV7h7fG3yx8Rp/iOdsMYCplHOkQsbrHzNoRee8uILubOKBalbJxa2IYdNXniYpLDYlg0NXLGbUGtbtBhYJ2cq7vP7b4As2Mj4t+FefUDSW/k+I7/rd4eMcWx5ocp46BdHx3GY2r9G2U7pqRXahJVgAYyVdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=embeddedts.com; spf=pass smtp.mailfrom=embeddedts.com; dkim=pass (1024-bit key) header.d=embeddedts.com header.i=@embeddedts.com header.b=lYJx7Nua; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=embeddedts.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedts.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=embeddedts.com header.i=@embeddedts.com header.b="lYJx7Nua"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cbedd5aece4so1023327a12.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Sep 2026 11:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=embeddedts.com; s=google; t=1788460093; x=1789064893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=00iMK9oZnqfI+bhkNipwLcBinQaiti2hc0sX7I4Z+iE=;
        b=lYJx7NuaONxg4fJ5848E//MQbt16inYTgb5PIGuZwjz7Y+NF95xscSgO4sIIWpi39l
         rTyXJwk1ZmJud9ssMRC9boKhdJUAy0M9Or4oAeCASd4Q0UOTilJbTj/MNA8Gt5TkF/rj
         5mY9cQNgJxsV9gg+qr/SqQL8oyTXe9lrCtZoA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788460093; x=1789064893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=00iMK9oZnqfI+bhkNipwLcBinQaiti2hc0sX7I4Z+iE=;
        b=YBzr1aUlfh4INrFmUIu0CSIrrBT6hfcIfMm1I4eFzqfwb6zMrcJ58qoqtBTNKbc8kv
         cVt4esB33VoffDxFBERRe56yk5IZii/wuu9k/NwW+ksm7UR2uyI7m/mrEnG9M0liU+HM
         GE5E8V7RgTEgUoynevBR9tx6/mNZZoeQGwLd8Ad3hb3VmkTgE/y6Gf1tMMWaKiQ5WS4c
         fBlll31Os8JEJfmMztAVAdwByUwF2RwWNY6djFZ2RGZQq8tOcG0IeDjrhshTlC54CKcu
         eLDRdzDb+Yy+kBEaNXMEotIaInc6amj3e0cLQe8jOQ2n7O5bF40LqMuVCJZ3BrDV5n/i
         HtDw==
X-Gm-Message-State: AFuF++mPcRxGCBFMPL5w55Ryt2AqBuD7HnmR63XX0BYk7wsZ1ox1BcoI
	n4plPkYU9hyXAnKr2ZbcIHhbN+f+j6X0L0zfIYmQeEkQOZIRfKwZjIaUxsWWE0yaPTWUegEOI5Q
	nAika
X-Gm-Gg: AYBFou0iVrKBIKRGNBwY9pVZEAqFscUqwPOLPxpGkEiyqDF0Xa+tXTYHbUExPBJL8UG
	8JovaxaFJ04NeCP/SS+xNbw06MTjWu3VgafPkGn73GpCIt/uMRKhi8+Mgdy50bYEMJEKNqlb04O
	aEzRy6cYkn8ydnXSQvDEgZ13NwzlnoqiU5+AAbVDrvXl6CZQOr2fnShTJcqx54bc/wFRG1goj/W
	ifE+e/8WrTDbYcl7QLtNYZTJZLyYnbwkUCGiJAqCkx233YXJB18LZoZ1Kv6FudqunMx7ByIHSfx
	CwOdkcbVtJTRyASzPhPHOHtEDChIFgpD4s+9ff+AXXCz4zwpJc4zyUfNtlK52TG6LPzSLu7hSXu
	raaBxNxUEv7it+k3YZVNpKtRYc2JFxrhnT+1j4NXjIyi4FE05CHQZzvJ2oDrJ0vMcy08Hl8/qxa
	oHkL+Xeqie7RGkCPdpANSRn/fNCN6+Hio/C8FWUVfy2jIyh30zDxeSnGQ/r/OYG/yhUyBC59wWa
	oZ92P6vtr4jlbjEzbB/dPzdsfZ6gLs0Dxeo+lz3
X-Received: by 2002:a17:90a:e183:b0:37f:e5b1:ec4b with SMTP id 98e67ed59e1d1-39b07f305admr8248662a91.5.1788460092757;
        Thu, 03 Sep 2026 11:28:12 -0700 (PDT)
Received: from aaron-desktop.ts-local.net (wsip-70-191-90-18.ph.ph.cox.net. [70.191.90.18])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-143243f780csm1150630c88.13.2026.09.03.11.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 11:28:12 -0700 (PDT)
From: Aaron Brice <aaron@embeddedts.com>
To: linux-bluetooth@vger.kernel.org
Cc: Aaron Brice <aaron@embeddedts.com>
Subject: [PATCH BlueZ 1/1] btattach: Update for glibc 2.42 compatability
Date: Thu,  3 Sep 2026 11:27:09 -0700
Message-ID: <20260903182709.473976-2-aaron@embeddedts.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903182709.473976-1-aaron@embeddedts.com>
References: <20260903182709.473976-1-aaron@embeddedts.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

glibc 2.42 baud rate constants changed, use cfsetspeed to be compatible
with newer glibc.
---
 tools/btattach.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/btattach.c b/tools/btattach.c
index 5f7d19093..cdd7b125b 100644
--- a/tools/btattach.c
+++ b/tools/btattach.c
@@ -64,7 +64,12 @@ static int open_serial(const char *path, unsigned int speed, bool flowctl)
 	memset(&ti, 0, sizeof(ti));
 	cfmakeraw(&ti);
 
-	ti.c_cflag |= (speed | CLOCAL | CREAD);
+	ti.c_cflag |= (CLOCAL | CREAD);
+	if (cfsetspeed(&ti, speed) < 0) {
+		perror("Failed to set serial port speed");
+		close(fd);
+		return -1;
+	}
 
 	if (flowctl) {
 		/* Set flow control */
-- 
2.53.0

