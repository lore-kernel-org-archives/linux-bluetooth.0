Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299A51CAA1
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jul 2024 08:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721811285; cv=none; b=SAaW77PXg+ENZ/OIb+YP+fb6lIPuE67US76YI7LRbIOWs9amAetXYzce/mkFQaUUYGieoh5e3hKLkDuC3+nMftwrqaKdMN1KcRCWRaJWxBEiytBtO6kf+WUCsiPKAzcixobMOUKUyNqmVQpsiqY3CalotYdjj1MXyy8kLQM20jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721811285; c=relaxed/simple;
	bh=e8r8BZNevObab/ahvsMNHkiF1G73wORNsUxTZ7pK31I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oY0pysfhNwL0bgEVEi6Yq2dVic8SZbE5RaT8wDecRefKxkk4T+6iNI9MWE3fz64NGEOJ+5CNUkdt5wDlkEsOUmfQvYflF9s9x4BSTbprkK5oY8vyWLmJnIJTNRmPWMQLokddqC3s73Cpr6T2ETZ8BrmKErKvLBVUEKkWFzb3i6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a5P1X9RK; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a5P1X9RK"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3d9e13ef9aaso3968088b6e.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jul 2024 01:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721811283; x=1722416083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qnx/tcYEGQ6KZ8xJb0smztN8Z/M3Le3t6TI8oU2w0jg=;
        b=a5P1X9RKYbffcSHitDMU+NvH8dl7FgTQXBbl9g+9mVNM3NnCAAUhFHYAuq9RpQ1Suw
         7ogS6Gy1Tf9QJ/gbymq8i7W6cgM7GrGPAIIEssB3mHhfGBL6SZrpNmwlH7Z8H27D7ePg
         gZLJcTFpaioI7p77MBoUOBhsXpqb+0tyWf2NnFvzitvHgkbELKJjy8WBNLUu+3y3ajxQ
         dTmRfJDn3Kfhy+xpVap/UloRxHP2PPY0OWr2tWNMNrAeZmHFagevS13hT8EnScE5baC+
         sHdwkXrf2zVrfsZmoTtxJY5DcB8vu63YErPyz0p5WNzGWyLkwOGFo4knETNyuhk5YtSS
         wjHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721811283; x=1722416083;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qnx/tcYEGQ6KZ8xJb0smztN8Z/M3Le3t6TI8oU2w0jg=;
        b=fzEpriqUUCnuqXHkE4rXzTchXM9wu2ETJrfI35sNvNQ/3hCStiP1U2hMp3i5QJ6LVi
         xo6qwe7SymO3uPe1T4P0sZBMdlzhvSRWttZSQX4XKbG4gv7AC7XYw/qMFu4BYWlNVtjx
         VTDAwCZvcotjFHeDik+XOwjqZ8l1Zo74d5us5fQRqiLz7P2kKSLx71WQb3I52jjtosHU
         eBnVH0imTD3R6mp7sQxViot2gRWT/BgJ90V/V8XuE1k6j7CB/IlQ4rWlbfcN/rDwHRWO
         GQXJWmGkFFrsVlW4gf8tqnyg/eorKTyHxxrLuaYeNIGGcPMjhG9OS1QJU56t2WxW9crJ
         MRtw==
X-Gm-Message-State: AOJu0Yy+SC9ufXkkWUPJtH3mZ0BRT/Pwd4mAHyIU1IOkn3FM0YXUlOpw
	xVdnRL7lhTJoSsbYesBXEBMQBW9Ic4Gj+pRDXLojM3zlVTJGwaC9I5uquPcE
X-Google-Smtp-Source: AGHT+IEMBdvl/S2KuyPskwywKf36/lL8xoxJ9veuiQMe9KVvyc6VBJb2ch0aeesWT7l4WpC98ycg1g==
X-Received: by 2002:a05:6808:1b06:b0:3d9:197e:696e with SMTP id 5614622812f47-3dae9858f0emr11836655b6e.50.1721811281424;
        Wed, 24 Jul 2024 01:54:41 -0700 (PDT)
Received: from localhost.localdomain ([192.227.249.122])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3daf59bdb7dsm1248914b6e.50.2024.07.24.01.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 01:54:41 -0700 (PDT)
From: Yancey Chiew <yanceychiew@gmail.com>
X-Google-Original-From: Yancey Chiew <YanceyChiew@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Yancey Chiew <YanceyChiew@gmail.com>
Subject: [PATCH BlueZ 0/1] Fix com.bluez.battery1 randomly missing percentage
Date: Wed, 24 Jul 2024 16:53:17 +0800
Message-ID: <20240724085318.209318-1-YanceyChiew@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For more than a year, I often found that the
org.bluez.Battery1 dbus interface randomly failed to
obtain the battery level of some devices.

When this happens, it is always accompanied by a
"Trying to update an unregistered battery" log.

Finally, I found a bug in battery.c:parse_battery_level().
Except when called for the first time, it will wait
until the battery percentage changes before updating
the value in the dbus interface.

For BLE devices, changes in battery percentage will
take a long time, which is enough for the device
to disconnect/reconnect multiple times due to
sleep/wake-up. And every reconnection has a chance to
cause "Trying to update an unregistered battery".

This is a new version of the previous patch, fixes
the style problem.
> id: 20240723082843.184915-1-YanceyChiew () gmail ! com

Yancey Chiew (1):
  profiles/battery: Fix batt random lose percentage

 profiles/battery/battery.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

-- 
2.45.2

