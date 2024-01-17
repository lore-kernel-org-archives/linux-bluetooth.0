Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9428628699
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jan 2024 22:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705530204; cv=none; b=V2D20b72ziDdNz7DDU+go7eFX19R+JRuYW9YhRl6BuH96BQsoVZt+F3e7ABkUUMhQk1U7LSEvnBSPyYwb/cJZbipg/gfLhZRfzRXGHOh4ef9Fj6u0WaPVspXbufZ28ipCNkHhSDV+KW+zHH5Wk3F0W1cscXHITMpfCqlueVe4rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705530204; c=relaxed/simple;
	bh=TZwuOdM2p/kYD8VmDHysT56kEEbWFnF6JB1KLNKCAVg=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding; b=ZXPm7H7MsJCjgH5fEbLohw46t/CbAkZ8B+Kfi5M6cejCJ8adDkj8u3HZHyzkaEqln4lkxu3Geh2MfSfhaZUcxOrKPbyiLsnXeRdLRGctsjfHScBC2PtxuvZVtxm5hb2OsoVOy3WRrbMLZWtkFgQcVG7YQEztgZlVFI1k3NAakMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UAgohlhA; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UAgohlhA"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-5e89ba9810aso96334237b3.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jan 2024 14:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705530200; x=1706135000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3A+fnt8LtryOwMOS18F4qX5CgiDujh1FzAcsP6LRFLU=;
        b=UAgohlhAEgXHOr7zrxRfO2r4tu68zWT96jQfI+igWQ/sGhM0TwCpb0vY6XRgZ1+sww
         npYc+7EVcNQlT+0KjU0rHF7wrPX63/BOlQq0Z+NxFdvCQ/ty1Nyhc0otfur0zztMnE5m
         hiLg8PllNXGt9VAalCtr8OW7R4n7MpfI4N7qpXJ8b3s/432aEBw4QhqoKVTeUPDWNieM
         50TIOcouBWck7GCKpcL+Tl1CdT0WqXARp4eZSB359eUfwyE76Uk09OMi+tahHGV2Fl0B
         tBKa10AKwFsQDgjf86HLmIqtKGtcsy5JL1un0VABoZLkbaZdj9OLMH0Q5rEXVR5cWlfU
         YWHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705530200; x=1706135000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3A+fnt8LtryOwMOS18F4qX5CgiDujh1FzAcsP6LRFLU=;
        b=G8hU/BGgcPhlvdilXhhYS7ftdgos4L/f0rUiDN13AGXl0CphlA2AOJqrOfetARQcJr
         9+RyKBCT60tnpdC2LpwliLZROIZUHLR/lQojezT9tzJf2qhjpdNz3PP3w7lzD9f8oK4D
         azPzdwWj/JZlWFoyXR3e35F0fACahd369PwFxrbg3yKW77IwK503HcE2pFNA+KEm2osg
         xrOkJP5J6RBs5R0/S8Gt78qF1Ee2V+CtB2kofKXufdlI6IGBKtUHxvnCFb3gJQ50TySI
         uQG0AoQybIt6tUW4d15zAIKJl9mw+N76xgsYd1aJZMH9WpGLxwp3Ft2H6Yc6odLVaf4b
         kobg==
X-Gm-Message-State: AOJu0Yx1TUQMpPYP7SS77R4HGaeLr8jrW6FNoNkKsfPWhhxzJxZclqxi
	g5e41NwPNUEQU8OLy3+OoMtAVUBwv4k=
X-Google-Smtp-Source: AGHT+IG+EzJnv/mqMSOa73A0HM8/oFCz+JWd0GFthX6KsbElN3UkLXCdfyTWcAbmi2bZs9RqtfL5dQ==
X-Received: by 2002:a81:b644:0:b0:5ff:5dcf:44a5 with SMTP id h4-20020a81b644000000b005ff5dcf44a5mr2697674ywk.86.1705530200573;
        Wed, 17 Jan 2024 14:23:20 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id x129-20020a814a87000000b005fc98de3763sm4640553ywa.79.2024.01.17.14.23.19
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 14:23:19 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/2] transport: Print owner information when it exit or release
Date: Wed, 17 Jan 2024 17:23:17 -0500
Message-ID: <20240117222317.1792594-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240117222317.1792594-1-luiz.dentz@gmail.com>
References: <20240117222317.1792594-1-luiz.dentz@gmail.com>
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

