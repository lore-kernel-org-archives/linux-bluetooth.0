Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793122054;
	b=JnAT+G6jEEoKQZxol4uoaNzunG22bKEL53XDjQvpm+Kg5yZMDBFfT4CFatSsJqMWCVV4
	 gTq5Koye/jx1fMTYTPNtxVzcL7VNqhDGON+vuoNt1D8yrlFx4HdENC5GXYXszKDhffvLr
	 63hfsA0kORndciC9WQ/ikUbqQAVCdqmPo4VpQt57QLuibKiZwZRaIBqTmwljLWDeKaLnK
	 CQV4rdQ7ZMTRFsCyfC6qenBunXcAzB3floXZAI2yukpeS2N1kON0aHap6zXYh6b64/J6m
	 rUTvvCUYfgtqFjgbrydh1+ymh5OyKkvBs/zTN3WZ01lYvjjPrf8erNzg4vGSijske8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793122054;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=0srGsQcriNeZSAqortz28JS4GFexyzZHlnolS5P5yFA=;
	b=hXPjnc6oohTNjO7azQ8r1pWi1pexhKFz3L4aj//7f5FuPWYzjWlTJuaBgJlEMFZWdeXn
	 Pxup1YuWIk25NSRoGt0Rut8rOz0G1hjJ934P2Kh7/c/XoBYxxMV1qaqE4F6sVb+aAA+CA
	 VZ7SLstJGKGW8mvu6Vm98nkkxnW2pELik5X5bj1AqWVV3kqu3KPuN7EowSzgQ9EH0SgNg
	 nnM6wV9SR+9Yg+adkEg+gyYxWdzh/LhE58eu+MwpMDH2D7NQHw/dOtxjIa1uJjhNIHuLZ
	 abRC+5jtpBegiY5kOrqYcottSB1A/DQlnGuLEqf9lizXZ2sMKfvhm7QP3q4Gve5AJbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simpleble.org;
	spf=pass smtp.mailfrom=californiaopensource.com;
	dkim=pass header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b="q/G2WVUB";
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743D7606A31A
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 17:27:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 743D7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simpleble.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=californiaopensource.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=q/G2WVUB
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-36a1947498bso239777eec.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 10:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simpleble.org; s=google; t=1793122053; x=1793726853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0srGsQcriNeZSAqortz28JS4GFexyzZHlnolS5P5yFA=;
        b=q/G2WVUBiccGDptMSNCe72hnkJVveHRSnKbQV5E5cFUgAGxYatXjJpm0ai6RAe7hNe
         oB2uLaCLPrKO5dHQzxQR2m7YChQWwl9Mycr6dARRtCcegTrIVYk8By3J27lwW+gC+mO/
         FNoiZnjw0npoP4sOkBkbHjGX6kH5EcYpt/g/zECjF3mUoNx1zWH3Kgjo0RjqKcnKI/iz
         WHHWlC67T+iPksZS8JDu+uFpVAdFqDgRZBW7myuLyFGhHAhBpflLYkRxlqCV8x8wzRjX
         XlsjYbUDQkBWm6j6L7ISCWczkDJbx1luw0cMq1eOMX7RHK5pkZY9k1FQ2l8jK3Eunyw0
         yvOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793122053; x=1793726853;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0srGsQcriNeZSAqortz28JS4GFexyzZHlnolS5P5yFA=;
        b=1SygOtJGqVaKqKWTn0+qB79n9fhS13SKQBiVHsYHvc8j55qWYcqHJVTTzz+K+H5nbl
         4XpmKdHOZFGymY70QK9QGIGbcQH9k0MpXAkFck2A1nGuuexoyugsfz/9PhGFH9wODTXx
         7kGaYkcv+vrHZNWeLzOiw8aT5kin5brdzi9c+rCAzMliB625AdXvIBvlFW+I2YmX9uJw
         U4Ber8OD98DZtQP8G+uUpY0DqpO+0uinCMmYSGgNffl2G3CmFSN1Uymvjf41xwQGhSpT
         psFOjai1D9XOI9rv/S8tIZRMIbXCb9dkc1jLG6S4X9BhPWB6hgW25kEI7TMoCHoq2ok+
         F8vA==
X-Gm-Message-State: AFq9FYL4Mlwkhezt863T1M0sH4hurUrFZN82s41kVKL06shsA6OxBevQ
	F+xx0Bx+Kx4aOt2bKK4S7JYtK4Hsb3YiKONhreuJuavz4Oa+n+e2CWCka2jtPmdDDs4y7RYpVg/
	/Qnms/bgQiQ==
