Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16491B81F
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Apr 2024 08:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712910253; cv=none; b=QrViJvNF5h8u3nAQ36QRhFnYsbj6qNEoG5D79FNP0H8I/wxGdhVBzhQvRjZmdPqXw+n2+rDTIOO6J0kcBsIQXPipfnevuRtJGoSG2Ev4FaF8CXqE6fL98rgvy7IJoIGoRKmmGFx+hW4tHu6c212+3jmUeRnGtWbQR2DDCasUuVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712910253; c=relaxed/simple;
	bh=+s6cMQQxp001mjfbrb31iAlVPsr9RuAORJw8X9ToNMg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ssHdWt5km3Lz46wi/LLH220zdTUeOSnOLqqHytzmEA3paKVjg157bOyWDnB9UxtOB/fOmQQ1gqvCWGUnPdCAXPAs3vtCTdlxhlX6C5xIl7+IQguqCYd3Nv/SKPTAK5kfhWOrdpU3GsppQYBUH3MjvS2tbJQNcOifbcFDwysUf9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WM1AX8NB; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WM1AX8NB"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56e477db7fbso877178a12.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Apr 2024 01:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712910250; x=1713515050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DuNdQAtLkWYGN0fPqcE7t0xY1JsPEeGxT6N0aOA+6o8=;
        b=WM1AX8NBFBcnj9IJ1WwQwglrBrSnzkF3jQe4C6ZgmZR1uCQOpWXLJ00e8JxrVfLVGJ
         Tua34t+zlxsMZ3yXXXjSTQ4Wt4g4I0ca2SwIyXUbjYONgdFslNqxz/It4MYKnDatEBY/
         kAJzFRJAudlSu9i2Ta9AYa07TaAfjIMNzY+BT+YqDUsZVIg438tB/kdTHqeYToBf2Tzj
         6hCbMq4KrEh2TForga3bnt5JFyeAti1WcCdyATBsxbZtnI02am+4E9DV77nr2/bfui+H
         I+71uxa6LnuJ7DQmHctvmgyklilnZBeNxfLKC7unKR4JbIp9299gm3zmhXpSXeeX9ySP
         KZ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712910250; x=1713515050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DuNdQAtLkWYGN0fPqcE7t0xY1JsPEeGxT6N0aOA+6o8=;
        b=QyHluVbfTW6ba7vQ5l+5Bc/QDoFLbf3eNiYT8AyYN0tEt+QFDUvX+x3wDZBQF/dRtX
         tnBE8VUNok6cuZujceQmjed4ncxQCTn1ePev2+fC7vkI+/qFmuCFLdXZGygCR3gOewoJ
         tc/vsmiN8Fa92LePVfxjepbRg3qwR0SbFv0E3fPS3Hsvrmk3DLMPSNpoay3LYq0CalxV
         cjW8UX4P5nmoJrGhpBnOBTVXF135wHOakwz5hvOcHpGYY1SKAhOUiBSiY1USLKVlrZhI
         mblXE3iZP3xEgT/w0vIvhquScvYdpMLZ5O0DmrG0E6RTOHwhjFkgi+gfLyPGtY89SXjq
         Y9hg==
X-Gm-Message-State: AOJu0Ywf0wKqge9g73BeaKqZoyjkGo9Nt/ngNt/sfCN8/chSf0M7b/0O
	PdubMFsv0mE7NZ8Ko8O+mbKuMBRPtC+eykGjoP7vYLwQNiUjCUfJCFAaoQ==
X-Google-Smtp-Source: AGHT+IHp2SEYeMWudLac+xBLELn/sY4A+gmlWy9peOUr1C6W+dtj5+7HLL5uHMFD/BGPlDCpD7kx7w==
X-Received: by 2002:a50:d54f:0:b0:56d:fbea:40ae with SMTP id f15-20020a50d54f000000b0056dfbea40aemr1361387edj.23.1712910249398;
        Fri, 12 Apr 2024 01:24:09 -0700 (PDT)
Received: from raspberrypi.home (46.205.194.2.nat.ftth.dynamic.t-mobile.pl. [46.205.194.2])
        by smtp.gmail.com with ESMTPSA id t13-20020a056402240d00b00568afb0e731sm1440807eda.63.2024.04.12.01.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 01:24:08 -0700 (PDT)
From: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Subject: [PATCH BlueZ v2] advertising: Do not crash in case of adv update failure
Date: Fri, 12 Apr 2024 10:23:51 +0200
Message-Id: <20240412082351.930802-1-arkadiusz.bokowy@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240403171236.853491-1-arkadiusz.bokowy@gmail.com>
References: <20240403171236.853491-1-arkadiusz.bokowy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The refresh_extended_adv() is used in case of direct advertising
request from the client or in case of advertising properties update
or configured advertising timeout. In the two latter cases it is not
possible to prepare reply D-Bus message, because there is no request
message to begin with.

bluetoothd: ../src/advertising.c:add_client_complete() Failed to add
            advertisement: Busy (0x0a)
dbus: arguments to dbus_message_get_no_reply() were incorrect, assertion
"message != NULL" failed in file ../../../dbus/dbus-message.c line 3235.
This is normally a bug in some application using the D-Bus library.
---
 src/advertising.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/src/advertising.c b/src/advertising.c
index 7f55a20e3..ad28f6f77 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -1259,9 +1259,18 @@ static void add_client_complete(struct btd_adv_client *client, uint8_t status)
 {
 	DBusMessage *reply;
 
-	if (status) {
+	if (status)
 		error("Failed to add advertisement: %s (0x%02x)",
 						mgmt_errstr(status), status);
+
+	/* If the advertising request was not started by a direct call from
+	 * the client, but rather by a refresh due to properties update or
+	 * our internal timer, there is nothing to reply to.
+	 */
+	if (client->reg == NULL)
+		return;
+
+	if (status) {
 		reply = btd_error_failed(client->reg,
 					"Failed to register advertisement");
 		queue_remove(client->manager->clients, client);
-- 
2.39.2

