Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793041349;
	b=BUf/4CjLs3Q9fly3Xjrh0e/cVTt/TmL6V9u9p98FE74C3Drf+JXT/I7RmCXjYNbjcGQb
	 zydkoiNkohUR8hMmFiB30+Iz65fjcIWIoMq7xNdyAMc4WTgmVcHy9hh7R52wCUXSvqSrY
	 G17bX3J/N+9uc/PM0QCl8rpF70EDatBsWfoyl9AAmyfXvo/3d8TPwWYfVtmqAswzmThNH
	 P2wIu8wguMCtSMVs/neuq9qyx64PXvCN2o8h596qd3+NFEuUHtOXx8RJlH2cSjhwrfMqc
	 OSaEanlYbgOBYu5GCf7+wvlsnJ6OiYpHEC3wNjOoP1kmAkWlFoSZT6CtMQwtBET3Nfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793041349;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=07HklJOx/r3iefKPdEdock1PeAL0doe52SrNOxBdYeA=;
	b=mWCXgfXSXoAUBDP9n7/eJbCwoD3bDlyIoexsVFv7UB8hTtlXPOXMpp9mJ1lIQCqwj/5U
	 zPKmdvsgmuJmBkPJRerJrMVQ/Rq5/qAbpLVeZXvbpPnpycN6CLxXyiOak/XsN2/kSCl1t
	 B12yk7M4liIKR7odSIo9QF36lv9uLuozHOjUbDEPENNVlpvmxWh3Et3dvgrHxCEt+cM5S
	 BH89MMP+PQPcHmn76OOUAT3oxNXJw8kqJq0G+fGeG8XSffyR9qcHKAyq/yu69tJGfmUb9
	 khncwV/kUxIQEZdYYdUmcs95SRw4o/Z+0l+kHSHDoNIHkLkKfqQUpP9J9FWD6sj/SMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TnnenxLF;
	arc=none smtp.remote-ip=74.125.231.200
