Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794975725;
	b=gbFQzsT1fbDqQsG/L8KITpoDv3/ZV614aHQolLvOojJ4QbxqwRQvla8WwuOZWzD1ZSuP
	 WYNLthvZKUQhC51A1pA1mTNq+YmIg63BpmMZvtbJCMJGazpRWNb+UpmuC9Y6xzEbzoN07
	 DSFhwnpDX2Ck2TYcYPgzyVpA2ork53IOBug4a5sr7sySlC/PRbep/6XK0hWHpScMRhT8F
	 7LUFf1nBP2eO83JT2jmsFo7HY7D2Eh10N8SAiVeWWhZiibs0xOIpGiUPzW4JA308Z5sDT
	 8IvmA2VbECg8SnD5hbKmGKIi4y1B0p9gA3yoVz+iTanBLjq5d0RN4LccAWypBD4G75Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794975725;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3ySKCiSWgBlwtkoa+bnMANotGsGSd06xoNSagHbZ3Ys=;
	b=Vs+skTJv0dHdydfV2Uhk7Yg/A3quxknNK/agXRfKTrApBwi0vihY2GoEXuigxwJvgvYF
	 ajbw88eHObjuP4EeeHXhNRFPJoyCtLPJnbbPmfoWiPoTK34lZZEIftlESK69Gw5sSKUi2
	 sTlY5UpOcd+7F1V1hZ4WzAx9lX1bJe2faJYO7xqdRczjJVIIDjj11vhdphgXTdr0jJIcR
	 WyiBzkX/iaJogtrS3iULLrQ9aXi6qHoJglibZ/+ne58d6bPLGX9aAD8Zl8aaWWZaLH6UT
	 ScCNaCc+UKfwFUx6VhKoHLzfiBb/rLnbvC6znDxdI2yvEyXzJ4NJ4I5lI2I+3JfS/MA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OGTHkrFj;
	arc=none smtp.remote-ip=209.85.210.179
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58658606A331
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 04:22:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58658606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OGTHkrFj
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8b612fd74e1so208567b3a.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 20:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794975725; x=1795580525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3ySKCiSWgBlwtkoa+bnMANotGsGSd06xoNSagHbZ3Ys=;
        b=OGTHkrFjJwfpKZzlmvBYulpQV071JZlDp+TC5aiofULsAiovcElnfYklWWnUucIuJ+
         OZH0YHoGTt2nBfdpDzR1Bv9q2jrX89UzJTFNvoI2zMmY/aORykvFXvZpLJVA9BNb96oe
         3PO4vJSX7XRpIpH2w4GPLVizoGC2SCJbpsrR7XCNtrqTTR0fhv+yn0j3p0jMAXdSDgyo
         corC9PW35aSh/Dri2Q8b9yhEbQ11sx6mqhbN97vMRdfuHqqeo5+zagCTXsyFH4RwQKKx
         ON3PIy6bcTDQut0eHm6OGyyCkvtSeGGCrmuqY59j7xr/d8bKeHyn97kpTuZk78puYLgN
         zVeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794975725; x=1795580525;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3ySKCiSWgBlwtkoa+bnMANotGsGSd06xoNSagHbZ3Ys=;
        b=siVf8ic7VHgopDc/Fy8hVfh8Ae0IVCbQBAeWTBfy43sBVfuy8kkw7Khjvp3pyU8xW3
         +zE8n6haEAzkxlYlXJXIbQsekYEtSp0d29mtOJigHu2TG5lrnNyPon28l92aDahWegux
         hDo3gdalcBzJxw/xPEKtWrVbTpG/l7JRdFeo31YzjngOyCLjTByQD2hX3a7PXzpVJJHh
         FuMHRqjX3K250R6ENshz2v/AfQWfcSCFHzLvAHXBqk3gTqH+SsfaMpHOpBGCeKS7zsbf
         C5gbIUF7YGQBFyF75qavDzzs0iaTTk3n9jNuiR1bp8vx1UUMfc1i2vGjbGCKJMARImge
         saHA==
X-Gm-Message-State: APuU4Z9iv77Jf2OndwM+jv2uchFtXvxfVZrZMqnH62FCa5swwvEthOfs
	hnj5gFe/TneRTmmC1G1dA52j3TH3yevxiA1kaGqFy+Gv0+FENoPsraWb
