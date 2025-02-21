Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D73F17CA17;
	Fri, 21 Feb 2025 21:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740174538; cv=none; b=ay5mleVdnVavgr+1ajilE+7MXdYnOcUT+7HRmBGw/QhhmJr3ivWQ7xrSUvvqBVnXYdmI4AtBYOdtNs0Z59dpf65fbd//yOHDqIcYjC7+rYIGsIYBrrt9zejmD0b7h9aCe7BV+Is1wyQyCWNnEy2zRe9FGqYjqncP/+aUhrZUD2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740174538; c=relaxed/simple;
	bh=gPyFzIP24Lc4ZAQes/Bw3FIR5J4Tu1cY7Qe5OFglfYQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ku7279CEzdsp1Vz+KwWe5KNv54E6vetHVMnKqK7HlCMh1qRH5qdrPO/Ik2LTjog3+Smv4xIkNQbm7BYLLqPtvPaWfjrrLUkLELCAsysSYpNRNb44iIWSyz55jEoLzybD1CHxO9+bxVrpDRkg0Dahwy3IAS/KBJFFRsvLooqEQAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lV2uaRVO; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lV2uaRVO"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5ded1395213so4391905a12.2;
        Fri, 21 Feb 2025 13:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740174535; x=1740779335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a9pTIn8QHxz7zjuURjxwEBW82WNxe/Jc1n8xte3Y49I=;
        b=lV2uaRVOBqW5Daj74v0NEGNczsVV3WyEWbSCyHnjg1+QKiSQuuJm/l5QNSiwHLByjW
         6aLfmSbwwyHEcDVJWTb8+fhF/zqc8i/VHg1WNImwaSiVx69tw24rWqB19QlpS94msArk
         EOIkCRWlqR/AQYf8vVa5QKGyhiQYrBuPgOxamJqUXsCazDd13/P6V7uIYuyyTB0074hx
         DwDAvra3G8pW9o6FNGW8/I9JtqLc6rXSjA81owq4rF+b5OvpG/5TkrIb0i/gaIBjaY6F
         2EDNNKUQT1e7Dn754tKFjmqOKK18BXGGkfKsadqRVOeCJAFBt+y+vhn4Jq16A3Ih5S8V
         W53g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740174535; x=1740779335;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a9pTIn8QHxz7zjuURjxwEBW82WNxe/Jc1n8xte3Y49I=;
        b=lrwvuhAvmi1+G73oxvp4DlXqnv4I83/yDrG4S/vTMcewFnzIPG+IWKQ7IvdRQq2XEw
         7rji695UptHIopzjYT62vwyFbOEv+UdCDG9D23o4KvuTtvYEcZvumz6wri/fpobNL62Y
         cP90bLJc7Qz1szM1eZdoQX+/8sZlT5KoZSsvBbBblI+b42h+oKNhGQq9v6FkI71y8J8u
         Eo+EulXmvyMVe08ajfTBVfBLKKJweSCntT6A9iDv6jeD8FaowAv2sTF9r7gZ7VCm4lKQ
         i1BYyoWHJFHK1LhRDJiKluCd873X9d14UhlYUn4tUqN5N1TJYQx8Ze1vy/PPeumKCDeB
         2KVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmllxdIy3yM/g3HBwPVEd9/zG8TiMtU0/7DxjIM4JO61PxR5LQfplQ1HJxyxDtKldzYCFViEUOlhMrV8V3@vger.kernel.org, AJvYcCXCr7Ro8/WrmxDZDS/9+hqQu58nk3ngEPc3nLRc44xZW9Z+fx4ZllBZhU8WwJJpQooibRRgnrTtn5+Gl07RBqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPa5F4KTEsMaqIMZuCZGQ3kw1+Wiq4ciJ28PWYu0X4C//GtiPw
	518YowWsS/ScbuFCKfbUf+UysOjYCk1W3ekxkNYHld+uf25KWScF
X-Gm-Gg: ASbGncv/LvxfxYEoQIxRXJYiaTGmqfJC+cDpE9f/GcAQOjZX+AERXu0+szo9vOgkaeq
	pT1ryCuKunEQdH0CvoVnXkzp6Q6kwg5mRG3hZ1HE4jEA9OpV2GgFNuXIhHtNNPE48vqs0TyDyqn
	qlI6G51PGyy8kFxf8uWHsSxIxLmmmWK0ZoJoD+iegSE3m3lyvhg+zczl6WC6UFsQ8dFYqxQS/FO
	ZY9UQ4aGGmjXIIHaTPNDe+ngW21W2gAhtyf/Zii8u2dzo+TyrIyyhIqhTxRhFFabM9VUXfRC5fx
	+K1jRQGsZvb0LRodh3/vOWSF9pkUk0u7/HdB/dEyx0Q=
X-Google-Smtp-Source: AGHT+IHgjsel/2ffzhG3H5/MfbiB4SAy1GJZeV3sYofZe0e1mMUm9l0y3bfHwh1UadRhS/V6bvw8EQ==
X-Received: by 2002:a17:907:94cf:b0:aa6:a87e:f2e1 with SMTP id a640c23a62f3a-abc09e2f100mr549352466b.56.1740174534537;
        Fri, 21 Feb 2025 13:48:54 -0800 (PST)
Received: from localhost.localdomain ([196.235.227.170])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb5781da94sm1374547966b.85.2025.02.21.13.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 13:48:53 -0800 (PST)
From: Salah Triki <salah.triki@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Salah Triki <salah.triki@gmail.com>
Subject: [PATCH] bluetooth: btusb: Initialize .owner field of force_poll_sync_fops
Date: Fri, 21 Feb 2025 22:32:59 +0100
Message-Id: <20250221213259.180833-1-salah.triki@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Initialize .owner field of force_poll_sync_fops to THIS_MODULE in order to
prevent btusb from being unloaded while its operations are in use.

Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
 drivers/bluetooth/btusb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 90966dfbd278..6cd9428419cb 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3642,6 +3642,7 @@ static ssize_t force_poll_sync_write(struct file *file,
 }
 
 static const struct file_operations force_poll_sync_fops = {
+	.owner		= THIS_MODULE,
 	.open		= simple_open,
 	.read		= force_poll_sync_read,
 	.write		= force_poll_sync_write,
-- 
2.34.1

