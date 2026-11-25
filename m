Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795608789;
	b=jvQZMQVffKqD44C8tgJTlMCT3Bh9aU1vwQFFZUePZxU0zKKimnkhK0E33OYfCRQnEYwl
	 BOV71KkvQW7mTBNo6lo816HUuDr+zzQRhdFLbkfZnIO7z5BOzkOvM/AQXkZoQ16jkUQbj
	 uvWk2wD8gYpS5Env7o8z+x/Zo9zXS1WblsnBZ+BrHE5MyN5rwv5ZUBTSHPzNitI+6hmt/
	 5oMxMnliicG62xvX5aOqO8J6ZVAAn56IGxBdIfRQMZnpR+TXbLUS1GJ+D8h/sTZRavSVr
	 gGq/yqXEbmA6NtlgRErCd5zUDzdDULXNG3tWug4sAyyteCtF9Jx1jdN3ncq9HhFVjDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795608789;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=vRd4AYUmDP6PDQXFkymBQOyyWyrHE2LAQ5tf0HbrYuc=;
	b=yij1U7/i9D6e8xky7aQkQlMw3PQ0t368TKgEhI0JCZzTQzN/C2Nly1WzKFUMdhGktY3W
	 P7eN6PBnB3eGb/9XUXfO9IvlWwmEAs0XB9KufYHsGyiARYgAtQ4AeTRqBx0Gf+9OE8ZVf
	 K+SEw87KiJAeRWucSviUf6VPg7Ppwl1buSO2sI9Iw7ZLbtcgl+AP4kQDxEZ3yEjSnVXS9
	 pTaakiYJQ1DI3f84Oe0hgdb16ShzMDErI1TuM44mo6je4nDGT0z8jmIUCOM7SVhTbJE5U
	 hCl7x9F4kALoRYdJHCsPdThtJWOg5eNKfh3JQz78mJD2YTurMm1OaqRl3xUHsNSf6gQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LBzYXkZ9;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE30606A321
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 12:13:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2DE30606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LBzYXkZ9
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-3863db981d4so7923045eec.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 04:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795608788; x=1796213588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vRd4AYUmDP6PDQXFkymBQOyyWyrHE2LAQ5tf0HbrYuc=;
        b=LBzYXkZ9xbChHU9/6a1W7ArjG0YaorCeIoWviJoJHETeE2zAJrCFBOdHBh6hKbY40m
         icd4UfoFlu2+VZYQiHGX4jqWLw/Zfv4S5m/A9tGZANIxHQ+cfZJxeZ/NvrSe8K42fRkR
         t3DXzIvjM6t8wrF9adONuSNGUHlH2uQghecyt0F9aE6I+Asx6CVuyKG0qdRDn6EUnQOl
         kS7+eGHE4zrZztUovgtN4XQw6cXdUonToGMv1F1tn7OmUfm5Skm7cWBECyLw8a5TpxBn
         XaaGugjtk3EhHsGf0sn2ZCVAHd3M0PkOMmJlc5cauvX72a/kUO7CrXPkNPQDa6ERS2yL
         wJ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795608788; x=1796213588;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vRd4AYUmDP6PDQXFkymBQOyyWyrHE2LAQ5tf0HbrYuc=;
        b=tfPKtOLtlmxmUqpJEkQ8NmL3d/yPxsbPr0NCU4oWDDd5PFWwMXI6Po/urConvA1/SG
         cF8y+dMVuJLZnZpnlUc4+SyM7diXxElbmurfkJrgItvbidzuK0xIHNkW/aIt58Hz4+st
         EPNNPQTWrW35EJWpcjwg5umpDYN1FJh1ZZu0NIvra/JV2JN4YWQ18VdSIE+BBhnlSeyj
         4oBF3YAagooaoGzrZz+eg/twYi8KpxarzGPQxfOvqECfQw0jsVoJe1NQSOb0RgsLnyB7
         hc0EvWGsPAPnDfsbvpBXWxquE/0ZG6m7FPMgsXbfJkB1R8GVgcgmIxweQM1ytIe7KW2+
         wGXA==
