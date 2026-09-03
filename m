Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B552F3769FC
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Sep 2026 22:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788474005; cv=none; b=ml6aehUj2Shvqea26KqbLTWZITW/Si4J6xPvj+r8S6GKjgxvxuXDVNssP/2V6kCrBLTpvseRAYiPkiz541SI/vMJ8xfl+DDHj4VDpMN7rWt/5BjNJA4utuX0eEuYBmNDVLdWVJ9Tzw9+xPaelzwpdvbkb4fbFxFrVsWoXk3Tmio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788474005; c=relaxed/simple;
	bh=1Nk5prkP3AGMsiZhherBA5myua4FCirAk7URQgeQ9sM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UvEw3PrEnXLH8Esj4xvaFe9yKSWMZ21hszAA3ETUTbsuN1JvLJy9NhJIH/vslts+EHOH8AqNs9/OQkulIDiwzsNINqbTCshUVrJen+m3GBnlPcd+SxmNE+ofoanN245UHtQuSj1Dzy2COinueLQd6vVBB58SjJyYvAI7+eGSxCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=embeddedts.com; spf=pass smtp.mailfrom=embeddedts.com; dkim=pass (1024-bit key) header.d=embeddedts.com header.i=@embeddedts.com header.b=MCJvSj3t; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=embeddedts.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedts.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=embeddedts.com header.i=@embeddedts.com header.b="MCJvSj3t"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38759bcd877so341846a91.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Sep 2026 15:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=embeddedts.com; s=google; t=1788474003; x=1789078803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RUEnSEWhNJ/Xzg76GKZXnJeNGJEYpzyXZg9ldoBo21U=;
        b=MCJvSj3tDXy332RwrO+iNENKj3EHdoUnrDsIASbRuVLUabtmj5wdqbh3Lx9iozYlO2
         bvfDlckmrmpH33Z7pHJfZc4lm/97r+FRXF0MEW1uxCUrpZSwFDvw0Rhj9HPfFDu4Ceas
         FLTHIxntanXa/zqOAxsxOv9Rp12u1SSnbLfFg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788474003; x=1789078803;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RUEnSEWhNJ/Xzg76GKZXnJeNGJEYpzyXZg9ldoBo21U=;
        b=CQN3B45/7w4aRGpZyx8tU97kvepuDZOg87uN09MUEYrZel5sN/TWg1ZwKw8nNUaUzd
         dNv2ytTV2ZFZnnej6ZeUpdPkYFAp9m4zhcy+/gCbeoszOPI4yqcQSb1WrwV70TQpbn1u
         ZH6YcWLLSxhnmxqx62EXxHrcDTJ9iutAsvuASvMrZah2bk2FdrYKkUp5cUO3DNXTiHDJ
         pcW//hY5GD0CD41YaUZ41O4+CYV5g1hqIwXQqOqOfDij4jzJkCUYMefZCsyghM6LFyjk
         3JToecHZZDBooSSaTZFvgUsmAUMqTY1wX0YzPScvMCFA/AWI2/XhDMIAS1F5AKbNa6oi
         aZug==
X-Gm-Message-State: AFuF++lABehZ5MtmmxlvlNQCgyYXlAy2Exi5mRxfaXmsBBiXbGfqLYKw
	+WLtRNM3TEcFn9+6/a96j97NuinG5NrYLU4UNqoH27Cr1vWszBGpCaFuFbNZBVg9xIGGfXXKKZG
	TTYsf
X-Gm-Gg: AYBFou3v28TpAlKa4aCYOTVw1BOWE+Fe4sThTHU6TijdNBre/G0JONaeQdrw2DAyPQC
	DouksF7FYSM2jh0ici+QK3C7B1+JJdg8A0TfNShFB2/zN6y5QCaFhXfZOVKbVm1C9+a31UIbxMl
	19tJ1E5KvNbWLlalUvgfhvf8BDuxaiO0QiANwZMO+TnMNSMSp0JV0ZAvgyuu7dFIWbNrp5Vcuaa
	W94VaB4piLYtd0V15HQmCDhSGUA7MbCxZFrEyV9a8RLODmM5XjFJiIi+5lkjNGxC0jReOnLsTza
	rdLbibdgApXTdoVNH2LPtouPhzGdpCwCUFNxPssppeS+v7M/vN2Y3Cq1bJF5BuMxm+d/fCjiwh2
	c2C8fYS7XlGUFhgw/CjzE8mQGUIWvnYrPMc2rAWhzbII7ZoZ+IQlVLUI27Hfga7ktRjZj7n6zDs
	lJQm0dYp2MxC0MCj9/RpOorZbJvQffBJcitY2ffZ07x9EhtbLs5s/JUnCVBrPgO2OF5w81P+UDd
	NPwOUNwr/VoTgH+N7aC3BfHdPNSQZxTVl94DfJE
X-Received: by 2002:a17:90b:580e:b0:385:393e:7124 with SMTP id 98e67ed59e1d1-39b261cfd97mr2495511a91.14.1788474002847;
        Thu, 03 Sep 2026 15:20:02 -0700 (PDT)
Received: from aaron-desktop.ts-local.net (wsip-70-191-90-18.ph.ph.cox.net. [70.191.90.18])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-143240d86c3sm2040193c88.0.2026.09.03.15.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 15:20:02 -0700 (PDT)
From: Aaron Brice <aaron@embeddedts.com>
To: linux-bluetooth@vger.kernel.org
Cc: Aaron Brice <aaron@embeddedts.com>
Subject: [PATCH BlueZ v2] btattach: Update for glibc 2.42 compatibility
Date: Thu,  3 Sep 2026 15:20:05 -0700
Message-ID: <20260903222005.482058-1-aaron@embeddedts.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

btattach is not setting the baud rate correctly on systems with newer
glibc such as Ubuntu 26.04. In glibc 2.42 the baud rate termios.h
constants changed value, B115200 was 0x1002 which was the struct
termios c_cflag enum bits, but in 2.42 they changed cfsetspeed() to
accept arbitrary rates and not just the baud enum values, and B115200
was changed to the value 115200. This means you can no longer set the
speed with c_cflag |= B115200 and should use cfsetspeed() to be
compatible with both versions.
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

