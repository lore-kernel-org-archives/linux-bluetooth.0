Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C912F3DEFF0
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Apr 2026 10:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776940783; cv=none; b=ZRLHSeEhC+cxJBmdxOrqy+oCTcmeUHus2M/+zFhl0Z1JP2oqKzEdUhcSKtZYMSVfJ0rO6+l60oK64gs8K1aOEcTFPsQ5BDva86CC5AAK/OK0Y41oy8ovo2jyz1GcvgB33x0PgilaQ2o2XUmY4Og7ry+7yzu0Fp3r9ST8uY16NVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776940783; c=relaxed/simple;
	bh=kq7MfNLwuLXTiZiPVorUHmCI88HVr+aXr9qC7kQ/M9I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nse1VSjq4mXJ8Q7Klrx4gv14wfrw4SsziR0jqRqw8PdFaNvrjJaJHVWIiqLTouX1Sc3I3zeZ8IoJVh1OmFWUThi6YIgP+0x2XVGMF75jlTAzArN5aVPTT/qs7F1SbHO44usyfCHQR2kplbnVtHXQB5rw4Welzyevq1N4jWIgXEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=V/uM5l0a; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="V/uM5l0a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1776940780;
	bh=kq7MfNLwuLXTiZiPVorUHmCI88HVr+aXr9qC7kQ/M9I=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=V/uM5l0aSK1nKR98tex9f+x4Iw6RNeMrHrifLqrS+MOgFCSZaj0BnSVXurKw/fePT
	 +rdI7+6idi795orx/uEat7NJTH1hM6H51I9zCVCCBnwwK0iVEa5Z93l2oeZMfFUgRi
	 O0b7YhHTYEFAe2wUiJMruC/uv/ZjqP4biSz35CX3GOnV/QqHWolQCSnNtirkHPbyTf
	 BS38Pdd1QqKDkEtKJsf06ZhVGn2QYABqHA0RvMJ0A7CpCt5BRrM9FWSszZDgz2+D2I
	 0PeOZ1DOYRQLLU58V84VcpuyUrKin5CMQgYPfqhObESrkjQDVvlsBKZ844acHllVe/
	 wQWorz8eM2b2w==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1D1EA17E1352
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Apr 2026 12:39:40 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 2/3] doc: Add documentation for readwrite CIS transport Links property
Date: Thu, 23 Apr 2026 12:39:33 +0200
Message-ID: <20260423103934.22799-2-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260423103934.22799-1-frederic.danis@collabora.com>
References: <20260423103934.22799-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

This is only supported when bluetoothd is started in testing mode.
---
 doc/org.bluez.MediaTransport.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/doc/org.bluez.MediaTransport.rst b/doc/org.bluez.MediaTransport.rst
index 81cf9e4da..fe69f948b 100644
--- a/doc/org.bluez.MediaTransport.rst
+++ b/doc/org.bluez.MediaTransport.rst
@@ -180,6 +180,11 @@ array{object} Links [readonly, optional, CIS only, experimental]
 
 Linked transport objects which the transport is associated with.
 
+If D-Bus testing interfaces as been enabled this property is readwrite.
+
+This can be used to manually unlink transport objects by sending empty array.
+Then, each link needs be acquired separately.
+
 array{object} Links [readwrite, BIS only, experimental]
 ```````````````````````````````````````````````````````
 
-- 
2.43.0

