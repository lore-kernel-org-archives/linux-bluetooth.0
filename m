Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FB7481238
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 03:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791862962; cv=none; b=ImK4DNMDMs0zxQvfBgfzN3TfpBwL25f61PCbb7KM4JIvC1fPARxbe4T8PsMLSWiMdEHBC+vsu2lPZdr8Bl/y8ByS6RyzSC9x/l2XIsR7pf4knKqGnsjz38tZ9eo3cUjLxGNoaUf07Y3vhtG4k1Pl5OV/KOOAaKv9B65QthTohF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791862962; c=relaxed/simple;
	bh=vOJczOjB0TyoKQuVkW2orzE70JFVuyQyf49j8eErCTk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cZp+hbpIsarZ4rI9bSzLlH/1028csKIFQ2M9EeJTem6+bbUqyxxrDDi4hj2ofLrQ+IK6lqB1wOca351sVQgsrYmc6AtmwO6aRyXfEhjb5WXiU6KTYKJb+n9fwifldLr+VpKymY1udziVAWldqvWQsXYB2eM1gKXk2Az1cwqAETo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dL7/Qskh; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dL7/Qskh"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-354ba08cfd1so4387240eec.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2026 20:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791862959; x=1792467759; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2jUpAcTrC5YTZFZzQ8gUcjDGHz/C/y6LLOxwXLI1DTw=;
        b=dL7/QskhLLhR9SP9+FZZekIxX856Velzj7ahazF1Zt//zguqFw3lGjmS7wfTP95zBV
         xJ7pI+IpvIJkA+7gAmjgnWN5DixYAqrSd0AT5LUpVup9LsPclxnKg2qWaSO+FAqwIX7q
         e6+V4vu3oTVNIVA9jofoet4s3ebPu35e2a/Sen+ss4z5dQyB/VGM69ZrvyfDzZY9mTHr
         h483MpyGkODTtCml8J4eDCizA+eHmj0lcC1cLKo0C4n8HYupZyHRBZFeUBt8Z5kI0c95
         cT7mD+SM4VO+UGMb1VRYbJURBwWQfscy+nbBvxcwrlC5PU63N1FMrJ9gAx1JXKFHRlds
         dPKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791862959; x=1792467759;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2jUpAcTrC5YTZFZzQ8gUcjDGHz/C/y6LLOxwXLI1DTw=;
        b=1leRAtYYAypgT1/0X0YokRFeRKfGndSr5U8lZOQha6nRErkmciwLPr6CE+fb7T0tYS
         gpfgDUxXOD7JmSiJD76wR9j2xEXhCgvGf9ADDN0g75cIaI4nfLfmplYIIKqPVgRsEfIb
         9HfEpV1l4EBxUGDRYLJETW0kul1ZttKw4j5Ef8wLEFyp3DRSfcC8vggyTSmWZj8aPRIj
         8YJ7x2uOgyogE2etBS85XPjBS/OgyUQz/0ROAz5gHO8wCn7/LoOWVBGr3LOC+L0oLt4u
         dwLDdPRYemUOud0+fDcOE1drA5bqHFO0YE+iNsye/09yshYcRu7PsyZcmzlpxzrQwz9g
         I5mA==
X-Gm-Message-State: AFq9FYIYRPuUpmK+557n8wqVqw/kbUo4MBEyStt2ndVSl0XVtwpcFfd1
	7glK7vSAmgGsE7xS++Cj1l0Io7PgGZXC28fvKWxG6SQ/EtjBM+uSNu2X
X-Gm-Gg: AYBFou2VCJ+7rWFKCWKQ0s/eBGR/2JJbtruLFk0wUC8FTYfZJl9zL8T72LyfnhgPVPZ
	WPsX8bsy4tvVVkEVuece898zddPHK0SZkQnZNTsgJ0stywMtwo6w9Zom3NPqNqS/8yaJWHnI896
	cxCvEqCebwJQBGOV5TH17CnZM6zhmqyqAKhkYgvnvm703zJNOLX+e1WRAPywiUhMgf6rDERNFe4
	zcNke09qcc+RTQk2uNYXDHpYsK9+BEywpVFytNgMwuiw4D/Vhg8JT6XL5rTFKrGOXNUOCFGWxop
	pctO+g07HDJIVSo17vS6BzKBaMjRRJCyApSI3ZCTjEPvF0BsLvNYsjmlDM/vY4kUCJ/6ZOSvFwj
	4viCZsNYBfr6jaE2jIhJOc7pFwIChziFkV2J0NvjkzPf93PNvnLR8chul2xRH3bRrG4iHuO/qnU
	TdjjIvcgyP8xT0g3j55h0Ju0aKZ+VvtiVyqX97kOhtC5Aq/Vkj3h3NU/OgqHVcFyiqty4ndwQpU
	NSxdFwn3bU3ZYhndHKgb4AqTI9hYRX1bwc5y3J5UiSTuBy7IqTDiOylDt6zzyc=
X-Received: by 2002:a05:693c:4151:10b0:351:70ec:1071 with SMTP id 5a478bee46e88-3537e0866d5mr17875344eec.16.1791862959195;
        Mon, 12 Oct 2026 20:42:39 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:679a:f35b:7c29:e0f2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cb68e56sm35268677eec.29.2026.10.12.20.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 20:42:38 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Mon, 12 Oct 2026 20:42:25 -0700
Subject: [PATCH 9/9] HID: playstation: Drop redundant report ID validation
 in ps_get_report
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-hid-core-report-validation-v1-9-e0dd5cb60b2e@gmail.com>
References: <20261012-hid-core-report-validation-v1-0-e0dd5cb60b2e@gmail.com>
In-Reply-To: <20261012-hid-core-report-validation-v1-0-e0dd5cb60b2e@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 David Rheinsberg <david@readahead.eu>, 
 Frank Praznik <frank.praznik@oh.rr.com>, Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires <bentiss@kernel.org>, Even Xu <even.xu@intel.com>, 
 Xinpeng Sun <xinpeng.sun@intel.com>, 
 Roderick Colenbrander <roderick.colenbrander@sony.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-input@vger.kernel.org, Shashikirana H K <shashikiranah@chromium.org>
X-Mailer: b4 0.17-dev-e56a4

Now that the core HID request handling validates returned report IDs
for report retrieval requests centrally, the report ID check in the
PlayStation driver is redundant. Drop it.

Assisted-by: LLM
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-playstation.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/hid/hid-playstation.c b/drivers/hid/hid-playstation.c
index f9dc9378cf77..de51a22ecf0c 100644
--- a/drivers/hid/hid-playstation.c
+++ b/drivers/hid/hid-playstation.c
@@ -813,11 +813,6 @@ static int ps_get_report(struct hid_device *hdev, u8 report_id, u8 *buf,
 		return -EINVAL;
 	}
 
-	if (buf[0] != report_id) {
-		hid_err(hdev, "Invalid reportID received, expected %d got %d\n", report_id, buf[0]);
-		return -EINVAL;
-	}
-
 	if (hdev->bus == BUS_BLUETOOTH && check_crc) {
 		/* Last 4 bytes contains crc32. */
 		u8 crc_offset = size - 4;

-- 
2.56.0.385.gd3acb90ef8-goog

