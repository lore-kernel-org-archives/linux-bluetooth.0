Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795532937;
	b=3CC8gE9T5UgxJQuaQYfBZdtNCmJpCxgRChC1bS8IV3nFTpUBXql2Ycut4ODGcvUJn5b+
	 219zPJrVzLeBk1ew3rcRc2Mw6vNGfnKvPShQYutZ0pAJyNO9g7eUP4osCltJ2YTslH9QG
	 g17k3jx84mCiRpTfHaSDFODY62otDxjXPS5PRahcJa+SGN8tOkvdHZ1tOuUIJjqU4n8F+
	 TdQPHChvpPvzWoZUYB2EUWi8UOczIL0W+4T/X9ulvZnRkvV1h/L2tad9bGTFwzr0p5I5s
	 EQ2eRu8LbB0EeOkggZPi4vnH88SltbBNjTr0anxtnh+754i+Y591EVH7uzYvc15s4uA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795532937;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=UTQUNopQNxN73KX7HgdMNqkd8EzRM0ZOijqDqz0SQ3s=;
	b=xzM9gGJnAEzF6iXkCZHyvQlxwb1H10sZhEc/dq8lzZS9JzSjuoWEt1qdfFttRK0MHCYd
	 4TtSU7micA4U53zk06kbt3JnKUMvr+g96Y9R3R9UglMh0IZlxqdT1JdBROlvXg04YAOEv
	 bUhNOYxeeRAMMPEy/CaGHWayyKn89o77d1Jq9bVNjNOgXUIsAOFztXmdYyc03gbgCdsfc
	 hD4kmHFvQA68ngfPCxu2V5qY3ozJJOvyJgu8KTvwQEsDVMO1M+oG40RkBVgGxwo4Ii1A1
	 xmGpVv0uDlzehwkmDylyF/opeIF/2xdqa8Ll/RlWA00PDgPILAibwOjOanGfevrWopg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=g2vH9RoN;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48700606A31E
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 15:08:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48700606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=g2vH9RoN
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a2153c8525so37224205e9.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 07:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795532935; x=1796137735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UTQUNopQNxN73KX7HgdMNqkd8EzRM0ZOijqDqz0SQ3s=;
        b=g2vH9RoN3P+jsH5tDJZL30TEWJzmquT0KKzBa/wn6341BNfF6wVhZAikul04/10EhW
         b4oRVbYISHa78Fnvs0Mum1MYJUUIn2SRaA2uN1xgoSzROP7Ye8B09jGV/MY74qFqy5xo
         IxT7WEMaJ/11HVhohUlxlQwejUt3XCxzsKvG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795532936; x=1796137736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UTQUNopQNxN73KX7HgdMNqkd8EzRM0ZOijqDqz0SQ3s=;
        b=LaqQ6BSvsuZJtfpFnnxbRyB0qWxeVPa23+/ceuNOBJYw8vlg7VawrTx4oVfKBpU+2V
         jsfTuSzD28T/h16NGcRmhIVzW5m8u7KhR7sP+tu7Tv4IIElx7qxkgGFgVQH/Kd/vD3Ei
         5eeKM62tVQShbiJEkKEyd9mrxSnoUvC3Ys3k9JoxymjmXZN5rmQZR2BMLHxNhK6KSfm8
         9MWDXx8Z2QTcvYEvrCaA69RGq/2ilLYf9NctOF9j88OERFIVDxHKsc5TSne12abJzZMC
         v/f9iUCi3aETySe/xeKFQuyM3gcaU/vkfoRfjSVEyKz8AIlZmXkubfgqVdLv1+Q3Ds7V
         pbhQ==
X-Gm-Message-State: APuU4Z/C/OwIjoCgrrJ4EUmW7RFu4QH0q1zvK1lshzt4apLdYnR1FNzW
	q4n3Vc3qIx6e6zxzimAYCcdJE0+w+L8Y8H+ioCHFHPnyAwNOH04gfL03/PrOp2ktb6e+9WcXNtg
	k7hD8
