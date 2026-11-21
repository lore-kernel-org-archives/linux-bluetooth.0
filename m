Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795294751;
	b=XyNKeatoTTYn0Dt7C3UvCwdHktNAura5owAkGl1ELoVOFcvqKbuLx0XED096UBHMbvin
	 K+/lFL2NRgcJ0PckX3CH9nT5x6Dqlew1QhJPZ6/YxuJfjzqQdAASxhhc91k5FZl+I02X4
	 0v3qo7iRbQR3SVh5CWYAoeQnnHJFwzZ0FNRr8ULcUBnXPWR4pXxohwdpgEDwgmAAovBoL
	 ncrrbDAIe5I6H7ZyboBceZ31+Jg6G3EDIMgiqg7OyaHazp9b5GJXblaFuPp11x4EVoJa1
	 FXBv0I9u7Wc98ifVptD/yn3tJ/Z76gQJAMC4EsysDrDPikWBPlCcuy23hVqmQx6NnSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795294751;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=SqbnZuesJoZvgPsDstFskea3jd3NyZs3pImmovl2N0Y=;
	b=kKUEU0rfk2xhXK76OfvNB+9gH9Ia66YSwSvpAQc8zWlFphj2VRdZ6P3kIuKzoYHjAUkd
	 yjp451YSLrGIRfj6NtXbrxdB/3YI1vEg+A5XUS3X5se/McIVtR/cHOlfFxsEWrlK6ROVJ
	 3oQw5VaHT75mtSeDMfusu2F+/YwMop9remV1VdmV7JUf0TEp7wmxjxb4aj2f91p6JrBqk
	 whzqtWfOyLSbiy13KmOe+Sn9XsCHDBhci910J8tTEYTwml+Lh2gquQ6lHzSVSmuN3mUT/
	 MMclUwfFk0O9J7HFqqfIimibzOFzO6HYh6EKGTzM8BJu2e2LfHbSRIG6/Gom2tSBU7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bOC47HVO;
	arc=none smtp.remote-ip=209.85.215.173
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E442606A320
	for <linux-bluetooth@vger.kernel.org>; Sat, 21 Nov 2026 20:59:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E442606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bOC47HVO
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cc147d86bebso1105517a12.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 21 Nov 2026 12:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795294750; x=1795899550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SqbnZuesJoZvgPsDstFskea3jd3NyZs3pImmovl2N0Y=;
        b=bOC47HVOxUpalacC4N92v1KMnC4wRPTI32jqljjisohrHTXQbEJlbWcRsTB4h6a6vn
         cSh3rvSAg9IZgEA3rKb33R1X/+rs8jjQ7gfqr39/JbjQRA/kNwkAHadZavypgPfTOVzE
         +ml6kBfPOY3dtbnrzWHzGOmrz6wx61wi72FiGbWE0QDX80QYQcYp84EmI6yGkgV63vch
         097yc8vDCkfJqdH2zdlSH4/9E8g9oBl/s3XyXPAPfKEYjXN8v93AQXWqELkqT9Z8G08A
         tFD0d93SY+jFz1ETGTyFdoLKuTtxsHPr66DtAY1X/lGPYQid35qjLRWF/IRZ3i9P4+XE
         56Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795294750; x=1795899550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SqbnZuesJoZvgPsDstFskea3jd3NyZs3pImmovl2N0Y=;
        b=UCCuhJ7wbrTYFcuCG73LpFE1WE3powt2QQB1ZrcxX53sWVhJ3aiCzux0eFYqu7T9Ly
         htTcKxZ8xV6OgYrrq7QGK1WjJO94JqwkQuhqSH6AW9vcwtyXRrFHUffellaB1NtbjSeb
         1nHkfcpXJ5fxkruv93ZazZhbZHQ3XlxtK6W9vC+WhkYF1yigy16LSRLZFAC4MMqEcUP7
         jgdyIQeRMca8d9qZpU40IBC3/FxF342vqAd+D1s2Vo1xto7ZZ1HJwv8Gx4RgnejUrObw
         McFcxIBhqJmBT0icAwGNX5SyJux+R7pZIdsqhfuBEZy6+PVp4iWeeKI0PFqGJIw9tWYu
         dcAA==
X-Gm-Message-State: APuU4Z/+gAoxUJWamohhdCJf4TNw4Pf33x5lzByqT8AolPphGSboYeWB
	MPX2D1A60xewZqKbyMWumXi+2oJlPa7NgOpMPK975H51oVi2WoBtzU5oJMqpWFDk