X-Gm-Gg: AYBFou2yJRDs1Sc/DawMU+kq2BEqxR4Fg5xr4UaUzlkrNw71GLl1lehDmJGQ3TWrV+z
	kBbct04Mn3YtyWdpq8I9LcGJCHjNxOCwWFce8/pkFPv/qbHd68PJp7tn5DG6MapHEIGT7koCGSa
	CxINUrTbVCG1rH/K2wAwfyczuKbUpN/2idBIQf5xrtCF3dcbgrVoTJ9BFXLY0D5wsSqxYCWfba3
	zwpaNIm9d7o/une+0t5YHdIqn0jeXXCZxwxUl1sf/1PV4PRA4SLsXhE19ejmj+0/9Fm3OgluLao
	tNAkFMAeNGcLAtdBnechOs/MqQRfzIIEhnv/4AIsAIy8Ey2UIkSeodkgh5T1VvEaDwMrNhLA918
	JU53jYQ8GtcitJV9rQxdrU3UUtFmUN63ezP4hJj47lVmmUM0VDitBAZGnemUalysrKrfsGcBnNH
	5rU/zng8MSwHiidsg4p8y62Nwuk3lqy8hUuTCGIeluCtpz4h5hgH6iAtcUYMeEa9cD8lRfxe4T/
	DY2DKamWAlmfeRKn6ACVuC11JHZrBK10ldca15XBT3bvafHrEzQDzdGX90Tg3enJEB3kKDe+Uz4
	DWFJg/N3Ce55WwQE1ONDeu1z0qL61vnXooO9yt3z7HDKft6hXKEguyeFKE7Qe5xes8bPUQdQGPQ
	99VFu1HZQ7mhCtFatADbDysgqaXBS7+mmxOIOlHctElM=
X-Received: by 2002:a05:7300:d0a1:b0:36a:16f:c550 with SMTP id 5a478bee46e88-36a203cc3ccmr109085eec.15.1793122053338;
        Tue, 27 Oct 2026 10:27:33 -0700 (PDT)
Received: from localhost.localdomain ([147.185.47.151])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a002a486csm20385023eec.22.2026.10.27.10.27.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Oct 2026 10:27:32 -0700 (PDT)
From: Kevin Dewald <kevin@simpleble.org>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-kernel@vger.kernel.org,
	Kevin Dewald <kevin@simpleble.org>
Subject: [PATCH v2] Bluetooth: MGMT: Fix discovery stuck after a failed Stop Discovery
Date: Tue, 27 Oct 2026 10:27:30 -0700
Message-ID: <20261027172730.86568-1-kevin@simpleble.org>
X-Mailer: git-send-email 2.54.0
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

Stop Discovery moves the discovery to DISCOVERY_STOPPING, and
stop_discovery_complete() only moves it on to DISCOVERY_STOPPED when
stopping succeeded. When it fails, for example because LE Set Scan
Enable times out, nothing else moves the discovery out of
DISCOVERY_STOPPING, as the LE scan timeout was cancelled before the
scan was disabled. Until the controller is powered off, every Start
Discovery then fails with Busy, and hci_update_passive_scan_sync()
skips background scanning, so devices set to auto-connect are not
connected anymore.

Move the discovery to DISCOVERY_STOPPED also when stopping it failed,
as start_discovery_complete() does when starting fails. This sends
Discovering (disabled), and the passive scan update disables the scan
again if it is still enabled.

Fixes: 0e05bba6f6f8 ("Bluetooth: Update stop_discovery to use HCI request")
Assisted-by: Claude:claude-opus-5.5
Signed-off-by: Kevin Dewald <kevin@simpleble.org>
---
Changes in v2:
- Add the missing Signed-off-by. v1 went out three times without it,
  sorry for the noise.
- v1: https://lore.kernel.org/linux-bluetooth/20261027171913.82628-1-kevin@simpleble.org/

Reproduced in test-runner with a new mgmt-tester case, "Stop Discovery -
Scan Disable Failed 1", in which the emulator answers LE Set Scan Enable
(disable) with Unspecified Error: without this patch no Discovering
(disabled) event is sent, the scan is left enabled and Start Discovery
fails with Busy one second later (3 of 3 runs); with it the scan is
disabled again and Start Discovery succeeds (3 of 3). Freezing the
emulated controller while bluetoothd stops discovering gives the same
result through the HCI command timeout. The other kernel testers pass as
before. Only tested with the emulator, not with real controllers. I can
send the mgmt-tester case to BlueZ if you want it.

hci_pause_discovery_sync() has the same pattern on suspend, which I have
not reproduced.

 net/bluetooth/mgmt.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 3cb4f9ece8..06595175d9 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -6322,8 +6322,11 @@ static void stop_discovery_complete(struct hci_dev *hdev, void *data, int err)
 			  cmd->param, 1);
 	mgmt_pending_free(cmd);
 
-	if (!err)
-		hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
+	/* Leave DISCOVERY_STOPPING also when stopping failed, since nothing
+	 * else moves the discovery out of it: Start Discovery would keep
+	 * failing with Busy and passive scanning would not be resumed.
+	 */
+	hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
 }
 
 static int stop_discovery_sync(struct hci_dev *hdev, void *data)

base-commit: 47d4d9f67e92d56ef3965f2727f9c98a5a611368
-- 
2.53.0

