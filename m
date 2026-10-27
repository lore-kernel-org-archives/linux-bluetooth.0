Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793119896;
	b=Paqy197BEIwhstei3Q+zTdobxVyIHgdGnMlMSzcgfoLWnDIuuI6oVFFa2Mp3lM+uCLtz
	 8/2YDrGtE+0qIAgK9G6eaySHMUOM8n4HZnJ00fSiOSonqt+MYorfnO2kYvN3DNcxokK2x
	 pshIIzGpWgad/vH0kE7vjiFcAtcc/KJznWiu++jhKo67olmKWUpdIS71pNm8wpn5UkFNq
	 nPjuwx98KYFSs4zHmi+tpNbm0N+IqFiU3ECzWLXag0Yl0wzf38G0XbLZYWbefFPxKPKIS
	 HEbpmiKNIkv1G6wk6bIyJrFdIhR8Bx5s+//KYjlb/vpQ88x3V9Zy51lhBcsAxD04SfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793119896;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=aAVYI7hzWz0Ro36eEs5zq4Y7AqRKeB23+7GHTzj26rY=;
	b=Of8AUKF7DlTUwPMtZBZid6dlHtwcwYrlggaJeHyZXzm7riKAwmUz2LNE5HfJWtjsejmK
	 X2vq+slZWoC8YBBzxlc9wh5L3C8Ht0cPEqmCVyJ4BEDrtDfW3P02eHL4CSbXVw5P2jdXm
	 2Gtwxpf75vAPDefHrDGe54mTbJd0hAd/iP6oFySqA8W95my9T7PUJwg6Mr/ViQCz+W+DE
	 zBYbca3PoLAsVBChmIEJwVGacHG6j3zRX2s0d2iv0xrvxBjitoLzabltBZBXspBBYmRAi
	 GUXm+fy7kr97Li4jP2cb5vHMPyH6CJPy0B4hFotfloshb3BogzzjqLjNBqHW6gf1U0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simpleble.org;
	spf=pass smtp.mailfrom=californiaopensource.com;
	dkim=pass header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=ln0SPSKU;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9044D606A31A
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 16:51:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9044D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simpleble.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=californiaopensource.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=ln0SPSKU
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-36661f953e4so98651eec.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 09:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simpleble.org; s=google; t=1793119895; x=1793724695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aAVYI7hzWz0Ro36eEs5zq4Y7AqRKeB23+7GHTzj26rY=;
        b=ln0SPSKUgrarXzwNmH9xP9RtnX3Xmam1Y+XCMj1HIYO6IxoKRHEXJQZU5FWaP0SGSF
         1Ouh/C6WipUr8cOUnmIXKFJzGMwZ7FIvfoGWQHEw/dPYqyVIJrGhnb+oTDlEGQH6xrno
         HMAkD1UKct1cVcvH2UHVC9IVWRJ04zUN1DlEB3lAQdQAP5WD7UpNDpPd+IWH6sgIRbhv
         GdviVtB4uvjxAlV04LinAZDtZFk+yVj1SnDeWegziMSA5ELrvxAuxKt2S8yUUCUXfosm
         pEzxJv5QvvmyEjTSbiuLn3bVR30oIvja+KMrkZogNcWY476xvq29eAKh2+tyAeOISAfK
         aKWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793119895; x=1793724695;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aAVYI7hzWz0Ro36eEs5zq4Y7AqRKeB23+7GHTzj26rY=;
        b=X7tJhJ0/LE5jqd+/FJ4+bihqpjE5XcGe5whb7I3MNufp2BPpfEATe1ohP/ZHRAIP0f
         v4A6ux9zKgOySp5UF3P9yJ3X//JIMDnSR+MiJZhZRwWO6wxLLnUpVpJey5SlgYM3hgar
         rTKfNOHSzP8zhLXBZQCEUqsqA98PeTVbVzVV26F6hDlCjlUJ3NqLIP7ve6XtXXnyWjuD
         PTFw3CR5j6zM+of68rzamP7YlfAgkgUGKvk/TLnzvHu/AFqzssB3lKT7YXGwgE3SiNZB
         QLW/dFCnYmfRE/G0EoisZiOEUCYOx3E4FHeggdeISerPrESXoWo2iRp/DLxxiHObekzM
         n7Zw==
X-Gm-Message-State: AFq9FYI3G+VeEnMkuDxV45RlpdJcq0b/ETh3fcY7VV+bw6hWNmoSc3WO
	s/fjnRtmfIIci+Jr/2SDJpGaWdnIvQpysX1yB+fFnH8A2SOEQHHp+R+Cr4RIm0k9WVHrZL9mU1i
	nBI5k5GG2rg==
X-Gm-Gg: AYBFou04+1Lr8wq0s9LZy//vslCjAsS0hp5pESnXj9Ww0gyZYfzGlKknETUx20LHmLw
	+z2mf5UMmRhn4Cl/eyudBh+Tz/SaWTriGFzZyAqPECPXGQwxtL4qnRAtO5eh9j1/LvMsJlB3X9P
	PpKmBEyEDl2e0QIPqO23QBhPhcpdEv1yNE3CUQOCugyPzo3afeB2I7nUgvTgVl/dLgiIju+Zl/N
	ADFTvloN28QdD7smG9W5FY7xnXZ4ai7Ctw3AB7VukWZ0tnBv70KnRr+blfWxL/U7ckiNPP+Qgm+
	FP/l568t2heqmY/E2HSpHoW75kmUotwnovd7AwRybyyB5YDkhDtq3JierQVFbB/LTY+dWBCOa+f
	iMpM+VUD8gIJfvXWs7oLd5WJT6GHQNG7pHgYl3Jj4wYQKGdz0Y/+2761zIXAiT+R1EagKWWv7WP
	XGkQq7eKhaYUO3aSgzv3iLcVXTTE+N4sez/V49MQSKccWTXCGy6njOjigSEQxBHX9xyzqOZmQtH
	RaIqrhtolPyXgCxtUUuvQP1Idzgwt94Yb/Ehqfj+DXbaDYP+ZAn8H4eI5f4X512L1CF3lnKvR+T
	+7F564AqQlqENFLxEGkgRUk9YJJhdhr3y6DlPsZtF3XvCVY+pT5JtpIugNhZnVwh9cXZ8jShq9t
	alc6w+DuAn3DXcFes+r5avg==
X-Received: by 2002:a05:7301:6f09:b0:35d:eafd:5737 with SMTP id 5a478bee46e88-369e84e382dmr14261708eec.22.1793119894351;
        Tue, 27 Oct 2026 09:51:34 -0700 (PDT)
Received: from localhost.localdomain ([147.185.47.151])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8db7e73sm35314092eec.20.2026.10.27.09.51.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Oct 2026 09:51:33 -0700 (PDT)
From: Kevin Dewald <kevin@simpleble.org>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-kernel@vger.kernel.org,
	Kevin Dewald <kevin@simpleble.org>
Subject: [PATCH] Bluetooth: MGMT: Fix discovery stuck after a failed Stop Discovery
Date: Tue, 27 Oct 2026 09:51:29 -0700
Message-ID: <20261027165130.74821-1-kevin@simpleble.org>
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
---
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

