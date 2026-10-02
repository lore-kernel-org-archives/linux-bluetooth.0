Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BE93DD87A
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 Oct 2026 05:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790919985; cv=none; b=gFr8co3SNSb+GYe0RtJFmAMWvW4RlZJlZfpwjGpvFCgSCBxt+G+ytiNiPAYPTjYy2G+vYlLbr6U935DWCJAul7wEe2buCkN1sxQVO78qoNlnZgnXNu5FuIM2KV0Isc1RSab4suPw5rkW1zgO0WLfCtoRw4Et4Yg3Scn+tP1y06g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790919985; c=relaxed/simple;
	bh=+dc2cQIEeVTeVhJcETBxBuz9LvK+5xklC4n8epY3vwI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KkexhPkPEk1BfJsbhw+ZK0dGl4so7uXAod8bI8uF8oTQQ/goi+7NTrVqzZecMC12FL/9MczjXdOg2tPJnchSWX26G6SuR0irXPRz6pcF+ygu8XUJdFXepVqrsLr6/7lKVdEIGzahd6LanAMc+m5I8BSZAANR2kDXkAJ7z0WRzUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=simpleble.org; spf=pass smtp.mailfrom=californiaopensource.com; dkim=pass (2048-bit key) header.d=simpleble.org header.i=@simpleble.org header.b=wubR2j6r; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=simpleble.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=californiaopensource.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simpleble.org header.i=@simpleble.org header.b="wubR2j6r"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-34ea0b83f8fso748236eec.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Oct 2026 22:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simpleble.org; s=google; t=1790919983; x=1791524783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=u8OLFshlPlGxNOFhXo5F39WXXnMJZfzOvw2LMq5vKTA=;
        b=wubR2j6ruV63czYQ5m7pjCwZZPtVLqTuqphwH8AOomsJxCddESK0SGrKhjBMRGC1S6
         U+a6MmsnG3cUjXQZ4dUuQrT2wCRFeGoLrqCVyW6xeUxeooggldr7OqS3TK0oDcbBB5tx
         UHkmEKbrE9K3sAq8NKU6dvbY/W2ekN69laT6Dyce1XoXpRLPP7d0Cm/TSWEIkAlAsL65
         zfzgsmFxHKckz0PBj2JHAIai4CnFJTo0SM2eppC4GEl0VHTiwvw8/j9a6gz/WpLR9MBU
         Pq/hIJOfRlKdXF6qGBRipsOhWX21nvgs+jdU/MCZyA8EmO6UGGeQ+AejZzmV4n+YMNAE
         8ONg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790919983; x=1791524783;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u8OLFshlPlGxNOFhXo5F39WXXnMJZfzOvw2LMq5vKTA=;
        b=DLfTwF8ZYTMQgjV9GYQtilVQ+zjlTisy/MQ3MDs7v9cElShrST1uH7vDGi3kVl+fUj
         Xobv5h7enpQWBsTMMXzr65Bct0DQRLOk4A6iU6cui7XmuioiIzPeaOwtCJqbH9tY6AEP
         V47Dh6QRrT0JFYws+4cM1eJKGERsSF0rXhHhc6CzRtTlYCasDYJ+NSPtJR+4CicSQYrc
         sORD4wc15t05pdDsy8YJMVyjrtUioNk99OR820h/Jtksl0GAd/EqDkIvZGjeo5Vr1VkC
         vmpXWj4ZUBtyjsCOa+HZzukF1mkI0FvEAmfMtR8W32G/iWYc2Z52u8Br+ujGviDXTxHh
         7uWA==
X-Gm-Message-State: AFuF++ncZAMOff/mQXu9jxQrXMvEspjJbKm7gXsdARchdViCOdhFMkTu
	3MiOI+ZRmqniXYmImSEwVArjSOkyXlHe0sBv+rlIAAfa62rXTuJVWmaGw40qjrfDsB816j14pUx
	6BWLdLks=