Received: from mail-oi2-f8.google.com (mail-oi2-f8.google.com [74.125.231.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78736606A31F
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Oct 2026 19:02:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78736606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TnnenxLF
Received: by mail-oi2-f8.google.com with SMTP id 5614622812f47-53c4858eb76so1444434b6e.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Oct 2026 12:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793041347; x=1793646147; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=07HklJOx/r3iefKPdEdock1PeAL0doe52SrNOxBdYeA=;
        b=TnnenxLFhymQPrRGj/bT5b7R8zsqQEAG5VGSYdJgHuPySQq2gBq8UYjHwGpK1GjHTd
         kkBjuKqtu+SpLZkHsn3HqlbvWGcBErqMDpJEUje9BPtFnvGgg9647Q1YTrxMbGU+2gVB
         ue0v7N0u/gXJDPPrP4aPtzjkzanJ2662JzI3CV4agPqQRAqmojTkFu3/vvVYZGVJF2lU
         HicYkj6llmIDapSCRGksjP7aKI9o1f8GYWHlVyxC5kG1F3qjT4s7iXYdpKI43FCIpUeB
         VFdhcmbFol4+k3/thAo13kD/74ow0enfZX5+7ThsWcAAsTJ0q7ecV1bBaPHyRL4Lk9BP
         lN1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793041347; x=1793646147;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=07HklJOx/r3iefKPdEdock1PeAL0doe52SrNOxBdYeA=;
        b=q/8mFR44DPkClJy9+eYSxc+Z7MyvxgCMR/Zuq48l0dvRMiYnvWaK70aW879p31zBeA
         Er3TuXC6uplXmhzbcVdSPmcz/HQIji0HHMwC4lWiXxQ4j9WQgCkT5Lrc/jhwaBwZt06F
         J6QL0aHWeqN2FExnq09ujjsHe6Du7aTrP40EOzK+mmFNxBIr9MV6hTitctFYSKJfK0Jl
         PozWwOait6sM7UpcLCjr/4K3H+deWQH9nRWaJKUN2rE9ka1M8QcxGSdW6d/E8TyYeX/2
         R8jguEvzSGJ+JX5TJswkcaDQvCF43oTZ7n8vGl8yAUuoTMEfjcMsfvCC52HdwtEXW54P
         r8OA==
X-Gm-Message-State: AFq9FYJsaZNEZxd1x0hHBNtKMMugRg5rj4zxHM8xjHcYaSWncI23LhKE
	RRQBkScDJ4bUTo2S3I5i28EfyjxexUPsj0fCHFREcVrmnDWVbZK3ok5PqDRY5yw+PAE=
X-Gm-Gg: AYBFou0EhRhHLWJvO5a0L6OGFuAFTezSWx3bw2V2p9wbxAE4Oye7xkvWFBQNrSe3WoM
	aAVvc8lED9v++B657/Xat7D+MQo0bWHHT9SgRXZLWCpVvHSbKRvOrGyTx9VULZA2VC23wsGz8x9
	mjiwbv6EociL4hkeNhtHLHmQHFqqtwGOL782DCiQoE+L8Kisnmjn8365B9NSXyceNPewcxkzf2X
	1QKdpLVnm2NIMjKOQ9R7DJDZmExfpsxwmBO3tac81cqZuqWbdFhi4f37qjHjD0zoD++gILovxnu
	gun9HKWEXqZ8fZHJI0wIykSYFUgWagdvC8lfv5kZtn97uf7ouFhNTmCZlKQoMrvhvQ8pq7it8Kt
	1dTN9gVG2H63PaLRl7cfjHO+OdcUlU4nGKMeWRrjPRXQVB6kYYGpcx9+fgFJhaC/Op6QeC1WMfV
	AM6ruoaB2bOb6A8oppFiuDlH8lnCRgssS9lNIYH+E56l22TouB3+oDxVHw9uwjZL4YpfjkOeQq9
	W1YzI4wJDjzHLOSzmWbTjk572kKpsJqNK2nDZI3qStXAnK97+ftjqCSdJqXBAFBnjgQDXFccVNu
	1JZ36LiCNM0BqMhbZGYmumsjhrNA9lLqnC1+YOS1oK04uA==
X-Received: by 2002:a05:6808:c226:b0:4e7:851c:23f5 with SMTP id 5614622812f47-55c003fa3f9mr4544096b6e.59.1793041347210;
        Mon, 26 Oct 2026 12:02:27 -0700 (PDT)
Received: from [10.10.18.223] (wsip-64-207-253-118.tu.ok.cox.net. [64.207.253.118])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-55c04311a8asm5958356b6e.16.2026.10.26.12.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 12:02:25 -0700 (PDT)
From: Ryan Brue <ryanbrue.dev@gmail.com>
Date: Mon, 26 Oct 2026 14:02:14 -0500
Subject: [PATCH 2/2] Bluetooth: btmtksdio: retry enabling the function on
 MT7663/MT7668
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-rbrue-sheldon-upstreaming-btmtksdio-mt7663-v1-2-121792305f72@gmail.com>
References: <20261026-rbrue-sheldon-upstreaming-btmtksdio-mt7663-v1-0-121792305f72@gmail.com>
In-Reply-To: <20261026-rbrue-sheldon-upstreaming-btmtksdio-mt7663-v1-0-121792305f72@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sean Wang <sean.wang@mediatek.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Ryan Brue <ryanbrue.dev@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793041338; l=2175;
 i=ryanbrue.dev@gmail.com; s=20260906; h=from:subject:message-id;
 bh=p5no/S8PpFqMwynWIKqGncsBNwjfIsmYO/W2PvcD6mQ=;
 b=IJ298NG14mxx/gBOBanVXzZJRrSHN5am2KydNnQfi4ZzU5GBakO03eJI17yPJL1Tz8N0Tb2xS
 iLeV3zN+1+pBrri+wlcCSBgNRlJh/9gFw2i6TTiZ85XBNSg0HrlsWbj
X-Developer-Key: i=ryanbrue.dev@gmail.com; a=ed25519;
 pk=KsUvVaP//v/2q+ZBuacc7cLbsyEYn+AD71Sn28oZWKo=

Right after the Wi-Fi function of an MT7663 combo chip starts its
firmware, the WMT function-enable request is refused (the reply's flag
byte is 2). btmtksdio ignored the reply, so the following low power
setup command then timed out and setup failed:

  Bluetooth: hci0: command 0xfc7a tx timeout
  Bluetooth: hci0: Failed to apply low power setting (-110)

Check the result and retry every 500 ms, up to ten times, as MediaTek's
own driver retries its power-on command. With mt7663s probing first, the
function now starts on the second attempt and setup completes.

Fixes: 9aebfd4a2200 ("Bluetooth: mediatek: add support for MediaTek MT7663S and MT7668S SDIO devices")
Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>
---
 drivers/bluetooth/btmtksdio.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index bb311986271f..239393a15e46 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -909,17 +909,33 @@ static int mt76xx_setup(struct hci_dev *hdev, const char *fwname)
 		goto ignore_func_on;
 	}
 
-	/* Enable Bluetooth protocol */
+	/*
+	 * Enable Bluetooth protocol. While the Wi-Fi function of a combo
+	 * chip is still starting its firmware, the request is refused, so
+	 * retry it.
+	 */
 	wmt_params.op = BTMTK_WMT_FUNC_CTRL;
 	wmt_params.flag = 0;
 	wmt_params.dlen = sizeof(param);
 	wmt_params.data = &param;
-	wmt_params.status = NULL;
+	wmt_params.status = &status;
 
-	err = mtk_hci_wmt_sync(hdev, &wmt_params);
-	if (err < 0) {
-		bt_dev_err(hdev, "Failed to send wmt func ctrl (%d)", err);
-		return err;
+	for (i = 0; i < 10; i++) {
+		err = mtk_hci_wmt_sync(hdev, &wmt_params);
+		if (err < 0) {
+			bt_dev_err(hdev, "Failed to send wmt func ctrl (%d)",
+				   err);
+			return err;
+		}
+
+		if (status == BTMTK_WMT_ON_DONE)
+			break;
+		msleep(500);
+	}
+
+	if (status != BTMTK_WMT_ON_DONE) {
+		bt_dev_err(hdev, "Bluetooth function refused to start");
+		return -EIO;
 	}
 
 	set_bit(BTMTKSDIO_PATCH_ENABLED, &bdev->tx_state);

-- 
2.55.0

