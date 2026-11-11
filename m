Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.216.248.207
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794398583;
	b=r8uexsiuoruyf6yavIGpb4LDJ/3oRLm5PX7AJkFvVMZ/MBlI7zWFAVj3bxV6e/E69udu
	 5zVcgAuAm3jlBcl0aoRaZP/HNwVma0Qf2ZAQuoCI3ombd9WmNW2mArCYR3vvIOg7YAfr3
	 UFueMGaxYtThAARmhWabfJpRJQKUNyaL1lqX2Jz8OUYErDr5/PpVjgO3eVyi/vWvrNANu
	 I4OwK6Z3Mi5adQlQEf74AowTnQmulzKcQmGFfvQfJlT+/4oeA1PJphBJaf/nAROUffBWl
	 ykej9t075VCkpNF+eCUrGqbyM3fx4QhW7gqZjLWD7v70iV8O53+6AdrIMxpq3qTCyBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794398583;
	h=DMARC-Filter:From:X-Lima-ML-UUID:DKIM-Signature:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=uCuXL4k6bXz1OMpQSYuglr4LnZB1D5NcI6zeX6m9YVw=;
	b=figAdMNVhb+wImIvks4tIzLDZLYL6uBPjjHJ5W11IMNcclpxIMenkr8uAhxGJ30ovADA
	 WGRZCG1rCE+HK83VYeir4W3LjsxdyzIKLcPlE9rElWTrZQHrg+3+F549btsaYsLcfuJ9g
	 lOPEx6KztRTFArRAcKJwl8nGP1HK0WWWVmjWp2CbDZVXpWgdIrCim+r5z5iBNjjW4cpDr
	 30Ees3CJPpcDsAnb+yTJWRop7TqHj6Wn1CCJGGIxeOIxIilNsLOwUQlIE7EryKrANxjaM
	 r6Jc20l3ce8XSsFEtfg+Bdq2INBeAHGam5a5erdaq58YnKJCMWmJ51YFsUR8ks9ad6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=deq.rocks;
	spf=none smtp.mailfrom=deq.rocks;
	dkim=pass header.d=deq.rocks header.i=@deq.rocks header.a=rsa-sha256 header.s=securedbylima-20251205 header.b=fENlUVZ+;
	arc=none smtp.remote-ip=91.216.248.207
Received: from mx5.mail-out.lima-city.de (mx5.mail-out.lima-city.de [91.216.248.207])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18998606B608;
	Wed, 11 Nov 2026 12:03:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18998606B608
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=deq.rocks
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=deq.rocks
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deq.rocks header.i=@deq.rocks header.a=rsa-sha256 header.s=securedbylima-20251205 header.b=fENlUVZ+
From: Andre Eikmeyer <dev@deq.rocks>
X-Lima-ML-UUID: c5a54213-9cbf-48a4-8e1a-0957c13c7efb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=deq.rocks;
	s=securedbylima-20251205; t=1794398572;
	bh=/2sigmfXWkPzluBSXA1irkkQUfzfLvNPv0N9im65hXY=;
	h=From:To:Cc:Subject:Date:From;
	b=fENlUVZ+IzGo74oxqoF6Zyc0XwlvqAKBDIvQNc47T0rPKrx1aQbXLYBEO51842aK7
	 qiphnBOWcTHVKhxfylp6NEoa+MI4pnMZIgfxpKDco/QxYoOnrAN1YCGLWbJI90XTse
	 ajyNclf9gB+Fnl+zRn0ZtZokpqwr6Dg3mVn+oVi1fJK0wC8amH2z+HQN41hNNx0TfZ
	 +VGK/UHF3UeAQlKiwafAAL8oHA0OOpWUckTjoLEU/D1f93hCrzGXn4d81mtI90ZI6S
	 uGi7tXpHgYAKe5rk/GCM6O+EOZrzK2i9uSN2tXAI4JlHX/wk0ubnbcR35X+Ml5QeoD
	 a/oNcM+6585jw==
To: sven@kernel.org,
	marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: j@jannau.net,
	neal@gompa.dev,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andre Eikmeyer <dev@deq.rocks>
Subject: [PATCH v2 0/3] Bluetooth: hci_bcm4377: resume after ACPI S3 and ASPM
Date: Wed, 11 Nov 2026 13:02:45 +0100
Message-ID: <20261111120248.21062-1-dev@deq.rocks>
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

Patch 3 is new in v2. Because of a hardware erratum the driver keeps
ASPM disabled on the whole link to the Wi-Fi and Bluetooth chip for as
long as it is bound, which holds the CPU package at PC3.
Patch 3 disables ASPM only while the firmware boots and restores it
once the firmware runs, also after the re-probe from patch 2.

The Wi-Fi function of the same chip needs the same after S3 and goes to
linux-wireless in "wifi: brcmfmac: pcie: S3 suspend and resume on the
T2 Mac chips".

Successfully ested on MacBookAir9,1 and MacBookPro15,4.

v1 [1] has not received any feedback yet.

Changes in v2:
- Add patch 3, keep ASPM off only while the firmware boots
- Patches 1 and 2 are unchanged

[1] https://lore.kernel.org/all/20261107154839.89941-1-dev@deq.rocks/

Andre Eikmeyer (3):
  Bluetooth: hci_bcm4377: treat only negative hci_register_dev() returns
    as errors
  Bluetooth: hci_bcm4377: probe again after a resume through firmware
  Bluetooth: hci_bcm4377: keep ASPM off only while the firmware boots

 drivers/bluetooth/hci_bcm4377.c | 93 +++++++++++++++++++++++++++++----
 1 file changed, 83 insertions(+), 10 deletions(-)


base-commit: 3f425f95ba3923d605f6a8b382e8fcdc59d479db
