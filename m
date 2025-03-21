Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2BE1EA7C1
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Mar 2025 19:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742586355; cv=none; b=IH83B+RkpTKs95O3e7QDa8zxWlwD/901IHv9vwU2bYQl6pwEFvaV1F3M7x34sW2NvKLBUUGvG2llgoHA5tEPv917vmdd7BiD9vwhYnEgT5QNJmN4qBYNrIVXNx+9mTBJAgj1pdS6NwWip2MkN/aYEVOUEUxxiIkNQazExN3hX6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742586355; c=relaxed/simple;
	bh=BEugHfuWTTWwpom9bxqbBFACjK5cjiXEg+fSDceHnjE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bNMSkEHO0vkDhi9IMAuTloE0Ox2RTjHr7ArE3GgqrN3l9CJidCO1VzXmBb+/TCPaBHfjQjycikOSuOOOLpM0K1BJTwxUifN2thLhMV4iuV/4b1xYx2H3eMoKIkdMkwaOIOT/BY//wrW7ZAo4H2tAqDRNEsHiWi1vISqyMi8zonI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PoPG/ck8; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PoPG/ck8"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-86d3907524cso1011339241.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Mar 2025 12:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742586352; x=1743191152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8yUFzEeP23ae02zx94YcHk+D3FSZrRH8pMWsZ4/dLsk=;
        b=PoPG/ck8V/h8lHSIbeWIDluu48cx3HqGgyHY6ZJq5S+vgtpHYg9Zy/4FzBhEfu3jg5
         dlvV9+BtIdjY31/mM9b77wr/UOvjQZwksIfCx5E9yhkGJy8xaBbNZSvZC06DXW8AKv7c
         69KY2di8Vc6ubvGpDY96qdiFfSn9/Z/SpDR+flMuFKCtCOsgIljccOulb9Rwaoy5Bl16
         SBG3MjzUA0S/5LxVlq1APs5uzHgXDG1DV8Xc/s+nPZVV4EN9pP32/uXYmuQSprxRBUDd
         86EG9OjFA4/rj1w1xVIPAUQrVOhgpVbE3Lj3mzXQsswkXPwCPFSdjAbGfc5hWYudFm9T
         jS/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742586352; x=1743191152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8yUFzEeP23ae02zx94YcHk+D3FSZrRH8pMWsZ4/dLsk=;
        b=LcAIrqt9IXPrxr66bM/Od+BJb/pfaaIqtRP+mLlHzGZrKFUHR9a5UY2bUWDpNrGzk3
         X+f7evaQOQLQcnTcJ+3x6N0F9TDnEU1Kvf04Wnyj45fAzMAuQZHldi4kAM1QDS2A4go3
         fHGFWvrsX90YE4Me0Ch7rqbakRtyaiaJdXLyY98gKJy/qJomaM3DDvhQeiBpbvn5WVU4
         F66pMVwrGnIgyg9BHWPBo1TGCA0jgkMh1JBOFpv+0VnYgynoYpG8jpDBpGRj8Nxq7q4j
         xYHA7ppB8rGVgUBPWUMsIslE1hnFQYecMtFNWJslGrKx8KZ+hBiy6S+AI+7VlLa5yXWl
         IVHw==
X-Gm-Message-State: AOJu0Ywzf4OTYnAyGHmYPVjilZPl3xrQgyRbhOaTkmEHTeSWAeh/pvVE
	YFlrJgKuJWk3Y664MBxYf8EtglzFcPm2h41bkxX4SYshWejhuc3xp09wPh/Yvhg=
X-Gm-Gg: ASbGnctkHlc4IjhMsABW7F6QLaXpquP9GBuI5IQTxXA6YjSV6YVL1yRvT9jVs30fJ8S
	vZStV1mmfS13hiKLbHG7uXZMBWky8QE61p8I8svUp3RaHR6k12n078xOeCQm3YMqO4yVHC6zqBq
	JXtecScE+DUy48CtD3e++b31ElfmooFxuJnH7Q+lknLYSOJez75cJThUN46UQ02nI3tFPTWplVU
	7tqILFz7uLAVVC8uEKoSmK7pT3v+cpSVy0vVSQww7uSYeYA+ML/sLAtnE2y5ep2enDD4f818f2u
	RWSYWBLEpKtzNGyKsi5AT9128ImR7Sh75NvfAZA39Lh0awCdZX3raPrN0+175sYWX8WLQSxNqNu
	DwXG8OGg/fSNwRw==
X-Google-Smtp-Source: AGHT+IFE9+ZgxjLBSNnjnMoLQwyXCpRDboqhpeCxVvyJNWdg4Z/FnFdlik1fCC4R626S7Tw61GLrSQ==
X-Received: by 2002:a05:6102:945:b0:4c4:e0cc:fb39 with SMTP id ada2fe7eead31-4c50d4fd939mr4703392137.12.1742586352405;
        Fri, 21 Mar 2025 12:45:52 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-86f9f47a3a1sm519917241.33.2025.03.21.12.45.50
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 12:45:51 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/3] mgmt-api: Add LL Privacy setting
Date: Fri, 21 Mar 2025 15:45:44 -0400
Message-ID: <20250321194545.1728631-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250321194545.1728631-1-luiz.dentz@gmail.com>
References: <20250321194545.1728631-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds LL Privacy (bit 22) to Read Controller Information so it can
be propagated to the likes of bluetoothd.
---
 doc/mgmt-api.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 3181607d94fa..2fe8ca22b9b5 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -336,6 +336,7 @@ Read Controller Information Command
 		19	Connected Isochronous Stream - Peripheral
 		20	Isochronous Broadcaster
 		21	Synchronized Receiver
+		22	LL Privacy
 
 	This command generates a Command Complete event on success or
 	a Command Status event on failure.
-- 
2.48.1

