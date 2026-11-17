Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794946848;
	b=RtwClf2V8d0cPtRqH499mE//sR2nh0DyPw5cSekPf74e/J50yET9w78NCheCiR26Byio
	 mw364TkoB5Q5N4FiEnnYIM0Nt2guFTFLuAIyMrTAy9UCpBLJjoABo9R4zByp9xogTSJLc
	 nL+bH/0F4ErJeFviiWlHj8/T/RmUgSpvBVUogHQtGpTLgn4Uh/ovDk4o3ysZysN7FaucH
	 MLgBbAC+cANzpVh7p0BMHwGszQ+b3AW4YzA1hETZg/c0E7A0zGWYC2FRCp+BrBGK9nTBI
	 3MBFKcIKth83rqEsZVwxZEZXrb2/V/3Khdp6neAbzZgzJuvr5L+gPSdWdlnyKPspGJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794946848;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5Z8SPxdj5ODVAQEi7lg+Gv07rpjrRS53E/dvwi0KsyE=;
	b=I/JUCu+hWD0mCrKe29HpaWd0vWzztiOVIF/hJ6sE4TdP388JGYewy5yUOeFWkinn6E91
	 cqKSxAVnAzYt3Xbu/xCZ/e/EMSZ68QH/vgJ5dDcny3yrvnEn+bcg8A8aDv3m4La4kyc1G
	 TJgi0Bu5uAuqVnNEF4OSO1djT1qSSlC7dJclhVo0vKQ+HW75PxShF6+74NSv2A7yDC2n4
	 IDJQmQkiUP/7HjUz6I94zfDMnsvoXKp6iy+i37FGoQNmrfroWbx9EHI3HguQJGxRdLD7N
	 JORNd4DykSQWiGTEKwZSMkUEEmgEX6ozhAUVbTJKDjEPd2wpcirjShV9cIPnCzg9+vA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GPKbsSN7;
	arc=none smtp.remote-ip=209.85.222.45
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D3A606A330
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 20:20:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39D3A606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GPKbsSN7
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-99e0082c434so80641241.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 12:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794946847; x=1795551647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5Z8SPxdj5ODVAQEi7lg+Gv07rpjrRS53E/dvwi0KsyE=;
        b=GPKbsSN7ZRN8g53/Poc3Q3MZ4KlAaB8KuhwGVwzCNTBzYA0T/ChDSeujGwpD9JP9m4
         N1cpyB6eQpZX2o4zpTapRqd60/vIXliAsY8i7BaYlqiHXgtAKuPSRacuW9RWdDYZTggV
         LSPnkqi3YvQ9rVdEdxoVf5YwhDF5+diiQl+cTRUIgw8pXo8IYyrxvubrDTnYaT63fDYP
         v2NGxzZGDg6cVcJUprbG4cLtSOZWXKp09B4Cb1lZmgGERhsyuAye8Vhm7mciXGpqTMve
         MkwXEJDZ2NKXTomvyRiRlBi3hNowkGIUI69yNAPN6U0rNw4SHmBWFHXX7tNi9/gbetcj
         SJ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794946847; x=1795551647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=5Z8SPxdj5ODVAQEi7lg+Gv07rpjrRS53E/dvwi0KsyE=;
        b=AIDrw0ALMJruSwSLPKuia0LvllIrlEMcmcgc6XKUs2ccAbvN0yxKBhIm3Sq/404PBX
         J5QkI6k0BOB3zXemja3YuXOjEb2XhmcDWCmy302z+7usanLzdriWSyyRu1Z2hafNnMTT
         YDp5OiGTzy0D7vl8e4lcTusKrecj9mdZ3fdOqgWUyOMbA3Me1u1lDbxZKFlGoIRufgi4
         om/3Gz3s2ayoYdpN0uiu4cLWvC6VWsyrnW4DnT3sSctSgl7h3aaa4Qpqpn9LnpH3Eee5
         Y9Le9xHAZmAQ8NAsvfuInGrEXkNylWzXfNIiRsWkz8ex+YNPm/jY+Kb2tuzfeIQmqwDW
         rl7w==
X-Gm-Message-State: APuU4Z8Vgz/O2l+TQj4LgZFMrB70LtOlUB6InZqJUn6ftU46cyUqqUJr
	PpJaribiBTkru5Tlk/pXhAc2BqMXNWHMqUjpVGZ3Yb+rDD+Qb2cEmI/KljtwCg==
