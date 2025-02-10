Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A711CB9F0
	for <linux-bluetooth@vger.kernel.org>; Mon, 10 Feb 2025 10:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739183566; cv=none; b=WXTGaGaERSvcFOFPnVPfiG5iMCcLKgdCPxZjzQb0pKrv3Pfwyw03+rRJA+cEX6SRiVfagryXMPonbFSdxagXT/GoAeO4KQmOBLUUEsOZXtbddeatTFZOXpe7DxT3wiYJUPfO51zoeUX8v0nThM8Jm9hb5VfRwA4Mh5mf/cKGMmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739183566; c=relaxed/simple;
	bh=RBeEBtxdV0TFL7U8F2Piv6M/qiXMmMXAm4lOhBdCz/s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=npPwvRetPp2oOg+pOLh0IP+goOZPv+YCg78aptamVVqI2V/HzkdlrYBsiH4i/dG9lc0iUKDP7WtqEM6axvvHcIWTSQtbVv4ZogL5OUMExvWQT/koXl3S0pvJiXDAOMyxhni5KtH0sEjK8MijWBiid9YIYfkdMMFDxUjYlNDwRFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--chharry.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wegF4j1B; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chharry.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wegF4j1B"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fa3fd30d61so4578220a91.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Feb 2025 02:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739183564; x=1739788364; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SJn6DfgP7RlIBFjSG/lWHJ7YYj41dmbJZu5g2xSn4do=;
        b=wegF4j1BV8zp83HxLh8D8I3mwqyMhaAKLGow/9GBWxpWvJlp0721Y+PvlwDiRdE9+w
         ep/ExCJUL03HGJiCKY+rFM4cifX1q79stfP2qivZru2cngRICcVhxqkXmNZDp0DVtsLS
         EsgpKIFFMGe4kZuuwNWAB5z9ULMzyliSxH8bWf9ChzbUaerfFc0mMl95BPvknhNwOGPy
         NHv/rMvc1llEieMIO2PcEJ5IEelgJgp8eH4BT2UeFlRvNgKIU+NlKKAxmu2VPvnnnAAC
         g0J1T3teTFkY1ZlBQVHhAeiTslnsHb+BNPoDXJfpsYWlBSyGtvwfApr84KWXmJZnnZEk
         vrxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739183564; x=1739788364;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SJn6DfgP7RlIBFjSG/lWHJ7YYj41dmbJZu5g2xSn4do=;
        b=JphasB54aaPCdm6Dxq6q2yKreUO5WifMpyLG8jIJtHaHsKyOdN/ppcCAnupOC+8UHH
         lKxhI8wtlkOGHwgqHwXRpgowWP3sW9HWZou5UUkLte5PheRHtWRbCoIykodp+dnGxxG+
         OopsqBTgH/qpmOEnBtKvnama4zIhRzU64g7F+wFO4wjw5i7LjxsQIyWZ76TZU07/P/rH
         3gFxsFd56cXndKzZQzKzeWFNCgAwAvlsZWYvvkwD9r1AFIaScaMggEoRQAgfnlQ6lkQK
         FEc+YrRX7I+1dXCgMTH7PP/US8vhVHZ05fouT0ky4DocHYD1Gslik03eDBpqPCmdfjed
         lWSA==
X-Gm-Message-State: AOJu0YwhEuibynYC9Z1D2Wlbdth6/h4ynTXBJ9Sw5xUr9AgBLmHsXkBn
	jvGb1HNX84Snq0wZFE4thu3nZo5Ke6S5HJojDhO9c0s9c0KZRYdNil7yHMG+y6Zm1DbXSdMAe1v
	dlx5kdQK1CYx0+xpxLwrkenpM2hQyYVVDdEX1AkCldrKzB8NJW8mjjp6ll9Kbggh174U4J01tQ2
	2NsrNEOrZPtJdi+pzFu/73tJMV6sejSOMvB0u5D2vAxO6S7gNw6A==
X-Google-Smtp-Source: AGHT+IEKyNniA+ZpzetGjEraX4TkxjWzYquORsipJs8jlUa8Hyw2OSBPnaHc/dSdVQr9Rj2P5o11WK5XCA3t
X-Received: from pjbsl12.prod.google.com ([2002:a17:90b:2e0c:b0:2e2:44f2:9175])
 (user=chharry job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:184d:b0:2ee:9d65:65a7
 with SMTP id 98e67ed59e1d1-2fa2450d0abmr19849870a91.29.1739183564412; Mon, 10
 Feb 2025 02:32:44 -0800 (PST)
Date: Mon, 10 Feb 2025 18:32:25 +0800
In-Reply-To: <20250210183224.v3.1.If6f14aa2512336173a53fc3552756cd8a332b0a3@changeid>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250210183224.v3.1.If6f14aa2512336173a53fc3552756cd8a332b0a3@changeid>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250210183224.v3.2.I6e9e94dcded65e4a9ed42ad23ca8a5d81f680382@changeid>
Subject: [PATCH v3 2/3] Bluetooth: Always allow SCO packets for user channel
From: Hsin-chen Chuang <chharry@google.com>
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc: chromeos-bluetooth-upstreaming@chromium.org, 
	Hsin-chen Chuang <chharry@chromium.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Ying Hsu <yinghsu@chromium.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Hsin-chen Chuang <chharry@chromium.org>

The SCO packets from Bluetooth raw socket are now rejected because
hci_conn_num is left 0. This patch allows such the usecase to enable
the userspace SCO support.

Fixes: b16b327edb4d ("Bluetooth: btusb: add sysfs attribute to control USB alt setting")
Signed-off-by: Hsin-chen Chuang <chharry@chromium.org>
---

(no changes since v2)

Changes in v2:
- Check HCI_USER_CHANNEL rather than just remove the hci_conn_num check

 drivers/bluetooth/btusb.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index a451403c62eb..2bf6b37344e2 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2130,7 +2130,8 @@ static int btusb_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 		return submit_or_queue_tx_urb(hdev, urb);
 
 	case HCI_SCODATA_PKT:
-		if (hci_conn_num(hdev, SCO_LINK) < 1)
+		if (!hci_dev_test_flag(hdev, HCI_USER_CHANNEL) &&
+		    hci_conn_num(hdev, SCO_LINK) < 1)
 			return -ENODEV;
 
 		urb = alloc_isoc_urb(hdev, skb);
@@ -2611,7 +2612,8 @@ static int btusb_send_frame_intel(struct hci_dev *hdev, struct sk_buff *skb)
 		return submit_or_queue_tx_urb(hdev, urb);
 
 	case HCI_SCODATA_PKT:
-		if (hci_conn_num(hdev, SCO_LINK) < 1)
+		if (!hci_dev_test_flag(hdev, HCI_USER_CHANNEL) &&
+		    hci_conn_num(hdev, SCO_LINK) < 1)
 			return -ENODEV;
 
 		urb = alloc_isoc_urb(hdev, skb);
-- 
2.48.1.502.g6dc24dfdaf-goog

