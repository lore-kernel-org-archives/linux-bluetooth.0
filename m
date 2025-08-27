Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43252777FD
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 Aug 2025 14:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756303471; cv=none; b=f9lelMA36VIR5m3bhdBtpJCpBzryQ0Vdq12Z188L6p3KzOOg90frEe5n9jswyLzud//b8PZYh7VLvQXITN+jtJWlF0Not87MIt2vnHE+sU1CTY9KrzeNECOCt5TpJmJ3HbG2jHzQeHfjj1Y63exu99x+GFUmVvo4of2+JyjOxMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756303471; c=relaxed/simple;
	bh=7zmeMBx8Tlk30i5zTDHtwjD3IFIdsjcdMn2Y9HLXuAI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=XWtwFq0Cnq+ONjn0lsUrIylk5tvxKycWDNXjGzjDYZgUv9wx86BEohQlX1+fzz5+nEOtY9oOPdEg/FE6SOAepjyruB/S9piy7uTOa/SZ90ps57oHJLU4shTj1eu/GBxtYQWt0jYZQ5Pj2CoTzznkzxrJ/HNtgxPlpNX5I5Ho1s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TQ66360J; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQ66360J"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-51ee492dd2aso2539688137.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Aug 2025 07:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756303468; x=1756908268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=R93x58jDQReuEIEurwAaemi5UY+1BDa8iDDbMaty86w=;
        b=TQ66360Jsa/YzrOaH94GtdhYV0+yCOFlC8ol+8S60WBuBRCz4DispwCJeaZuSOox4d
         YOWdU3W78qf0v1NcmWtJly9lsf16onD8HhItl8L1IlM4BFvPbiv8J6H9LT47vtovqO0+
         G1v74hy8mqiZb/AhpqUwioggSqPLPtFC3Xd6v43U36zkg5wGdkBfDrSzOa3lAPi/TNiq
         lTbHXX/dYdmeiNwN6D26DP2wFxV0uOZvhbpBm9cBPm5XIHDxzAE2hIcf9U5idzQcE/zn
         dfd6IaZFQcaAsAwhlf3w9IxByG5b02aN1a6+PhVM/gbosKeTQR+sEHlJv7FpbtzBADvp
         q1RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756303468; x=1756908268;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R93x58jDQReuEIEurwAaemi5UY+1BDa8iDDbMaty86w=;
        b=q9DcXV2EVHP/SrCg9DqBTvCTGRPyDsHIgiesVRunK/xvtrIA9CNCFYqu1+RiTZewCh
         c5+UIS/bFJxlF8vaTphnPHs+khKHzjETCPcf3VhnYVbYcGfzCXngeREEnX7HBwGVy3+K
         b3+6alIDlxpGRVGsOardHIGkaqx0ssh6uWl0nRCZMDexktWoPgk9yTY1KxDfhjL4/u3M
         EDtQYTo7GPXsRvLEvQM1SEwZe6riTZVV5LET++aceUOOeSwvqyvuo72Zml2qYZHWFIaJ
         mTzwBvqJHUyBsnNTohqpaPsfvfj8iMvp8NvZVm8si6LvhlKJ6Da4p6/pR7am2/mScpbo
         cubg==
X-Gm-Message-State: AOJu0YyrcZRj3ONe2jfvzsbGaEgakaXnrHBaZojaYzDOF+A1WUebeKFj
	rSWCOlMV8d5sHPXql/CierkSxaLtNjJD3H5ZbRYKWi66WZMBVAruEO6vZJzvowvy
X-Gm-Gg: ASbGncuy6R3eGwEpvAVWij67I4VkwKhWUxrV2X+tKMVtJTv/gbGTBdAkdOYA00cfzyi
	1WMGw09Ea/G2bFqIqQzsnGrdtuIoPT+bS2iX1MbLotgyBEpKEISnRL/SYNr1qFQusm603HzXL1i
	qT88qGKSMCxb7zTXnXvww3mPLUeET04ZiDkrMXgVEphPUSE4dGZmZ/fD6V68qaz9uNQ5WRki+fz
	lOXuNhIuRHZWpbLro3j+5sxKmc0GEfjODH8Kh3Jqi171sgF9+ps03eGLuJ5d4nqIuXrCxxy2EG5
	QEyeXfYFZXViZhhdWSKNvVTxejQhl/iayWo4UEEKPvqTnOPBRgsiXYEtS2YOMOTLiQapsRMWyqw
	y5LGzoqqJOF/MChHsL4lgGEQLLEJM/VraROCWLBOMrisvTDSGAiz9gJDuEOyRQF7TWFTTFtgPgS
	slcv08O28nOFb7rDCoC+ouC2Gkn+UsDmWrTrAqebc=
X-Google-Smtp-Source: AGHT+IHpIfpylbBy+BGP09Zyl3NL7lW5vC9ofKfj+bGIBV9bbUgtE4tGzzyNvCHeMKPcogSw1u442g==
X-Received: by 2002:a05:6102:2ac7:b0:527:4113:6aef with SMTP id ada2fe7eead31-52741137164mr684297137.17.1756303467705;
        Wed, 27 Aug 2025 07:04:27 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-89419b15db3sm925336241.7.2025.08.27.07.04.25
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 07:04:26 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] client: Fix transport.acquire not doing anything
Date: Wed, 27 Aug 2025 10:04:16 -0400
Message-ID: <20250827140416.1338566-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If transport.acquire is called for a transport that does not use a local
endpoint it won't call Transport.Acquire as the bluetoothd does not
allow controlling transports of other processes, but it doesn't print
anything either leaving the user blind to what is happening.

Fixes: https://github.com/bluez/bluez/issues/1532
---
 client/player.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/client/player.c b/client/player.c
index 8e68fbcc054a..598ad7f6dfd7 100644
--- a/client/player.c
+++ b/client/player.c
@@ -5017,8 +5017,15 @@ static void transport_acquire(GDBusProxy *proxy, bool prompt)
 	 * endpoint.
 	 */
 	ep = find_ep_by_transport(g_dbus_proxy_get_path(proxy));
-	if (!ep || queue_find(ep->acquiring, NULL, proxy))
+	if (!ep) {
+		bt_shell_printf("transport endpoint not found\n");
 		return;
+	}
+
+	if (queue_find(ep->acquiring, NULL, proxy)) {
+		bt_shell_printf("acquire already in progress\n");
+		return;
+	}
 
 	if (!ep->broadcast) {
 		link = find_link_by_proxy(proxy);
-- 
2.50.1