X-Gm-Gg: AYBFou3Jok6hqQ+4W0lqMugqC9/QRWHaHr5H/Pz4cDG/QgGfiSSGsGbdnmv0hEAQ0q4
	O4bQWupP2aCXKqO0Ty9lFCcIu+R0HfPNLGXgiVBsiGxQD7CmPwTKlRvi1yOF8SX5JJWSQ9bdIfK
	g1D+3WOFaHeHENp6Ckg+47ONpzQGxAIrRqk5pV8RwPHVjeI0ao+uLR+lndWAbCaMzmVBQyA4qcv
	rChE/vtmfXhUaXuFawzVzRFC6D7KSKAi3dJ1QFwm/iBcPGA5k3mDc5N7882GGdPZLoKxbtmSr04
	e/8/CFcxL0HDUhB0TGsGnQk0QnK9eIjPG8b4/hdj535ssmErhtcPcyhZMSMffsIOjMKIA18iPdl
	hatgQ6KudBFcHEJnPAGchJMAengwUzOgJQv0MUeR2xmceK10OADvkNyQxTiLLB5IBv/Attb/yQy
	pNdVI2m8s+/CrqLhdtgRYTzFPfbSAKqUUaZpG3QNX4PNtJ8l9bt8goCMmyJ0eGEdkPGQS0c4Nf0
	XSYgzoCmqfXa/cmkVCicP302BPLlgHq6OkQMVs0AzuyG9pzOD5s0jTmM16rp92EjdxtEuj6gqw5
	XJto3x1UO9lQ8oVQ9diclxFcuM0ZOxyin9E/Subzxdfz7U6xt4NZ9foxgqxuteqFi1SB9EPA9yU
	Uzf6CcsMiE2E32+0LJ4ZYjFT8/p/cqrmLFOmbDJ9ZnN24koHxNqf3p/REEvYIPljruyDSMNJuYn
	CvlyD8bmWNj3Yil0JOsAkrw0ji
X-Received: by 2002:a05:6102:604c:b0:7cc:174b:f7bc with SMTP id ada2fe7eead31-7d6ba3894c7mr44011137.15.1794946847148;
        Tue, 17 Nov 2026 12:20:47 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6b935ddf3sm303166137.11.2026.11.17.12.20.46
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 12:20:46 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 15/17] Bluetooth: hci_core: Hold hdev->lock when removing advertisement monitors
Date: Tue, 17 Nov 2026 15:20:30 -0500
Message-ID: <20261117202032.3848411-16-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261117202032.3848411-1-luiz.dentz@gmail.com>
References: <20261117202032.3848411-1-luiz.dentz@gmail.com>
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

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

hci_remove_single_adv_monitor() and hci_remove_all_adv_monitor() only
require hci_req_sync_lock, yet they look up and free monitors, modifying
hdev->adv_monitors_idr and adv_monitors_cnt, which Read Advertisement
Monitor Features iterates under hdev->lock. Take hdev->lock around the
IDR accesses and the freeing, but not across the HCI commands sent to the
controller.

Reported-by: sashiko.dev (linux-8b358899-5ac9-4687-af16-58420a4d9bba)
Fixes: 7cf5c2978f23 ("Bluetooth: hci_sync: Refactor remove Adv Monitor")
Assisted-by: OpenCode:claude-fable-5.2
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_core.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index a6bf806b9206..5522d4397682 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2129,7 +2129,10 @@ static int hci_remove_adv_monitor(struct hci_dev *hdev,
 	if (status == -ENOENT)
 		bt_dev_warn(hdev, "Removing monitor with no matching handle %d",
 			    monitor->handle);
+
+	hci_dev_lock(hdev);
 	hci_free_adv_monitor(hdev, monitor);
+	hci_dev_unlock(hdev);
 
 	return status;
 }
@@ -2137,7 +2140,11 @@ static int hci_remove_adv_monitor(struct hci_dev *hdev,
 /* This function requires the caller holds hci_req_sync_lock */
 int hci_remove_single_adv_monitor(struct hci_dev *hdev, u16 handle)
 {
-	struct adv_monitor *monitor = idr_find(&hdev->adv_monitors_idr, handle);
+	struct adv_monitor *monitor;
+
+	hci_dev_lock(hdev);
+	monitor = idr_find(&hdev->adv_monitors_idr, handle);
+	hci_dev_unlock(hdev);
 
 	if (!monitor)
 		return -EINVAL;
@@ -2153,7 +2160,10 @@ int hci_remove_all_adv_monitor(struct hci_dev *hdev)
 	int status = 0;
 
 	while (1) {
+		hci_dev_lock(hdev);
 		monitor = idr_get_next(&hdev->adv_monitors_idr, &idr_next_id);
+		hci_dev_unlock(hdev);
+
 		if (!monitor)
 			break;
 
-- 
2.56.0

