Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556A0DDC5
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Mar 2025 22:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742336533; cv=pass; b=S6zqxPlueP7xZ2fW2OIH2/K1chIovgCw4ED2zigx+61R9gIhwK3kgRTjD5yV4pai7PfoV7ksU5QpU+oHJ0OZBz4Gpy6klVl/boi/XqCN5bgK95ZyAZNLgD3QNbJkIiumXeDjWUUGuBIgNtwX+NVHHvIMb79tjF1JDAWkRNwvcwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742336533; c=relaxed/simple;
	bh=kh6n01HTEcsbukMhvzwT/Rrg3OSccXzIwgyWvu0tCL8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YguntDVfxwfTb1lGmaB1/Nsw58Sp+27WRQhNrKri56JPUFQbc1RM134YiXxsuNzpHnC1NuGE5GJuohzBQrs5zQkRmgSjBqHufkdUp+JHsgZaQ6qHn/OyThfVfBgrg+XEO4uVgWi4Ya58v+d3b+dTKmStT0pggDHH4d2JAJUwZPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=mJD5WaBU; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="mJD5WaBU"
Received: from monolith.lan (unknown [193.138.7.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4ZHRCg3yWtz49Q3T;
	Wed, 19 Mar 2025 00:22:07 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1742336528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OJ1LIQX3ANzegZIxBkwnk2Dnz00L0hOB9PW/AWHR7xY=;
	b=mJD5WaBUWJqkqHZaKubI+fCk9iD9GXmP6PBAaUCaJ18x02xat1ZMSBBKiBRnnNXXgMFMaL
	3XoaBq5/0Qa17/WOATo0JtVqhuOntkQwfugVvEzbQQe039em4KT0g5stTVlXvSQV4ylmKv
	09hpXSPEu4tkvYKW1c7mn6P3dOQQ4RBxWJyYYyO60w0O7aAezwzj0mfPY8bHjI4C5zqzO8
	ztAq3cL85xwrN5HTaTSFzR2Bam/mDmixmt4fTfsMFkVsFTyJskBilieVlcj2T7iEiUDjZL
	rwfYS4Qji1b9JNp+XIORNokz5/RGrb+ibCRpfzmTw7cQB7kGkQ3rubQ63iAWMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1742336528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OJ1LIQX3ANzegZIxBkwnk2Dnz00L0hOB9PW/AWHR7xY=;
	b=f8BklsbWo52BO55ReCkEA5oJq4PfcpJ18EWpz1LyOYIQl8VSNoDctO94Itm3myPRzZFEIE
	M+hSAwNoth9hIDAL0rhOhbjCQJLqvdnv1zjXaI0yjz1qLuEyJXUH3/7b/XiuK00g6W+rCl
	J7+aW75PqHJorMhFiiSEOL3AKaIoKrxmaZSfjHWPBphNjZNxlzquUmOYUYaB296F3ZoeMA
	vq20pHUMEbeXffyZM5a7dN0W4r/vLYko/r+g6QSiamowGH24C8dXcq12hErNOInZxbXwph
	DhMKEiNF4sXLNvdMnldx/SttfgC1GK3PylMJXsEPhqbUrhxfgRx7WI8jzisAsw==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1742336528; a=rsa-sha256;
	cv=none;
	b=jyb0xyIViVMsUhAtI0/O/R6c9yl7/oXO3boecnNY0R30WcxNjQ0T8FVwebp3jH8E8GiqVV
	IM+G+z1gGx5vipHBeeT8sBiPfRBKkH0UWgfAce6UwdT9I1He9C19wo0xYtSXFCQaFm9z/o
	0G2mg8cUTiVpc9d3HKvqNg3IqMkkCB0QdtI9Vxh+blT8lB9evJiAByhCdmpgh6Axl+rM8D
	CDd2VJKF5XE1WDvYODSXVMqA/iR1alev6W2WtgYyTEzD3stpWbl2QQijL+kD9w+yaZJC3V
	NegJMWdubzx0fAE3hFzG9QcROIT5AZzpaPsuECRWjyQzRYdsp6TBfMkeQObdSg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ] l2cap-tester: ensure SO_SNDBUF is large enough for the writes
Date: Wed, 19 Mar 2025 00:22:03 +0200
Message-ID: <975ef1acdd3903f4e0fcb26dc1d0046762d99140.1742336487.git.pav@iki.fi>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since btdev runs from same thread and won't flush, SO_SNDBUF needs to
hold all data we are going to write.  Fix spurious test failure
in "L2CAP LE Client - Write 32k Success".
---
 tools/l2cap-tester.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/l2cap-tester.c b/tools/l2cap-tester.c
index e56773d13..3b3ffb6a7 100644
--- a/tools/l2cap-tester.c
+++ b/tools/l2cap-tester.c
@@ -1451,8 +1451,9 @@ static void l2cap_write_data(struct test_data *data, GIOChannel *io,
 	const struct l2cap_data *l2data = data->test_data;
 	struct bthost *bthost;
 	ssize_t ret;
-	int sk;
+	int sk, size;
 	unsigned int count;
+	socklen_t len = sizeof(size);
 
 	sk = g_io_channel_unix_get_fd(io);
 
@@ -1464,6 +1465,15 @@ static void l2cap_write_data(struct test_data *data, GIOChannel *io,
 
 	l2cap_tx_timestamping(data, io);
 
+	/* Socket buffer needs to hold what we send, btdev doesn't flush now */
+	ret = getsockopt(sk, SOL_SOCKET, SO_SNDBUF, &size, &len);
+	if (!ret) {
+		size += l2data->data_len * (l2data->repeat_send + 1);
+		ret = setsockopt(sk, SOL_SOCKET, SO_SNDBUF, &size, len);
+	}
+	if (ret)
+		tester_warn("Failed to set SO_SNDBUF = %d", size);
+
 	for (count = 0; count < l2data->repeat_send + 1; ++count) {
 		ret = l2cap_send(sk, l2data->write_data, l2data->data_len,
 							data->l2o.omtu);
-- 
2.48.1

