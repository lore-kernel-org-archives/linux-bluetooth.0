Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316A939B4AF
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 09:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786958868; cv=none; b=WVhTRIPJvM4zhdymtSZxdaUjknIAonj4KaCJJEbmVg6oehzjMQtLdamOU4cQi4G0tygQHPVc/G3Vh/OGVZ0yiYSZD7IrAELrOab3JxxfrvPEavTf1xYXdMj85BOgmpJQCjw54lZ0ycX1KSJEcyrSSSl9nLpvzsk2kutoahY0tTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786958868; c=relaxed/simple;
	bh=4VODi8yUWp6VotkEng+Eoi15pTbHzrJrCQiI2m+Wxhk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W8I2McFHTiwqbRjSRdqZzNTJFrOia4e6i+UayOfR1XW08F2o42ECjGlM3cQwgzImRgZORXPYlSfii69wWtieqD+akWWFXuFx+oQeCHYKu3snPcF1PWThrPUGdZnLPqSrJmB3Cf6qPsHU820N3usQHFJfkgBoct8+9XQbs7R+6Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=synaptics.corp-partner.google.com; spf=pass smtp.mailfrom=synaptics.corp-partner.google.com; dkim=pass (2048-bit key) header.d=synaptics-corp-partner-google-com.20251104.gappssmtp.com header.i=@synaptics-corp-partner-google-com.20251104.gappssmtp.com header.b=XWi8qjwy; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=synaptics.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synaptics.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synaptics-corp-partner-google-com.20251104.gappssmtp.com header.i=@synaptics-corp-partner-google-com.20251104.gappssmtp.com header.b="XWi8qjwy"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2d5655cc850so14879135ad.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 02:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=synaptics-corp-partner-google-com.20251104.gappssmtp.com; s=20251104; t=1786958866; x=1787563666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MqILGGIWyBqTfUPjY9fDVNDQq53KOhgiPASwm5nWtNY=;
        b=XWi8qjwyps0lDkUqIPhgEjm69T0dw5pcpNd3e2wQPgaitxpRdCkzmfskBK8AJMfGQp
         UfgPECct6+bRn98vw65yiZrQbSKOc0+e7/z0tT9cCF9tt8M00CKY8XeNhavYS4840WyR
         /mIadDq05BVMpCZ35oug88g4Zoi+GaQ0DKBDHsBIfcs0+Uve1+csOUSv00WVcMlMR0JW
         Z9Fk9DRop7+eAw6YAV+YiCKxlXyJihBMKOeoKls84LlBU/pLI53mq2vP+LgU4BTEiVxf
         jYVeI9xvmOHSWDjZKgVfAETVztgdIOQYZvWM0oHFJTv2AJ0pKG2Hk36eQttgfMT6XL5p
         V/Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786958866; x=1787563666;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MqILGGIWyBqTfUPjY9fDVNDQq53KOhgiPASwm5nWtNY=;
        b=l2yxqHnXq5UzI5pjijDdl0Yfhtkt1apvuLw6y8R4nYk4gwMWYVqW6DEWQ2XPAjoOc1
         UPNoUpQc6jROf4/Unfl10g0mxog3Q/vfdv8mFso9p1kb2RG84hT6MjgFKcQdUrlGyGJk
         MSLiZGRJ9gVLMHlUC7ttF92NslRJlI+LGQS5RMQjlFzke/ooSXZG2bomwE4zaQMlyHPc
         /D7SWinoGS7qXp88Gmf7RbuwzTDvLlzwQG2lS6RejdPzMWIT+v+VvHuzy4BrHaZwwYbu
         SVr4l+BOfwq2WWzlkjL37DA0AJYGEYpK9YNSG9b38P+XF2c/DYrKupEZ8TagqL0cvmIV
         RuhQ==
X-Gm-Message-State: AOJu0YzsCuSBCX1dbcz/mhgM0sfOpJOklBPWeZ9Cg8tPjxlt7bXi+Lt/
	flEF9CMmWtDU9Sl0GHipt7XcuNArNm9q2OK3IxBm7vVS5NCrXdNpgUk/5043PzDMccMJpMnFhTA
	EP2Y=
X-Gm-Gg: AR+sD12c6FeoStsOoWUWFi3uhcgqebVIouklIC8vQQVDO3cFc/TKmktEKXXCYiE7QjM
	s9kfr12wBrk6Y80oeVSfIQqHBmdqGmeMWfI0JrH7gIAjyD759AYb3e6jE8m9Xwe7ZaDjU1fzZSP
	TqPHMLV+3vr/hoYpcxwYnIYv2qRmqxWmcMdRHl1+QMiIC2wLiRvCBq9ayU67zfm395heCc2paNq
	vV8vT5c/kQu3/rEPOPBL7+0ehuArzRpI25X8TtU+L5kNLLzJrGElww6EH8xngyD6qbrgmrZ50Iw
	spK62VY1Eb7IbWB+ET5UN4jVIVaoEVPsgiR0asncON0D98fNN+v5jGO1qx+FIUzJ8JGlUfJCfqR
	3SzneURUapHNss9AMOAofjF1opCe+FDbolxA3dvZrmNrmHr/4UFYAzqLa1zCqKLFCLJCNZkzTg3
	E/jEdLucpnJaU2G31pgUmP3hy9lsv172FtBl1prrvpSscTlfnyF8GcqRKoMrDHAJH1YMQvifh2P
	j8ZYkfleMySDgjVQ2EKtQAIsrmSrlHjeqPDI8BKOW9dePEI/1LZidhwK65C8Etfr4BWqrR0zMcI
	mQ==
X-Received: by 2002:a17:902:e78f:b0:2cf:8131:75f4 with SMTP id d9443c01a7336-2d3b0c93b91mr258543235ad.11.1786958866521;
        Mon, 17 Aug 2026 02:27:46 -0700 (PDT)
Received: from TPE-build-server-2.synaptics-inc.local (59-124-75-166.hinet-ip.hinet.net. [59.124.75.166])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d5bb499e12sm2962455ad.8.2026.08.17.02.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 02:27:46 -0700 (PDT)
From: kaihsin <kaihsin.chung@synaptics.corp-partner.google.com>
X-Google-Original-From: kaihsin <kaihsin.chung@synaptics.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linusw@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kaihsin <kaihsin.chung@synaptics.com>
Subject: [PATCH 0/2] Bluetooth: add Synaptics BCM4384 support
Date: Mon, 17 Aug 2026 17:27:21 +0800
Message-ID: <20260817092723.637956-1-kaihsin.chung@synaptics.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the Synaptics BCM4384 Bluetooth controller.

The first patch adds the BCM4384 Device Tree compatible string.
The second patch adds the controller support to the Broadcom
Bluetooth driver.

kaihsin (2):
  dt-bindings: net: bluetooth: add BCM4384
  Bluetooth: btbcm: Add Synaptics 4384 chip support Add support for the
    Synaptics 4384 Bluetooth controller by adding the corresponding chip
    IDs.

 .../devicetree/bindings/net/bluetooth/brcm,bluetooth.yaml   | 1 +
 drivers/bluetooth/btbcm.c                                   | 6 +++++-
 drivers/bluetooth/hci_bcm.c                                 | 1 +
 3 files changed, 7 insertions(+), 1 deletion(-)

-- 
2.43.0

