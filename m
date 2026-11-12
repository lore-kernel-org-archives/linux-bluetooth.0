Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=18.194.254.142
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794471997;
	b=4jt4j20r7wsBSNqQfjXeaZnKH3fRMG90OgXbhURdTXnhqm5mY4F6D4CjLvgzp0Hlq15m
	 OnzIWFklTDvCy9IRFs7t24q4ksEpznnb3KwAmE/jD9oJ/N8t/3utPX+U9Jm+xm51SQY1U
	 1Bg0xQlQUrAjW8V4QOkEd/pFp7+mBFzEhhB47YgXaZ40xg1rQe/ssLSvgD+L80ZAWL0e9
	 hZp9qQgaIlm3OPg6wcNM3Fjtvs2Ko+RX2ST8ZmwnpspZuCHCdn07yCA9ZcGoeYbjKp6w4
	 QvEF81HikH0kAATEoTmeoew7TTV3jK3LlikrbFbRY6YMlkH5AE2DFiyNcqQzjEhNAvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794471997;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=ALlmcWUT8hLm+bMDDq61tHU2NhGeQNt9726k88rnyjI=;
	b=m3JmufqCt4OKhgs9FphEKJbRju+eqqvT0R0S5O1WUJuoE40VPBVV4f2K7RxoL1UD2dns
	 PooIzVZwyueuZc4//rG4OjmPA7leQS5jbq6uSFyCyTaUxbCnYmhDEh8HgbPZgQkIboLjJ
	 OIvDuIsylQ/k51I5hpEBREcywEzrpoHeMz+UX3GO/+CZv1gOeoUsjYI0Qo7CtOiBCXZ66
	 wnDd4CeRTq5kQDw6ncKY+y+ayT4VKw2g4dphpzCqRV6hu0pnc0myYcf8NPwlbSbktrAES
	 4bj+/oLlzHaq1KsCqOhiiNKFPeli7eH8gH0+KNVRJUSs2jcqGkjy7qF4ggvk0fTklhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uniontech.com;
	spf=pass smtp.mailfrom=uniontech.com;
	dkim=pass header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=EV2yZaGs;
	arc=none smtp.remote-ip=18.194.254.142
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A97606A323;
	Thu, 12 Nov 2026 08:26:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4A97606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=EV2yZaGs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1794471969;
	bh=ALlmcWUT8hLm+bMDDq61tHU2NhGeQNt9726k88rnyjI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=EV2yZaGsyn2hlirQd81vnhev9jV2VN/PUYIi6NukJE8Uqlc0d4RDXCZFTWJ4CQaQh
	 /dT9+8QjfQNWh4/7AMA8Ep9NJOdNrfkLKguOtZyQiGuBYYMRt+hvIPhOdYXE7xfEca
	 IdvWOtN7aDk40ewNWGzQYKU2MwwjTnMSSblsA6d0=
