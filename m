Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793448997;
	b=ll4S3pyFnD+yWJXrDRkWiSeaqjZZ3AemXHwmu0qRS+LzOh6i1X5SjhXuP+BA4TPvVR3F
	 NCuKNqgc1nE/JmR9zfEVw6JhO1/aVnHSFLkLoP4VKP0bdqgYhvvHfgEpyCmo7NNfvgE6l
	 29+1+ZXpdS4k3OGq2L3RutdFjdflM/GQhkIsTQbDUINr5E+1vI+aAp+6Sw8NBRGFz6TJf
	 29DNpka0N7y0hxSls3s9z6nYTZekDXdr9zIgY8aHamUfeRV59HEI/m3EpJVmCKanu2OK1
	 edelU08a3N/AtZoFxqYxLr8o5i1rkr1Te+yZkT+9ag+EUStk8URMZ7CBHf2t8dgfjnw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793448997;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=SjqgroeEWEZSL3UEQsxo7sYbwKFnvRh6dO+iYjjDQ7E=;
	b=MkAwqsS740b29N1iFhh9pK/uMsyDZhKIdcSA7V7aZ3/yZtJ2qkWL5MRqFCcZlPaHH9W3
	 XahxaqpeyJkkhF9x+LbSofJ8UdXi149L8aQqKnG/D5dGI94Qz0W/b2r4/GPLB4iI4QNKN
	 1mZWsOmbN+gSwu46dtinQ3y6apiZyWJtJv52cfCFx2n3SXlL+b8arcoCC73IkFkian5Vd
	 W1AGawDFElfT2GCxBw6CNB8tC27YD3fgQiboHAEO08ffJU1B7Tx094LgmenP30mBDW62a
	 /0UvBBFBPaSyyzVcTYV3RvUap+idBnw2eFcMDkI06zSCIJ6Sq7jdhY+anqm3nX/TQag==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jvpe4JDf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C9B606A32C;
	Sat, 31 Oct 2026 12:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jvpe4JDf
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793448997;
	b=L88lRo4LnL5//0eQA5eW+myEz15ITj0/6Ykkfh7xDY+lX6FhRUDN8cvHyUY5t5xqIWQT
	 kUF2lotjySuUg98rclqP/Io0X3SWFWL6SWxC94H5NX491y7ANDaCBOhK5jzz6EJrde+j8
	 O+28w9989CkaPScXGznWPqp1oU1B5KlRo9+dgPMbEVOIdJT2RvnEkJuvjiTySSQO2qMhO
	 SQSn8q1zgqWXCvpxDyaBx5BvZ2t5ceG2bkFC6l31er9QyhatsjbIR4eXAdAR7dYK5DW2s
	 i1+YmVcMSWoHENrazql8JX3sBq4o77jJtYBbLWSq9uEc2PD2y+so8DN7SBkpGeCudZA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793448997;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=SjqgroeEWEZSL3UEQsxo7sYbwKFnvRh6dO+iYjjDQ7E=;
	b=CokxASz+itq1kZs+pHJhM5HsPmd9gkEPPRf3XuOMDzXTQoUhsq1vPonwzBhbECJKaC1B
	 SMuUOrVOcCqSd1wLiSyZ9LZSgmMG7EXnf+8B/pO8GKe9wZv8FqKbt4xA/WXQnsX51GXyw
	 AVwyD1/8F8j8ZuHzqdKCLQClulb2NBK75zbTtgMcFmTreebUjZa82EYYw1kTHsS+mhycj
	 51lR0ncIShFO+NEOwCIMQUM9d/mApWwbebJSxYth7Mm00uhE9wMUGufwtRwrdc0RRrs1U
	 +3JdmpRbE6k2yXRR/b8OMhw41jACww+zd0QangMk2iZfqJ704cJWPMVMXVTnf5nsGeg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C27C51F000C1;
	Sat, 31 Oct 2026 12:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793448997;
	bh=SjqgroeEWEZSL3UEQsxo7sYbwKFnvRh6dO+iYjjDQ7E=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=jvpe4JDftDv2wCbbjdz2HTffnF6C+GovNUqUWt0dylMVRmQMk1ecv3v9pXSiH0zaI
	 +rs0ygKbLSs80856ZA6PmoLxG176GM/Vhg+xkcVlRoUuB0mJrq1HlUx0jwTFYTXXDf
	 3hrNKZGk2qs1fPdnd4ns3Ho3EBk8hh0BIKGvMXq6kLQwFb3L9wy+dvbnuHtwQDOS5e
	 JW2+bIMtkMYChv/BTTyv10zq+vbU38oZidNvMy/UFP9RCMwGMxIG7DU0nVrkMKUD1S
	 kjD91cUg2LMYCitwxIPzc4rCDMgTMjD3W4IbzC/GIoOy+67ug/Yha+zMWUD5XgsVln
	 n8mbRRrVnf4WQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 234F245EC0;
	Sat, 31 Oct 2026 12:16:35 +0000 (UTC)
