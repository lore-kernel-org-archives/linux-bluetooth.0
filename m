Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3281C43AB4
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Apr 2024 11:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712142358; cv=none; b=HtmN058+OlEnmKOCK+eHoLPTP/L4LfIp2aGLJY92N68ZU4YcXKMUAz9ZZmvbKVMH0KmmA095JlS0XWOOcecG1sxfbtpUMQ679Z17dp8CYkHbxUUKfV5OLSABWKcfgTujoP1KgD1/XFsA0kWaQJekUFJFD1cagZh0MfG+MWPBwUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712142358; c=relaxed/simple;
	bh=bQXn0yuQeBmlk9S0vx3YAteMf+6fb+js61BVf9TE8Ts=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=pYLxQtAfZWKOZR4JbgXR/H2h5g9P/hPS+9/Bd+jM9OQaO0oOymRqOeQkq+LLyY0eYeUhsGGB12E9VGOw/EVTKH6YxcpT3cICC6wenMzCZA4Ss73b6NaBhUanUbWIhFjb/R1bm5MeDEeiGvlZ/STbVPXDI4+acW8OAbD1s+zQdfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--howardchung.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d5Fch/vF; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--howardchung.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d5Fch/vF"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc746178515so8779564276.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Apr 2024 04:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712142356; x=1712747156; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KVvC+43ZdUyvzV4+LHjAEPxjQ7hiPEDENCPcEUuvQaM=;
        b=d5Fch/vFHZYH1X931zbpDewyqkT7CtwPZL8/yGP0TnR4jVyt6AnLRAY8pjPh8Xjbpw
         aNxFY9rHWI64RxaTdKyee3EP2zeeS5xeLQrZvpi9XlTU7TBWcCcKja7+ch7+pxxDvo9E
         VvALyAo0cbTZnWChp1JbD2KonKv3KEpP59GDOErzYVFW7ns+Xq2iVZkgzgVtDlI6lpjQ
         FM4LMwqjQtJW5wCvOL2lMMQAcmh3WcEn6WLIIn/RW937kyBkRuX+628zrZvMXy8rsgM4
         JhAC4CT3YaGjBam3IRZw4u6KpTzNv+ngUZ5wdI5EHkwHBxTLCx3IfG5oOja6MQQMkqqZ
         DU0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712142356; x=1712747156;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KVvC+43ZdUyvzV4+LHjAEPxjQ7hiPEDENCPcEUuvQaM=;
        b=sxESqDn7+X+FkKn6PzRShkEKJ2Vv+R1w3EcvIRcF/o9vWiNtNOsrBsrx8dL3X0ddLO
         cXKAABGZpr7nCl6FEw4a1xHlTruL533mzSRi/F0iepDqjtk/ZfdzFBWU3UyM/nKsA346
         TjQMWfdz3r/tTiMrKDye3BMlGqRvrjzrJ7KPRiq3GEq6vjmSdYXIFZDQrgadN/qMjaIX
         KcrJEYP+8wkRl/KHfAbjSqRo/nyelylbxGMlwv1M1ZDnTrqCf2vLJ6TPpye5e4XKPqhW
         VmUxb4VmrcegmtMhtnepTov3T3wFvfQu7vpT14TElgbEsKGZmOUPAS3ECfIDE0HBvjWI
         KPDg==
X-Gm-Message-State: AOJu0Yz6SnUIJwgL8gIa0lJTLG4RM82OLyx7evkIQkxwgdX7HWpTU1uG
	aeDUCmNije5AchBTxd8ObqNLOcBcOSuhsPd5QDgwFsoBL/b6gdsxEtbZ2s6E6M+hNNBzuy8hT+k
	BR5nWwNl5oIrNnfbl8XbqKnlOwgI9gs7Kog/8oYbuslIUDaTfL8NKgUS6IaYM+9qkCGAFC3pxt3
	TuWYH2UIgvCJCPljd1hJ9eRgxkbR1xL4gLoHdCgqtDuUaImFFIY7qGI2WgAFOqUjCC4/jZGms=
X-Google-Smtp-Source: AGHT+IGylZl8VQVACA861F0yhceegw1KdnQBawt3praTqD64mV2ifSn8JrMSmQeC4qx5wmnhHaj0up3ECUEvVbAnew==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:17:a99c:36f2:1a05:fa42])
 (user=howardchung job=sendgmr) by 2002:a05:6902:1b11:b0:dcb:e4a2:1ab1 with
 SMTP id eh17-20020a0569021b1100b00dcbe4a21ab1mr4772991ybb.11.1712142356106;
 Wed, 03 Apr 2024 04:05:56 -0700 (PDT)
Date: Wed,  3 Apr 2024 19:05:10 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240403110549.75516-1-howardchung@google.com>
Subject: [Bluez PATCH 0/2] Fix descriptor display issue in btmon
From: Howard Chung <howardchung@google.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Marcel Holtmann <marcel@holtmann.org>
Cc: CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>, 
	Howard Chung <howardchung@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi Maintainers, we found that in some cases the new feature regarding
displaying the characterisitc of the descriptor could be wrong. It turns
out it is because there is an assumption (please see the 2nd commit) in
the gatt-db usage but not being properly maintained in monitor/att.c.
These patches are aimming to fix the issue. I'd be happy to send you the
btsnoop log but not sure what's the best way for you to send it to you.
Thanks.


Howard Chung (2):
  shared/gatt: Rename some gatt insert functions to append
  shared/gatt: Add descriptor insert function

 monitor/att.c            |   2 +-
 src/gatt-database.c      |   4 +-
 src/settings.c           |   4 +-
 src/shared/gatt-client.c |   8 +--
 src/shared/gatt-db.c     | 102 ++++++++++++++++++++++++++++++++-------
 src/shared/gatt-db.h     |  19 ++++++--
 unit/test-gatt.c         |   4 +-
 7 files changed, 109 insertions(+), 34 deletions(-)

-- 
2.44.0.478.gd926399ef9-goog

