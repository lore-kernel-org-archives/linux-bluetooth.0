Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793041345;
	b=EMPjSbuovPvFRDUz4Amou9ONHSyFJyUgKkRXVqABQzsRxsczlVXWhts2knfVGPEBNbis
	 RKN6dflhzf1pIuOeqOBx422weOZ+t2oJwwog19k+rY8JIny8WYCWacbHGI75vezVXQa3R
	 PbtxwJ63w+jv/EfaZcHTxvKFrWe+bKS3uo+e4O3k0Al0KYX0nIKYD11zR3Nj4CQPA+svO
	 3hK6qRS+QAVcvIAir1zvQ4dcvZbnOgHV1dIpffQ0n6jO1FTT4DgexF+2aNEh/JG87JOgG
	 uKlNCbRch3lfVCI980E5Bi1+Cb/ubOtX/co7Y1v+y0HFFQXobX3AbaL6Jp/OMpQCkBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793041345;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=C0/sOWlN1MqwJBr0A98O/WByIk4UA9hHkggdJ3H2bxw=;
	b=pmb7r+xMEmS1vrMe5e5xndFSeF5iblzRA9pW9vD5XgErh/Uvx6Yw+yLKFGAvMRbemCv/
	 72eJDcQnwchrmzbi3nUprjNoo++C3pq510tTQ0sq55io+5wIp+soo9wGeZOWGhlwsQh96
	 FRLghBQuOAmrwNnQK4xx5kkL7bDMS0eA6bL/uCpDR17Oc/0YPOHWKU0t+Yr58ewbHVAs/
	 s9TSmcJnFDf3MGKX8UYAb7JlusBG69/bV4nCrSF5W/UgkFc+vGpHj1RQQk7Y+eeGMmWaa
	 uzXPyQXvmz+H1Mvzi/iyA3HVMKl1jgsm6yW+3Sx11nJnbma6wrTJxC2ro13iVGPmR2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Hae0fN50;
	arc=none smtp.remote-ip=74.125.231.199
