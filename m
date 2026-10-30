Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793371447;
	b=mnB6V02x/wnYd8gjD1BIkl1jpQKa/StBVSu+XJOH/FMYu/QvitvKjIRAWksnpuztamam
	 1ov640jQd2dbg80m1fMlL4sV6o57n2bPVD8CSXEVkqSqXDjHVyY/5Zxup6SCq8ftiX6UH
	 sMC62Shpzlindq9G2GNtiNeGndORssFTyM7AFVgSGz0/cB92bLardQfx6dejhse1uyO49
	 cOCvDxyRbMP+kWgcQTU8HxIGSOBWyn8OApG+ItozyVJsnC6ImP/6I7PfMXQPJRSg7yfsE
	 N71imgqu4chF1i5vUUyZ0dLiHEJFvcDMD4g+chbe/ffMtGE+Frc1GAaucaeTh3tK3cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793371447;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Xf7sf8+0BwKqj0uvznPLe3t/Q+q+kU1XLoWKn8dO4RY=;
	b=cXjRV15Phb4lHmFNUgD0kWSOUoBueuBFTD/XVpmHkCkO5ghmuNvCRPRcHFY4bKzNTH7z
	 Y8Z7LTr8kkrbeonfZ2Q/OKbcZUmyi7ing3QWAJl1iPEqe+W5KnQgfDyAxaxLgulkhSYjm
	 oDkLR/pTM664cdAb2c2Bb0lIhBYTEJd+nmU3Ds2y+KRO6/pEgwJMakZVhkjr+xCWXTnhb
	 6R+pwSTeOToac3jSIMt0tebCXihhamHeESFxtJzj/nBYJrvszA/kFO9h7fj++7Kvsns/F
	 ghCJL97XBqlSNNKwJojWcgoQhL0u/vGyNEE39I08z0XmeBFLkc3K3oPBkztSNnLwTkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FX0K5KHy;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D541606A31C
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2026 14:44:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D541606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FX0K5KHy
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3ae702d28c4so389645a91.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2026 07:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793371446; x=1793976246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Xf7sf8+0BwKqj0uvznPLe3t/Q+q+kU1XLoWKn8dO4RY=;
        b=FX0K5KHykmEqt5iwTWU+A1+yWSk4kOv8QVMCKR9CrTK7GPZC+gKOxKprFCjUwjFBeG
         PpFoJv/KlTZRynAwU4I3aSGMpHdQUjj3JEPJ0pNqX5hVrnJ66uUwiC9JiGwIUO9/Vqwl
         UwzHcmi+eN9Gv8gFrtiZc87dcncs2xQrmFboft1pamiSF92+zoeQas3RGTVl1UvqFZSr
         fFfwt2NE47CVQom4/zFMoujIzOyIXpv7clD8AZHWKgVDXTG9JVuYnQxaGHWrL8HSCelK
         WeUWAWB13wRJXMfOriHEZQd1X29vepKKxoKk1vdRl6Qrgwjl/txVy1YS8Yolm1efMH4G
         BYtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793371446; x=1793976246;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xf7sf8+0BwKqj0uvznPLe3t/Q+q+kU1XLoWKn8dO4RY=;
        b=qYDns1+AjCGyquI4s9gnE5useNgphy9LR4G73O3bWmkKwyAb1dnflI8ihlqbRDCV44
         LwcHRX2tcfDs03+dLhz4hEtRcMfJVoyFMJDXRSmR6lVfFJtBSxFGezCa0RWYiBcTN7Rh
         qHszM2+C7tOINfoEEpSTc3/9Jf55o/JqntxoHK/Wf/VHuHlQOvhAYXlaJhcVSZ8bxFwT
         T6OE4+LFapPcl2ruqXYe3iJ6jzPWsdZVfRwrzPgAHoPQQ6hpOLX24Rvg9UqWYU7Tw9Yp
         dWgbZT2FN9MTmrdoeaeez5BYnSWXW6LCn5Y3WhqY8Ey8esDJ0qlV0G7bjtaNV+ivGzkt
         hk6g==
