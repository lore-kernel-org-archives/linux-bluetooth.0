Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D3C41167E
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2026 16:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787849617; cv=none; b=UMQBdAgwO0eL9AOMkEimfulshzATbeKcRpkSqOl/ThZH9c7wi0HUEpKXbdFC9zZgeclJDTAb+6LDmC+SshoBR1ehIFB/5YNEeFPo24yHAeS/Qta9vQvM1kcrOy4mznoGuJMtV73o0XQet7rjNsmMJme++GgX1gmiaMHh8l89i1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787849617; c=relaxed/simple;
	bh=+51WsnDtmO1sHa8j5XH2djbvXqfmjUrONS4KdqT1o7k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ytvhn4ZTOL0DQJkXbwpc5QUv8nILncZ3dxWLVdH3rn17JoD4o97jBsL4wmG0NoMYRUw5+YfoYFecSJnOYP9YhjOKOhxXaAIy6PqXRU516eAUttW2T3ZMOnqu+pljVKMYHrOvqpCi/AcYy+ItxVip38dbzW6CGFXDRhB0TD5Cztk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Be1EOvh5; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Be1EOvh5"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5c2c46a428eso90524e0c.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2026 09:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787849614; x=1788454414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1w80tISnmgMNs+VBIEkhaHKDKwS/eqcG4KqJLmG75Hk=;
        b=Be1EOvh5RHi+FWl/y6quUY9y9kcsByjgoQi9f6uhU4C0hlxggrAThh7Sj3KrWFunWm
         1JGK1vJbogd2dqLydzHhVWsfebviOAzvLPBSb+cZ+J1YCPdfAJZ2j2lwW5sdwba1tUJV
         +liTIFpW2ZYnLzmSz4DSxQm00XFkAq3D0Q+3qbt5iq2//6UHMMPcMmlzjGHxncSALJVF
         rMmI9ofgvWBOIx9cQhHCwe3Kre3y9TiczIWMYCyd9n0G1pdxGkCXLoa2zkBD3O1st8Yp
         idW7wMLOF3UJtSJq8pKM+StzcN1hu9uDB04aTWW97G68LaodGCrnxOZAqAGhqnIvMgCx
         yxKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787849614; x=1788454414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=1w80tISnmgMNs+VBIEkhaHKDKwS/eqcG4KqJLmG75Hk=;
        b=MnmMjTlE+DmXW5Uk4UkVhKnzLocvwfPaJJYbykyFsL71lgKQmJjOnR4xI0K3rSEmUD
         8yjM0NcFKP2De2EoPWFZNf1hADqhFusUVW1W/RQ2qVUXnSJ+x+Rargdx7mwPey8TL4Xz
         2kZ6BKB0GZ0VyGA5L2PNcgc9C/RGf5QM6wo2HDij+5iIyox5g6CY9qyL70gbbVmDX/C3
         6JIFaJHsFkcVKrI4nJ2apBM81sbG7wj/bcpx9f4RWQ6mpAEIWCVR8XiK/iuO4HMGu0MP
         luGyZRfl68mPiTUO1VFcAadodf5fFA/eNsuBCADyJp6bXbaY8SGYQfIkY4pOy0UPY+hv
         6nxw==
X-Gm-Message-State: AFuF++klMuDPR9BmFehjqJGtmFPwtN3d5ubHnJv1CMmVB6Nf0XUnrU96
	51PrSgF51uyNwx5H94cuozxEl/v8vdW7jCjvtyOS4NCw9+SiBz8yPwxeQJ5cF97i
