Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D494364EB0
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 11:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778499328; cv=none; b=EhaWxQ76a7y84f3cUHyjavXwrnu4ixRnTC710AOo1VJEAC+9XT4XCkU/boH0+tOHn0MhqfXz9AaDJBKo+8j6HrEQNJyAhkFUnDK/mq/i2zFoFCHlGTagX5uRT6D2tUZnvItfporwl3n+ridk921JxHgTDMAbKvis4F0dMrUYxWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778499328; c=relaxed/simple;
	bh=PCMdQgnEhNMhWBL5x6QD3MT2XkhN62QrR01VDjhZZjA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=t2E/NUltCb0mfGh6IilqjyQpl0m9VsarAw02fV0oVso/Gk9+9Aib4N4VlNNANdHCQsdTreEHyCwHQ/Bp05VQ8N9CJpzi6mf6Dd37P03RqLRkrHUjqa9kfi1x8BlbAJNfoKxV0/IuEGVQ2WAhZzUAZeq8PpLSY4BNB4IsH6hgr78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8F9053EB8F
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 11:35:19 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ 1/3] mesh: Remove unused but set variable
Date: Mon, 11 May 2026 13:35:05 +0200
Message-ID: <20260511113511.1217887-1-hadess@hadess.net>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: dmFkZTFvRi0MivabkavrO/3CKE0bdDyMX2/KwKKfCC2rekfTVkej5F+6Y4qNWLLiffyAGvxkHzgyjRkZUUsv4miDhIIVJMfeZ+xGFmVxEbOu8MuyKeUMYK+4pMBmj063k/d8FuJ9ra435GhSbUgxTBXZdG5lmhKU1/KOAAT+/0eCAO7NY8Ymxiv1j95YeEdNG8C5CxFttJPoyBaIdvpsUULBKbXvLEfuAE16OUNsqpsccdIif6y/fCkQ8WHkDWlYbRJjqICKhPJh9sxFh3JHWuw44MioVIV9sld4k4IwYHKbGWkIII1EmT8DXf1WXTAKzu3Bltz6vJYSmzVmFzI4BgUY58LMaZRQeKNkCChqhgOV5k1Zs8FJei3hb/D/nIyulKIDK+qBQn+JTnd9NT25xXMnlRWSyVhqKxNDzsZuykV9PfIQR53dbvtrdhgDOlBR4xZvk2zB9tOeoT9LRCm1EJVYPIZxi6OlagS/gz6Y1xQUvz+IvvDoQ2l8eynohVMwk5Kn6X14wWqlX8HzCI7SiFtXhHXwFUzgtizHHJgvoseGD9hc/MI0/MDgwDsR2qhG8jImqNneQM7dTKuu1SIZZ1YvweuSSub14Ka84sS1pdiQCYODzURoY47vmgyCCOVoLJDxGSOu4mn5PbavGpFXKSLO6dQK8bDbx44nJcCdb+tOicqZ7w

We played around with the bits, but didn't do anything with it.

mesh/net.c: In function ‘ack_received’:
mesh/net.c:1569:18: error: variable ‘ack_copy’ set but not used [-Werror=unused-but-set-variable=]
 1569 |         uint32_t ack_copy = ack_flag;
      |                  ^~~~~~~~
---
 mesh/net.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/mesh/net.c b/mesh/net.c
index b29e24f5d4a9..2c1be1f2cc63 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -1566,7 +1566,6 @@ static void ack_received(struct mesh_net *net, bool timeout,
 {
 	struct mesh_sar *outgoing;
 	uint32_t seg_flag = 0x00000001;
-	uint32_t ack_copy = ack_flag;
 	uint16_t i;
 
 	l_debug("ACK Rxed (%x) (to:%d): %8.8x", seq0, timeout, ack_flag);
@@ -1599,8 +1598,6 @@ static void ack_received(struct mesh_net *net, bool timeout,
 
 	outgoing->last_nak |= ack_flag;
 
-	ack_copy &= outgoing->flags;
-
 	for (i = 0; i <= SEG_MAX(true, outgoing->len); i++, seg_flag <<= 1) {
 		if (seg_flag & ack_flag) {
 			l_debug("Skipping Seg %d of %d",
@@ -1608,8 +1605,6 @@ static void ack_received(struct mesh_net *net, bool timeout,
 			continue;
 		}
 
-		ack_copy |= seg_flag;
-
 		l_debug("Resend Seg %d net:%p dst:%x app_idx:%3.3x",
 				i, net, outgoing->remote, outgoing->app_idx);
 
-- 
2.54.0

