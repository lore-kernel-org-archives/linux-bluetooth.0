Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13F012FF86
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Mar 2024 17:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709830876; cv=none; b=YyNlnxPt+vC/8ouzCSiSFcrm9tHNRg1McJdkHcW1eRH2rLftOrPSCAIEKhkNNiEJQAYU4Jgq2SJ8WMUzhBcFVUq6R1L/9pU8ZgY8MWN0BEy7utS7oFV/SgaISmAtuylxeltMbMND0zPasHuZvr4xx306+vQWU5yGAkLKM+rIeoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709830876; c=relaxed/simple;
	bh=GdY0aq29e/r1IjTwX3a32aQDvmZFpdy2FUznLXj7Rcw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=fsVNlrsdexpBFZQGTHhaShXjCxNnmnMmVgm0nDvVdVJQXzqWYPJOASiLlFmb+XAus496AcF8EV0AFevKOzPV5firgu2jecKbxDSQQ5rhuR/jA9wihjKTDeYwkCmEhZ0/OvRuvHVJ7CLbXSdU4WMg8NCh9t5y8mGI/lqostthMik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fSns0e4W; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fSns0e4W"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-7dae66def19so565915241.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 Mar 2024 09:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709830872; x=1710435672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q8nrs+sqbjTUno3Gmy9RVGvmMPDqcLRi6BJsFAiMcC4=;
        b=fSns0e4WbIAbKab4sNyaXLQgXIpFrJNV1m0leHFtB7m8a+FvBx+oNUOYkIm0f0isBN
         4NeZ/AYv/ODQqresX8cXoDbPNoANJmyceyPTA04iW7QTk+xcn2JZPAWdru70s21l5ICc
         atYTLojviBcGK7MEirHGZbA+AbrzX58m/2RM9KhprbSOHayktTDGp/Likty6at/+jGq3
         nTs7CtE7mWzbBn4OuNMvvfoKdf5ENmfl1LWAPau2i8lY74XJtD+frdvj6AvdJyGQDeZz
         Bdyh7dtVpIOTfQ/t3K/KTJyfPxG7j6M61TfuoY2LeSa9gZBsmMM0IKDnP/Bq+3XO9HEK
         oPqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709830872; x=1710435672;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q8nrs+sqbjTUno3Gmy9RVGvmMPDqcLRi6BJsFAiMcC4=;
        b=iTjwK5wJYQ9noUmD45yj57wKkZR9hkp16xp7cAQOac1j182kwsIQnnwa3LwDTXbAHE
         IBllW7nTM0HlMQ6LaMMSmL/XifEsSWJhLz4r2BYMIXV5V0DTa0FWqQN+rf/E7NnhxzPv
         wHkPvcyts+ayrGFMQHUxNBYnIf2Sm3AcYIifAVgqJp6cSJ5Ns72DmJ8wRnRnisGtxGIV
         gUl6295rjpHXZ0pQ7M0suiKxJsVgdyqn/Y4uUqTmU/z5QrXZgAVWLDf+pFh9wdFO9/OC
         JyzOoIMDqlnAln2zqq3LLz7MtBzpd9jg/NP2SxA/ngAJUfpE49NsGVO82y5+DqAMTmVt
         Nk2A==
X-Gm-Message-State: AOJu0YxoBETeJxUVeSrVvevEMBhzH8P7x+6UT4AZGYJe79fCNzo8mZve
	yG4EnrSr1T923L3hU7zloKn7RRDUoAmVGz4yyxdzbwwmr34d7LR3bAq9yXxA
X-Google-Smtp-Source: AGHT+IG2ZnQ9QhQzR4RrVIi5UwH7OWMq7qqpltGD5wHFd6gNNja3cYpjlkdJBHqAtUHew8GhwkSrIg==
X-Received: by 2002:a67:efc7:0:b0:471:e1ad:39f5 with SMTP id s7-20020a67efc7000000b00471e1ad39f5mr7610067vsp.25.1709830872370;
        Thu, 07 Mar 2024 09:01:12 -0800 (PST)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id hx3-20020a67e783000000b0047254aee7cfsm2666218vsb.10.2024.03.07.09.01.11
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 09:01:11 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: ISO: Align broadcast sync_timeout with connection timeout
Date: Thu,  7 Mar 2024 12:01:10 -0500
Message-ID: <20240307170110.4096559-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This aligns broadcast sync_timeout with existing connection timeouts
which are 20 seconds long.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/bluetooth.h | 2 ++
 net/bluetooth/iso.c               | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 7ffa8c192c3f..9fe95a22abeb 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -164,6 +164,8 @@ struct bt_voice {
 #define BT_ISO_QOS_BIG_UNSET	0xff
 #define BT_ISO_QOS_BIS_UNSET	0xff
 
+#define BT_ISO_SYNC_TIMEOUT	0x07d0 /* 20 secs */
+
 struct bt_iso_io_qos {
 	__u32 interval;
 	__u16 latency;
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 8af75d37b14c..c8793e57f4b5 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -834,10 +834,10 @@ static struct bt_iso_qos default_qos = {
 		.bcode			= {0x00},
 		.options		= 0x00,
 		.skip			= 0x0000,
-		.sync_timeout		= 0x4000,
+		.sync_timeout		= BT_ISO_SYNC_TIMEOUT,
 		.sync_cte_type		= 0x00,
 		.mse			= 0x00,
-		.timeout		= 0x4000,
+		.timeout		= BT_ISO_SYNC_TIMEOUT,
 	},
 };
 
-- 
2.43.0

