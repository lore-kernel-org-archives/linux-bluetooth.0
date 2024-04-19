Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEF312BE93
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Apr 2024 20:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713558228; cv=none; b=rg6Ru0+vvMLnZH4jM8ueaK4X7I0zzF1zkzFdN5WrW2JGoZUvF5PeGPprvpPIeN9IFw0ZVKAMa5d950T4+/JzNumsOhXDH8PzcVUyzlCCLaN77DTRMuDfdaLo3Zhengq7eeHYKRZSv+CNUO2AsatwE3JhQKHRe3ezONkk0L251NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713558228; c=relaxed/simple;
	bh=yuUE75OBmec4Ehvw78aZRx58MHJWs2pBJgtDeL1g8PI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XP4ffvjdgzjkrwWSzkM1psPRpzBVEJi7Fj/xkS49QQ9ioNVZJTbEMb2zLhBZcrPnF9ACzxQ5+J+VwcclgBpR4v4kkHlJLi1i2y9BypjlTgCAxV8dRSMr49vYYWwTYFB2KmYe1dM+bqAuMdpC1kv9AEe3tRZ8qb2U/2un6MR7Sh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=czuu4qQ6; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="czuu4qQ6"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-4dcceac3ae1so762483e0c.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Apr 2024 13:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713558225; x=1714163025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mxk7W+/13YVXMokNPGV0pgKi7UgZ2RJlF54G65r32QA=;
        b=czuu4qQ6abSZb2nmaQ+hp6mA7jzZj8fEDir9vWZFkZeaLUGG9WnHlWXK6yfwcM5Q/M
         UMvhZswMWnqLe1NljMui6dCUt6PuiQ+HoVD3dXEEwByHy10gJbnV3YxTqwCSI9r+0HV+
         8dSZfm7UrcNC0Ps8NsjxoF3KjOgzbQwHEbENTID+E0KVh7affyeQVMxXT0EUvvj6Tk6b
         fUiL2b+Fg7uA5bxA9LjjQ89fy9qFo3fOZpxawIRxguLi+A5ZneBuGwmuZg5tFJjv+5Rg
         +qbkFU0/sKNA1xhyG+/57Rnjbc1Fprkip3U8zz7WOkeEibgtt/6r3gxftywPofnGro4+
         EfiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713558225; x=1714163025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mxk7W+/13YVXMokNPGV0pgKi7UgZ2RJlF54G65r32QA=;
        b=CR+IzQOMkmHje1l1GauwY4t3cFigkM+E8UE0M52U+9o6xHb/molpgqUzkGo02spRNL
         WqqdqfyqI55CqOiY5JQVYk6TvuuhJ06q2IYpakUR5RoJY0ri7m18j8BeQAKvHVOjP+PI
         NgeBiKbONwoPfvNkN2aVlAFC1yhi1gaiXiblsvwrhBLXdiODFFmAYOo1qe5NIPSvys4g
         ElkwrrBxIhxOJ1N6GCwpndtAUJCXvR43478K+NWp06+wUNGkewo3JJjNNdTQbUneXW3I
         5jg9anPVE8OZyP7WISTIIa0Vts2mt/9fxOxjw31cTGJXFRsHr74UyF394RqLsF5kcFYe
         O7yA==
X-Gm-Message-State: AOJu0YzBanTd8ZSRt5cb85CB7IT3jPWDMLxZNoTllvLY28dJhV6+1d9W
	i/XM9JZ8+AB7L2gjjMFlccKayo4VKnNllgP7OxOpt40XIj0xCX/ITRa7Kw==
X-Google-Smtp-Source: AGHT+IHmhzeIPgk9pPa0PYlKxCgJDJBtn4fZ1kgtdaRd91uiRQmUQJXgry6dvNQDSdjQ7XbdW6BVlg==
X-Received: by 2002:a05:6122:3286:b0:4d3:4aad:1b9c with SMTP id cj6-20020a056122328600b004d34aad1b9cmr3513676vkb.0.1713558225044;
        Fri, 19 Apr 2024 13:23:45 -0700 (PDT)
