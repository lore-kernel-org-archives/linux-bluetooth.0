Received: from mail-vs2-f41.google.com (mail-vs2-f41.google.com [74.125.227.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704514F7CA1
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 20:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790625665; cv=none; b=dcBOUxkSlHdjdhErNmIhxijAv9oQVwekd2En6mrQoqLo6ELcZf1BF+hqCw81S3KRVswF0YjFKujIm22xJLaE+tzp1loQvYMmq+4ZBtu3+pG/KyfR7jCQxsVwKvDsIvJn94Ntheq+Yr4bZMAaQ/SjdbgOibTSUOqF8u+LG6kUkZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790625665; c=relaxed/simple;
	bh=/FEZTPT2L2/rGDOLXfjsNIFDX0IxbzgjtFtLjsrX9oY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aeSQV4ShcmDbkDO1eYzkGiR1p70/YE9IGbSGjspffkARVeGPmhMygwnH5fS5W9z6f3UumWNri81XGCmn8Nc3wwTTFrHfBIUik0ovZUyKI2NVgH2Xvhd61pc5TBFJ8u6d0gZ954YnHl3EiJL19ibAQ1aEpltQc2Iu0CUZaX86QSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aW5y9h7N; arc=none smtp.client-ip=74.125.227.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aW5y9h7N"
Received: by mail-vs2-f41.google.com with SMTP id 71dfb90a1353d-5c963a787c9so1253969e0c.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 13:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790625663; x=1791230463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rp41POhCiiUSxOFWV5cikekbyRUKV77FzUtqMDpkOfw=;
        b=aW5y9h7NDDy8iDP840p1F1ZvE2P5IPaeC01MP11z4i+cxp1WobPLdMv3Uc9ACFFy1C
         le0Paqdvv0nnHC3E36uc2d7LBNTZOW06G1fT+zb9W3F2T5ro4H9yHrYPdzSqj+V8XdSK
         npn6LnmClQHJ6e5PizIlmD8GqCstX5QcNmmcdZAmz8u8m+27to0B6zf8QRkJdLaTCv7d
         72ypHkl4d4GiZ387e7tM9umGqKbD8pUnQvHwwdttXaOPhFbdXGnzM8eGVgQN/onlHRbT
         KkllFVWwkGxIFkGZmccGZsFiVBzeCGevvmSw2v0I2mjanvivSCjWM/pSWEgAkdtfUHFT
         AyJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790625663; x=1791230463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=rp41POhCiiUSxOFWV5cikekbyRUKV77FzUtqMDpkOfw=;
        b=sgcT2LgcU8mpuEp9r9jnB++FLcCfYu94G6yUq4+5q8smRvOZIhg6kkVdTe6EnUivt6
         uFBLcUgL0pc1wm7wzHU0wb+ZMQIMNAuyGTylVNbbvHZXarIiZpDeYiZjteE4XdZ8E9rt
         os9SHUuUrhqObUIsizIPMz5h5RKKMcYwLddiB5omNERKx0haYZmrNuWyjr3nZj0iOAGI
         A4GkTJnqgH/O21RYz4U5k/rkVx0MbjOgbFsaoUQgtMm7CRcR8la5bXd8oYUJYWSpI+Fo
         b/hUtfrzHHHosVZaB5pwdQKCcb6e5JJqtip6MULYUJ0BpDy7uIvnGtxhJoDl4UOFNpiH
         g02g==
X-Gm-Message-State: AFq9FYILjSJrxpBgwPXJBYAeKfSQyB7qu2qtnrWzD2mHaAMambBjWGM5
	6IvF7eKpwyd4/MORqbNSe35u0O82kiE3GI4TK7v9/sCFYQAhb/B3AScfTriMJ/cJ8BM=
X-Gm-Gg: AYBFou1u+Fi0dOHIW13y4Uqv+BK0hHT4FWexQlpdn7os0VIA2mmot2rs8m9I2IwHjnE
	+Dmqrl8W8MvTxq7z5wFc5yFxH7vKh9pxxXlWIY80LpwmWBCbR7E5P3vJKUYBrOgPBgqM9Q+rwiL
	qB6Y0It+P5sC50KJwyGcp1cgj5J1gfqmpW9jCiCFccamPstURvcxaLdvQX+n3hHvq48NzNyDiMh
	VvnRueCtXw3onqTp/6c9O8tKeVzFiNtPqo/Kr1rR3odXKVJV8N9E+WxOaC+ac15YTQ/yKpQyTqU
	hS0Un+8jb0HBnbUFoXAHQvDofW/FSHb4fRH/UpYq+yc9TQztnlnar8FCE1973o/bqjiksQAgQ3w
	iSCduEp2iPZA6HOx+EtbMo9xoliBhLrIRNzqOaqFMoFsiErNQBpCDoVdQSp9HQfzf8uprN5iX2Z
	BxwMW1l9Daz1NWKvrC7j4NAU+YdT1S+rcKGHHoZPdzj4Jv9WKzPsS2DFg1K+j7sESHOB57B/x74
	3EfENSqkZOnJI8R1vg66Mc1kSFoiuCMpW+pmLqXAHL+iSIATWoq3Nh3xrIFD3W6
X-Received: by 2002:a05:6122:488e:b0:5c9:ef0d:155d with SMTP id 71dfb90a1353d-5cb08b4038bmr5824240e0c.10.1790625663130;
        Mon, 28 Sep 2026 13:01:03 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5d1d23f8dc2sm749638e0c.6.2026.09.28.13.01.02
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 13:01:02 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v6 10/23] shared/uhid: Fix size of Get Report reply with a Report ID
Date: Mon, 28 Sep 2026 16:00:16 -0400
Message-ID: <20260928200031.1209311-11-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928200031.1209311-1-luiz.dentz@gmail.com>
References: <20260928200031.1209311-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The size of the reply did not account for the Report ID prepended to
the data of numbered reports, dropping the last byte of the report,
unlike Input Reports which already account for it.

Assisted-by: OpenCode:claude-opus-5.5
---
 src/shared/uhid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/uhid.c b/src/shared/uhid.c
index 919618a71b00..36a16c331e83 100644
--- a/src/shared/uhid.c
+++ b/src/shared/uhid.c
@@ -530,7 +530,7 @@ int bt_uhid_get_report_reply(struct bt_uhid *uhid, uint32_t id, uint8_t number,
 
 	if (number) {
 		rsp->data[len++] = number;
-		rsp->size += MIN(size, sizeof(rsp->data) - 1);
+		rsp->size = 1 + MIN(size, sizeof(rsp->data) - 1);
 	} else
 		rsp->size = MIN(size, sizeof(ev.u.input.data));
 
-- 
2.55.0

