Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8522EB5CD
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 22:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769810593; cv=none; b=QR7ipvk0HfzmFtw0PQn8UG7yDv85Ql9pJxKMw0cEN4nFogY/GNr5hSp7xLnwQRT8Mv3isQxYpauL2JW49PEI5nagOdSnll75O6iYszo9GhKHx2QD/fNKq/Iml/qA4Z63lz85b5ps9A7l0tewPjo22nb8owOpykPCZxu/RA2AOmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769810593; c=relaxed/simple;
	bh=RE5kAdwC2RdbZ28roxPG0cvBkn0AtTODHc8g0G3TnhM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=naCnqGu2dyUUzQ6Krlvdx1sSeozlHRHCw4mN3Dux3I5V5qExnkHtQGPdTno+z35Xy0szkU/ryFkodFZz8oNQvL/J5qTNaPtYPiCg4dXS7dC+1YkzzUPsNglvwk4hp5nTgVksiewNqtWeh/gxHlTvn5LTGFPKhRyXdpNZPFkxqvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BYDSza3B; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BYDSza3B"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-93f5910b06cso1443349241.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 14:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769810591; x=1770415391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pcR5zVeQAuV6iaYG28VaKN6TbF7g2xFreX6+YlILJpU=;
        b=BYDSza3BoUURCM2GYG76wEhxXyoD79cTBS9QruvGOk8MpVdHOZEHoIFjv+8h3jvpXF
         7W6ByXgnYTSQhQySbcllnyBqzMovsX4sA/hchzCIWi0ZBg9ObQ8v3iE1CdHZjTXcjvxA
         zHOK7QAfA+AkIfwnuK41g7ul3xwp3BRwibwbt1Vduk4E1OSwHqkUUX/e+1Nw6U0UDyvn
         CphsGPYMxkVFL1GqAAVIxIpvhPssI537+z2V1UpbhOb9bSEMeZH3fa13MWHr9M1YpkJp
         bBDhDx48gz43EMnZ0OnTzVxvXDsvwwNaMNlxffdTCJTV43R0EQOQ7+LdAwWpw4nzs9om
         ujtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769810591; x=1770415391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pcR5zVeQAuV6iaYG28VaKN6TbF7g2xFreX6+YlILJpU=;
        b=ioopVCag+OlA7jz2iY5pnCrkSBJfKDmD8lZFtUiSCUgz0fcP9pZM3q1k38m52e4ene
         S07y/WRo7G9LogymE4heHG0tPBkgJs5ao/K5lXP9yT3zrglRNboGD5DH1fbV6Uu6QwO7
         t9AfdBrpG29kDGWgezcCuJr+W2RwbQk73NH4btI83uUSsvBXyAVdlDK7dbBrcZ4jeZQY
         hg8jZJHY8LnbmkDU0MShOZ5tYk1yU7IY+lnbwLS31CftzHY+lhdKT3UqCw/FfS64QoT/
         0uGp9LLabA1WMbp38F9QaBiPTdwLf5Yg5CtQiYi4mCSuTbcbhxr051yMCRrUmir3AKPO
         kdeg==
X-Gm-Message-State: AOJu0YySDflesU/lKLwuCGHVYxJ8XHoL2c0Iqkx5QDJegoT009ySMGsT
	NCU4qiq4GJHYmbtG8QjIacCUmTDJdCtL4EJHN7IASZfLh3n8GR+Tq/UKWhlhjQ==
X-Gm-Gg: AZuq6aKkWpZh6H5+lZdHzyxTaOHou4Czg9QOTTDPX96ZdmnYrGKAuq1skohawqt0r/I
	xbFljruhsXrO7mt6Ya+REcwQbABLe7Hy06Si3AqcvUO016f8ftMRlkQ+l1s4y/8HDG5iny7YvIy
	HURa8M6bDn9mJhkSuEPoee9YkHckJ7RWtUqSpWw5mstgg6HM5LW6XhEXJXkG5gxQud8oXYirR+Q
	ISBsuT6pQp6SOlBkp3pNjtpVfPju2P7LgbncGbOKmCh0rP0DMu9pn3GaOe43lEQkZLQ8SUuyea6
	Fb9JQB+pQYcpvlDyDM/RHgG7Hm4zs8hldKhfAoChqquXsifX262fySYfWEweRTrsb8IgMuER3lf
	mhCx8Wj4cm4ww7pWjwA/xXP7p2OWiR+93/cAQUiTr0j7gUKUJCsOEjzhG+pMCXzabM5MXURGqLB
	yUTnDgdXGoMYOHyTQkKrASJ6IgOmOGaJD/SaACARPW6LeUAM5q7i3oWJ0/dzXRw8LLE4ZG6Jc50
	eIKRw==
X-Received: by 2002:a05:6102:5125:b0:5ef:afd9:da31 with SMTP id ada2fe7eead31-5f8cdaa492fmr3054136137.4.1769810590866;
        Fri, 30 Jan 2026 14:03:10 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-948723adb7csm2404052241.2.2026.01.30.14.03.10
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 14:03:10 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 25/37] doc/org.bluez.GattDescriptor: Add Used by reference
Date: Fri, 30 Jan 2026 17:02:16 -0500
Message-ID: <20260130220229.1346261-26-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130220229.1346261-1-luiz.dentz@gmail.com>
References: <20260130220229.1346261-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add :Used by: field linking to bluetoothctl-gatt for this interface
used by GATT descriptor operations.
---
 doc/org.bluez.GattDescriptor.rst | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/doc/org.bluez.GattDescriptor.rst b/doc/org.bluez.GattDescriptor.rst
index 76d274464f51..790a5482d080 100644
--- a/doc/org.bluez.GattDescriptor.rst
+++ b/doc/org.bluez.GattDescriptor.rst
@@ -31,6 +31,7 @@ Client
 :Service:	org.bluez
 :Interface:	org.bluez.GattDescriptor1
 :Object path:	[variable prefix]/{hci0,hci1,...}/dev_{BDADDR}/service#/char#/descriptor#
+:Used by:	**bluetoothctl-gatt(1)**
 
 Server
 ------
@@ -75,6 +76,10 @@ Possible Errors:
 :org.bluez.Error.NotAuthorized:
 :org.bluez.Error.NotSupported:
 
+Examples:
+
+:bluetoothctl: [gatt] > read [offset]
+
 void WriteValue(array{byte} value, dict flags)
 ``````````````````````````````````````````````
 
@@ -117,6 +122,10 @@ Possible Errors:
 :org.bluez.Error.NotSupported:
 :org.bluez.Error.ImproperlyConfigured:
 
+Examples:
+
+:bluetoothctl: [gatt] > write <data=xx ...> [offset] [type]
+
 Properties
 ----------
 
-- 
2.52.0

