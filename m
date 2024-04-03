Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC73152502
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Apr 2024 17:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712164367; cv=none; b=R48UPc5nKoN7W3o3/564+jJoutzaspFfVBjgs24XcB99r+OuhI4eAfzYX55ma62RLDx9OPiQ4/5VK2I/D1ErnaXfA8MheVN8yp+U9AQkWl/PSO7hADkwevpniCsV/ABFwiI7kz7i5F8l++BLe4JO0l48s1aeKktoCtBfLCs99sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712164367; c=relaxed/simple;
	bh=Gbz9TWeEHfUYZFlXsVxQtY676xoJBarDjHXJ8SPI2Xw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BnmN81ELaE77Y3lVy9EjhPxsoV1aad6aHt7I5rhbZ9D1p63kI4r5RDt9EJfMQ5S+enwA6u9qUVvNJFAQ6a9JbpV0xy6eT9cgppEEYntsw1eaCTurzQmIxJ+5SlJgEak9vn4gIdgnGNUtEMfGsqWvvHFUfxgDdfwY1fwH8r3Iwac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dY2l7IdY; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dY2l7IdY"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a4e34d138f9so13762466b.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Apr 2024 10:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712164364; x=1712769164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PmtNPq+RHGhRrisgdbR0oWF+D9crJ9wNeH1UNFCIHC4=;
        b=dY2l7IdYnqjHdEA2h8lAFpLtriVhpdWxkqFxnKdFtiTSd7RYb7S0Ea6lvw1mF8CTc4
         vLmTtKCQ+sLZL8XIFnDNzm8gvBDXpVSFSvUTo7EpKn0nf5Bz5JZmrjSsPyiReo4BFmJh
         K2xDh3cQpnwfDEWGSYax3g0McSLT9h1bibD+0AJ+HFDWfzfFt5y9RvFzmIB4d/Jl0KJs
         nnk1nb7IMniZxcdcCDE5dSbjN+z05nhhS4mW6BovEvSsl5vzRWCP7A9HBc9bVTPPAC/l
         +d4meVmh/gy7+/yV388Z71kvv/G14My5MvaDlgXLDlZhQr/GKdn7WyMUpGoiXxWQmbHh
         bSUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712164364; x=1712769164;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PmtNPq+RHGhRrisgdbR0oWF+D9crJ9wNeH1UNFCIHC4=;
        b=qULEhrJVIEA8XuAVxOrmyVeTPKspRqu5I+1tN0lSNi0Kz6HA7D5C5pHM2UzbvZCBYK
         STALQpDd0S5vVvI65ELF/c+WW49Ubns4edeSity2i/vM4pDQSU19tGk6QJ6lILEBw/Me
         LRRh4c9ZKuMxmuoYqs/aNjD97qSgLoRtoek2tjTNUIggTArfzUYfvLQBLY9E1sNdIp9p
         tqIE05eyIrIDVKRnFkXxcretsY94bK8QmuNhPWVCN34vAgIbifU7vZhSs9fkv7HJzr0k
         XV+P/8Pguq4EfL+jHhsrYKtouU3Nr6aAaJWwC3zEsbCMDNa+cD7OnJXAGu1jaD3YzlK8
         +3uA==
X-Gm-Message-State: AOJu0YzYLugugBMSkS2TYeqDlohXDgayDZY5uHuT9q/OW2COVO5yZOAE
	WEYKbaIW5MJbC85zxUKm3pJULJw41ULqI0Vkg0rR6SbUTSd/G+zfGePeoeUP
X-Google-Smtp-Source: AGHT+IGD6sPyEQn39mUcpz7ArRs9tZm6xpr/UKQnWLv2bh+LwDRlKJvOy1UQQPvRDNXUVy5U6htSbA==
X-Received: by 2002:a17:906:1455:b0:a4e:5540:7c0c with SMTP id q21-20020a170906145500b00a4e55407c0cmr2153069ejc.70.1712164363620;
        Wed, 03 Apr 2024 10:12:43 -0700 (PDT)
Received: from raspberrypi.home (46.205.194.2.nat.ftth.dynamic.t-mobile.pl. [46.205.194.2])
        by smtp.gmail.com with ESMTPSA id pk26-20020a170906d7ba00b00a46aafc6948sm7910622ejb.74.2024.04.03.10.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 10:12:43 -0700 (PDT)
From: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Subject: [PATCH BlueZ] advertising: Do not crash in case of adv update failure
Date: Wed,  3 Apr 2024 19:12:36 +0200
Message-Id: <20240403171236.853491-1-arkadiusz.bokowy@gmail.com>
X-Mailer: git-send-email 2.39.2
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

bluetoothd: ../src/advertising.c:add_client_complete() Failed to add advertisement: Busy (0x0a)
dbus: arguments to dbus_message_get_no_reply() were incorrect, assertion "message != NULL" failed in file ../../../dbus/dbus-message.c line 3235.
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

