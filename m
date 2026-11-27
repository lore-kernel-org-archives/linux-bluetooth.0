Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795769659;
	b=325riwkTPibuRBVzYcFdC63LTqxzV2u3qdyKP8WgeG5QadHtx2xPB5v1QjKM1W2yBHzo
	 uy4/ig/YnMebhCZWJt3e0X2Dxqn3inb2Dv9jBjlITzFngpcFchdv7xBcKDxuYpdniKGW4
	 4yQKqc77kanzeeRfnZu2coLybBC+e5Hhr+ls4y9HhQFrGqG45BmyaHNk9MubBIV3oLYWP
	 Zw1HjWIG/64TwLyKRygAjY1GOtTNFx08qhf/hNZvgIrinJqbw523GAyAYzOuzsL1Z2qHS
	 5x7XDNoR6DbB5V4ttyr2+yqUZylf4A4c4Php9J84r/1v2jinmrOMOdO1Zps9ZI814yQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795769659;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=ztrtuCTPkzr7OBQbPK0NaxzBpcb3F5z5aEmHEZeHzfs=;
	b=JwOBzA4S9skJU6xaD+sJ/1Wihs+EY+3g/T+mM0m1vS95rS1oEO24Ujwroi0PubznBdkB
	 Pz8vuo8x23Yb1Cb3iVD+oC9JavIdoqVR3kVv27RBlwX6bT9InafB+NkIDwIl5XDXmvlYZ
	 WUcf/pJplpDt2fyEDTvhprlW66HObrXTQdiiPjOBrp2YEoQh1FiaGtQOl1aKUCVqgEx96
	 bJTKXFN0g03zX5cNquL7hggG22JldctehUgJSXg7wlnIIitIjeFvZm8fS+UtLRUS+iiKH
	 dMqtGA9X5JyQbnhNUsWEKZ0L1JM36l/e5Cx27nQAKTj+nDzQLONUq7oZ/HDhrmhSMsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=adBFWU48;
	arc=none smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE63606A31C
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 08:54:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8BE63606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=adBFWU48
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6bb06dc1ffcso768215a12.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 00:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795769657; x=1796374457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ztrtuCTPkzr7OBQbPK0NaxzBpcb3F5z5aEmHEZeHzfs=;
        b=adBFWU48U15YchE+geBGE0Ng4A4S9awmSXOzF3wgUCMyzfcuk6zcD18B9uQZN5jjuk
         31UPmh4mDbhlyqk89FPFIJ19aOHgDXl4X6K2hBXqn6x+N2HCezdkL4RMoz1sOw6CWlnP
         4IG4zFy6Ok0/nYlc//4F9VMVN3UI9opWyZLd4JPFWi6b2IsucqAPklpPsKOtxOvp3Q3e
         dAVvOOh5ao0e+GShso43WSFK1EizB8km4qwKSG5WRondErc6xWtdzEQtazo6jUgYludM
         kzkpcOGeImnAKWkIwTAdgzkfXpOrv9W5USBjKbmrQUo1NdeDpu0al0sAd5RMLpNSEVPR
         iXYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795769657; x=1796374457;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ztrtuCTPkzr7OBQbPK0NaxzBpcb3F5z5aEmHEZeHzfs=;
        b=EoKMYjVFYUNXgvzOG2fu2fB8OAUVeyKzTwwsfpz0qBvkUvmOK8Cl+06ax369rIy7/T
         pq8Ja6KKX9EdAV/UicM+upGb/gSJRzAop4GIR8F0SQuIr+Wey82xKh/drD8eukfeIBpH
         sg6HQpPHJfbjksfcCOdl7XGe43XAp7hZOEZiUbNo3UQM1iXbcFNjkjz92KHKHd7QU0LK
         cEf2iHqIL1JPir43jXWSrviT1lVBVQ+OeEqj0fi0HaeyMpH3O8BcZPExo5ia1wxxc/hR
         4nTQYBuqpzV2u4Pkqc6qDpblA9d5NcxWcWjgnmRulf/0+bXv4Amccaj7n8XZ6fskV6eD
         YG9A==
