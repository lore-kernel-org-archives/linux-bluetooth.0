Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE15E2D63F4
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Aug 2025 21:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755724424; cv=none; b=Xyd81/QGHsRJRhw3JD9QteqNxYGUkkBn139gEaeR+X0vg/wpVmcst2gLtq5/Qwa4DKTw5JqyvqGIVX9/tZKPk3wJxPQoBMB7yTXh+/+17ZYCvVL9PgFgLA5prqVEXbioJK34AFGghz1RqHiF59lPt+yivdnuwJ26+6JTPBcDwb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755724424; c=relaxed/simple;
	bh=2R3RhoDi4KrXzVm/2K0yI6Z2R6XuVWWT2AitAY5Uc80=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=LLg6Pl4B0nhyj9bTOyr9SrabxY0US/6yaQdKt72+CaskMqy3HVE17M5Qg1WjMMu5ml0xvKWkAqJtCQLEztpnNtBn8+AV1/K4ik8BnRmvg7budGACjfa3U3ScoNaI0eImsB4EMtEQyaffmM+lPv61zj2RiR1rzGQAgyHPr7wWI6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bGlNSiQP; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGlNSiQP"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-53b1738e8e3so279167e0c.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Aug 2025 14:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755724421; x=1756329221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=NIkfLZ+CT4tNumj9HmI66csjS3eyYnh/Y4SbeQNrgOk=;
        b=bGlNSiQPqUnAbVu+Fq/wGG79SHDhl79x1YMncFmfgOaUSKYjbqEWVUtlIcu4TCXWsB
         Tz23X2waceDkCh76n/5UD09cOMmqdug7+xsbrHNqBskPUeaXFICHcT/zmUIinnO8/oY3
         4grxURvpCX79AmOf9OB98cjR7buCoC/5tlMt2NPDxHC7kqlPA8WpzlPcETIABoNUKZBh
         9Qoyu/gDFQC7kRR30Epmp9Mvd0aHwm7wr/wk44cyRvz2djv1y+fRHZdCoeG13tMvShfb
         hE959KExBd2e36PeIOmaPXeGWYlbvf100xmCrDws+dBoPj+Q8pOLZb7OzYALoNt3WzjC
         G6OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755724421; x=1756329221;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NIkfLZ+CT4tNumj9HmI66csjS3eyYnh/Y4SbeQNrgOk=;
        b=iAPYnKaKdealW/YV1gKRnuBeYQ+QxSK0YViUnCeVHK8b2ontJb09RxpQNHpPLRQs2w
         zeJ8aVkCcGNmFQo8/WAoyxmSHr6t0iHWXrWS98iJhgA3UaUqY789c741I36A7pl7eu3+
         +1Fe+TVcQdj+C0LWESKmll8V3QiHg4b9sjKu8prAur2ZD7LCDFlnb11Zi9DAK6BaKbcz
         zNq5q/lNRpaKhguxPRofvc3Zp8mKcWDUzfZ8vnhtDC1SSr+Tc7sLyIoKys4a9XERpTLM
         l4h8X+WBg5xOC24/RpdsGboaNsFZjbPgDxybET6j253ipBrpcYgpE05GFaoIChjNEahu
         ZPBA==
X-Gm-Message-State: AOJu0YxoVKRXH4u6yg3swE7Cdzpg+iejCvqv6tWnHkb0qXWKSwtl1WL1
	ypZjmpyWeg8ARusmDbyQdIEXC779Aydo1PmKVLwX8C+b4YSS7SnbhHASd5vixA==
X-Gm-Gg: ASbGncuMhIyQ5AfZq2yP+lv4crbuIt4GUxZDjpJBe2JnITCicmQnTMfaTmzv1NI42f9
	dFcwvP7vSayZsKBAMEVlD90bH5CsavQAFImOQtcgWiGb+eX3yUyg4bgLh0dAhyVpGhbGiZ0Vkpr
	DzM6UHtio9sH9kRUy/0zMHPp1y+mC65jXdUZ3qp9E3fFJ+G7IsI+OeBL4rLHRc9uXkOc8M6+gt2
	GL4BiwyIm6covo6XVC2veyb6QOGmZaXxSngl3ou6jexMsUMQsuviOupv56HSjoVlcHaOwHTXqKH
	yO5q6uYM9TLG0iT5PM68arg1/Aew2xztEiaBYw7z9tRsZMUSiVgEOkklzp0Hxcg5qmuwUuUaWWM
	N6aSQ1L9r70xqwiAqKbPreWF9bL51xd7gqVtL7GMcB5uqIL+eU9nsBs9W3OHt22xQzYSGfcjvaK
	g=
X-Google-Smtp-Source: AGHT+IHxdcUy3266eyXSssBtbkeApUpK7JMqwFGeHDk96EEUC8YbfPpTfZEL62FIMGc5+nwnvLZwiQ==
X-Received: by 2002:a05:6122:1e09:b0:538:dbc9:17a6 with SMTP id 71dfb90a1353d-53c6d5216dbmr1635125e0c.4.1755724421031;
        Wed, 20 Aug 2025 14:13:41 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-53b2bd51987sm3415842e0c.4.2025.08.20.14.13.39
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 14:13:40 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: hci_event: Detect if HCI_EV_NUM_COMP_PKTS is unbalanced
Date: Wed, 20 Aug 2025 17:13:31 -0400
Message-ID: <20250820211331.1923957-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This attempts to detect if HCI_EV_NUM_COMP_PKTS contain an unbalanced
(more than currently considered outstanding) number of packets otherwise
it could cause the hcon->sent to underflow and loop around breaking the
tracking of the outstanding packets pending acknowledgment.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_event.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 512041c68062..e3b76091f1a1 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4414,7 +4414,16 @@ static void hci_num_comp_pkts_evt(struct hci_dev *hdev, void *data,
 		if (!conn)
 			continue;
 
-		conn->sent -= count;
+		/* Check if there is really enough packets outstanding before
+		 * attempting to dequeue them.
+		 */
+		if (conn->sent >= count) {
+			conn->sent -= count;
+		} else {
+			bt_dev_warn(hdev, "hcon %p sent %u < count %u",
+				    conn, conn->sent, count);
+			conn->sent = 0;
+		}
 
 		for (i = 0; i < count; ++i)
 			hci_conn_tx_dequeue(conn);
-- 
2.50.1

