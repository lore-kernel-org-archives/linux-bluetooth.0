Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C718818DB19
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Mar 2025 19:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743017514; cv=none; b=ZW6461emqQXKL9eT+zDUnEYcCFrm4iqiWVEiR3G5DNqbhH4DQO3us3RmlHoGrcWRy67rLCuliSa2QsEWsJefUHhJAyB9D6eHQaxGMykcS2NAtmgcaclTre0oK7MfLtqd0ErHnnMphJ2hB62VAydk76bE7HQjitVqT/XI7XtX4lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743017514; c=relaxed/simple;
	bh=0kAz14LJeBzujGmsf5ftu+pOZ9J8TTK6EMSZWmrZ+1g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hio0ljODLiYpFl0apUzYsr5Ltk05YFS6C42U37aDaDPUjavtzNvslB8eHKBRmkSEUJkTw8Nfglyabr6QkT8Ncwj5nYElOt4QgbOPPKFyVY6Wdv5GNgBCjhZHRUJBhudhf9nsFdl5dfk5Ce1FfDV50pXcU64MoVqwGOeH6jFlhuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hP3nXNkP; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hP3nXNkP"
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-86fbb48fc7fso82620241.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Mar 2025 12:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743017511; x=1743622311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qUFzjok7KDF0U/68DXlWp0PHaQBteZtCHRinspvqPZs=;
        b=hP3nXNkPYbaYsbX0XQfs83DG30e18M78xXT14nA92lMlFIT+IKRdA5tHZugbpt66mr
         GFtbjsTw0hqSqlF6S4jTMED43D6v9DN74+VepYlW3Oq5d7htZAM2vgpuO7xCecHCl96K
         3v3vRb2j7osBM0EUJNQpTD5Knj0VZmvX1SiDMG6FmABSZaLX6hpODvCqLZzCS7M9F8WE
         JXbU2krfS+rXYJ/l100+sQTzBa5oQb3GsN31WScbpF1qrg4gidbaf0wgzUKZUsBpqDFe
         KnRSchire7aRKGjSojxXAvwFByzlo5vURVnRX7LuUwfqI1aPIfuRuJuSMcNXN35vOBWy
         Ml4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743017511; x=1743622311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qUFzjok7KDF0U/68DXlWp0PHaQBteZtCHRinspvqPZs=;
        b=WDl5buIEa06jZJ4B6Ds27XDZnRfbRtigLXRXJQ0HlmffBOKDqMIFBu20CC6RxiHz5e
         xzKC1StNNZxJJ5685qtXfbw1F1Q8sxmvGtI/bEme+1In90uSY/ghfOmHK5PXIDjYgtwF
         nwuKVyXMB2bBxtVEkVCZ8Ucfd7/t2DlKoIHCDJ1GCO9OdEZ6iyv6NeHdYND64TJyehr7
         lFFurWWCQBuTkBFGOEJd6C68Bvm5tAGrIAFFLfMv3tJ5qvkB6xwZ+ix3K4/a0Ml4HBr2
         v80vwbP+NUJCv9nFXRpguw63Ne3aRvnLC3uKL3XNeqDcWbmF1E6IGhIihf6Zv1W/8sz1
         K6sw==
X-Gm-Message-State: AOJu0YwcDcCdBkAw6vVSXixLkp2Rq+CeJSLb77nyPUcaOnWxQGGNhGDX
	1glG0Te4UW/p7ID4Ozla9hy4jGIW4LupIVndE4j20TwY5bPG4iX85CC5GN3uG2Y=
X-Gm-Gg: ASbGnctsnl4yH9ZpCwxZmiPCYWF4W1hG1ok9gPFWdE9N9liVgT1n7Z2wG2FBoQvHrA2
	PDSUN5yLhg90PtlzRv9BU3/KAf2HSF0DYNN3esbA9tDBg+haJcQzLRlR5c4pbE7VBbuHB0JJAoX
	Z4V1+Ankj4Hp8XoGpjPBjCMtN9JzfApf3HTLwYFAoNqVv4AWGDraKhV8OLQLXkmpRsxmdKqalOQ
	1FJ/C9LHNdWL2WIyTlcSgD9MBzrRHBaBgKa/qqQj007ovS7d0AzINV4ZXDYwY5I+/Yq8Bq+0kbU
	4RbwXmaaYvfamMn9IcPGmS+NAnH84bKM6hfA5Hf2WKvBS9DaaQmH8soMIIgf1JY7NogFUFqUTmo
	+a6vY9U7YCRiF3Q==
X-Google-Smtp-Source: AGHT+IFp9sQ1O1Xp2dLCKaavs2hu3htqG1YN9GpJQQ4Goh4wOf920e7bF/mz3S7j9V2wFfuBpKvd8A==
X-Received: by 2002:a05:6102:3e08:b0:4c1:8928:cefb with SMTP id ada2fe7eead31-4c586fa84cbmr1680904137.12.1743017509221;
        Wed, 26 Mar 2025 12:31:49 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4c50bd75e84sm2497804137.20.2025.03.26.12.31.45
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 12:31:47 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 4/5] shared/att: Make bt_att_set_security never downgrade security level
Date: Wed, 26 Mar 2025 15:31:32 -0400
Message-ID: <20250326193133.2718934-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250326193133.2718934-1-luiz.dentz@gmail.com>
References: <20250326193133.2718934-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Requesting a lower security level than existing one shall result in no
operation since higher security satisfy a lower one and it is never a
good practice to allow downgrading security to begin with.
---
 src/shared/att.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/src/shared/att.c b/src/shared/att.c
index dabbdb4315eb..8657cb6423fb 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -727,7 +727,11 @@ static bool bt_att_chan_set_security(struct bt_att_chan *chan, int level)
 {
 	struct bt_security sec;
 
-	if (level == bt_att_chan_get_security(chan))
+	/* Check if security level has already been set, if the security level
+	 * is higher it shall satisfy the request since we never want to
+	 * downgrade security.
+	 */
+	if (level <= bt_att_chan_get_security(chan))
 		return true;
 
 	if (chan->type == BT_ATT_LOCAL) {
-- 
2.48.1

