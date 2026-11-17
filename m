Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.6.130.215
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794882961;
	b=LDfMBLDiA0h2EZQIJ/MXGk+Q9hfqtwbq6V5XZRh85nOz1tMEO4s0EFIIa6KlNY4V+Ek4
	 XFsRHOnFupBDWRDc43DF64+GFlVO9fxr706pNLy/ss55GV2e74A7qdypTgUPSkj4wWtsF
	 qcXTi2Rt85kOlW3gN4UFzEAbef9l4c3slGPjY8ZWNSthbttwoR5jipsrjpqh1Pca9HMia
	 MXnhVpqEBdz2S1xISkkg13WZ+01TlOrnTezlgLXFe2b2gJxkt2oD/lrJZTo7fycloaQEn
	 rhih4cpcrOnBBXS6rXqJv99uoohlMlgMWY7uUlrv4mDEgvMsjdVRLYdYXEdc+ptRIYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794882961;
	h=DMARC-Filter:DKIM-Signature:X-SONIC-DKIM-SIGN:X-YMail-OSG:X-Sonic-MF:
	 X-Sonic-ID:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0m/5H8ekHXmYv8Sp+ayayrocCBe6rLWYJaFS2F1QzQc=;
	b=y4FSN+N8CFBynW1YDiIolYMkPosH3xEHKo3K8JT/SIKE31mIEDFHfpQAPJ3A4LOwt59D
	 dhUgZ1JJr4r36uGHl2TokuQzJRmjQt1jUX2xHrhx68raNN9rh3qhnQeWtz0pp/VebiG+o
	 RjMyId4a/pRnda0pqVzMn5Rj24WNTkIuGUaeU5pVTewh0ip+ufbV+BD+dwdW+Wv1aV28f
	 oXPzwN8qmYFLYyE0e0fZJwTu+LLIIWq2cScKklyQMV0v/8V8/tzU3rKjbOU0rbeMHeRbX
	 noisGgdkyHhVY5XIc8Fty2Tjr8/g6F/Ji/P6a2wEU+OBIfRsNU5qZE+uAC1hWGHRXhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yahoo.com;
	spf=pass smtp.mailfrom=yahoo.com;
	dkim=pass header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=aUkLGuwB;
	arc=none smtp.remote-ip=74.6.130.215
