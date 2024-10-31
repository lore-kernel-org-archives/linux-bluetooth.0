Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D261BC20
	for <linux-bluetooth@vger.kernel.org>; Thu, 31 Oct 2024 04:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730347449; cv=none; b=qPFY8cWf61GoPap6Le7UbZrXCW3oUMB0EZtc7kt0VYoSobOUGOqBqoEiqpXVXO/sg64SuIyyhSNbDoPosgDHZ6OZvlgY/NrTa7Yt7lRabsdvWUTfygrwQdIfSRSob723Sn8+2tmQb/GvnpPbk+R5XZLek0aAMDvGFw9gOOz6cKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730347449; c=relaxed/simple;
	bh=u0otbi1KqNuUeex9wDKzy7ULXAGJMgqkLyr1ZFRR1J8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=iPbs718ckQgRdPt9nLD9Qm6Bi4/PB2wj7uoHbIGFlt5dYZnCazOPaF+rZBMGMphJent6khbFjjbguqnrQgKbM0T9fbib7mPbypBZ8/8SdLklVBkugwQt1CJT7rYFwaNJs3MY7+cGifUq0Oht2I3sNsqGaT57gQPRcQIAiQQe9+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--howardchung.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pDLeI9S5; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--howardchung.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pDLeI9S5"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e9e8978516so11035457b3.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Oct 2024 21:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730347446; x=1730952246; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Sib5MUTy0ZWUPCb2Gk3e5OmGbxD7wtulHHXaWjL2M0A=;
        b=pDLeI9S5dJYNzRQa2rqESxiAFhllzLHpMow8KJSk9PblD1k4BO4b+PIxYYNY3mAPP9
         xkW6FlrtFhh+jyhjF5MOdtrv0mvDmoC6D8+km9aDGu4307eCU99LW/0bvuBns5AJ2Xht
         ZJViaF45YtNorCqCpv3QWQtmt1svUYt4MmrYC4tuEOgHjvOojKNphgSoO6/ZRwfVW7IE
         DpLQolP5RulZ2rvuQf5ky92dt3TP+2hbGs3hNj8dXaynXJhP/y6O6hXHd28sDAR90PNr
         7OnOmTQfqFoYO0JGZnsQ26ghwu59ZEUCI4GdGs9D8uxa70xJOh+ryJIjg3fWTb/tqPui
         fDNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730347446; x=1730952246;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sib5MUTy0ZWUPCb2Gk3e5OmGbxD7wtulHHXaWjL2M0A=;
        b=XtOK658xN0q86Aj6M61KdUT/s9Apw5qkQjSYDa5UnEMohhcqXi8Kxna42aMYlNCC54
         zx2XSxQHzsF1xwbWB8Py7tdhxW60BgYqwx/HLRaukemArnKviQEuYwgVgZFMBCeUg3Xa
         AQNNxY43rnSthEdbRYjUY/SQ6J0UcfMwUYY8u9kdYMnfK94OE2xGzoVCBtWPk5Q0WZj/
         tpB1TOsSbomsDFD7n/Td69pii4BfqOlx5owtooEdVXYkZ/mHa5FZFabp4SYWi5X53Aju
         gEGyIGZabT6KrRGNseqVYnmzTyq53sFkhFrsU/QpZtUA+JwGH7o9XmFMgwKkFAJCpMrB
         LEug==
X-Gm-Message-State: AOJu0YzIJqhijdYYfhaTR5hpD3sbxZeYEa7f5GFkf+/EDIcchLCT0Nzf
	w0qSH8c++ZBSfFw9QV38SviopLZybvFDWqEEBkPATpTCnPd/kGG5Fd+RH+R1p5ANTALYDZrJlXu
	XDg59wUnVRpNLIEl13WqEmH+HYZzZdqwdMbTptAO5mZRo5S/Qs/ywYq4kEuv2QKmc2FzlUZ6Wb+
	afpl+d70GEQcmls5omziZ4A+pcj0xUGD2dBUQPplfTMmNjMgzTWrK8jiMuivWNnEEANElxDyg=
X-Google-Smtp-Source: AGHT+IER8ZKnrxoApIdwnKDd91vyL9BE1UZm+5VKRkLwpSpP30c3uVSk9TgZuuqtVjFd+kUhUaBn/TRILns3uEpzMg==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:17:16b3:c4e1:7f2:ebed])
 (user=howardchung job=sendgmr) by 2002:a05:690c:4a02:b0:6e3:b08:92c7 with
 SMTP id 00721157ae682-6e9d87070a8mr9030707b3.0.1730347446126; Wed, 30 Oct
 2024 21:04:06 -0700 (PDT)
Date: Thu, 31 Oct 2024 12:03:00 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241031120259.Bluez.v1.1.Ia122d85386d6c2fc69f5b3d7ea7a7169f73756e4@changeid>
Subject: [Bluez PATCH v1] textfile: Fix possible bad memory access in find_key
From: Howard Chung <howardchung@google.com>
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc: Yun-Hao Chung <howardchung@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Yun-Hao Chung <howardchung@google.com>

If the searched key is a prefix of the first key in the textfile,
the code will assume it's not the first line which is wrong.
---
This is reproduced by fuzzer: https://issues.oss-fuzz.com/issues/42515619

 src/textfile.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/textfile.c b/src/textfile.c
index 313098f38..8188d2ebe 100644
--- a/src/textfile.c
+++ b/src/textfile.c
@@ -127,10 +127,10 @@ static inline char *find_key(char *map, size_t size, const char *key, size_t len
 	while (ptrlen > len + 1) {
 		int cmp = (icase) ? strncasecmp(ptr, key, len) : strncmp(ptr, key, len);
 		if (cmp == 0) {
-			if (ptr == map && *(ptr + len) == ' ')
-				return ptr;
-
-			if ((*(ptr - 1) == '\r' || *(ptr - 1) == '\n') &&
+			if (ptr == map) {
+				if (*(ptr + len) == ' ')
+					return ptr;
+			} else if ((*(ptr - 1) == '\r' || *(ptr - 1) == '\n') &&
 							*(ptr + len) == ' ')
 				return ptr;
 		}
-- 
2.47.0.163.g1226f6d8fa-goog

