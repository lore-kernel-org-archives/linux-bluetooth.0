Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E72B13F43A
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Apr 2024 14:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714142913; cv=none; b=HoMaf0IBWKa+xuB2VtmQnCA/QtA3/Y9oLF5XdGrt4MtA29nAro7bol6CbEPJTt9QgkmJZTLalsOAgMyLUK2Q4/cxaStdEj8E7tefbTgH7xOp0s5GkkKOrYQ72DnOzMPiUban/NYaYRPn/d2EYUanqkmMkv5D0bu3eGElYuowJwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714142913; c=relaxed/simple;
	bh=YWzMb+4eWQz9Tz7k0P2eWRt473A8YnEmKUbp6EMyej0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fnIN/Gt5vjNQWttk4h0fz4cW2iXBBnIeQwMbTjRfZlZ31nZIKSsw+amQXAEmR6b6j2BJp2HgW8S0vAmtNOBrTdWRqYxiHK8UnAfs3Ce9zKRWS5/Fgn05mZZcP0jG3mpZpFiwrYLieR6IhNoDDlbFlzjswk0dMI4n7AnXjd9qV08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XYBRtNLC; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XYBRtNLC"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6f28bb6d747so2003574b3a.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Apr 2024 07:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714142911; x=1714747711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4f3ZGAfcnLTcFX35xtIqjhutqvGFiE+LM2NznGXlNn0=;
        b=XYBRtNLC2Mtf/HNK0DGRW+i0GPE0cr0BBiF+5nF6kFGorvJXJTBPDjR7+WIl3AQvhx
         DNUTatrCHqd2dIKpNMt7o4WuJ577DGA0Dj9Qn8jmTxTdG8RY8Nng1UbKNRMAxq/6NUcd
         A6oyFwfjWi7FyPaGmGEYbUeGZ8S+zoq9FVQ3m69zFmvrOVbS/5j1q8CEyPVZo42OBc5M
         mhzRn6M+WoOjXu+i49yEyX9vwfAN8FRpabvWD3qHLtypksYwc9BPBRxrxL0lGvdF4QYX
         uP1qpsknU11YGHPkKlOLhgpp81gNlmH2jgbND6hEadQO4k1bl7IEEIxb97X5/h0gccDs
         f9ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714142911; x=1714747711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4f3ZGAfcnLTcFX35xtIqjhutqvGFiE+LM2NznGXlNn0=;
        b=bOMBiVLMCcgBDvOuTUQ5kRp99wfm/i+fQrJ5x8dV1PpD4rQGLSAiHlK0nd41Uvs2Kk
         q7iixImUptWAMXBTwIEtv2H5Dl2MFZHxRxUrbWIAgoyAttIh8rNXb+1TcVAi4dCABsSe
         NAzgZQy+0DrhuwVTpYq5eyk0hm7kRX4n8s6bm+4OLWpmoVCB4jp9gbWShZRAMeL+dPG4
         p1O65VoH/3sCVnH2rZeWcEp4NmMq3K1hI/iIk6BUalYmL0E8MnGI3wbO/rS4lKGgD9QF
         ubZoBARROadacg3jikpLi8SP1LgF65lsvjAGekij10TUgO8ds4fro+N49NUKKNk4GM4R
         plRw==
X-Gm-Message-State: AOJu0YzTwcNdXEnW1jirl+8fO8jj7T2UAvTWzYxAlf/+nDpcqcdtR9x+
	CL4sJsyEaPW2oeRMYcBZjSjqePUoFX27d/9Zbkrk329jvGbRJI0DRNrkMg==
X-Google-Smtp-Source: AGHT+IGORfY6NWEZhXvJH6YcIvTkBcm4Unsv+yVAMjLn8bX8bCFoeoABR+5T7rtnSoL2p3ih+NEktA==
X-Received: by 2002:a05:6a00:3a12:b0:6ed:7684:484b with SMTP id fj18-20020a056a003a1200b006ed7684484bmr3045670pfb.27.1714142911042;
        Fri, 26 Apr 2024 07:48:31 -0700 (PDT)
Received: from lvondent-mobl4.. ([107.146.107.67])
        by smtp.gmail.com with ESMTPSA id x23-20020a056a00189700b006edadf8058asm14914487pfh.23.2024.04.26.07.48.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 07:48:29 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/2] gatt-database: Implement support to org.bluez.Error.ImproperlyConfigured
Date: Fri, 26 Apr 2024 10:48:26 -0400
Message-ID: <20240426144826.2608852-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240426144826.2608852-1-luiz.dentz@gmail.com>
References: <20240426144826.2608852-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This implements support for handling when applications reply with
org.bluez.Error.ImproperlyConfigured the code will translate it to
BT_ERROR_CCC_IMPROPERLY_CONFIGURED.

Fixes: https://github.com/bluez/bluez/issues/827
---
 src/gatt-database.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index 7ca2f94222c6..d028ce012b99 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -2248,6 +2248,9 @@ static uint8_t dbus_error_to_att_ecode(const char *name, const char *msg,
 	if (strcmp(name, ERROR_INTERFACE ".InProgress") == 0)
 		return BT_ERROR_ALREADY_IN_PROGRESS;
 
+	if (strcmp(name, ERROR_INTERFACE ".ImproperlyConfigured"))
+		return BT_ERROR_CCC_IMPROPERLY_CONFIGURED;
+
 	if (strcmp(name, ERROR_INTERFACE ".NotPermitted") == 0)
 		return perm_err;
 
-- 
2.44.0

