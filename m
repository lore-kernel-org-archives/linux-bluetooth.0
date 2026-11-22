Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795362615;
	b=HAOHL7viD5STmILPH0ckMhjTUfMWn6pjUaIiUnTjXbI8eOlqQUa1gCVTyooqEnROvKMx
	 m47Uc9CcNeAgQsoemnBGJ1aOnyIxYsvqP0yigvzn+8MS/EI2VfXJrqL9jYaKFe9s642zE
	 pj+H2r0wx+aEICUt1ZFRIhvy4mJdGn1ein1RtG+70lEKJcc93QNiL3xCJSRXlSCyGxBhI
	 wWP2P8T2kV/PqpbnIqyyGY/ZeVaAfKdnT8Bnp6b8GOwjQh+ibIG1bPO5ddQHm25/j4r1C
	 AZhtVlc+N5dnK8WxZjN4UiH/4ekhOMIl2S5ugeBWZNLS2YfQ8Di6AE+a2TqfcJ8QvuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795362615;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=lt5tsqcP5LdnXFM2Hx8BHrqFAca6lFSEY3z3oVEvZ+w=;
	b=Rzjs7dRB0/+iOsP6Pg0WJJQl3ABmOgc11zU8KypRm84owQx6NZpI3p2mYT4KQxsmcjcj
	 Qv0pNxilcofPObG72IO1tRa8zr6Glpf8krF3slOqzzrawD4YgO05TzLS9TgOioHAP9hz4
	 Lrm1ttXCijDqMXr0OX3MD4E00LxhwDlRFuvvIpyoNw5pqPviZXmVHkXqEAaZdsmsGPMM5
	 //BoXbDhdRhX8F798zT0+qNyNfOzqgtPqVQQ4w24QrtrWsc5zLmFTBnuT0XyEatnzuflo
	 qeoreVkwHMw74VCj5R0lt30qZTRGynET1Log/5/5bxzW6eubng754eHtQBX7cHIsK1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=YjbuCaAZ;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558BF606A32C
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 15:50:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 558BF606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=YjbuCaAZ
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4bb69f5b161so15771385e9.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 07:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795362614; x=1795967414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lt5tsqcP5LdnXFM2Hx8BHrqFAca6lFSEY3z3oVEvZ+w=;
        b=YjbuCaAZESZUGGfHd19Q8SpxvAdcntHJNbTozrDVqZqDqinJ/BPqnL8LZSflaUvtde
         EjEHPjjXmYpVDhdQ7f+a7jD05rPVY+2SYS3JwmqZUTXvWljIvOxSGvN+OaqIVVoeD0D8
         cwLMBnRwrdntJfVsFXn7MHQMPf8uK0VMr2meA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795362614; x=1795967414;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lt5tsqcP5LdnXFM2Hx8BHrqFAca6lFSEY3z3oVEvZ+w=;
        b=t1WTYKH2dv6GSAVZaDdFf9sI5fseumsAbvWC82B1w8WOTs1Xb3rKbo8ZBApdhM1bs7
         wdlDZYyFE2PZyc0sckY85aSkwv9IUDGIlQDz4fsqzwoohMGwAH+oLTC1CnAz6qg4Oj4Y
         2WUrABuIoICNGPrHKgl4h3WLaDCVmoRUXvFdN45gNdMlpjrD462Q02+H5oc6XTH1jFgQ
         o1PWUHTejYUohfQi544KRPPKT8pWOHuRQZhLWZCnobyHdSOcfnG2kbvL3AMA6nf+O0wd
         xHyYbPjnNP+b2DvA2NS7cTtshD09VAQzALeSKFXTFKT6APyfzTagsJZljnl3Ram5D5R+
         K9SA==
X-Gm-Message-State: APuU4Z8DkQysoCLOdm2oLjlF5kJNInzx8y21/AwSloKUZ3dQEP0566lb
	BuRrsF0vfGUpMiNq5snCuPrGccSM/ZQdZa0L46n9pAQ67SNcJt/kYQieof6dolb5Lg30d+kS39D
	hj0l6
