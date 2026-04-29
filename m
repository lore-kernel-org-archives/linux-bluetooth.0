Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7D23FD134
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Apr 2026 13:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777470065; cv=none; b=qPgvim2/Nwh0A0wtDjN0tP/BjFdC+hQvN/CiSpAE1KryzL0JR+B0qC2TFQ+GgQ/YwCbZWHalNrhrwKf2TC+5vnMo3g8UR0vDlMaaYMLjIkWoJiN8YuNmgFGZpsdazLGQw5MK4AeLnkDZ0aQUQyu2/vgqs0XGqf9q7TozB87j8UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777470065; c=relaxed/simple;
	bh=VvWnO5p7rH9s4xOJKUSBq25CDGaY3gGzJmvgx71arec=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=PTKWQuddy8oKMuBzNG6QQQyfmYEM244fSZs9hpwwKoF4C2phHzmhW5uikzf/+zwx5ruqs6P6sfvwVD+TGxUoQFFefO3dQYsf+cwslRhxIe/s6cOchkoJdXIJA0JgXOkyM/q6hOmnxWDAZVxpyn+wrXgsSKRNIU634p7GphaUccA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ku0yW6Kt; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ku0yW6Kt"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4891b4934ffso117235e9.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Apr 2026 06:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777470056; x=1778074856; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VcF+qL2+XHdM3kJjnpyvX7fweQN4QlGSj763XZNBxs8=;
        b=Ku0yW6Kt0SFPd65H0i/by4t1wogt9u637UFJZJVZDPUt+OZCPzzHq7k8z0osF1NURO
         3n63KsL0dfUbx4ebrdBvld07VUo0aIxW5yrz/SW+oM8yyg7nYLt5m4XtYlvus3zNAbh0
         weXI2300ZUzm/yNbCrCPbf1V6QNfNR4piEvcmVrRGzlPQywa38ldCLoP0ntv8w+ntUyE
         /gmwlkNB8zGsv+kg4Dj1q6zSN+zZi0yyX1a46oxGvCco++uMXIrNe2oEwyD7izDeOSR7
         1WjruAmNP5ASHAlm6Ow7oJkzRmJW9gDDLopnSoN+OHYW75REP2O49WWNRrfjoNEzhAH9
         bmjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777470056; x=1778074856;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VcF+qL2+XHdM3kJjnpyvX7fweQN4QlGSj763XZNBxs8=;
        b=EFb9qXiWX78MnhkNa/o4/WLAC/I0DVT4j4cW9tR05Qt6Qr7E1L7n+KAgNOS4x/U7/A
         p/EStR+rW942gKvNUk0u7lmp2MaZEao7bz4d+tvRaZlyxAx696ls9Mb4OInDJ/CVcKMV
         XRnzMt3W+2HxYgub3PCGsMsYWFKrWp4nJQYTpgaErZQS1cGDPHp7R0vkrEow2UlJKNrZ
         0s6mFpAkujl46ovhr6RdAG2URslr71fTfZ1ey8HUKsH7OUlh0DAlU90eU0UpgOLppxBG
         wS+5n9ggzRAkcOah8Un0DTkMrWYZeywakm+J/qoFcidmcAO6MtId/IkzhZLUBNbnBDrT
         Vuow==
X-Forwarded-Encrypted: i=1; AFNElJ+QKkV4W6BqUH/ul2N6SEjuYBW+Hh6IVtyETOJOUUy08lAu/KyNnBcK73yN8+750/rOVXbgTIGSXJ7/VQ00Hb4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1mHxYQmCxHqWIHf2xyNFMEoxi1FGRO2Cf9FI4F51NJ+qy2kLS
	5qG85dbIC2+PWmb+BVPHpZ/yOpdWYrx6yC/2BDYR5lRskb290pcdpfJJS4D0hft8Rw==
