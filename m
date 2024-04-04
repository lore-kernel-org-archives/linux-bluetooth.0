Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDFB1CAB3
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Apr 2024 02:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712198747; cv=none; b=FX8Y4hY1tKq4luZxjy+oNCSZQCKYyzEY8smxCkPEW74hYsASasNo1ro4RRirX4A3kglw4kfWLWCH9RO+yPAatNnaod6A3fxNvDYwg6xc+rZIeUOfnAWr1Fj/K7ykkEkCo3SB4dUGP4/BkPvte76AtoosqhNEHdEenBubk8ZEH8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712198747; c=relaxed/simple;
	bh=iqy/ebasfT5qjlxKBbAkD5hBnSNu2TQwrUmfsRSSLgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NcYMtCZbqnJXFFLWNyx0SfvtYooyyWCqKkFsS4vae+kPBoyDwUY3WwKiUpBOa4iitcvzMlB8b59/rFK0yIBBswiVvgyTWtbjSLFgqWdh5hUsf7PpMtg0MBKYM2XBP7z8SqLbwqVaOhHeFHLZjs+wfTBj3MnpwZARI5Il5vi5laI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gmIwGZxW; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gmIwGZxW"
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-6ecee1f325bso114642b3a.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Apr 2024 19:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712198744; x=1712803544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yhVRyojFtHpDvl/I1GiGcFvBQtnda0HUQSY1ygHsDh8=;
        b=gmIwGZxWvRlOmqX5Rf2MEn3Z5VsWg2vRUSM88oadA5Qh1/pYHyeMM4/3BFcOX3e86D
         rEc8Q/2Ad+8f4a07hcsYe+Bg9HgIQnyqIQTRO2hXeoPSrM0QtnT/p1a/QZDqp9rTc199
         j2dqK/ZmN4YpDV5BEYICuMWGBUdOukjb+AgqrDh1hMmhUqVJPpi57b8x2uCo/W87Gihk
         btgFq9SX4E6WqV4DSQm2sKWgMZJoMQIqCuhQImyHJAi+DlMZsOL9YCVSjXlOpGGWYIIq
         4wXb0N7vd6/f7Tx0qEyionuP5PMQhwagUJ/D+LO7JH+knJOEF61PETncW5pdGa8ZWyob
         Cumw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712198744; x=1712803544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yhVRyojFtHpDvl/I1GiGcFvBQtnda0HUQSY1ygHsDh8=;
        b=uLh9/Jn26zduETavW50O2zYHnrO6V3/KiGxOQuJJKwB2kP/UF6ivzng0HOUgFJh6QV
         yTcvE9mRHxwLiUYK3+68wwrv1hXy3ZcxWmW+YzFm12JbJgPjNY4JwYMkGRM6+bnxNVhn
         wnb7r81ZdB8F+3YJVcVhTlboaqaGubXWMzFIvHo2YRHUXBSOhMXL7Xpp+MJKfWYh/AJD
         l9YTyqwDSef3QFxzKtwS+oNEMtJ0C0j8uqjzAAh5+e9DYwlkwc+jXf/Z2AcGCqiXvcKA
         kgyW5pI3CZyPbrHQ62bAfLBimId0b7LWP2NpKp5iPEvZyMXl9GF+ao4hN5vseoi9ikWH
         IKiA==
X-Gm-Message-State: AOJu0YxtI5nLP2wAmTPdaFb54y3uMKBpQssRQrCjP/jpJ44tNJKz9B4e
	PzEvj7WMgL3OLeKf/q6tP9N37jEEb9gaIocrvPb5yCNouleIwlFd8DHRhbEaX0SwvFFe
X-Google-Smtp-Source: AGHT+IHe6sjPmYi3bmyijynWKKs2rj5KMyjTi169yW7ODQ+lLAAsbygWRviXKRkRwUN3BizG3sOLFQ==
X-Received: by 2002:a05:6a00:885:b0:6ea:f05d:d2e4 with SMTP id q5-20020a056a00088500b006eaf05dd2e4mr1853591pfj.15.1712198744266;
        Wed, 03 Apr 2024 19:45:44 -0700 (PDT)
Received: from angua.lan ([2600:3c0a:e002:7f00::1001])
        by smtp.gmail.com with ESMTPSA id g8-20020aa79dc8000000b006e56da42e24sm12512869pfq.158.2024.04.03.19.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 19:45:43 -0700 (PDT)
From: Dimitris <dimitris.on.linux@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dimitris <dimitris.on.linux@gmail.com>
Subject: [PATCH BlueZ 0/1] V2: Fix busy loop when disabling BT
Date: Wed,  3 Apr 2024 19:45:20 -0700
Message-ID: <20240404024521.120349-1-dimitris.on.linux@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240403205252.71978-1-dimitris.on.linux@gmail.com>
References: <20240403205252.71978-1-dimitris.on.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Second attempt with a more narrow change footprint.

Dimitris (1):
  Refactor btd_device_is_connected

 src/adapter.c | 2 +-
 src/device.c  | 7 ++++++-
 src/device.h  | 1 +
 3 files changed, 8 insertions(+), 2 deletions(-)

-- 
2.44.0

