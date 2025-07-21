Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDCF239561
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Jul 2025 20:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753128586; cv=none; b=dJXFoh99oAKlzv0WOam/meOiJT5uTS1De/9slm9MLOXJFjjFxfUsxGeTn2g8nNKoXnQbkWCjUAUitdU/AkM9DnVrqAEIPAIk6jcULAHyawQsSCeLtWbtTxyY9pbXZk8FDy3QrcylaLfpj7w9rze9bBjEDaSjjAiAR1MnSyPcRkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753128586; c=relaxed/simple;
	bh=Pf0AxCikzvGENO3CvnO4TrQHzMLj/N8cvYBOoM7VZyM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=NWGMPuChRA3RNTyWhFxC8kLJM+SF1nhNb/4kxEu2l/GFi9nm9soBYDHMFPfcW3YdRq3Vlzf6ag6oftsbFNYZO2xk+7oN8fhWUpfE+s51jjwHm15SFjhBHDFE6zgn7TP8tpDiRkbgcd4p6RTTHGNc5J4Ljk5fALSC7y2vVaZ6BKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q3/ph6m9; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q3/ph6m9"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-87ec5e1cd4aso2972494241.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Jul 2025 13:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753128583; x=1753733383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=sj3zgAg0IEGcCyr+ZsP49KPKLG5eexgP2db9Ko/T+5s=;
        b=Q3/ph6m9Dy1+qsBJViLVhxkcHmITAi43sosTHvx1mgVvjoDUp73Vje2fjkDwpKGFYM
         1Lt3kbp6oQMqCQ+zt25SMnnkEpIIBxfZmTS4nrmb2Dqlf7dUg8BACif1i6qm10hDIgPm
         DZxxhi0AjkC7nrQ/vyfxcEL3UK0ZzbYeHkUSVOP6HRXRbpuZB3slfttiDwWuzYq1PPke
         AWsTPjfhbUIwRIP+ky4dqdNuSKMqm7SwrXdQGQAqAldGaxB7udN17awSxSjRd8SzGARY
         U4tE8aDwaAX3ptahqD42g238BCtsFYbaXfib4k7V+bKmclyg8/GCGld9s4bI9eQk0imL
         1Ucw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753128583; x=1753733383;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sj3zgAg0IEGcCyr+ZsP49KPKLG5eexgP2db9Ko/T+5s=;
        b=IOUsLdxcRBpZElmc7SViTIQnL8LnGPtcuxKBhokhJgbuPxBimf2JBzESX3RA9WjM1W
         nAVpC+zvI7Y7yhwac6CLzXXNWmYDVoZBEISUqWLhWpZJjS25G0fOzgw0P04b/u40iy+9
         uH/ZK0vOjOxuFgEjwfk7KjJolwLooscX/gv+KzQpiuqZry27T7TKb8SBo7MPMn8Zcyhp
         LGHgdt0gkmbAiUp6biGSvUzU43yLJMLCrT4xCjFy6l+cy8TvM2VJhTHl9WezKtg3cTiJ
         1yaHBZBDuY6/SgkfPktZuNmVYXc8xU5lhOKNyf7ULsNlbmOt+WgBYoCKgXwZ9WfzSXHx
         ComA==
X-Gm-Message-State: AOJu0YwRQXCFTmxYeBtktO2peGRnjiiUY9LNIY9NMBJMMXS8YGMKOTTJ
	hYDP+7AEmGPs3zuaBEzvpEd7qqJrSWTjWKAZHLf7w+32kkeXP3+tCjg0YsEu2wSv
X-Gm-Gg: ASbGnctN6DUCzHE1d4eM15hXg9O5UnNGIRnpuLyhCb+mqDtxsnhCratKNOtwZLKLFrO
	DfP/sVEy6XmXwGOfNE0agBkt81mHNMCmsuOcNlV8bkMd1zNLqJ9mMMy9wPrXrroCl+yU6Vl4KFx
	0u9kkjc9+cfsyC2mtH7GQVyBikcHlMKK4iKdDd32Jwdt7ZCrWAldQMqtSlN13N2ivtrrvqGIeUm
	JZAbP45APQny61G0Li/41UChn+M91JCY0uKifpvHBmzHI2k0F8Wn92mGUjJqV/KY/iBYjufYpc7
	9DRqjtsPdHyzjLph6Ge063Rw6ZifhJMbBpZzksPQh9t8V0GOE4Dj971iSy2EpR41JB0eRqYynPb
	fdxBszh2w6tZe1RKEa8/fythyt0jkeFPPv23c8gA6wPzPlLWnFsAFjhCObamFY0BH
X-Google-Smtp-Source: AGHT+IGAwli8DxqjDQQeiVE49Q9v+tTUzEQ00iI40f+2msgr0gNXYuQ8thcPpohxcP7J0C/t9wPvbg==
X-Received: by 2002:a05:6102:6c6:b0:4e5:ac99:e466 with SMTP id ada2fe7eead31-4f95f40d1f7mr9655414137.18.1753128583049;
        Mon, 21 Jul 2025 13:09:43 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4f9ad095066sm2284088137.15.2025.07.21.13.09.41
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 13:09:42 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] client: Fix gatt.{read, write} not working on scripts
Date: Mon, 21 Jul 2025 16:09:33 -0400
Message-ID: <20250721200933.1102559-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If gatt.{read, write} are called within a script they don't indicate
completion so they block commands to be run after them.
---
 client/gatt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/client/gatt.c b/client/gatt.c
index b18186518953..6dc80e2a31cd 100644
--- a/client/gatt.c
+++ b/client/gatt.c
@@ -696,6 +696,8 @@ void gatt_read_local_attribute(char *data, int argc, char *argv[])
 		bt_shell_hexdump(&d->value[offset], d->value_len - offset);
 		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 	}
+
+	return bt_shell_noninteractive_quit(EXIT_FAILURE);
 }
 
 static uint8_t *str2bytearray(char *arg, size_t *val_len)
@@ -809,6 +811,8 @@ void gatt_write_local_attribute(char *data, int argc, char *argv[])
 	}
 
 	free(value);
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
 static char *attribute_generator(const char *text, int state, GList *source)
-- 
2.50.1