X-Gm-Gg: AYBFou2QJGXOl/OtPooHEsWI5kDMt0Dywvub9CVq1MW8ISNC66AS1xRgkmRbuzItHur
	Hr1fFHGFSae/0j/wjbRYeOmSuhtF55LvqQ02eCFmmz50/qhRPboLcNFJQYP+iCv+CnfZ4gxLqH8
	Wt4JAnyHFgiwOeHolEBSzmZJae//ii+bI34OgT1ietVRgDpqx2HmBO28ijbyn5ugCnE2jPla2eZ
	dwjgFgiEAqIq7wR2u+9bQoWB+k69EYdmuoavxaV5l4Im63OyfN1xczslKFSbxhychS5V0EHXvie
	d9FrudButKmnxgjv7cw8wCixVmWRUE2o1+3s+BfCFMhTtY9f4DwUTtw8j5pwslOQL/yDml8Envl
	mwEs7IcrE6CFBu3whD3HBTOPiDIq2TDLm9QuSt1SlR9QWx9vTov3MyzygKFiUClmJVnQybrmtXU
	RmuX9bqWcnlcpo7vLA6CoGMhFK4FCQo6QGNyACMWiwUTqyaenkF/m/TxmCTsPXI9j7EKySH0wKw
	omkjt79j33R//m4q0OGtLkeksgJojkynrlx5vIMwadCQRGUbULk5/90qdgLm8Tf0E4N93LNRrS+
	9mf8R/e4zZxJ4bDT5AswQmURxIqhaCA+Y3xaYaB/
X-Received: by 2002:a05:7023:a4a:b0:14f:8d59:edcc with SMTP id a92af1059eb24-14f8d59ee8cmr1059023c88.12.1790919982778;
        Thu, 01 Oct 2026 22:46:22 -0700 (PDT)
Received: from localhost.localdomain ([147.185.47.151])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34f15019999sm3064217eec.29.2026.10.01.22.46.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 01 Oct 2026 22:46:22 -0700 (PDT)
From: Kevin Dewald <kevin@simpleble.org>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Kevin Dewald <kevin@simpleble.org>
Subject: [PATCH BlueZ v2 0/6] Add Connectable property to org.bluez.Device
Date: Thu,  1 Oct 2026 22:46:11 -0700
Message-ID: <20261002054618.30994-1-kevin@simpleble.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bluetoothd records whether each advertising report was connectable,
from the Device Found event's Not Connectable flag, and uses it
internally, for example to pick the bearer to connect and to drop
temporary non-connectable devices when discovery stops. Applications
cannot read it over D-Bus, so they have to guess, e.g. from whether the
device has a name, which is wrong for named beacons and for unnamed
peripherals.

This series exposes it as a read-only Connectable property on
org.bluez.Device1 and on the org.bluez.Bearer.LE1 and
org.bluez.Bearer.BREDR1 interfaces, emitted when it first becomes known
and whenever it changes. bluetoothctl prints it in info, and prints
devices that are discoverable but not connectable in red.

Tested with an nRF52840 switching between ADV_IND, ADV_SCAN_IND and
ADV_NONCONN_IND advertising: Device1 and Bearer.LE1 follow each change,
including PropertiesChanged in both directions on a device kept by
continuous discovery, and the non-connectable profiles, which keep the
discoverable flags, are printed in red.

Changes in v2:
- Add Connectable to org.bluez.Bearer.LE1 and org.bluez.Bearer.BREDR1,
  so the LE value is visible for dual-mode devices (Luiz)
- Print discoverable broadcasters in red in bluetoothctl (Luiz)
- Print LE.Connectable and BREDR.Connectable in info
- Document the property type as boolean, like most of org.bluez.Device
- Rebase on master

Kevin Dewald (6):
  org.bluez.Device: Add Connectable property
  org.bluez.Bearer: Add Connectable property
  device: Add Connectable property
  bearer: Add Connectable property
  client: Print Connectable in info
  client: Print discoverable broadcasters in red

 client/main.c                  | 32 ++++++++++++++++++++
 doc/org.bluez.Bearer.BREDR.rst |  6 ++++
 doc/org.bluez.Bearer.LE.rst    | 12 ++++++++
 doc/org.bluez.Device.rst       | 11 +++++++
 src/bearer.c                   | 38 ++++++++++++++++++++++++
 src/bearer.h                   |  1 +
 src/device.c                   | 54 ++++++++++++++++++++++++++++++++++
 src/device.h                   |  2 ++
 8 files changed, 156 insertions(+)

-- 
2.54.0 (Apple Git-157)

