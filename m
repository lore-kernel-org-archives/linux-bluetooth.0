Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65450288C3C
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Jul 2025 17:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751563954; cv=none; b=XP/Xmn/tfKHO8uIph1AC0YFbpfdLzIOY1vkGCXbUXYDavRwwXDEbRV/kThuU5s2t5meRKhm+sqXaT7SAAVm6fGvSPKcemSCNnpMNDy54dWfk8dH+hYr8lsjMoK8HN2AINTcAA7BIOUVWAUGMlds5K15RXEQgNBtp6dCfj9EsaTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751563954; c=relaxed/simple;
	bh=ihPsTpZQZt6FLyQUQhz0U9hrMvCwGw9uBE8XRy6zN9Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=o4xuAAvTxLFX+jJM5KZ61VOZ4rq+9SZPeFK001hrffiJHGp8slI1eNoppW9y85HRzt8kJgk8HhlhGY17T60qiJAWa64U/Kbgxi98f2ZTxDeAPjvoeCnV4e1oAaWqVpXxFMi1ghsHF5jLsRmevRaIEK5y6Oa8WB6/NQiRgqJ5wqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b8XeVHXj; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b8XeVHXj"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7d3f1bd7121so8090485a.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Jul 2025 10:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751563951; x=1752168751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=965+GYjnLufkSmMNQG9dloluaZggOa0Cchzcgqnljlw=;
        b=b8XeVHXjIRVz7p+kMtqg+1BthIQUWjKT/WTKX6RgviZRNockJUxeDEiQHAdDGAsWtx
         bTTsW6Ao9ExzcNMdqGYoT5kfN4lb17qi2a8xq4L3WeA1oAZFLtVCB/346ygji73jod0v
         YfywcQ5TsZyecz5LnIMgyhz5QzesU/fltXihJkblxy9NSzQJw241PFs66OQ3xMTku4H9
         xPQdSOsTXXkf1SNEmMeWn1vqrFcW8tPK+OPTWxxzL5FZqOuq255I8XBducvbT7e3wfUd
         E+MuJTC5fLaNRZxu8Tlo3hNYKlsJJOa2cuX5zIH3dUM0E0zat331OqUCMHJhhXzzmLal
         dMRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751563951; x=1752168751;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=965+GYjnLufkSmMNQG9dloluaZggOa0Cchzcgqnljlw=;
        b=BNv+hEVK7U1f+wzMfwvBJ+5ZAy2E7KLobNCrnIOdEXZOSfOLgkRRfoN3MjmQIlXx9y
         kmxvAXKIU3U3ytv9vDR7kX7XRGdmLal4EiwHuydAKw8N2WjGkUAtECCCnO5uoFU2QrSq
         qUhXaPMqs3QSv4ivlEC3j69uXrfb8RPKXLRNORfDdfFwyGhVJMJdL2bB1ZgFAF+NsQHG
         lZsvnQovvWhFfO9CubtaQQ5GbWEKI/X6lgoB7Mig7HSmKduLGzL001H2yZAn+NCy2VlC
         r4FELKMK4217bl7vb8Vk4byc3V+SyRkskM1c0+U5u3RbfITrnDSTet8wSpID04+hzwUG
         eNPw==
X-Gm-Message-State: AOJu0YzaJ5a028cgb9oV30nJ2WR1sS2Rql/WgzD7lpLpjJtCEqW1XsjD
	9X1BFWiyrVeOj9augR0gr8NXE807lebMLZZiaNBgGaAxM8EJxzggoqR4PmTGXUYTLzg=
X-Gm-Gg: ASbGncuFKSPlM1gk3BTO6QWsM947OXrY5AeAiwQlWXBZ3FfGm7zGYIIvJ59PVuBdz1b
	yrbeY20r6fj8oGtFoCRjbroB0p8w5yFS7v9GvN5l39/RbFGgS+xPDV2AHAyCZXt5q+vhVh++5F6
	Ur/4wmUKbHVar+aHghmaV17w6Yg1sizXIn2nA1yPtj42UhG++I/9mlgNExXcErCyeqa2rursuIU
	cufWoBTpE/Z767bo1BXM1h7lWcbQYEzoqGu3XjaGbUatE9Wtnqax6lCO8G/U2Vyl665uQGvU4Rq
	FWc0tMU4rAxnKrnZ6ai3rwEjJ58oz9ryUlKvsEWJj2btTvr7R0/aj2xHHo/xa4nyvb0VRWSNBmx
	nPyLk9/OWQyZCraCOhpwma1itWxwSiKI=
X-Google-Smtp-Source: AGHT+IGq4ZwJ5VfPIPSI0U2/jr1gVsrvDrZI8b+5/lPoib97W5jLW9odO+qdLuPiOKIDxjCK6DLwew==
X-Received: by 2002:a05:620a:4413:b0:7d4:293b:a8a9 with SMTP id af79cd13be357-7d5c4719716mr1246678885a.18.1751563951291;
        Thu, 03 Jul 2025 10:32:31 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-886e922e896sm10973241.6.2025.07.03.10.32.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 10:32:29 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] shared/shell: Fix not calling pre_run for main menu
Date: Thu,  3 Jul 2025 13:32:28 -0400
Message-ID: <20250703173228.1815400-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When calling bt_shell_run the main menu pre_run was not being called
which cause tools with just one menu to not work as intended.

Fixes: https://github.com/bluez/bluez/issues/1319
---
 src/shared/shell.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index 6b4f7a7ef503..ec9e5f7dc984 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -1449,6 +1449,9 @@ int bt_shell_run(void)
 	int status;
 	const struct queue_entry *submenu;
 
+	if (data.menu && data.menu->pre_run)
+		data.menu->pre_run(data.menu);
+
 	for (submenu = queue_get_entries(data.submenus); submenu;
 	     submenu = submenu->next) {
 		struct bt_shell_menu *menu = submenu->data;
-- 
2.49.0