X-Gm-Message-State: APuU4Z/c6eC7Y2evz2ki1YkwQLsXQ7VVm/Zfx6czoKUBf+tk51w/L0b1
	6u/6xy6ok9B7uWS8dzWFJpB/b5pnQqThD7XIoozfjqICdRPcNyZQcOQ0
X-Gm-Gg: AZFdTZfHNGY0UVuYa9e0EK8pWJGcvuvmYgd+bQGpmmsIE6QsR1pRWha2xkW7gqUuS36
	ZzBvB2moH6p2jymoXii6Ph7DSl6E70JtbTMQPaQHeROlC3g2bvQJ8wDx/q9L3q0pDlMCA4cWsiT
	fmIFZxhjN8JYzJ1ZzQqZn0GqXDC+HOXwZfd989ZXlWseE/qvbFqq0d2k2oS0wZmYKzsq3QhkRvr
	sRoV43LaKJR9KldGUJ9T5VKtBDx+O3ok0db3QCS7l9BjhjNHmCyhSeQIQ58xjvveMFdvuChfKkr
	VQkuyDzndvJweRtAk7QkmNd9oUGjkNZWUbG7OGDkne5r0T9lVSkQrG9JisvJQ7d56wyaYRuc3FC
	qMemHOd6ZWk6eG5BWSFZ/wqnBAkQOaVznB+USIIUQ8lxVGDwk3di3Np9Hr6xqXNUXBkJfj0xqeM
	0SbuyRR6ClaU5h8IyeWhDHJoVk3BHvVrvIrsC8o0cfXF6zjg12I3lJU+Y4Unz7NHLERWc42vEzO
	PPcbZ8GweLq9xG0XfUc6YhCc+mQdsNEfKY78TvCrqMOppfxmKbzgWPlCJSlCBe9lCFxbqzvAOTm
	a+0BIhw8nP/AzSHyi+cXetp21j8jstMnEbl26Wtc/GsaO61bytMOiaFgd4KDa7gheXiY0LbIepA
	=
X-Received: by 2002:a05:693c:6390:10b0:386:ac97:f670 with SMTP id 5a478bee46e88-386ac97f867mr9397986eec.12.1795608788293;
        Wed, 25 Nov 2026 04:13:08 -0800 (PST)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386992b404bsm41333439eec.1.2026.11.25.04.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 04:13:07 -0800 (PST)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: btmrvl_sdio: Bound fw dump count by memory table size
Date: Wed, 25 Nov 2026 20:13:04 +0800
Message-Id: <20261125121304.1602985-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
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

btmrvl_sdio_coredump() runs when root writes the coredump attribute. It
reads the number of memory regions, dump_num, from a card register. Two
loops then walk mem_type_mapping_tbl[] up to dump_num, but the table has
15 entries.

If the card reports more than 15, the first loop can store a vzalloc()
pointer and a size past the table. The second loop copies from the
pointer it finds there, then frees it.

Limit dump_num to the size of the table, as commit dbca9dfd3bfc
("wifi: mwifiex: bound SDIO fw dump count by memory table size") did in
mwifiex.

Found with a CodeQL-based static analysis tool that we are developing.
Reproduced in a userspace harness under AddressSanitizer. Not tested on
hardware.

Fixes: dc759613b024 ("Bluetooth: btmrvl add firmware dump support")
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
I used an LLM to help write the harness and this patch.

 drivers/bluetooth/btmrvl_sdio.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index 4fd241693a10..cbf63e737ff0 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -1378,6 +1378,10 @@ static void btmrvl_sdio_coredump(struct device *dev)
 		goto done;
 	}
 
+	/* Limit the dump count to the memory table size */
+	if (dump_num > ARRAY_SIZE(mem_type_mapping_tbl))
+		dump_num = ARRAY_SIZE(mem_type_mapping_tbl);
+
 	/* Read the length of every memory which will dump */
 	for (idx = 0; idx < dump_num; idx++) {
 		struct memory_type_mapping *entry = &mem_type_mapping_tbl[idx];
-- 
2.34.1

