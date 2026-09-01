Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C5A3655C7
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Sep 2026 02:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788230009; cv=none; b=dCCC36M2WtvC7av/k3nYOlUqyjeOZCrT2ViR5fndbxagU9kCHEboJDtMIi4nTgro20m1qgHekLdwSzA0oLFbD6ye3IKjMM+9zDSWpOwg3ezFLfe7G1ot4pD9+WWghvThx7GSHh/QDT3k5upOI8h0dftQVwQH5lbxs4+M+PpkqNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788230009; c=relaxed/simple;
	bh=xzNUE0g2RNOAbTc+miqaYUEcLeyNwtRt9Y4owm+vRG8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ow3nS+uZ+CCV1m0nJfiNyrtzQGbnuNFppxCWtK2inKFh8lTJba9HhDP7Jbl3hOqVbe0PXbLXbn41WNOqHLoYABDmYQOMNRwgx6iw0InuyA6ctV1RSh5EbBzpyCJC2HunwnheJziR5j+6bk8Z//yGlu3J1aEbejb4ajSfK8pJ970=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=synaptics.corp-partner.google.com; spf=pass smtp.mailfrom=synaptics.corp-partner.google.com; dkim=pass (2048-bit key) header.d=synaptics-corp-partner-google-com.20251104.gappssmtp.com header.i=@synaptics-corp-partner-google-com.20251104.gappssmtp.com header.b=Lla81i4+; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=synaptics.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synaptics.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synaptics-corp-partner-google-com.20251104.gappssmtp.com header.i=@synaptics-corp-partner-google-com.20251104.gappssmtp.com header.b="Lla81i4+"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cc1a4c62804so3636692a12.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 19:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=synaptics-corp-partner-google-com.20251104.gappssmtp.com; s=20251104; t=1788230007; x=1788834807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gChFCRqPTxG6qAlhVmq1u3HWUgs8rr2muPIizuvzUM0=;
        b=Lla81i4+g5yHvkaxNNtSY6n8Bx6uvQCOH9AS7HTiZcuMtc8ZWw8H0OcP+QSbZ/ra4E
         pBO92t2J85goHbrPXmpN8JKeIbIdzlRDFpniX0KRCEgMNGGt6pEyukO7SQpTSlhtxbky
         UCOvEIOkfRVLytnMrNMveAWtNQhRy30/Z4qEE7r1Rf7JZwh5kD9GpozI4ccp1gDelwdh
         KonEg45GUN9IrLd3nsgiMkJ/t0f/98POiMdVDuDAWIQQ33EehKmcW0lIQGlTHEENO0uL
         CAffW90wj7sk7NFxmE0smC34ExHPe1hk7Lq//SlgfkX/EvwQQkBn4/Tahkfu4oOlgC5A
         tW3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788230007; x=1788834807;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gChFCRqPTxG6qAlhVmq1u3HWUgs8rr2muPIizuvzUM0=;
        b=Xp9khfAegICelmC4hjp3CS+X2yaVnVZnUoiGjk5NPO7cnUjQSdRsAuBZStcmNx6k9B
         IgOetfJlAbuo263i7bRTXe7Zt090R87lH6c8vCxvoGvgxXyGRYVn+yrIPCYtuckAJO5V
         kfGgztWXLLYOk4DM/fgNuHDyrEE548cbEra9KdmeGOttZ8fdS5b6edO/5WEQsFmqCxfu
         ybkT4UbowbgaOVDJKoy2skAjTenRHjp2wiL824wIMgn2Swq68hVwINOovfAOtqDHYhAO
         i66zumciPyhV+kzMURV2t4355YK7C9h2R8H/QJ/b1jZllGvGCQsmd737Xq399NATEgl6
         WWNg==
X-Gm-Message-State: AFuF++mkinqB7WllnQ9BGprXBrhYYlmL6aRaIP7oIvfnHdidm4GNWQbJ
	W/miGZNfmZ6doKWabu18XLk0tS/1jYCct1qa+Z6N+DEFpGYMxRrUwpeoMzmS7VHXumj0wcsfMHG
	5yb3aj0s=
X-Gm-Gg: AR+sD11Vn6m3JdQsStYRCjkiC8Mp9cbCt32dUbyi1kEoZ66BhQFqHRQWuRXERuyrqge
	31EzhKUomC9kooMnZggGNMMqGnyWW51jK8B89UhTPRZmHFOi147KaaW/UfGD8xOy9xwHVLJUBdl
	Imgxok1zO+3dJkDv9xO4kzOPM+I3hxOn0YYvjonvLdT6NvW2z1dotPaFZaUqBue0MAnhODFlEsH
	cyEzD9J6ObPiF3zT0DJztStnHpg04JanRWItHeK1M80yz6AG6jaVjxiIccBeQe1iw6ye0dEgbkL
	IfCdtQHjSvu7xngDeej7lFP/0bWk6znYaAQR5Y3+InRx0/wFYUPNwEaN7kaGGxJDCt8MgJk3pcw
	QKrEap8HaIvFqKtDoqwTKpr3U9oOmT/hPw2CF2QLEa7UAM0JEJN5lpM6hMQq2AzdXze8VMkRHIN
	1hOuCXZgdnBh25SYmtU9U8dKg5ySeSHXcmOiQgVSTo7Ye6L/1WzNChI14Pysqhhaas/m5vuQF2L
	XhSm5gi3XoKmAYb6zS2Brq8HV6gVqReMQ3lLmkCoqF7LNfmsGMe1VJbBiBn49IrMlSGlqxckaoz
	7xYghA==
X-Received: by 2002:a05:6a21:4d8e:b0:3d3:ad3c:49a9 with SMTP id adf61e73a8af0-3d3ad3c6441mr37600042637.23.1788230007459;
        Mon, 31 Aug 2026 19:33:27 -0700 (PDT)
Received: from bt-tpe-server.synaptics-inc.local (59-124-75-166.hinet-ip.hinet.net. [59.124.75.166])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc1f3312270sm5005565a12.11.2026.08.31.19.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 19:33:26 -0700 (PDT)
From: Andy Chang <andy.chang@synaptics.corp-partner.google.com>
To: linux-bluetooth@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Linus Walleij <linusw@kernel.org>,
	linux-kernel@vger.kernel.org,
	Andy Chang <andy.chang@synaptics.corp-partner.google.com>
Subject: [PATCH v2 0/2] Add support for the Synaptics BCM4384 Bluetooth controller
Date: Tue,  1 Sep 2026 10:32:58 +0800
Message-Id: <20260901023300.1382808-1-andy.chang@synaptics.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260827110242.1203546-2-andy.chang@synaptics.corp-partner.google.com>
References: <20260827110242.1203546-2-andy.chang@synaptics.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first patch adds the BCM4384 Device Tree compatible string.

The second patch adds the controller support to the Broadcom
Bluetooth driver

Changes in v2:
 - Patch 1: Added an explanation for why a fallback compatible is not
   suitable.

Andy Chang (2):
  Bluetooth: dt-bindings: net: bluetooth: add BCM4384
  Bluetooth: btbcm: Add Synaptics 4384 chip support

 .../devicetree/bindings/net/bluetooth/brcm,bluetooth.yaml   | 1 +
 drivers/bluetooth/btbcm.c                                   | 6 +++++-
 drivers/bluetooth/hci_bcm.c                                 | 1 +
 3 files changed, 7 insertions(+), 1 deletion(-)

-- 
2.25.1

