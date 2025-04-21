Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079B3263F3F
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Apr 2025 13:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745240455; cv=none; b=b7h0HszMrGrcX4wMGPyBPyGt0QD8NRSVMGDhAVI7xFg8JgrziW0BhGAcx4FSB5jpM2LvqYISEzgOfeU5IlWiX3kOOrJ5KvJ/oYlOE42ELah47q2Yk/ldscEWd6pzC1QyVnorE8Lf8Hmfs7eV6a7D2q4A9JsK57m8R6qSFzWnJKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745240455; c=relaxed/simple;
	bh=UdoBYXZDI6i91jbwfQE13A2pfJqNj28gRiPFYgsqjEw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rlSn43kA5TMGM0D/mwuolEGUEOrFG4Z6PtQXZQ8lNzlqKoG8PP3qNBTQveypnGjGi8GAKjspautYmjbOGW4LxQrxMPd/UHBF1Na2kjzmbeVx7EM7qOkmcVm1bF4ua7jm6nr/+v67CcXTk9ht0zm/fJZNds4yB3rn1Z/C7ZzJPGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=P+SboFVm; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="P+SboFVm"
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 2B1B541A0C
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Apr 2025 13:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1745240445;
	bh=vQ6ou3tWqXEiNZ+OJ9V6Fm/EPrs0acywzCR64vd5LIA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=P+SboFVmDBjMjpg9phP5s6RtXbandTWjQNrD7CSlHIMacS+0Xyj4cyO7wOxVKdIJw
	 3EnhXjzXupUp7AVETcbNAndaluOJumHP8svu5UDRDmaU8IqI+yeKaftDIco58T9nAG
	 vpwlFHZd27qtqSw6AQUwjTvXqOOsgRgKaQ6nvobnSquUdDQ04VtakyOrAJ2P/+jgR3
	 HxcS0BhnWoLcB7RkhrDcdSdYNf6vaA3MvNQKvof+rHMCkkNzE1+bvMTp1YfzdVCwW0
	 dnnrnAeXBwyx3mLlm4H0NVWmfNyQ1MrKrhmISBNvWmhmnLEDjyVbYaeW5M0GTGdLtf
	 b2IVB6Y9b8kqw==
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-227ed471999so36173175ad.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Apr 2025 06:00:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745240444; x=1745845244;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vQ6ou3tWqXEiNZ+OJ9V6Fm/EPrs0acywzCR64vd5LIA=;
        b=XGhc0dwh+dsSMW/gophWNTvETPebEgkYVAPAszYGJNRdeH+OKwwp0YH0sM6zzgcFen
         6QIatdmcT/H0o9kxhs7Cu51CymjPL/r0lQsZYu4EqRCehO2feiS78X68NDqiWL37hCU9
         NZ24QGRyybayjCMyuv5pok5bYehSEkbt1hzCb5b61+d6BQzSRwtocSq53BfG0eM/2veW
         2VLqGSJLUq0GA3RyF22V/uecNhcMpXlLwXzCkqA1lBmkpfwUWpvhhcOH/EMpoJUUpRsY
         rQDvPXOkty0QDtbQje5XAJT+jbICnmFrZZeKywuQS93+yYqNEQeaxpy0Nqm4V+0KcFKd
         Wk+A==
X-Forwarded-Encrypted: i=1; AJvYcCUa45YZxt4hPiz6qCpEc3GtOdSZ6O0orU+O0h6evQM2odxOAiHg4QHWYkgSO3HDi/fHcmQRnR4CWbQI93x98b4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE0xrzCgL6DBV1T9D4TUu27OrZAi3m1qSE2tM4QPEkgDBze0GF
	Y1NJxv4UTCzBQr/CovaLgwesO4HIK4r8ylj+CF1PXGwYswNIztBk4azaDgKJb10IZOLBGePfq6i
	Vl9HqQ4WC3UixUepZK2a5jG2ltoi4R76oYq9Xwn1JhmoqKZi/zj2W2oalJUyqA14aTm7l3cqtqR
	YJ90KBug==
