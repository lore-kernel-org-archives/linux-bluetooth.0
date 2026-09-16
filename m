Received: from mail-oo2-f43.google.com (mail-oo2-f43.google.com [74.125.231.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8694937F8CC
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2026 13:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789566403; cv=none; b=mtvATvoo1sYyNQHs04srwmKV7Y+PNR7QWm70GnoCdFxAufq8l375idLUXz5ws1wfCvnpr/UFaZ7XioI/bxZDvpA4C81o0LcNeaTuA2r/zCpp2SWcnDb+EQmCXMlBc0SSQ6sluxCQfhRJeojfYTqNt1EjJ/z+8IydmqsjA5PEL5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789566403; c=relaxed/simple;
	bh=8xMv7Of/R1lKSdCGf3UyOmrHLguwJehlKPUu6fYANsk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TibFlHzydVpqtfbFJHDx/Ltera83IhAp021D9G9eeO+NdFmbB9PQE9kdH39X2goM28/EfgZEXu3Eo3/S+jgS79PyYMsdRvI+29RoixYpHlbO+eP4iHDrRg/AOj2kqwu2LSXupiNBsxgwpdiR1LHyteczdNzgq01L+mGAlbEvySA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ThjaT/FN; arc=none smtp.client-ip=74.125.231.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ThjaT/FN"
Received: by mail-oo2-f43.google.com with SMTP id 46e09a7af769-7f4f0cfb33cso634206a34.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2026 06:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789566394; x=1790171194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mOGlzHMI1lJ9vaBIDrUEVsQc6zuf0ursOymMrMeZIbw=;
        b=ThjaT/FNm/rZx6++IfJZNge8u6e/0vTadyC8A3/U4AktRjujf82fNPnSZCvlqR8BCQ
         6527GWw//dw3S9KQj3WOur8EtNmPoeiWysAIN3G+DkHgwhxtrKPUNYfvqick73+1hOVY
         IIGa+8n7jZpLoWtW91ZfJjVsbdubPam6UavvcOnCdZ3tMob/X06KHS2lkGtJniRXvHrW
         XQhfdM7c+c9/DqZ4+KYOOlRDBmoNBB/Bt8qQF/tcxgv5KaKNIlvwip6PCnVerBP0n65k
         JsytRRE6rg/t2LG3eppr21WdJr9/TLaNVHSQIAn4D8tDLeZ0EJ8N8wVv2f0VmG2KNxqo
         RjcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789566394; x=1790171194;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mOGlzHMI1lJ9vaBIDrUEVsQc6zuf0ursOymMrMeZIbw=;
        b=fktY0EHs2goGrLrMAdRSAdahKvjgf/byHHpW3Somt2yfkfDRGQBP/GOA91vi7SSYQK
         Q7lt/fwNw1cpX4Is4WxfxkaCcFtdcfEli9t3TPZCc/27ckUWl7tn/M6owxv2ttse7HsC
         f8NLbgJk6N8jCwv0NkKFJwxUOaGV9Vxf5GHEpsC2LgMFhCPHiaEjr9rcVVSt98RHG+3O
         iiYvYTj5j1POmwG5vxf9kYVX2HPhF+nLjGtmCdX9YqO/RR3+JoulgIZ5ZF6CEACvpjDi
         ILEN0QEatXYsuWu81KlMnjj7b9aidrX+vKZBV3vywSxDyJB4U0K60m/7LX8pW17AU92D
         5GhA==
X-Gm-Message-State: AFuF++mRgeApgfCH56Rm6JHEDNxUbf7JFEORcs/1KF1gmOq4s245kDyV
	8fmNbyDqO3xpILpDMZui7xQl2WQuKnwJGmw8sUlFtsOIPdzK7EhOd/FKoNqhnKjI
X-Gm-Gg: AYBFou2tfkmwj6lMYQ/wL/erQDOODYtNOAUYS2qJ4ITD3jWdsMD8iDZh0AesgbFsmmi
	ZvZdNAr0M0A352dsMJx0bzIarcWf63qe/dnMyul6Z1HFM8PaIwyxTBxPhw544QRPUpzjf4yNrhC
	FrAn2HEzixmmJccQm+g3nfqMGNePR+YsvSthAU9ozrtgkYid/fc8V3paCKLRR+WPwN2MhWPNNBn
	45CmHu9xfYsJhvs1TrLLVM/XD/RtfrWW6vsHorDTk2sYAJRXM8NHDCVgFtePZeqWatd1gVvLdPS
	XVMGfwg8gL2O8w4XtIrSt5lwFUs4W26PGMeN4YwAQhbaRKzGRV9z8oesvdwiMLlnrU3kCB0ayx2
	vG/YSryzAVcNXdv3Usj/3U0PUInFBzTK/3r/lu0XrvwVMglNKRbTb18Hwqe3l7ByfH8m27w9ho4
	+K27aBSLNyFYog7dYzv49P9Xs2C/HynXA395wOMhEMEE0km1zIgZHR0Df6wcDod7f/XqgtF1XQU
	8E47gXxnUJzq0hKbYL4mreTMW4EjBg4hLiGnc2y5UrOmt4Lz2uOsA2h2GwnBerBEw==
X-Received: by 2002:a05:6820:3109:b0:6be:4eb3:e1c6 with SMTP id 006d021491bc7-6c7d35fb6d4mr4588729eaf.19.1789566393598;
        Wed, 16 Sep 2026 06:46:33 -0700 (PDT)
Received: from archlinux ([187.125.137.12])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6c7a677c460sm2834526eaf.8.2026.09.16.06.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 06:46:33 -0700 (PDT)
From: Christiano Amora <christiano.amora@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	Christiano Amora <christiano.amora@gmail.com>
Subject: [PATCH] Bluetooth: SMP: reject Security Request over BR/EDR
Date: Wed, 16 Sep 2026 10:46:22 -0300
Message-ID: <20260916134622.519192-1-christiano.amora@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bose QC Ultra Headphones (dual-mode, same public address on both
transports) occasionally send an SMP Security Request on the BR/EDR
SMP fixed channel right after the ACL link is encrypted. The kernel
handles it as if it were an LE link: smp_cmd_security_req() has no
transport check, smp_ltk_encrypt() looks up an LTK with the ACL
connection's dst_type, and hci_find_ltk() matches the peer's LE LTK
because the LE public address type is stored as ADDR_LE_DEV_PUBLIC (0),
the same value as BDADDR_BREDR. HCI_OP_LE_START_ENC is then issued on
the ACL handle, the controller rejects it with Invalid HCI Command
Parameters, and hci_cs_le_start_enc() disconnects the link with
HCI_ERROR_AUTH_FAILURE. The headphones drop within a second of
connecting, before any profile is up; a manual reconnect works.

btmon (MediaTek MT7922, kernel 7.0.12):

  > HCI Event: Encryption Change (0x08) plen 4
        Status: Success (0x00)
        Handle: 50 Address: BC:87:FA:47:73:5E (Bose Corporation)
        Encryption: Enabled with AES-CCM (0x02)
  > ACL Data RX: Handle 50 flags 0x02 dlen 6
        BR/EDR SMP: Security Request (0x0b) len 1
        Authentication requirement: No bonding, No MITM, SC (0x08)
  < HCI Command: LE Start Encryption (0x08|0x0019) plen 28
        Handle: 50 Address: BC:87:FA:47:73:5E (Bose Corporation)
  > HCI Event: Command Status (0x0f) plen 4
        LE Start Encryption (0x08|0x0019) ncmd 1
        Status: Invalid HCI Command Parameters (0x12)
  < HCI Command: Disconnect (0x01|0x0006) plen 3
        Handle: 50 Address: BC:87:FA:47:73:5E (Bose Corporation)
        Reason: Authentication Failure (0x05)

SMP over BR/EDR is limited to cross-transport key derivation; the
Security Request procedure (Core Specification Vol 3, Part H, Section
2.4.6, PDU in Section 3.6.7) has no BR/EDR counterpart. Reply with
Pairing Failed / Command Not Supported on a non-LE link, before the PDU
is parsed, and keep the connection. The reply is sent directly rather
than through smp_failure(): rejecting a command on the wrong transport
is not an authentication failure, and MGMT_EV_AUTH_FAILED would make
bluetoothd disconnect the device.

Tested on the affected host (kernel 7.0.12, MediaTek MT7922, Bose QC
Ultra) with the patched module built out of tree: 7 days and 49
reconnects without a drop, against 2 drops in the 3 days before the
patch. Every disconnect in that week had a userspace or remote reason.

Fixes: b5ae344d4c0f ("Bluetooth: Add full SMP BR/EDR support")
Assisted-by: LLM
Signed-off-by: Christiano Amora <christiano.amora@gmail.com>
---
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 98f1da4..7792f48 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -2301,6 +2301,23 @@ static u8 smp_cmd_security_req(struct l2cap_conn *conn, struct sk_buff *skb)
 
 	bt_dev_dbg(hdev, "conn %p", conn);
 
+	/* SMP over BR/EDR only covers cross-transport key derivation; the
+	 * Security Request procedure has no BR/EDR counterpart. Reject it
+	 * here, otherwise smp_ltk_encrypt() finds the peer's LE LTK
+	 * (ADDR_LE_DEV_PUBLIC and BDADDR_BREDR are both 0) and issues
+	 * HCI_OP_LE_START_ENC on the ACL handle, which the controller
+	 * rejects and hci_cs_le_start_enc() turns into a disconnect. Reply
+	 * without smp_failure(): this is not an authentication failure, and
+	 * MGMT_EV_AUTH_FAILED would make bluetoothd drop the device.
+	 */
+	if (hcon->type != LE_LINK) {
+		u8 reason = SMP_CMD_NOTSUPP;
+
+		smp_send_cmd(conn, SMP_CMD_PAIRING_FAIL, sizeof(reason),
+			     &reason);
+		return 0;
+	}
+
 	if (skb->len < sizeof(*rp))
 		return SMP_INVALID_PARAMS;
 
