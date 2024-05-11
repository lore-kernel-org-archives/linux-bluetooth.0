Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BC65646D
	for <linux-bluetooth@vger.kernel.org>; Sat, 11 May 2024 15:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715442368; cv=pass; b=O9D0Oz9Eanrg716X7wxHdLa0BVWOMTpx52plcHXPneGxXkYX+xojMLNxPLRdImyTZdhPVops4qJ9XkAQ78V19NsnaegNSAjda44+rJ96ffazKiVvGMIUoXMeSpI9PQrcLveTPma8HGnTzttlswmhRGbMbQFwQ0Qn08Bz/E270Y0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715442368; c=relaxed/simple;
	bh=DNDdV6qEDdc+jSB+VvzTITXFustcYNvjxqZRUv6iPwM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oUicf+d/r52yKy4KfCYXi6eGUqGsx07A/ucy3UGVHtaJR36sRCFhK1TyGfYGsZD4xWz8K+q5d4d9AxR1TgG8/J9HqDdDY5bOcHc7+UWhOrWe8WB4kwE/+eKGXzrhdzCR9Rv4SMdOmw6cIIVPSAohHsjAYnIolFGPURRpccXXucs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=NxyM6k4Z; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="NxyM6k4Z"
Received: from monolith.lan (unknown [193.138.7.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4Vc9835wJYzyNX;
	Sat, 11 May 2024 18:45:55 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1715442356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=63hYYxxOXAj5pGWQjGOgvxg1+q5FqcuGoXtKoPNJmXg=;
	b=NxyM6k4ZUefGZPIIetEXoatG2MboRlIqVY5cfcUPgB+v5jc5rrKIZ8pAfq8daAr+HNaway
	RTBSXZGguR945txSxc96GrKNzJPxg8z2jOZ5FgYqxvjd2B7bZvC6K4CPdPupCo5AYmK7/2
	vcZE3kooOxtk+HqXWCNGX6E+2mYKLfM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1715442356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=63hYYxxOXAj5pGWQjGOgvxg1+q5FqcuGoXtKoPNJmXg=;
	b=Hv+n04Mjmvrg8hWWLvd3vkbZrGJ9Gd3VVetBXm19WOyS3esceQDwaM6LZFrxLbgxkS29Xd
	ghWqwPm/CbeKHq1k2mkOLqO/ZYXprm2ILJNYc+AauX3RfCM0Rq31aWRQzcr0+NyydvV+1T
	1itwUq3I24MtQiPOOC5R/9l856V8A5I=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1715442356; a=rsa-sha256; cv=none;
	b=YXna0DM2yOTMikJQdQKV78psI6J7SrqQoKEnIwc2dMYxENTpfsaMKMyJNAy/Ad75p+XO2c
	j0DeVVqD3mc7NDuV1YzADG65jrVfzqtsRPVDmZNQN2RfqA8oKjSoEp0guv5LpDHvrTbrON
	7scCbn6U7Tgmk+lLuVuF92vpiLXIzoc=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2] client: fix ISO send data rate
Date: Sat, 11 May 2024 18:45:46 +0300
Message-ID: <30fd803be62f762706486698821e9e5fff2d0b63.1715442270.git.pav@iki.fi>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We are sending data to controller at wrong average rate not equal to
1 packet / SDU interval, if Transport_Latency is not an integer multiple
of SDU_Interval.  The calculation currently may also give zero, so no
data gets sent.

We are sending data in bursts of num ~= Transport_Latency/SDU_Interval
packets, in hopes that possibly larger timer interval makes things more
efficient.

Fix the data rate by sending num packets every num*SDU_Interval, so that
the average data rate is correct.

Also fix use of itimerspect.it_value with TFD_TIMER_ABSTIME.  The value
set previously is going to always be in the past in CLOCK_MONOTONIC so
just set it to 1.
---

Notes:
    v2: Buffer one interval immediately as before.
    
    This assumes kernel shall set qos.interval to SDU_Interval and not
    ISO_Interval.

 client/player.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/client/player.c b/client/player.c
index 7f67425aa..df5cb8924 100644
--- a/client/player.c
+++ b/client/player.c
@@ -5066,21 +5066,30 @@ static int transport_send(struct transport *transport, int fd,
 	if (timer_fd < 0)
 		return -errno;
 
+	/* Send data in bursts of
+	 * num = ROUND_CLOSEST(Transport_Latency (ms) / SDU_Interval (us))
+	 * with average data rate = 1 packet / SDU_Interval
+	 */
+	transport->num = ROUND_CLOSEST(qos->latency * 1000, qos->interval);
+	if (!transport->num)
+		transport->num = 1;
+
 	memset(&ts, 0, sizeof(ts));
-	ts.it_value.tv_nsec = qos->latency * 1000000;
-	ts.it_interval.tv_nsec = qos->latency * 1000000;
+	ts.it_value.tv_nsec = 1;
+	ts.it_interval.tv_nsec = transport->num * qos->interval * 1000;
 
-	if (timerfd_settime(timer_fd, TFD_TIMER_ABSTIME, &ts, NULL) < 0)
+	if (timerfd_settime(timer_fd, TFD_TIMER_ABSTIME, &ts, NULL) < 0) {
+		close(timer_fd);
 		return -errno;
+	}
 
 	transport->fd = fd;
-	/* num of packets = ROUND_CLOSEST(latency (ms) / interval (us)) */
-	transport->num = ROUND_CLOSEST(qos->latency * 1000, qos->interval);
 	transport->timer_io = io_new(timer_fd);
 
 	io_set_read_handler(transport->timer_io, transport_timer_read,
 						transport, NULL);
 
+	/* One extra packet to buffers immediately */
 	return transport_send_seq(transport, fd, 1);
 }
 
-- 
2.45.0

