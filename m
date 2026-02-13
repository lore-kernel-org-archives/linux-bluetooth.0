Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CD2208D0
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Feb 2026 05:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770959777; cv=none; b=KdWPPOFQULCIqu4K3xBbENCOGQXhClMyP3SX9M+1mdYz1tPzmYWkGIsweSQDJlYVtqzKhGgaY7K0HJcxJLKf/O7NXngqvSinRKLh7ZtwIlnn3RP6xb3rP9AE6us714qc653+sN3zq9PIp2nuKkN3tp94J5xbVqp9prkbZq+U6/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770959777; c=relaxed/simple;
	bh=u99lO8kJ2bmNswoL8KWRcKDDnHMAzE0Z2GISIom0mS8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BUTuzY3rEgNX8dN5BUA8tP0JackTwWefxFnWU6M7sOK4GvLQPOWRpSLWZbqy3PnPdewZinjMEWyngD60obozl+m0xAjWKnmfItBdRoVyklyMhi7RVYWjIxDk0roynq5wlmipamm3Uthpn7c9KJcBT0N5ibbbtvQeq2V2AfDL2O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XlTdC+sX; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XlTdC+sX"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2ba9d13f10eso1007811eec.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Feb 2026 21:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770959775; x=1771564575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hGNlPsP06TyMgHuOdGw4OVgL4em53RNDBz4eIL1iyy8=;
        b=XlTdC+sXdOUK0arm4Byr/LZUQkcfrjNtz9o6GST3GKPM4etzdqwnPnj/vLCcypV89I
         D17gvNpmnENczPkH1jDYak4LPPVk9vuDEJh9sa8y8Zyoaw+ZIUJ7jLVG5vyfIBD24cCI
         rwHMl0PekCTtsFeQfoRfEmtbqzdjvMxs1B63KE2rItn+ZKKtvY80q8zOYq0vk/3c4/NE
         8+tv2jnL1mAGPU+lNU1BH0JF7lkGnAeggh8acSmd9ndRY/gTHNcNcMqp+C3YL6XtEneb
         BVEgKVP78R8Tg4w/wcGulY0XIBlkWezvab0F/m03L2UoGfpM33oPqR09fG5QWldql+tO
         JZTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770959775; x=1771564575;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hGNlPsP06TyMgHuOdGw4OVgL4em53RNDBz4eIL1iyy8=;
        b=PgtVDJgWAx+nv4Q3e8hvOGvvvwIWxq/FJ3VEzcoQF48ZkqHPDjcRfxV1GpNw/yMUKM
         8HxJhhg74PEGcGoURQixQKb+l9K5VbGbUQAbkrLYFbBhYnavCgalxD5n6qrMDsWij/oq
         N9hRkWnJT/W5jv+dgcHw0YRrffnjKFWyhnCRJqOEs9SoTqS2LNxQm5Zk8QFQxbsGMdij
         Um3CxEjcdJsOJrQN2XO3Bfudj8LsA2utsMfJEXCka6BmUhCFXR4rohp5aj9EBDWBFHD1
         +h95Y5TQEnvdEzF+PLNA0lN0sGDxdpque3fdJ9Evv+emyeaddtafuF6mfjacTFTNPL7i
         fycQ==
X-Gm-Message-State: AOJu0YxKho3nb0eDdTyp0xnGjEX4STkL4x2hC80b2mHahTl8JvfWZxIf
	nx3X5Tw2H2CNTrfIYOIHQIbvT5UmADpSBVf9B3bLEERyRouT+gQ60MumuD9A5A==
X-Gm-Gg: AZuq6aK4J4SCU+cPAKkp4hZoRE5rxUc0kTi85Z8KBK9KENtP59A5LDF6BoNvfQBqbEU
	XyxbeVggglueAMYdjFP4oUyxDl7/rfuQXgsbY+gPKJ4CH4yN3gAyHV3Bkrtsub0PzFAeTSOW5gm
	dy9v/GzDctyQZ/0OVdxgET9GXut8VXA6UmPjf65ylLelc5dDLeduk3XIdrVNTPqZCZWyHY1cjyD
	7f6eTqmYuWMZA++RM9bwrfOr/yywKzqUuErDqxamCdGrSuvpxm8PhVZZ2mJZDMrTEd9whhMG2mB
	ozWDsys9veU0vwQuz8+wTSTEOJxnnr8aeO1kWXe0iqisZI4L6JoSxpfNO/5RCJuXP7SzuziseHh
	sGuWY+5GVBwW5rh1l68TT/tV1ar6GIucJ59Oeoay/+OK/J6JM0+OhyNqi7AyVm25w1mMjbE0luR
	WkumyqB4enY5jcfjtabiYYs6qmXPL88o8/ote8ubRN4Y/ZMsUwvc7b0sNqSCgfU+I+RmScxfYX+
	oVkcJI78PyjVzSiKBSsDuUyzg==
X-Received: by 2002:a05:7300:e828:b0:2b0:5c2f:6bf8 with SMTP id 5a478bee46e88-2babc535bb9mr208332eec.23.1770959775045;
        Thu, 12 Feb 2026 21:16:15 -0800 (PST)
Received: from kernel.. ([45.232.185.208])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ba9dba2ef2sm4958483eec.3.2026.02.12.21.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 21:16:14 -0800 (PST)
From: Maiquel Paiva <maiquelpaiva@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	gregkh@linuxfoundation.org,
	marcel@holtmann.org,
	Maiquel Paiva <maiquelpaiva@gmail.com>
Subject: [PATCH v6 0/1] mgmt: Fix heap overflow and race condition
Date: Fri, 13 Feb 2026 05:15:24 +0000
Message-ID: <20260213051525.10945-1-maiquelpaiva@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch resolves two vulnerabilities in mgmt_util.c:
1. A heap buffer overflow due to missing length validation.
2. Race conditions in list handling, fixed using the existing mutex.

Changes in v6:
- Rebased patch onto the latest bluetooth-next tree to 
  resolve CI bot apply errors.
- No logical changes from v5.

Changes in v5:
- Combined both fixes into a single patch for atomic application.
- Switched to using 'mgmt_pending_lock' (mutex).

Maiquel Paiva (1):
  Bluetooth: mgmt: Fix heap overflow and race condition in mesh handling

 net/bluetooth/mgmt_util.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

-- 
2.43.0