X-Gm-Gg: AZFdTZcx4Oy2e0tgJRZHU2BCSpkNekU4HX40LVx32dBgE6obWyJTuoNcO/BwzVxi2kn
	4xYTsZjM0hzBibDYnQE9XoShDjFUxfEhpzVMnXs5wQBxEcck9v9P1uk4oFudOno+PO+NjaYz8KR
	hjnJrMjsBPwP69xrya4hqaH/GzxiGf5Cqzzv1j8qOl7+XIDimfUJWLPqSQGd0T7BLjhH+ny1pid
	C15C4V8EDkTfIX0sD3+IYv4QA7qsLSif0ml9FRJe6lua5DFyKfk02tPDtI6TS/6+hMcwxsB5A5q
	Qn7q4vkxj1ZIbIYL3ZXdtd98bwHbUpX+8Wxhr6JXrFPuSsdqcygGLXJc1ZSgEjywY74o6zWDhtE
	hJ+2atNFVThttwONjRGFhOx+XVB+GclYFWiH8OwtGxaWaGI7I7cJwg9Iz2N+rEcDtb5J8z1l665
	rsqW5jl3dxbApaAN7lIwS1iEEWo/MwGzyt+N2MpIL/CzQEfNHrTXGExRPnxTH8++DpB8FHCgRu5
	0hM2Wg6yL2v6PXx8QZZ8SapV4C2p8+ZUA+4VLXycepqNwdW6rcxVkV4qWB7iQS5T7aG3Ev4fmi7
	l2jBQoCMVcE9nJndVMSwgv+cHf4BzKgIcNtpR2A6v5sbVkG9A0E=
X-Received: by 2002:a17:90b:3b8f:b0:3ac:b3c7:de04 with SMTP id 98e67ed59e1d1-3b41c95f0e1mr4922952a91.34.1795294750284;
        Sat, 21 Nov 2026 12:59:10 -0800 (PST)
Received: from fedora.tail791dd8.ts.net ([2601:1c0:4300:57a:5830:187:53e3:add2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b792474sm2751587a91.3.2026.11.21.12.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 12:59:09 -0800 (PST)
From: Dylan MacKenzie <ecstaticmorse@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dylan MacKenzie <ecstaticmorse@gmail.com>
Subject: [PATCH BlueZ 2/2] input/device: Only auto-reconnect on link loss
Date: Sat, 21 Nov 2026 12:58:35 -0800
Message-ID: <20261121205835.381239-3-ecstaticmorse@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261121205835.381239-1-ecstaticmorse@gmail.com>
References: <20261121205835.381239-1-ecstaticmorse@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 5cbdfbd83d66 ("input: Automatically attempt a reconnect when
required.") added a timer that pages a HID device every 30 seconds
for up to 3 minutes after its connection is closed, in order to
restore the connection of a device that "goes out of range and comes
back". The timer is armed whenever the interrupt channel is closed
though, including when the link was terminated on purpose.

This breaks devices which can be bonded to several hosts and expose
HID next to other profiles, such as earbuds with a head tracking
sensor (ReconnectMode "any"). When they move to another host they
disconnect with Remote User Terminated Connection:

> HCI Event: Disconnect Complete (0x05) plen 4
        Status: Success (0x00)
        Handle: 51
        Reason: Remote User Terminated Connection (0x13)

and 30 seconds later bluetoothd connects HID again, which brings the
audio profiles back with it and takes the device away from the host
the user just switched to.

Check why the BR/EDR link ended and do not start the timer if it was
terminated by the remote device or by the local host. Other reasons,
including an unknown one, keep reconnecting as before.

Assisted-by: Claude:claude-fable-5-2
---
 profiles/input/device.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index 5b1be2b16..93d51be49 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -24,6 +24,7 @@
 
 #include "bluetooth/bluetooth.h"
 #include "bluetooth/hidp.h"
+#include "bluetooth/mgmt.h"
 #include "bluetooth/sdp.h"
 #include "bluetooth/sdp_lib.h"
 #include "bluetooth/uuid.h"
@@ -1422,6 +1423,8 @@ static const char *reconnect_mode_to_string(const enum reconnect_mode_t mode)
 
 static void input_device_enter_reconnect_mode(struct input_device *idev)
 {
+	uint8_t reason;
+
 	DBG("path=%s reconnect_mode=%s", idev->path,
 				reconnect_mode_to_string(idev->reconnect_mode));
 
@@ -1443,6 +1446,21 @@ static void input_device_enter_reconnect_mode(struct input_device *idev)
 					btd_device_is_connected(idev->device))
 		return;
 
+	/* The host is only expected to restore a connection that was lost,
+	 * e.g. because the device went out of range. Do not page a device
+	 * that terminated the link on purpose, or that the host itself
+	 * disconnected: devices which can be bonded to several hosts (e.g.
+	 * earbuds exposing a HID sensor) would otherwise be pulled back from
+	 * the host they just switched to.
+	 */
+	reason = btd_device_get_disconnect_reason(idev->device, BDADDR_BREDR);
+	if (reason == MGMT_DEV_DISCONN_REMOTE ||
+				reason == MGMT_DEV_DISCONN_LOCAL_HOST) {
+		DBG("link terminated on purpose (reason %u), not reconnecting",
+								reason);
+		return;
+	}
+
 	if (idev->reconnect_timer > 0)
 		timeout_remove(idev->reconnect_timer);
 
-- 
2.56.0