X-Gm-Gg: AeBDiet6EjvVpmDOWeG3Wq3g1sQQhaNp/I9sIvOjwCD3FbI3UozP9cmgLMgtt9NU2Pb
	ovqcvlGERhQAUmgs8nIwsfQ/BJ1UyvOqxEuN4u8TDdw0aC5PahKGbXYy41Im6/Q2wCPcsNTEc5S
	jQuFVg/eXEFx0qkCk02N/gM03qKV9gi47xWKInTLCpb9DV8AfQ9BgviCRuQNPF7KQjT1mtTrqZz
	JMBJLHG6B2shaskqKDIVMTCNZOD+OozRyWi9Cyuxjt6W2Q5sEyoy2WWScW1nA4ts+0IaSPI8tok
	WqXvs9tHNcyi/GsoU6hfsFKr+/AdbEejDxcGLDVgQPVcu6CoeaioJ8Iz9Bf+mXOCvv42b9A6ffH
	trSqWPjDGXQFZPTThh7wfMDotRjrxu3gqEZktf8DkQxpbqaU4+RSfk5qHn6cGw/TIfCcPYngBg/
	dXMGYZWq2gwp7I46U8qyqN38CMXyh6hGsicwTw0IHxtcinqQzUTl5q4HWSqFFPz5l1yvrgjz/K
X-Received: by 2002:a05:600d:486:20b0:48a:5aa3:ac1e with SMTP id 5b1f17b1804b1-48a7c85d6c9mr895825e9.3.1777470055419;
        Wed, 29 Apr 2026 06:40:55 -0700 (PDT)
Received: from localhost ([2a00:79e0:288a:8:4582:e630:2e06:ee0f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a7bc7a359sm90738615e9.10.2026.04.29.06.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 06:40:54 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Wed, 29 Apr 2026 15:40:46 +0200
Subject: [PATCH] Bluetooth: hci_event: fix memset typo
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-bluetooth-memset-fix-v1-1-73507b81a903@google.com>
X-B4-Tracking: v=1; b=H4sIAF0K8mkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDEyNL3aSc0tSS/PySDN3c1Nzi1BLdtMwKXQPDFHOD5FSDxOQ0cyWg1oK
 iVKAw2Njo2NpaAIxQvUFmAAAA
X-Change-ID: 20260429-bluetooth-memset-fix-01d70ce0acf7
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Iulia Tanasescu <iulia.tanasescu@nxp.com>, 
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jann Horn <jannh@google.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777470050; l=1634;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=VvWnO5p7rH9s4xOJKUSBq25CDGaY3gGzJmvgx71arec=;
 b=kpg9xvBqQqKhZrwIP20Wkr+gWJOJQG22s84+xfDG/LFYd2DoS8KLlesBYgrV82dN69EQek5Bi
 g7cWU8f7daWDbfy22UarmMN3dlAdszshS0rSkcbyhFmWsDrTdj1Akbf
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

hci_le_big_sync_established_evt() currently does:

    conn->num_bis = 0;
    memset(conn->bis, 0, sizeof(conn->num_bis));

sizeof(conn->num_bis) is wrong - it would make sense to either use
conn->num_bis (before setting that to 0) or sizeof(conn->bis).
Fix it by using sizeof(conn->bis), the least intrusive change.

Luckily, nothing actually depends on this memset() working properly:
Nothing seems to ever read from conn->bis beyond conn->num_bis, and when
conn->num_bis is increased, the corresponding elements of conn->bis are
initialized. So I think this line could also just be removed.

This is a purely theoretical fix and should have no impact on actual
behavior.

Fixes: 42ecf1947135 ("Bluetooth: ISO: Do not emit LE BIG Create Sync if previous is pending")
Signed-off-by: Jann Horn <jannh@google.com>
---
compile-tested only
---
 net/bluetooth/hci_event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index b2ee6b6a0f56..ad3945e4fe2a 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -7168,7 +7168,7 @@ static void hci_le_big_sync_established_evt(struct hci_dev *hdev, void *data,
 	clear_bit(HCI_CONN_CREATE_BIG_SYNC, &conn->flags);
 
 	conn->num_bis = 0;
-	memset(conn->bis, 0, sizeof(conn->num_bis));
+	memset(conn->bis, 0, sizeof(conn->bis));
 
 	for (i = 0; i < ev->num_bis; i++) {
 		u16 handle = le16_to_cpu(ev->bis[i]);

---
base-commit: dca922e019dd758b4c1b4bec8f1d509efddeaab4
change-id: 20260429-bluetooth-memset-fix-01d70ce0acf7

--  
Jann Horn <jannh@google.com>

