Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC98248F73
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Jun 2025 18:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749581435; cv=none; b=Dfvw6KCNmq3ua3oleky3Wo74r/PSYyv80GAZyti51aZyqjH+d+tiaobwTWmguWHJdgvQyc/xQugXEEkrk596tdtIjP2omfQ9f3mHbM90EdEp7CxblOlzDflWHx7BwhNagFMQCQ2K68dRjtUCLZK2a2lwpKqyD884xYseGhHx9eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749581435; c=relaxed/simple;
	bh=RVe6zMmUHB98CoMl+XlRxxRuGIQ3slol8ilcOd/uQko=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=JfrSI2WdTs/KBKXaS89JwGzVAwcYMzmbDEQzFUPFktODg8IfDJfZ464R3PkXxCbgbybdi3pHxQ8mfZqUMOD9kZnf1Bob2gBtpvfL0g3CxUkoJsiFZdgNn704o8rvZl9WAv2VFa4GpV5+p9fxXNwNC8fHyzQgrKVkwuFoC1e9JyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aiq2+IEs; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aiq2+IEs"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-40a4de1753fso89738b6e.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Jun 2025 11:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749581432; x=1750186232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=KQ5Qiv7ng/BqHScgLqpGygM6PEeVzLMkzqa8GsIZcpY=;
        b=Aiq2+IEsLfC1IwdCkER4DhFcyWk0YE8hP/Yvb40ISbkufiKvVOatRFSfOxiE1gRdC6
         AsdkMwdvsgXzPx2mopjFbYgSBXsKOuTdvjy1exZVnUXHSm/BRnxbDa0/dOfiLIOWBC/z
         1+3/zwDnJ+YXAsvDpc8Tf81a2KdW9nA8FFnKb6GCdcONkskFF1PAhr4Y3VsSDGHprkWi
         WqiP+twEdHMGNkeabwxg4XcjaCP4EEUz0+WDy25Gac0H0RBQjLpEORutDDPvNSd6KHzE
         Jqy6KhXqePzDBFW4RpRimGEH7Xvl7bLiDVDPFu9tkLnCux0SPnfyMVpspFieIS63H2IE
         euAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749581432; x=1750186232;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KQ5Qiv7ng/BqHScgLqpGygM6PEeVzLMkzqa8GsIZcpY=;
        b=s4h1V0H4CcPA21n60dG3Qfuuda5z3Qxqg4ZSnHUdY3EZvUraKdaxj4ywXxvRUIDyVP
         aBu+242huDJUBYrEGTnEFZ+nT6LRvrRc0monoH9gJxb+7QXVYEYN/ZkCCu5fGdXAXzpC
         DYGEgR0MGqqxhHD0DvI6FsjmLhH7MDeavD2+LNO/llULzECgZj5MLnwY8BFImWXcqudz
         9KGN37tLj7WSKV06WvQt7YN+hTIira+7Vq2qyOkTm7Oa4J7gIQ2aYjoelIlHGQAbdisy
         3TnLT/XLNlRi34ygLv1oufrTOOJub1TzNFSNeqyNa38VZrfMoHY6nog+D1wW8bWlaGLO
         Lz+A==
X-Gm-Message-State: AOJu0YxK+EAXbGu+iyZ/EqzCRJUYQzHHkqMSs1ENN5DdYVYC6+LJSkwn
	ZWrgi4l7hdkbUJqrZJ9Ay61LA6zEYdy/a6JCIpfm/NsQT4EteHV6Eukvw/zdtw==
X-Gm-Gg: ASbGncv0jPewp8m+gC1Ytgoezx4ePnf2VG+yfq2aG3HpFDlQcKANdRtAw/Y1xhkEGTQ
	E7C0v0unJ9oSG/ImpJuWzYUq35g5RsY3qguJpo79/O8lG0cN31pIjcMpBSNmeJ+FTurTSJvPy7j
	0ENjuJ5vtQ3FAK/pFb395PINq7yMn8tDaH1UVWcgIhbbHf+oAYOw0SlAxN9X5uW+vBE/mqpLVZz
	KOsVFKT9gsjpBzBW/fv+WxJwb9XotsQf4T2xAIBnxwsAubNo4hMaGuYB73BNFCMgtg2Y74Q2yV3
	E43SHV8h+NNE2I7Rh6INRyKaP43Skz50vi1FdctHyvk+xPR2erkSHTCdHAVtrPyTXwzfspqj7Qa
	phN2fVjtPJ1PnXNhFMIS8eNtBJEL0kddY0NYEy3azsQ==
X-Google-Smtp-Source: AGHT+IHfpvQaYbU8GdiSCqMr+CsyrXjlKNMO0JAc8nzE7oT7YulYCVOiFnbZOOPZtjpi4+JLOKvUgA==
X-Received: by 2002:a05:6102:3e1f:b0:4e5:5c14:5937 with SMTP id ada2fe7eead31-4e7ba5d5d48mr1010350137.1.1749581421169;
        Tue, 10 Jun 2025 11:50:21 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4e7baee4719sm150150137.9.2025.06.10.11.50.19
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 11:50:20 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] bap: Fix not responding to SetConfiguration
Date: Tue, 10 Jun 2025 14:50:18 -0400
Message-ID: <20250610185018.1141155-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

For broadcast the SetConfiguration would call setup_config which were
not calling the callback so no reply was generated which brakes the
likes of client/script/broadcast-source.bt as endpoint.config would not
complete without a reply.
---
 profiles/audio/bap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 513e207d1424..66403fcb7997 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -1170,6 +1170,7 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 
 	cbdata = new0(struct set_configuration_data, 1);
 	cbdata->setup = setup;
+	cbdata->msg = dbus_message_ref(msg);
 
 	if (setup_config(setup, set_configuration_ready, cbdata)) {
 		DBG("Unable to config stream");
@@ -1178,8 +1179,6 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 		return btd_error_invalid_args(msg);
 	}
 
-	cbdata->msg = dbus_message_ref(msg);
-
 	switch (bt_bap_stream_get_type(setup->stream)) {
 	case BT_BAP_STREAM_TYPE_BCAST:
 		if (ep->data->service)
@@ -1776,6 +1775,7 @@ static int setup_config(struct bap_setup *setup, bap_setup_ready_func_t cb,
 	case BT_BAP_STREAM_TYPE_BCAST:
 		/* Broadcast does not call the callback */
 		setup->id = 0;
+		cb(setup, 0, 0, user_data);
 		break;
 	}
 
-- 
2.49.0

