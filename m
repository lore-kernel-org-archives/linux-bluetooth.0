Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926B9101DE
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Jul 2025 16:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751473440; cv=none; b=UoDBo8+L0dqMrepi/Z7HGEMA+YFCpC7JizXjiXlGMiZ7SocWbIhPFmDODH7TLBRz+hfk0/4/kNkXfr0FOctZHtxLLb0h97bM3x/qIWlh5B8wyuaC+24k8aBiWV9j5QfEN4Cxm66BfxhCFM5mQFadkD+dyKqN5c+MZ47CJaC8cbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751473440; c=relaxed/simple;
	bh=n0tcHVRfxebu3iqSFYUuQC1iNV6Ezy189hK2LiwLhEE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=I25q5jkO80BTj0AGzMwwD249r03BSLT7YzkdO3BZUDILcfhoDndSrDpXfyU+mcY4yEFhcueC+372CqxjEeqrog+OgqPeZzBEEe0fwHslUcK9U6bmM4qoyRW6qX2jBzQsGZ0jARRTOShu4tSQNR6Z2OEy02zHt5vxEFbJL6AZMKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L5dB78rI; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5dB78rI"
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-4e7fb730078so1454007137.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Jul 2025 09:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751473436; x=1752078236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=kU7mIV672lIKYY137K9kRm2KjXPzelDi4EmsCNARJQc=;
        b=L5dB78rIKZQXopMUDdJzbS0xkrsVV4NyH7MYFxdUOlilfpsUHc0ivvyXp6zHDs1cce
         oh8dYNyb7MdXsPqoI/ZPmDiwh20qLg6iCkv5QVs7fjQlZxjvF0bwIZHXfyemJ7rdtpI4
         bMxLjGByYIlz6R4LNQxRZbYZ7CxVv9RHssLqB8e+ijGlaLAyIeq3q1Ob3akjF5jugQy5
         XYcwoN0J/nm4bRq4ogj+ArYqGK2HxpjHE0P3CF9tAmQgSFO6vQB0iOmLEUIzvCTAZdDe
         uVBKo444QuBZW8uWMZLIFaAoEJpUDCRqFSDk3fWiRp9z6AzMjDsPXYcaXL1Pnrzh+Cnp
         4pjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751473436; x=1752078236;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kU7mIV672lIKYY137K9kRm2KjXPzelDi4EmsCNARJQc=;
        b=OzMZgRgz7fml/z7asf8q+YFot0/EqpROYMkFE8FaaDkMnQNt88LkBxMOuPjhRleL8C
         Ug9P2N+TKi0emaLwj/Wx4q2a1Nxlhxp5e16SqF1nNlUFtp0vPdPH6YEMmiIymluvhMjG
         yTrnQEqevjuZPuEZDHVFEl8JoxvK3PhtTHYzPg6g4lLZ68uxhmewuD2zpLPsxsOKrNoq
         BKPuG3etMsN3zxZK5KsvcbItGtqgaTmby6M/3RCQWDZABl3J3ER5NeE3G49aWnax4Rb2
         LzoyGWjcZ4tY/la5hDasgW5BOSkNpWm9BkRI0+9Zr6MCgvhkyagtwk5WODlFOLWx6ZAg
         VxXw==
X-Gm-Message-State: AOJu0Yz+oIPA1k0oGsFlya0/HJW9MQll5AdB1XK/9ONCvj99+PHc80Bz
	sJBsJQ8y5+2r+UHdq3u/xxxpRXYWvwtocXp15BZEsEFV7LkmRYjMtw1fuYJKa2BVaJE=
X-Gm-Gg: ASbGncuG8ildlCTWwK+gwLZPYR7ELGiTzCKT9sJ3lcQQI0OL3FI9XiUNdcP8tqz55HG
	l0mY8QRTPbllmQMolpQplrb8vT0drZIHqCpMGJdKuVU91QK8jqYp4OvqiDwJ8WLWIPD6xIvL8BD
	TD4MQBbBtnc9nTNGL05YHmVum9PPDwV8AvOyXZoxreIpzSGOxxY6F/vMGAfLt0neqZsyd54APeX
	1dHWM5cWmmwaXIj2ZNX7olJuk+6FS/sm6uA3wRXY8v1EhSBpDHQYtlerYbymd+BSyBLDwExTKZB
	qwE9uHZ19n9b69HiWBMWhhDW+YNfIBCVkZh3HAbODMDLQ1VPbwuevkDxbPCmrk51tNFRXOveg7E
	bQfql8vaiPYZkNcDiVmzAa1fr8K/bHD4=
