Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9414CE671
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2026 22:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792017719; cv=none; b=mw7kVenueHTHBCef0hJ5X8bczCkiOkpCSLyGNYRyDhsQarSyYeb4ib31/oLwn0kpAnsyMOVMX6tkOiIj+c/fHyJc1eyU6ifLR9zXalfXm45TKGwfHNf/yRSvG6u96AlajnZb9MEXr2PdgMWvdASN3d0topqrdnsSTI0xQHFi87w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792017719; c=relaxed/simple;
	bh=ki2ArKXM+5oyaB/oO6XYXhgQRk+2JAxST2ZQm4gkydQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RLMy5WmxFKVE2TMkhG++HvHCA9j6PT4MnNwZ79UFddCKOht59FFiD5crsjsLXs/PI8X/ddylovIyBoUUCnBP1kpaXifSWIt5vNypbVMCW7YURsKT88rpWHmh6f4kIlBPQiLmy8HXUHsMYepNQbp0asMqDa27fqy6ToWR6q7DGL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=simpleble.org; spf=pass smtp.mailfrom=californiaopensource.com; dkim=pass (2048-bit key) header.d=simpleble.org header.i=@simpleble.org header.b=pbnhsuPS; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=simpleble.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=californiaopensource.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simpleble.org header.i=@simpleble.org header.b="pbnhsuPS"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-3535bf8b3e0so2317848eec.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2026 15:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simpleble.org; s=google; t=1792017714; x=1792622514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UycZ1PF4EQx1eN6YOc20RflCJPkeKntRi3SIYHfDNwg=;
        b=pbnhsuPSVQzp3AGRFix5cW1N40kcPrTUMRX0gvrNDj4RnQJv5ndlzREogmOQapOkck
         /jGCfD5AIawC3bH68c9LnOJ03u096KrH/tQldhVXhbHNU1RM0dRMwvIlJZ93LfFbuaF5
         OnTO7F/MdOHxqDBP4QsZewcebKkuN4sieJgAlAkKKnFdwvQ+knnYQJKPnyiNhOvP0s0h
         Ar3ap7xkK21QAg5NNWfEg+1ypjNfwD0idXtEPiePGBfGSpU7wQ7qPr+CtF7xwG9k3tOJ
         xBAvecEpObFhw0QfSqAaCTA8jZZE3YcLswfD2p24AJyfrOADKLekU5VgrPirb8UirIqL
         h/2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792017714; x=1792622514;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UycZ1PF4EQx1eN6YOc20RflCJPkeKntRi3SIYHfDNwg=;
        b=JymV7abe7f87VLtHbb7BoAbT7P76s4YoyUaguS0rhx528S9r4wmUhZnUzMQvZsY1OK
         7mA7R6k1q2bBqMz56QQ7gzijITv9k+hVH4EON7IIhi6vG4oVKqFf6HRRG7RIrzfdzWzh
         XYMN60cHd5omqvdRCX7lIq7Q4fKl+1lzBa59u7fTquESGwLAC9SW8klKoyYhnwM1aGIK
         CYEq2V5OiFsKM/208JvlYnR+gUTqYAWsu01AFz7LoPD/Wv6H1NHMeAVIEkLDZAN+XNqm
         0hgmBjXqrAWd5uJPaaaY5MKuLgGtVZNuVjzZCuSo8owS5GaCVOnrcWULZXj0gsZ5A+f6
         yygw==
X-Gm-Message-State: AFq9FYKAltjBoRyVqMew+4IJxqUjkk3L0OC27616Aw6hOGrWidWwnPeV
	UNMlqxMvM/pEsGk8b0SaaemAKa4vOsOWRV0jYuwB44yZyxpR24xMEcoDGE/3tAfHMa0lTwHpq8a
	2zTf5AQw=
X-Gm-Gg: AYBFou0fobLFF68LmIKEOixfg5Na9VGJ2zSIqFxE/zQpaZVHxsoXp5PkkWGf2Mg0p3f
	90OXyuZRVRTqc5+DqiFk8PB3NnzIH87km9KkwpwOds+Ls01YAnj7DYta9zZetMxmVpA6XaMjq/T
	rizisbMvR+y1W12j5abb/vwWw/bOZ+T0TABKCzolm9Cj1fr7nlpIe+C28PfN+pec35mrmqPhO2B
	OYKzUrWku2tlnnd14xSLVjscVL7o21H56n61h/6SD/8Ymaui8m/+p9uU9HBbzX+4YAXMHjnI1qH
	vkG7VsKqktmjh6tGhvA/wWRhvI6IbAFinG+RpvhhHTM/VKYwPrtmOmJPe5vblZ7PT05SnWd6f7m
	v691DAIB3rbEjlYZWLaDm2X9Tu5KfiLgozVbDdTFhxX5fOE/jz6MdthVrb1M8PrbN0oqtQWLZLz
	KwcX+Y+CGzFfuSjE+N1NSBQMmu/WgqGWLZUhVEhbJosshrZx4D5o/KsYPZDfXGgLHnhq5nNkVhf
	LskDeUrpuLCcCjbrr8KAMMRJ7CvsryVVibhMj5TlQkM8l71imN0LnscMAUEPfKH1GK+Uvi+qlCA
	tPfB4ZlCY2C/4BQYt920pRF3Cg54nHkjU09X11IV
