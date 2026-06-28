Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F722110E;
	Sun, 28 Jun 2026 01:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782609042; cv=none; b=W87dH5QLeU3gukl+fu/MVM+2O3MVpBMjN0nv0RLXei9iq7FOoYjmvMq6BpvHYZZQ0EJk3S0uogmJUwvZBJMboYWoDRuVGwaUdXrDJjXCHiuwvaKiLnkH9WZiJlmezjlQgvTwPWAgICVxdcGpJdOvb198zPxJYs3cKvCBm7Osxls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782609042; c=relaxed/simple;
	bh=Rq00QHMSxeQ8DqMD7hWDrR1GtDPNQihf3mMguTU+F4I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l5LJriq0WytxJNH5qRz6d+o+R4yUAjiinXLh2rN3tLgIYcDTaNTHonT9l3c5EaYQxMQyuVh7tT11U72y9aaN3wqXxjViCYjNytNHhAbblAbZ17j2sr+T6gzj8RslB37ZEHUwKJgM+/NnCNDr+1acPxs7mSu2AfI9wmYJe/cp1KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=whynothugo.nl; spf=pass smtp.mailfrom=whynothugo.nl; dkim=pass (2048-bit key) header.d=whynothugo.nl header.i=@whynothugo.nl header.b=VzM/T9L7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Dsorr1lS; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=whynothugo.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=whynothugo.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=whynothugo.nl header.i=@whynothugo.nl header.b="VzM/T9L7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Dsorr1lS"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id B83E7EC0331;
	Sat, 27 Jun 2026 21:10:39 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Sat, 27 Jun 2026 21:10:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=whynothugo.nl;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1782609039; x=1782695439; bh=3MTQzOV040
	h06hKRc3XufEthEw7SvAdMqj9pZn9otZU=; b=VzM/T9L7tsVGGWKgAYBUPZHBvw
	xlImzX7Ss/H5HxYv1gbmEaj1j6j3tjspwPbO4yg5ioayJGt5kH86fAZG6Em1awWc
	3eoGTV8y2ajxPjDir00jlTTmAlKT54FqS1UzdX/o80dVdQijm22+Kdq/86wAKjl2
	WJOve6qaD2lnryYIwT4OSyUskB1/uWBE70agK5M+I+Q0RULO75QAoafnM87zGapj
	d2z9yRnhPlHQBY4jE4hJuRtnXbxCKloWSqwOlHYitNgB3D9g2OQfbytjSH4l3gLF
	jw0rBTvXHhCG3+3crxusZRfgv5YURqp7ylUGfipo8CAIUgP0iPc+STPE8OlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782609039; x=1782695439; bh=3MTQzOV040h06hKRc3XufEthEw7SvAdMqj9
	pZn9otZU=; b=Dsorr1lSHpKGbeYcR9LOsOIKxbYN8GG146TB7BIuBwHepX/2ngY
	9Y+wDk9fPVjw8YkuVIXOtM7rcI/tVxXlZo8L87CpmXRiKZ/hdNS8BO8LkyvX/JOJ
	fCaiJBvn0Ob5jfL7ENPFAvI1ZMK7KIVmPTDi26vTwZabIgxRpdpRqxxVhtP7Ppje
	yAFB0mGLFFV3BJ0aAXWPhkoNv+pag1wVkIEnG02e0y413w1molTFDhs6eJAMaqvH
	R/iC3Viy7YEsUmqGF0Uwcxzxw8v0ln6yhq2PVJuvQfJwDzKB9VxFQZkp4HHGSWRb
	tJfdyWv51LAgDKMu7EovjeiN87ESnTGr7yQ==
X-ME-Sender: <xms:j3RAaqAOXi5_BOvvB5aFWomjlCy-1WEc-BduCcFspKRH2zngoIiEjQ>
    <xme:j3RAamAkUQBBLs5bHfFoVMKg0AA-GzczRGPzqapgeWxSh273fu1WR-OIkioi03rBS
    LfhsCOsQ0PT5O8viET7P1QcKPQH2WnmSvZYESpDeFKeWduF-KQBZ_I>
