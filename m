Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637513F7891
	for <linux-bluetooth@vger.kernel.org>; Sat, 25 Jul 2026 20:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785010758; cv=none; b=JGj3u6aP5aeVHFSvbFy4+jooGqraDQ+GdnaAFgB0wkzrX7N1mfrYakhwGBN3fP7UO5qQR8L0qCQja/Ouq6ZagdhahiVgHOtRAQ+7MvnLZNIN6og9oODOxbfbYR+7Ta5K8WXmFBJSL+sLA7Gv8XcnDYsujcZdrQG1YMjfAepletY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785010758; c=relaxed/simple;
	bh=3igNGiPbbsnXtFgNU4iZbGFIfRyduHmXUAaX7YQHd/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C1VzMKTeDgdA1dIzmK9gQ9bg18otv4a8IJ+fq3HJTXzsY6m3mVq1ebtoyI7FNQz3FiJam8Jqfie8pU2V/ywY8WGC+zkPu0mIlAHNa98EmDSJlVcXI58mdswdOwwb8pZ7Rqiwce6/kR9QIsMhzkaEEPZOL5fu9Rhw+L3d2vSmvwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tgX0flGn; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tgX0flGn"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785010754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pt8RggeJyiq8QuxYCbNfsvZB8dz4pxnCkvpw6fQ+30g=;
	b=tgX0flGn3+jCDUITxwBf74mWrd4g2IXeBpi9m5j6dFNLjom5x2QUUWTDIMgjDGdHBBtef5
	tsdzgIJc86BE/yOk6MFs0EHlsKtL8KetFxrwGRXszViAdHUy7dMl31wD4cMb2KIEYdbFNb
	Nne8j8AnuYpe1KbWGxOuNPeDcfE+7xA=
From: Matthew Schwartz <matthew.schwartz@linux.dev>
To: linux-bluetooth@vger.kernel.org
Cc: Matthew Schwartz <matthew.schwartz@linux.dev>
Subject: [PATCH BlueZ 3/3] doc: Mark WakeAllowed as optional
Date: Sat, 25 Jul 2026 13:18:56 -0700
Message-ID: <20260725201856.2142333-4-matthew.schwartz@linux.dev>
In-Reply-To: <20260725201856.2142333-1-matthew.schwartz@linux.dev>
References: <20260725201856.2142333-1-matthew.schwartz@linux.dev>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

WakeAllowed is only present on devices with a profile that supports
wake configuration, and now only when the adapter itself is able to
wake the host. Mark it optional like the other conditional Device1
properties and document when it is present.
---
 doc/org.bluez.Device.rst | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/doc/org.bluez.Device.rst b/doc/org.bluez.Device.rst
index 3e6a30aaf..8b6b9e866 100644
--- a/doc/org.bluez.Device.rst
+++ b/doc/org.bluez.Device.rst
@@ -330,11 +330,14 @@ Examples:
 :bluetoothctl: > block [dev]
 :bluetoothctl: > unblock [dev]
 
-boolean WakeAllowed [readwrite]
-```````````````````````````````
+boolean WakeAllowed [readwrite, optional]
+`````````````````````````````````````````
 
 If set to true this device will be allowed to wake the host from system suspend.
 
+Only present on devices with a profile that supports wake configuration (e.g.
+HID) and when the host controller is configured to be able to wake the system.
+
 Examples:
 
 :bluetoothctl: > wake [dev] [on/off]
-- 
2.55.0

