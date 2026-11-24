Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.70.183.196
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795535616;
	b=W7uZHRvp/ut5ubcD4k90xNucEjXjtYd3eiyRUV9h1UXmscJ0sK8tedqUOBl1Pg6Gttmx
	 l5FkDsMA3NpnBlpo1E5KP35Qp0igKo6PNkc5DvFnPAdn9cu4/bNMkcjCHBCJDcpzve8xR
	 fePnFES1xhBpO+PEulgoBZb6KO6KvaEXbx7TQhKJZ4SDk2/is4tE1Uz26nKp7M1701Kev
	 /xNPxK9V/0QhmWn54lCj8e01BdvyEqrGL9VcuHPAKppNAhX36z87w1A5zSQWh3/z1URsB
	 fbLEOyJpiyfOXMGGSpkJDTjqUkEGG9mYi3q0Jz67GxGIu7Sp23OFZgTYU+BvmRfKmRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795535616;
	h=DMARC-Filter:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-GND-Sasl:X-GND-Score:X-GND-Cause:X-GND-State;
	bh=kb9buLtU3tNQzXZqRAC/sOkg2k4hVThL1kVuGauqmyA=;
	b=moOt0VlVy8g2ocqZwG4mBcyulSDFI+vhJ0OGvndFgQ8HARgD7QdD/BjSXkLoV0sL3N9t
	 +Qx0kIdHFVrtspr/KJ/rTs7nORKSYinfzbGH8Lh3BWjsg8MSnR1QKZRVGXFhALspxe2FC
	 7c7OWU5n/ZGfhK9iGBomI1h2G2yDZ6Ngw93gQjmzgyPIFNyIoHUFAMABwz3UlKYriaVNN
	 yTrSnWy3TVdFvYFWL95XuuSXpKlkorztMYcLSXynsX3FpbqZ/b8tL2i1iRNqF4F6BDW50
	 PuIKbNvHOHafC5uLoay2FLYLXmvsvTPADzuPNfW0c5UCBaJCNwxNilkNuWJrf6iW/9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hadess.net;
	spf=pass smtp.mailfrom=hadess.net;
	arc=none smtp.remote-ip=217.70.183.196
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5FB606A32C
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 15:53:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F5FB606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 90D8A3F5A3
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 15:53:28 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ v11 04/14] tools: Install avinfo tool by default
Date: Tue, 24 Nov 2026 16:50:35 +0100
Message-ID: <20261124155319.1752879-5-hadess@hadess.net>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261124155319.1752879-1-hadess@hadess.net>
References: <20261124155319.1752879-1-hadess@hadess.net>
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
X-GND-Sasl: hadess@hadess.net
X-GND-Score: 0
X-GND-Cause: dmFkZTFJW+/usAh8LSeC2b7lfudKF18sgJZTx6Q5JW63T3PYDtZvjgR5PhbULgtFAmEbVpfttcUmba25pPJrigPv9vsiekGsh8iCjfhDJ3ywT8aJat2JIsDk03TLbnzVf7YS9O9qWkD21odO8DuGLUMprzjbI6svYZitsvGrcmzNPUAJeVN0q/dHhjk6Cl/chCR/pPSfob4XQg2Yzbi/6KU5vBRLoyczw0S65W1LhRl8Ihn7b693h1/Xa2RaefIj280LNX3N/lAY/riSgCFIzKXU7cROyGybfv/70BjuVKgfexNzk4YEjixdqJxUz6XPd0Z5b/gkQe1htR1raToGyHGLJ/nSHXy2GsmbIxlocdOnAiGo/AbmoImbPJENXe/3UaUBuOt/riyh2r6QEpS/tWaYoz9JBoWCEsv/8j7eyCOoiTkHrpRPPPPcKaOo7gzF83fhuIDKJFB41KFV2LDd+X6snNtv4TAR4tfsgAdMrfqNM44ZFJsAcAdvD7h8xPsS3GIQ15XWvfco8otVqoFuF5mKdU5sgW7WJdEzc6y4WVc23gZJl6lRcfYrhIF4ULPX0b+QpUNXf2E6wzgRlQIfUTd4I+W/sbYrKybWJ6DXvc+TC63hiF4w+rLDOeUsOgitJwk2+HhRR/emEJSSIsGIchL2sLTvzkBCTucoYM9pkPZ2/rLrxA
X-GND-State: clean

It's used for checking which audio codecs are supported by a Bluetooth
audio device, which is more useful now that PulseAudio/PipeWire support
alternative codecs like LDAC or aptX).

Fixes:
https://bugzilla.redhat.com/show_bug.cgi?id=1699680
---
 tools/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/meson.build b/tools/meson.build
index 270fff53a090..d6539e2d63ad 100644
--- a/tools/meson.build
+++ b/tools/meson.build
@@ -61,7 +61,6 @@ if udevlib_hid2hci_dep.found()
 endif
 
 tools_names = [
-  'avinfo',
   'avtest',
   'scotest',
   'hwdb',
@@ -82,6 +81,7 @@ tools_names = [
 ]
 
 inst_tools_names = [
+  'avinfo',
   'rctest',
   'l2test',
   'l2ping',
-- 
2.56.0

