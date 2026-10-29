Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793237637;
	b=R7V96DUFqCCvS8TXd09hFgqnPEs5Jnsr6UlaqeJxqrxB997tSiSus55wQRdBiB2s2KO5
	 bIqTT9q7VaWX6F1KSPgSxA8Mv865/+AE8IORmmRO6IwPdOTmOP1XDgNv7xAv+1kBjVBoP
	 phq4Pd2A5YjdrcCrxM3N5MrOS4nPZYcPSBFLPgDzLykp+rSSm6bSpLw80Y4bv8zJ5lpvI
	 I0nJwpwjum+jE+3etnkYYsILF8jGfTYJbX+06HImghJZ/fUMS8f9t+gI3yF17hYXovsJk
	 OuSjQZ52RjIDSfAzMLviMZkuTR4cmPtx1A4FnCLFdVcXRCDxA6WwoonTLhZlS0DMoBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793237637;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=EoP5HeDwRQrZtppjR04jBpu1jn7IKqWeWWXoUVEEViY=;
	b=x+2qWuQZE7lLk6PQKj9TLcCEnKFnERTt2CEJL6w36TSalZPSvu0JWdRIlHuREe89Xkvb
	 Ty+DPqp8kKqh+b8NZFwShxGs1vVdpRmBKkEwDH+uPm42Pw3eCbJ+KCxo7+phiewaCJBO2
	 lbCGruzFhskDu0jur38VDvw4QW0S+7Jeys43tj1oNv0d50IH/eqM2zY/mbLE9jIiuv3VM
	 ewZwPXqp8ZWUzC5bdsOlrOsniGL+z3qUY6gVKtske+NRtm6dzBJvZIh+yipeTCM95WAW/
	 6MyCwPAhRYz9K7lobM6yqWa9FI+gBBUhNYlMog+tHiurw+zXrIaoBT1EUELH1szZ/pA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l8fzn8tY;
	arc=none smtp.remote-ip=209.85.167.170
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE84606A31C
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2026 01:33:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3CE84606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l8fzn8tY
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-53ca1ae18bfso101521b6e.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 18:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793237636; x=1793842436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EoP5HeDwRQrZtppjR04jBpu1jn7IKqWeWWXoUVEEViY=;
        b=l8fzn8tYMbKqGYUKEpa6kNeWVZW8R+eGHO61t7sknyOiSTnuGltDl9xX+Lmb/TQTq7
         VXje9FQuH+3VkUH6na0awQ97ZFbz0ACihhZPHGqVYm+58UjiuDhGxXoKXVm/GkMXJaTh
         CMDJczwCOyNlSNNPYXRF/YNmZ2niy/zvHgvz3DKlrZIB2iz+ADnWi4dBEkQwiCK6I4tT
         wtkvsu9XlBH4XQA5B5klG53eg+5LhYoQvl63XT0iZ2tU7JWQq1l+Womlv0Tafxe7nqlJ
         TRDG+4peupPtHDiXiSvIt3a4JOOV0Iez0WrT0N4+j7zh4U7MGFYd5FlWleiW5xZsThrt
         rfvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793237636; x=1793842436;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EoP5HeDwRQrZtppjR04jBpu1jn7IKqWeWWXoUVEEViY=;
        b=LwVvJddZLxbUyB89WHe6kJ3AkqZycvN/mn1WnE/XlkoJmUz2ISiQDUKW6NcHpPVSRA
         5LukpkCrM9FEZcfpy5x/btN1+PacRFURfVxuspQZSOOzKoVZuZi7DQijqqn7VxZWcmYb
         qE+FijrvjYQzxP/s2+btoCBwuDl4M83vXSlMtJC2kIYSXUbJRAp8267xr+QdbOyA0rCj
         ivaE9LI09MP59a1m1sUVh0itPjlJ6rP5SAArx8+Xqe5bE59GBbe7zPLgMAmRnlOHeRQW
         0MR3EgWxs0Se8ipS7HL6XNHMtDU3UkALGdgbXXyRXQ+UtzvyAHiMt7cgXXflhzbKCDeu
         /2Yg==
