Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=138.232.1.140
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792956234;
	b=hn31BEdiysByelL+lNATzZYKjSin1/ouZAu9A/W5WZ5qKHqth8NZowIC5Unw5exym8AZ
	 73GQU5Hqtm0ZKUn/qiox9KGl5dHfLhJ4gkVGNoFxwlEv2dbET7jErgvaXyvJ1bIvpMEjw
	 KS2DEG7kVR1sRsEoIUxLw1k4KzcMoR1xw+KI278PYTs9hPW+MH98h6zH5b/z9/OpEPR5t
	 50JbT9RKM3JEI5jMXTNiptJNJ0ufKesu8U90B0PP2aeN17vVAczZ+saN7xvSlFpfIidg4
	 Ug+3buNB1J7CVzhoRBJJPbmS3V+nXoQwpdv/qqRb3bE3yYeeUHsAO1P6vFY2LtI3pow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792956234;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Spam-Score:X-Scanned-By;
	bh=ra4/QRivTLSdriFBiUEkS7hbX4vjLYQ8M9nUGkUw3X8=;
	b=PE6WRrILGFc2depolnWbemrFSiiHZ7eGSFyRYRpdVb9NT6yjG24sJtsv92p3Jz6OvN48
	 jVIfYJu3VcSVtHDJGXGa4AHzF27stKH56+bwNrAp+Fr8gsOQt17c/NWHEn+COBxcYNnFr
	 /JUi299BSQGLf197+JAxgLv18ZVtUiP2jIEOR2opBe2eYUZAgHts/0LdOEsYp+snAue6H
	 oLnSD5soeC2C2OF5+74TwoJS21LrU7SK2c4Lq0dQBsn6NIEcF8qMbVrLYJmCENJxKo/WN
	 wNqgY6Zb5RYs7MkvodYAFgm8URea8aU3ppbdWQ1qybk+s5fDyCQlhedjuVKHZFDVZ9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=student.uibk.ac.at;
	spf=pass smtp.mailfrom=student.uibk.ac.at;
	dkim=pass header.d=student.uibk.ac.at header.i=@student.uibk.ac.at header.a=rsa-sha256 header.s=prod24a header.b=LgBqvykJ;
	arc=none smtp.remote-ip=138.232.1.140
Received: from smtp.uibk.ac.at (smtp.uibk.ac.at [138.232.1.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EECF606A33D;
	Sun, 25 Oct 2026 19:23:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7EECF606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=student.uibk.ac.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=student.uibk.ac.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=student.uibk.ac.at header.i=@student.uibk.ac.at header.a=rsa-sha256 header.s=prod24a header.b=LgBqvykJ
Received: from surface-pro-5 (178.115.151.51.wireless.dyn.drei.com [178.115.151.51])
	(authenticated bits=0)
	by smtp.uibk.ac.at (8.15.2/8.15.2/F1) with ESMTPSA id 69PJNdOt518064
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 25 Oct 2026 20:23:41 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.uibk.ac.at 69PJNdOt518064
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=student.uibk.ac.at;
	s=prod24a; t=1792956222;
	bh=ra4/QRivTLSdriFBiUEkS7hbX4vjLYQ8M9nUGkUw3X8=;
	h=From:To:Cc:Subject:Date;
	b=LgBqvykJMKisqONMOJitgNVCboCT6KJf17sXnoQjMxEFd6UctWgaNPx7bMMJVaCSh
	 7xei1CYRHmlauIk4CNjyRifh4Uc5aEw9n5irk8L9/HJyshJG1xKGV2zDa7wQ1BHlxq
	 6K2mm51+G4qAazw/QmbfgwLDDbdD6p+mXw9hmdpM=
From: christian.koever-draxl@student.uibk.ac.at
To: yang.li@amlogic.com, marcel@holtmann.org, luiz.dentz@gmail.com,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Christian=20Stefan=20K=C3=B6v=C3=A9r-Draxl?= <ckoever@outlook.de>
Subject: [PATCH 0/7] Bluetooth: make the Amlogic W1 (W155S2) usable
Date: Sun, 25 Oct 2026 20:23:31 +0100
Message-ID: <20261025192338.209574-1-christian.koever-draxl@student.uibk.ac.at>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Score: () -14.0 ALL_TRUSTED,RCV_SMTP_AUTH,RCV_SMTP_UIBK,U_RCPTS_11_PLUS
X-Scanned-By: MIMEDefang_3.2_at_uibk.ac.at

From: Christian Stefan Kövér-Draxl <ckoever@outlook.de>

The W1 combo chip in an S905W2 TV box could not be powered on by
bluetoothd and did not survive warm reboots. This series:

 1-2: adds two quirks, for controllers that advertise Secure Connections
      but reject enabling it, and for controllers that hang on Write
      Current IAC LAP (sent when the adapter becomes discoverable);
 3:   lets hci_aml cope with a controller that still runs firmware from
      a previous boot (the enable line does not reset it), retries lost
      firmware segments, waits long enough for the firmware to start,
      and keeps the controller powered across down/up;
 4-5: takes a stable address from local-bd-address, as the controller
      keeps none across a power cycle;
 6-7: adds amlogic,shared-antenna for boards with one antenna for Wi-Fi
      and Bluetooth (about 15 dB better reception there).

Tested: cold boot, warm reboot, rfkill and hciconfig down/up cycles,
classic keyboard pairing and reconnects, LE central and peripheral.

Tool use (Documentation/process/generated-content.rst):
This work was done with the help of an AI coding assistant, Claude
(Anthropic), used through Claude Code over many sessions. It did a large
part of the hands-on work: it read the vendor kernel and the firmware
interfaces, probed registers on the board, drafted the code and the
changelogs, and ran the builds, checkpatch, dt_binding_check and the
tests on the hardware. I directed the work, reviewed every change and
the final patches, and take responsibility for them. There is no single
prompt to quote; the sessions were of the form "find out why X fails on
this board, fix it, test it on the box".

Tested on an Amediatech X98Q TV box (Amlogic S905W2, S4 family, 2 GiB),
vendor U-Boot and BL31/OP-TEE, Linux 7.3 plus this work.

Christian Stefan Kövér-Draxl (7):
  Bluetooth: add a quirk for controllers that cannot enable Secure
    Connections
  Bluetooth: add a quirk for controllers that hang on Write Current IAC
    LAP
  Bluetooth: hci_aml: cope with a controller that is already running
  dt-bindings: net: bluetooth: amlogic,w155s2-bt: allow local-bd-address
  Bluetooth: hci_aml: take the address from the firmware description
  dt-bindings: net: bluetooth: amlogic,w155s2-bt: add
    amlogic,shared-antenna
  Bluetooth: hci_aml: configure the RF for a shared antenna

 .../net/bluetooth/amlogic,w155s2-bt.yaml      |  11 +
 drivers/bluetooth/hci_aml.c                   | 197 ++++++++++++++++--
 include/net/bluetooth/hci.h                   |  32 +++
 net/bluetooth/hci_sync.c                      |  16 +-
 4 files changed, 231 insertions(+), 25 deletions(-)


base-commit: 7be4bc52fd9e0e55dc9a2e0232b89427d2c4b614
-- 
2.56.0

