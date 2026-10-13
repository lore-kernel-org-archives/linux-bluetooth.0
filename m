Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC96847ECC5
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 03:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791862957; cv=none; b=nTR8jIM2uNTZEYAG66qyzPO/8u9qEAXUhpPYbh2XnVe/VMVDq9/FE5+1cK0yWqsL7yIdkS6IkpE209VcErLEWFsEgmjrjlZ2WOSek5vaSvW+Sxe6PrqEcrmCL5FOBEBcPRgGa/5Nu0xK/NoF/eoDIaNyTPVq0bamJkenPNcaky4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791862957; c=relaxed/simple;
	bh=5l5rOMnqmUZDSkzkbMpjGa6wwNxhDpOe/T3B2RXhwgg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DcIqWvjIBDn9w8fjzH4tPvo7iLkmNs/R/J/98rR/NDwcfqXxW3q00nslstuG3zCmEEX0BVzRZExTXZinDXQMluKQtfhVkTeCn+UKT47E12312MnWZbMnhK6qXhpm4zhG1WPBZI2oMi8myyf4K4HKaK+xiLruHtqk2YgTyFZBEP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bN8cZ3XX; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bN8cZ3XX"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-3514b90bb89so4717725eec.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2026 20:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791862954; x=1792467754; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aCIUa8Lo33J/2KwMBZsXqmYyUZJ5D4WgEyODRjSabeQ=;
        b=bN8cZ3XXUjO+Xw9MdiwVS/x5yAB69JEB0TBQZsIGDrtSdrtm31DcqanyfySbykwo2K
         ika/pCp3f/tHexISEQSf2Z1vR0lKpGakOmJJ4SAKmYqLvnahkDmWdvUTijHUiemb0RS6
         +dilucNpiFBVWT1sDgj/ltUCQ5Htq6FJGNOkBtS/c/vRcny/Fx19p3nPr7pBOaLxosTI
         gitEA1bAEdb/Dav6hlliSUzsAhmGQyOyr3neIPJcLnatoKHLrkfAFKKC3RDLVeql+I0A
         EqI/ezsAuOJ0d0tfLmHhB6Tis9SoJJRl/45x5rf+BHrSvLponjhygrm3dwjp8BCfDGZ2
         +VCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791862954; x=1792467754;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aCIUa8Lo33J/2KwMBZsXqmYyUZJ5D4WgEyODRjSabeQ=;
        b=Y261WdZKZtRjaLa1YxjtpEEsab8tbCHAsuLbpt9V0DnlIILEPZr85JRbti9ZfJSMXm
         UEoZfiiHzRxfghmAjnl3nlOtcoJiW+ZTXYOyQ5dLQR2cq+6MIPG3mEVD/sAF2xtkVjDo
         Tl4x8bx9pnfOsyHU366WsrEApjpDLY8o52dCxuZ/M1D45vDSa230ytfQLrvO8GrCexhG
         DeMcQTxpPi1sk1Rgm4ITXPbIlc+ZbJVaESfZ4LNzqBseLifM6MuIW4RkaqbLxX+1UkD5
         OG6MO50aiRec8arDKRcFTL0sddWGIBeZlWozSdEKxNQHWQ5DOYqbJ/BUjM/bFCbeuL+I
         5Ldg==
X-Gm-Message-State: AFq9FYLbo+6So+eEtTN15soFysYHMZcGpmKWceErEMiV6SMBA9L5yG1A
	xOIdgfFMDHSD5jBQ5BA5I0mmAX9t6Sw6Z8iMhtO8hPk+c/Dnjxmyivcx
X-Gm-Gg: AYBFou2IDvQuVAM8tt4La3cIvVGl3+WppqzVQsqlcZYcC3/gFiGFEGO1hr1OCr8KtBL
	iIpY1TDKo0rDnRJQJdH3gzCEidlsEfDjVvigAV9yLXEMwR9szW4kegjUfv7M7MCc+q0eRuplGOC
	cE66QCUW6Qc1fCSS3V065kB336ZxsOuoZGMJTjJdXtAID3Av6Zn7u0ZCxNKr6Vv/iwfbXdRy6Dk
	fs7XHcyCVUsMF+pY9lcYH6rbhPRNk9sASty5aT+6GwgO1xfXFPJzgbTRPy/nkbGyY0/iO6nbq4k
	IwVHO0WzDAvOi3Y0EI0MUvJJkmWIsGxTkdN8cxQfz7JsAFnXbcI0ba+U2iWDGjmN0dXYiuV+VuA
	1dKLmE0YzEUacLT5wA2UrIN4CkCu3oUiMb6CXYcfJWiztmtjEE+DmCkH45ILZOrGUoPlZ/1CKgh
	BJxpPWsql9H9K4VgP4OI7HSc2NDvt8LqFcTatyMhSKpZt1eh9eWj4tPIi6l68DJO/IrqK12T1lV
	WOcbK25hzBEDLT0wpLIjt7FkSl0UgB0cA0gsNOR6wLBiIGlDyJIyVBuc0YEI5I=
X-Received: by 2002:a05:7300:6d23:b0:35c:6ffd:e91b with SMTP id 5a478bee46e88-35c6ffdf3b6mr1436443eec.40.1791862953821;
        Mon, 12 Oct 2026 20:42:33 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:679a:f35b:7c29:e0f2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cb68e56sm35268677eec.29.2026.10.12.20.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 20:42:33 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Mon, 12 Oct 2026 20:42:22 -0700
Subject: [PATCH 6/9] HID: goodix-spi: Drop redundant report ID validation
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-hid-core-report-validation-v1-6-e0dd5cb60b2e@gmail.com>
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
Goodix SPI transport driver is redundant. Drop it.

Assisted-by: LLM
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-goodix-spi.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/hid/hid-goodix-spi.c b/drivers/hid/hid-goodix-spi.c
index 03d549efbdce..81603581ae40 100644
--- a/drivers/hid/hid-goodix-spi.c
+++ b/drivers/hid/hid-goodix-spi.c
@@ -461,11 +461,6 @@ static int goodix_hid_get_raw_report(struct hid_device *hid,
 		return error;
 	}
 
-	if (buf[0] != reportnum) {
-		dev_err(ts->dev, "incorrect report (%d vs %d expected)",
-			buf[0], reportnum);
-		return -EINVAL;
-	}
 	return len;
 }
 

-- 
2.56.0.385.gd3acb90ef8-goog

