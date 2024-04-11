Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AA1137907
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Apr 2024 18:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712858847; cv=none; b=fNw98GV8s6ncdwTRjfx3AThjqTRLmQKOR5b8kMbPl6TQ0UKa6BUYPJ4JTT3+Ay07VNjWeewuK0dpu+dTFv7ytklNeW0CmYaaifxAgxEj7Xe5gZPD+H9r9oR/eu4vyCZueeAGY4KAWhP1ZLKVdynD83dMycWOALiG6RoBgFYHf7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712858847; c=relaxed/simple;
	bh=2zd2aErHG1lZPkrmYGGNWy8rR9E2GG4suFCJDjI8SaE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ZjdW1XD4cPu0wQOaJPqhKHbPVzVZ0J4pwP1suLb+2gBeaUorUA3DPAWJ1J4xvRHOs/roccnqQefn5z8FAe4JI6JXD0TAaP2adyPdFiN7XpSjyIkeC2ZNA+B2qfgky5SqKvlVDWXDWGt1H+DR5AFea7OixNC3ysrGvPxNFxAolY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b8cWJwUY; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b8cWJwUY"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3c5ee27c2ddso14592b6e.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Apr 2024 11:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712858844; x=1713463644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+hANOqpWi5mccCXObOolBPcIhoSeVd6fCezYfr1BhRY=;
        b=b8cWJwUYD5WwBqA5gFJxn+X37BOLSlXMlp7ZON7lLVgzTj9fPUIXJFk48+7YTm0Mwx
         tRLYsgjbolBwLGsW1fTrGzSm6aZEKfFBdQEYlY9j6aVhv39Cja7Jf07COV7I0qsjGw09
         mlXN1I/ZgQzpcqeaOrL4QBayfZgn/GIHAB6rAznsjME9vdI0/l3i8MqyrXir9dN26+4c
         Z1cWw2mUKfCtiW0JnXS5bUgByzadtaSSXHR7Jtm4M9Zo4tQPY1EZswtRoERFLSd8wIkD
         IQGkZIdFnTnvncqLSr804qxxoSLbHeKjuA0muLk2A1HCprfQm+CkdjX2rd6evjn73ay4
         BxIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712858844; x=1713463644;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+hANOqpWi5mccCXObOolBPcIhoSeVd6fCezYfr1BhRY=;
        b=gdzzVJnCIXNkCiXTosgNlMirORcpyG9m2RccgG4DpyKTD334yDrk/wQSh5N9HNPs4R
         cf3duNBf4SeipYbaWr8RRkogRzGIhCmvI/SjUt7bVoLe9IZlEV4gH212xg2RGizhKvWT
         UKA99msIu19op6d4ZjPpZpsQWWQiRySI7VIoMUBYLL2n1OXP94zF5my3vBW9FevD34MW
         mChXiBCJACSctIDaGSeObgQnwc3yBBYH0e4Rw9jEXm9p/Y7e9K/VekAXMjnP6DKtexOU
         sccnBZTBtg52GaiFEft9Fuk+z1ZhxcEi0cNgWpC9tFQwdnjWL9rU0j4yorN7ysHIBWJQ
         2T0w==
X-Gm-Message-State: AOJu0Yyo057PipYSsvJAOrAaLDDv1WLF8guQSpIyT4+NAxUMPjZPzTtZ
	rJxSX2oHz1/lca9xI3msweoyVfoSWoJV9S0RvSggA2QEBEvnu3mbLfrGPg==
X-Google-Smtp-Source: AGHT+IHvwwQM3TUNZpn9xs7gRqUUi84Z97/TbDSZ/C4ZrplxV8z6sX8fql4z7h32v37ZcYufHFdeiw==
X-Received: by 2002:aca:1107:0:b0:3c5:e03a:8f51 with SMTP id 7-20020aca1107000000b003c5e03a8f51mr330427oir.48.1712858843986;
        Thu, 11 Apr 2024 11:07:23 -0700 (PDT)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id z4-20020ab02244000000b007e7b2f8e0b5sm225711uan.13.2024.04.11.11.07.22
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 11:07:22 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 1/3] shared/bap: Fix not updating location
Date: Thu, 11 Apr 2024 14:07:19 -0400
Message-ID: <20240411180721.157181-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Fix not updating map.location when selecting.
---
 src/shared/bap.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index f553096dfcc6..b452461ac715 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -5163,12 +5163,10 @@ int bt_bap_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
 
 			/* Check if there are any channels left to select */
 			map.count &= ~(map.count & rc->count);
-			if (!map.count)
-				break;
-
 			/* Check if there are any locations left to select */
 			map.location &= ~(map.location & rc->location);
-			if (!map.location)
+
+			if (!map.count || !map.location)
 				break;
 
 			/* Check if device require AC*(i) settings */
-- 
2.44.0

