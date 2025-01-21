Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737D41B4220
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jan 2025 07:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737443849; cv=none; b=YfScxq0HOvFp34c8LzMCPujbBe6fwzIgAAPrmrls3i9oK/KfRYEj9+KJJL1bHcDx9ifHugJzcglIfRf3SNhLAQVUw4Pp5DwCe5fYib1OZgl32FI/WBRJ6vqJr5Wevy41tl+H9GFaKLOd89bAj+DIKt0WNM7WCNi0MVY3S9ey53M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737443849; c=relaxed/simple;
	bh=jQ87CgRVzDyOp9dueh8NPmWwYJLHFrM1gHXGzPnzSPw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jbvkxm4x9shbNgai/1vG512ygiGOJs80gEgAvBdhJoMgFyIjq6wvvD969z5cKQh2c+j7ekQnQj6lZ6U5DjwAj3gWffMT2OOtRRoCntwBqe6M6oaOOZ+z8X/IzbU8aU7RSA0LwS+HkMmchYdVz9sVXUE250lLu9gGfL7cteuWn+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--chharry.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r6cFvBvI; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chharry.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r6cFvBvI"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ef728e36d5so9955585a91.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jan 2025 23:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737443847; x=1738048647; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=A2exPbSO3ubIytjnK4kQUXO5XUU9Tw5TLkZu6eEM4fY=;
        b=r6cFvBvIlG7fRJjpJDlAcOa8a2RQjV8zGJAxZU0vS90j3mBJsmM7Fq8+A89frZktYB
         f21VgKrljUzfBRcC+xH0FmOomlyQtOYLvz/zzlXYk3ktyh8vaOXmrNetYsfPpF4yaaIS
         AQC4dW5VzbcC1Y5Rt+4USK4NL1dZkoffzc160JmXdxwmwXrExFdnOoLS7o9EqfUn93IO
         80CZVmyAbjWU8HfhiZkFEGfpJKaQHN4Q4PxC6A0T1cmbLghnorPZ+qSll3cE4L4OOzVl
         e9knDWPoKqeo0bvmO3d88L00JFrAXNam4DyZ4g+hyQZ92Ww16/L19Vd9xfsdN0kFNxbX
         wvZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737443847; x=1738048647;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A2exPbSO3ubIytjnK4kQUXO5XUU9Tw5TLkZu6eEM4fY=;
        b=US06A15tZpnk5axSpSHY7uqu5QiK7C7WB46kll6FytV6JXlu0y++r6oVcK77K5cpKb
         m+CZoDc2f5wBwZdCg9iY1d8AZQNnLG5njvATkZxdZxxObvsN9Q6nRy3AfFhFvTrQ+Xp/
         uI06T0UGXCMbKPE0pAM64hdJSj5Biy2wxftYOQuQ16d/C5ZCYG+zhqu8R3yIkYP7v4R/
         Vk5iTTTFc2oqq70P/iiji6xUgjxiPFTySPQtRS7Fik/v7oYaUtAI5QWidqpJEGaRFgDO
         rgZQTwzxepuIpUuk5YKc3oJZFmSXbKWqhoDBFgVNy9C7ilud2dFX4Vz4Clun6BeTLEZH
         GpiA==
X-Gm-Message-State: AOJu0Yworq6Un3bOztej/Ai2wRjpixtNQTO2miCJ69yxGAD/x26iaD9u
	AASmpGbU8/6/Z/8pxXgojjH9i1D06QrNM8SibXX5Pus1cod4E43XQoEsqT/FyxkUYwGKfiiOW8V
	XBVJJeO6GScLdgvKYnLtdRqnb29ub68KuwNqYcQSy/H0Ah4yhTs7Vu0ZuvaozIzUhKkWQQc7Pjj
	WAeXuiRupDPRfTo4g71a5N6TgcWbK8dJD1Vhbm13880WHRGshGtA==
X-Google-Smtp-Source: AGHT+IFgel7XKiHU3limKY/2zQzAzUIGlLvav66/T9760wE/2W8XZ+b97u3YoVFfXBy/rZj+GtxxGjWpOYha
X-Received: from pjyw12.prod.google.com ([2002:a17:90a:ea0c:b0:2ef:8eb8:e4eb])
 (user=chharry job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:51c1:b0:2ee:b2fe:eeeb
 with SMTP id 98e67ed59e1d1-2f782d2ea80mr19742158a91.22.1737443846702; Mon, 20
 Jan 2025 23:17:26 -0800 (PST)
Date: Tue, 21 Jan 2025 15:15:34 +0800
In-Reply-To: <20250121151532.1.If6f14aa2512336173a53fc3552756cd8a332b0a3@changeid>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250121151532.1.If6f14aa2512336173a53fc3552756cd8a332b0a3@changeid>
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
Message-ID: <20250121151532.2.I6e9e94dcded65e4a9ed42ad23ca8a5d81f680382@changeid>
Subject: [PATCH 2/2] Bluetooth: Allow SCO packets regardless of hci_conn_num
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

 drivers/bluetooth/btusb.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index f419d0827ee4..3e2d7ea6de5c 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2107,9 +2107,6 @@ static int btusb_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 		return submit_or_queue_tx_urb(hdev, urb);
 
 	case HCI_SCODATA_PKT:
-		if (hci_conn_num(hdev, SCO_LINK) < 1)
-			return -ENODEV;
-
 		urb = alloc_isoc_urb(hdev, skb);
 		if (IS_ERR(urb))
 			return PTR_ERR(urb);
@@ -2588,9 +2585,6 @@ static int btusb_send_frame_intel(struct hci_dev *hdev, struct sk_buff *skb)
 		return submit_or_queue_tx_urb(hdev, urb);
 
 	case HCI_SCODATA_PKT:
-		if (hci_conn_num(hdev, SCO_LINK) < 1)
-			return -ENODEV;
-
 		urb = alloc_isoc_urb(hdev, skb);
 		if (IS_ERR(urb))
 			return PTR_ERR(urb);
-- 
2.48.0.rc2.279.g1de40edade-goog