Received: from mail-oi2-f7.google.com (mail-oi2-f7.google.com [74.125.231.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2E3606A325
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Oct 2026 19:02:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A2E3606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Hae0fN50
Received: by mail-oi2-f7.google.com with SMTP id 5614622812f47-4b39374fab5so1424133b6e.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Oct 2026 12:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793041344; x=1793646144; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C0/sOWlN1MqwJBr0A98O/WByIk4UA9hHkggdJ3H2bxw=;
        b=Hae0fN50KSZf/ZM5NYrMRFb2a7Ij7HcbwqlV/tZqvdqCNbanaEhwTJ8N4NGCOG4Q/7
         Bln/ZGvQtwELoK2mrf3TWWyB3hAK16KWWQdRZbGlTXJO1UG1LqetbzGxkrooXWn4DGBB
         PWooVulvBduk7cEg9GdsNFTX7fbD9bnJA93iXxxPXauZ6fwxEjPLjIzxw4QaJZkm9t13
         7de6DclzVVvJhS4O11YeV4GiA3RKJyqNtKjl/rxSN+vn0IBQBgGQLsnz7g6rDo0SEg8V
         DerIsGiyh4nKaxRwsbLY6YlUVpWMnn2J/hcWKw/dxVc4SekvP4CTh7+N+C/P7l24FYrw
         C3hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793041344; x=1793646144;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C0/sOWlN1MqwJBr0A98O/WByIk4UA9hHkggdJ3H2bxw=;
        b=uClcvpPm733x+3J639eyGcyR9IvVNLEyXQSCgsjyztKibjwR4yxOGlEdBqnHl6T5wj
         rEK+8/R8nAG6UbwFFifkmTlor+InqrY9AHi+/oreY7tW1HEXKsMhStyFn7uhch/5VstG
         82jxc6MzdECTY72UZ14v1D+UbQ/H2dl3dljCg0wP/SwRoE7AvzByQjFRATSfwbtFua0z
         TRjXt1pxiZq+X1jc7abUNILVr27R16KGiIbETkL8T/5582+ynVo7R/rZu9eKiThzMU0/
         9ZIzyiVWynhS0hEJTroPyVIW0C9J+yDHFcJM5zERZ6p4DQ2JP7XjVPVfmbOtMpQGRaln
         MjkQ==
X-Gm-Message-State: AFq9FYI4lHSZD6vYJznyr7gWV01schTWVCcCNlYwBfw+3ns7Tomj7a1n
	33SNCk/Fl/mBMspv+qM6f8vAuCQTUNDhQ49Ffb4fhx403wiGbAx87yxK
X-Gm-Gg: AYBFou1sxRrXc9v/JSYMXzoaDbcQvnvERaTBJN9uKvAu6luCkoDUbnlEbwaX7qT3Cp1
	Gf52WVeOGYT9GcYgd1vsZ1vxasufsidbAGSB+T+pHeq9BZLt3OzCb4JoxyeZOeClFUfuSYDCFfC
	YOkexBQ4Njk0ATL1fAEyQLj2CJokP6A4hifDd0eQeLOONaRdql3+zP1LYJAxmjcZ16ww4gUDq6z
	2Br6GBpXsieMqUKiMqZmQFfjJze0NufBK1ebRwH5NPbHd448FdrdJRkGqoNxo3Bv2cHd/puGp2p
	WYUx7+vpUJf1yb5MNMDuJ4Tfialc0o3PMzvE5ol1Rr941zkWs4YO7lfBcZBW9zUPQpKWkis1fEE
	1k2uO3Qsx7rP6VQPP4pujV4FmgN8nvolsl5XQ/6t7wcHlrDoXxX+xUpGp0jagYXheYkADLzN/sG
	o8WgkYCFjfotnxoFKVhNtW0IHBDaxbOiHz3pr27th0PTTUf5PhJVV9IQr0mDqNwqHSnLhUD01cA
	w+tc7oG89oR1I0JR/r37qJ2S/g2z9KE5nIL2UxoxrXG4EyK15gqjlijbZt5eEWOGV/7/+Hlan9p
	YzjsaqDhEdwJedElAfZKUKS0AlvxjvfyO2CThLLoeg69yy+tDr1QIPUtiUkF8SS86FDXmesYymy
	1pTh3RK0Jo1fhQXdnFLY=
X-Received: by 2002:a05:6808:c2f1:b0:4f5:d3bf:edf3 with SMTP id 5614622812f47-55c0038dac2mr5576376b6e.59.1793041344128;
        Mon, 26 Oct 2026 12:02:24 -0700 (PDT)
Received: from [10.10.18.223] (wsip-64-207-253-118.tu.ok.cox.net. [64.207.253.118])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-55c04311a8asm5958356b6e.16.2026.10.26.12.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 12:02:22 -0700 (PDT)
From: Ryan Brue <ryanbrue.dev@gmail.com>
Date: Mon, 26 Oct 2026 14:02:13 -0500
Subject: [PATCH 1/2] Bluetooth: btmtksdio: wait while Wi-Fi downloads the
 shared patch
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
Message-Id: <20261026-rbrue-sheldon-upstreaming-btmtksdio-mt7663-v1-1-121792305f72@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793041338; l=3241;
 i=ryanbrue.dev@gmail.com; s=20260906; h=from:subject:message-id;
 bh=ddztoRYUESDPWb2PQYPya2Tntue+gD/4f8ofmkkWRzw=;
 b=Xpakt9Wyhh2fH44z/HY3v5CV//e6jdBro+k8eFbYlXhtJ3WfwmxDtQGqwSusmrwJNYH6TjbNb
 2hHcf/PxIVLDax2JTueLWoyqslFrC7Zmb2Rbz+fxerGE9NUNOiar/kM
X-Developer-Key: i=ryanbrue.dev@gmail.com; a=ed25519;
 pk=KsUvVaP//v/2q+ZBuacc7cLbsyEYn+AD71Sn28oZWKo=

On MT7663 and MT7668 the Bluetooth and Wi-Fi SDIO functions share one
ROM patch, guarded by a semaphore in the firmware. The WMT semaphore
query answers 0 while the other function holds the semaphore and is
downloading the patch, 1 when the patch is ready, and 2 when it needs
downloading (MediaTek's own driver: PATCH_IS_DOWNLOAD_BY_OTHER,
PATCH_READY, PATCH_NEED_DOWNLOAD). btmtksdio treated 0 like 1, so when
it probed while mt7663s was downloading, it went on to enable the
Bluetooth function on a half-loaded patch. On an MT7663 module
(Amazon Fire TV Stick) that left the chip unresponsive until reset:

  Bluetooth: hci0: Firmware already downloaded
  Bluetooth: hci0: Execution of wmt command timed out
  mt7663s mmc2:0001:1: Message 00000007 (seq 13) timeout
  mt7663s mmc2:0001:1: Failed to start patch

Map 0 to BTMTK_WMT_PATCH_PROGRESS, and poll every 100 ms, for up to
5 s, while the other function is downloading, as MediaTek's driver
does.

Fixes: 9aebfd4a2200 ("Bluetooth: mediatek: add support for MediaTek MT7663S and MT7668S SDIO devices")
Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>
---
 drivers/bluetooth/btmtksdio.c | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index b9563df72983..bb311986271f 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -234,8 +234,16 @@ static int mtk_hci_wmt_sync(struct hci_dev *hdev,
 
 	switch (wmt_evt->whdr.op) {
 	case BTMTK_WMT_SEMAPHORE:
+		/*
+		 * 0: the other function (Wi-Fi on MT7663/MT7668) holds the
+		 *    semaphore and is downloading the shared patch
+		 * 1: the patch is ready
+		 * 2: the patch needs downloading
+		 */
 		if (wmt_evt->whdr.flag == 2)
 			status = BTMTK_WMT_PATCH_UNDONE;
+		else if (wmt_evt->whdr.flag == 0)
+			status = BTMTK_WMT_PATCH_PROGRESS;
 		else
 			status = BTMTK_WMT_PATCH_DONE;
 		break;
@@ -842,20 +850,35 @@ static int mt76xx_setup(struct hci_dev *hdev, const char *fwname)
 	struct btmtk_hci_wmt_params wmt_params;
 	struct btmtk_tci_sleep tci_sleep;
 	struct sk_buff *skb;
-	int err, status;
+	int err, status, i;
 	u8 param = 0x1;
 
-	/* Query whether the firmware is already download */
+	/*
+	 * Query whether the firmware is already downloaded. While the Wi-Fi
+	 * function downloads the shared patch, wait for it to finish.
+	 */
 	wmt_params.op = BTMTK_WMT_SEMAPHORE;
 	wmt_params.flag = 1;
 	wmt_params.dlen = 0;
 	wmt_params.data = NULL;
 	wmt_params.status = &status;
 
-	err = mtk_hci_wmt_sync(hdev, &wmt_params);
-	if (err < 0) {
-		bt_dev_err(hdev, "Failed to query firmware status (%d)", err);
-		return err;
+	for (i = 0; i < 50; i++) {
+		err = mtk_hci_wmt_sync(hdev, &wmt_params);
+		if (err < 0) {
+			bt_dev_err(hdev, "Failed to query firmware status (%d)",
+				   err);
+			return err;
+		}
+
+		if (status != BTMTK_WMT_PATCH_PROGRESS)
+			break;
+		msleep(100);
+	}
+
+	if (status == BTMTK_WMT_PATCH_PROGRESS) {
+		bt_dev_err(hdev, "Patch download by the other function did not finish");
+		return -EBUSY;
 	}
 
 	if (status == BTMTK_WMT_PATCH_DONE) {

-- 
2.55.0

