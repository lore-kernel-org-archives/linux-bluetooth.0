Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A950727C866
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Feb 2026 20:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770669266; cv=none; b=htrNXKCd7ePFKarGbw2Hp+tI8NWG/bKHYyGQRsID1bO08Any+q1cdq+TkGpyADk5GCMrb4KomcFcRkF4fdE4ccJ6YqeV7f9xN0ppkFWxSCXPLmoRBykRKbyaYh+dYeVHXRAyNx2eXoQItWkkZu0zFqqza56lgxlDfqUMCG0uamM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770669266; c=relaxed/simple;
	bh=VBaZZtWZfBNVrKki/L1/thLjNnBZQMDh1fxkdbgYnq4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WCWE8MZSOCEqnSoYPqoNeE2k5r95sXsH2lSkAdZoEnj/OevLSRrB31fUjCprfZDpRWeoKNMJF6v6FGy7F1iDfqxx+UR/O69hBdb888ZHgt45egEj2a6iuwmnAyRk89dhGyJV3QJISwQjQSser26JXKgd2NIMIFEduSfbPzwUlD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 8BC8258128D
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Feb 2026 20:33:33 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5C48143859;
	Mon,  9 Feb 2026 20:33:25 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 1/2] shared/util: Add byte-swapping macros for constants
Date: Mon,  9 Feb 2026 21:33:12 +0100
Message-ID: <20260209203316.3050687-1-hadess@hadess.net>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleejjeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpeffteektdejuddvhfdtfedtvdetgeeileethfetgfdtheekvefgueeifffhvefhfeenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeelsgdvleemtggufeeimeeikehfugemtgdtleefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeelsgdvleemtggufeeimeeikehfugemtgdtleefpdhhvghlohepohhlihhmphhitgdpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhqihgupeehveegkedugeefkeehledpmhhouggvpehsmhhtphhouhhtpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehprghvsehikhhirdhfih
X-GND-State: clean
X-GND-Score: -100

We can't use functions to populate constants, so add new helpers for
the various __bswap_constant_XX macros available for that purpose.
---
 src/shared/util.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/src/shared/util.h b/src/shared/util.h
index c480351d6e9f..8683684831c5 100644
--- a/src/shared/util.h
+++ b/src/shared/util.h
@@ -29,12 +29,24 @@
 #define cpu_to_le16(val) (val)
 #define cpu_to_le32(val) (val)
 #define cpu_to_le64(val) (val)
+#define le16_constant_to_cpu(val) (val)
+#define le32_constant_to_cpu(val) (val)
+#define le64_constant_to_cpu(val) (val)
+#define cpu_constant_to_le16(val) (val)
+#define cpu_constant_to_le32(val) (val)
+#define cpu_constant_to_le64(val) (val)
 #define be16_to_cpu(val) bswap_16(val)
 #define be32_to_cpu(val) bswap_32(val)
 #define be64_to_cpu(val) bswap_64(val)
 #define cpu_to_be16(val) bswap_16(val)
 #define cpu_to_be32(val) bswap_32(val)
 #define cpu_to_be64(val) bswap_64(val)
+#define be16_constant_to_cpu(val) __bswap_constant_16(val)
+#define be32_constant_to_cpu(val) __bswap_constant_32(val)
+#define be64_constant_to_cpu(val) __bswap_constant_64(val)
+#define cpu_constant_to_be16(val) __bswap_constant_16(val)
+#define cpu_constant_to_be32(val) __bswap_constant_32(val)
+#define cpu_constant_to_be64(val) __bswap_constant_64(val)
 #elif __BYTE_ORDER == __BIG_ENDIAN
 #define le16_to_cpu(val) bswap_16(val)
 #define le32_to_cpu(val) bswap_32(val)
@@ -42,12 +54,24 @@
 #define cpu_to_le16(val) bswap_16(val)
 #define cpu_to_le32(val) bswap_32(val)
 #define cpu_to_le64(val) bswap_64(val)
+#define le16_constant_to_cpu(val) __bswap_constant_16(val)
+#define le32_constant_to_cpu(val) __bswap_constant_32(val)
+#define le64_constant_to_cpu(val) __bswap_constant_64(val)
+#define cpu_constant_to_le16(val) __bswap_constant_16(val)
+#define cpu_constant_to_le32(val) __bswap_constant_32(val)
+#define cpu_constant_to_le64(val) __bswap_constant_64(val)
 #define be16_to_cpu(val) (val)
 #define be32_to_cpu(val) (val)
 #define be64_to_cpu(val) (val)
 #define cpu_to_be16(val) (val)
 #define cpu_to_be32(val) (val)
 #define cpu_to_be64(val) (val)
+#define be16_constant_to_cpu(val) (val)
+#define be32_constant_to_cpu(val) (val)
+#define be64_constant_to_cpu(val) (val)
+#define cpu_constant_to_be16(val) (val)
+#define cpu_constant_to_be32(val) (val)
+#define cpu_constant_to_be64(val) (val)
 #else
 #error "Unknown byte order"
 #endif
-- 
2.52.0

