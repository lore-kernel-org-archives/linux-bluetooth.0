Received: from server.interlinx.bc.ca (mail.interlinx.bc.ca [69.165.217.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6ECE225D2
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 Dec 2023 17:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=interlinx.bc.ca
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=interlinx.bc.ca
Received: from brian-laptop.interlinx.bc.ca (unknown [IPv6:fd0c:685d:4db3:4ba7:23ab:92fe:41d5:f62b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by server.interlinx.bc.ca (Postfix) with ESMTPSA id 999392F7CE
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 Dec 2023 12:27:59 -0500 (EST)
Message-ID: <6ce4dab33868db0a8c7b93bf58c20aa876d50f21.camel@interlinx.bc.ca>
Subject: chrome passkey communication timing out
From: "Brian J. Murrell" <brian@interlinx.bc.ca>
To: linux-bluetooth@vger.kernel.org
Date: Tue, 19 Dec 2023 12:27:59 -0500
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 (3.50.2-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

I am trying to utilize the facility in Chrome to be able to use
passkeys stored on an Android phone with the demo site at passkeys.io.

I have tried this on 3 computers I have access to and it only seems to
work on one of them and the Bluetooth operation fails on two of them.

The one that works is running Fedora 38 with bluez-5.70-5.fc38.x86_64
on a:

Bus 001 Device 005: ID 8087:0026 Intel Corp. AX201 Bluetooth

BT adapter.

One that is not working is running Fedora 39 with bluez-5.71-
1.fc39.x86_64 on a:

Bus 003 Device 004: ID 0a5c:2121 Broadcom Corp. BCM2210 Bluetooth

BT adapter.

The other one that is not working is also Fedora 39 with bluez-5.71-
1.fc39.x86_64 but I cannot seem to see a BT adapter in the output of
either lspci or lsusb.  But I can see that it has a BT adapter:

$ bluetoothctl=20
Waiting to connect to bluetoothd...[bluetooth]# hci0 new_settings: powered =
bondable ssp br/edr=20
[bluetooth]# Agent registered
[bluetooth]# [CHG] Controller 70:F3:95:3E:92:34 Pairable: yes

Any clues or hints on how to further debug why these two non-working
systems are non-working given that this does work on the third system?

Cheers,
b.