X-Gm-Gg: AZFdTZdOMdJEdmYDBx6FKWaqBxRVqHV5hHsEcho++dSK2Xtp5eJYu0ioeqO3xKcOZPQ
	XJnbmjUeacJ4Z1FByMqELvbyvigxHh7KJfNM2c8+8wuGusADXMVXXMUwNkmu5LBA+ZPfjy+SdHj
	ZtiX7YaxyJM8DvpI1jTSDQi0+nN/6CH5+YMsTquRX6sN/RvWQMzJ13jqiKNxsB3KZsMLpeLF1NP
	gqb+Xt4jBlhEe3tWpEiPImhP/HaEaRY3KtaEwAdtB4v7amajxVls9UktQ+yB2W17J38m8AEOfTQ
	tDvncFMbKfR2V813gDdETK7rPfWGvsCR8lrfosYtl9XAB/cy2iUdFS2z09qYLhG72qfjO29+7pR
	dNrNk6N2K0G1Txm9YId9IJeuqV39yzSTPAP3NfggqBq7es7yO/x3b+FjH4PNQ3cnek8DOie49v4
	nAomsuyjCqKaHDLM62evhnybc2Yb8cxen+OqWmDHDBkC1CTrLve+JUlIS/r6Xu+s0fPjCq/fmJy
	hRFgAK/xXiU1LJs5ckHrywwbwO9mZAfDYzyc+p911ETlNHzMsC0z9TenIonvP3ScCcebd7iGcNL
	D13A4A2kq6154Wr0c5SJxEX7fCazXbgGhQlLbB+4tlW+c+yXMg==
X-Received: by 2002:a05:600c:46c4:b0:4bb:6a5a:7834 with SMTP id 5b1f17b1804b1-4bb888106damr194535985e9.20.1795362613693;
        Sun, 22 Nov 2026 07:50:13 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:f8cf:a1d9:90ed:c978])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8849e598sm237733025e9.8.2026.11.22.07.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 07:50:13 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH] Bluetooth: L2CAP: Fit an auto-tuned MTU's PDU in one EDR packet
Date: Sun, 22 Nov 2026 16:50:08 +0100
Message-ID: <20261122155008.1545777-1-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
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

l2cap_mtu_auto() sets the input MTU to the payload size of the
largest EDR packet the link allows. The MTU only limits the SDU though,
and the 4-byte L2CAP header is added on top of it, so a full-sized SDU
does not fit into that packet and is sent as two ACL fragments.
Subtract the L2CAP header from each value, e.g. for 3-DH5 the MTU
becomes 1017 instead of 1021.

Fixes: 4b6e228e297b ("Bluetooth: Auto tune if input MTU is set to 0")
Signed-off-by: Simon Mikuda <simon.mikuda@streamunlimited.com>
---
 net/bluetooth/l2cap_core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index da947b65d26a..fb6fe760b147 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3433,37 +3433,37 @@ static void l2cap_mtu_auto(struct l2cap_chan *chan)
 	 * (including the 2-byte payload header)
 	 */
 	if (!(conn->pkt_type & HCI_2DH1))
-		chan->imtu = 54;
+		chan->imtu = 54 - L2CAP_HDR_SIZE;
 
 	/* The 3-DH1 packet has between 2 and 85 information bytes
 	 * (including the 2-byte payload header)
 	 */
 	if (!(conn->pkt_type & HCI_3DH1))
-		chan->imtu = 83;
+		chan->imtu = 83 - L2CAP_HDR_SIZE;
 
 	/* The 2-DH3 packet has between 2 and 369 information bytes
 	 * (including the 2-byte payload header)
 	 */
 	if (!(conn->pkt_type & HCI_2DH3))
-		chan->imtu = 367;
+		chan->imtu = 367 - L2CAP_HDR_SIZE;
 
 	/* The 3-DH3 packet has between 2 and 554 information bytes
 	 * (including the 2-byte payload header)
 	 */
 	if (!(conn->pkt_type & HCI_3DH3))
-		chan->imtu = 552;
+		chan->imtu = 552 - L2CAP_HDR_SIZE;
 
 	/* The 2-DH5 packet has between 2 and 681 information bytes
 	 * (including the 2-byte payload header)
 	 */
 	if (!(conn->pkt_type & HCI_2DH5))
-		chan->imtu = 679;
+		chan->imtu = 679 - L2CAP_HDR_SIZE;
 
 	/* The 3-DH5 packet has between 2 and 1023 information bytes
 	 * (including the 2-byte payload header)
 	 */
 	if (!(conn->pkt_type & HCI_3DH5))
-		chan->imtu = 1021;
+		chan->imtu = 1021 - L2CAP_HDR_SIZE;
 }
 
 static int l2cap_build_conf_req(struct l2cap_chan *chan, void *data, size_t data_size)

base-commit: 4fe38719e6738feaa90486e36b0790dd5d960a96
-- 
2.43.0