From: Ernesto Salvetti via B4 Relay <devnull+ernesto.salvetti.tambosi.tn.it@kernel.org>
Subject: [PATCH 0/3] Bluetooth: Fix LE on Barrot 33fa:0010 controllers
Date: Sat, 31 Oct 2026 13:16:14 +0100
Message-Id: <20261031-barrot-le-fixes-v1-v1-0-30e2089882bf@tambosi.tn.it>
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
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMwQ6CMBBEf4Xs2Y20IIn+ivHQli2s0WJ2KzEh/
 LutHt/MvNlASZgULs0GQisrL6mAOTQQZpcmQh4Lg23tYNrOoHciS8YHYeQPKa4Gz6fB9jGOres
 7KOJL6NcV73r7s779nUKuT3XhnRJ6cSnMNVqEJ07Hp9NMAvv+BZfbsLuWAAAA
X-Change-ID: 20261031-barrot-le-fixes-v1-95624ffd0a43
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ernesto Salvetti <ernesto.salvetti@tambosi.tn.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793448994; l=3307;
 i=ernesto.salvetti@tambosi.tn.it; s=20261031; h=from:subject:message-id;
 bh=NkLdEkh7bgUMhoEF7i6a2/grihrcRLLsAyrSVjURO74=;
 b=wK3wUlz5FRjKma6NmX35el7rDepELpXhStFn1qiVneFSiKgL6kqYf5U7KioRaw0F5Ek6AqFNN
 KpV62SJyZhICUFPIA7EnpJxUFUMiq9LOfZ01Oc3xSIY9RphQlLZlmqY
X-Developer-Key: i=ernesto.salvetti@tambosi.tn.it; a=ed25519;
 pk=OLNiuyRbYD4dcNYoAvM99nt/1KZTKeM316r91BCQDUs=
X-Endpoint-Received: by B4 Relay for
 ernesto.salvetti@tambosi.tn.it/20261031 with auth_id=1370
X-Original-From: Ernesto Salvetti <ernesto.salvetti@tambosi.tn.it>
Reply-To: ernesto.salvetti@tambosi.tn.it

The UGREEN Bluetooth 5.4 USB dongle (33fa:0010, Barrot chip, bound to
btusb via BTUSB_BARROT) works for BR/EDR, but LE is unusable: as soon as
a scan is started the controller hangs on LE Set Extended Scan
Parameters and btusb resets it in a loop. Once that is avoided, two more
problems show up before an LE device can be used. This series fixes
them one at a time:

1/3 Setting HCI_QUIRK_BROKEN_EXT_SCAN alone is not enough on a
    controller that enforces the spec rule that legacy and extended
    LE commands must not be mixed: the stack still uses extended
    advertising (LE Read Number of Supported Advertising Sets is sent
    during init), after which the legacy scan commands are rejected
    with Command Disallowed. Don't use extended advertising when
    extended scanning is marked broken. This also affects the other
    users of the quirk (hci_bcm4377, Actions ATS2851 and Realtek
    0bda:a728 in btusb), which will fall back to legacy advertising;
    I could not test those.

2/3 The controller answers LE Read Remote Used Features with
    Controller Busy right after connecting, and the stack drops the
    link. Continue without the remote features instead.

3/3 Set HCI_QUIRK_BROKEN_EXT_SCAN and HCI_QUIRK_BROKEN_EXT_CREATE_CONN
    for BTUSB_BARROT devices.

Testing: on bluetooth-next each patch builds (clang, W=1) without new
warnings. The runtime tests were done on v7.2.11 (PikaOS kernel) with
the series backported; patch 2 needed a context adjustment there, since
hci_cs_le_read_remote_features() in v7.2.11 lacks the
HCI_ERROR_UNSUPPORTED_REMOTE_FEATURE handling. With a 33fa:0010
(bcdDevice 88.91) and an Xbox Wireless Controller, checked with btmon:

 - without patch 1: Command Disallowed on every LE Set Scan Parameters
 - with the full series: scanning works, LE Secure Connections pairing
   from scratch succeeds, reconnecting with the stored LTK works, and
   the controller shows up as HID gamepad (hid-microsoft).

Before that I used an earlier btusb-only workaround with the same
effect for an afternoon of gaming without problems.

33fa:0012 shares the BTUSB_BARROT flag but I don't have one to test.

Tool use: the investigation and the patches were done with the help of
an AI coding assistant (Claude, Anthropic) in an interactive session.
It analysed the btmon/dmesg logs, read the relevant core code, proposed
and wrote the changes and the changelogs, and ran checkpatch. I ran all
hardware tests, reviewed the changes and take responsibility for them.
The patches carry an Assisted-by tag accordingly.

---
Ernesto Salvetti (3):
      Bluetooth: hci_core: Don't use extended advertising with broken ext scan
      Bluetooth: hci_event: Don't drop LE link on busy remote features read
      Bluetooth: btusb: Disable broken LE extended scan on Barrot controllers

 drivers/bluetooth/btusb_main.c   |  6 ++++++
 include/net/bluetooth/hci.h      |  5 ++++-
 include/net/bluetooth/hci_core.h | 11 +++++++++--
 net/bluetooth/hci_event.c        | 11 +++++++++++
 4 files changed, 30 insertions(+), 3 deletions(-)
---
base-commit: 42b8c2d729268a65a2d98064e8dc59ff53646b14
change-id: 20261031-barrot-le-fixes-v1-95624ffd0a43

Best regards,
--  
Ernesto Salvetti <ernesto.salvetti@tambosi.tn.it>


