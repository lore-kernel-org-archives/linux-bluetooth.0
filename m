Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B545FB8D
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Sep 2024 17:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726075261; cv=none; b=Xies1SwoRGOiOdiEH9ZJGqIl2RWusVMq/Msq1/eGMFKPMQksOqzEyc09HNDIxLlKbzuIDjz8vsJKPsJgqWVb4PAJCfvAhSmztAEkcYDhlf+X//xRPY4EqsaWFhaL2DMz3gq27SbJqxphPUKY0teUSrbwDQWjbEKrHkUgVlesZyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726075261; c=relaxed/simple;
	bh=qAQ3+s30Q8nPcs9mnvTkMwBC9IH7FX4L/rpoDj59qKg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=qeMXJM9yDnuE9ksagaCRKlw5pxSgNGI7OfcjQ/GUWazM08NA0hQeRh8ea3ot2l1O+TucTW0gnhOCkF9lxui7Ip/KUZM40Jx3UvEddaVBnx4ObPBgs0WVskb84Fs983Tj4PLg+6pW6C0+pqLwk6OqUW8SN5Vz3CmKk3jV90JOB5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wll35hZW; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wll35hZW"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-846c36009d5so25547241.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Sep 2024 10:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726075258; x=1726680058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=zNadY81Q6hHe5eNpRlL73bk5Jj9PwaFkSTo5UuifMEo=;
        b=Wll35hZWRqVRzIq4stv3HSjK+103RmHfyR4oz2FpHEosvkVfg5ATYZ9vcmqSejYtee
         COjRMMizIakqaAsTxxwXhIu/rykSomT4H3jVQkxJ9+I2rTRdCmIKjpMDHQt37ShcbdM6
         ktChpWTZ6EHCyetmXZRpxnQZVpEFsKz43ayxQboSZD9pAlZEied1u6k+vf9RHB+wKQKg
         lZzvL4Q7LOzQczaN/QLlq+kAc4BpqFcJmGj8k2vYFFacxlmm87KgraMmfxNSEMSs0vY9
         f4ZSEchoZaFLO0j1M4D2//SAI3benXXwyToMuvIW0luLb4+y+Hq9qMHIzsspSb7QUuTs
         wyBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726075258; x=1726680058;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zNadY81Q6hHe5eNpRlL73bk5Jj9PwaFkSTo5UuifMEo=;
        b=cR7PjL/GT7FqHjXuJ+93LWjPcph0sOI204BPC+kj+j6BTOgkjWIAOdYznoCnLN4DNL
         o/Nprc0cKGZyT8RPJsKeNM3mFXWTU2UjYt+KrWk0Ko1copLuxMwzp5KJXm1fD3rlf8xN
         7v0qS8evfJe0mzTSm03GABIOX2DDe7bPIV5n++zciSvGZoQKX3VYSi66DAa/9fTZtDSM
         tIBggFnvZwqf7cJSENcS95HVADtUCYJYnSyO+wGaoe8kH2yBB72b7qZVOrOs7Y3AvZF/
         kpjtyn3CuD/cU9GKU3G2XK9Mclz44xg0oIJ5IrdvRYT5ZT71bxC3BBQk13Q1fFqlLgOC
         JqPw==
X-Gm-Message-State: AOJu0Yz1iRgrrMCd4BcYEbVKQHtlyfUfKQx1fH4Q+cfweb9oO9H/iV45
	RZW0BL/AZbJ+RUOqaGF9lR8rAG8lStzJjMJ409eZuRQdgsOMIg9OdJIWleNc
X-Google-Smtp-Source: AGHT+IE8iWh5s2gecrQZq84lSxp+i7ciQrBIHmBnrX/HaJcC4tHAA5yI39Bv27tsX3Xv7zeoGcm6BQ==
X-Received: by 2002:a05:6122:3c87:b0:4fc:eb15:b0f6 with SMTP id 71dfb90a1353d-5032d4a5264mr374841e0c.8.1726075257646;
        Wed, 11 Sep 2024 10:20:57 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-502f9a2e2a1sm507195e0c.10.2024.09.11.10.20.56
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 10:20:56 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] build: Fix distcheck
Date: Wed, 11 Sep 2024 13:20:55 -0400
Message-ID: <20240911172055.2862355-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the following errors like the following:

../../mesh/mesh-config-json.c:31:10: fatal error: mesh/missing.h: No such file or directory
   31 | #include "mesh/missing.h"
      |          ^~~~~~~~~~~~~~~~
---
 Makefile.mesh  | 2 +-
 Makefile.tools | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile.mesh b/Makefile.mesh
index e4c9fa6a32e6..f5e99a955c77 100644
--- a/Makefile.mesh
+++ b/Makefile.mesh
@@ -38,7 +38,7 @@ mesh_sources = mesh/mesh.h mesh/mesh.c \
 				mesh/keyring.h mesh/keyring.c \
 				mesh/rpl.h mesh/rpl.c \
 				mesh/prv-beacon.h mesh/prvbeac-server.c \
-				mesh/mesh-defs.h
+				mesh/mesh-defs.h mesh/missing.h
 pkglibexec_PROGRAMS += mesh/bluetooth-meshd
 
 mesh/mesh.$(OBJEXT): ell/internal
diff --git a/Makefile.tools b/Makefile.tools
index 48bc47bf1925..71033d6388cf 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -328,7 +328,7 @@ tools_l2ping_LDADD = lib/libbluetooth-internal.la
 tools_bluemoon_SOURCES = tools/bluemoon.c monitor/bt.h
 tools_bluemoon_LDADD = src/libshared-mainloop.la
 
-tools_hex2hcd_SOURCES = tools/hex2hcd.c
+tools_hex2hcd_SOURCES = tools/hex2hcd.c tools/missing.h
 
 tools_mpris_proxy_SOURCES = tools/mpris-proxy.c
 tools_mpris_proxy_LDADD = gdbus/libgdbus-internal.la $(GLIB_LIBS) $(DBUS_LIBS)
-- 
2.46.0

