Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.216.248.207
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795785910;
	b=EntruoJN/0p5jpKtNazXAFIl811OGsvW73/05kHxxjEieQikjs6NxkKMGxyTleYA3r6U
	 WyIHv0HQPNoEc/3iLuWUqP0m2PPZ3yeijBk59um1EZbP1ePt3kBp5G7PtnamUCQimgeH+
	 9mRyjmO0vYk483lvwqN0Pt7PiG6ZJSGvfiZjIvfPX5S02ml22Om7kNPQwsXVxY3Hpmbig
	 chnnB0GkypZsrBfNJJzntO4EjOzxkcLMtyCUKXkQ6B3BZrs5m8uXXk/FJO5YQ7d9DA+ny
	 rvY1hGH8vUA5CZzIQ1X57/xxQBwRJStk+vZJSs9LOKOQDTvi6pZjQjxQaTB5le6UNkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795785910;
	h=DMARC-Filter:From:X-Lima-ML-UUID:DKIM-Signature:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=v3yEbC+AJmlftdTFGRLi1VzGahJ69Ti/aAE4/7WZpZ8=;
	b=aR5s4/Iw86UqzRi7E4vNc9upw/CgqjoCwacod4tk0dFy+pX5eRTDN7uSEgR9p1o3wmUS
	 ZCfT3z3nAgTKqLCl48fz29yOvWQt2uyqZDfyel6kMeuXfG34LDZ4L9c+sQc+i4oYJ1Atl
	 4cspRwxY9D23B0YsWkdJJGsZz27xpjMgFdHsP77Ur31KZEAeugJU2Onx+UHijDwVGHlR3
	 uWm4dim+buj9zBNtjGVtrrwi8bVs8IEgvQF/iG0BC+1QLmkeBdb7fydo5sC82j9mVADD1
	 OxPVWzXDOJ8feQE50QLhBV3WSdfoaQLbmJIV3H/RdGJm8AzkEZNp+VN3mopFtJ3CteA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=deq.rocks;
	spf=none smtp.mailfrom=deq.rocks;
	dkim=pass header.d=deq.rocks header.i=@deq.rocks header.a=rsa-sha256 header.s=securedbylima-20251205 header.b=XIee0nPO;
	arc=none smtp.remote-ip=91.216.248.207
Received: from mx5.mail-out.lima-city.de (mx5.mail-out.lima-city.de [91.216.248.207])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A21606A32E;
	Fri, 27 Nov 2026 13:25:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55A21606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=deq.rocks
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=deq.rocks
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deq.rocks header.i=@deq.rocks header.a=rsa-sha256 header.s=securedbylima-20251205 header.b=XIee0nPO
From: Andre Eikmeyer <dev@deq.rocks>
X-Lima-ML-UUID: be76e0bf-39fa-4763-b198-36333ccb8c8d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=deq.rocks;
	s=securedbylima-20251205; t=1795785905;
	bh=jCbGfbLhz0HJs0XbEZQr5LjpS053K2gG8GUfQl41Qr0=;
	h=From:To:Cc:Subject:Date:From;
	b=XIee0nPOFMYsVn0LGgyRbwD8r91BOqjTLtTGbqQmsNLRzh8eYtV+hjX+XvGwjd+lv
	 3KUvI0EfxBWmO6WWZEr6pAmHVwxDOnhkdPu6EqnXv81YHXbEvCXzH6D6Jlj3h+0fHK
	 a7Wuw5atrgwrygc/xxbVmxua/FcftRx5W//K1a29xiy1d1zTLlhnKg7Y2UNURE310O
	 Huo1zb/ZTMWF25endityMHWoquAMfRCzNh1oWEVQ0cXUZQiqb49fzZx+9qw5B01oJT
	 JwuJDH1YOTMk9VLE0FYsK5CKRRcdiFgCnN3PVXg1Hyg6Gavxz5rHSD93A8lVVw1yF5
	 LFU2hbOFyuLXA==
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
Subject: [PATCH v3 0/3] Bluetooth: hci_bcm4377: resume after ACPI S3 and ASPM
Date: Fri, 27 Nov 2026 14:24:58 +0100
Message-ID: <20261127132501.262651-1-dev@deq.rocks>
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

Because of a hardware erratum the driver keeps ASPM disabled on the
whole link to the Wi-Fi and Bluetooth chip for as long as it is bound,
which holds the CPU package at PC3. Patch 3 disables ASPM only while
the firmware boots and restores it once the firmware runs, also after
the re-probe from patch 2.

The Wi-Fi function of the same chip needs the same after S3 and goes to
linux-wireless in "wifi: brcmfmac: pcie: S3 suspend and resume on the
T2 Mac chips".

Tested on MacBookAir9,1 and MacBookPro15,4.

Changes in v3:
- Rebase on bluetooth-next
- Patch 1: shorter subject, add Sven's Reviewed-by from v1
- Patch 3: add Sven's Acked-by

Changes in v2:
- Add patch 3, keep ASPM off only while the firmware boots
- Patches 1 and 2 are unchanged

v2: https://lore.kernel.org/all/20261111120248.21062-1-dev@deq.rocks/
v1: https://lore.kernel.org/all/20261107154839.89941-1-dev@deq.rocks/

Andre Eikmeyer (3):
  Bluetooth: hci_bcm4377: check hci_register_dev() for a negative return
  Bluetooth: hci_bcm4377: probe again after a resume through firmware
  Bluetooth: hci_bcm4377: keep ASPM off only while the firmware boots

 drivers/bluetooth/hci_bcm4377.c | 93 +++++++++++++++++++++++++++++----
 1 file changed, 83 insertions(+), 10 deletions(-)


base-commit: f57f78086ab54f3b3122fbaeba2c842ba7bb6d00
