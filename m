Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBB71C5D7D
	for <linux-bluetooth@vger.kernel.org>; Sat,  1 Mar 2025 06:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740810212; cv=none; b=Zst83f1dvIfNn6QPkpwve/WgeqxT39pHzuK/yAgsdFYXq13go+ifpGZegH6ZYfZexdci3OTTNkTPAhNugMoH4MtY4xskrSlHlq4FLUnWpWUtuzD/MmacCRY34BVZ2do5PXnHAVJ9RVablIJ3jCGwACHW3H55RvsB6cujBkhunY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740810212; c=relaxed/simple;
	bh=NtCHFKrh5PuvdovY0wXhRaOhpUVyFwT8jlTOg7twsXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZIp+CuEMskZMS92ekyA8Ar27wnuacVc/1kH6jSSHa1m00Gvkx9wxFVfjqeNwtI4M0Iq35aYgllUGJG3r8etEQcZAt7oMldnp9jBDuhvnmfo+DWjJ/tzqVCUauLUfTkNs/S/K0uJbyciJODYTe7SiHz5/k11WQcaVQczveZiY74E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KrizvvEa; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KrizvvEa"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2fc291f7ddbso4726607a91.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Feb 2025 22:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740810210; x=1741415010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1hYJLYX4np++SY91ganzp4cmHu4ThNjzoQRSKY1wlKE=;
        b=KrizvvEa6sCKxNgOE79DFRwbv2SwZ14kU4Lrc0RId10AVwUaWikHzUPYTdP/Dvs7nz
         LdzERvj+QnEHhN196fGdW15Ehsc3xvE0opqTxkTe2kQKfsSeoRWaYk49mgvgbahNVhsn
         +Rhvp38qTFQ0UYoTvD5m7k9n8TTl/HbRyZyvkXi60PnXi+/WQUfd2ff1Fz1LEttMMoj+
         3tm9nWGOgnZoWXc6WXU1ho1LZcu3MZH6wtmAh39ciV9seAxQOHet2wrI1CWi7vhGGJbE
         olxQG6epZ9Ap6Sc0Fc7qVIMyQyoM9JHWiVPJ5DzlDfPwFOjv/PzU4pH5nnI2g4ZJVqTk
         ddLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740810210; x=1741415010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1hYJLYX4np++SY91ganzp4cmHu4ThNjzoQRSKY1wlKE=;
        b=igmJSk4r3Kz6s/joWcvGU8lJs/DDt7Fi7Eo0cf0Gr1D7udI0mU70o+sMMhBH7AdwVW
         cV7H0OKaDtFU8uQkK8ZKFtgfB9PScr0D0SaiwM0J3EIPCqB+SlLAV9M+rJJP5PlnoHX/
         wfhFPzTgZZjjL0ifyyULEFNzDWYUxCZE7VxGyg8SHuWphAq8xnKzc0WwrDrHBvO4DPgm
         CjijwpCF5WpcGTOjIGPJwYsJy07AgsqWxOQTTSFWJax8Q/9GNCFVSS/npOcSTCstT0uP
         UpKDdgn3ppbCucfCMMftai1zVINv2KQBiFcYhLELtlPWNMf6qQ4SMgMrsZEZ3+Rnq/sN
         Yulg==
X-Gm-Message-State: AOJu0YyiED/9BrdkIac6aRELY226VCmD1U5TtoLgqQ1fgFI+NNG6UqMg
	RwjYcxsp2eyzu3WFi8as5GMVNWta6KcSzAOwDee/61llIuyD+6WJZcWJMZlb
X-Gm-Gg: ASbGnctqMmOcVF84EQpIFgp1ePOXFHPrvHdt4vW41Ei1TpUJwctX2I3dC6xxUOXzh2c
	qGZ7zZ/zyBwG3eAYy17lIh+JVezuS+mxW9aqXlwYTFJqO/P4+7OFaaD8+auZ1RsnrI5/ieBuVj0
	p5tpI5huNUzsNhxqppy8o/SQdYY8CbW4ukOvszvXo+cMktfwcwDKPOf/FTnTROvLU4BgDTMzuB2
	c0/0Y6Kq4fYeNP/R4ERP+aBi9bs9rH5F1riPw+oGEDAongvAurN8CXtWJqR9hO3tBKfzrlS90T/
	2ZnqsR3L0vNO73ZiUjW45wM2AJ9z4kLhv0g+/iZQdzrdnTzaHmbraB7/OKHcFGkYufwzdzaVkwv
	e6vmB/OaXAEWqBhSx43R6GEuT2Q7XyQ==
X-Google-Smtp-Source: AGHT+IHuVz0ldTBhVxAiuPFrKmH19Z8Ug/nqreukmkwH6uisXDC4rvkrVfskxLwAToViVJ6vOkLPXw==
X-Received: by 2002:a17:90b:3ec4:b0:2ee:f80c:6889 with SMTP id 98e67ed59e1d1-2febabe1e9amr11010335a91.33.1740810209601;
        Fri, 28 Feb 2025 22:23:29 -0800 (PST)
Received: from localhost.localdomain (168-228-202-55.static.sumicity.net.br. [168.228.202.55])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe8284f121sm7014625a91.47.2025.02.28.22.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 22:23:29 -0800 (PST)
From: Pedro Nishiyama <nishiyama.pedro@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Pedro Nishiyama <nishiyama.pedro@gmail.com>
Subject: [PATCH V4 3/4] Bluetooth: Disable SCO support if READ_VOICE_SETTING is unsupported/broken
Date: Sat,  1 Mar 2025 03:23:00 -0300
Message-ID: <20250301062301.18029-4-nishiyama.pedro@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250301062301.18029-1-nishiyama.pedro@gmail.com>
References: <20250301062301.18029-1-nishiyama.pedro@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A SCO connection without the proper voice_setting can cause 
the controller to lock up.

Signed-off-by: Pedro Nishiyama <nishiyama.pedro@gmail.com>
---
 net/bluetooth/hci_event.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 2cc7a9306350..88011fdb3673 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -930,6 +930,9 @@ static u8 hci_cc_read_buffer_size(struct hci_dev *hdev, void *data,
 		hdev->sco_pkts = 8;
 	}
 
+	if (!read_voice_setting_capable(hdev))
+		hdev->sco_pkts = 0;
+
 	hdev->acl_cnt = hdev->acl_pkts;
 	hdev->sco_cnt = hdev->sco_pkts;
 
-- 
2.48.1

