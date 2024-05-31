Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9221C6BD
	for <linux-bluetooth@vger.kernel.org>; Fri, 31 May 2024 19:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717184229; cv=none; b=HdUz/JS/lJ+MiRCh4gKArsRs6VTJSg7FTvJihOahm0fKxBn6HlpNrvXel29Y6Qv5xp1XVJq2nv2wTGsPd6m+pUaG94ylVq571/Q+hnyRRALEGSXQuhPdFtXEGbvyzD6zUDk5+XCR174Znq1tTDn9/Q1WgvrJhUGKhX1yPVjLGV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717184229; c=relaxed/simple;
	bh=fM8DXtS0g3ad3SkWJ74fl9vbVdU9ZZhOPrhX+Q++VA0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D1q3rnJug3wG/50lO1mTI7w/g4q8RSnAeGwz/MeTp1iuOxSpkU0+YTibOjAtJpz/eKnq6TR06MElJE7aXeB3rPe4cUAPLRZQe7kG8GOE00es/PAH7nWpEfEdv5gEB513lGlzjqqIoLZj27CgAsYybYzR22kYzVFXqe6vs31OoHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=prestonhunt.com; spf=pass smtp.mailfrom=prestonhunt.com; dkim=pass (2048-bit key) header.d=prestonhunt-com.20230601.gappssmtp.com header.i=@prestonhunt-com.20230601.gappssmtp.com header.b=pLWVBsRH; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=prestonhunt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prestonhunt.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=prestonhunt-com.20230601.gappssmtp.com header.i=@prestonhunt-com.20230601.gappssmtp.com header.b="pLWVBsRH"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7023b6d810bso1517999b3a.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 31 May 2024 12:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=prestonhunt-com.20230601.gappssmtp.com; s=20230601; t=1717184227; x=1717789027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wEeGm70tcJLMIZtXwuy+rG4HE0SVtA85dqOwWXBg8qQ=;
        b=pLWVBsRHczO7hgU4cvPozlR+QgsfMZLvXNnAok/sInv5jk9CK2ycPzrPRACjNRG3pI
         0AZmRds++tkbos5ueEcUlQrX+GdmNPoboQ3HHe3J4kJYn2XUbpDat6i4Mxlf8ner2vZt
         0eAtzIk5Y1g79pF8HyimFyFIx81/HXaOacR2d0uOfTfLoZOJIGkZZ4QRkJO4k2dYVNmW
         wKwmflrLbR81wefaCPnpgTqtskbx57KdDdv4O8yqMQQ8uTpuyh5K+WVeSVB6zbTbPeb2
         wmsz1GszzzY9X9eYsMnkfCal8okkzSPVXfXuxonofzwJ6yacB5vfaR8Cti3yVNG6Udu1
         YrvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717184227; x=1717789027;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wEeGm70tcJLMIZtXwuy+rG4HE0SVtA85dqOwWXBg8qQ=;
        b=jCaw+xhP5j+T5okHJALBUB8uVTcD1dVNu5B+Pq7q3hzbAz93msSbHba2T43xMprPUZ
         3WNb0ZX3jiIT76h+8AR/FefX/KQyy92kbDRq3yL9o5n1gPadlsE+pBdnYX7p85uvURYX
         3f78SF/8nqFh8EOxGOj4Nv6K74J/xqpnxgc5IrO7tsWBh9JXI7jGjC9XvKPIVA2nB/7g
         WRn8AFgeyvRWwErac7SwcZSJPkA66FiGEDTo6YYslQghrPcAiLb1Tqa911GDN7jSkDxK
         YY30dV0kvCebR5ruradFm8xDuxf0/gRoGifJB6vMv6niXBrdD15katc6GHRUeMLnSgsa
         h2cw==
X-Gm-Message-State: AOJu0YxUz1DNUkjfMiueRCkKjupQ8QKfMXbt+IZalo6tyKznOUYLFd0G
	XF22TsM0xYu3ou54EG/ftwjO9P6mOO4ibfUMxkZnQ2IWwrtgbky471NV/MIQecY9SDlFJutoHe0
	G
X-Google-Smtp-Source: AGHT+IH3qt9nP7QwaWSKmhJn2rumZlC47+sSn1U2cr/nGOMRKpcx4pVn8GOptpY/fbVQ88uM7zl6QA==
X-Received: by 2002:a05:6a21:99a6:b0:1a9:c4ca:dc74 with SMTP id adf61e73a8af0-1b26f0e6242mr3779249637.5.1717184226215;
        Fri, 31 May 2024 12:37:06 -0700 (PDT)
Received: from localhost.localdomain ([97.115.143.6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70242b2c262sm1720956b3a.190.2024.05.31.12.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 12:37:05 -0700 (PDT)
From: Preston Hunt <me@prestonhunt.com>
To: linux-bluetooth@vger.kernel.org
Cc: Preston Hunt <me@prestonhunt.com>
Subject: [PATCH BlueZ 0/1] Fix GLib deprecation warning in example-gatt-client/server
Date: Fri, 31 May 2024 12:36:21 -0700
Message-ID: <20240531193622.1696328-1-me@prestonhunt.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Updates example-gatt-client and example-gatt-server sample applications
in test/ directory to fix deprecation warning:

    PyGIDeprecationWarning: GObject.MainLoop is deprecated; use
    GLib.MainLoop instead

Also, remove python2 import since the script is run with a python3
shebang.

Preston Hunt (1):
  test/example-gatt: fix deprecation warning

 test/example-gatt-client |  7 ++-----
 test/example-gatt-server | 11 ++++-------
 2 files changed, 6 insertions(+), 12 deletions(-)

-- 
2.42.0

