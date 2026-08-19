Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D023DEFE7
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 09:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787130832; cv=none; b=ax4ZuoswYGSMzlbKvcYjfXIg5Dy1WOpcHFO2dRJ5brghGPSttQmVOR53Va8L8LiTCoolVRxIi6UEvbZwwD0rO/88kNAhqEwBYT7jO0h8xoao2vqg8x+A6+9SxXU1IU4+ydlQ60+s62tNDdFYUwvtfXmNl93hdOVPagMTEwhw5kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787130832; c=relaxed/simple;
	bh=GipSGmhzhcQlkn7H59N0swF2ZR3oS9bffVaTF3ywMJo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ReMf8EY1RT0LJdmqDpzr6BS563J5KJvqSs+vdpV0qTD4E9SFpjm8AWqsvgRuf06Zpfvf+C4e0hzKcM0ZJRrlh2lgdfnqMpLFfKBvVGRkBovA/TuuM7CnfmKWUlegKLgL+kjvPn/VUgAlGPyLZfT7uTQsl9WLqMN616HB1Qe4ric=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 671F13EBA1
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 09:13:42 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ] doc: Fix typo in test-runner.rst
Date: Wed, 19 Aug 2026 11:13:31 +0200
Message-ID: <20260819091333.1203931-1-hadess@hadess.net>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Score: 0
X-GND-Cause: dmFkZTG18iyAMEIQjh4veXWtQlH0Odvj9ozjZBJUum9zgChOm20FdzK9SMBkyMCI1MwSB8ZsrMDyzAQn7VFNEJnNGAty5q0MJq/QBw0KRNd8QCLUTrz46Ux4vyqEazuazvhw/BmaLZHCkEoTi3Ixz6bEQrXrhpaPtwJNxyOLlNGqv5TltXTHRWRkM3XMseRY/7rWBbULvKlr0OmYsB33fOEWg8SCw+ZCdUj7Ow2XqxC5xhCi/4fyCqR69aPWzcUp/dX92TYxGrzazYt8i7tsm2e5XvN62PwbZkNVhT62c1zU+qFv472FbcED9TdtqZ0qlwVRiNRevVQAjuz+F9DG3nfAx/ekoR9U/K0RptuAJB31ssSYWNsbVhIZI6K6RTMcW9kXl3IwHVwIFOz3MQXD0vIYEDfbtnBEL3lmiqToZXlX3xs53xBdrqybA7IL8/qG4xuG827/KiomplJfkRyGif6mp4ppICvcDTd0uoOROY+rKnwpSCvNmL12OleM5hb8Xv3uLN7VYonaUlHXMf8fLj0R/HziUoxL/kyINa69pgKoICTjIoi0kJ5GCxHb84/+YrE1yl92TAO5D7IqRUoCMc7wncQJSKBN8Ndhn5jryLCPf9zkNqYdtC4Oj3g8sEYcf8IJb0ude2+ogOfgI2p//G2n0k0Jrw1mFOGilsLsogDhQE1/ig
X-GND-State: clean

s/lunches/launches/
---
 doc/test-runner.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/test-runner.rst b/doc/test-runner.rst
index ff2420ea84bf..a650c6fae571 100644
--- a/doc/test-runner.rst
+++ b/doc/test-runner.rst
@@ -8,7 +8,7 @@ DESCRIPTION
 ===========
 
 **test-runner(1)** is used to test Kernel changes to the Bluetooth subsystem,
-it lunches a virtual machine using qemu(1) and mounts the local filesystem
+it launches a virtual machine using qemu(1) and mounts the local filesystem
 using virtio (9p).
 
 OPTIONS
-- 
2.55.0