X-Gm-Message-State: APuU4Z/AjjhRJnjOygKGErxbXg+1+SZpz7A42k0NkD6sjgENZjLgfOeK
	1ZsT7UG5ILFlGSzq3VpBn/2xGJFHZ7OKHtnYtx/5jFpuTyd/7J/ZnRrgKLByru5t
X-Gm-Gg: AZFdTZdlNtc3deBWjOSdYklfo36hXQlGRVCb+/EASbf3UnQgdnWuyREaCUX8jJRNPo+
	0Xq/ARmsDGjIzKmgNnldDkPMtSgsIVf+wxvJbB3ZjOgKMKR0IRjZIru7LSWaJtlu79qLTB7z9N8
	NKY/bO3gPPs5shCIBs5hKd8RAfFm6TYI2F3LXpJ4EGLNvXak58vfsaxgZ7Vs0OHOW10TA2O07La
	OWBirF1WbO3g8mCN/jTsoRGN2pdEqCZEj8jXW3t3RJ0CRwi8sWJBTUpPcbRV13SCG8XJq4NoPmV
	l5OvTd7qjiP8nGRssSrQ50g7m2FrvCwxxrqgHY8lFP8AJ1T+vRD3zOYEsoJV964L4YnfzQ58xvp
	mPTvmoBChP0E6p2ZDnMh4BKoYMjyT4oEgSGhV5GWMlmivXZnbsMfQgxkQG/4Dl9T2DZW5YlnDhG
	WZ7dKRnWrStecH+cxTNv2f7g12aR4Nfun4OKPbJA7LGF6Bd9sQVRZAGez0amsn6dWPBE19a6HFv
	doBhzsvLRbp9C/l8FqWICN6jBRDre9kHohP5zY6NhYH0+fyBOTLGvnq8t0CY1thuyXsN+f9fORN
	dRJG9pbyfRr6ttFS9bvoYSAPUorU8FsHIL+Ay4z8O4FBYEtGf1T16fOa
X-Received: by 2002:a17:906:811:b0:c51:356c:2657 with SMTP id a640c23a62f3a-c513a567c14mr1887260066b.3.1795769656594;
        Fri, 27 Nov 2026 00:54:16 -0800 (PST)
