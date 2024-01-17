Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1872325576
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jan 2024 21:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705526899; cv=none; b=RJK6Lejyz3Xi35EKa5zCSboGNplJz5c92dVMJvprJ2R/g646f/2jjAjf7X31YQ+0xQZsZLH5oTXMGInxYtxy6zsOa1PClX00xU7KU0lIa5PMj/OHUUUAa2trhuynJ/sBOAq0s2BttGoM5+HO/KfS+W62jZ7NvbRO0v694fZH00o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705526899; c=relaxed/simple;
	bh=TZwuOdM2p/kYD8VmDHysT56kEEbWFnF6JB1KLNKCAVg=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding; b=FACspKat0XFkNuDEN2zAek6fdaxpbBzurIRL2EyKZRz2YoVwp+kJ6uZUvAc5J4wa7DkE4zn+IioPWCCR1lHeO7qdxNcUuDRPbXyO6qW58glYpNXG5aQJapWJH0qL3ikyrdXzViqGrL96868vX9uNA140ZVgFdOnGksW9fgusmkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GG68jp3g; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GG68jp3g"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3bd7c5b243dso2157891b6e.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jan 2024 13:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705526896; x=1706131696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3A+fnt8LtryOwMOS18F4qX5CgiDujh1FzAcsP6LRFLU=;
        b=GG68jp3gg6/41qvV1yPm3gOh1z9pjdbi/0E4nsu8Vm8cNN8vf9Zanj2eOWA679zxTO
         LsAxyAyM7T8OsiIkEMZSyQiNJqt5XGQx8bG0JeEpMqVPTTIs3BfMOvQo6EpLQxuAwRzL
         bHGnF3u7SBJExbKBe49Ip7w7AoUpTtPsriWH4TM5/1cdGjNlMN89hjoc2opU+lRXi0eu
         9F7E7/9ucMNvCUD4nLg+12QQkRLCJr7Ozb4iw9pnemSJbhAY9zrKK6sWY4jNnPvqVZdP
         rx/WymnxlkwZL77dzYytafcBTw8oFrMqKOI+BXYfhLJ8+xSpvTqmzrKSCzWqr2x2wgeW
         beVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705526896; x=1706131696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3A+fnt8LtryOwMOS18F4qX5CgiDujh1FzAcsP6LRFLU=;
        b=jvVXKbBhI0nnZ0KZ5LuFXleBDeoLLFvBpD13MLvSH8Nrb1XVoThwefvuAFUhksWUkQ
         ukWP/KT5IFlDaaAm4dCv3H8sEmO7j2Axu1nyFopl6ekqllb4H3+kBJfS7wysRQj4SVt3
         YzXPKSgqENFGcxded4sGzBr4LMeG6D2sT6HqP/9NhcooE42z3qzbQr+lWZ1QShFaZO4T
         /zwF2h3P1NrBLnlmvNZNfYpofvy4Mt6tZYxTSbqa+jZVZudB8cJQQUR7zPjsBHBHikzq
         8pBph8qE7WDsSjdqZNrE9U6oIeeWtbtu9occXlVNUYu+Rf74ELg8d7eSvrrlAS7KZ/DH
         fxww==
X-Gm-Message-State: AOJu0YyjhCRYrjMUhypd56F4LCbDT8jMUhQiXijFyHenNszQNroiM/z5
	N0BCpzVrKU02r2H+mUIYl+8AXL3uQ9A=
X-Google-Smtp-Source: AGHT+IEEsY8w8zeYN3j5RGCaKb2rvJxUiLKXQQ4SJ0z4j2S6I3BGhdKkp0ffV8uqmdmmZrVNw/QZsQ==
X-Received: by 2002:a05:6870:d0c4:b0:210:af25:a5a0 with SMTP id k4-20020a056870d0c400b00210af25a5a0mr752235oaa.1.1705526895998;
        Wed, 17 Jan 2024 13:28:15 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id lw21-20020a0568708e1500b0020472215893sm59522oab.31.2024.01.17.13.28.13
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 13:28:13 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/2] transport: Print owner information when it exit or release
Date: Wed, 17 Jan 2024 16:28:11 -0500
Message-ID: <20240117212811.1784326-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240117212811.1784326-1-luiz.dentz@gmail.com>
References: <20240117212811.1784326-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This prints the owner name when it exits/quits/crash or releases a
transport.
---
- Looks like there is a bug/race on codec switch it appears the likes of
  pipewire attempts to call Release in the process which stops the
  acquire/resume:

  bluetoothd[1774429]: profiles/audio/transport.c:transport_set_state() State
  changed /org/bluez/hci0/dev_94_DB_56_F7_F2_88/sep1/fd8: TRANSPORT_G
  bluetoothd[1774429]: profiles/audio/transport.c:media_request_create()
  Request created: method=Acquire id=50
  bluetoothd[1774429]: profiles/audio/transport.c:media_owner_add() Owner
  :1.133105 Request Acquire
  bluetoothd[1774429]: profiles/audio/transport.c:media_transport_set_owner()
  Transport /org/bluez/hci0/dev_94_DB_56_F7_F2_88/sep1/fd8 Owner :1.5
  bluetoothd[1774429]: profiles/audio/transport.c:release() Owner :1.133105
  bluetoothd[1774429]: profiles/audio/transport.c:media_owner_remove() Owner
  :1.133105 Request Acquire

 profiles/audio/transport.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index a4696154aba5..5395985b990f 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -531,6 +531,8 @@ static void media_owner_exit(DBusConnection *connection, void *user_data)
 {
 	struct media_owner *owner = user_data;
 
+	DBG("Owner %s", owner->name);
+
 	owner->watch = 0;
 
 	media_owner_remove(owner);
@@ -742,6 +744,8 @@ static DBusMessage *release(DBusConnection *conn, DBusMessage *msg,
 	if (owner == NULL || g_strcmp0(owner->name, sender) != 0)
 		return btd_error_not_authorized(msg);
 
+	DBG("Owner %s", owner->name);
+
 	if (owner->pending) {
 		const char *member;
 
-- 
2.43.0

