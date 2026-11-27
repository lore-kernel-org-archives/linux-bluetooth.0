Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795805455;
	b=aQMD37I1sc8EO5UmTmWIVUtSq6HS+qYlg5JKMZrE3RKYuqgsPij55wiw5CPW+EZZ6ILX
	 IKKeVOZEBs0xJlDUP3yRKXl9IK9JD/tBgyP/MRbnS9oDv64Q1AQcVkkIxf6934uXmcKaV
	 B/YFuvsR4ZxhJ7LqkBJ4qBcjxV8e5mvZUeoOyDUIRy3mq+UV/lmBBYR7t/SQun9yVXGYR
	 O/S9JVEgvkr2jSTQjD9LwulOxy6DupLaajYNvj3YaDqfvaFUlw96a3778us7qopWMzjY1
	 tJILc5L2k6bQSbOMI5Qs6XsnMR4LDP2j7u5zkZ918X/7f9utv8IshdoWrPcqsHzFPWw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795805455;
	h=Received:DKIM-Signature:Received:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:From:Date:Subject:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=eDWfZws5sneXeyP6GwoVDYB3oqWDws2mo5yihewfqY4=;
	b=G0UKgsa4Va6CLVydiZZrYvbDnw/tRehGdbxyJMo6day2j3v21N1lbJL4apl00nl47r5R
	 lo8YgQKWO/tRi8+eJlezXzs95c5rROInamv4yto4Dau//UWq/BSM8hizN0PkyBhao9ily
	 HXioCk71nlZNuPV0nQ778p0sL6v24dHDZvC+W/OjD81wu+ya7uLefogXEPcu037Y2BACr
	 kI5zezhnVd2Tx95fDhNiDu4zNhGCzYA8dLPARDMGibRBWV1CgcPB+Cl5UEZeJPRgoBMji
	 mcLQrSBI6qpXCQZTrinEMQ8e1pOgJNWh4lOmMxton2xuFymbIt2x5J+vp40EY3MEvQA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="l/EcS9/f";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A70606A31C
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 18:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l/EcS9/f
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795805455;
	b=H/GCOS72HdF52pNSfHfHAsp+8xDar1zGdQAgVFXNGr1I70/Pm8tul9tAeE2Ltl3Pp3VL
	 J9chSXuDBhSDc3dexwbsgNA2OKNQPYKh/oifY6RskM4JSHQRrLS4FV0HmyvVwMCDWLy9V
	 AswDseyXHRXfe4eT6tcyV9BVSdZJDd1rYFmC0ue5I3g05r+uOlxhQ0BtXgY+XGyS6lgh5
	 eqJTgIqJlQ8nGUqx4ZT62076s2x73i0U9OObmnqSY14UXPPI6DsYZ62QHaNFT9aefn2Hp
	 Hu/G+a8pjTDJNMPSQaYljP66psmyt0SiwlESTDSDSGQFV6Xt+T2jfWypqGYbKFJwcDQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795805455;
	h=DKIM-Signature:Received:MIME-Version:Content-Type:Message-Id:
	 X-B4-Tracking:X-Change-ID:From:Date:Subject:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=eDWfZws5sneXeyP6GwoVDYB3oqWDws2mo5yihewfqY4=;
	b=srukHFspmWRrjGl+kxC767osP1Xe7mMb0C/yZd7ZwZmTUM9VxWjGZGLLtQCtpGabH98H
	 PLnfjx1aUecXR6AT+Vthk2khOCtQJT5Qn0IxP6Eh0KupbdEm//gRjB6cthOoO0Vfg3YAC
	 wQ8CCJRxtybWeYjQjEUvNCv/cz6QfdGL8r5OZ2QhIGYQX1uc7YkDnFueCYhZKWIWQlBoj
	 T80Smg2kiFdP7W1VIwxfJiMl2wI1OdzGsq93+gxhtxVuXPCca0P5qQAy8HW20xktTauz4
	 mqWMD+sEW0yKJr2CJSNOj/7EuBs4wKL5XjXr4Dcf9tBVXVipmFC67bBNaT6PBDw6DlQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id BC0181F00893;
	Fri, 27 Nov 2026 18:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795805455;
	bh=eDWfZws5sneXeyP6GwoVDYB3oqWDws2mo5yihewfqY4=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=l/EcS9/fs1VGXvSHa7q7Y94NH+rG6jqA/xrp8QkHQ0YRiwftoZ6pdlust+hfBtRM+
	 mRv6hp2KZAgo7wUsepo1z1veswz1KwMDfzaQNPpYCxKM8Cts99oGNxFvEsFK+VR4fo
	 4pW7FsNJikgUepY6D4wnFfD7cxGWxb0pHxjS8XAR+XUAXNffTotwoHHuMOIsGxh3yh
	 g1KOpSNxzPj4XNNYMSO+10zQzdeUaB8+hmBwVL/Oq3Rc0xJ5JBi1B3XRNge1gahb1k
	 5FjfMIHbrC3n4+PCMTNLOYC3s7iNVDDDO/EA65E7hABCj/Cu5VBh2JYAT7MLWMgNus
	 X+DZEv5apzs6g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 4B76D4DD1C;
	Fri, 27 Nov 2026 18:50:54 +0000 (UTC)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261127-bt-inqcache-v1-1-9610f88a2a49@certik.com>
