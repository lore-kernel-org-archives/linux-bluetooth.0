Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795522647;
	b=rhPGenXG+wsEYHxEzKW3KDdT0vymtJwm0LrLxkjVyNON2VtDQBjWAgyCRJ+S0JwiqoRD
	 nqZPkDbsgq+gUV46q/47dsvuWSoh/57c5Nb4qeYDDdX/KsZ++hM1VYrC9Mllh7TtrgkFg
	 8Y5FrxyU6UF1eBg0w9Mn5poRKNYBO9iK1LjELoNmQexIWCAUUFuJlaHrTjv3MMONaZFnQ
	 B8oyY7Sir7Jo7+gf/W2cUKbrNyInQo5qXZbdX96lC4xR53X3ZsDMMZKoW5beDa0UAC/TX
	 ly4px9N4nP9zZGn4r9blIpM3TcOgTkZys209hR3m0pCYc5JttsInULLu4mjgD111bMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795522647;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Type:Content-Type:
	 Content-Transfer-Encoding;
	bh=0LifVzlYtsielq+UoPSSnYxf6dng+u/CLX4Gv9VJzLg=;
	b=k5PJzEIjQP9jh/31LrRPZ/OdVowP59KzDq4C7cpH8Pz1R1NamQIPZRfWk6iTECeKYlPD
	 Q7SDy90wLdsXbgsRHN9HfZGVlR4wHA58MzlLuBjJ08chscbNlCjyEe9mQ1BQKfnjnhiSe
	 z0TuJ3WNYv/IdrbGzrb6hI/kkCxE/Ke16S9jiRANu5FMbjegxFie5qXYvsRjefSSquYUP
	 bPMvPsIJAu9tgTfcjBWxSaXYjnjqXJGdr9FaJukx90NBU1rxqKrJbgbSznZ2z8bq4FrUK
	 3lyRNzitmemX35Mq4Cg0kWpcRFtlRK2/QNaRAwlVmjX0EvmjTb9rq8+PEsiWQuLD65A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=lmjB+G+E;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E585606A685
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 12:17:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E585606A685
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=lmjB+G+E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795522644;
	bh=vkOyT2VBTLjIjiEqubrkcnrHefGrPsqIfe4L7l0C7Jk=;
	h=From:To:Subject:Date:From;
	b=lmjB+G+E5sPO4x6S5qcxs7XAXmYRnB/AR4sXUndJEfuWJxPWiRU6EmyEIdegeDPkZ
	 pAuha9HCPsy7AIzg/NIO4QQ0GcB4nNThOs6dUNmAsGmdzMDGTSmfIK9e/6LCD4WbWO
	 /pvMHSoOl0YM+MA+pZuZX6V24s5ORE9n5HXH4RlOrmwNN8B/u+6qHVCPdtl5Od3hCN
	 z0+6MeXNdJH3CcyghFNWWAxd64GRFKTKIhdxW4t1QuS0kzfNaGVgmKIxo8x5RJP3Q5
	 1ODsnOZ9Oq2vJImr2N/UqmbP8An0LM7bnkQbOYUx4Cx9T1lDW7D9lTo55sKi5stAdX
	 SYH9RDIH9TqXA==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5134017E08C6
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 13:17:24 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 0/3] client/btpclient: Security Level reporting
Date: Tue, 24 Nov 2026 13:17:16 +0100
Message-ID: <20261124121719.280039-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Set org.bluez.Device SecurityLevel and EncryptionType properties to
optional so application can access them only when they are meaningful.

Send BTP_EV_GAP_SEC_LEVEL_CHANGED event from SecurityLevel property
changes once the device's services are resolved, matching the BTP levels
expected by auto-pts.
This reduces connection time for the BAP tests.

v1->v2: Retitled patch 1 from "device: Provide Security Level related
  props when supported by kernel" (subject line was exceeding the
  mailing list's 80-character limit with the series prefix).
v2->v3: Patch 3 (BTP_EV_GAP_SEC_LEVEL_CHANGED support): only read and
  report SecurityLevel when ServicesResolved becomes true, so a stale
  cached level isn't reported as a security-level-changed event when an
  encrypted peer disconnects.

Frédéric Danis (3):
  device: Provide Security Level props when kernel supports them
  org.bluez.Device: Make Security Level props optional
  client/btpclient: Add BTP_EV_GAP_SEC_LEVEL_CHANGED support

 client/btpclient/gap.c   | 56 +++++++++++++++++++++++++++++++++++++++-
 doc/org.bluez.Device.rst |  8 +++---
 src/adapter.c            |  4 +++
 src/adapter.h            |  1 +
 src/device.c             | 13 ++++++++--
 src/shared/btp.h         | 11 ++++++++
 6 files changed, 86 insertions(+), 7 deletions(-)

-- 
2.43.0