X-Gm-Gg: AZFdTZfDoyxrl5GeisqJjW+YWcsRIGokeTME4skiZkgjQhHs7SeD7DcI7UZwOeS1G6Q
	pDTg5nPDEA/np1bk2XH37Z0oj5k/iPpmECimCiM+CoMMWDzx6lWC9kun8M5+nVO+3Y34HOeqfWh
	LZSaHQI8+WCpzDEQQoXUSGn04jWARYR9INp4WNZFuKdnN+HC3c4CrdgXw+KhvJthY7Zo9RaEI8n
	GkesQASchVOMzfa+I0O1Yomp59IIYYAjjZpvmgqS9/8lTYwnX9ajeRYNFcAlL3t5sOMxMVJwTY5
	TUw8dQLUx5aFuJM38lwTo3L87SaYFQkTxt/Uwhx4MhMgOv0c+H1cQkM6r8+slVdsioZOjXxFsz0
	GbuXyNPg0qhOMjECpDPrxry9EB0pVtXuQhFZW7aUqwCgo7f49C1qvUkaHMjD1EvDp9nKqI87UrP
	IQ6e209SrTTpLEHYkxBEGrkUjGUOy0MChaqvT/GE27F+0bQEJKrrC1atI9Bu0sWqRWaIJ291QSA
	MlyRRcyRQ8lVGwWGag7LKH2C11/gXwbrjzSIKv988jBqnIONUWliO1yQuWAaKuKrGqs9ssPeMok
	Sr5T11Jj6j8D0Gm/9I3bxwQh6xFuWF6vyUK9lpUkBBCbWxK5Ww==
X-Received: by 2002:a05:600c:820d:b0:4bb:5de1:e923 with SMTP id 5b1f17b1804b1-4bb887c33f7mr297897235e9.4.1795532935639;
        Tue, 24 Nov 2026 07:08:55 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:d476:8432:c5c5:dd98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884b7515sm606401275e9.13.2026.11.24.07.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 07:08:55 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH] Bluetooth: hci_event: Terminate a PA sync nobody accepts
Date: Tue, 24 Nov 2026 16:08:51 +0100
Message-ID: <20261124150851.338673-1-simon.mikuda@streamunlimited.com>
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

The accept mask of hci_le_pa_sync_established_evt() starts from
hdev->link_mode, which has HCI_LM_ACCEPT set by default, so a PA sync no
ISO socket accepted is never terminated. This happens when the listening
socket closes while the sync is pending. Every later sync to that source
then fails until it stops advertising:

    < LE Periodic Advertising Create Sync  50:1E:2D:A1:5F:1C
      (listening socket closed)
    > LE Periodic Advertising Sync Established  Status: Success
      (no LE Periodic Advertising Terminate Sync)
    < LE Periodic Advertising Create Sync  50:1E:2D:A1:5F:1C
    > Command Status  ACL Connection Already Exists (0x0b)

Only ISO can accept a PA sync, so start from 0 and let
hci_proto_connect_ind() decide. Terminate only an established sync. A
failed sync has no handle, so the handle in its event means nothing and
can be the handle of another sync. The NXP IW612 Bluetooth chip, for
example, reports a cancelled create with handle 0.

Fixes: eca0ae4aea66 ("Bluetooth: Add initial implementation of BIS connections")
Signed-off-by: Simon Mikuda <simon.mikuda@streamunlimited.com>
---
 net/bluetooth/hci_event.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 610207e25fa4..2da77ebee12d 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6814,7 +6814,7 @@ static void hci_le_pa_sync_established_evt(struct hci_dev *hdev, void *data,
 					   struct sk_buff *skb)
 {
 	struct hci_ev_le_pa_sync_established *ev = data;
-	int mask = hdev->link_mode;
+	int mask = 0;
 	__u8 flags = 0;
 	struct hci_conn *pa_sync, *conn;
 
@@ -6848,7 +6848,11 @@ static void hci_le_pa_sync_established_evt(struct hci_dev *hdev, void *data,
 	mask |= hci_proto_connect_ind(hdev, &ev->bdaddr, PA_LINK,
 				      &flags);
 	if (!(mask & HCI_LM_ACCEPT)) {
-		hci_le_pa_term_sync(hdev, ev->handle);
+		/* A failed sync has no handle, the one in the event may be
+		 * another sync's.
+		 */
+		if (!ev->status)
+			hci_le_pa_term_sync(hdev, ev->handle);
 		goto unlock;
 	}
 

base-commit: 62fd917f6d2df1a399a453138c2b7cbd563f8f95
-- 
2.43.0

