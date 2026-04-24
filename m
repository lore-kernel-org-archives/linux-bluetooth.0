Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E78387341
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Apr 2026 09:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777022024; cv=none; b=IxBrjcjlsyVGiRozobchT+FrUZ28C4dZnDRMHmYQIkdiMNV0v9xTkjwglvrMVeXOAyhnay3x/bY7hNuAJre7y0ytnC5f3VgKI1BfH/+vAh+p9e8cm9ML9rbbaj7468ECASpZhEkaU3Nhffk44DwKaMicHEfzV+fNFtGZK5To00s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777022024; c=relaxed/simple;
	bh=ShRYFoh/Qqh3YbMyGWfFbz4pnjks18+gVnKlUthcYU8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gXaZ86eI1OJA8BBDZolRN1bsXWb3ngWMOutxib5QAtOvboRg4VcI2TFHiZdNmCOU41e1Md6pb6PPTBZwDF0sV0K7ZXSY5Effdc70vz2gocRvJ0F2wQzcsgUyDkgP5/8QppTtNIP37zDuejAN4LZ3WpnuSv9EaVMmhklWWq/vqfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id A524F3EBFB
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Apr 2026 09:13:34 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v9 06/15] emulator: Install the emulator if built
Date: Fri, 24 Apr 2026 11:11:09 +0200
Message-ID: <20260424091324.3097084-7-hadess@hadess.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424091324.3097084-1-hadess@hadess.net>
References: <20260424091324.3097084-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Cause: dmFkZTE4fwvglj1stUpqbfNOHgbX9pBEbBFXfBn+DQ4MiAAA6Q5/kgmY6sH9Wwik1ceYLp6ZNgfTynQHBkQ4N55lyQu4yW7V3nHJyk/iilnZtTxZrqQt0GkMVUUvcdSDhQ/I4N0PSGb4UvWo71F8G+un+/Zry4Qu718gJ7Tc1UFESpRs/KnFyu+QdCxtlRBx+YBGSmskVeXbdXm6PlGkslt6AZjsbtBecG/FMoAlwgc27KEpaEMzn5WZDvunlzCnmcJc3y7KTB1b/TPjvmtdlfkTY0qe3MmA5mFjVST1KD1dS2cnveNKU91CrDhd4MGiADuFUUUingjVS7GXUQtIFa0rmXsTd8cBCkDD79x7k6yBerTNQa/hXogvSP8otaqWIzOWL8I5IS7xTnDyf8dd6q9bswni7Lj2ygnr3qwnVRZtMF4jJD3OwWRQR6kEIpOV7ExGHo52qeEeY5mlGfx1KvgEHtKFyZyQTuXl6vQHmT86TmH4gaCBqSKNMwP9oMp6SUDVXuTeoGK0vCt8Q2nhqJHicz95E11JnA/bvw2vHh5ZA2RXVmveKWKZWBt/0F9NlMMLU3tbHRkicMok08W+RDN80AsJ9iaPnfAb8e+d7diHOeYBRknv7bHB0V73anW4plSvpCbxbUEw31B6lH+/sAisfOH8wB19kOkHJ+uQZ0/L47qLUw
X-GND-State: clean
X-GND-Score: 0

It's useful for testing.
---
 emulator/meson.build | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/emulator/meson.build b/emulator/meson.build
index 40544567e4e4..9da91b16671b 100644
--- a/emulator/meson.build
+++ b/emulator/meson.build
@@ -18,6 +18,8 @@ if get_option('tests').allowed()
       'phy.c',
       'le.c' ],
     dependencies: [ libbluetooth_internal_dep, libshared_mainloop_dep ]
+    install: true,
+    install_dir: pkglibexecdir
   )
 
   executable('b1ee',
-- 
2.53.0

