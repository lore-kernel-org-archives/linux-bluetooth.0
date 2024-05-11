Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C89D54F87
	for <linux-bluetooth@vger.kernel.org>; Sat, 11 May 2024 11:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715427281; cv=pass; b=fu7iGeE8cMQENNrweYM5mo6jpIi86QBheCCIHNtS7tXEfHtic6MiVdAmAfISC6AgB1tyJ36WbsgTBk8wOnXW/4ktkWqWOxaV3pKvRoPk/YwU7jWuAzaBIHtRC4QbHk5v4vrhVDEJkCXlmr6O9UQGEJdoLXX45ueUEIAuOLDMqrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715427281; c=relaxed/simple;
	bh=SDw4fccHiXfAnHiqtsteJet8IDvhNaxh7ZhYGJK3f6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DpBPMasQ20J6ozGHt7sFbNGYMWEsV26CroWsmMTLRS2mN9T3lRdMMxVGll2IqX+aYJXj7wtDP7FnK2tOg4EqoZmjbnz0rqt2tpnEZfu1C45pREAZLtApr9LAdo0w4h2oe4aEUnQLveSL+Kabz26Bbeb98QP73VCD8+b1jTxtevg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=b+pm8bXr; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="b+pm8bXr"
Received: from monolith.lan (unknown [193.138.7.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4Vc3Yf6VSqz49Pyk;
	Sat, 11 May 2024 14:34:14 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1715427255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=j1bHUPcLeQznxmDgdIiSFlIaYUAXhu54WGNk2m5BD1w=;
	b=b+pm8bXr2w5CzMDB55OwHshAf52OU30+Hargu2FeH8CU2Xze8Ph/rWsKjyx59m1FGzZyHG
	iIbjWI2XuY37xc8i/9EAu7bk5RoaBfP1/9+4jiAtcbJaIjgjDQ0XoONalu2Zyw5knJol+r
	2dNHRSN5CUfY/0iNi6udJdPyTw6ox2pB6FZ9hcvImwhJF97LEAcPFRNOQVR8iys0MGnRtl
	eqIkJPCgPAfHqO89S0FCWbETeAb0E/OwmlGM1CxT+sCD42DFs8IZoYVsM979+9bNcpm6mZ
	NdTGkq23Ka0WZKxna1sS74Z8id88XJCt5p0U8qY66gcO0Wm297eMdp/c4cDXIA==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1715427255; a=rsa-sha256;
	cv=none;
	b=tbhdkfmJtOhnRigeaN2KU5XgMl06/mqragvUcT0d5cEm8CciOgE/B5Fo6qect1QSO8cUH8
	CvmIHJzgVffhnV7hFueNFfDwIPNlmNS/1xK+fYOIMJmRBLAmBRykkL+Adkp+l9AC0I6ATc
	1GM8KsVoUfkXZAkm3iBys7+ho2TDVzc2bttIARlF4H5HXHJk7BWb35ctyL6kQU9QhVwVlw
	E7igfS3zhwc6+Us3p2i4oXHf/f0UWH0VBZkO9t6rDNymmnZE5/2Ydpr/YfMruo9mJO2cBQ
	Wb+yduMo0X3sU4E/x6TVo+RIDZDkwKC4RjwpMmGzuseJp3wrHFcP5tG25lh9aw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1715427255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=j1bHUPcLeQznxmDgdIiSFlIaYUAXhu54WGNk2m5BD1w=;
	b=HWqEhbQQLpb3Bnp15vou5ICzahfOv+vyk1oCzL7uyV01LYB/jDk9i0I2H+FVPo5c+YUgFF
	vDdRNKp+1cravJudKl11+Sd4abywVYBtQ0Gd2kfuhFvFiHdE+6W/9U5cRIPnnnyAguhJ9r
	apfdQQJM09qHsOFNpU8SXXE2GhIQ/Id94Vaw1bgKYo11I+PmYl9TL8KjeANcLL4BcfYgYj
	vZ0vaSs1bH4eUCzvmoRojNuC6tZ/J28j6I0iDezn6NSa6vtRcA6TFKEdtXj/MPtJYq2y/N
	LO/K956tukNPFa0hZYpM7zlxEIXYqFGol0fdO48rb1oXBUaeo6mqeliC5aswHA==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	vlad.pruteanu@nxp.com
Subject: [PATCH BlueZ] client: fix ISO send data rate
Date: Sat, 11 May 2024 14:34:08 +0300
Message-ID: <9b88a0238679d24aa5d68a4c473483943a8ea2b6.1715427163.git.pav@iki.fi>
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
just set it to 1, and leave sending the initial packets to the main
loop.
---

Notes:
    This assumes kernel shall set qos.interval to SDU_Interval and not
    ISO_Interval.

 client/player.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/client/player.c b/client/player.c
index 7f67425aa..8d17022de 100644
--- a/client/player.c
+++ b/client/player.c
@@ -5066,22 +5066,30 @@ static int transport_send(struct transport *transport, int fd,
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
 
-	return transport_send_seq(transport, fd, 1);
+	return 0;
 }
 
 static void cmd_send_transport(int argc, char *argv[])
-- 
2.45.0