X-Gm-Gg: AR+sD12T/+fbglHsibZaYNwj8gSd8L9kw8QZs/aTM9Vxv6cWQYby3XcVuRyMwcKgKgf
	hBRqNnudi7MIKai5Shftijs6L4f9ON71JvA/f3HuX2m5rzK9JimpW2cfj+ioJyq+YN/YJvGQ06k
	DWCCDAk5uyf/mUdJH5/C07o1TnUa0AXoV0HBdHQTIFOAzk24xjJdsEt6+w6ecbOGE3S87JyD1gn
	n2hnHBTvgJvY2ws0OVda9YI+Ys7VM32JErdpXixxh05WjmYbxMgLKfna/RY71R6ikfGSojTMaKX
	3/a7QkQBzRz43I2OZuO7rBUR9ieArS8l/baTKP/7i4+/p142Hx6Kzk8TWd/4K2d2y+o9gMfREVc
	S2Xz8szrG8/HJeeEK8G749bs803F3h00zW5e31n+TwXxVsj234D8q53VRt00NtiudaI044VXwOU
	JDKVgby+O/LrPPMCLWAN5QxdeyiAs+ZHlz9zQff/32iOA8T09tDXo7+B1vKTtRMy1oD46m5JJ7Q
	DjSyA5B98v+uZ4J6V1ge/K7P9KErR3GRAp0d59mN4Ed77dtt9GlkdI=
X-Received: by 2002:a05:6122:6c13:b0:5c2:cffc:2c55 with SMTP id 71dfb90a1353d-5c680eea11bmr244740e0c.0.1787849614375;
        Thu, 27 Aug 2026 09:53:34 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c6600aeabcsm4155489e0c.17.2026.08.27.09.53.33
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 09:53:33 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ vRFC 2/4] monitor: Add latency standard deviation
Date: Thu, 27 Aug 2026 12:53:24 -0400
Message-ID: <20260827165326.350079-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260827165326.350079-1-luiz.dentz@gmail.com>
References: <20260827165326.350079-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The latency range and moving average alone do not tell a link that is
consistently slow apart from one that is unstable. A high average with a
low deviation points at the scheduling or the interval configuration,
while a low average with a high deviation points at interference,
retransmissions or controller buffer stalls.

Track the sample count along with the sum and the sum of the squares in
struct packet_latency, and report the resulting standard deviation on
the latency lines of both the live decoding and the analyze mode.

The samples are squared in usec and only scaled down to msec^2
afterwards, so that the sub-msec resolution is not lost while the
running sum stays clear of an overflow.

The model derived the accumulator layout and the scaling, which the
author reviewed and verified against an independently computed
deviation.

Assisted-by: opencode:claude-opus-5
---
 Makefile.tools    |  2 +-
 monitor/analyze.c |  6 ++++--
 monitor/packet.c  | 41 +++++++++++++++++++++++++++++++++++++++--
 monitor/packet.h  |  4 ++++
 4 files changed, 48 insertions(+), 5 deletions(-)

diff --git a/Makefile.tools b/Makefile.tools
index b3ef4ae1c3df..8f9ffe97cbf0 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -62,7 +62,7 @@ monitor_btmon_SOURCES = monitor/main.c monitor/bt.h \
 				src/settings.h src/settings.c
 monitor_btmon_LDADD = lib/libbluetooth-internal.la \
 				src/libshared-mainloop.la \
-				$(GLIB_LIBS) $(UDEV_LIBS) -ldl
+				$(GLIB_LIBS) $(UDEV_LIBS) -ldl -lm
 
 if MANPAGES
 man_MANS += doc/btmon.1
diff --git a/monitor/analyze.c b/monitor/analyze.c
index de9c23603a21..b349887716da 100644
--- a/monitor/analyze.c
+++ b/monitor/analyze.c
@@ -155,10 +155,12 @@ static void print_stats(struct hci_stats *stats, const char *label)
 		return;
 
 	print_field("%s packets: %zu/%zu", label, stats->num, stats->num_comp);
-	print_field("%s Latency: %lld-%lld msec (~%lld msec)", label,
+	print_field("%s Latency: %lld-%lld msec (~%lld msec +/- %lld msec)",
+			label,
 			TV_MSEC(stats->latency.min),
 			TV_MSEC(stats->latency.max),
-			TV_MSEC(stats->latency.med));
+			TV_MSEC(stats->latency.med),
+			packet_latency_stddev(&stats->latency));
 	print_field("%s size: %u-%u octets (~%zd octets)", label,
 			stats->min, stats->max, stats->bytes / stats->num);
 
