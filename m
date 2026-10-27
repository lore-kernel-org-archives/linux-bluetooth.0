Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793121559;
	b=NLPCdAAiIXR4pKwgsx4HAOHyQXJwbMOYPgBDincbqNuzWU+Wjp1r7ww3CaX4SqYlTG8R
	 QzN1cuJaW5UJGNO4aJrRLtNoSiWHCAcbn6SKSmazM6RUWwqgKS7EqQO2I24WxVuO9Thry
	 Z1iSeCeMREIbJQ3FJTIswJ87D1g9an60BZFoIF4h0wyq5dWXokK1kIeO5g7QkObuumM3c
	 Wcx8TLVDwKYbNvFuBlz1tile/RFP1ulnJYI6X32VotuEGfaqm3+Qf98ker5UZeVsthayU
	 Q+Joc25g45oNbiDwf0p4yjYGKUeSFYnSz9n23C3Jq1w+Hn0kQC1TKbhcfDqxJ+59cqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793121559;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=aAVYI7hzWz0Ro36eEs5zq4Y7AqRKeB23+7GHTzj26rY=;
	b=IVjToRu0pqJPdSg3qYHWiK9OlHz/ij1CvTOLP7/3PU++RBoaKrZSxYwyIcgi3LHQi04y
	 cdpkNWsEz4vfF+BsVYysbjX4bmMoR9Hp0L0MJUmYnmnqO4k1gmIcLPuuCrYSLwnAELEb0
	 BLd5D/2H5RbHek/60mfGyNsIG2KMWhleY0d6Rl95FA7Vd+BLifx65rf7X+BM87+Y7MVXy
	 Xp1zoBYsWsFXjyxdlR5rwuAaIJda0Iwgvn8PeEqCIowvMGXT4W1Zg1K5EyDUF41zJRxR9
	 UiicvqZLYp7JBFby33P3rlaG5UoYs++zzfIVYSMfNPqvRHor6uv8fXrGFe4epdxW2lQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simpleble.org;
	spf=pass smtp.mailfrom=californiaopensource.com;
	dkim=pass header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=OMV+wd5v;
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6FB606A320
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 17:19:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA6FB606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simpleble.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=californiaopensource.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=OMV+wd5v
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-14394530ec6so27854c88.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 10:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simpleble.org; s=google; t=1793121558; x=1793726358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aAVYI7hzWz0Ro36eEs5zq4Y7AqRKeB23+7GHTzj26rY=;
        b=OMV+wd5v0uEIfsIZPUPU/X3XoJzGUe4i9Cwr4VY6wWsDBbYeb+h5JeTRDDeLxRr6lB
         dwV1BYI4lMXjtZxGK0EkpDr6yOVsCRBqQu1xIUgKfQSrHwinwSJa7JhHOQcn4PnNeS8c
         Pd/vy4FwwvnXu1ke/0eDpmNQOA9kAsPi962pzvDSp7FQDIajDr+TADTPnYhUGwuhajIY
         llJfKY0zTkz5CQgeB+YDrmjf3+FHpUflAFPav4A0pCA4N25PgVxXZzv93FP9HmtirhC/
         sqZA6Ag5wPRN1uRh76urKFutUsmBUteki/rCYCNu8oWGk1gCkplQDC2Q4XsORJJDFJjU
         sI7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793121558; x=1793726358;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aAVYI7hzWz0Ro36eEs5zq4Y7AqRKeB23+7GHTzj26rY=;
        b=mnlaXfWGOm4I9ZUL6FBBZCR6WFPVI1/+VZ2rK74LAtNAsZPZu+iLzdKw3kG45FoUsv
         +8Uvwr0YNqeLeTe+0SZ7j2EU6rmHOm97JP3q0OsYQLfDjWgFiUZ/dX5pJtVmkKVNh5h1
         A7sTTeipNeSJNQFCzu+v48WnHlxJyMENdIApUEy8v+m1yprrnAoPAp8kPJmIoUstyEBW
         lW5sESLwbWUlQtwwBDFrA1nuZU45tLh4Yt4ab3K8eIcC7/i9HNI1EE8fz6KYCEcUpCP7
         EpqW684QsNM9buG66VsDRIfcGSomN0FpMXRdv6IKFo/eVLjtwlbJorw3KJ5rE+y2SJIT
         Di7g==
X-Gm-Message-State: AFq9FYJnH67rSz8hJbNjXAt2pvUxdufaHFsDTGf6nptoVFSXodUl7vGz
	Hzg5KRGisvYk9spv5Nx3eUa7nOyx9MTPlWRBi1CgWpQZ1pORKHGImelGimEOYc/yJhZIXU4fzwc
	sYzTadMbZOQ==
X-Gm-Gg: AYBFou0XLQOgbS0Jxc2lTBaVuehmqGCvVkExsXi4K8oDzlk84taANODbe/TN9vr6wPV
	au+fw1c/3fjQ/loH/u2n21RJ9Awzwpg7g+kJYQWvFotgyerFfmf33uOQW4THawuCRIWRk+/9J1I
	dXGV+wWxtHQ4LCYzkEZS6UdrFy/OGRrLu+szSpFyrbF4XasD0jTxmUeYRZ1y2YEy50VG+SYHq0L
	hM3N/pAB6KETMdlfcDJHw7bLeLnJtY1EIRvQX9Vw6rIZ9TKhvnxIKcwtp045ML5sEiv5O0xftsK
	00nXdLfPs6RoF7keK3d2JyAXZ6WxSpXNqNF0F2n2yhsN2xAaq8us1Qj0PWDp9qJLFvaJMGDxKy9
	V2SzHao49KNA0iPgwzkjipqlt4xUUpGNPArJl9G1KkA5VR/ECcYnNzNq3ryLLA27dwxEmYfhrhq
	Pc6lfyyRn/5uFn9boePNpesmCI6YCoxM1hfod1ECqniAWbHtmKEPcOI59J/npnQlc2/U/5Tk97W
	sUSrb+EbvO0Uhm1fnQ1QMIJJWLRmYail2u6rbLWGN6sSa+HInSpn2GsUGCrt3Kg6J3dpr7aXYqN
	XO2xdQTs6g8CmSzB5xZBb98Vb2hr/ITepYI4gxr/gAn4tfvYsd4MK4a71nfCkTh85VnEDHMeZkJ
	g+Achj1tmZxIDzX0pajRiMg==
X-Received: by 2002:a05:7022:7f12:b0:179:a1d0:be39 with SMTP id a92af1059eb24-19935fcba5amr14595800c88.29.1793121557565;
        Tue, 27 Oct 2026 10:19:17 -0700 (PDT)
Received: from localhost.localdomain ([147.185.47.151])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-19894d5a10csm34517842c88.1.2026.10.27.10.19.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Oct 2026 10:19:17 -0700 (PDT)
From: Kevin Dewald <kevin@simpleble.org>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-kernel@vger.kernel.org,
	Kevin Dewald <kevin@simpleble.org>
Subject: [PATCH] Bluetooth: MGMT: Fix discovery stuck after a failed Stop Discovery
Date: Tue, 27 Oct 2026 10:19:13 -0700
Message-ID: <20261027171913.82628-1-kevin@simpleble.org>
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

