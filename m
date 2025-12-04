Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D35303A1E
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Dec 2025 18:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764873091; cv=none; b=dSol65cjrUpv9ecc2I7QFYWJ8kJMni8eBxg20GJ1h4OBs2/b1rHRFM566sOM5LObBT/cy/DIuPEbn7Dumizt4LtdRTgc8Zf0r18kUg80dLrwmkBwhL/E/4a0m4cG7j70e0PflAndaW5iDJvGIF1FdObeGStM9q1KINkcDXRoFd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764873091; c=relaxed/simple;
	bh=4KPS+SZZgCoSZfJD6mLF8JKu4hAMmi74vm5a8whuhPY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=YT/2n6tbnpYtcAeD3Vbx84+z298vALGg3P5ilK1URIf4agzXZO7zTpJdDomhq9fHMpp3J7b8uHehvQUAmMb37xL/EjRBGDqUPuycZ0ZXh7719XmpFRByqf/fcmLgrm2dp2RgZDbZjpMbYBzCv39pdaxMd+s95+SLKYNU4nq3zGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YtPqmUi2; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YtPqmUi2"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-5e1fde1f014so442177137.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Dec 2025 10:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764873086; x=1765477886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=HiVdosadHPruLwP7lVNJdadU5vME/dj4suQ0pRHX6V0=;
        b=YtPqmUi2EI5kWpbIou+tIfexB+id1ncR2Kjk6WTY62pOKybLXX9gMNpE9EZ2HD0/zK
         kBl5TY0LI5Hoo98ajoTYkXWzJlCgmJiXk74fjzfxI1er2Bo88bRiBBVY3DQswu4XDzqk
         oG5r0rISjxb8dsMuaz/rsn5Xaj0R7uaNXfz2UnL8R+el7s113ZzPryKxKVtm7A/wf/cQ
         o6DJMuLZfpwwOCutzltPmZkI+stddjdoq5mxpIVH40cVrSsy0mSlCM9eFsg8gpmaL2Cx
         a0sp6KTXMWdEez9cDsn/Y1xTLDulXTIdXl8gk+V3nbysgjStUIlWQosfQsQwQj771F03
         DOng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764873086; x=1765477886;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HiVdosadHPruLwP7lVNJdadU5vME/dj4suQ0pRHX6V0=;
        b=eJTiYFRHuZtACf/DQfCSDA5tR1+F9r7ultglsNOOsMDJepB5ZfnkLdTfYp62o3pMwM
         oUPPCYBigYvu1SY0n41hz7XWlfZ1ILjewyyQY3YPDlhLuqjDv1UqIKGr94ythHjQZ1XT
         vaBesWKhc0L8zjn/YJ9LI11A5StLLltPz7qhuGLUERmAfdh//KxA4h5+60iB7CdbpGMB
         znW5ZprzaOGN7OwQqOBzyCm6B0WqLVyGr2uJCnCybXNEIKrwu0qhdSI1NezX2kHk0Bxz
         YRjRGPZnQKrTsPkGzRWUpvXi31ZUvja7dQkY642kgIrwpuhC3b37ZY4VQ7fK1GSbJ5W9
         e6oA==
X-Gm-Message-State: AOJu0YxVjbWMiitgmL6R9OiUKfohbVbKToJtqqSaEaaitjtVXbDNx5n0
	B238ZVS6mkiJN2AOaU4O9g3N8jySP5+b0T5njHDrnSzYm2t3ZKHHImq4YSoVKA==
X-Gm-Gg: ASbGncsChP1qmui7tAlyGXhemmukmlRDNQkbzcq7K03XhSUnaIdL8Kz7Vua8CoU/R7f
	d1IDlHuOuS9JRBIH0wnXtVqCufp+mH50VIKrCppcO5LpqYYBiwOF3IWGMb9ciceeuLuoH9Nzn3X
	h614VqqbfLSOsaz55R3nZpEmbbAiOX5sOTmCIp9i/XF2NYfhszb2Zp5fMIN0zm/Fc2fMnvJMvEF
	jN87RdXXOqrgIKqhe4DTd7UsiNWY8CQVfrEtbGuWFdJaEI3cPmJ5S24Y1U845Rn6PgHTsXiH7cr
	qIS92X6Jgk1b+TasYhO7qSGj2535hnTIURDF7Appwt9pRw1jKuDgv1QQOqAtB9ZYYs3joMBXdHe
	eu0B6va3yHGUYXcnKxUmq1X3+N64BZO3LKDr/iAPHbAi4fxefcwyGoBixofRFajk4RoKnvP1X0r
	sY98hjaepdmR6OmA==
X-Google-Smtp-Source: AGHT+IE344dvWt8ftgtXWiypzNx3vNS/gU9uKsgoMoBXGg/ip7afVs35n6wo8sr6PcEYoaFd2yeQBg==
X-Received: by 2002:a67:e704:0:b0:5de:6dc:22be with SMTP id ada2fe7eead31-5e48e38dde5mr2627230137.36.1764873085672;
        Thu, 04 Dec 2025 10:31:25 -0800 (PST)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5e510808c63sm1009520137.7.2025.12.04.10.31.23
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 10:31:24 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/2] bass: Fix attaching to unicast session
Date: Thu,  4 Dec 2025 13:31:14 -0500
Message-ID: <20251204183115.2533504-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This attempst to check if bt_bap session is attached to an ATT channel
then it shall be considered an unicast session not a broadcast session.
---
 profiles/audio/bass.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/profiles/audio/bass.c b/profiles/audio/bass.c
index 8886a27d99b6..20c37323bb0e 100644
--- a/profiles/audio/bass.c
+++ b/profiles/audio/bass.c
@@ -1298,6 +1298,10 @@ static void bap_bc_attached(struct bt_bap *bap, void *user_data)
 	struct btd_adapter *adapter;
 	struct bass_data *data;
 
+	/* Only handle broadcast session */
+	if (bt_bap_get_att(bap))
+		return;
+
 	DBG("%p", bap);
 
 	db = btd_gatt_database_get(bt_bap_get_db(bap, false));
-- 
2.52.0