diff --git a/monitor/packet.c b/monitor/packet.c
index 0d3b23cc3fb7..174d844c05cb 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -27,6 +27,7 @@
 #include <sys/time.h>
 #include <sys/socket.h>
 #include <limits.h>
+#include <math.h>
 
 #include "bluetooth/bluetooth.h"
 #include "bluetooth/uuid.h"
@@ -11524,8 +11525,27 @@ static void role_change_evt(struct timeval *tv, uint16_t index,
 
 void packet_latency_add(struct packet_latency *latency, struct timeval *delta)
 {
+	uint64_t usec;
+
 	timeradd(&latency->total, delta, &latency->total);
 
+	/*
+	 * Negative deltas are the result of out of order timestamps and
+	 * would only skew the deviation, so leave them out.
+	 */
+	if (delta->tv_sec >= 0 && delta->tv_usec >= 0) {
+		usec = (uint64_t)delta->tv_sec * 1000000 + delta->tv_usec;
+
+		latency->count++;
+		latency->sum_usec += usec;
+		/*
+		 * Square first and scale down to msec^2 afterwards so the
+		 * sub-msec resolution is not lost, while keeping the running
+		 * sum well clear of an overflow.
+		 */
+		latency->sum_sq_msec += (usec * usec) / 1000000;
+	}
+
 	if ((!timerisset(&latency->min) || timercmp(delta, &latency->min, <))
 				&& delta->tv_sec >= 0 && delta->tv_usec >= 0)
 		latency->min = *delta;
@@ -11553,6 +11573,21 @@ void packet_latency_add(struct packet_latency *latency, struct timeval *delta)
 		latency->med = *delta;
 }
 
+long long packet_latency_stddev(const struct packet_latency *latency)
+{
+	double mean, var;
+
+	if (latency->count < 2)
+		return 0;
+
+	mean = (double)latency->sum_usec / latency->count / 1000;
+	var = (double)latency->sum_sq_msec / latency->count - mean * mean;
+	if (var <= 0)
+		return 0;
+
+	return (long long)sqrt(var);
+}
+
 static void packet_dequeue_tx(struct timeval *tv, uint16_t handle)
 {
 	struct packet_conn_data *conn;
@@ -11585,10 +11620,12 @@ static void packet_dequeue_tx(struct timeval *tv, uint16_t handle)
 	if (TV_MSEC(delta)) {
 		print_field("#%zu: len %zu (%lld Kb/s)", frame->num, frame->len,
 				frame->len * 8 / TV_MSEC(delta));
-		print_field("Latency: %lld msec (%lld-%lld msec ~%lld msec)",
+		print_field("Latency: %lld msec (%lld-%lld msec ~%lld msec "
+				"+/- %lld msec)",
 				TV_MSEC(delta), TV_MSEC(conn->tx_l.min),
 				TV_MSEC(conn->tx_l.max),
-				TV_MSEC(conn->tx_l.med));
+				TV_MSEC(conn->tx_l.med),
+				packet_latency_stddev(&conn->tx_l));
 	}
 
 	l2cap_dequeue_frame(&delta, conn);
diff --git a/monitor/packet.h b/monitor/packet.h
index 73a86f64b242..6b792c0e420c 100644
--- a/monitor/packet.h
+++ b/monitor/packet.h
@@ -31,6 +31,9 @@ struct packet_latency {
 	struct timeval min;
 	struct timeval max;
 	struct timeval med;
+	uint64_t count;
+	uint64_t sum_usec;	/* Sum of samples, in usec */
+	uint64_t sum_sq_msec;	/* Sum of squared samples, in msec^2 */
 };
 
 struct packet_frame {
@@ -69,6 +72,7 @@ struct packet_conn_data {
 
 struct packet_conn_data *packet_get_conn_data(uint16_t handle);
 void packet_latency_add(struct packet_latency *latency, struct timeval *delta);
+long long packet_latency_stddev(const struct packet_latency *latency);
 
 bool packet_has_filter(unsigned long filter);
 void packet_set_filter(unsigned long filter);
-- 
2.54.0