X-Google-Smtp-Source: AGHT+IFC8DRh3DOst1jXun/TQzqT7MBxgJU4H9MOv0OZEq83ALBFj6V3D/AzC54jNRdMpOqilRUvRQ==
X-Received: by 2002:a05:6102:160d:b0:4e6:a338:a421 with SMTP id ada2fe7eead31-4f1747d4abemr234959137.6.1751473436049;
        Wed, 02 Jul 2025 09:23:56 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-884d1c458c2sm2476733241.13.2025.07.02.09.23.54
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 09:23:55 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/2] Bluetooth: SMP: If an unallowed command is received consider it a failure
Date: Wed,  2 Jul 2025 12:23:51 -0400
Message-ID: <20250702162352.1374119-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If a command is received while a bonding is ongoing consider it a
pairing failure so the session is cleanup properly and the device is
disconnected immediately instead of continuing with other commands that
may result in the session to get stuck without ever completing such as
the case bellow:

> ACL Data RX: Handle 2048 flags 0x02 dlen 21
      SMP: Identity Information (0x08) len 16
        Identity resolving key[16]: d7e08edef97d3e62cd2331f82d8073b0
> ACL Data RX: Handle 2048 flags 0x02 dlen 21
      SMP: Signing Information (0x0a) len 16
        Signature key[16]: 1716c536f94e843a9aea8b13ffde477d
Bluetooth: hci0: unexpected SMP command 0x0a from XX:XX:XX:XX:XX:XX
> ACL Data RX: Handle 2048 flags 0x02 dlen 12
      SMP: Identity Address Information (0x09) len 7
        Address: XX:XX:XX:XX:XX:XX (Intel Corporate)

According to the Core 6.1 for commands used for key distribution "Key
Rejected" can be used:

  '3.6.1. Key distribution and generation

  A device may reject a distributed key by sending the Pairing Failed command
  with the reason set to "Key Rejected".

Fixes: b28b4943660f ("Bluetooth: Add strict checks for allowed SMP PDUs")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/smp.c | 19 ++++++++++++++++++-
 net/bluetooth/smp.h |  1 +
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 47f359f24d1f..a3a4ffee25c8 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -2977,8 +2977,25 @@ static int smp_sig_channel(struct l2cap_chan *chan, struct sk_buff *skb)
 	if (code > SMP_CMD_MAX)
 		goto drop;
 
-	if (smp && !test_and_clear_bit(code, &smp->allow_cmd))
+	if (smp && !test_and_clear_bit(code, &smp->allow_cmd)) {
+		/* If there is a context and the command is not allowed consider
+		 * it a failure so the session is cleanup properly.
+		 */
+		switch (code) {
+		case SMP_CMD_IDENT_INFO:
+		case SMP_CMD_IDENT_ADDR_INFO:
+		case SMP_CMD_SIGN_INFO:
+			/* 3.6.1. Key distribution and generation
+			 *
+			 * A device may reject a distributed key by sending the
+			 * Pairing Failed command with the reason set to
+			 * "Key Rejected".
+			 */
+			smp_failure(conn, SMP_KEY_REJECTED);
+			break;
+		}
 		goto drop;
+	}
 
 	/* If we don't have a context the only allowed commands are
 	 * pairing request and security request.
diff --git a/net/bluetooth/smp.h b/net/bluetooth/smp.h
index 87a59ec2c9f0..c5da53dfab04 100644
--- a/net/bluetooth/smp.h
+++ b/net/bluetooth/smp.h
@@ -138,6 +138,7 @@ struct smp_cmd_keypress_notify {
 #define SMP_NUMERIC_COMP_FAILED		0x0c
 #define SMP_BREDR_PAIRING_IN_PROGRESS	0x0d
 #define SMP_CROSS_TRANSP_NOT_ALLOWED	0x0e
+#define SMP_KEY_REJECTED		0x0f
 
 #define SMP_MIN_ENC_KEY_SIZE		7
 #define SMP_MAX_ENC_KEY_SIZE		16
-- 
2.49.0

