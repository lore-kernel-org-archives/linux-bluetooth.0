Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795520415;
	b=aJFDL650zXmeSTrPmaOyzVOObhpWcUC/b73xmrS1RYSmuhK/m90D4xstvda/woMdLJZH
	 RMB+jTJQsf1jAv51NtOiokBrOEkfxzCLfGLZX7ftylG5XJMDfrg6OX5dTCRa55wde0L0g
	 +WoB36lUyn+eedpqqwsYwhB8y5MHoEomjSlBv+uooenQ+HQmlZSamy+DdIIPPHGasjIfm
	 EvI3vn71BtU8ZbglhNV6rCca79YDedjivOcByiD7aycrX/F9NhKEvqtCpK9Qu5UiNabK6
	 PIjVs8Pty6FmSE5p3G7leO1LYN591oxiUHO1LVrJamhR2WauVhY6MTE2chO4S6dskrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795520415;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=0Zp3jHOV31NIj94DCngdzooB8/E9Q/YUvZ02W/fimHk=;
	b=dVeCwkjtapvS6W5a0qxIyoEDsy1ZS9kqC0EpdW8LvSRo793cYr3fp+RyzCuSFDRfx03M
	 4khDbBcDuiXIMjQueG6qC2V/19Ch+NUWCkDtG784KLOeJFav/vIpFDg8aZDqIMhGWmm5i
	 G2kG4RYl+t9sYCVujYqbWSgGcE8h5Uk89OldieTQV+liDpDriL050nCgRKwcJPoQQ7G3z
	 i5K72grIdlI77ZsBbSZahM8WJRP2UAVUnni6VAPOiJhsOv0D+LHy/pqU+wjBXRv9cqQ2A
	 +IEKJgHmmwKQxJ0q8ACD9jqXTG4pn14ijr0S+Pze+09g5pccH9ikIAe1d2AbxypCG6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=y6oAjVkD;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA8A606A31E
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 11:40:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1DA8A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=y6oAjVkD
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4bb68c197c7so55899945e9.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 03:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795520413; x=1796125213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0Zp3jHOV31NIj94DCngdzooB8/E9Q/YUvZ02W/fimHk=;
        b=y6oAjVkDqjoL2gMYSO9fUlAyBXyqLOMJEXRcJtKtjnfBWq29VafsbtBOr9fNEQvn1R
         tz8AP+f1fV3o4VvNUpUYPefpJACPcB7kexppBKvmH3oLMVjxgmfoeYyvJDIwZoIoCe4e
         pbtncVeOsXwV5fCKTrJ1C99Ap7ArDSbg4Vwx4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795520413; x=1796125213;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0Zp3jHOV31NIj94DCngdzooB8/E9Q/YUvZ02W/fimHk=;
        b=Nz9/m9eAluZG6t/FGDuhmP7+cOHXvNWbRaP0kNbBJHtDOaTv1uKIdvg18RqAZc1MHX
         NahEBdIOLpHhZST6CHb2jjsVFRKBLbQ877TEG7v7u8dt3Qw4JWCluoh8vOM18LC+UAUA
         kTMxDum0A1A3Jpbsm/wgXxu7i/v28nl2N8sjM7LTdTHWngaCNRJEuXW8RSQYT4XX/A27
         Mb9AByE/iXzwXrkkrhNpjW387KqyrCfrDVkg+ZKWEiPASjsmPMMZ5pzPDF0S8Y6T2mJX
         T5N0auUJ0jmm9RJtV6Qz0UvXuLV1NFit1YQA/1WWxzjkv07UI9sNxkFNUDmTYX9LsKlK
         XbOA==
X-Gm-Message-State: APuU4Z+SVo1143YEv1KW5F5w0QNlRKG8/cBmnawJ0dfYiRih9phV8s3w
	YAm9zx5MKG25RXQ029HQjMZrW2kN8ZgbYSRbDt3bmlX01o2U2w9SHcHBBDOaUUhlzcmEZ5+AU2b
	ueGNX
X-Gm-Gg: AZFdTZemKuO0zdO+GwxNWRKirW862l7ZDdBGc4hnpPer77CZTNDURzdOBVWvgAF6mIp
	9OQTLKUwEarIjQb5q3hFXtFEur/t7ZlpzB0pcSRZ2uH1aKloPIH3IjrYj7ZCYEC0csnTTOUcggT
	+dSfE+zcKh/dwjcro6rP6AFKS6Rd3A+b1PbNptOuSxWHiRrJNgSWQ3/V8xaKVswmQKqbO5OMtgf
	FjceKbVpySvd3SWbr5EPGyQc1dHRw9NgT3p+WrZTJHbEWAZPnhP6Huluw/662w6d4t3oFYpzcB2
	sk7pae03lvC5pmg0Cu7HmpClpXTMDC1NICU9dtYz78HvFOdZIcouwhAar/a5GxkKCmwOfH2PbyQ
	8XG/NLY4PTDsqCK4tvv1OwrhpI8x1/PVmOkcRY5JSERakPENyRGj4LzFFeF5Nzp3S0WW3gDlvwz
	XQ8XHCarb3DD2LbqRAeJfF4avwCktpmoWNU1y8R1Qy/2Fa+UZ1kEW/tB3ksmLooggMIrgFzn9+s
	R3xAD/ZqGaM1r9Tn4KRPJ3j0damSg5r4C7lpdBKxD5iKgAzH3txU2O4tKxdoVRvLNablAovvaf2
	Y5/8yWI8Ed+NxZ8KBCfWrN1arM5qMPbqCWLW0IpEngaGI0AukEosPDbAnJDmfoWeFYaj90o=
