Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794588821;
	b=R1c8peqqvnQg2x37iO7CbmZb1vXfr8uRQ+IpEyHkgkMbNX/DCxXByHddk8yDQkX/JGHA
	 tfureDieOgwd/UHvXCqbEj/nQqn5VfyadkopxxJPRkkL/EpE8kN0tTxhHxvpn9IcxI1Ju
	 GI8A9YETtlWo0n6OFpVs3j5g3O3LKtSb34BCtVxFoFb2QU05ZKsi8gy9EBFeOdUg35tqU
	 nZdO2AIu8iC9DRt2mmOEaf1MQqGFK3DFS6UImoQcfxn9rGMEUJhCWYNhnAPVE21Q3H+Oq
	 apEQ1jCwjk5ZKWW9EHVRfBlZpFFt7HSKd16RcX6jbtHy12EwFxesI0Lykb1RqfTIpeA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794588821;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=ZaHO+6xbW5Ux0NtJcT3mSzVeYXwMBUX+UM/ZVbnihEg=;
	b=ctnebOfe9dwRC2vFaxxlDoS2J19vugmzbj6UA6plauvQCkI/jbzgJrgpJSiwV/cekQVj
	 CXVayinRHnzV8/dWm6uklCCE97OYRvG2SG3iC/edkpUf1+knRzE/YRtcKAkNwLeoSOMdK
	 Iz8BD1LYq3/goh40wPrx5orNL9AAwPSigpELxsB8SvNFyxzsDfGwEMf2kjXMFFxldqf1y
	 qXM6vDwOHeoC9hlU6cdlwC5q4XtavnvHzPt0+5tHx4TUDx5emMXg7pf1HikBb0vlnG0P6
	 4Ng6wXxXFl5nQoao2I9ue3d55lxKCdPVWxYt2kpUnnKe80cOD9Jw0lgpS3VXK5qoQjQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qp0Xn8Cx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694D4606A887
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2026 16:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qp0Xn8Cx
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794588821;
	b=liYnMa8hvzv8ZC7oORCds+ERGPBVYVI3dgFc7/+9oMmmyDYotC79LCpu7oP6kXHuWFbz
	 ur/cPgJntC4FxEdeaYmEz8xDwWjw74nUebwx46C243NZG0UTGUbC8wWSDMO/hvDe7ySNy
	 f3Y23TvIAXBr0LYzE1Hwii1vPHmHRev6TXfzOL4py0W5egwObpbTPqB73MwKqkh5v1b/y
	 OI1oKIZLWBLzkWuPUmON/9dZ6gdFtF/AWTo9j3I9M7qPfOlrJjGyMP+z8dEBJDhCkWqOY
	 huc4KNq3+5EiDEOdzRAYgLeYhB21ZfQHwu0Fq/PfaYJ0bFk1M6aolC72GMa+OQrORyg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794588821;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=ZaHO+6xbW5Ux0NtJcT3mSzVeYXwMBUX+UM/ZVbnihEg=;
	b=E2k1msvp5R5+PUPTJaSesUm7P5oeI5/dXQl+WoE99hnQcuO+upKMa1mP/rwWX51QjCBL
	 4kofu8RFHtsUdA30h1nPyuNvWcujqHWeIz3gHz/6gVGqI0aVv1neIoXeN/+wkil6A1Njy
	 LIxJyc1AKTDqqR8XmRFMmiQW0In8zE0SvShLm1uw5ekypa9a86EPQW8E6v7+IBmbRYatU
	 xXD4lANy4fkQ6bEEBGVRlQ8dJC+GVxBepjnwSMt8uqd4aOZrdZ/fhA7DEOcQ/SazUsmx8
	 4/zd1ZaIcz33VhXne+M5xwSHSfDKK1ggHGhxyO8bBO4uC4PWIKyo0pPXBqTQ4Jsex1A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id CD3F91F000C4
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2026 16:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794588821;
	bh=ZaHO+6xbW5Ux0NtJcT3mSzVeYXwMBUX+UM/ZVbnihEg=;
	h=From:Subject:Date:To:Reply-To;
	b=Qp0Xn8CxsF7Ye7XWSjnIo1S5hMIEa8n+diZjqiRYqn75J9bBenO6YPCrqKdxgavFI
	 asPW5QvlZW4jKLPF6fJGOTe9Z+zBUbSjLZMV3yj4xNlV/a++F7PVv/IGECAi0J9O/c
	 VTc4VEaxMV7z4eDzmdLy/WXNqG3OisArwCjQseaoXZtBLOlOpuZOig8vgVj1GztVH3
	 vCcrAvl+QKJvksfBlzjwyES/Qsg7oOP9/yNNaU481GrTlfM5RqfpF1fuI/DeZGB2eD
	 dTCkUa8IPI7j7ofkvnw6K1wzKTfUzuEsUFX6CxbaA+USoa1IF74lhcvwvW6Te9AQ+1
	 7APpmj7CB2pmA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 4623F49991
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2026 16:53:40 +0000 (UTC)
From: Marian Poltak via B4 Relay <devnull+marianpoltak.gmail.com@kernel.org>
Subject: [PATCH bluez v2 0/2] shared/gatt-client: Fix init when Service
 Changed lacks Indicate
