Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795758381;
	b=RwR/981xsXmesdPkBccvizY/yVPCiRMa3zerQCeim97pIoKlYjbFlrfQRM9S3YLI/96z
	 ENgiIvL27QAOtJN/rUyS1BdeUSPbxdb7Kic8LDe6bsa9PGrfXKa2Y+CehjHhV5MHx9b8j
	 r3vnydXXCocjFu7pKzX0C1oKeAAdpSU5wu8O7xZ7Z4iuPnTSM5rVoe1s/262Tf1itdgZD
	 3poLBw/3TCBfZ2lSYtXXQWR+XvNJVas/uvb9/VEAvut5nwRXW8kp7YkRUg9MDiFrxVLgG
	 1vEjkeB+HaUZOKBBiskSx++p6xQHIWOfwkfFissPT1Gax8NxpJ/aAsmb/kJ8mwG2KfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795758381;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=YOHpqplFlVfJNy13FxasUOkItKPxCrPvd8D86/g++Rg=;
	b=I2cXoeZkl+BEV+jxW/ANzHx26zAw8A5w+UcUcQMAlQvc4iVuQnbsfgxImogOetynaOAC
	 MpTUax45ZdFxyKgEjmMPC1m68EXGK+pOtvdQWqlfaHi9FxAVHRg4cP75QjMWqugndSM2T
	 x4opta/6RZkWfKOF9sLeZanE2PA8eQN1Cm3vRJSAJQiGLTzx9EByZwJAJaTm/5LRV7Xz0
	 hibRIfoHXQDcYu5/Yphz2saOsGsoYpDuDeZ/96BXCxQSG8aY6OqxXZffqs6T9HC5NmYPl
	 DT3fqgKGffKyQ1CofAHSPqk6nO8SaAcdIIikfXyjiFm0MJv45ml07XcypfGdBndh8FQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I2RQEd3r;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BF4606A31E
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 05:46:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70BF4606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I2RQEd3r
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-386c71feeeaso4182655eec.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 21:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795758380; x=1796363180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YOHpqplFlVfJNy13FxasUOkItKPxCrPvd8D86/g++Rg=;
        b=I2RQEd3rBYQ30QHWQ1h13NVe3n9QTHLN3qJdj6ynNOiSCMRKYoBvap9wyspD7YEozF
         PRpEazT1pah5khrGzBWHfsHVsMulImuu4fvx8A1WMx91tqrcwpo/N4+GWoszzY49yxcu
         FzANP0MsfuGTVEKj7sRFkoIUdqgGN7yXJYMSq8dtF+sGWDgIsYZ8jb/C5kqFIUo1daPZ
         yNcXiWCX1trdCMgCQR5lutzaafk16DljGqYfNyfq99Ex3ScOgyZmsXOTCQtepU3hXNU4
         hgVlfBnkk67SLMUfEXFWisA8sGby9+g5+s0IErqUMOxfvzP7+TzeyF0qTRidCoTaKF8J
         qm6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795758380; x=1796363180;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YOHpqplFlVfJNy13FxasUOkItKPxCrPvd8D86/g++Rg=;
        b=FDacBVR93D6vifquHGgZClipYuXqa01DQuS0pHL9AaxtezRU4by2MGk26P7fQaJWsd
         sHM/gflQoHfFczxwfYDg5u/xPx/5piQTjqwzq9CRyhIWZz6c+eOz5lnxSA+Clu8Hwrf0
         HHvQcrm8CnhULlDkXKXlCoY/TaaOZoR6+XisE0182t+rnXJGvqlwL8FAPX13dPLV8Z/K
         MVPHghSC+tZt8/FFQKQmZ8U9V7SEIUhDOpFI5faWlwK+BCbBfJa3MkdAJgeR7mSAgR8w
         QuLkLbuRcmruEVMm23sNTuxhKnrHR/Xkcb76jFryRh2c9Mi43kp/a7ZoxQtR2SshGI21
         FuDQ==
X-Gm-Message-State: APuU4Z9ch8Km5WcWp7UHqers1zOjYpYHSlvP5Kig+pjsbGcnOrseHBlE
	ugSQ0K9+FJsYTDVmoeFNrKB8IyqMJF02eAyhzFR3mDwkwsz8CcrDbqemNyHYAC8NNyw=
X-Gm-Gg: AZFdTZfFJEdgxjlQlKQMByGgyW3jtaFaadgE0kKD2MtYiFtMK8G+G97k19LdPLCOwWT
	/qVhhsZmvfMugMoKfEo+DMUFDHiyEJl1l1H3oRcZqDpYbAt1HoyQE+P7y94XzrmWB57/49V0QWR
	+zdjDQaGCZa7THk+eSwNurx4prbrI1aXBZwTnXEcWYBBA3gpWfgi61AIFPDNN0BZmz+m1DK9R3M
	mEaQkJ/3xsQKacOFDu9fXoiGQmSdXa/qkCVGZ1LehTd5+30HgvTTKaf9ZgxIauShcg5UgRyeCiZ
	wAVPQB58K1O+fnDLv8rmJDjOgTAYlgyipVIrgsyVXvdt/LhlRKePnGLps8LY6UsaXNVlFEDWRO5
	iLwQPEkJSyefrs8vQWDJoTMftIObPOMpPSjAMr7NlCSG9frAO1ipD8iy/N2E1sIPmKwiGMtfF69
	Y0DNP7LO4oriG2vGhg9nbIwVxmXScou4AoJ6VMXvMltcz/QG+oVnxIL5YPG/dV8SsCKv7LaI8f+
	fwICbbAMB6UHuab2kq+QjyKBERa2BiqjMP5z1/QIYF2lxcSWZaoVie/Wf1EUqllLlZTvfHIGzA3
	vbYmFkbnvriJW+evvsEUj3x97rV42A1JkGJ52YUZdyTNhbFUuwz9619s7MiCIz02dQjtAptwc9J
	ypg0Bw4KSB6RzGie2vkNh
