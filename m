Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795710000;
	b=QY5oXvl0zjX2uKyZFWxT49Be5q0tv+imp4/blXGOJa9DlSwKxP5Zh6Xak+Jd7S5ErnSY
	 6Osasy0lVmeO+6UmmCWcLB0GFXe4dDH34SG47OpH55E0miTamPUBorE78CVLPVFScKDYp
	 yyqDHc6QXd5St/WHuTwDu+bUuCtjHjwzgFpby6x0dUDiAVTYrvQIg1qlcKZ6893F02Pfr
	 ENTB3OgY8h+o94PVcw0kErWpG3OdZ7F9Y1dH70VxjX7+M7rAGfRpR3dglVDPJaBKNmB8E
	 9ft3bkh3vKNgEYaRu2fgEflfw9bbv9MJJ4dNAPxnMOc4k7vXJIohmGNrsziCeTQ3iGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795710000;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Lkgre5qcJ5JDJ83VWMY/EoHEK7uMhR2UbEpH1fCBixw=;
	b=zg5RmBb4ed/otU6s6sS9XTF/U0RBPxMuLuEoQdpHXXQdKKHC8MB/9pE7/7pCAXWJW6/2
	 MLfnq7ETBSM13EIyKhfupflls96TiJjuhrhwwPJtMNNKYjf2kZPfubYG7c1R7y0UDWmTL
	 UJiaROWpWV/rivemyiDeOAtl2j4fftU7/GgbnXnO2/bIVgZ4ex+bs6SPxGxlOuvfH8N7P
	 StzLkZkWSij62O4GddE4NV9cEoZZm5oKv1j5pXk8HQzMHNWDgiMmuoG91ppoybK38eAoG
	 M04aTGvBXWeT9kQcm4cZejyMSRh7g6e4y7POXUIi1cQqwgGshMIxYxccK8a41pGjHdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Udz6qZjS;
	arc=none smtp.remote-ip=209.85.210.47
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679FB606A323
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 16:20:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 679FB606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Udz6qZjS
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-86320a60314so1038366a34.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 08:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795709999; x=1796314799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Lkgre5qcJ5JDJ83VWMY/EoHEK7uMhR2UbEpH1fCBixw=;
        b=Udz6qZjSXZQmDOFyEhkHpyTSm68l/7h7IzU964hcapON0wdPfXoLuQpMQWoThd+++u
         Y+Ey7MF570dSADArqyOpiPYgz2BsXvqUWu6eYwHJMCCzZ0mGz5pRAqsTn1/iSXRVQulQ
         UhcBodEcPK3nFJfBjHDBkF378mh7ttCzH8jK/+Mt137d+30ckHAfPHHRoo/nqD74EMOo
         QUeWyhPzk1LzMMyH+YVR7Da8tvj1igWWoUr7PMTHQ5IZ0uWFQt/C5JLX1s3RKIZSIdWU
         7c+0qHCZ2kv2Xs4uVnG9sjntSO+gA2GaN4C/spQUqcXljKpgHQPbXE/G4sC01dQzK0zY
         Z2Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795709999; x=1796314799;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Lkgre5qcJ5JDJ83VWMY/EoHEK7uMhR2UbEpH1fCBixw=;
        b=qCqOgZIoKVcbOvEC/QCeCd4ZC9AEnEWG1L66maiY0WgkzeOrddxR1wlWX3E8xGlT7v
         GrZl8wFcscmH54y/+rnxlZOpF38o+XxQ5j3N8Gu8cRO0UUOHVVSzTWj1vXf4Ht3t8gw2
         QYIHj5TIS+ZmCfLc1At6NtPFiNBR2AhsTLUr5xkVIGZZAjy6WGfxYP2PLj8RwdG1ycIS
         LvLtSGHyuOzqAJOFkK0lCe0/u445kvrRjOaWso2zncFk6jHYmqShQtm1dzbqMVErSYY5
         g1FGuXZnbBTL7bJ9bTy7cukFI0o57ckMOFkbiHYg1cnA1A7C+mX5wvphs6soHwFzgUkQ
         DjLg==
X-Gm-Message-State: APuU4Z93u9ueQtZEMJjcIebxIRUWmvFhgKIEaFb2FB6jiqAUni9NqeoC
	RoJ92rM/5BWhZrZCIeAau6uHCFo2dPFm0Y+zEDsTWegeDRFCoBV/SlE7osW+GMwoVX1efg==