X-Gm-Message-State: AFq9FYIqbkmWT8s89YYC9BROdCkStz4bx06GcQRdx+87/CSLlwQDmkO/
	NdPG8/FXXSR4C6fNAva4rlNLJXyzBBndW/rJQp+mV5ASScGSb0lLVNxKhnydMTG93iXByg==
X-Gm-Gg: AYBFou3NosrLKARhI4dM17biaklbGi+gHl6/0RFfH74BuyYGE+i8lunCI3DtV0mFUQJ
	REOejQdS56CxpZM31NGBBJvZZoe4yCN1F6baZbI/29LG3ZEjJpl6qcp/sByaIu5krax67xOPPmp
	2fSn2gRJm2Zwgz+LQaQPDXlDdKCw3l+tlGk1JvHMYhNdADgGP32U1uAWkeu+u6mhl2Z9katcmpR
	SnkMlWEwA65nd5grYmxELfyxoHq6B1GFAwpptO5FmgL/0mzgIlH/ICa6Ohb0rBLIMvRNXv/EX1v
	RQWJMcBg1v71Z2ejgz+OKdOnHVjZ39v9vGS+4SXV9SKh8omz7HiFFpkvHokNyCSNo11BddvRgB6
	wjmT9ToP6/29dJ0k6nLzYv01kYDakVskzh8htb0UYRnfyddMtGemOfhiFPEwnnoanNBNVvzzCEL
	j61A6VX717hbwnFC0Bpz8kA6kVuBYggEK2N978E2074+B/XNUU5lZ0H5i1wC6Veayw+941flOA3
	FxV5Kryeft6s8ZFz5rdlwtIfxDfXRWXX3Xl0ybYCHbccojitizrGXBVTt+IHKkhVGkoXXbslKUP
	axXyajmQbmK+7dJ9MnAEqmwdA+5Re29tGe8+KhgyZeiz6rqm3iBNq0BffC4P8qwsxYpB/HNDqtZ
	2ZImoK8I/0w7fURQ8D2ghVVNVUSRBwg4=
X-Received: by 2002:a05:6808:120b:b0:4f4:ad37:ced3 with SMTP id 5614622812f47-5638217e505mr4234515b6e.3.1793237635887;
        Wed, 28 Oct 2026 18:33:55 -0700 (PDT)
Received: from localhost.localdomain ([37.19.221.69])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-563c363902esm2784617b6e.2.2026.10.28.18.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 18:33:55 -0700 (PDT)
From: Iaroslav Voitovych <yaroslav.voytovych@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Zijun Hu <zijun.hu@oss.qualcomm.com>,
	Shuai Zhang <shuai.zhang@oss.qualcomm.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Tibor Harcsa <silurust@gmail.com>
Subject: [REPORT] btusb: QCA9377 13d3:3503 on ROM firmware: HCI hang during mSBC SCO
Date: Thu, 29 Oct 2026 02:33:50 +0100
Message-ID: <20261029013350.360574-1-yaroslav.voytovych@gmail.com>
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

Hi,