X-Gm-Message-State: AFq9FYJRE6G3LxNbtRCZwiOzjx8pqrmuhh9JwbAJipZOUhMKPc1QtcT+
	/qs3+Glx22R85wUOPWvUglN03t631HG6LcJZx5c+7TSGbDP9z1pLjrjX
X-Gm-Gg: AYBFou3afWJJUR6rO8HvHlOn/FGuuG/33qIZdXSs4YjHU+Jw/D4c79kKWH2cqDYgTx2
	BW/ibFelYoEr6R2zbxtDcYK/hXX5KRhRmkjzLG6PrSLSqEHcNguUsFeS2IMmbIvMAms8FVuuJEN
	iOiaQoBJ+/FlZcFYziVL9QzeD08CLP5UI/r65p05P3FxOz6oGVavyNztvjY92LR2+LkbVWW9+5W
	ksTM8JNBqeSAWeem7fHmZRfUy1mEH7ui00DbEhJtzGgJhptHY2ergAuuFlMDWVA0/oZS/Rx2iam
	PN+gQS6p4Qu1cejsYN1/99kj7MZSZESQFJz+NLbeIcdz15gC29AJs1xbIlEZNobz6/lbrs2fJ63
	5wVPo27XqvU2C/rJCc2NOjd2jEmi9YmjIVnKrvCJZFPuC391E3fe8ojv2DqE0KU0KSdUeQEF1vP
	z6ARIxQT2jUMV4WwqDc6ZxFh/uoD83snz1C4x61oNdBiOt0BqYuTnogSIC+hSvnF67oAZe+OwaO
	FoKQKDIA1tITtOEP6+FIOQqexsvAave6s261pgUkRzI2smTiyq9vwe9n37NPw6o5G3kNM7Fspp5
	or60u//stmNb0sLNXkbf9a1Pnw==
X-Received: by 2002:a17:90a:ec8e:b0:3ac:a203:e0a1 with SMTP id 98e67ed59e1d1-3ae8980ede9mr1798961a91.37.1793371445790;
        Fri, 30 Oct 2026 07:44:05 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae845d5e62sm4610922a91.13.2026.10.30.07.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 07:44:05 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH 0/2] Bluetooth: SMP: Serialize root channel updates
Date: Fri, 30 Oct 2026 22:43:55 +0800
Message-Id: <pm-bluetooth-objects-candidate-0184-v7-c26e53b52c260063ab6a-0@gmail.com>
X-Mailer: git-send-email 2.34.1
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

The SMP root channels in hdev->smp_data and hdev->smp_bredr_data are
used by HCI event processing under hdev->lock and by SMP receive
callbacks on hdev->workqueue. Power-off already removes them under
hdev->lock in hci_dev_close_sync(). Two other writers do not serialize
with these users:

  1/2 The force_bredr_smp debugfs switch creates and removes the BR/EDR
      root without hdev->lock. A connection confirmation can see a root
      whose operations are not set yet, and a disable can race with
      power-off and release the channel twice. Take hdev->lock in the
      writer, and skip the deletion when power-off already emptied the
      slot.

  2/2 smp_register() replaces both roots when management powers on a
      controller that is already up with HCI_AUTO_OFF set, while HCI
      event processing and SMP receive callbacks can still be using the
      old roots. Run the registration on hdev->workqueue, where it ran
      before commit 2ff13894cfb8 ("Bluetooth: Perform HCI update for
      power on synchronously"), and hold hdev->lock while it replaces
      the roots. The caller waits for the work without holding
      hdev->lock, which HCI event processing on that workqueue takes.

smp_register() still warns when it replaces the channels on that path.
This series only makes the replacement safe.

Cen Zhang (2):
  Bluetooth: SMP: Serialize forced BR/EDR channel changes
  Bluetooth: SMP: Serialize root channel replacement

 net/bluetooth/hci_debugfs.c |  2 ++
 net/bluetooth/smp.c         | 38 +++++++++++++++++++++++++++++++++++--
 net/bluetooth/smp.h         |  3 ++-
 3 files changed, 40 insertions(+), 3 deletions(-)

---
