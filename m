Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8C0142E9D
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 09:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715850230; cv=none; b=KlC/Zk0K8C2yL1bDRSSTvnltRl34fpiYhuklQaTxFpquCZIruWupBTnCxe1D9mMva7u9ACteOtzAGQsD1l51KKL81QZw6B1a0TTOxNm8JK/UFZNlGT5KdbqTFEvGihXJ6vPY7rl/BUiQyA2qfyP1Qh5/845orq5eSORs14dnwyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715850230; c=relaxed/simple;
	bh=JhKx39PYa8ptl/+65Vw7X/x+3AKi/DDJcPudIuqVM7c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AzegAEU3WLeXIkxVZS714x/fQW3j7+4ADPAS9MovzZ3KJS5vuM/i+tcBz8T6OIIhtNrlYlMyzRX+8KalRzSG2XL7NX3x38xHXqqeEoBuIfb+l34yTj2p0UsuSxVwl4Jc2N0XBWlhTE2526dcVWKG4FHFXMI8wCx8pGQrhI0N380=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id F045B1C000C;
	Thu, 16 May 2024 09:03:40 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ 00/15] Fix a number of static analysis issues #2
Date: Thu, 16 May 2024 11:03:04 +0200
Message-ID: <20240516090340.61417-1-hadess@hadess.net>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net

"main: Simplify variable assignment" makes a come back, moving out the
single special-case out of the function.

For "shared/gatt-client: Fix uninitialised variable usage", please verify
that this default value is correct.

Happy to iterate on any patches you feel are suboptimal. Note that the
only patches that received any sort of real-world testing are the one
mentioned above and the gdbus one.

Cheers

Bastien Nocera (15):
  main: Simplify variable assignment
  shared/ecc: Fix uninitialised variable usage
  shared/gatt-client: Fix uninitialised variable usage
  tools/mesh-cfgclient: Fix uninitialised variable usage
  test-runner: Remove unused envp
  test-runner: Fix uninitialised variable usage
  test-runner: Fix uninitialised variable usage
  shared/bap: Fix possible use-after-free
  isotest: Fix bad free
  test-runner: Fix fd leak on failure
  isotest: Fix string size expectations
  mgmt-tester: Fix non-nul-terminated string
  gdbus: Check sprintf retval
  shared/bap: Fix memory leak in error path
  android/handsfree: Check sprintf retval

 android/handsfree.c      | 14 +++++++++---
 gdbus/watch.c            | 46 +++++++++++++++++++++++++++++-----------
 src/main.c               | 19 +++++++++--------
 src/shared/bap.c         | 19 ++++++++++++-----
 src/shared/ecc.c         |  2 ++
 src/shared/gatt-client.c |  2 +-
 tools/isotest.c          | 20 +++++++++++++----
 tools/mesh-cfgclient.c   |  3 +--
 tools/mgmt-tester.c      |  8 +++++--
 tools/test-runner.c      | 15 +++++++++----
 10 files changed, 106 insertions(+), 42 deletions(-)

-- 
2.44.0

