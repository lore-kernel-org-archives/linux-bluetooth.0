Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC182F549F
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Oct 2025 20:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761164995; cv=none; b=gL9NrJGTCN//Y8TkqD5dtdm6FK5RREoeAejJ023fK/1rLyrBf9LjkdcVWVz9EPfbqu+cKXfqRjrXCJ1KhG+Dh4egdGfTiXVGqqEuIxjYpQ+9Xi0WHQLFw7lnA2IQ8x1l5scfur6Pl7E0K4mBbukdxi41UkQga6mdLMTGYaf1wYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761164995; c=relaxed/simple;
	bh=xUBA+akEKGDDqLNRRcwz/OzlcSm641fiDffPRyssAr0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=fX15eAobV2bAfwEAkVdtTB+XYTkeI+7fDfcDpvC0b7qLhUQnYMG6BdJE4ZaPsZy29eO4un0tfpkWxxr6ntQtQuveW9RUV8pED7BTqUF71ep2HpStEa7F4BNbEyBI1b2wpnsO4GwdfrPYVjn+FPjcnk/eFx1NtzZ4RM3HwguYXUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yo2p5IMb; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yo2p5IMb"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-5d40e0106b6so3361548137.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Oct 2025 13:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761164991; x=1761769791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=SrFefficYe5wFg3mGDq9Ff5iAmdVyaY8EJqcQPtyABw=;
        b=Yo2p5IMb/Kp5EhwPknoEpZhCXWCaK60tLFAcPWQAoowczFzb6/oh3vbg9sqbvvXdB7
         hHoJVzSclfweTbwJHEcZGv4feTMKo/ot0AAm0byvgWeOHxfgSdGOLrNZ9NDwLvfKWlXO
         993GMkAXmra6+HtZB75aR3l4447xo6q+JKMmFAXFIK1JWBo4Idm61mvlrXP69vVwLmaC
         FnAX6iWsn6B2uxqGMkV0dOO8HAbGDqKBZl8V/SaJRshdY0IcwCPdAjkopyo0F8OXJ9+N
         rLdK1RPChqAswIejf7J2kwUPCdBrWQl+ES4nh1C7isENu9oSAkrE48eo8CGlMzu5REXS
         LXEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761164991; x=1761769791;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SrFefficYe5wFg3mGDq9Ff5iAmdVyaY8EJqcQPtyABw=;
        b=C2Dq06q2j55xVuiWj4qLQwA8V1hnaeqrchi8PMaIVGQQR+Q8nJt8QXp0jAh5umCztA
         yRp6jjR1V9I0ak2khtkKptI96+dU2hLwltenioHv+5GDItqQTysIQmPwkaKGPU8eI2cP
         3/VR9HqW1D36sCsGeOQA3g/oYg3FlDwRbLKtmWNKPXgFoFYZaxvIKe2EKareKDHwUxW3
         s8DMrU1u9tlNHCzAe4GKBB4rdjP78SCrG3vALcH1SZIu/QXmKo+K5UByiGzYETMeSNCn
         Skkq60sE0zNuJoXGpacdGKlxQfmHqzQ1H3Fe6jbQUDJRTBsC+ayEERoooAAvacWwDAG0
         nj1w==
X-Gm-Message-State: AOJu0YxjL9xwE63kDH5VK5Fye5ihMbdONUbAaPICytU1NJBk/l9Ncl9n
	LuafHXeL9lIUz0aFCWwx54G2F7EUXRRaaYqF9jwFSL4UxP5oMW7T01a3aaWuzA==
X-Gm-Gg: ASbGncvOv0OqZZq5XQQ1m1wgKFHX8qqykyINHWSai2YUxf+OgieW1kCGMbc8EusJ59s
	GbJvce0OYUCY+AuHXREtJuFXMc4Qry3IH+q4KyEnUrqvWKJRdsD6s8Un2hvIDuz2/pQxE375Hb5
	ZQNaTMdlLJE7lsTm1m0hOwgssn6h67hStATImuaxDHJZ5KQnpHglUKHKb4O+lJfHar6bj/6ydd2
	z1DUe0+YEzVLTqA6Emgt2dEU4StFyyzhKgEaho8CpE6xgz/picHmiuoNPAl4/MNMfXXaOgpUG7D
	7nRcfTbc/PU5cjgn2KBrBhTKsJp43rdaayidrKZJ7TT8kVUSXQ2tMOeTGX4KJW6xmP79I01evH7
	J2N5Ta4cISiiL0OPfZJmbe3NWY6DIOKBF2aBgCgT6ieV/A/9R9PBBvuNUrCCox4XBASgTD20eXs
	HhmE55BgbZ3xj/bA==
X-Google-Smtp-Source: AGHT+IF+O7msup4LuhFe5KKtqknvCLX/VSH0EL2sYQVS+4+mi0SQJMx0VaZI2qSAgx6juvE10iMp2g==
X-Received: by 2002:a05:6102:3f46:b0:5d6:731:fbc0 with SMTP id ada2fe7eead31-5d7dd5ecfd8mr7333714137.36.1761164991205;
        Wed, 22 Oct 2025 13:29:51 -0700 (PDT)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5db2ca7d0ebsm65955137.10.2025.10.22.13.29.49
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 13:29:50 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: hci_conn: Fix connection cleanup with BIG with 2 or more BIS
Date: Wed, 22 Oct 2025 16:29:41 -0400
Message-ID: <20251022202941.1537413-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes bis_cleanup not considering connections in BT_OPEN state
before attempting to remove the BIG causing the following error:

btproxy[20110]: < HCI Command: LE Terminate Broadcast Isochronous Group (0x08|0x006a) plen 2
        BIG Handle: 0x01
        Reason: Connection Terminated By Local Host (0x16)
> HCI Event: Command Status (0x0f) plen 4
      LE Terminate Broadcast Isochronous Group (0x08|0x006a) ncmd 1
        Status: Unknown Advertising Identifier (0x42)

Fixes: fa224d0c094a ("Bluetooth: ISO: Reassociate a socket with an active BIS")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_conn.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index d6162a95048e..0b86aaddfb02 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -843,6 +843,13 @@ static void bis_cleanup(struct hci_conn *conn)
 		if (bis)
 			return;
 
+		bis = hci_conn_hash_lookup_big_state(hdev,
+						     conn->iso_qos.bcast.big,
+						     BT_OPEN,
+						     HCI_ROLE_MASTER);
+		if (bis)
+			return;
+
 		hci_le_terminate_big(hdev, conn);
 	} else {
 		hci_le_big_terminate(hdev, conn->iso_qos.bcast.big,
-- 
2.51.0

