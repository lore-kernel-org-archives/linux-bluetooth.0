Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FF02063FA
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Feb 2025 03:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739418255; cv=none; b=sBfZdIELT9Noq4yPy3GfUld6Nxf8Af4iS1g8bskHLkRcSAdWRMLfZ1OJKDaQm+isBAkSRULEDLKgD/UwUKirYY8TdPltPd/yY6jtVfSHOIotIug8lAV8wVlny7/BuKK2S8Qs0nUc6/ernwXzPZXj608mfJubkjq9ntz5pekfjaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739418255; c=relaxed/simple;
	bh=lu+K44rTXY8XHrP1xqlITq2h780w9Fa06jttTuxcf40=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jFoYzvJ0T/8f5CenIN/8MfaQIkxC5f+aEobO+AQ1z78TDmqkH/brd6TvgqGi6RpJbHCi2ze/I9bfUGvfxdOQZBmWC4sSd3PcEbddRGs2LXaQZdUUOQ+ejWuKBU3ysA9x3OUmIq01jBRPUEm25DPLYih4nOGD3Gf3jydew3L8Jcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--chharry.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v075Jfi8; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chharry.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v075Jfi8"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-21f6890d42dso13594685ad.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Feb 2025 19:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739418253; x=1740023053; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zcMsAG9yErYMXfZzDMubfi8AYhSUZZ1p7DLoUqRwf84=;
        b=v075Jfi8n7uCtgaqbe5F+WzEuWXGSKYnI2Lcyda7koZH7aP4BTfv6N5+d4nqrRQc4y
         RF26+VhU5WLALz7xpmN3wcJqp4rRWNY6iNMYuaWJBCkRQ6ZXgGlSwhD2n4vx2htRqs/u
         DQHtDOoRtpOTIKCl9kudPwgipLq6HGNZ7wfeKqrSioVt1rDaDilTGehz8OhiNU799SWa
         FnhsgWom3vVi7H/n4ljOCYjZU2rq7Vd3iSJgjETsFK1n1OO5WiOO98hBWQVeYJt3XC7a
         k/8QgnZEuhOGaZ2zXEYr/E9yyT1MOxYdvfgY2kCzGM2gmG3W+d94BQbqzeGEVj9pQZxM
         mTRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739418253; x=1740023053;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zcMsAG9yErYMXfZzDMubfi8AYhSUZZ1p7DLoUqRwf84=;
        b=C3uzRdvNdlwkRNDi1X/3Xr18WFMlMIpw2PhVb4nIlEZHF1DY8ePOjukP9UApqtYFAj
         7hJM8slJrpvRfwKBCvw8Ov76j9Gpn2XZ7ZQE3qWL5mWJ42BuMFHGXQ0hIM3YhWVy98yA
         Qzsb/UZIqR+x2STqj/gSGfTzekpCI1Na9yu1+1tkGqZJfzId2hzOeaE36TMDupyzlJgm
         bLAJfU98dH3PuXYa4IljM50rQQ1cqflIBKUJbLms+SDBPiMXwsjYTuOg/jWsBqfOFlvR
         W7O4xEJ/qfDbMO8naugx+LdDX04cA8hCGICIqVQcajQOxxyTqfiZoJXAzfTopbYTZqE9
         4vaA==
X-Gm-Message-State: AOJu0YyRPFKVtdMy6wOb5V6wa1ohhjMC7aG7PzShKH7zWxBtwCgabdmM
	ZMFwstA7UVQzXWl9g4c5C5Dc8ty9+hL0e44uFh9JJGLs6EVbdEpXCfFxURHRF0VpCS0Xa2QALcL
	aGz6DDeIdNdRfYO42gRtREztOLcyB0HFEY/Cyg30A5/XODlR/upfJdAFQbMNmFa7/+726wI5Mj8
	Hck897YAlRDemkt0p/SKiY0xZlz8LI95Nhq2Vop3oqycnLU9Dklw==
X-Google-Smtp-Source: AGHT+IHK9w9UpX37k7oeAo+CDeYGncD+J6qpnDGzSPKR70jVF/4aze/v5ktbnZ+WivlFBRP2+EsAlWQGjIY4
X-Received: from pldp13.prod.google.com ([2002:a17:902:eacd:b0:21d:dca4:21b0])
 (user=chharry job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e850:b0:21f:78f:c178
 with SMTP id d9443c01a7336-220d1ec1f7bmr27790965ad.3.1739418253438; Wed, 12
 Feb 2025 19:44:13 -0800 (PST)
Date: Thu, 13 Feb 2025 11:44:00 +0800
In-Reply-To: <20250213114400.v4.1.If6f14aa2512336173a53fc3552756cd8a332b0a3@changeid>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250213114400.v4.1.If6f14aa2512336173a53fc3552756cd8a332b0a3@changeid>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250213114400.v4.2.I6e9e94dcded65e4a9ed42ad23ca8a5d81f680382@changeid>
Subject: [PATCH v4 2/3] Bluetooth: Always allow SCO packets for user channel
From: Hsin-chen Chuang <chharry@google.com>
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com, 
	gregkh@linuxfoundation.org
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
index cb3db18bb72c..01f84da27a30 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2132,7 +2132,8 @@ static int btusb_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 		return submit_or_queue_tx_urb(hdev, urb);
 
 	case HCI_SCODATA_PKT:
-		if (hci_conn_num(hdev, SCO_LINK) < 1)
+		if (!hci_dev_test_flag(hdev, HCI_USER_CHANNEL) &&
+		    hci_conn_num(hdev, SCO_LINK) < 1)
 			return -ENODEV;
 
 		urb = alloc_isoc_urb(hdev, skb);
@@ -2606,7 +2607,8 @@ static int btusb_send_frame_intel(struct hci_dev *hdev, struct sk_buff *skb)
 		return submit_or_queue_tx_urb(hdev, urb);
 
 	case HCI_SCODATA_PKT:
-		if (hci_conn_num(hdev, SCO_LINK) < 1)
+		if (!hci_dev_test_flag(hdev, HCI_USER_CHANNEL) &&
+		    hci_conn_num(hdev, SCO_LINK) < 1)
 			return -ENODEV;
 
 		urb = alloc_isoc_urb(hdev, skb);
-- 
2.48.1.502.g6dc24dfdaf-goog