Received: from sonic316-41.consmr.mail.bf2.yahoo.com (sonic316-41.consmr.mail.bf2.yahoo.com [74.6.130.215])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE29C606A336
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 02:36:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE29C606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=aUkLGuwB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1794882959; bh=0m/5H8ekHXmYv8Sp+ayayrocCBe6rLWYJaFS2F1QzQc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To:Content-Type; b=aUkLGuwBGVVes6CuV+oMrqgKsUZ8QEwZbLqxQoxsFPRrEBuq9lauGPxVibiba43Oewjiyq58OuD2tuRgH+nUzLaiqaifGlp9ZdAQug0f5O6UJXxFGjA2VR7ZLSsPAfle1G1f966S3fEQVD6X830/ozf19PUspi8LpIjtTMSNSTnKklDkgOilawafKkFR5oAYomuMoA7xOollU7ozUFIEgKMRzDvY8Q6+KLesC/jEbNzMyjeqDjlCA3qpSWR92RhKmUZ70EDHdpkSDFJPDus+4wwtJhQVlbVgRW4T65Oicmc+r+jo/83EIj7SxSKwHSIorb57d+kcPtfjDPXBiLma2A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1794882959; bh=DPESRh349sjMqgDTgq+cDRn40T9D1npF+4O4zyKqdwp=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=WgEFl34gP50RzRHRugblsStCIvQwtY9+U1UOMzuE1XxKDKO5i/EqSfRLKVgi0BXaE/JrqTMQBv+AN9GBhMWDIwnq7Y/0WWcsXywgT8awCgoR6fnI1Zd/JW50+px8aO50Ey4MKXiRifrVZ6T5hFDbFtpr5PJz6+T8t8t1I5Ucj8H+f37iWcYC0sGb9M0UwSPwubmib/RIC4LLlwRSc5SvMjdSMxg4oyHSrlB8U8RhGOT2SwtH9aIDa+Bbbh2yFPzuAucBm+FkCIuqlLjjSCEHi58kxRsmCnCDA9HnZ0aoDtOw5GN4JEJZdbdSbE2ERHGUPb2NsAMlFP8JYuWAvqpEuA==
X-YMail-OSG: SR3THOUVM1lpMD4Y4NNC6TNYILf.h2YJYisaJzrYc_kPukdosJgHNjMyaamvbpj
 mvmTxykqX3raKqteQSJtOpQdLoED27TfkpUSH4.YiWHb7KMKHnZMTzxk.i4XVVH.3pCIxRNH2lme
 .TEHYlj7duN3AwXuqE5QuTBFQ5FaLaC8fBLj2MSZt12Kc3BAkQ0i2poi68y40CBMKzMI19zrlmdI
 xYDbqvEJXMWwFRPdqrm8S79MoRuPbLLPq8xVyThmXFkmd0radUKfi8aVjUbqR7aulLjXNeYhEZX1
 nhb31KqluoJFQWeZu.jF.Qi.ahkNKj5QKvzXyopSaR7DoyETrjm_FRXrs7TzbuJ9.zXWFg49SVlE
 hO7kW9Z7ye3kJpZx8NyfiCzQHvkndx5_mUQuLmXfHIzmrpioEdrxJ6K2GKmm2erIVtsyUlQz8fyz
 uVCEMH1rFu4_mnq1mnDmLtqC45BCXkpRgoJktUTVG2WpRDJDBOjVQVI081F1NMjFodu6Vo2eq27J
 .6VLkYpWBRuEvXAU5.4VaeymlwsAqsG1CiBFi1UzKV3AQOlx.RUhhunfzArfaVY.G5gPzZJ283N0
 KatPMInZ4FDUbpmKrYck.MOUJ0KDUHXQ7GXLsnPwrxe2vqCw4gU5lTH8xrC8lLExq9BB4xrsaevl
 Aqxk3lI4eZYSNKZHoXeHUOnYPh8qoiqtT4hb3.0E9xXK6EUwi2MMC2WUSTbs1nOEuZGug5vus4e7
 kht4nit1cl4FhppGOwNmta7rk4b3ByMIhjLKANuzTvedoS0wVOIyfGUuG4Ex40_Fs.oAraRe.Qrv
 nJQJOgoWSYq5gMvKj9HG0c.B3c_r4obGUbOZ9VYHHksykgL0p8MnJgJvI_RL8shnS6rqAzZWrPX1
 J67BbmHZgeisQ46inGhXQYG9yLRPNHT4aGjq.nO6k0ReScue9iiaOWWy9ZtouM9WpbGGdnHlwQpI
 z3ZWCdoNRuzr5lCPVDoQR.zvGkFVzzuLqE54eRfhcBj63FK0E4M0CyEqgpvtkNQ.tAec97b2V_zH
 deAeAfqOUdDkJSjCG5.28jOtM6GsrOk5yz4zh.M9sXi7VTpSqyvhWb0n2IjywkypOf59oYp7gaVC
 MY5nCn6LdG8iMAn.ekis_pcxx.4YtyN.zbeLhl0lckjRvLv.B.HnPqrz1C3TK.FgVG7x..a1o1Q1
 Q_g2W439gx4vCOfmME0.TtcEMIwrCJJMXacnoOlGXL7PlDIagtekUNO2.NHDuGuYrrDXQkc.60Os
 l73u7.UsM7zSZ0D5CAtU2_T1m4TZchU_uDG7Ue9BylA1UbUWWpyR0XST2CYI6Qz1_U7adcOb7rGU
 6Bm_ULlA13yhqwGqY02PDUiD_8f42Xcf63F2K4R0.VImGPgYu3BNqrxyIek0dM2jjKQEDP4VslmM
 XDQiw8LaqvMwqOYuyWxzzmsqKKLngDCYP.8KFN3L9KMDd3iV7.m.NFLoEzakOAaXJm71NvnEnevG
 Wm1dlsDJLAbvgzAJPgzPbgSezBJg3G3sVeyk5JfmyyLCjo0g2gGBmhbhcbOUXJKHHWheKBLLwYYq
 lRYTW69JtlpPuiMkQMaaa1qC_s.CseIVRpTTtJEOXLlh6IzTIE6yZy_IEGWM7pAR6rykDRUeK9rY
 gm2Wa8DosKgOmrawndsFeI62UitVl3Kt6_kMClR2HSi4zf0dLJs65O9NA1GjcVj1UOZ.gbHYuWdZ
 aEignzhf9LTUhcLW_5d7zvICxRqmxdgd.5Jz7i1aDeri9DDrDsakBhjVtDovbEwOMKaedcbB2Woq
 uRjfsbxwfsPwQ4OiKvYq4VMUKfBNhTM7HLF4Sd5_z1TXNMXishA9rybhkD_MRJgsyX9lsgu.cb_n
 NMYFcFhPiH4.Yj039Wk_e52l2e3nfGiwnch7N5PpLFHpzwDI4zU3BqMOHYQ0agYDTNzaFZe.nqld
 Of74uffPBbVymsC3x14ZXzYy0MrXaRnN0.FpDH6I31yC0zbvm64ukzZ4G14jLMwgNwQ6P4c3qVje
 uHFrimmyuzi5XTZ.2up_Md5QkjcxtswEhfPH1HET3N0p1Ru0usztQsKpU5A9hT7NZ72AX79UjZew
 5bAPau57rU0BTjsBKaNwNRlByM6oF.m00mSH8QaHD0As_Mibl3khbYOI2b9vgvvlm3FmzmObkEqB
 U5yDUmlEEA46OMbliyeA3Pv_Mii763sqZJ4nimE0vSOeZR1ZHEGXR__97p16At1YA5NGntTWSkNE
 NVzg4cBcJYAIqcFkvlP55xpCkFxX0Lp_fHajf9oKGDn2zp3b.fSh8hQwHWrANad9tDqS6YFaQbp1
 IiPQ6flfMoAhKn030zBT4ucBvPLOMx42birEMKh4_rw--
