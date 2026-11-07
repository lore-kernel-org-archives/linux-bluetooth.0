Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.216.248.207
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794066526;
	b=h1XRsMN/RTGTdWJhkkDXoFpgLclzxRe+Pw4g87idowEvkwKP/eFRPsgdo8tYfDDRa16T
	 0NmQpKnxnh0pFAffefC6TnoItqgpmcrDNy9vK3rKS5W0P7Idf1b1L7yBhPRoc7pRzR8NA
	 rLaIouZRIb/Ulit9Es3nbJG8DlicQ7yXSgjHhlb1ds+EIrKMhlfAaulCOJgCH0dOq8M+h
	 KXSgKoWSfUpjaIrHPxcxHwFQf8SPns4o7r0arlQCVpbrPMlxVLYYOR+hy28lwU40OuEyo
	 Unb3ty80nJkBKIY8vzcTneSZg+UhQV6//qSHk13K8K1J5H1aJE+YXZbl6IhGEg3IrqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794066526;
	h=DMARC-Filter:From:X-Lima-ML-UUID:DKIM-Signature:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=jtXfHdYWCtXKWv9mf/2Ht3BVfSpNnPeOBsCh2ZBabNc=;
	b=BDtzoCmHm68E8p3cIgZlYeBHEVAcnkmcrMQYM4590fLcH5EwjBXzGvymjw+xbFLOSruS
	 Ynwyger0alILykzN+1D/3R5Tm3qtoIcNOz15SrLRiDQrUKsy7fGQ0cdxgQ3yxJe/ibYNr
	 Xnuovl6w7YJ/BYwFphpg2b3OvNPI/tH2iprrGZbUJjj6VRqkwKCPuIN5sVZTNa8Ju3J+k
	 dPTH4izMoH41UTSmAfiLUM/zSDXASErUzFwPgvAkCYtJRTbOw6IgeLQJ5q2KBxXZCBQHN
	 vjfLLW8nICu4EZVHoW8+5o/cT/psplsn+yokFnPPQrqZGxkEC9/lUfWJEGAjxI8Vx1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=deq.rocks;
	spf=none smtp.mailfrom=deq.rocks;
	dkim=pass header.d=deq.rocks header.i=@deq.rocks header.a=rsa-sha256 header.s=securedbylima-20251205 header.b="xb1V/8vd";
	arc=none smtp.remote-ip=91.216.248.207
Received: from mx5.mail-out.lima-city.de (mx5.mail-out.lima-city.de [91.216.248.207])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD956083620;
	Sat,  7 Nov 2026 15:48:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1BD956083620
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=deq.rocks
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=deq.rocks
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deq.rocks header.i=@deq.rocks header.a=rsa-sha256 header.s=securedbylima-20251205 header.b=xb1V/8vd
From: Andre Eikmeyer <dev@deq.rocks>
X-Lima-ML-UUID: 62c42788-fd3b-40fc-b502-00516516e72b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=deq.rocks;
	s=securedbylima-20251205; t=1794066522;
	bh=9oMB0p4H6SKMJlxQ7LbkQ0+0DRnlDsn0JitxiNh13XA=;
	h=From:To:Cc:Subject:Date:From;
	b=xb1V/8vdoooE3cVzf4DGaq8SqBROrIzJqc35M1sc2pJyDj+PH7/+P5k6eIrkE490Y
	 H9nM2IiQJDzdkQqtX0H57l6M6yCgHyHYMcEvLutfo5klavFuHjEn6XFyqv/UEv/JUT
	 uiBTBXV9psXcu65h/I79jpA4l8rzCMdzaAkU/Qq39nBnGWQK2cQ+rEg7Vn3nJd1jsc
	 fWV0LHu4OqpK/EC9b2Oj9FEnXYW4lwQIvd+qvTCstN3y8WyYhWL6MKWzDfrF4NcsfF
	 gA7BlEj4VE2MmUUZKrzd63J/jm6XiKgbF2qcGoRAPVexxQF4FZArw8GSIuSdJj4vuf
	 rSyefVwKlIx4g==
To: Sven Peter <sven@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Janne Grunau <j@jannau.net>,
	Neal Gompa <neal@gompa.dev>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Bluetooth: hci_bcm4377: resume after ACPI S3
Date: Sat,  7 Nov 2026 16:48:37 +0100
Message-ID: <20261107154839.89941-1-dev@deq.rocks>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After ACPI S3 the Bluetooth function of the BCM4377 comes back without
its firmware. Patch 2 probes it again after such a resume.

When the previous controller is still being released, the re-probe
registers the new one under another index, which runs into the probe
return check fixed in patch 1. Patch 1 is a fix on its own and goes
first.

The Wi-Fi function of the same chip needs the same after S3 and goes to
linux-wireless in "wifi: brcmfmac: pcie: S3 suspend and resume on the
T2 Mac chips".

Tested on a MacBookAir9,1 with three S3 cycles, holding the old
controller across each resume so the new one comes up under the other
index.


Andre Eikmeyer (2):
  Bluetooth: hci_bcm4377: treat only negative hci_register_dev() returns
    as errors
  Bluetooth: hci_bcm4377: probe again after a resume through firmware

 drivers/bluetooth/hci_bcm4377.c | 61 ++++++++++++++++++++++++++++++++-
 1 file changed, 60 insertions(+), 1 deletion(-)


base-commit: 3f425f95ba3923d605f6a8b382e8fcdc59d479db
