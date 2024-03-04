Received: from taslin.fdn.fr (taslin.fdn.fr [80.67.169.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E3DC2C6
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 Mar 2024 14:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.67.169.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709562653; cv=none; b=Mc7N8lFp4b9I+SzTyb21QmjnG4nR5Xu6lzofpGXLbeVtBkd8WnXVrb/qdfG3i0kI6FWnqYDnBqFzo6WLAMqooxbulCgonAXnnRYtnfJrGuP+LC64LhYpFsB6KwcczpSyXtjszfC19GFL+3Gr2T99F2UbPPVYFKXhRGcVU5D9Y6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709562653; c=relaxed/simple;
	bh=jwMbm9EbrTydYIVwf5E5ShO9zeWFXcKUmesnDkAZEt4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kY1CdHwKGXSbMuMZPySFo+U+nw3HnotiGmkDuA+Kpv9Wtl4fBjolOKdVfHj+b/WIdM7SPdWHD2tsh1QkEFzrSIReGlnIBgvjjuExQtMWwL06pBbnlUAYUMlyMy/BpWQZxrH6bkk1bDgRCLZ/9ghVXHc3pQQc1B4tkQHbn/BLw74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name; spf=pass smtp.mailfrom=max.gautier.name; dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b=RgnlNAwU; arc=none smtp.client-ip=80.67.169.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=max.gautier.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b="RgnlNAwU"
Received: from localhost (unknown [IPv6:2001:910:10ee:0:3e59:337d:d116:8f67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by taslin.fdn.fr (Postfix) with ESMTPSA id 7B55860249;
	Mon,  4 Mar 2024 15:22:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=max.gautier.name;
	s=fdn; t=1709562126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lY8moMvHRyYcCcSUNVc2Yw+Si8qOEzQdwU9Ch2hsvzg=;
	b=RgnlNAwUmcopA6hZxKtHWo8ai/s5uEwcXbZpviY0dKlRtJKJfTF9fQiQI31lZd8+EuepgX
	TJqwEz/gpwnNFUF+N0UFMuCsS6HHW3OZ6TQOURB/ZNhkykY2e8cj4zHQvkWQRQAF04XPs/
	PWf58GVp0kjPhEeNSgqGmrS34Xi+rdu1Mn4UDEQTITcQuQ8fxLYHM/Apul2ptLwKNaSHPG
	nEbwObp25MzzZFvWyPmTz8M4kfhVWmtMCWProHEiFtCSKex1Ldkf5i8jE1jl3N3H80TYK6
	19jsVZAbJQc1NM0Zpb9r+78Hhlt+7qH6Ym5r687oUu/5N5J1ywJtYACqeFQDBA==
From: Max Gautier <mg@max.gautier.name>
To: linux-bluetooth@vger.kernel.org
Cc: Max Gautier <mg@max.gautier.name>
Subject: [PATCH BlueZ] Don't install conf and state dir on systemd
Date: Mon,  4 Mar 2024 15:21:57 +0100
Message-ID: <20240304142200.69968-1-mg@max.gautier.name>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bluetooth.service file already specify the State and Configuration
directories with the correct modes, which guarantee they will be
available (with proper permissions) when bluetoohd starts.

Not installing those helps implementing the "Hermetic /usr" pattern
(TL;DR: '/usr' contains everything necessary to boostrap a working
system)

Handling this in upstream bluez (rather than in distribution packaging
scripts) avoid duplication of efforts between distros.

Links: https://0pointer.net/blog/fitting-everything-together.html
---
 Makefile.am | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Makefile.am b/Makefile.am
index d94839856..ed4f9dc51 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -422,7 +422,12 @@ include Makefile.obexd
 include android/Makefile.am
 include Makefile.mesh
 
+if SYSTEMD
+install-data-hook: obexd-add-service-symlink
+else
 install-data-hook: bluetoothd-fix-permissions obexd-add-service-symlink
+endif
+
 uninstall-hook: obexd-remove-service-symlink
 
 if HID2HCI
-- 
2.44.0