X-Sonic-MF: <deaner92@yahoo.com>
X-Sonic-ID: d4352def-b281-4e2b-bd48-af4ad0423722
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.bf2.yahoo.com with HTTP; Tue, 17 Nov 2026 02:35:59 +0000
Received: by hermes--production-bf1-6d6877594b-c5dh2 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 6b4a44673d94ff3e2f092b66bff98f7f;
          Tue, 17 Nov 2026 02:33:58 +0000 (UTC)
From: Jeremy Dean Clifton <deaner92@yahoo.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	william.xuanziyang@huawei.com,
	johan.hedberg@intel.com,
	hdanton@sina.com,
	Jeremy Dean Clifton <deaner92@yahoo.com>,
	syzbot+5897b3c764f5989ea942@syzkaller.appspotmail.com
Subject: [PATCH v2 3/3] Bluetooth: hci_sync: Disable connection works before draining
Date: Tue, 17 Nov 2026 02:33:44 +0000
Message-ID: <20261117023344.278269-4-deaner92@yahoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117023344.278269-1-deaner92@yahoo.com>
References: <20261117023344.278269-1-deaner92@yahoo.com>
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

A connection delayed work whose timer was armed before
hci_dev_close_sync() can expire while drain_workqueue() runs.
delayed_work_timer_fn() then queues it on the draining workqueue and
triggers the "cannot queue ... on wq" warning. hci_conn_drop() can also
queue disc_work from another context during the drain.

Disable the per-connection delayed works under hdev->lock before
draining. A disabled work is cancelled and any later attempt to queue
it fails, so neither the timers nor hci_conn_drop() can queue it. The
connections are deleted by hci_conn_hash_flush() below, so nothing
needs to re-enable the works.

Fixes: 76727c02c1e1 ("Bluetooth: Call drain_workqueue() before resetting state")
Reported-by: syzbot+5897b3c764f5989ea942@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=5897b3c764f5989ea942
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Jeremy Dean Clifton <deaner92@yahoo.com>
---
 net/bluetooth/hci_sync.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 931494348325..3fe179d649d0 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6012,6 +6012,7 @@ static int hci_dev_shutdown(struct hci_dev *hdev)
 
 int hci_dev_close_sync(struct hci_dev *hdev)
 {
+	struct hci_conn *conn;
 	bool auto_off;
 	int err = 0;
 
@@ -6079,6 +6080,22 @@ int hci_dev_close_sync(struct hci_dev *hdev)
 			cancel_delayed_work_sync(&adv_instance->rpa_expired_cb);
 	}
 
+	/* A delayed work whose timer was armed before close would queue
+	 * itself while the workqueue is draining. Disable the connection
+	 * works so that hci_conn_drop() and the timers can no longer queue
+	 * them. The connections are deleted below, so nothing re-enables
+	 * them. HCI_UP is clear, so no new connection can be added after
+	 * this walk.
+	 */
+	hci_dev_lock(hdev);
+	list_for_each_entry(conn, &hdev->conn_hash.list, list) {
+		disable_delayed_work(&conn->disc_work);
+		disable_delayed_work(&conn->auto_accept_work);
+		disable_delayed_work(&conn->idle_work);
+		disable_delayed_work(&conn->le_conn_timeout);
+	}
+	hci_dev_unlock(hdev);
+
 	/* Avoid potential lockdep warnings from the *_flush() calls by
 	 * ensuring the workqueue is empty up front.
 	 */
-- 
2.43.0