X-ME-Received: <xmr:j3RAatp50AZtaYJCqzELUVECc9tW84VgNAJ53f2YIYW2qL0HlHb9nHYrLeiDXQBSFUfjc4oS6oA5iwhKRV8>
X-ME-Proxy-Cause: dmFkZTGWw9WW1+t4k3meeOathqgfqPftyL1SkKJ6ijLQyYB3MRQqk/YoKM/Hd9CM2jFemL
    qVANPq3hBRuIdacxc5+uP9kmGgyr1MTUkaj3kpwSaWybGyYAwuRENxvvUZiLbFD6o/TgJR
    ZjUbfnXWsP4suKeo0aJxyDozPcZY8IIIVreiWawXlEjai9BMjTXnTZ7d8whICAFEQIPH/Q
    1QGQwJAaY6OhfPu0c7JbHcaWQLznYf59KzdghmOhu+VcbHI1V0yzqCEoqfQbTJfJi6RwVG
    2Z6q7Eyq/nGne6llFzcO6L5nJibMk8BxGPf6rDpIusCDVMkyAVgaEm6bY7xOrSl3fs77Ew
    tmqtf0x8ZIcr62BiBgeGzYg3JXXqStIK+I0M2WfTMHMhuSXtzD8plo/CK8JqLZsFo9GbNc
    NL/kd/7lWJMe8/9c8oBbqKyqtmzKVJT6zCIQv8ClUQIjfxyeb8HBOXsd+cdcz1Bhj5NTAa
    LOO+wItDf+U1GcH8bYsfOMK1vd2pnpOBHIedLUSB4IBJAUzKagvxPR1lE6S7Wbhh4wQIsw
    vmU3su+8sXQj+WoiOqsk4+UYndg4DHzAsEiPlRmN68ybHsV+xcz2245MynYTMKu2OAmkql
    rzyEwipywqfWaFMhoAr1ep1rxk7Z/Pl9kbAdBb03MXuXfIBf70N10j+tgMWg
X-ME-Proxy: <xmx:j3RAaokXMpkrUS2paLIVXsK5oiH14BQEe2izO0YdZ2iFXdQ59FwWJw>
    <xmx:j3RAalxj_hEbyzxMhKsw2z7Zik6Sm_ltNF1LjAnxQf0xGKhxtHG1nQ>
    <xmx:j3RAao831o6pNl6ddtIfvSbeBYFlVO7VcAGpsUCzVBCw65osB3R9oA>
    <xmx:j3RAapJ8t8n6zPfclD33_R8OOiyZGLSguVVauOJ8IXF9J3M6Q6rlMw>
    <xmx:j3RAamjCedIKYIcsbGEsw41E8fETL3gXFvlYGml4EOl5Vg7mi-LcZlfm>
Feedback-ID: ib8c04050:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 27 Jun 2026 21:10:38 -0400 (EDT)
From: Hugo Osvaldo Barrera <hugo@whynothugo.nl>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hugo Osvaldo Barrera <hugo@whynothugo.nl>
Subject: [PATCH] Bluetooth: hci_bcm: add BCM43752
Date: Sun, 28 Jun 2026 03:10:32 +0200
Message-ID: <20260628011032.10437-1-hugo@whynothugo.nl>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the compatible for BCM43752 used in Fydetab Duo.

Signed-off-by: Hugo Osvaldo Barrera <hugo@whynothugo.nl>
---
 .../devicetree/bindings/net/bluetooth/brcm,bluetooth.yaml        | 1 +
 drivers/bluetooth/hci_bcm.c                                      | 1 +
 2 files changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/brcm,bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/brcm,bluetooth.yaml
index 95501e858e6f..04e8a968548d 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/brcm,bluetooth.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/brcm,bluetooth.yaml
@@ -29,6 +29,7 @@ properties:
           - brcm,bcm43438-bt
           - brcm,bcm4345c5
           - brcm,bcm43540-bt
+          - brcm,bcm43752-bt
           - brcm,bcm4335a0
           - brcm,bcm4349-bt
           - cypress,cyw4373a0-bt
diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 1a4fc3882fd2..443969afa747 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -1591,6 +1591,7 @@ static const struct of_device_id bcm_bluetooth_of_match[] = {
 	{ .compatible = "brcm,bcm43438-bt", .data = &bcm43438_device_data },
 	{ .compatible = "brcm,bcm4349-bt", .data = &bcm43438_device_data },
 	{ .compatible = "brcm,bcm43540-bt", .data = &bcm4354_device_data },
+	{ .compatible = "brcm,bcm43752-bt" },
 	{ .compatible = "brcm,bcm4335a0" },
 	{ .compatible = "cypress,cyw4373a0-bt", .data = &cyw4373a0_device_data },
 	{ .compatible = "infineon,cyw55572-bt", .data = &cyw55572_device_data },
-- 
2.54.0