X-Received: by 2002:a05:7300:229a:b0:359:2f0b:bee3 with SMTP id 5a478bee46e88-3592f0bbfb3mr17164410eec.32.1792017713551;
        Wed, 14 Oct 2026 15:41:53 -0700 (PDT)
Received: from localhost.localdomain ([147.185.47.151])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca329d9sm60022688eec.5.2026.10.14.15.41.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 14 Oct 2026 15:41:53 -0700 (PDT)
From: Kevin Dewald <kevin@simpleble.org>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-kernel@vger.kernel.org,
	Kevin Dewald <kevin@simpleble.org>
Subject: [PATCH] Bluetooth: hci_event: Clear explicit connect state on LE connection
Date: Wed, 14 Oct 2026 15:41:45 -0700
Message-ID: <20261014224145.10801-1-kevin@simpleble.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 6cd29ec6ae5e ("Bluetooth: hci_sync: Wait for proper events
when connecting LE"), create_le_conn_complete() only runs once the LE
Connection Complete event has been handled, and le_conn_complete_evt()
has already removed the connection parameters from pend_le_conns by
then. hci_connect_le_scan_cleanup() looks the parameters up in
pend_le_conns, so after a successful connection it no longer clears
explicit_connect, nor deletes the parameters that were only created for
the explicit connect.

The parameters of every device connected through an explicit connect,
such as an L2CAP or ATT connect or MGMT Pair Device, are thus left with
explicit_connect set. MGMT Remove Device for all devices then keeps
them as HCI_AUTO_CONN_EXPLICIT instead of freeing them, and if the
device was set to auto-connect and is disconnected, they also stay on
pend_le_conns: the kernel keeps scanning for the device and connects to
it as soon as it advertises, although no one asked for it any more.

Do the cleanup in le_conn_complete_evt() instead, where the explicit
connect request is fulfilled: clear explicit_connect, delete the
parameters if they only existed for it, and put report parameters back
on pend_le_reports. Auto-connect parameters are added back to
pend_le_conns on disconnection, as before.

Fixes: 6cd29ec6ae5e ("Bluetooth: hci_sync: Wait for proper events when connecting LE")
Assisted-by: Claude:claude-opus-5.5
Signed-off-by: Kevin Dewald <kevin@simpleble.org>
---
Reproduced in test-functional on bluetooth-next: after connecting with
Bearer.LE1.Connect and disconnecting, the debugfs device_list of the
central still has the peer with auto_connect 5 (HCI_AUTO_CONN_EXPLICIT),
also after MGMT Remove Device for all devices. With this patch, the
explicit parameters are gone once connected, and only disabled
parameters remain.

This also fixes a test-functional failure seen in CI: when
test_bass_past_transport_acquire runs right before test_bearer_le_connect
on the same hosts, the peer survives the Remove Device of the next
bluetoothd, and the kernel connects to it as soon as the next test
advertises at the same address. test_bearer_le_connect fails 5 out of 5
times in that order without this patch, and passes 5 out of 5 times with
it. The kernel testers and the rest of test-functional pass with it.

A tester case for the device_list check can be sent as well if wanted.

 net/bluetooth/hci_event.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 1f80f2cf6b..dede0b686c 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6041,6 +6041,28 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
 			hci_conn_put(params->conn);
 			params->conn = NULL;
 		}
+
+		/* An explicit connect request is complete once connected, so
+		 * clean it up here: hci_connect_le_scan_cleanup() no longer
+		 * finds the params since they have just been removed from
+		 * pend_le_conns.
+		 */
+		if (params->explicit_connect) {
+			params->explicit_connect = false;
+
+			switch (params->auto_connect) {
+			case HCI_AUTO_CONN_EXPLICIT:
+				hci_conn_params_del(hdev, &conn->dst,
+						    conn->dst_type);
+				break;
+			case HCI_AUTO_CONN_REPORT:
+				hci_pend_le_list_add(params,
+						     &hdev->pend_le_reports);
+				break;
+			default:
+				break;
+			}
+		}
 	}
 
 	/* If we are central and have subrate parameters stored, queue a

base-commit: 397464709a204da9b8dc3b01d6ea42539d951cd2
-- 
2.53.0

