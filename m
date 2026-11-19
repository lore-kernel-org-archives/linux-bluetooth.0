Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795048439;
	b=d9MWPuKpQPm+dXkAAia5t4DPEP7t1DrmRNvi8TFrvk+kP35cW8sgPjw9YgEEsRqhWuX4
	 /7fGWY7r0aewAkETHiFTXoSnBtHK9rNPvNFJUYOsR4EjoiR7IvybRL0tMxC2nFETg+fwm
	 H0Pix+OPhz1qd6QfYzHBhMrhLxNX0FXjl6vmV/AvjiZjXGGIcTbg+wzd3BDvB3Po0dMun
	 c7xuLhnuKkxl00u342HstJBulqmA4btbWcDN7sK5ngFFGZuibxg86hTGOHXPfjaLNyERN
	 bfdN55blE94UWzp2f5ytme30X6D4VKo44HILvxsGnjy+80cRLFZUBYgRWoUjYnozQ6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795048439;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=w8iB8hXj1rJtYCTecMKdoTMO0/3sA+9tX97nJ972+uI=;
	b=cW4VMkxsUD1KPDImGp0eSsP/h++YQgpI0a+Aq+vzZqgdUUksJhgcod254rBVgkM6OibK
	 hoGXkAPiSnmOYw/fjoqfwx+r6Zb9NE9aibb544iNV/L/sy60niYxaIjqhKvssdCZbetKV
	 K+iIxDAm+K6m3mzJwTazaY6WNVENs8CEB8ud6nRSHdFMkl5G5CGvptDPSls+7OM30SDrk
	 XHTOhq+SvIF84hL21/lPy2fKLRVUAx56ur52SkM/WdXfyRndanWIkI//yurtQhfbg8HG2
	 RCdzyoI3NcVqs8104Yvh32PouN6fkUovW9oZ7JPJS62fkSuW+uiKXaJgEwg1UXBqp3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UibzzQer;
	arc=none smtp.remote-ip=209.85.210.172
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956DC606A33D
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 00:33:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 956DC606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UibzzQer
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8b3577deeb0so916922b3a.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 16:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795048438; x=1795653238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w8iB8hXj1rJtYCTecMKdoTMO0/3sA+9tX97nJ972+uI=;
        b=UibzzQer0/Z27aYe84shXuHWDo4bIPhHIwF4PtXRxat2/Mr0euEQTYucRs7REOMSuJ
         VU7dPPHeL/yUhsrET0f2G5zXPyA/Re/4N5wxDTGembLZe6RzS7rJPSSJsz5lHfx3UkFW
         SfUgOLfa0Tjifp5eVPv4DsR7CpRBcS6TJc5ZObsF0LABXfP3WNWxajUwIQr3UeqNbJZt
         AuaE6QUNBl/GcdZWPk4/Pi7/cmT1VPGQhi6NYhzBA4yr9tpAtobYjUmZAb7ARr6Uq+/7
         Oz/AFzj5d/pvYj685xi/qs8Cn8WIFhBAdI11QYLOxc5yC3Bh6eQ1LFyGdjhHoM6CWarN
         pqqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795048438; x=1795653238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=w8iB8hXj1rJtYCTecMKdoTMO0/3sA+9tX97nJ972+uI=;
        b=PQfSLhPDxDDN4qT5aCUEDiU4aqNE0PpyjpsXjVLkozn7xgifBtk0ukB8m6UyoVdLck
         B1rFg3kUjqBxXrjFq7Oc7PAjqBqKBauFPo2RzVFmcFn8iyROMVduKxuTEgtNxRGIrc/u
         kaFt5W+eZYdDL6Y4e0rVcFn0mqtWlFXl/I8CgTgMWtA1EyL/vrDKQx/LD2cGhbbwm/+H
         JXbtvebLYGvezbOl0fIYo9juTxzNZs981TfEpmaFUt28VnuvT/L716/jtra5Yz46cvcP
         wJtRBXZgjN4hINE5+iJaoq/7kjCIvK6YlSdCC068SwTFi9cdB/yrQeK8aYShE2vLGO33
         ii8A==
X-Gm-Message-State: APuU4Z/EOASQPzDOxiTlyqlGEwI5LDI/9vL0nKvRxr9jlMjjFZbJBFUZ
	kMdJ9SlOIkj7UmQJl8URYyVJBta5TgN8BkK3fT5xN4cIkMzUR3we3UWjgSnQsgI2IlY=
X-Gm-Gg: AYBFou2fkLrjRDSbZ+k4oDXCRf1IaerPhWsUasn6OEfioZfFKL09RiI6jQq4OJ9jCAv
	zGf7Y0T6RGLJkRPoD9Mq+nHcZoL61tgpYob3VzpbdzZqrj83JdQk3B5CHo99aJwEvJ02e4+xsjB
	6ZCfDSbkypc3BT+OGvPi9G7EsxmVdab+ndlWyIFl6xaGGJID9t0n+Xr3VS8ezEE0DEJa/npWfHY
	EOtgEQMJlRjrFSOwplY5DtF/lnNK9+z6br6b7ALfY2JOpOIHzg+ksUhVVC0xqAYgEZiUQ7Dh8fu
	MHGxIGMqyAkFhIxL/hOY/5LKXoY+o42AJZCUqiL88xXzMiTJXx/0hLuwYF2Hs5TuBRhuSr65FrS
	pMUzdWiazpBY/KZ0mwcSLoatgjrZ/dWsZInOoORCq2JaXydv/2NqrvIeFVwWtHWaYuGSrRGPeHo
	maGqw+v8fV+fkn9poVydrwGTlAnyd/CUtLDvDoXreDkRrsAhZUY+iS88eHs10hyq0p/gBdcSbks
	jYOywfaplcTD0s362aEuScT617uAuh2RJdfWIkF3AR9uUu/hMDAKH4z+trth/iJh5nY/rrESiOj
	C434Tybf/qqkLyyoRM6wvptN
X-Received: by 2002:a05:6a00:3e29:b0:8b6:5a07:7768 with SMTP id d2e1a72fcca58-8c5d305264dmr3968760b3a.21.1795048437940;
        Wed, 18 Nov 2026 16:33:57 -0800 (PST)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c5c7f99f91sm1906491b3a.5.2026.11.18.16.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 16:33:57 -0800 (PST)
From: Cen Zhang <zzzccc427@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH v5 3/4] Bluetooth: hci_core: Hold the request lock for the power-on update
Date: Thu, 19 Nov 2026 08:33:42 +0800
Message-Id: <pm-bluetooth-objects-candidate-0184-v12-e80229724d6ad14ca88c-3@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <pm-bluetooth-objects-candidate-0184-v12-e80229724d6ad14ca88c-0@gmail.com>
References: <pm-bluetooth-objects-candidate-0184-v12-e80229724d6ad14ca88c-0@gmail.com>
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
