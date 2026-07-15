Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4440D3E6DC3
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2026 09:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784106151; cv=none; b=f+Qf6xWz02dwl6v/WkzTRXLz2GsnUE61VaSsXckGgPjUMJTbKdc8bZKVBcvvaEAimVGaVS8H2fwa4kFbN+9GnvjO6hXv05M5uxb8lZh8Qigr10T5VKmxCG05NJjIIft7k7WMGcAaRdrzEGXFsizTBN/5U7nDJ51vvygM+dlWLIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784106151; c=relaxed/simple;
	bh=9/wGKKGJpBaTn34yD8jkIBOphNMn2I2ECbGzheEDkn0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cGQ1HVCtvih3n0j9pxSuSp9ZcY+rAtv3bTynmbXJ2+FFLNwInN+yJlk8lWFqxh47u4IMz2xFxXw5VflMqKzAvu8rlN+0nUKY5J7kx86UkJYusPWLaLRZrF60J4oKc0NnYZ1/vXUxSB/mysQWEqOx6rXfpgkJxWcYROyCMRBTE9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=abn7zi34; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="abn7zi34"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1784106135;
	bh=9/wGKKGJpBaTn34yD8jkIBOphNMn2I2ECbGzheEDkn0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=abn7zi34m2udSqzR/NxxAO0KMElzL0Av1dugxAf9pKkyz5V7kFgLv4N5IHLgin4eu
	 2tEMjPA7yCC0zEA52WCMPXXsLM6UnRX5FgR609uhslTsSjpa9+62UCEoYIAJFcEtMa
	 IFYJSk8MIeNzK+b4B+E3vqkpBoHp5UX3tjLrrmtXYQFLEOTzRJyHfKYMxHZ3X74EYu
	 X7zgRrCFfmEhjomaHD2cwNQvwiBC96ebK0IBU4T22BtIufMxWOgOSoTlWtDaf4vdZi
	 abF03q1BGIQG38XF8p3CHe/x19mua1O2SVaXP4+e2EXLiB+8qwC8PJ1g25Mk1ekR1e
	 7unAbZX+qnzOA==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 40C2917E0E4C
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2026 11:02:15 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 6/8] doc: describe admin allowlist runtime enforcement
Date: Wed, 15 Jul 2026 11:02:04 +0200
Message-ID: <20260715090206.212130-7-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715090206.212130-1-frederic.danis@collabora.com>
References: <20260715090206.212130-1-frederic.danis@collabora.com>
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
index 29fe3bdf7..9ac0aa76f 100644
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

