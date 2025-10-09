Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804DC1CA84
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Oct 2025 02:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759978677; cv=none; b=nZR3zEGmeW+aWHUm0Svy6KFl6etp7jMpPeGOTkb81Stj6T14qTYFygvZjwwDYVsNlJ0sEVKET8wvJQqMZ5GVRhIe1M8GloZ8wUhmTV7Cz1TAI7vIV1Dg3sCxH1H1M+7ZOR1P8ZIINO4QtT5iOsLI/YzrRwwpGxXbXI9dTABVfp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759978677; c=relaxed/simple;
	bh=lF7BW2ohCLI1X07kVAARu7zfDJnU4/XAq0NhBy9tApk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tKJZ/3/rmg9pdp9GCrtnsaiTYoeCjfWVfR/vzoZSBPwGzxvtcHeNuKlxhWQOlELxRcJ6TC4KlnYv1KWb38bE++UwXHAgz+1pEIClJ2h+5ZDc8WkySvmbHLU7TH3Jv6zj0cE6yQeGeDTZgAjbavKaM9mId4JB7dAZ6O2uNWcnmvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nIQZcjHl; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nIQZcjHl"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7f04816589bso44984585a.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Oct 2025 19:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759978674; x=1760583474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vlG0GD1lh6iJAvDPmOa/rB/T6NwWaH3uKxr67w639yc=;
        b=nIQZcjHlZ1PwaSL0fXgX6ELsoBgDdMETdRevkwI2OSzwZnLZlXisundfX/dPuetQn3
         pBvAlhEY61HYn+1u0UqJEsuPGpxXIG/GBAK9TMYqE4CBaA2ouZaz/OeCQsA6h2PmnIBt
         B2auZ1/N4Pgr5DPkFT2Ok0mjRgjAkitDEEcR3FUNz6238hzrePAKzT6KlyI1Bx0WMMmm
         p0KziYOgQslSg9PfKqz4/0++6Qf1s3SkUJivyQlBFZJSNm0ruk0UmGZG6RRIIWvEUqvr
         tpKjRAyuVxbMRDEnMOgMOA5TxTgJb/fxvDZp9p/NnBXnoZLuouqPWGT/6pjA4sWZ9tJv
         a9pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759978674; x=1760583474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vlG0GD1lh6iJAvDPmOa/rB/T6NwWaH3uKxr67w639yc=;
        b=tu3VgkvIf2o17kqn9TP9QlwlkZr6J/+6SR2uD6lXhLqMnbJa21Ji7zo+HoFsDv1EKh
         NEsvLkTDTov6O9Rs1ROe431O9ySuFQ5Y5FRKOFbEtD3v9D4nwIk9eugOwi+YlyWQnPrn
         HuNSHPVOkcbAlAtIcapOnOnPrMrQaTGSmQXYzSXmp6oo9u0fAQ5BSmx1VIUOpYd6gXQ9
         LJ3ZlGqc1bjIVYhr+6fC9keg0iCWWUDfg2tkYvxIOT4YGSmaKNDu/WFYen7Y1ddfdss+
         e+2rmqTwsyL8y2k+CpwQsvLobgtxdMGkSRKaiG97mttIhoyjLTMceGj3lHvwwj4iPFRU
         cSIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXKvm0xIgpMR4lFzlCmFS1LkGtuiDW2Xs+DLhUBLCujDFlDmjI6AUyDEBtTOMvexW3UVbQY76msV3aVi9KQVc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp7cQDyD/1gX2cay59ZQdoMuwIBIls5Z4UtViRsbW30hfJBGqK
	1nwGx1uuylsTlBZipKDPNP/8zKT8zD5/L2dG4NwG+S1tz8G0jzEZI2Ug
X-Gm-Gg: ASbGncvyXQpeTqRjkWHK24EWGp4xxwTVRN6YjTwOjfnYQoT+vwP8xg4Lxcaxculu6VD
	h0KiVP7l6dDF/bQIXF7cBAd5oZp1FHVJ/YTIxvybsEJO6KsaZmo1s8j31JT1TnzrQKa1vWZojRc
	uLiCYn6eTxRUqhZ8VEqAX4zS1gwHaQI26pMRt6Mcw1iyfmwgaEUCyQapRGSL6zHjGt7y6D8JTL7
	/Pva6GPzr3ZF1jglt0M2xVf36lmebRIt8nkwHR0qVGR5tRI8Rs313vW/XnRLw+ZQ8hHWOvSGZoR
	2kAO5nrxmZft38UKSg2CFPMiaWALC0Z73xjiFpl5K67bUuSt3orAF1LXJhqntIwRiZdkM4NqvME
	GlBJRDs6ktWLRVJs/DtCKFbh1Kb2Fh0bTmNUedoGiiM6Jw1Bxk/ftFATQFmBnKeXLY5d1SWWi85
	1kGZEKFYMHDcDrZeQUlI1FvrhlDl2bQME=
X-Google-Smtp-Source: AGHT+IFeXJCxTk34Ai1JrFRrwRib866Y526WpeJO+H78PvcAR+LJHG+ZBY6j7Bj7ixRivCbirG2znQ==
X-Received: by 2002:a05:620a:25cf:b0:845:8f50:9d29 with SMTP id af79cd13be357-8834d1aa700mr867293485a.0.1759978674217;
        Wed, 08 Oct 2025 19:57:54 -0700 (PDT)
Received: from mango-teamkim.. ([129.170.197.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-884a2369a0dsm114261085a.48.2025.10.08.19.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 19:57:53 -0700 (PDT)
From: pip-izony <eeodqql09@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Seungjin Bae <eeodqql09@gmail.com>,
	Kyungtae Kim <Kyungtae.Kim@dartmouth.edu>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH v3] Bluetooth: bfusb: Fix buffer over-read in rx processing loop
Date: Wed,  8 Oct 2025 22:57:01 -0400
Message-ID: <20251009025701.3756598-2-eeodqql09@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <77bde79f-2080-4e40-a013-52b480c0928c@molgen.mpg.de>
References: <77bde79f-2080-4e40-a013-52b480c0928c@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Seungjin Bae <eeodqql09@gmail.com>

The bfusb_rx_complete() function parses incoming URB data in a while loop.
The logic does not sufficiently validate the remaining buffer size(count)
across loop iterations, which can lead to a buffer over-read.

For example, with 4-bytes remaining buffer, if the first iteration takes
the `hdr & 0x4000` branch, 2-bytes are consumed. On the next iteration,
only 2-bytes remain, but the else branch is trying to access the third
byte(buf[2]). This causes an out-of-bounds read and a potential kernel
panic.

This patch fixes the vulnerability by adding checks to ensure enough
data remains in the buffer before it is accessed.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Seungjin Bae <eeodqql09@gmail.com>
---
 v1 -> v2: Fixing the error function name
 v2 -> v3: Addressing feedback from Paul Menzel

 drivers/bluetooth/bfusb.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/bluetooth/bfusb.c b/drivers/bluetooth/bfusb.c
index 8df310983bf6..90ca5ab2acc3 100644
--- a/drivers/bluetooth/bfusb.c
+++ b/drivers/bluetooth/bfusb.c
@@ -360,6 +360,12 @@ static void bfusb_rx_complete(struct urb *urb)
 			count -= 2;
 			buf   += 2;
 		} else {
+			if (count < 3) {
+				bt_dev_err(data->hdev,
+				       "block header is too short (count=%d, expected=3)",
+				       count);
+				break;
+			}
 			len = (buf[2] == 0) ? 256 : buf[2];
 			count -= 3;
 			buf   += 3;
-- 
2.43.0

