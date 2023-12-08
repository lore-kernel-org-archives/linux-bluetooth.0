Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r7BdHG8V"
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA55137
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Dec 2023 13:07:15 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-db5508d1beeso2740999276.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 08 Dec 2023 13:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702069634; x=1702674434; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=atKYixDgc1IYLIAixNFTtgRe8JLDt6J5MMwxSW6b7Pg=;
        b=r7BdHG8VStUbm+h4QyUFMMRIhoNDnQY0D3t/d7dmkMDYDKOyP4v1tYRszFTXTUO31n
         MxsZetvujkvUK41OaJBcqx0zUSrEdjFPyGJPUMcPxJK1oteunVwzTg48fuUuRaJAyy6d
         7NWpv1EzHYhMIgyS6r57tlO22qtO711ZfbkMCADPpV+OPF4klJnRZ+1UBbuOSSarB3G8
         NBAYeJHhb0DQHxsgNwPLd9ozu0J8gQMWNTD7YSwswLPzdhF+p2qVNWx/fzAendxYXIWJ
         pM63C4V06AW4dRnquvD5EepNv8eamaMt1UunBvdTvkKPajW05e5VgtXtEOyc1wcAMmMp
         Bh5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702069634; x=1702674434;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=atKYixDgc1IYLIAixNFTtgRe8JLDt6J5MMwxSW6b7Pg=;
        b=uvM/0n8VRFV6fBW5GpvFom0IgtmZ6LEhgU8plRdq9XivTeexGb2oFJ6fmdi6gZiO8x
         WqyhNAjU42MVoM5J3pn1df7/O/dxz1KY60gkMZ9K3aTqSQprLs4tVhCfbCzJc1oTI2mI
         W+qcZtGePqVIOMnNQCIoixCLLL1G62ce7H1XpJiB6zy3wHfVDFd0m4etWt9hDNYOX/dF
         LFGdymitMQoTWbYzyb8PL+xXcrM3H9nitcCPTL/5RFlnHCH6FN6QHf4F3jcjl3kl4A08
         hdCj477O6XuW5aT2Pz0Pe1Uv9XXqqO1MMl/JrRc7SFHWq4t86PNt/0lQwnpo6Pd9zeYG
         GNjQ==
X-Gm-Message-State: AOJu0YyahdseZUN1wpfwXGW5cnMW+/mdyp31A3XrNNhQPi/1feHRD+6t
	gwS6KVSd/1OShkW1TvZUYh5G4aZ35tiD4VYv/mqXExVrZM4bF1V0GcXHAbjbD57fLgm56GewzPv
	hvgM4mUUjYOH5mMyteyoY1nZZP3cOwlMcAoOF1lKPh0DcQo7ae4CDluMFYRaV/OgVsz1/P9ASEZ
	kv
X-Google-Smtp-Source: AGHT+IHzeDvqNFdRZWKrYRWtX4T16qXBWuRFYuGxk14i3a32wrWAEXwhbb0Cto5r9VdTV4zgSQTlXO1gQzao
X-Received: from jiangzp-glinux-dev.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:38e4])
 (user=jiangzp job=sendgmr) by 2002:a25:ce4e:0:b0:d9a:61d2:38ca with SMTP id
 x75-20020a25ce4e000000b00d9a61d238camr7101ybe.10.1702069634325; Fri, 08 Dec
 2023 13:07:14 -0800 (PST)
Date: Fri,  8 Dec 2023 13:07:06 -0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231208130705.kernel.v1.1.Ic5024b3da99b11e39c247a5b8ba44876c18880a0@changeid>
Subject: [kernel PATCH v1] Bluetooth: btmtksdio: clear BTMTKSDIO_BT_WAKE_ENABLED
 after resume
From: Zhengping Jiang <jiangzp@google.com>
To: linux-bluetooth@vger.kernel.org, marcel@holtmann.org, luiz.dentz@gmail.com
Cc: chromeos-bluetooth-upstreaming@chromium.org, 
	Zhengping Jiang <jiangzp@google.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Paolo Abeni <pabeni@redhat.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Always clear BTMTKSDIO_BT_WAKE_ENABLED bit after resume. When Bluetooth
does not generate interrupts, the bit will not be cleared and causes
premature wakeup.

Fixes: 4ed924fc122f ("Bluetooth: btmtksdio: enable bluetooth wakeup in system suspend")
Signed-off-by: Zhengping Jiang <jiangzp@google.com>
---

Changes in v1:
- Clear BTMTKSDIO_BT_WAKE_ENABLED flag on resume

 drivers/bluetooth/btmtksdio.c    | 10 ++++++++++
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_sync.c         |  2 ++
 3 files changed, 13 insertions(+)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index ff4868c83cd8..8f00b71573c8 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -1296,6 +1296,15 @@ static bool btmtksdio_sdio_inband_wakeup(struct hci_dev *hdev)
 	return device_may_wakeup(bdev->dev);
 }
 
+static void btmtksdio_disable_bt_wakeup(struct hci_dev *hdev)
+{
+	struct btmtksdio_dev *bdev = hci_get_drvdata(hdev);
+
+	if (!bdev)
+		return;
+	clear_bit(BTMTKSDIO_BT_WAKE_ENABLED, &bdev->tx_state);
+}
+
 static bool btmtksdio_sdio_wakeup(struct hci_dev *hdev)
 {
 	struct btmtksdio_dev *bdev = hci_get_drvdata(hdev);
@@ -1363,6 +1372,7 @@ static int btmtksdio_probe(struct sdio_func *func,
 	hdev->shutdown = btmtksdio_shutdown;
 	hdev->send     = btmtksdio_send_frame;
 	hdev->wakeup   = btmtksdio_sdio_wakeup;
+	hdev->clear_wakeup = btmtksdio_disable_bt_wakeup;
 	/*
 	 * If SDIO controller supports wake on Bluetooth, sending a wakeon
 	 * command is not necessary.
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 0c1754f416bd..4bbd55335269 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -672,6 +672,7 @@ struct hci_dev {
 	int (*get_codec_config_data)(struct hci_dev *hdev, __u8 type,
 				     struct bt_codec *codec, __u8 *vnd_len,
 				     __u8 **vnd_data);
+	void (*clear_wakeup)(struct hci_dev *hdev);
 };
 
 #define HCI_PHY_HANDLE(handle)	(handle & 0xff)
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 3563a90ed2ac..6c4d5ce40524 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5947,6 +5947,8 @@ int hci_resume_sync(struct hci_dev *hdev)
 		return 0;
 
 	hdev->suspended = false;
+	if (hdev->clear_wakeup)
+		hdev->clear_wakeup(hdev);
 
 	/* Restore event mask */
 	hci_set_event_mask_sync(hdev);
-- 
2.43.0.472.g3155946c3a-goog

