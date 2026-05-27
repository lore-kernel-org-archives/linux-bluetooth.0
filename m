Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1853DD534
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 May 2026 09:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779872951; cv=none; b=g0zSquWdUTDeiP2f+/S6kz4mLM9IQMv+8ar/wec7KYO3AfFiLrIGFU/VfYhKeJksS8o+IYMlkZT/aqDiTr2NygGA6ssAYXr/XSCUqPcvg5Yh1PDdmUcWBKaw02/XBgverSy6SSvvtfRQH5wT7ztKtK31QNRF55k41F6XqChSvkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779872951; c=relaxed/simple;
	bh=xYy1/j4PQat72RkJ2qs58ZdiYDbBTsDsaIkP/Qz8WmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fr5RFUFhN2WziFUerP3tlzOeYOJg1UJR2sl8vw/YyMcqDWC8oEiXmChha6o+k3IcXRWN9dPQC32cIfucEFuXOrrEZjGHHpW/ENE5Pm6DoL+LgI/CIUdg3xPw4Ie8bD1SGo56PB+teuROuDo2KB7dGpDgjuqrm9RT2vNY0ramAWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=synaptics.corp-partner.google.com; spf=pass smtp.mailfrom=synaptics.corp-partner.google.com; dkim=pass (2048-bit key) header.d=synaptics-corp-partner-google-com.20251104.gappssmtp.com header.i=@synaptics-corp-partner-google-com.20251104.gappssmtp.com header.b=I/J5WfVR; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=synaptics.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synaptics.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synaptics-corp-partner-google-com.20251104.gappssmtp.com header.i=@synaptics-corp-partner-google-com.20251104.gappssmtp.com header.b="I/J5WfVR"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-36a8ee1e28cso3850251a91.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 May 2026 02:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=synaptics-corp-partner-google-com.20251104.gappssmtp.com; s=20251104; t=1779872950; x=1780477750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YzP4nn3r/gwn1is3A2tYi+9xfNYB+0iqmEG+7KOfkLY=;
        b=I/J5WfVRfzjhf5qjwyUsAHvbOe3VTsw/jzfUkEHs2iYR6+JsaK5DIeKteNMKUQQQyQ
         MRu1uSc/PsnxCSMz5HlgcpjlVdRRroJDuEbTF2rbbVtDoM5P8bbkc9F7Ir/TGzmhX862
         CQeNu+p1UBX/hvI6kg9Hy77yhz8dzm1w/bptybDywsv5ghbteQEeBsyKyD5j+oGYzXrP
         bUXsxeaTz6AZiZRofWWzthR5QnRsYM+NCJ42zkd0D1Kgok0exEsF7KwC6mjGal+lZ0sw
         MJI3q7oSRAfdx+MowNxL58MuG0zQDGc7P7FNszz/NOR2qqmuGD+LGCqmdU01W74vz0yc
         uR2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779872950; x=1780477750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YzP4nn3r/gwn1is3A2tYi+9xfNYB+0iqmEG+7KOfkLY=;
        b=h27PfMJnzFgvgzC9EjzTus0e4C6DKrc2v4T6j3gUdmVy3TWZRMvDgYiQm4XavhaOy7
         mz8C07WAoX2yXesHozCCNwEXMykIDF0nGxpAstNiwXOTIuJaJ8RxpmCuCIwe4COhB626
         MvweFtPmIF0hVxoZpqfC1xDYSPAOvFmjixv99R4zSrMIqoY+WfPTKNp4QSESvV1YD+e1
         oYiquTiswTBJZbmpd3MfpOnA79iasXVh/7+1mvo5iwEd6xM2qPHPL0wdkRelLGt2Ys7r
         zxtknOuJyKp0DOgmQz4EFIGzSZ9vfU0LXGzHIyRQDC9Qk1+6NVzd7XWhFuOG0cWHfso3
         uBuw==
X-Gm-Message-State: AOJu0YyBo4Sv09Rn+Zoquw7k86VCZsoUE7H1l7KQXM/82iXuAljquu1K
	3ONEU2v5mfUtgH5R/4CwMyHiyXdv1zWIsElNpRLuEo3FacSHnbedktibOsxyU0AJtJRPTN7/lrc
	nLpxcWg==
X-Gm-Gg: Acq92OGosaS5NT+gnmEh2pJugFyL1iAeF+mEsCYaXC2EpRtzJg+rjR7hAKwxwh+PlRn
	xf58SG5Xp7RCrPK2t/+/3IKRwT0YFf52kOwffLvY0HmnSpIeHJS0yqSb0epa2dwI2we3DFD/LB3
	0k60OP965nxjKwOWkY03V9lxIcpOKDxJuvlQufegjI/ElxDu6mkM6/Fvjsl/RJfHWKmmbnp6Vax
	ctn3vRGJ6aQePyVYO5GnhUqSma2lpAnPfVtcX0Lcchnisu7mY0WAdqn9sbHp0uoaSoScAbsdJTz
	BcAyz6eHfP84IgiDOhy+/40+YOA/ILQqlUNeWdmBXFxr4Cy3BM3ihYNV6sA4mPjGqpHGWYKv45h
	/wNDvYuQ3DBonDHGNNanvx+vGaK6xvna++9ZA9EkTXBTq/AqBODbZu52VFqwA159SM00VkJdhW1
	UR51W5wCnhp8wZ2ErOdPxZ/zaoD6udtkFeMO5H61nehstQEzidStXYzDbquswLcAvg04btSYgH8
	8rQk47zNe8r+tS8Bg0Bgw3nSxErfJLdz4Ywfj8=
X-Received: by 2002:a17:903:1247:b0:2bd:c5f8:504f with SMTP id d9443c01a7336-2beb0702144mr236239085ad.40.1779872949672;
        Wed, 27 May 2026 02:09:09 -0700 (PDT)
Received: from TPE-build-server-2.synaptics-inc.local (59-124-75-166.hinet-ip.hinet.net. [59.124.75.166])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bed2061c59sm92430365ad.2.2026.05.27.02.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 02:09:09 -0700 (PDT)
From: kaihsin Chung <kaihsin.chung@synaptics.corp-partner.google.com>
X-Google-Original-From: kaihsin Chung <kaihsin.chung@synaptics.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	devicetree@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-kernel@vger.kernel.org,
	Kaihsin Chung <kaihsin.chung@synaptics.com>
Subject: [PATCH v7 0/2] Add Synaptics BCM4384 Bluetooth support
Date: Wed, 27 May 2026 17:08:47 +0800
Message-ID: <20260527090849.3647601-1-kaihsin.chung@synaptics.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260408083217.1915419-1-kaihsin.chung@synaptics.com>
References: <20260408083217.1915419-1-kaihsin.chung@synaptics.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kaihsin Chung <kaihsin.chung@synaptics.com>

This series adds support for the Synaptics BCM4384
Bluetooth controller.

Patch 1 adds the DT compatible string.
Patch 2 adds Bluetooth driver support.

kaihsin Chung (2):
  dt-bindings: net: bluetooth: Add brcm,bcm4383-bt
  Bluetooth: btbcm: Add Synaptics 4384 chip support

 .../devicetree/bindings/net/broadcom-bluetooth.yaml         | 1 +
 drivers/bluetooth/btbcm.c                                   | 6 +++++-
 drivers/bluetooth/hci_bcm.c                                 | 1 +
 3 files changed, 7 insertions(+), 1 deletion(-)

-- 
2.43.0