Date: Fri, 13 Nov 2026 17:53:39 +0100
Message-Id: <20261113-svc-chngd-notify-only-v2-0-e07cc198f32b@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNSw6DMBBDr4Jm3amYgIroqveoWEB+jARJldCoF
 HH3RrlAF148W7YPiDqwjnCvDgg6cWTvMohLBXIendXIKjOIWtyISGBMEuXsrELnNzY7erfsaEi
 R6nvVmKaF3H0FbfhTdp8wLW/9hSHbM8fNh728JSrhn+FEWKPs1NSNss0yD7uOvFylX2E4z/MH+
 48ijsEAAAA=
X-Change-ID: 20261112-svc-chngd-notify-only-f1d1d99d3f34
To: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794588819; l=1251;
 i=marianpoltak@gmail.com; s=20261112; h=from:subject:message-id;
 bh=cU0eWVhQ+xVj3g+Gv9TfHlL2h2IVIvL88iR1p7mjDvc=;
 b=pljTBl/XB8PkI2Qt5r0/6dJ1VZPhoETA3nKfGcT5sZuVLXWXq5k2gcLlQ1EjRBfg+KpIE65qO
 HPB2oF9K3+RDSNXpb+USZboVb7mF6xMhiknimi6j/OQprUQ2cw9TWVR
X-Developer-Key: i=marianpoltak@gmail.com; a=ed25519;
 pk=VPxSnAMaNkyjfVbKo8tQ1gFPwqOoZoPqtVZ8znSiAiA=
X-Endpoint-Received: by B4 Relay for marianpoltak@gmail.com/20261112 with
 auth_id=1502
X-Original-From: Marian Poltak <marianpoltak@gmail.com>
Reply-To: marianpoltak@gmail.com

Some devices, e.g. the Aqara Presence Sensor P2 in Matter commissioning
mode, declare the Service Changed characteristic as Read | Notify only.
The client initialization then fails because indications are requested
explicitly, so no services are exported although ServicesResolved is
set.

Patch 1 requests indications only when the characteristic supports
them. Patch 2 adds unit tests for both cases.

---
Changes in v2:
- unit/test-gatt: keep the new tests running until the Service Changed
  CCC write is exchanged; they previously ended as "Not Run" once the
  client reported ready (reported by Copilot review).
- Link to v1: https://patch.msgid.link/20261112-svc-chngd-notify-only-v1-0-c7db7ac47acf@gmail.com

---
Marian Poltak (2):
      shared/gatt-client: Fix init when Service Changed lacks Indicate
      unit/test-gatt: Add Service Changed registration tests

 src/shared/gatt-client.c | 15 +++++++++++++-
 unit/test-gatt.c         | 53 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+), 1 deletion(-)
---
base-commit: 9659adb6819d7e0284d0d2ba226a3894423d8db4
change-id: 20261112-svc-chngd-notify-only-f1d1d99d3f34

Best regards,
-- 
Marian Poltak <marianpoltak@gmail.com>