X-Gm-Gg: AYBFou2jzVKp2YLmm/wEPjykCzmEBdY6LRhvKKIr2CBP7kIHOO7MwiCJTpVit4jBsxB
	J3h4XmNbDG+/GYX5V1q6F4kvgxXc38h8TYTkc4JCQCcLtBuA7Alh0SVzIwC34TjoFzXn2O/mQSa
	S9vBZ9ViEpDiBOGYnGRPChnv9XLGRgEz/MeDv7iO9USGfM3xDhJlHbyOaqQlFVR7whY3HUyBWwM
	eIb5Fcx2xQd7wBpECgeM+6wPibbD34BIQE9g9dIwAV3jg/Olz8X5+A5Njy4Cxd9vpY7NFfhULt7
	2vfY8tFdRg6UmxQooeJ3jBlOiNTFsFANjmdHmikoU0Q6TA1J0PNz37vHsFCvmIcC7DohdeG0fAM
	Demu6B0UZari4O2KT0LBlmVycd1K9WzeujoOJ8NKk2s7JxdtwD1Ks80OKDI8gpOrqugdy2FIycC
	c9zp+x0BKMgJ5+LLci7vCn4gUiVvKnKA4mxr1Uhe+JCBE9Lla34P4+64HB99PoFvBcpKHavzRfW
	aI8ZNUj20hG7UcmJmAwCAiCUKBvfPBVvE02l4bLAgoNci5jw1IN6kwXyye0DXG+HYTRr5mprVN7
	qAMEdsGyM1pB+n3pdhPpkxQI
X-Received: by 2002:a05:6a00:1994:b0:873:5267:dfd0 with SMTP id d2e1a72fcca58-8c5d101b6a4mr1020103b3a.5.1794975724498;
        Tue, 17 Nov 2026 20:22:04 -0800 (PST)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c5ca7aaa8dsm455003b3a.10.2026.11.17.20.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 20:22:03 -0800 (PST)
From: Cen Zhang <zzzccc427@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH v4 3/4] Bluetooth: hci_core: Hold the request lock for the power-on update
Date: Wed, 18 Nov 2026 12:21:37 +0800
Message-Id: <pm-bluetooth-objects-candidate-0184-v11-900043ed2303656c76fe-3@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <pm-bluetooth-objects-candidate-0184-v11-900043ed2303656c76fe-0@gmail.com>
References: <pm-bluetooth-objects-candidate-0184-v11-900043ed2303656c76fe-0@gmail.com>
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

When the controller is already up in the HCI_AUTO_OFF window, for
example after set_public_address() or set_external_config() queued
hdev->power_on, hci_power_on() runs hci_powered_update_sync() directly.
The update registers the SMP channels and sends HCI commands through
__hci_cmd_sync() and its variants, which require hdev->req_lock. Commit
cf75ad8b41d2 ("Bluetooth: hci_sync: Convert MGMT_SET_POWERED") dropped
the request lock that this path held around the update.

hdev->power_on runs on hdev->req_workqueue, which orders it with the
other request works, but not with request lock users in process context
such as the HCIDEVRESET ioctl or an rfkill block. Such a user can close
the controller after the HCI_UP test or while the update runs, and the
update then registers the SMP channels again after hci_dev_close_sync()
unregistered them:

  hdev->power_on                  HCIDEVRESET ioctl
  test HCI_UP
  clear HCI_AUTO_OFF
                                  hci_req_sync_lock()
                                  hci_dev_close_sync()
                                    smp_unregister()
  hci_powered_update_sync()
    smp_register()
    send HCI commands

Take the request lock again before testing that the controller is up, as
hci_power_on_sync() runs the same update with the lock held when
management powers on the controller through the cmd_sync queue.

Fixes: cf75ad8b41d2 ("Bluetooth: hci_sync: Convert MGMT_SET_POWERED")
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
Assisted-by: LLM

 net/bluetooth/hci_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 0c0180a616d15..be087b9fcf3df 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1006,14 +1006,17 @@ static void hci_power_on(struct work_struct *work)
 
 	BT_DBG("%s", hdev->name);
 
+	hci_req_sync_lock(hdev);
 	if (test_bit(HCI_UP, &hdev->flags) &&
 	    hci_dev_test_flag(hdev, HCI_MGMT) &&
 	    hci_dev_test_and_clear_flag(hdev, HCI_AUTO_OFF)) {
 		cancel_delayed_work(&hdev->power_off);
 		err = hci_powered_update_sync(hdev);
+		hci_req_sync_unlock(hdev);
 		mgmt_power_on(hdev, err);
 		return;
 	}
+	hci_req_sync_unlock(hdev);
 
 	err = hci_dev_do_open(hdev);
 	if (err < 0) {
