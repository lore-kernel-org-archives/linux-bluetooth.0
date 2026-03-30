Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF20328466C
	for <linux-bluetooth@vger.kernel.org>; Mon, 30 Mar 2026 14:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774881059; cv=none; b=Ph7pkZKkwHjpAoS1l2jIheOA1yCUIAxXh5bw7lMNs2FoikAKkL2XnEJwVGQpgQNKHkkP7P6vpVa2gGioKwUekEPjI7MdsbvhrM3bB68tsXTwQ5UJked0TkR679+LENb2TDdim4GM9lW9ClgLIy6kiB2wX9ahG8lHCy1S668Kj6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774881059; c=relaxed/simple;
	bh=1UshCuMi3AYytMT42n/6G0Radm9wKsFMkmKJCz7E+xU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=MuSf5cwSTFvrFYFZHyA8huA0yXJDUQXfMGr0zaXDOu5qEPaziPVmUUdrQH+DZtKvbnvC6UnXMifGF94Guzrz55fpQ+jbrxqFUdXIM5rrS2zHBsz2Op3E+oL6j+OSmUuiF5Qusdk+YT3TKDdhjwmgWEatVe51uwngrZGkBOIu9ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 202C63EC29
	for <linux-bluetooth@vger.kernel.org>; Mon, 30 Mar 2026 14:30:55 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] shared/util: Add MIN/MAX implementations
Date: Mon, 30 Mar 2026 16:30:36 +0200
Message-ID: <20260330143046.3497403-1-hadess@hadess.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Cause: dmFkZTF3MlKGTBplesi88wQZKDo5R0eKBg2vbgItD3Es5/YvJ4KOwDe4Boz/O6N9WUSUaB6/p5dZhZvNAc0keFg46j1GymQoYY52RX7P6oJRvfi70Tqkw8vFbj31GceAlq5LRaiWEtkGmGqAiYH+OAJdpLhSxi/ocskoSTuNhEcCKa1QKieMnUtoaxV/vPUEb0OuwesKVwjDMHJfgHkzdPcRerZ56LLFvGmGPyRSFM4YTBxNus0stV3Re+BOfRUO2app5sKv5w1VryW+LxEDP1FvqKzKdiXV0KVovLgUojVUesE8KrNWmZfGixybQhTvUS7TvEorgeg5Azcs++OJmJXDAyipSA9oXvMo8J5t12bvYGAZ5jZsiVDB+GSSeBMI8Vk8cFhLSuRq6i+SJrnNfQ91X5nNG5tpFtAV5q2f6GPwCBcb3gVxmBcnCmb3QdBANBiSrnoWbRbw/nNDMfgShNFkP7/cVQp8glI7ZnpT3u9O8iZCvgNaIX0NqI+TtUjgbCi3alw0kmWyxRyhL61oQqJtqDoOKsS601QC7CuKtQNj2P7jZhEvx3q9HU7Nx3eMdEkyZi7+/MgwSGmzYne6Na2paqO6Af7QRp8V4o7LQkKFjaCH2AqrGU0ZDbzUf9yKKZdetQV4mJF2xGU9tQoG3bVtxhtJ4TeeJcsrAmfNvKEwrdIO4A
X-GND-State: clean
X-GND-Score: 0

And remove it from src/sdpd-request.c to avoid a redefinition warning
at compile-time.
---
 src/sdpd-request.c | 2 --
 src/shared/util.h  | 6 ++++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/src/sdpd-request.c b/src/sdpd-request.c
index 1fc07e97bfe0..7c632c2aaf62 100644
--- a/src/sdpd-request.c
+++ b/src/sdpd-request.c
@@ -40,8 +40,6 @@ typedef struct {
 
 #define SDP_CONT_STATE_SIZE (sizeof(uint8_t) + sizeof(sdp_cont_state_t))
 
-#define MIN(x, y) ((x) < (y)) ? (x): (y)
-
 typedef struct sdp_cont_info sdp_cont_info_t;
 
 struct sdp_cont_info {
diff --git a/src/shared/util.h b/src/shared/util.h
index c480351d6e9f..99a5aa2daf32 100644
--- a/src/shared/util.h
+++ b/src/shared/util.h
@@ -22,6 +22,12 @@
 #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
 #define BIT(n)  (1 << (n))
 
+#undef MIN
+#define MIN(a, b) ((a) > (b) ? (a) : (b))
+
+#undef MAX
+#define MAX(a, b) ((a) < (b) ? (a) : (b))
+
 #if __BYTE_ORDER == __LITTLE_ENDIAN
 #define le16_to_cpu(val) (val)
 #define le32_to_cpu(val) (val)
-- 
2.53.0