X-Received: by 2002:a05:600c:1548:b0:4a1:e00b:a10b with SMTP id 5b1f17b1804b1-4bb88800020mr318006455e9.7.1795520413393;
        Tue, 24 Nov 2026 03:40:13 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:d476:8432:c5c5:dd98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853a9846sm506581225e9.11.2026.11.24.03.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 03:40:13 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH v2 1/3] Bluetooth: hci_conn: Fix BIG cleanup while BISes are still bound
Date: Tue, 24 Nov 2026 12:40:08 +0100
Message-ID: <20261124114010.1696510-1-simon.mikuda@streamunlimited.com>
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

When a broadcast source BIS is closed, bis_cleanup() calls
hci_le_terminate_big() unless another BIS of that BIG is in
BT_CONNECTED, BT_CONNECT or BT_OPEN. Until LE BIG Complete the BISes of
a BIG are in BT_BOUND, so one that is closed in that time does not see
the others, and the teardown is queued while they still wait to be
connected. The BIG is not marked as created yet, so it is not
terminated: terminate_big_sync() only disables the periodic advertising
and removes the advertising set the BIG is being created on.
hci_le_create_big_complete() then connects the BISes that are still
bound, in a BIG that has lost its advertising.

Steps to reproduce, with btmon running:

1. Open two ISO sockets for one BIG as BlueZ does: BT_ISO_QOS and
   BT_ISO_BASE on both, BT_DEFER_SETUP on the first, then connect()
   both, the second one non-blocking. That connect() sends LE Create
   BIG.
2. close() the second socket right after its connect().
3. Keep the first socket open for 12 s and scan for broadcast sources
   with another device in that time.

With the Zephyr controller (on an nRF54L15) and a 7.3-rc2 based kernel:

  < HCI Command: LE Create Broadcast Isochronous Group (0x08|0x0068)
  > HCI Event: Command Status (0x0f) plen 4
          Status: Success (0x00)
  < HCI Command: LE Set Periodic Advertising Enable (0x08|0x0040)
          Periodic advertising: Disabled (0x00)
  > HCI Event: Command Complete (0x0e) plen 4
          Status: Success (0x00)
  < HCI Command: LE Set Extended Advertising Enable (0x08|0x0039)
          Extended advertising: Disabled (0x00)
  > HCI Event: Command Complete (0x0e) plen 4
          Status: Success (0x00)
  < HCI Command: LE Remove Advertising Set (0x08|0x003c)
  > HCI Event: Command Complete (0x0e) plen 4
          Status: Command Disallowed (0x0c)
  > HCI Event: LE Meta Event (0x3e) plen 23
        LE Broadcast Isochronous Group Complete (0x1b)
          Status: Success (0x00)
          Connection Handle #0: 16
          Connection Handle #1: 17
  < HCI Command: LE Setup Isochronous Data Path (0x08|0x006e)
          Handle: 16
  > HCI Event: Command Complete (0x0e) plen 6
          Status: Success (0x00)

  Bluetooth: hci1: Opcode 0x203c failed: -16

The first socket becomes writable, and LE Terminate BIG is sent only
when it is closed, 11.8 s later. The scanning device did not find the
broadcast in 5 of 5 runs.

A Synaptics SYN43756 controller, with a 6.18.2 based vendor kernel,
answers LE Remove Advertising Set with Success. In 3 of 5 runs the BIS
was connected as above, and when its socket was closed the controller
answered LE Terminate BIG with a Command Status, then sent 2690 vendor
events instead of LE Terminate BIG Complete and answered no command
after that:

  < HCI Command: LE Terminate Broadcast Isochronous Group (0x08|0x006a)
          BIG Handle: 0x01
  > HCI Event: Command Status (0x0f) plen 4
          Status: Success (0x00)
  > HCI Event: Vendor (0xff) plen 244

In the other 2 runs the set was removed before LE BIG Complete, which
then never came, and the first socket was neither connected nor given
an error.

hci_le_create_big_complete() connects every BIS in BT_BOUND, so count
them as users of the BIG too. They were counted until the lookup of any
BIS of the BIG was replaced with lookups by state. With that, neither
controller gets an advertising command before the last BIS is closed,
and the scanning device found the broadcast in 5 of 5 runs with each.

Fixes: d36349ea73d8 ("Bluetooth: hci_conn: Fix running bis_cleanup for hci_conn->type PA_LINK")
Signed-off-by: Simon Mikuda <simon.mikuda@streamunlimited.com>
---
Changes in v2:
- 1/3: controller named correctly: Synaptics, not Broadcom/Infineon
- 1/3: message corrected: the early cleanup does not terminate the BIG
- all: traces are hardware captures now, with steps to reproduce
- 2/3: vendor statement and event-handler paragraph dropped
- 2/3: unused struct hci_evt_le_term_big_complete dropped
- 3/3: Realtek claim removed, it was not reproduced

 net/bluetooth/hci_conn.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 0b76df1bc5fd..9fa8dab2520e 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -939,6 +939,13 @@ static void bis_cleanup(struct hci_conn *conn)
 		if (bis)
 			return;
 
+		bis = hci_conn_hash_lookup_big_state(hdev,
+						     conn->iso_qos.bcast.big,
+						     BT_BOUND,
+						     HCI_ROLE_MASTER);
+		if (bis)
+			return;
+
 		hci_le_terminate_big(hdev, conn);
 	} else {
 		hci_le_big_terminate(hdev, conn);

base-commit: ffb95458a0f70dcab620eee0ecf5ef7750971b2f
-- 
2.43.0

