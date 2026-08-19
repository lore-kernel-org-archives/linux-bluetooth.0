Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F01C3C1D56
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 14:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787150640; cv=none; b=LL8lesEqxLeBCGO39sMCMMsZxk0XqTb9lyw1qX4PnXEB0P25llBKBgJ9+FsFtks0WHvzYMiYIobf9qBfqg7UYz/OXPZHm5W1+NbC8vRsETpMNaA8PxuDdGmvANZpqxGDOvL5Sm8UPWzCJXF/qRRzd5BrOw1yCY21Io81FquV1WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787150640; c=relaxed/simple;
	bh=apdXtFtx3Bhn0KYw3reFAOx07EcHKD2fRg6FCIzTNPM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u7HfXkbG39S5TZZa7m2srdYFCkzSf7ODxVcZS1mzqgVaaiZZGfPGdMEcAMJIuAS0ILcry7+2snlYFs9oock4f9HSo3/y8e+rXkvrQ68HOiPpLRMBo/AqMSfWnrmTXN+P+VQR7pHbmphfXOHO2s5BMl+kx3Lrv+HFan2+29q8anY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=gs65NbHq; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="gs65NbHq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1787150628;
	bh=apdXtFtx3Bhn0KYw3reFAOx07EcHKD2fRg6FCIzTNPM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=gs65NbHqOymECB2K5xqwbQbPZ+DBmvnGDMIcbcR0YnEEdnbvuTPazQqHv7AEStceZ
	 Q6OfNpn9GWxhuEABRwNh8bia9LYO7jzwU1egIzelHEs2CjW6GbgX3z3iJ/U5C0OFVP
	 +ynJWdksD9iTYjUkKqrB91vr5kCzcB0KZTJ1HB0Phbgcs81I0MIagJy0BGuPmddx50
	 iJQv8NEGErSZDJIdkvd6iwixKGAvjIEmdP//XknI7GI5m/hZ9LVymC9GAsBt1Ffwa6
	 /5QyVfHqJtBnj3LxRA713hSheA1Z112iNfq1waZ2BTlO67H1l/FTkP8offWs8Hil/V
	 t0Ux11wVQYL0Q==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6FF0B17E0FAF
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 16:43:48 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 5/7] doc: describe admin allowlist runtime enforcement
Date: Wed, 19 Aug 2026 16:43:35 +0200
Message-ID: <20260819144337.889893-6-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260819144337.889893-1-frederic.danis@collabora.com>
References: <20260819144337.889893-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Document that ServiceAllowList now also governs local adapter/server
startup and registration, and that allowlist updates are applied
immediately on initialized adapters.

Clarify ServiceAllowList status semantics for both remote profile
connection policy and local server policy.

Assisted-by: GPT:GPT-5.3-Codex
---
 doc/org.bluez.AdminPolicySet.rst    | 11 +++++++++++
 doc/org.bluez.AdminPolicyStatus.rst |  5 +++++
 2 files changed, 16 insertions(+)

diff --git a/doc/org.bluez.AdminPolicySet.rst b/doc/org.bluez.AdminPolicySet.rst
index db132b7de..991388479 100644
--- a/doc/org.bluez.AdminPolicySet.rst
+++ b/doc/org.bluez.AdminPolicySet.rst
@@ -41,6 +41,17 @@ Sets the service allowlist by specifying service UUIDs.
 When called, **bluetoothd(8)** will block incoming and outgoing connections to
 the service not in UUIDs for all of the clients.
 
+The allowlist also applies to local adapter/server services. When an allowlist
+exists, only adapter/server services whose policy UUID is in UUIDs are started
+or registered.
+
+Updating the allowlist is applied immediately on initialized adapters:
+
+- services that become disallowed are stopped/removed
+- services that become allowed are started/registered
+
+This does not require restarting **bluetoothd(8)** or power-cycling adapters.
+
 Any subsequent calls to this method will supersede any previously set allowlist
 values.  Calling this method with an empty array will allow any service UUIDs to
 be used.
diff --git a/doc/org.bluez.AdminPolicyStatus.rst b/doc/org.bluez.AdminPolicyStatus.rst
index 702e020aa..d44ab9361 100644
--- a/doc/org.bluez.AdminPolicyStatus.rst
+++ b/doc/org.bluez.AdminPolicyStatus.rst
@@ -43,6 +43,11 @@ array{string} ServiceAllowList [readonly, adapter-only]
 
 Current value of service allow list.
 
+When non-empty, this list controls both:
+
+- remote service connection policy for device profiles
+- local adapter/server service startup and registration policy
+
 bool IsAffectedByPolicy [readonly, device-only]
 ```````````````````````````````````````````````
 
-- 
2.43.0

