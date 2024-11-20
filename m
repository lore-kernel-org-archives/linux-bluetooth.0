Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDAC19C542
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Nov 2024 13:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732107783; cv=none; b=VFjXxRHm/UUzYgekCfMYRTXcdmj+4WqaGJtB3alJgbCDLcsDbcSsiEQ+WEEAs+h49HHmp5y33zZ9Vkq+ev5e3OcrgdJ0QfNA6oAaJCFH/HQPyNXD8fPVxw4MZgC0PsCPNhv7e+UlIwkXTuGERIFRkDLdZO9bd1NEhhTGwxHSGtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732107783; c=relaxed/simple;
	bh=AklO7Ep37Z9t8zPpacdd7LvHYRJG1f+G637csZYAuDc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hNXfhQ7SQ7YYJw5hiO+Y2m6QZr5Hj7vTzLNlpqZj9Hp8kWsIo7d6bs8+ur6CbtkYBtdIk8uu+S7kOBwVe4z905TRtyyxVx2EJBARcTfe9LtEfY9rGltGSY/wTq6hmYqeKBX6DACGrNvS63ob2dI+g5d1WOcGo9Z9NeOseZqskVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heitbaum.com; spf=pass smtp.mailfrom=heitbaum.com; dkim=pass (1024-bit key) header.d=heitbaum.com header.i=@heitbaum.com header.b=T31AOBYQ; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heitbaum.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heitbaum.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=heitbaum.com header.i=@heitbaum.com header.b="T31AOBYQ"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7ede82dbb63so2622131a12.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Nov 2024 05:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google; t=1732107780; x=1732712580; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bq2LOKLCr5boFFSS1gEXMTqxlqLDdnDIUV5osrtgs40=;
        b=T31AOBYQLfHQCHH6FIUvtvZ0mhXhbUoaVyUfHqV0JHsrcFlmnix0QfzYb2WaznBfB2
         GG5IqhQJaN5IcbIbL5GUBLB39IxM6pkDasAKI+NjWlQs9/D3zydlv0iTn/jrQPXp0kob
         7cy29Eq6XlPj7sgLnbpyySSoNXguigtJkAe7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732107780; x=1732712580;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bq2LOKLCr5boFFSS1gEXMTqxlqLDdnDIUV5osrtgs40=;
        b=erUe9MK9Fl21K/z3l8EcTf0MLWTvQQLe7PHYHt7zFudlJbYo3n/9TAOfMHTKOpBMCH
         X7A42TT9KtAxG5pwEgyfq3R48xW+3o+Qmdtw4j35OTJQJFAoyP1pnNFzpJn8lhynFPJA
         GU85GRvjSpNyjjaS0S1O9CW5o4Z8nPnJYkVOeGJJxnsIWGxL1atVrTI2gaI5kqZAqgvm
         j/Wd4M7o/5S5lEa7BsK5UW/82ooptZ8iv2BN21jBfSZyMIn0iWxNQasyJxGmgf0ozwGh
         w6jJuX5BJbTGH/wtuYl9skllx8pjABqmp4NTK6tlZ9Jypk7m7Kq89Gp+DpUSeiFkaxTG
         i1lg==
X-Gm-Message-State: AOJu0YyZ82Kl2WwW4NTmn5PEodpmVZMwPpUvMh9oJdbCak6U0xIEKDaJ
	nhx8Q98No2wnQwks25M6NCtg7cZPGza5gbZ2Zdzt5BBL0AF15Kcc/TnZWlGdAHSRpmQ6BAnknnE
	M
X-Google-Smtp-Source: AGHT+IH4CJXdEdagEVqZ5qFNRKnVDKs8r5eWx9hVYa7sB0Al6IMyHeMMbQQGF3CUVxalslJ5t2k01w==
X-Received: by 2002:a05:6a20:2594:b0:1db:e10b:8a9a with SMTP id adf61e73a8af0-1ddae3e7935mr3620499637.6.1732107780141;
        Wed, 20 Nov 2024 05:03:00 -0800 (PST)
Received: from c8d99ad60702 ([122.199.11.121])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724befb43b1sm1545857b3a.166.2024.11.20.05.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 05:02:59 -0800 (PST)
Date: Wed, 20 Nov 2024 13:02:56 +0000
From: Rudi Heitbaum <rudi@heitbaum.com>
To: linux-bluetooth@vger.kernel.org
Cc: rudi@heitbaum.com
Subject: [PATCH 1/3] shared/ad: fix -std=c23 build failure
Message-ID: <Zz3eAJcwA--0n5lf@c8d99ad60702>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

gcc-15 switched to -std=c23 by default:

    https://gcc.gnu.org/git/?p=gcc.git;a=commitdiff;h=55e3bd376b2214e200fa76d12b67ff259b06c212

As a result `bluez` fails the build as:

    src/shared/ad.c:1090:24: error: incompatible types when returning type '_Bool' but 'const char *' was expected
     1090 |                 return false;
          |                        ^~~~~

Signed-off-by: Rudi Heitbaum <rudi@heitbaum.com>
---
 src/shared/ad.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/ad.c b/src/shared/ad.c
index d08ce7af9..dac381bbe 100644
--- a/src/shared/ad.c
+++ b/src/shared/ad.c
@@ -1087,7 +1087,7 @@ bool bt_ad_add_name(struct bt_ad *ad, const char *name)
 const char *bt_ad_get_name(struct bt_ad *ad)
 {
 	if (!ad)
-		return false;
+		return NULL;
 
 	return ad->name;
 }
-- 
2.43.0