X-Gm-Gg: ASbGncsZbBrT6Xap+j+Qrd6LO8OYD+T85mGDPmQFeU+h5EwnvMX0OGJihjIkcmKKwUT
	HjKuQdLdrux4kVeMmxg66FL6xTLvHYTkcIjLQSLG29UH7G2geCqX6X0QJYWGu/MyHPP31tp5NBD
	Xmfb2GTUYVVh0kmaKSKJ5247oJXcSZDHg/ma2iwh4u7T4teHXiurRvXgZm+mQVLqFQCr3xYQBcw
	AGNGvbYIxlK5WY0qWmDrdj8Os8WbI0VBiDX3SNzXxITiad20tJbkgQdHoN/T9rrAARWE6pg7Mnz
	GBDtjCY7s7I5WLw1ZDktEOH1y72GCWZStrfDVy+SQZiVx9oDYz1iVlbhZZfI8bucYN4=
X-Received: by 2002:a17:902:cf12:b0:21a:8300:b9ce with SMTP id d9443c01a7336-22c53626fb6mr170043365ad.49.1745240443751;
        Mon, 21 Apr 2025 06:00:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExX1Xc2vMU2pblQy0GGeMZoJV1lDHlig9j2h90ZQJ2QyMEyBmrDv5Jg0PlkH60VKL6UPlkuQ==
X-Received: by 2002:a17:902:cf12:b0:21a:8300:b9ce with SMTP id d9443c01a7336-22c53626fb6mr170043015ad.49.1745240443473;
        Mon, 21 Apr 2025 06:00:43 -0700 (PDT)
Received: from rickywu0421-ThinkPad-X1-Carbon-Gen-11.cnshub.home ([182.233.178.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50bda7b3sm64758665ad.52.2025.04.21.06.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 06:00:43 -0700 (PDT)
From: En-Wei Wu <en-wei.wu@canonical.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pmenzel@molgen.mpg.de
Cc: quic_tjiang@quicinc.com,
	chia-lin.kao@canonical.com,
	anthony.wong@canonical.com
Subject: [PATCH v4 0/2] btusb: fix NULL pointer dereference in QCA devcoredump handling
Date: Mon, 21 Apr 2025 21:00:36 +0800
Message-ID: <20250421130038.34998-1-en-wei.wu@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series fixes a NULL pointer dereference in skb_dequeue()
during QCA devcoredump handling, and adds some safety checks to make the
parsing more robust.

The first patch fixes the logic bug where dump packets were mistakenly
passed to hci_recv_frame() and freed prematurely. This was caused by
handle_dump_pkt_qca() returning 0 even when the dump was successfully
handled. It also refactors dump packet detection into separate helpers
for ACL and event packets.

The second patch adds bounds checks and replaces direct pointer access
with skb_pull() and skb_pull_data() to avoid accessing invalid memory
on malformed packets.

Tested on WCN7851 (0489:e0f3) with devcoredump enabled. Crash no
longer occurs and dumps are processed correctly.
  
Changes in v4:
- Fix unused variable error in the first patch
- Refine commit messages

Changes in v3:
- Use skb_pull_data() for safe packet header access
- Split dump packet detection into separate ACL and event helpers

Changes in v2:
- Fixed typo in the title
- Re-flowed commit message line to fit 72 characters
- Added blank line before btusb_recv_acl_qca()

En-Wei Wu (2):
  Bluetooth: btusb: avoid NULL pointer dereference in skb_dequeue()
  Bluetooth: btusb: use skb_pull to avoid unsafe access in QCA dump
    handling

 drivers/bluetooth/btusb.c | 120 +++++++++++++++++++++++---------------
 1 file changed, 74 insertions(+), 46 deletions(-)

-- 
2.43.0