X-B4-Tracking: v=1; b=H4sIAKXPCWsC/yWMTQrCMBBGr1Jm7UATQalXEReZdGJGSqKZVITSu
 5vo8r3vZwPlIqxwGTYo/BaVnBqYwwA+unRnlLkx2NGejLFnpIqSXt75yOgNT2GcJ6ZwhLZ4Fg7
 y+b1dgZaVa841wu0f6UoP9rW/9TI5ZaTiko9dKae51RfsHvb9C3WxRdiaAAAA
X-Change-ID: 20261127-bt-inqcache-c1e9f0d9ebf3
From: Dickson Wu via B4 Relay <devnull+dickson.wu.certik.com@kernel.org>
Date: Fri, 27 Nov 2026 15:46:47 +0000
Subject: [PATCH bluetooth] Bluetooth: hci_event: Requeue failed name
 resolutions
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Marcel Holtmann <marcel@holtmann.org>, 
 Johan Hedberg <johan.hedberg@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795805093; l=2025;
 i=dickson.wu@certik.com; s=dickson-b4; h=from:subject:message-id;
 bh=7k2grbbT9bxaYWonzyj9mudhJSGr/nMZ7k7ShM0xQpE=;
 b=jG3DeROsDqtMrLtX/K8GoqCMToeXzflfF+imPHl1BhEJP4g31q1SBmDsvVrweK/A1LnQiTjs1
 jl3dI3jr9FmCjat+xEnFcwDYrZekljx0SZOIyX47IPZEcAsG/ZXlaaH
X-Developer-Key: i=dickson.wu@certik.com; a=ed25519;
 pk=fxH7FS4FdojeJSGLJzgKdfO51Rvr4EW30yinj2mc1vg=
X-Endpoint-Received: by B4 Relay for dickson.wu@certik.com/dickson-b4 with
 auth_id=1647
X-Original-From: Dickson Wu <dickson.wu@certik.com>
Reply-To: dickson.wu@certik.com
Content-Transfer-Encoding: 7bit

From: Dickson Wu <dickson.wu@certik.com>

When a Remote Name Request fails, hci_check_pending_name() removes the
inquiry entry from the resolve list and changes its state to
NAME_NOT_KNOWN, but does not add it to the unknown list.

If an Extended Inquiry Result later supplies a complete name for the
same address, hci_inquiry_cache_update() treats the NAME_NOT_KNOWN
entry as linked and deletes it again. This corrupts the list in
hci_rx_work.

Add the entry to the unknown list after the failed resolution, so a
later result unlinks it exactly once.

Fixes: c3e7c0d90b14 ("Bluetooth: Set name_state to unknown when entry name is empty")
Cc: stable@vger.kernel.org
Signed-off-by: Dickson Wu <dickson.wu@certik.com>
---
Reproduced under UML with KASAN and a vhci controller, on bluetooth-next
f57f78086ab5 and on mainline 9437ee8b6cf6. The sequence is BR/EDR
discovery, an EIR without a complete name, Confirm Name with
name_known=0, the Remote Name Request failing with page timeout, then a
second EIR for the same address with a complete name. The second
inquiry was started with a raw HCI_Inquiry from uid 65534 with no
capabilities, which hci_sec_filter allows. Stock and with the patch
reverted fault in list_del() from hci_extended_inquiry_result_evt() in
hci_rx_work. With the patch the guest stays up with no warning. The
reproducer is available if it helps.

This was found and the fix prepared with AI coding tools (OpenAI Codex
agents, with review by Claude). I went over the analysis and the patch
before signing off.

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index a9b6a6ccaa03..c767e8d32217 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2582,6 +2582,8 @@ static void hci_check_pending_name(struct hci_dev *hdev, struct hci_conn *conn,
 	list_del(&e->list);
 
 	e->name_state = name ? NAME_KNOWN : NAME_NOT_KNOWN;
+	if (!name)
+		list_add(&e->list, &discov->unknown);
 	mgmt_remote_name(hdev, bdaddr, ACL_LINK, 0x00, e->data.rssi,
 			 name, name_len);
 

