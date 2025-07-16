Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D02814A09C
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Jul 2025 13:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752674037; cv=none; b=uywxfARD1k93yUqsT7AZIqPxUDRMHV3rYlOx9ZEfdILxfZZZxz7O9nNSzS+G83Iv8G+I+jlusha/R64oSYKDKy9DMEpNv1pwBEkMTe6BI4UA0cb2ABvX2pfxohWl1OxKHtduov40DLCsvuuSQx2eyyLzllnXmIXQ8qEIA3kXXwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752674037; c=relaxed/simple;
	bh=a8ADoDdLadUErr8Gy9rnqDRoftmmoBatiJf2kGhwUvU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eCIGH3XN62RiHYO+S5nC15kMnfyslFLsLyK2dB7IQPDChBrKgAaVs8+sYP/GbEyBzCWzxXGPdPpCw/cFZLmlnCOTl6PNEBxX41n+e8VRBPqeF+kTyXKdjVv8qHnAd5IeA3PCa7BYYLGQyGDq/tt6ftOYHr1Dsb5h5CwhDFyDnJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UomOzlbw; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UomOzlbw"
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-87ecac3e17cso2647077241.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Jul 2025 06:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752674033; x=1753278833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=zPn0CxUo5++A+bf2BFFOkHvNholFRJ93i9nDO/2c1ME=;
        b=UomOzlbwMJslVVKq33JZm2799w3lumMogPsTigdXrvMoCIM7Bmai5kXFsOH74mBV+Y
         uynuGbEw3eG/id5kyyDX3rIK9waRWDKXu5UlYp5APN0+XV3AGcYlfVgW1Kk/YtTU8JDQ
         TuwiL8C5wDR3jOcGbFO6cB9T7A3HaGOPZ2McWcFWkYpSx6Ob2wG54767bIrATvGSksQ+
         jNYJwOIl+bU47euN7IScy6tHOy9r9PZoKMLixKv55EFcBUzkBFHpqwBYtR0WlxkQRzeK
         re1lWJ3YvJV4cWLOUbfNOsRTZF1GT1a6+XYT8p1L/Q/Pv0hQaN3iI2UYGtUwUITUUbuI
         tcEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752674033; x=1753278833;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zPn0CxUo5++A+bf2BFFOkHvNholFRJ93i9nDO/2c1ME=;
        b=IOnNmB3mWl48UnVf4fU7u2uBxxJHaEtFYDJg/p2KzsIOm5xC/pHc75hTvj7N65Z3w6
         fnEo6rLKgW0TN4FKMpQAjlxjaQIJocQ2zG/AH1gRhPjKCu7S0GrenRoMs9UPuuc9axbD
         kPZihGS6sJ6WpTtIzvEdkwoqDqlxKKjuq9ITxRRfZ6bSYt6tRlKAI7WQidgg2uGKpABC
         GQrd1lBm0dfFTpjHgv5Ja13GXDgPHGhxXDbkfe68qjBNizUDPGdoDResRIUOcxjIjfhY
         iHNncgOrlwGZjbsQJigKCLRkGaua4Er8GZa9BctSXxPPI0WRTMtXmWWGCYLerl6Udr4m
         eC2Q==
X-Gm-Message-State: AOJu0YyV13PHlkjminI1VVWyB1tL+5E3UT4GLxf0kxzF0bV771kvmWvW
	mVAmMBXiR5dWbXbavVm99WAgkmwttQyKVe0tytS+8IEpDebG1Y853oBOTpzcYg==
