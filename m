Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE77487A5
	for <linux-bluetooth@vger.kernel.org>; Sat,  7 Sep 2024 21:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725744789; cv=none; b=mVFdtlM9hZLaMlIalzDSHl/j1TS4QMNIv7H4JOrPSmoIQvO9/azHPj1hXIa4ZmySuvN4AUdYrP0AVa4WOcXGTRZ9e1gJMxQcWnTlbD3U29aiE1D+7+eH/ndTuk0wkCv0r9ArtblFgvppmrK1c1PBbCsxEggtqnsG3Z+8Ee0L/xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725744789; c=relaxed/simple;
	bh=KjPDaYvPzeQ3vWA482i2ZPpjfVsPaUxN5M0cwJ1gCXY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q+MdtJhqI5NhffI9i1InDFr9L4+D8wAa1iWmnMudxOaSa4sE6yn9MBGIsP5Kg0U6nLNA70JgT4PHoCD4AA33+tk7Iz8T1+UrggS5Seipd4wJyI5vNK+/8NJ3iabVksYTf3Gg8X6g+NFvibtRymldtahW3e75piLcqXwLIjhQ7lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U3kUQP+z; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U3kUQP+z"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-710da8668b3so393553a34.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 07 Sep 2024 14:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725744787; x=1726349587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L2pWquYkVjy0XTiEUD3DOu8z6XVfgffuFdpkdY2zrKY=;
        b=U3kUQP+zlaamea3ZreWPgsGKgAEM3EJV4xhuvtHehVmIwBKOtoBlHO7s7mxq5sqfRb
         CsTSJL1Mw3a8qpxW/qPoBYoub0MWiClSG31uiUEAObqcqBYalHiuv+uCj09Woz2MwoCi
         5DcdrJapCmTlxBk2JR6bRMnkf1ck4dRsXpKiyzQVTLfiQ/HKVbUicP+X3u+ZDgeejcNs
         bORV0znYiK9dzJdhoRA0GqbYLCkoouNFEQivPmIUbkg0twa8FS2S/0BX9NVVrKhnLMZa
         yYOTsOJFvlGgWSuIzagJZ4nVg+Cel5pHs8SZal4uu0j+p5ra1Lu3qCEmmpgohSKFPb/s
         zpqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725744787; x=1726349587;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L2pWquYkVjy0XTiEUD3DOu8z6XVfgffuFdpkdY2zrKY=;
        b=Ps3ZWmlZgOc99ca32NrRuRxv5L85vKDJKifqaq6QMcVeu2/KOfP3OQIWjDo8QZgk4w
         6ybTNF/0oS3FqpijXpUOw3xzWyC6vB1FCk95GcGEk1DkpUFXnATNTJB9XeG2CBPikzNQ
         fuYJ4YKkZa9yntWCvktPnCTFTfaQjqy9EKfGdMbSU/PoQwFdvAvwSSdVwt8u2aZuuObw
         hT+rxRTxGud1Hz9K4Ee5yVh/6vd/YKMnAch/CLxssSwJyU3//jvvt8wuqlwfg2VpEoJJ
         prPHZ1Ee8sfylgxdT26kOoz8x4WcM3iND181ZuZ89PeBFYtp2/IbNDBFCe85a4T4cHix
         EzZw==
X-Gm-Message-State: AOJu0YxzgHNvxMPf5mpZZZt00BmocTXNr8NHTvOyyWwA5hzUo0TdfNbJ
	3XZgnqOZ3fGSpM1BlKhdggeiZgaAghOLO48OutfrqJzM7ax/Bqc+2gJang==
X-Google-Smtp-Source: AGHT+IG57Tquebp4q9xbEqduCOprqEgd+xWe0mct8+J3KPRUIpsIKuneoPKMjieE2Lpb0wXdjRrYYA==
X-Received: by 2002:a05:6808:1705:b0:3dc:299d:c4fb with SMTP id 5614622812f47-3e02a02964emr7014566b6e.40.1725744786680;
        Sat, 07 Sep 2024 14:33:06 -0700 (PDT)
Received: from vibhavp-an515-58.lan ([2401:4900:1c62:13d2:d7f9:63c9:9aab:1368])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d8241be950sm1229781a12.44.2024.09.07.14.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2024 14:33:06 -0700 (PDT)
From: Vibhav Pant <vibhavp@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Vibhav Pant <vibhavp@gmail.com>
Subject: [PATCH BlueZ 0/2] org.bluez.Device1: Add GetServiceRecords method to get a device's SDP records.
Date: Sun,  8 Sep 2024 03:02:59 +0530
Message-ID: <20240907213301.14000-1-vibhavp@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds an experimental DBus API to get BR/EDR service records for
devices. The method will be used to implement a part of the Windows
Bluetooth API in Wine, which allows accessing a device's service records.
The documentation clarifies that the method is only meant for compatibility
purposes, and purposefully returns raw SDP records to discourage general
applications from using the API.

Vibhav Pant (2):
  device: Add method GetServiceRecords
  org.bluez.Device: Add documentation for GetServiceRecords()

 doc/org.bluez.Device.rst | 19 +++++++++
 src/device.c             | 83 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 102 insertions(+)

-- 
2.46.0