X-QQ-mid: esmtpsz18t1794471964t89470df4
X-QQ-Originating-IP: k56wWTcPTlKlrR/LsO4FnsffIDy49lTP5C+ygjI4QhM=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 12 Nov 2026 16:26:02 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 791511799139374376
EX-QQ-RecipientCnt: 5
From: raoxu <raoxu@uniontech.com>
To: marcel@holtmann.org
Cc: luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	raoxu@uniontech.com
Subject: [PATCH] Bluetooth: hci_vhci: Report write readiness with queued input
Date: Thu, 12 Nov 2026 16:26:01 +0800
Message-ID: <A77F6FF053467FCC+20261112082601.1356290-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MABkn+BX1UZ4qV99deJJuiGcugFIHBUXo3Z+CNttgQkiOlrbx5PtStLu
	0cg3G2Kw07RY0oh391eKpLpSyNBVV3Tb/KGPCOO0PzA1tQiIPL+w97nlkaJTmqAjsHG1yPc
	8j4c2E0tpLXqrKoJV2+e6lEfZuBZK9TrTcgIMrhdZM570nsojT2u3Ngsy0FT3vbffwSbaWX
	qtQCAqSSZTTyHmitB8HnKC9KHpLbs4ya3X+bkoCgePXWMNGNVVl9RmW7gexK3VQavR4jb34
	rE+5IojQGoF/h1gv4oLYRGEquJsACNKcy8nZiyFW5b4pNwwT5nAOz9V/Jxvnpd36eC6/i9y
	ba+JOsd8GbVaQuDHzzc0Cw9VesKcfpDPdl/oxCtaCGROyM4w+F0VX9rSQFOjTyqDsGpM83z
	yoYxofuPeo6yaBPBCXWlNJOtqquC5ZVfntLgEhhFavlDBqkqL9Jis9oPBmC/7AkjCes3r/n
	948nN8nznmT1kez0bDD2d/idcwPkpRxd2LL1GjcR7+RkwKi2OQ9LVTqpXfqxcIDHkMFOgL8
	wh9KnK9SqIuSyN9T4TKfXAT9/ubN+jf6501aH5hiI7ZVeyd6/Dm4WsA4WoazaQbwfBiBjCd
	f51e70v82MuUM26WMPIX1PiVFAJ6qlqVh8TD1maWcz9fADW2RWXgrqyMSwyAos2HhgAqF+n
	39cHF9Zpm2meTeY1PbPtCs+358KhQwo3Lkt7+lHd+Wyd4pBDjDdDDK8r5zeBwzmsXPYcDI8
	U2QJpuKmju+rlo5H+y3QEKhmSAVVormdNrqKrnyJZxVSfNs6hZ8m+I+01wzwz/cWKLtOJqu
	7FDJk5OMayogEdwJ9spxranwjX+9Mcl5DGGjLiP1ypKEavSAmNoCl0Xa/gW8BTFtBho5fxn
	7ROpW8JVCjLYsfBIoOaYCLeBDFrCTmDyp/Fm2/QTLf9qKHzWEOqa5mhu+pXIvRU582kCksw
	4TwG/h9+J1Mt2UWPpu+cBxNPep148RrWlIFAZHEjbI4YuVNP0MXJOjxZKuBjWxBzy3Q4MbJ
	tLkXH1ld5NzqxBu3+D/Nujq4oW/ItPCSe5iO4Mzw==
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0

From: Xu Rao <raoxu@uniontech.com>

vhci_poll() returns only EPOLLIN and EPOLLRDNORM when readq is nonempty,
dropping the write readiness bits it reports when the queue is empty.
However, vhci_write() does not wait for readq to drain: incoming frames
are handled independently by vhci_get_user().

As a result, userspace polling only for write readiness can time out or
remain asleep while input is queued, even though it could submit a
frame. Applications that drain input before waiting to write avoid this
case.

Always include EPOLLOUT and EPOLLWRNORM in the readiness mask, and add
EPOLLIN and EPOLLRDNORM when readq contains data. Keep the existing wait
queue registration and empty-queue behavior unchanged.

Signed-off-by: Xu Rao <raoxu@uniontech.com>
---
 drivers/bluetooth/hci_vhci.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
index 771ad9893c44..0b427c65ce59 100644
--- a/drivers/bluetooth/hci_vhci.c
+++ b/drivers/bluetooth/hci_vhci.c
@@ -636,13 +636,14 @@ static ssize_t vhci_write(struct kiocb *iocb, struct iov_iter *from)
 static __poll_t vhci_poll(struct file *file, poll_table *wait)
 {
 	struct vhci_data *data = file->private_data;
+	__poll_t mask = EPOLLOUT | EPOLLWRNORM;

 	poll_wait(file, &data->read_wait, wait);

 	if (!skb_queue_empty(&data->readq))
-		return EPOLLIN | EPOLLRDNORM;
+		mask |= EPOLLIN | EPOLLRDNORM;

-	return EPOLLOUT | EPOLLWRNORM;
+	return mask;
 }

 static void vhci_open_timeout(struct work_struct *work)
--
2.50.1