X-Gm-Gg: AZFdTZdSVlfj4ShIwPXdmqDI4aL09QyqnGNseVh2N7GEglSlahU2HEsFMciJm5W/Oz0
	aVu73k69GjtX0ZNeQfcC6B7/yEFVGM4e7Y1apdBeXlK8ng4iyOj9ANJEHYfPNrQNhur1AMQj2Z6
	OVjmI7ZuTLv35lUKSY3tyb7C2wzU2wzI4XODlGlCt14Bdy228loi6EtF/FOrZOHYxPGTN/eowCw
	xASmf31fanWdZmLr/aXiR1vqLBjmzCAXw3qaeeYgqKz4NE3MQvmo/bNMqoqdzBGn/D7bLkw9rot
	BolkPx2RYoTsG8PmktCHCpkcLUJEAHyhTgKIqsMXTNvwFQEXUB8RnNxmTKYnZjaaFifIM9tV+wG
	iz3RI5iylt07t3MLEBtt0bHqLGFWE/sfAaJ9z2Y4989k96R/l8lsI7Bgy8QiKdD05TUyacxGI/T
	UFeecdn4HW6phUynPV7I5B/Ei5mA3loopJbNYXLvLV5z+HgMFseLYejewYIrP4RBJAGjI05hGnl
	5++gD0zl60+WlH7LUPsvzqhkcF9L/gu9awrsc2MiLmat8SJtPvaC77EBB/jjVn3iK3VSTrV2RiI
	kp4JzCX0x2oTQpKsaugXVKcWnEM2MT3hWX6rcIyz/tIosJfO2t72FI2fwxkT0RhtkWQL3WXkezZ
	Yj2jQ/G3Z
X-Received: by 2002:a05:6830:2a88:b0:845:3cfe:5f2 with SMTP id 46e09a7af769-86314ff95bemr34495862a34.0.1795709999247;
        Thu, 26 Nov 2026 08:19:59 -0800 (PST)
Received: from localhost.localdomain ([37.19.221.85])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-863168dd6besm15335990a34.11.2026.11.26.08.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 08:19:58 -0800 (PST)
From: Iaroslav Voitovych <yaroslav.voytovych@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Brian Gix <brian.gix@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: MGMT: Fix Read Advertising Features hiding instances
Date: Thu, 26 Nov 2026 17:19:33 +0100
Message-ID: <20261126161933.923041-1-yaroslav.voytovych@gmail.com>
X-Mailer: git-send-email 2.43.0
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

read_adv_features() is meant to report instances 1 to
le_num_of_adv_sets and to leave out the mesh instance, which is
numbered le_num_of_adv_sets + 1. Instead it compares each instance
number with the number of instances, so an instance numbered above
the current number of instances is left out: with instances 1 and 2
added and instance 1 removed, for example after its timeout, instance
2 remains active but is no longer reported.

Compare with le_num_of_adv_sets, as the comment says.

This was found with mgmt-tester while writing tests for advertising
instances, and reproduced in QEMU with a new mgmt-tester case that adds
only instance 2: without this patch the reply lists no instance.

Fixes: b338d91703fa ("Bluetooth: Implement support for Mesh")
Cc: stable@vger.kernel.org
Signed-off-by: Iaroslav Voitovych <yaroslav.voytovych@gmail.com>
---
Tested in QEMU with a new mgmt-tester case, "Read Advertising
Features - Success 3 (Instance 2 only)", which is being submitted to
BlueZ separately. The case adds only instance 2 and expects exactly
that instance in the reply. It fails in 3 of 3 runs without this
patch and passes in 3 of 3 with it, on bluetooth-next f57f78086ab5
and 5063a0717aa2, v7.4-rc4, 7.3.6, 6.18.65, 6.12.119, 6.6.163 and
6.1.193.

No other case in the Bluetooth kernel CI's eleven testers changed its
result on any of these kernels; the CI itself runs only mgmt-tester
and mesh-tester for this file. No test has a mesh instance present
during the read; it stays hidden because its number is
le_num_of_adv_sets + 1. l2cap-tester hangs on 6.18, 6.12 and 6.6, and
iso-tester on 6.12, the same way with and without this patch; the
cases after those hangs, run separately, give the same results with
and without it. The same KASAN and lockdep reports appear with and
without it on 6.1.193, and the same lockdep report on 6.12.119.

The bug also shows on real hardware: on a QCA9377 (USB 13d3:3503)
with Ubuntu's 7.0.0-43 kernel, Add Advertising for instance 2 alone
succeeds and the controller accepts LE Set Advertising Enable for it,
yet Read Advertising Features lists no instance. On the same hardware,
with this patch on Ubuntu's 7.0.0-44 kernel (whose mgmt.c is
unchanged from 7.0.0-43), it lists instance 2.

 net/bluetooth/mgmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index d21538634bc3..01969ab57339 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -9074,7 +9074,7 @@ static int read_adv_features(struct sock *sk, struct hci_dev *hdev,
 	instance = rp->instance;
 	list_for_each_entry(adv_instance, &hdev->adv_instances, list) {
 		/* Only instances 1-le_num_of_adv_sets are externally visible */
-		if (adv_instance->instance <= hdev->adv_instance_cnt) {
+		if (adv_instance->instance <= hdev->le_num_of_adv_sets) {
 			*instance = adv_instance->instance;
 			instance++;
 		} else {

base-commit: 5063a0717aa238f5242bf6b4abb8ddc1741ce682
-- 
2.43.0

