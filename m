Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A3927A914
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Jun 2025 18:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749147183; cv=none; b=Z1GDDB4WU78S0X0FtD/Yp67/rxBiRfoaw7GntoNiPseduoHNlRvu9guGnub9mmvenbAjmCXP9/IGTUOchu+LvSLobvIdlA01wyRKtiuCALGi4Cc5Pk37H3yAiTqbLBeRn9SWd1wzW9I2KgPD6N6R9hbXkwfXA4mWVLOCZ+IkbOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749147183; c=relaxed/simple;
	bh=Bjb50t2idh0yhufLjPXZ1GJPZpaC9t+3LY3NxTwe4dU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RRV1gvU0rlmcA/hLaDI1CdpyNhf7g5O2Ii489Kdqh0u+2JnXclYe3T1pv0ULwDmWS7UVg6JdMTgCekM7sXdSH7k+n+DRyakJisQUT4hi8kpkAmwhbgO5WIu9WolKgxymqYVgTCNbzkOTJVBSropImdLyqS/YyHPsPcnAAkNYGlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MUmrvj+8; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MUmrvj+8"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-4e58d270436so416471137.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Jun 2025 11:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749147180; x=1749751980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ex/2M17JWK8pzr9zOr5sQ06/tFDbmfexr/CBvyqMY58=;
        b=MUmrvj+8z5YwOJ3j29vSORusY5SNsD/TXZOuSOrqMKlegSwHjKMtdO46m4YJYJu44I
         tkQWLRP6DbaXp1t7RnmXlv6Qr5zh+v9yBJXEWtEHIlxE1X75MqDaZ1SifUFl3yfB0iGG
         IvWOTHPs2tQig0z5mLONZS4n9YH/gaBBSVevsuYZm8bSDGzBUzbeJxkAgOC5qaY7Hjcy
         BF4qtR4xxJgOpgTuCHIoDkONun5gi3cWNXQjIEVr3tzWIzeqAPkqjgzoyVtPyI6raQRv
         d9vXkXgDkamgkUonBqzot0R6EFy/ZiTNZ7TuZIl9m3JnJoy5XohLESJu70Cu5lqprERP
         eG/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749147180; x=1749751980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ex/2M17JWK8pzr9zOr5sQ06/tFDbmfexr/CBvyqMY58=;
        b=Eur7uzoz/G3Rvdo+Uiw1DEETw2ANSVuHM4wQMsSqQdyIZTKDycs/bdMxuHySMNFYAG
         Rsb/rpRm8A0aZnBmtS+Qe0TdkjVDXmT2e8wFvU7AWMG5Gl+2E3c9gc8JUYFE0u5W9Ktt
         yisMmJ4FAR+q5cDD4knIYVOL4rbfeNbTlAo1eOtMeUg3577uYciPc5/Ey8MkI+pb/0To
         7sbbmzMUxs4HW5G8Hv6d0+pMfYN2Hl8w5HzEs26hVCn1VF2cDbuRQ+gAzUQptO/zwV/j
         DVLhPaT1g3AHoD908rB31bIlxX6uXMe807hr0Y8uXWjnbkNXZoD3DPzrx1Bxh9GwZV5s
         1jKQ==
X-Gm-Message-State: AOJu0Yxd46TzAmKK6WexRJQe4nMMJZPhOGhz+11lERL2BK4S6qwIPNcE
	LiDlOzXX2++IXWajwh3tfwnEQqa/P0s9aQ2TCPIcUFFPzYUZZem4ZxJkfyG77FTauek=
X-Gm-Gg: ASbGnctjE7rSJmQ6rcuBMhfcRytM+9ubooFfPNaZoal9r5PJm0fIHJo7BeeQ+WE97Ik
	mphF930nnNroJVt0NnqxwCCSn6QkK1Azj25TzYxG7enQp1v7m3wf54a0SinYitml5Q+V6fKzPh7
	TF6lZi6McAEdx/SB2GGoWZLcqd7fBhCkJ/AWIsGnp9sIFhsrXGrzrNJA3DdwCCgK9qr0iiLe6oX
	Hxr9PUDMNKvChnNBxKrknLNQACGVsmvTp6YQcSBnCNVc6H7ZUVi+HUa0y72oiQO1zgIBOnr5k2T
	A1MTg3B/5vXq7qOkiTgNs9jvnGyMb6Fm2z1ZdT34DssBI4fzVinxtNxKC5lPn2Jg3j6Ib+YKFQy
	AZ3zLI59HLWXnQFtx2znTyBTqBFVLlfQ=
X-Google-Smtp-Source: AGHT+IHqqNkHocGZcwR5rutVUkO004EAtKQE9/XourdwWKziNNty3hnzZyraD5VbYcYS1d+A9dCY/A==
X-Received: by 2002:a05:6102:32c6:b0:4e5:9426:f9e6 with SMTP id ada2fe7eead31-4e772ac5c05mr398045137.23.1749147180306;
        Thu, 05 Jun 2025 11:13:00 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-87ebd194c7bsm4173241.3.2025.06.05.11.12.58
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 11:12:59 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/3] client: Add assistant.list
Date: Thu,  5 Jun 2025 14:12:55 -0400
Message-ID: <20250605181256.853484-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250605181256.853484-1-luiz.dentz@gmail.com>
References: <20250605181256.853484-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds assistant.list command:

assistant.list --help
List available assistants
Usage:
	 list
---
 client/assistant.c                | 14 ++++++++++++++
 client/bluetoothctl-assistant.rst |  7 +++++++
 2 files changed, 21 insertions(+)

diff --git a/client/assistant.c b/client/assistant.c
index 19d9faac57e5..ffefa25baf9b 100644
--- a/client/assistant.c
+++ b/client/assistant.c
@@ -383,11 +383,25 @@ fail:
 	return bt_shell_noninteractive_quit(EXIT_FAILURE);
 }
 
+static void cmd_list_assistant(int argc, char *argv[])
+{
+	GList *l;
+
+	for (l = assistants; l; l = g_list_next(l)) {
+		GDBusProxy *proxy = l->data;
+		print_assistant(proxy, NULL);
+	}
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
 static const struct bt_shell_menu assistant_menu = {
 	.name = "assistant",
 	.desc = "Media Assistant Submenu",
 	.pre_run = assistant_menu_pre_run,
 	.entries = {
+	{ "list",         NULL,    cmd_list_assistant,
+						"List available assistants" },
 	{ "push", "<assistant>", cmd_push_assistant,
 					"Send stream information to peer" },
 	{} },
diff --git a/client/bluetoothctl-assistant.rst b/client/bluetoothctl-assistant.rst
index ea094f444425..75166a6e7928 100644
--- a/client/bluetoothctl-assistant.rst
+++ b/client/bluetoothctl-assistant.rst
@@ -21,6 +21,13 @@ SYNOPSIS
 Assistant Commands
 ==================
 
+list
+----
+
+List available assistants.
+
+:Usage: **> list**
+
 push
 ----
 
-- 
2.49.0

