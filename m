Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9C047F772
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 03:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791862954; cv=none; b=qT++A4CQ8jIf5bGORpOLydtqfjRx3FDbTJDXW+/ufPw9o066OwUFH+EXEE8AdW07w+o1+Hiu3pr3l+zUXht/EPNGtvYd1MAg7zvgpKO6NamUF9aodmQ8i8av5SQOxqoU9LWwixbeUVkkq39K44NpENy/fRWVXLaA7rSF5IWKaDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791862954; c=relaxed/simple;
	bh=qQtZc/LYpwS1Pn0Pbj2cy59uoKqv6Ln5ZHOMP+Ij/ls=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hprtCcJqsBVSvum9j8y3FfEWrcVtY4jtuFpjSR8sql9SNOpy8AbdZde3j2AQzs+o5wLrAIep5wUT8S38RV4nfeEqi1NFcLGOPm7BrM1LGytRlfnNv5z4sB55UAP1rGSXhipG4w6TTJGRslv1gN4rGQEp3AFT2toBaprBEnKPo94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q2kRnEGy; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q2kRnEGy"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-33e6279a1d7so1807431eec.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2026 20:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791862952; x=1792467752; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L6SSHz5Dk/JWNOpPlT4rfoa6eqVGLCdKSUBhsVYqgGQ=;
        b=Q2kRnEGyDFWcdS2ZxPmW7s+rq35ZtEfMcFORDFvjaZ/ulG2vHAL2pnYOHYLoA5/Evy
         DnIFiNOW+Jkb+zBFi6w7pKNnSUD6p+5KT4k4F/1pR0bGOOdOlxO+oA7f9S0e3GAMJ1zY
         wKO6ySobGjUrH6JS8J3py10QmYVf81OxBtH4Jd25Fv/0QLVrQIthjYqKwbCwUgUBiR3n
         DNX5g9Io0eUPU4Imqh+VLJmKaEMLYxU/r1QjAZh1xxBp4QrL7iZlbIW2QiVBUAlISHr1
         qSZoq9GEIMW4j4CLMplpcPw+c7HxvH283M2qRGVTZG9lxmnc/QvTncx9T0j6Q2YwrEnK
         +WYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791862952; x=1792467752;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L6SSHz5Dk/JWNOpPlT4rfoa6eqVGLCdKSUBhsVYqgGQ=;
        b=WTY5VGvXHbhF1HC0qH1HfiH70bVwi6+Rn+gh3QD/jqTxVS3c4W0+TvWSu3qOWwWI3L
         4KYFzWv7FZ0H3Y8FBQL/JVYUTvHfYm7nbCy+LZTBgDJqSxGsG8FqFzAvd9XF0J9kHUQF
         mlDMnrSxgv+CO+2tdNeELznsfeUuLH9+47Q8AswuDfwqZMcQJrK5ZcruBfhEweTj/hls
         HUVCQyBT2sLA93M1mCd4qAekFSjPXRhqHV4i0lOK2Z/X0Wshf0+tUE6ZpewZLy4RIZdH
         LVNjDaeKX8tQFtPaKfFLl0heIhtaWgtoU7DaO8rjUxyhX50vQfHNENCuV1Ljd44ltHRR
         8/qA==
X-Gm-Message-State: AFq9FYLnVwcVGRtSJ28+aaXNDFo52r/sJa2UJmUQnIQcy7bg+7JBisxK
	bJbUYQA6QGSoBwuekvBPgRgzsjIPnz5gBZlZrJyj2Ud+7bTwIKZuVieP
X-Gm-Gg: AYBFou3/X+YA1GMK6g6XQefd4VTv2IhbcxFLA8YurB7elY56XzLqUcLpn9QEx64ewQw
	q+VT45zmxmGQ565dZGCJZAp+86/uqUlfXmWfHXSazImnNbQB9dBwy1S8dS+oH8rOXT0Stti1bGP
	bkOEa/Du2qh2iizvvaWn5d6gZXHxdlBbBcgpNZuoZZ8jMU+KnC7StH+b8xf8KBVaapLhwCBG2hm
	Ros1m7tTPIoHjpigySNoLhNarqfz0VMewOoRzwbfdLh18VKJinEZzZmVrPjn/Xl+g4j9Q99s2dy
	dt++EQAZIbvKvvk8DzAQ1sbUILyHNFY0kDSaCOkCe1kvPE7IxavsWfYdyXqyS3fzrOeOxppfYQI
	nu1t5MbsOE/F6hKRBYCeVfJBTGUjQtP4QTBopn2QVdOGhzbWrTgF42W6JSIARHBqSY8yYF3M7YY
	mz0T5njKYf8xMD5laEzzR6ugdDztHZOeAmzr2e62rYOdY6DqVmV8Wak0LkGlaGnryPhRvnZlWDI
	EdtZLPZnOPShvMLpNXxRELTBnQZNeFhLko7UereWXfdet/wlgPspdE7WTl2f+A=
X-Received: by 2002:a05:7300:e9c6:10b0:35a:c54:f446 with SMTP id 5a478bee46e88-35a0c54fcadmr8535188eec.40.1791862952303;
        Mon, 12 Oct 2026 20:42:32 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:679a:f35b:7c29:e0f2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cb68e56sm35268677eec.29.2026.10.12.20.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 20:42:31 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Mon, 12 Oct 2026 20:42:21 -0700
Subject: [PATCH 5/9] HID: i2c-hid: Drop redundant report ID validation
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-hid-core-report-validation-v1-5-e0dd5cb60b2e@gmail.com>
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
for report retrieval requests centrally, the report ID mismatch check
in the I2C-HID transport driver is redundant. Drop it.

Assisted-by: LLM
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/i2c-hid/i2c-hid-core.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index a8a9854854f5..d8ed7bb8e80c 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -311,13 +311,6 @@ static int i2c_hid_get_report(struct i2c_hid *ihid,
 	recv_len = min(recv_len, ret_count - sizeof(__le16));
 	memcpy(recv_buf, ihid->rawbuf + sizeof(__le16), recv_len);
 
-	if (report_id && recv_len != 0 && recv_buf[0] != report_id) {
-		dev_err(&ihid->client->dev,
-			"device returned incorrect report (%d vs %d expected)\n",
-			recv_buf[0], report_id);
-		return -EINVAL;
-	}
-
 	return recv_len;
 }
 

-- 
2.56.0.385.gd3acb90ef8-goog

