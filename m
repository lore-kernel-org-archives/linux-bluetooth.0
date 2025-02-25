Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D6A2135AC
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Feb 2025 22:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740520866; cv=none; b=bqmZB1MqpayKBZQbapx2DqpkRbnKC0MwTY1UCxfWPIHosgNQenIAYo83bwiuS/EOkBpwLZW/fWKUWoGPsCoqioF9mGzOMne/XnF8QeLWSC1wTvTPoNkpUlfxZWmlLhK/ujLcAOfDZ4Fuipl3rDaC/jgZRK/goYLbNna0/C3r/js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740520866; c=relaxed/simple;
	bh=u4D2ysouWFu5bTZIUpNIs3fhNumzbXtmogCIuiOZa5Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=obgy1TbBUIGU+/2whByoZhOVF8/tczc1LAxj4lVTVA3Tkom2O6+xGbNmX/EFnovJFKlg3YynGZsVnBhisAnTIEVVFhmhyC6Mr96/GNgEtVe4nkj7jhWSygbKro7PRGuSqOwSYft3K6sD9QEGWgqyqWwLloVddiow9J6/RIfoGGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m/n4Y+Nt; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m/n4Y+Nt"
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-4be5556aa27so1697215137.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Feb 2025 14:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740520863; x=1741125663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=DtVsiCTPXcLKZohphQdspl/F7ltUoceFtEFau8xmyg8=;
        b=m/n4Y+Nte8Y09ibQyew9Sk3tmq5bCmrBO6T//gBzIlj4QtwIjoOsYGn9C/lwzrkQX3
         O/FW7b51yR5bOpP5FBb7sDx0tdaRxwOVcKifguo70rl0ZxisYgH6aJqN1zlndYi9gJYt
         VFFRKLWHmBMhFJAliep1K99HJ99uNfRj9RvF2tfIxlVSxeANuUeZSswWDEVMY4D2T4XW
         tFYPhkr6qxmD679JM2vWwQaaeX6eTAQFy4FFuWNh1BtKiwNuSDSpPenCASbCfCQEMQ32
         svyjsxpu2g00mqNjAJav/21BG7Fkug8SKVv5Dzvzu187R41TdqNetJeKEvLWWhvwV8qe
         FqoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740520863; x=1741125663;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DtVsiCTPXcLKZohphQdspl/F7ltUoceFtEFau8xmyg8=;
        b=LYGNArtPhBVCtgDVwFA0UNsUFBVfcU1+nPaUlEwhjA7wIPtpyIzdMGa678HopvUNPD
         xtfhHfs0sNOFrSc4fozKlCLpgdQtVrXO6WNbPO8OAagQz8j17nsfZqBpsts5JiP2fzyR
         4Prde+jikAZy0yZu2CgvhsEt0qSOYjh/VC+HIUtsoO1iDaoVmVE4eKhdbv9gjt9u+Lx0
         Ueesd7vCXoyKYeexawxBqm0P+QPQIURiS56ppsCDT8xNNsE4cuoMyx1gK79s5efRDmxK
         dfhdMYz6lp1Cy3iz0mKY08S7vAm603zbRkKl8bUUz43qb+RwFG80wY0w26/SjynLNrDk
         BbHA==
X-Gm-Message-State: AOJu0YyW+jnfYSvoEyjy/RppUUZR2SFBnVWqYsuB37kmRIyBjyuUntOL
	gDMAKYRRkWnXldm4pyT4ftGOF07RB34+7frimMd38fP0InrKiwgP0FjYhdlw
X-Gm-Gg: ASbGnctOEcthSwyWmtcmGGU5+Z9/WH2YH9MPnmYfi1nFIyhDjqdXZUG9/Eat9ltVeQy
	wQqRQOyAaOr04UdOim9Wr5Sq8ZF3h6EPr9kz8dIHeYIgWmuCRCQxD5klC3nxiI877t5c+d6XWpb
	IIQ++L1gG3/PHKiP4qxK2Smtt+bnvLSfZSsjqMyphct6FCOPH6rF5KpoX3FUtO+kk+9I9BlQFxc
	ekC2HdJJLG3sZTj/zsuXbNOCONE9L9adsWVT+LGn2GmXVeBiPuzJtNE+8I+BHLVZLGZwgaVf7tA
	21rq3djDXhN0VI4lf8NJaLvTrO6yPgfZUeIBWapWJoBOz+IiMYLHNiPTwbfS12OL6RBdBog=
X-Google-Smtp-Source: AGHT+IEBtQwv+ZErVVeR7+gS9xb+SWs/hER2TMJesI/edM5hJd1+pKKl+uIlGF8JRppcoGzRxsLMMA==
X-Received: by 2002:a05:6102:c87:b0:4b1:14f3:5d6d with SMTP id ada2fe7eead31-4c01e1bdc29mr550186137.6.1740520863173;
        Tue, 25 Feb 2025 14:01:03 -0800 (PST)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-86b1ed4e428sm494863241.13.2025.02.25.14.01.00
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 14:01:02 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 1/3] org.bluez.Device: Introduced PreferredBearer
Date: Tue, 25 Feb 2025 17:00:57 -0500
Message-ID: <20250225220059.2821394-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This introduces PreferredBearer property which can be used to indicate
what bearer shall be connected first rather than just using last seen
bearer which may not work always since it seems some devices sometimes
advertises on LE bearer but expects connections over BR/EDR e.g:

https://github.com/bluez/bluez/issues/1092

Also with the introduction of LE Audio this might become even more of a
problem since most likely users would like to select which bearer to use
rather than using the last-seen policy.
---
 doc/org.bluez.Device.rst | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/doc/org.bluez.Device.rst b/doc/org.bluez.Device.rst
index f8d4a68a6b41..13328249b0b0 100644
--- a/doc/org.bluez.Device.rst
+++ b/doc/org.bluez.Device.rst
@@ -40,7 +40,8 @@ void Connect()
 	are skip and check latest seen bearer.
 
 	3. Connect last seen bearer, in case the timestamps are the same BR/EDR
-	takes precedence.
+	takes precedence, or in case **PreferredBearer** has been set to a
+	specific bearer then that is used instead.
 
 	Possible errors:
 
@@ -346,3 +347,29 @@ array{object, dict} Sets [readonly, experimental]
 	:byte Rank:
 
 		Rank of the device in the Set.
+
+string PreferredBearer [readwrite, optional, experimental]
+``````````````````````````````````````````````````````````
+
+	Indicate the preferred bearer when initiating a connection, only
+	available for dual-mode devices.
+
+	When changing from "bredr" to "le" the device will be removed from the
+	'auto-connect' list so it won't automatically be connected when
+	adverting.
+
+	Note: Changes only take effect when the device is disconnected.
+
+	Possible values:
+
+	:"last-seen":
+
+		Connect to last seen bearer first. Default.
+
+	:"bredr":
+
+		Connect to BR/EDR first.
+
+	:"le":
+
+		Connect to LE first.
-- 
2.48.1

