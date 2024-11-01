Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B13136345
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 Nov 2024 02:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730427242; cv=none; b=gOyZOVoggPonCcFY3Dra17zsF4zQNPOLFm0aiT2D4iUmw9BWFtITIvnPgjoJs/IRjsb7kb9sK+KDBhkWcbUOFiw5Kyq9N2nPf7/0qnkq2BKGFUKwlWptkXFlbJY/lXgwZbW5Q7B7o+Dsx9petZJ4pJRW6C/LG8xReS8wAuLekQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730427242; c=relaxed/simple;
	bh=ezwLUsKsAzqhdqh6ddZFqZ9WJEo1uaItR7mLsoo8fdw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=IvQWQ+S2oou4qvFwOUJj4YWS4dD+dX2+V13atlaYGGFViEBnuyHMDMEdwUT3eerZG8bbP16BzDfEUpws7hYo/qSCjS+kRTEoRpoF5++mt6eSX1CwCVrozkte8/8KdTGRC53kZlQq4dKpANfGeFBTsUPgvFTJWEnXPlAIOD88ogY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--howardchung.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JMvXzbs4; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--howardchung.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JMvXzbs4"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e29135d1d0cso2841566276.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 31 Oct 2024 19:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730427236; x=1731032036; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XKH9Q4MaecAtc16OO5zSoVdaMrPrTs+ywQSm6sD6B+g=;
        b=JMvXzbs4NVknDiiQ/x3qbwtTI4KmMdgvMHZ9RnOF3z7VTAib2Gz6GN99Zq0v+gO4Fl
         PdJh2iiVz61aD1wIwUj5rGRhjNgHUTxsAs2OqXvsZpulmNoUDHDvdmNYYO5UABCfPQNe
         EcU52Vf7Sxg+UgrWx4rdi+aQ6mV7Q+0xbbjVeQPa7npZsFPq2orClFPR25pelOlNwZeZ
         pm0v4glrHzAPQEqTg4T0e1i75XId0zo2tiTk+21u3NNobgOkxwGF/IFrUjNQEuEdGhUo
         rMr+U+4tbIwUPmSIixkBESyZnfroIJouyMo7SN+0nCFj9i82u4xm1ifV9Jdhed364nDK
         RLJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730427236; x=1731032036;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XKH9Q4MaecAtc16OO5zSoVdaMrPrTs+ywQSm6sD6B+g=;
        b=ddgGXq1IKBIjVpFZM9IDFjP+5DFDvCLAireqh7e6SlU4LUXshokk0yNlmilTWoyqDE
         dKWr9+aks0AcTNFIp9i9PnERmr4v2H0wsyKxb4QB3JmXFf3pJemxCs2fn4iR1RqU4POr
         tdUurokyl5C0yRUziKbUReaET3M6M0Hgdqzt3cfPXqusWvxJsyb98zuufaOSm/ZERq4y
         OxrRPxb0HIXQM9B1kxFOeJlOmhfvzOJTIA0V3ncfpDBfED9IDPcdyL3Orwc+KEYVpQ3k
         MQPqfKALGEsDj2iUV7aj51qg+fU1iADpNAjHHS3s2EpqANXLZzwhsnYSJRgwg7SOsyT6
         co7g==
X-Gm-Message-State: AOJu0YzmVZcWS0F6TMDZL1Yj3vW7AaQ/pyZbCMLwxa1co1sLRcWyMMLD
	1mfcYW0yCummXKkezMODzJB9b7MLejKviHBweU5vJIGwRAyFmXxSiGl6RWbVzky7s6ELkyS8dn2
	10E7yGZVSqWZWU7YSCvNbafSpoXQygkzjEmgmj5LP2WIm6xY2zKXEqlbnGcrnYBk3NEx7z5EpWM
	sAUzFug5R6aJg4dKn1dnWAt3Jjso9o9ZFUWB3u4qtDwPzvTofSFns0L0Im5SjQrESAUL4aTLI=
X-Google-Smtp-Source: AGHT+IGRiQeP3TdpIVZ0iUpYBYrBhHaoNFwXKMWZGY0u8C4MUketcrmE8fFMVwenE/z3V41lb0c2Z6m3N8KQ+DDHOA==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:17:16b3:c4e1:7f2:ebed])
 (user=howardchung job=sendgmr) by 2002:a25:9b42:0:b0:e30:c741:ab06 with SMTP
 id 3f1490d57ef6-e30cf42ddb2mr5872276.5.1730427235530; Thu, 31 Oct 2024
 19:13:55 -0700 (PDT)
Date: Fri,  1 Nov 2024 10:13:45 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241101101345.Bluez.v2.1.Ia122d85386d6c2fc69f5b3d7ea7a7169f73756e4@changeid>
Subject: [Bluez PATCH v2] textfile: Fix possible bad memory access in find_key
From: Howard Chung <howardchung@google.com>
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc: Yun-Hao Chung <howardchung@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Yun-Hao Chung <howardchung@google.com>

If the searched key is a prefix of the first key in the textfile,
the code will assume it's not the first line which is wrong.

The issue can be reproduced by a fuzzer.

Stack trace:
    #0 0x55e1c450e7ce in find_key /src/bluez/src/textfile.c:133:9
    #1 0x55e1c450e7ce in write_key /src/bluez/src/textfile.c:244:8
    #2 0x55e1c450dc33 in LLVMFuzzerTestOneInput /src/fuzz_textfile.c:61:3
    (...trace in fuzzer)
---
This is reproduced by https://issues.oss-fuzz.com/issues/42515619

Changes in v2:
- Add stack trace in commit message

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

