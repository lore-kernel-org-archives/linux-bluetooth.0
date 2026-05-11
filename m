Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A68C3E8C74
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 13:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778506358; cv=none; b=eNYIvY9euSRURyyMIbyR+a3/lYMF31rva2f/MZXUsM9qfcuzBWcJ9M/nwRbJoE9H56lkZq8vX+65Bsh2yHqqjeDHRqWCsd6RhmKeCK1999uABKHQXWSCFVYfftuIutCa++CxZALwtNbj4YxxC/eb5yuvW8IoUbTpJQyBa98SIJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778506358; c=relaxed/simple;
	bh=PigVV1ShmmDR1sAEZ19B797OyU0CyAkOzVBmaKCJJJY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=trv5hdDpX5NIwlWiZU0I+fGV1q2nZbu6DpQEWuD5cp+f2pXFUGjQ6u7dd/kSLmbL9dziohtkkznXQwH5/MCqgkhlGRcH1CJ8GWz8ntOEUFe0CNaJ81XpDfcJzeHcZr43YbUkchvCcXvM88Lf3W5HeLkqYbUFsSl3E0eCVgIBrMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 52F0A5812F5
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 13:21:47 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 42BB13EC2E
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 13:21:40 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ v3 0/6] Add helper for "cleanup" variable attribute
Date: Mon, 11 May 2026 15:18:03 +0200
Message-ID: <20260511132131.1283892-1-hadess@hadess.net>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Cause: dmFkZTF/sB+FplFiLM3W4E8soJdEeO+3soZ26UH7b02JW1X+TFEV2PD0DgSUGNEHUcargjghqDpl7lDvUIY+WHlE+oJ6Aon0tbMCREPgqIP4rUQe5J3K/d5vaudUfZwFq3a1k4ErA9DyuA0xoTzVHQELzOA+DuLf2mxSXhiKpN27wgFW6obGi4aUMUNTfYUymb8KHIp59wUjaw5HO89HpDgbqX8Hc0swvEIR7lHbIcLB+Siz8AStls3t0zMtKeyQdcLaZg/2S+OXWqXlC7HIsBIbnHwp3ezbF4H94q4ySURSjzWebcwABUv2F5UaNPi/iRsz2GfKnIkgb16goCX+GN5HKq6hDswKYFH1Svw0Ub3SVd4Uq22Fj5faOGwf5JRDOKphnFYYXA0OiTPOi3QEHC+qEztzGxHmj+kxZAOT2ofqI2eCI/KRHHSQp1eCXzHxH/JE0m+Ww3kmUqGseh2mHdsVjgCPf97quIK85lgNNianQ6lbba6TGTMbRGmtzRbBW++bLoj/TpWJdr1iK2jXnr/MbPSlVzmqziDYSfBeyL7l8xph15LFD27qy1llCRaqBIstMj9dXtEMIaAtD7F4EKj7wse/GqE5rB4ZppLZaxhr1+5ZbP6TwhXATn8e5n4I2xp5dqPwwk/0b//ZJbik0Ui3YFmGpoZOXX1VM6Qy6a3jQC/0cQ
X-GND-State: clean
X-GND-Score: 0

As discussed in:
https://lore.kernel.org/linux-bluetooth/ed949f2550f79a4bef19bd482bf8b069ad5b7e0c.camel@hadess.net/

Implement a cleanup helper.

The MIN/MAX fix is here because it touches the same hunk in src/main.c
as the other patches. Feel free to pick it up straight away while the
rest is discussed.

Changes since v2:
- Add macros to declare cleanup for specific types
- Add file descriptor cleanup
- Add "steal" helpers for fd and pointers
- Add unit tests

Changes since v1:
- Fixed checkpatch warnings

Bastien Nocera (6):
  all: Remove more unneeded MIN/MAX macro definition
  shared/util: Add helper for "cleanup" variable attribute
  doc: Recommend using _cleanup_ and friends
  main: Use _cleanup_() to simplify configuration parsing
  client: Use _cleanup_fd_ to simplify urandom access
  btattach: Use _cleanup_fd_ to simplify error paths

 client/mgmt.c                 |   5 +-
 doc/maintainer-guidelines.rst |   3 +
 lib/bluetooth/hci.c           |   4 --
 src/main.c                    | 103 ++++++++++------------------------
 src/shared/gatt-server.c      |   8 ---
 src/shared/util.h             |  40 +++++++++++++
 tools/btattach.c              |  18 ++----
 unit/test-util.c              |  65 +++++++++++++++++++++
 8 files changed, 145 insertions(+), 101 deletions(-)

-- 
2.54.0