A report with two questions, mainly for Qualcomm; not a patch. For
13d3:3503 the kernel side is already fixed: dc16388d45ec ("Bluetooth:
btusb: Add IMC Networks QCA9377 to quirks table") is in v7.3 and in
stable releases, so I am not asking for another fix for this ID. The
entry was sent for BLE-scan errors; in my tests it also avoided the
controller-wide hang below.

Summary
-------
Without a btusb entry this QCA9377 runs its ROM firmware (ROM 0x302,
build 0x111). In twelve recorded failures, the first HCI command
issued after a transparent (mSBC) SCO link came up got no reply, and
later commands timed out too. With the QCA setup path, which loads
qca/rampatch_usb_00000302.bin and qca/nvm_usb_00000302.bin, 74 SCO
links logged no command timeout. What goes wrong inside the
controller I do not know.

Questions
---------
1. Is this known for ROME ROM 0x302 build 0x111? Is there an erratum,
   an affected ROM range, or a rampatch/NVM revision that addresses
   it?

2. Is there a list of ROME-based USB IDs, or a reliable way to
   identify such adapters, that could be compared with btusb's table?
   This year three were added one at a time, each after a user ran
   into the 0x2005 BLE-scan errors: 13d3:3503 (dc16388d45ec),
   0b05:1868 (d54601f21faf) and 0b05:1825 (cfa67a1dbfd9). An
   earlier, unmerged submission for 0b05:1825 (2026-07-21) also
   reported SCO audio broken on the ROM firmware ("corrupted SCO
   packet", no HFP microphone).

On the ROM firmware
-------------------
The device has isochronous alternate settings 1-5 (wMaxPacketSize
9/17/25/33/49) and no alt 6. On the transparent links recorded here
btusb selected alt 1 (read live from sysfs), and the captures show
each 27-byte SCO buffer sent as three 9-byte USB packets. Setup
Synchronous Connection (0x0428) is answered and the link streams.
One of the twelve failures (kernel log, Bluetooth dynamic debug on;
"evt 5" is HCI_NOTIFY_ENABLE_SCO_TRANSP in btusb_notify()):

  02:09:36.646940 hci0 opcode 0x0428 plen 17
  02:09:36.718906 hci0 evt 5
  02:09:44.049893 hci0: handle 0x06 reason 0x13
  02:09:44.049956 hci0: Opcode 0x0406
  02:09:46.067797 Bluetooth: hci0: command 0x0406 tx timeout

Here the stream ran about 7.3 s before the Disconnect. In all twelve
failures the first command after link-up timed out about 2 s after
it was issued; where the delay from link-up is recorded, it was
34 ms to 9.65 s. The command was 0x0406 Disconnect in six, 0x0c1a
Write Scan Enable in one, the bare "command tx timeout" in five.
Whether the command causes the hang or only finds it, I cannot tell
from the host side.

No later command was answered. In one failure I probed the USB side:
two GET_DESCRIPTOR transfers timed out with -110 while the device
stayed enumerated. Removing power recovered the controller; a warm
reboot did not always.

The twelve were on Ubuntu 7.0.0-29, -30, -31 and -34 kernels with
stock btusb and three headset models from three vendors. I have no
count of ROM-firmware links that did not fail, so no failure rate.

With the QCA setup path
-----------------------
Before setup the controller reports ROM 0x302, build 0x111 and a
status with neither QCA_PATCH_UPDATED nor QCA_SYSCFG_UPDATED set, so
btusb_setup_qca() loads both files; both loads return 0, and a later
version read reports patch build 0x3e8. On the same laptop, across
the same three headset models, 74 SCO links then logged no command
timeout: 50 mSBC, still on alt 1 with the legacy 0x0428
(btusb_setup_qca() sets HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN),
and 24 CVSD. Of these,

  58 ran on a diagnostic build giving this ID BTUSB_QCA_ROME without
     BTUSB_WIDEBAND_SPEECH and without the reset callback, so no
     reset could have hidden a timeout;
  16 ran with the exact dc16388d45ec entry.

This does not separate the rampatch from the NVM. Nor does it
separate the firmware from BTUSB_QCA_ROME's other host-side effects,
which the diagnostic build kept: the shutdown handler, set_bdaddr,
the simultaneous-discovery quirk and the reset-resume check.

For anyone searching the archive with a similar failure on a QCA
ROME USB controller: check whether its USB ID selects btusb's QCA
setup path and whether the rampatch and NVM load.

Kernel log extracts, with the commands that produced them:
https://github.com/ivoitovych/qca9377-bt-hang/blob/4b56813d311d/contributions/CO-25-qualcomm-rom-report/EVIDENCE.md

Thanks,
Iaroslav Voitovych