Received: from schinder.corp.hoffmann-group.com ([2003:8:2:4::5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513aea28f4sm870688166b.33.2026.11.27.00.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 00:54:16 -0800 (PST)
From: Roland Schober <rolandschober1968@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	marcel@holtmann.org,
	Roland Schober <rolandschober1968@gmail.com>
Subject: [RFC PATCH 0/5] Bluetooth: Periodic advertising and PAwR over MGMT
Date: Fri, 27 Nov 2026 09:53:55 +0100
Message-ID: <20261127085401.263615-1-rolandschober1968@gmail.com>
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

Hi Luiz,

a few weeks ago I asked on this list, from my work address, whether
Periodic Advertising with Responses (PAwR) is planned, for a gateway
which serves battery powered displays like an ESL access point. You
suggested to start with PA and PAwR in MGMT, then the D-Bus API, with
emulator support so that it can be tested automatically.

This is the first step: periodic advertising and the advertiser side
of PAwR over MGMT, with emulator support and mgmt-tester cases in the
BlueZ series. I send it as RFC to get your view on the interface
before I go on with the responder side of the emulator and the D-Bus
API.

The interface (patches 3 to 5):

  Add Periodic Advertising Parameters (0x005d)
      Makes an instance created with Add Extended Advertising Parameters
      periodic, before Add Extended Advertising Data enables it. With a
      number of subevents it is PAwR, without it is plain periodic
      advertising.
  Add Periodic Advertising Data (0x005e)
      The data of a plain periodic advertising train.
  Periodic Advertising Subevent Data Request event (0x0035)
      The controller asks for the data of a range of subevents.
  Set Periodic Advertising Subevent Data (0x005f)
      The answer: the data of one or more subevents, in one HCI command.
  Periodic Advertising Response Report event (0x0036)
      The responses received in the response slots of a subevent.

The parameters and the entries are those of the HCI commands and
events, in their units; the advertising handle is replaced by the
instance.

Questions:

1. New commands, or flags and parameters added to Add Extended
   Advertising Parameters and Add Extended Advertising Data? I chose
   commands of their own because the existing ones have no room for
   the parameters, and an instance can then become periodic without a
   second way to create it.

2. Set Periodic Advertising Subevent Data is sent with hci_send_cmd()
   and answered from the Command Complete handler, as the PIN code and
   user confirmation replies are. Queued with hci_cmd_sync_queue() it
   waited behind the connection setup, and the controller refused the
   data as too late: it wants the data within its lead time, 40 to 50 ms
   on the controller I tested with. Is this acceptable, or is there a
   better way to send a command which must not wait?

3. The kernel does not check that the subevents of the answer are the
   requested ones, and does not split an answer over several HCI
   commands; the controller refuses what is wrong, and user space gets
   the error. Should the kernel do more here?

4. The controller's Too Late error (0x46) reaches user space as the
   generic Failed. Is a MGMT status of its own wanted?

5. The two events go to all MGMT sockets. Should they go only to the
   socket which added the instance?

Not in this series:

 - periodic advertising data of more than one HCI command (252 octets);
 - Periodic Advertising Sync Transfer over MGMT (the tests send
   LE Periodic Advertising Set Info Transfer with HCI Cmd Sync);
 - connecting to a synchronised device through a subevent
   (LE Extended Create Connection [v2]);
 - the scanner side.

A known gap: if the controller never answers LE Set Periodic
Advertising Subevent Data, its MGMT command stays pending, and the
answer to the next one is taken for it. The PIN code replies have the
same weakness; I have not solved it here.

Patch 2 is needed by the others but stands on its own: the controller
refuses to remove an advertising set while periodic advertising is
enabled on it.

Tested in two ways.

With the BlueZ emulator: the BlueZ series adds the PAwR advertiser to
btdev and 31 mgmt-tester cases for the three commands, among them a
second instance, controllers without the features, Remove Advertising
and Set Powered off with a train running, and subevent data which is
too early, too late or sent in two commands at once. mgmt-tester
passes 560 of 560. Without patch 2 the removal and the power off cases
fail. The other testers pass as before: iso 213, l2cap 144, sco 30,
ioctl 28, mesh 10, smp 8, userchan 4. No KASAN or lockdep reports.

With a real controller, in QEMU: the Nordic SoftDevice Controller on a
simulated nRF52 (BabbleSim), with Zephyr's periodic_sync_rsp sample as
the responder. Plain periodic advertising: the train starts, its data
is set and changed while it runs, the instance is removed. PAwR: the
train starts, the responder is connected and synchronised by PAST,
90 data requests in 8 s are all answered in time and the responses
arrive. An earlier state of the PAwR patches, ported to 6.6, runs the
same on an i.MX93 board.

The Bluetooth code builds with W=1 without warnings. I could not run
sparse, a 32-bit build or an LLVM build here.

The BlueZ side (doc/mgmt-protocol.rst, btmon decoding, btmgmt
commands, emulator and tests) is posted as
"[RFC PATCH BlueZ 0/9] Periodic advertising and PAwR over MGMT".

Roland Schober (5):
  Bluetooth: hci: Add Periodic Advertising with Responses definitions
  Bluetooth: hci_sync: Disable periodic advertising before removing a
    set
  Bluetooth: MGMT: Add Add Periodic Advertising Parameters command
  Bluetooth: MGMT: Add Add Periodic Advertising Data command
  Bluetooth: MGMT: Add PAwR subevent data and response reports

 include/net/bluetooth/hci.h      |  59 +++++
 include/net/bluetooth/hci_core.h |  20 ++
 include/net/bluetooth/hci_sync.h |   2 +
 include/net/bluetooth/mgmt.h     |  89 +++++++
 net/bluetooth/hci_event.c        |  90 ++++++++
 net/bluetooth/hci_sync.c         | 104 ++++++++-
 net/bluetooth/mgmt.c             | 382 +++++++++++++++++++++++++++++++
 7 files changed, 745 insertions(+), 1 deletion(-)

-- 
2.47.3