X-Received: by 2002:a05:693c:8211:b0:36f:202c:48 with SMTP id 5a478bee46e88-3857045092emr24740221eec.14.1795758380338;
        Thu, 26 Nov 2026 21:46:20 -0800 (PST)
Received: from localhost.localdomain ([96.44.128.241])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385672c6f31sm67002146eec.15.2026.11.26.21.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 21:46:19 -0800 (PST)
From: Weihong Guan <weihong.guan@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Kyle Pepper <cochcoder@proton.me>,
	Weihong Guan <weihong.guan@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH] Bluetooth: hci_sync: Unfiltered scan for peers outside resolving list
Date: Fri, 27 Nov 2026 05:45:17 +0000
Message-ID: <20261127054519.3146135-1-weihong.guan@gmail.com>
X-Mailer: git-send-email 2.47.3
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

A bonded peer using a resolvable private address is connected to by its
identity address only if its conn params carry
HCI_CONN_FLAG_ADDRESS_RESOLUTION. Without the flag,
hci_le_add_resolve_list_sync() leaves the peer's IRK out of the
controller's resolving list, but hci_le_add_accept_list_sync() still adds
its identity to the accept list, and the passive scan runs with filter
policy 0x01 and address resolution enabled. The controller has no IRK to
resolve the peer's RPA with, its advertising matches nothing, and the
connection never completes, though the kernel holds the IRK.

A plain connect makes such params: hci_explicit_conn_params_set() adds
them with no flags, so l2test, or bluetoothd's Device1.Connect for a
device it hasn't added to the kernel itself, waits forever.

Scan unfiltered for these peers too, as commit 397464709a20 ("Bluetooth:
hci_sync: scan unfiltered for host-resolved RPAs") does for a controller
without LL privacy: the host resolves the advertising and connects to the
RPA it found. The flag keeps its meaning, userspace's choice to have the
controller resolve.

Fixes: e209e5ccc5ac ("Bluetooth: MGMT: Mark LL Privacy as stable")
Assisted-by: Claude:claude-opus-5.5
Signed-off-by: Weihong Guan <weihong.guan@gmail.com>
---
How it was found and tested: first seen on Linux 6.18 with a BL602 as the
peer, then reproduced on a Raspberry Pi 5 running 7.4-rc2 with
net/bluetooth from bluetooth-next, bluetoothd stopped (an empty MGMT Load
IRKs first, as bluetoothd does, so pairing asks for the peer's IRK).

Controllers: as the central, an nRF52840 dongle with Zephyr's hci_usb (LL
privacy, resolving list 8), and a WCH CH583 running our open HCI
controller firmware over USB (LL privacy, resolving list 8). As the
private peer, a CH583 or a CH571 running the same firmware's BLE 4.0
build (no address resolution, so its Linux makes the RPA in the host).

Steps: pair the central with the peer at its RPA (btmgmt pair, Just
Works); the peer moves to a new RPA; then
  l2test -n -i hciX -J 4 -V le_public -E <identity>

Without this patch (nRF52840 central here, and the BL602 bench's runs on
6.18): not connected in 15 s, resolv_list empty, the IRK in
identity_resolving_keys (the kernel saw the new RPA). With it: connected,
3 of 3 (nRF52840 central once, CH583 central twice), resolv_list still
empty: the host resolved the advertising. With the flag set (btmgmt
add-device -a 0, set-flags -f 4), the resolving list path, unchanged:
connected through the resolving list on the nRF52840.

Related, not overlapping: Radek Podgorny's "Bluetooth: find an RPA peer's
connection parameters by its identity" (v5) changes the connect path, on
a controller without LL privacy; Brandon Williams' "Bluetooth: hci_sync:
Reprogram the resolving list when a peer's IRK changes" handles a stale
entry, not a peer left out of the list.

 net/bluetooth/hci_sync.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index ee426ffea..7ca7676ae 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -2893,8 +2893,13 @@ static int hci_le_add_accept_list_sync(struct hci_dev *hdev,
 		return 0;
 	}
 
-	/* Host-resolved peers need unfiltered scanning while awake. */
-	if (!force_filter && !hdev->suspended && !ll_privacy_capable(hdev) &&
+	/* Host-resolved peers need unfiltered scanning while awake: with no LL
+	 * privacy, or not marked for address resolution, which keeps them out
+	 * of the resolving list (hci_le_add_resolve_list_sync()).
+	 */
+	if (!force_filter && !hdev->suspended &&
+	    (!ll_privacy_capable(hdev) ||
+	     !(params->flags & HCI_CONN_FLAG_ADDRESS_RESOLUTION)) &&
 	    hci_find_irk_by_addr(hdev, &params->addr, params->addr_type))
 		return -EINVAL;
 
-- 
2.47.3