Received: from lvondent-mobl4.. ([107.146.107.67])
        by smtp.gmail.com with ESMTPSA id r2-20020ab03302000000b007ec900d958fsm195833uao.7.2024.04.19.13.23.43
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 13:23:43 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 2/2] client/player: Fix using unicast QoS for broadcast
Date: Fri, 19 Apr 2024 16:23:41 -0400
Message-ID: <20240419202341.1635591-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240419202341.1635591-1-luiz.dentz@gmail.com>
References: <20240419202341.1635591-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The code needs to identify first if the parameters refers to a broadcast
stream or unicast.
---
 client/player.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/client/player.c b/client/player.c
index 65f771039258..6b70e9ed3f9d 100644
--- a/client/player.c
+++ b/client/player.c
@@ -34,6 +34,7 @@
 
 #include "lib/bluetooth.h"
 #include "lib/uuid.h"
+#include "lib/iso.h"
 
 #include "profiles/audio/a2dp-codecs.h"
 #include "src/shared/lc3.h"
@@ -143,6 +144,7 @@ struct transport {
 	struct io *io;
 	uint32_t seq;
 	struct io *timer_io;
+	int num;
 };
 
 static void endpoint_unregister(void *data)
@@ -5008,7 +5010,6 @@ static bool transport_timer_read(struct io *io, void *user_data)
 	struct bt_iso_qos qos;
 	socklen_t len;
 	int ret, fd;
-	uint32_t num;
 	uint64_t exp;
 
 	if (transport->fd < 0)
@@ -5032,11 +5033,7 @@ static bool transport_timer_read(struct io *io, void *user_data)
 		return false;
 	}
 
-	/* num of packets = ROUND_CLOSEST(latency (ms) / interval (us)) */
-	num = ROUND_CLOSEST(qos.ucast.out.latency * 1000,
-				qos.ucast.out.interval);
-
-	ret = transport_send_seq(transport, transport->fd, num);
+	ret = transport_send_seq(transport, transport->fd, transport->num);
 	if (ret < 0) {
 		bt_shell_printf("Unable to send: %s (%d)\n",
 					strerror(-ret), ret);
@@ -5052,7 +5049,7 @@ static bool transport_timer_read(struct io *io, void *user_data)
 }
 
 static int transport_send(struct transport *transport, int fd,
-					struct bt_iso_qos *qos)
+					struct bt_iso_io_qos *qos)
 {
 	struct itimerspec ts;
 	int timer_fd;
@@ -5070,14 +5067,15 @@ static int transport_send(struct transport *transport, int fd,
 		return -errno;
 
 	memset(&ts, 0, sizeof(ts));
-	ts.it_value.tv_nsec = qos->ucast.out.latency * 1000000;
-	ts.it_interval.tv_nsec = qos->ucast.out.latency * 1000000;
+	ts.it_value.tv_nsec = qos->latency * 1000000;
+	ts.it_interval.tv_nsec = qos->latency * 1000000;
 
 	if (timerfd_settime(timer_fd, TFD_TIMER_ABSTIME, &ts, NULL) < 0)
 		return -errno;
 
 	transport->fd = fd;
-
+	/* num of packets = ROUND_CLOSEST(latency (ms) / interval (us)) */
+	transport->num = ROUND_CLOSEST(qos->latency * 1000, qos->interval);
 	transport->timer_io = io_new(timer_fd);
 
 	io_set_read_handler(transport->timer_io, transport_timer_read,
@@ -5131,8 +5129,20 @@ static void cmd_send_transport(int argc, char *argv[])
 			bt_shell_printf("Unable to getsockopt(BT_ISO_QOS): %s",
 							strerror(errno));
 			err = transport_send(transport, fd, NULL);
-		} else
-			err = transport_send(transport, fd, &qos);
+		} else {
+			struct sockaddr_iso addr;
+			socklen_t optlen;
+
+			err = getpeername(transport->sk, &addr, &optlen);
+			if (!err) {
+				if (!(bacmp(&addr.iso_bdaddr, BDADDR_ANY)))
+					err = transport_send(transport, fd,
+							     &qos.bcast.out);
+				else
+					err = transport_send(transport, fd,
+							     &qos.ucast.out);
+			}
+		}
 
 		if (err < 0) {
 			bt_shell_printf("Unable to send: %s (%d)",
-- 
2.44.0

