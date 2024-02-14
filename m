Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA0213A862
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Feb 2024 18:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707937048; cv=none; b=M17QO2Xrtdzg6oS+PRInD8ccpaw3SmUw2RB+py65SFKT3Q4HzSYZa7pteSQqCTC1TtjiofK3f9W3dDZ89z16ES2/BQe1lkQKH5bana5UrHZal56LWytvLRKRfmCiZGtI+HD0AonKG0jUVEcOxg3ShT/gQnufi+uVy/mtwjLtg7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707937048; c=relaxed/simple;
	bh=r/Gn9VbMpL6x26byGJzklBtxknH+tR8PM7yN/yyGzK8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cCMZ1oBmhgExpfjwKUMFtQlHe1X0/WZnu1fgWezeJgv/J8RM+KrbGKZeMiFSHDztpsHTu21q9y5mc4dc1wvxywCzInqcplkMRv3iTlHdF3IuGA/Mgb/4zaSXCUnBFzdbpfgO4x1mnO1xtdoSnQ3C+vty+0cKQFRqH9CCDty88aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VO0A4oLx; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VO0A4oLx"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-4c02779e68cso16247e0c.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Feb 2024 10:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707937044; x=1708541844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KjNeV6w5HrSFdRZEhg9X/6qYQX2xBJuhTWIha7DaqKk=;
        b=VO0A4oLxVZ3tJh0v4NpZs0gVajNCH0foIMFAp3ZM1gi4QFDExSS+sxsZsqNvRvfbxI
         d62EQXIQ4CMMdoAK2blM3f5YywLrs6pAzaFFQzVUmE+2MfOn0aShzN0xWi5R4ZYaplFq
         n0EBFU2f5WkmSZb6CwcYdbubPLPj0R0ZpCCnM1+p7ksdW9UEhgwcyD4DY1eAS1AxRTgb
         H+1O5a2kWAE1KnEtWV5cQUoCFHV2i5CvD5L8ec3sACg4NMXWhkK0rI/4x0x9bcZ8tbEL
         R14lGOU6/H85lZaADapemRn/tm4gpaijjIqJhPxisqlwPvBDXUEgCsLxKMQhI55iIIoI
         6WNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707937044; x=1708541844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KjNeV6w5HrSFdRZEhg9X/6qYQX2xBJuhTWIha7DaqKk=;
        b=RfcACepB41ro+zEOlGgL+eQQxSDmMWdLpGnwAnPFwPD5QR96Yef2wyitlMlo/zFYY/
         SPcH+itTZwt1HW5TZ617XgUKDw6fNRPTg4Dwfd+DOHklkIDqSomF0wyk+eavxBo1D5kW
         rdLrK/+OBcWNlQ0GOpKzJwN4ORkXT4y2N5DkVTj2W3Gky9e/SN+xWF4xgOFKg2GkjKb1
         1cF/Odazp315wqx0AxBLua844JJ5Sf/O9NOd6xUS/Nzco9qxnYYYJaVVwjbfhn4BEksn
         dosbnmT0lozcH0wumyjaRKOcW7oCK6vKaov0zJCNff7aeU2EWC64JsVTNfj3fmjVO4SO
         KfaQ==
X-Gm-Message-State: AOJu0YyWPJejflXLeaAkXgGjwKE4FJBLNu/DkCOHMN3y18QYqquCEYxX
	itq5XljHwbJCxE3xe40ZW1jeqGChwtyS4otu2aaheL+HUQjAzcgSvN1wqgoF
X-Google-Smtp-Source: AGHT+IHBh8XvuI+bD/7A50TbQSr0khRajFaMqgdsI7WEjMq4mbnxDxPT0bgeVAWV+Yzq39+TCL24Mw==
X-Received: by 2002:a1f:4943:0:b0:4c0:23bd:1f0d with SMTP id w64-20020a1f4943000000b004c023bd1f0dmr3434913vka.15.1707937044291;
        Wed, 14 Feb 2024 10:57:24 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id l5-20020ac5cda5000000b004b72c016c0bsm1309545vka.5.2024.02.14.10.57.21
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 10:57:21 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v5 3/3] input/device: Don't destroy UHID device on disconnect
Date: Wed, 14 Feb 2024 13:57:18 -0500
Message-ID: <20240214185718.536748-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240214185718.536748-1-luiz.dentz@gmail.com>
References: <20240214185718.536748-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes classic HID behave like HoG which keeps the UHID device
around while disconnected so it doesn't have to be recreated on every
reconnection.
---
 profiles/input/device.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index ff7e3482d0eb..0d32b705bd00 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -985,6 +985,10 @@ static int uhid_disconnect(struct input_device *idev)
 	if (!idev->uhid_created)
 		return 0;
 
+	/* Only destroy the node if virtual cable unplug flag has been set */
+	if (!idev->virtual_cable_unplug)
+		return 0;
+
 	bt_uhid_unregister_all(idev->uhid);
 
 	memset(&ev, 0, sizeof(ev));
-- 
2.43.0