X-Gm-Gg: ASbGnctNDjE2TOmA0cN2+0uhdHGe6Jreos9AsiTPj7PYHrZnOecfLEigKUyIPK5h9Di
	VBoYe8M8gUGCX5L9ff8lA/n/iI0RLtKzz9WUZqgWxTvBjNg4s7sdfPOZaMqKrPrFrrw+wNNFEn1
	bYClc/pGUZeYljck5+EGKS2txx1I2+xmY/YVm4tLf5dLxMey703iui3xCDPBnGkQOzTvq0vktlz
	Blns9oyeauFwFQpHzoPYjEsdlbeQiw03j21+etkJ70wEYP3as5Hf1TnAXxD9xNmzeEI5tlm9lOc
	RPiNLkdRkxAI6+qUNG6IxOVBkkgTEixd2Cg7PccnTN7qjSy8yDgYJ7TU1L76kBppqb8IE9CAdAl
	3xdPCQ8NyHy4z1CI5NrrJc2A6tfVZEVsCoUVX3Km8FvSUtA0y8RrsVGyte/drUoG4
X-Google-Smtp-Source: AGHT+IF9wu3OaU+9lDEmFZB3B8kb1NlzBwX6hVlqWybUS/azuWfE0leOLLJowaCSEJFlvttcn4Qeng==
X-Received: by 2002:a05:6102:418b:b0:4ec:285:72e1 with SMTP id ada2fe7eead31-4f955aaeabemr1002061137.6.1752674032575;
        Wed, 16 Jul 2025 06:53:52 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4f62faec4a4sm2458497137.21.2025.07.16.06.53.51
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 06:53:51 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: L2CAP: Fix attempting to adjust outgoing MTU
Date: Wed, 16 Jul 2025 09:53:44 -0400
Message-ID: <20250716135345.162225-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Configuration request only configure the incoming direction of the peer
initiating the request, so using the MTU is the other direction shall
not be used, that said the spec allows the peer responding to adjust:

Bluetooth Core 6.1, Vol 3, Part A, Section 4.5

 'Each configuration parameter value (if any is present) in an
 L2CAP_CONFIGURATION_RSP packet reflects an ‘adjustment’ to a
 configuration parameter value that has been sent (or, in case of
 default values, implied) in the corresponding
 L2CAP_CONFIGURATION_REQ packet.'

That said adjusting the MTU in the response shall be limited to ERTM
channels only as for older modes the remote stack may not be able to
detect the adjustment causing it to silently drop packets.

Link: https://github.com/bluez/bluez/issues/1422
Link: https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-/issues/149
Link: https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/4793
Fixes: d5c2d5e0f1d3 ("Bluetooth: L2CAP: Fix L2CAP MTU negotiation")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/l2cap_core.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 40daa38276f3..805c752ac0a9 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3520,12 +3520,28 @@ static int l2cap_parse_conf_req(struct l2cap_chan *chan, void *data, size_t data
 		/* Configure output options and let the other side know
 		 * which ones we don't like. */
 
-		/* If MTU is not provided in configure request, use the most recently
-		 * explicitly or implicitly accepted value for the other direction,
-		 * or the default value.
+		/* If MTU is not provided in configure request, try adjusting it
+		 * to the current output MTU if it has been set
+		 *
+		 * Bluetooth Core 6.1, Vol 3, Part A, Section 4.5
+		 *
+		 * Each configuration parameter value (if any is present) in an
+		 * L2CAP_CONFIGURATION_RSP packet reflects an ‘adjustment’ to a
+		 * configuration parameter value that has been sent (or, in case
+		 * of default values, implied) in the corresponding
+		 * L2CAP_CONFIGURATION_REQ packet.
 		 */
-		if (mtu == 0)
-			mtu = chan->imtu ? chan->imtu : L2CAP_DEFAULT_MTU;
+		if (!mtu) {
+			/* Only adjust for ERTM channels as for older modes the
+			 * remote stack may not be able to detect that the
+			 * adjustment causing it to silently drop packets.
+			 */
+			if (chan->mode == L2CAP_MODE_ERTM &&
+			    chan->omtu && chan->omtu != L2CAP_DEFAULT_MTU)
+				mtu = chan->omtu;
+			else
+				mtu = L2CAP_DEFAULT_MTU;
+		}
 
 		if (mtu < L2CAP_DEFAULT_MIN_MTU)
 			result = L2CAP_CONF_UNACCEPT;
-- 
2.50.1

