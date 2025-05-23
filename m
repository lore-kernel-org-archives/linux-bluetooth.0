Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF612957B2
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 May 2025 14:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748010327; cv=none; b=H3BIXe9wiRisrWpfZ2rhveW7DBbWBEGyQypj8ckPx8PIK1s4zRoKJ73U8iYYYWfYKlgc+H5n+fiwzQ6F2TZZJYKCILGwoiOWZ3noZyy6kZf8xhNxj4L2EvzX9eTm5bYvYG10oxznWf46RpWlxbqBLfxALDx2azOwHzZpbEC2Izs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748010327; c=relaxed/simple;
	bh=V9moyCEvcreBrmKtmYS+DmumWNR2WbQ6dAJHdwX3Rp4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FscljD94tCvMW5BlYTVyGVM86tz8mk2JvYMRmujG/bx97SgQdGBM2xtxMIhm0ZoD+CWxyqD3dphlL8+JKJhcZrkMfoDIVJyhZwtrk3LWSZqe4RXQqqcaf+8aFFSKjVAS8acYqxGI22xCQagpwfkhJyzyuglRmJ1xwQh5HxJMI30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BTzBV8nI; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BTzBV8nI"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-72c14235af3so5938972a34.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 May 2025 07:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748010324; x=1748615124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9m4+0OIIskS7vHvSoBI6wzMv5zKIWeD/uVc6SDRQhLc=;
        b=BTzBV8nILmxNXIVzRKnxtJc+vSW4quD4cNHaI3Iq6Xx7bS7OBJKMBJ/KGLa9GNlHLP
         NEkYWw/L5w2s4e689GW2Js6C7vGSaQyFmtuyqUMWp4YmP/CGpO49iAHexe5le48TFJUI
         OV1xPx3NZ/pMBDtO0HTma1bTTH4aX0n38GPEon5yMiqKgSHADpb6UtV7pCN02ggeYulR
         QnLpkQw7t5Sw+xZ4cyFPkWMFmWfk6mHOlec5vTbupItmgfagQDITHKzudd31wdR8Q2vk
         rqUr9DchRdWRi/XorHn/Rot/5XO2hWoBe8lMGCrnh8iykuR+adFuaxGb/yglXHeMkcQl
         pQLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748010324; x=1748615124;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9m4+0OIIskS7vHvSoBI6wzMv5zKIWeD/uVc6SDRQhLc=;
        b=HGGfKXv1ejYnYJk1u+62VWVi3pxfDTH+wdlWYy4ZAdrH5Dt6/qAvwSTNgwYc5VRppE
         C9/ZUuOLoNbTpJnViwH61itH28zlE7aQIVE0baNZ+17sivfyXAVJHxtD7Eo3ALrg8Mgh
         qC7cLYm45+R+tC64yh5VDLlxkdGDfja9vHuQWcfwNyQ+N0mQtS6oWAt5hXlsLyWdI9/0
         U1ow9qGOFfJdRobvh27RrfFuoxN397uJRK4gKPDqegGXWiy6/zAuBOi1VmhuBX6SBdWv
         T/sb9Sb97RqZemlh5n7P6SR1fFlqzfIxbWBHfOacByWdfgz1HKU/NmnWCT5oHCGY/19U
         143w==
X-Gm-Message-State: AOJu0YwH1kds0qupShsa9ZsEjO8rM1rfMNWfKVOFJoR9MQob3OMxYXK5
	nAq+TLJL2gfSCQXbqMSZtLC/upvTghnv4/i4ZgT9Z1/1ZBI2YmfF0DWl5TBX22rT
X-Gm-Gg: ASbGnctGQiGxBtlBgqEkKh3u0ZFqt78tlTIT3E1YJVNIY8Ox+hW7BMLX01eEeK+gtQd
	xSDqJTYdzPNJls71i5RdZal7TpXGXYYXB6woEWXBxNNivr5R7FZWkZKkG9gq0QAwv2itWh1xctV
	UuAgysCBwe+6QuSI94BzeAepUF7dL7dO6qdb63phUe2PMhjLJQgddIO9BUFj5xV3SyQARA0G42F
	qQ+en4EjCIzDDIpiCSpaJvAcZluf+iDjYm7TEUKrwlHgU332i9N9XrN4yu8hCLa2m//l2/B8774
	dfFNeq2Jy7ivvzrYnNwiXlEfJOpPl7uFvm/6e5b3Unj9f+7FY+0Pt+Gz2eaWx5aR5PnApjyec5m
	pYqGbw0AJfoKR+QVS0TeTkbLycULrzYw=
X-Google-Smtp-Source: AGHT+IEfFjjD0RGWur3/pvu2hmT/75fPRSIHZaTpngMEaLX25qcMh/1neRyDpMzLZbQ1pei8gyU0Fw==
X-Received: by 2002:a05:620a:bd6:b0:7c9:269f:b654 with SMTP id af79cd13be357-7cd47f5a35bmr4317772685a.27.1748010312707;
        Fri, 23 May 2025 07:25:12 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-87bec027524sm12246308241.0.2025.05.23.07.25.11
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 07:25:11 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 4/4] bluetoothctl-scan: Add documentation for auto-connect command
Date: Fri, 23 May 2025 10:25:05 -0400
Message-ID: <20250523142505.3476436-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250523142505.3476436-1-luiz.dentz@gmail.com>
References: <20250523142505.3476436-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds documentation for auto-connect command.
---
 client/bluetoothctl-scan.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/client/bluetoothctl-scan.rst b/client/bluetoothctl-scan.rst
index b4b8315926a2..cee255131622 100644
--- a/client/bluetoothctl-scan.rst
+++ b/client/bluetoothctl-scan.rst
@@ -122,6 +122,16 @@ When set, it disregards device discoverable flags.
 :Usage: **> pattern [value]**
 
 
+auto-connect
+------------
+
+Set/Get auto-connect filter.
+
+Connect to discovered devices automatically if pattern filter has been set and
+it matches the device address or name and the device is connectable.
+
+:Usage: **> auto-connect [on/off]**
+
 clear
 -----
 
-- 
2.49.0

