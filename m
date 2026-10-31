Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793431963;
	b=mna3N7Sl9GaM2iBh3Vyb4C+tXrnv7gLv2tjQIOREaZImP7WLAv8oi5l78to6VbSXXmk1
	 7ZMwvUlXLbsLYKQnqyWbK9MXo17+3unaxiQ7kmLScvE9LyTGu0fIlCslj04bSdg2Bwz30
	 828L4rUBg9FX2WBljtbWNtnBx9cgHZl7+2VUsMNRofNTdHVYpc8VifogCKqxhgOyp0W/A
	 e47GF83QPv96A9iKCF7waMsy4XTLiPDCeMnGXHL41FFXDL/jd6wP/f8HNSIrgy0rdPcJS
	 JFybYh1MiG16XBNhmwoqbw6vPlmXc5kJZUh3Ih1YgcQkRZhxdKkgWyOCUseG9uw+TPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793431963;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=M6Kw+2ZkPNmmmVtdjl+hjlT9G0MDLpS6DZPqvvJBmbk=;
	b=X9U+49NZF7qoUxEQZY4CoNNzu027TaJ0wLBnR5vpEhPrP/PAbboSRqZikoLj/UxiUpAI
	 kX8qm0735xMTwed/aZ0+hPd5q47hQVWJfQAbVZpRqlMO4kmw0ywemzC+YHl5+3DVER6hA
	 johm3AbD3KYaAGhKkQLtrbn9jXrD/2c4RlNwArQg0rCVC3vIBSzntdwf+npQhmi7xTjxQ
	 1kMbpC3LSheD3w4yXU0dGTr+Vx38FzwoSOoJoiOp/3YA6w/i+2PYKGVLMHHndRl/3V5n+
	 sRyDOT4bAyMEesNOacCFcO9LYcr2EpDXKjEEeQS+xb6+WJjYOMuu6HlM4y+p6VoBlNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rwyZXJZm;
	arc=none smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5701606A31D
	for <linux-bluetooth@vger.kernel.org>; Sat, 31 Oct 2026 07:32:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5701606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rwyZXJZm
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-89f85edd210so554642b3a.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 31 Oct 2026 00:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793431962; x=1794036762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M6Kw+2ZkPNmmmVtdjl+hjlT9G0MDLpS6DZPqvvJBmbk=;
        b=rwyZXJZmIKzk6f+J4wV1wvSZJN+xIl1EYMTKp7Za9DOH4LuoQYIJTb3Y1DQmFRWj5h
         hr84Ma2NqAMZm2fbN/7/4LfjCI6qVBUhts7EZb9EFCrdQnZ4gnE4lh7LcYqFl6NQrWkt
         wh9Bp1d4GQOnt+6oBGvQOxg+Mg9zedLpzbBRKqpFB7f3o+f4pZXX/uTpXqb/olOnXQTD
         W9oc6YMLWTrA0Ka2B9qZ8Nxc5T6kBKIjp+xD97CQKvOFroPY7dXyKHboTsxnHRNZ/Y6F
         iTRdJhag4Rzgoo4iNYznxvfpvckHfdllpOTL7b7X2RHJjnwjW2z9nP2/XOT9F5CffoQ4
         8ueA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793431962; x=1794036762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=M6Kw+2ZkPNmmmVtdjl+hjlT9G0MDLpS6DZPqvvJBmbk=;
        b=Jkzi9VW3U5lXniA8XahnP+/6+BE+Cs3dH7N/dcyuVwTUPAsjnB+EBzcrbr17bukKn4
         ZPWqdWwXz6TmcSxWWW5Dk5Kr3zGeBuJYoAlUOEq0Ocmba6AUMnyb/B8T/XlBGyP9bk43
         4znO1LeODsMi9KtlDK8y4PgEVWUiE51EM22zj4wmXje1Yl3msmZuQXrOyhZTVPXA/2bv
         UyF5yRw/eKINRBQVVZnxkrD1WmaIE5XlPcI7+IlTvlJiMd5WJNnDorcQQlo5NjzR8/o+
         mNpXLjOdZysSRj+0RsY1XXz891opTmALzaDzwqWxHoeFlZYWMGgdGFZCway35ncUtPPz
         XMig==
X-Gm-Message-State: AFq9FYLZenQLLWahy4vZoaL7xCuE32qrSRh/qYowrezwuhds788Ax3gX
	3ae+rIp9j6WFozkSlMyDemaPo0QhtzWh4YE+HzFvaqwy3MSGIuxeAukZedBWh1P1XG6KFA==
X-Gm-Gg: AYBFou2ptVon+cNCNFedGDYM8utzSYYUsvWbQBj1s7NIu2OZLt094lvG4XsAJE3Swgg
	m90rXfhG7TSghoXrFrTsKtPapQY4G+R61Xjp6qCWaUKiY9KAlbxVeR+q0JTdt+X+nyS77AVyAiF
	vEMEH7/OLk9JV+ZslDB76v3pqTUz8ygZPv+Aiurb60wMLk5HlvdCJ1EzajjCkePLDLaK19wmrRA
	8BTSpt0kZ845mRhtgjwZEEWwQmdir/43wAz7hJqM/oC4aHMlOw/1boztJVniDsTxiXqN7AAMiDv
	57ATMCeLjVXgq9sCzuaeAyHzEK1mb6Qg/AHL6J9JcK5CAG8BaO8ZqVCE1GTQVf2sxsaXOOrTZxl
	ZAgJquvlU1M0XN0zkPjLZeiDspu+9j/YNIsknY2iTufKQFrsjiu8RUyWCtfWw1QjKbUbTUSlhFQ
	XM+I4ilMDqj4yA1SJoTIaKpPgKWVcg2RbvyYMqV72PaD4Oq4p/MdMpZZIkjefvNzKZJVCBOsezW
	TBEJv96gQnpq4ZPD6/9bzmZGPPBOcnljHxAHe8nQGolUmUuGIq50t5ixbILgFXO2oabwU5AVCg8
	tdjh63EucKPr1KEZ4UKprPmcfslcnN/fO4QKuJcN6k2tFw==
X-Received: by 2002:a17:90b:4a4a:b0:3ac:8446:c1a5 with SMTP id 98e67ed59e1d1-3ae897d313cmr3466248a91.48.1793431961896;
        Sat, 31 Oct 2026 00:32:41 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae841dd1b9sm6691486a91.0.2026.10.31.00.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 00:32:41 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH v3 2/3] Bluetooth: hci_core: Hold the request lock for the power-on update
Date: Sat, 31 Oct 2026 15:32:23 +0800
Message-Id: <pm-bluetooth-objects-candidate-0184-v9-4094fa28af7bd56a283a-2@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <pm-bluetooth-objects-candidate-0184-v9-4094fa28af7bd56a283a-0@gmail.com>
References: <pm-bluetooth-objects-candidate-0184-v9-4094fa28af7bd56a283a-0@gmail.com>
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

Take the request lock again before testing that the controller is up,
as hci_power_on_sync() runs the same update with the lock held when
management powers on the controller through the cmd_sync queue.

Fixes: cf75ad8b41d2 ("Bluetooth: hci_sync: Convert MGMT_SET_POWERED")
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
Assisted-by: LLM

 net/bluetooth/hci_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 2a29cfdee9728..55bad385e78c4 100644
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
