Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD55422D793
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Feb 2025 11:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739531840; cv=none; b=Opft/1nJdZxjWBhBeLnMq3u0o3FJJnFx03mqk06FjvxJwHW/QkCkWjX3VXX79RWOxTVRC4uTtBgJ+ky1IVmuPXOo4lc7BZ338/2k+ULEUVOlm71UUcikx3kHM0yUR2MCKPLht0mo5oMPRTUJ2prxGGv/9J3dGtmpkjrlNFH/2A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739531840; c=relaxed/simple;
	bh=TTra3h9T0Q3NSgH3cSLC7VMf+o3j5WRDFH3X3lNLLQE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=NBv2FH+29dCht6mjKsGKSBGbEXgbPH5AgOTX/dkRaOEGccoBUxSz3qt1SJEyIxeT3BxYerIGCLMt2EI8hD3fmDoyPzHMzXJOVeDw6M029t/I1wy6WzsKNoi4Xkfhr/zvP6wBkaW0h03Gmw3+B+scspLbjgg8oS6f5rBmjoYP734=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--chharry.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PqwHWiSY; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chharry.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PqwHWiSY"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-21f6890d42dso64068535ad.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Feb 2025 03:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739531838; x=1740136638; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vyd6VZvnLXfIOMtoaeKKTr15aT2gyb+Vo6m831IpGOI=;
        b=PqwHWiSY8xe6zv3Tafq/1oNzaIH9AJuLMomrj7JQqefQOk4Frjpv8Mf63yBRoKtTJC
         w5/cBgXVaH2NPGrsXEz4P5HSJv6upFMhvAEb7JxikgmMSm0cu/koxk90lo4pdG+9add4
         A/o9DL8qorzReRWLdPj9adz+Af6ntW1kQFh6OHjYfAH4X5gNXVLnmg0wxCIQpXxMtxEp
         sjIS1IdAIx01kY9kaubB877ZVuIJU4WpUumDekN+ra1tShTyyPj9WfHDijnOY8qhFO1g
         GuSSMgLP9L4a8xP1otdpHwxrYoHfKvrFAJGOktQVB2K76DmDagL7z639xwEBNBzA5YRs
         n1xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739531838; x=1740136638;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vyd6VZvnLXfIOMtoaeKKTr15aT2gyb+Vo6m831IpGOI=;
        b=eet9Dasa66HPMWNTmqjt1jtNqWEGUMN232HT7qXSNdeNDOXDsAk64Lbtok+7MLwXri
         nXuAPOZUR2cPkqPwOQ/EtJj82JVzGE9dwi7j+uQCrRdRaabc8VMq7an2fTQwlycKD50Q
         AHUzWsOE2kPPanlhF0BrhQDed6drCx+ol4WHuqzzsKcKDaZLkDPVELIPHHYHQO1UlB0F
         asyZHlVyQZMAXoiwqEL0sJNLK//6Sg5geOvznxmOP3xCPnTiI4wlKN9BasAu0oLjvnXi
         Pk+odkStPoHfwQ+Lvx/ER3/YxmS9bi+OwiVCfeIuX/TjOphXpBpvgtGguYnpJCEYiV8/
         DnFA==
X-Gm-Message-State: AOJu0YzGcc4JRUXR7LlMCPmCmUst/bT/jW5RYEu/AJROGcOiyPZHy4fo
	sdJPvLdSjMeAk63psurouzOISfszaq0uSa3D73GtY7+IRvuJbcfhPffs1ahD++0PPPTVL678DvZ
	MVyxzB0024mYAkShNPmH9qxQKi4kOwhDIfEwC8+gy8SqSTAWCBJg+OriGl+Ie1Tkk86jUVy+hba
	HX4raYaUSYWJxITXiUovVgURI5BeNlbl02JWNCAt4swZX+8dE0gA==
X-Google-Smtp-Source: AGHT+IFghr9P0HMIUaxBFgnQoWhw1CWBSpSlNf5DupB1nwEy99TDbtwc4wIvagfrECbSa84ztB7qdtZJJYLN
X-Received: from pgbbw41.prod.google.com ([2002:a05:6a02:4a9:b0:ad5:5920:367])
 (user=chharry job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:8c6:b0:21f:617a:f1b2
 with SMTP id d9443c01a7336-220d21616famr121726985ad.46.1739531838030; Fri, 14
 Feb 2025 03:17:18 -0800 (PST)
Date: Fri, 14 Feb 2025 19:17:09 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250214191709.1.I6e9e94dcded65e4a9ed42ad23ca8a5d81f680382@changeid>
Subject: [PATCH] Bluetooth: Always allow SCO packets for user channel
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

 drivers/bluetooth/btusb.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 1caf7a071a73..de3fa725d210 100644
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
@@ -2604,7 +2605,8 @@ static int btusb_send_frame_intel(struct hci_dev *hdev, struct sk_buff *skb)
 		return submit_or_queue_tx_urb(hdev, urb);
 
 	case HCI_SCODATA_PKT:
-		if (hci_conn_num(hdev, SCO_LINK) < 1)
+		if (!hci_dev_test_flag(hdev, HCI_USER_CHANNEL) &&
+		    hci_conn_num(hdev, SCO_LINK) < 1)
 			return -ENODEV;
 
 		urb = alloc_isoc_urb(hdev, skb);
-- 
2.48.1.601.g30ceb7b040-goog

