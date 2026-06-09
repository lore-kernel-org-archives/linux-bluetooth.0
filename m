Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AB933EAEC
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 14:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781015025; cv=none; b=udZL7QzOchSzTg2kAM12xu4TPg7E06w3bjBkDCE14aiNkQORaNZHVHIwWKjL3BhEQPrT0xkAegzuYE0Vmqa9uj5UQYqH72HokUXZJCXvQqgNsz8YlluTpAoX65wxA3eysHQ0TJd3YcL3rdQNRZst3Vvkmv3w3yzzjFTra0MHUS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781015025; c=relaxed/simple;
	bh=VHoEPPeRIvUsnTxhbShT/rYphGZdaFcN6+IQIpUeDNc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=G4X6xYjyFnn0Gi2orYoAgGoU1BWe4PgsWtjnYwlCU0KGt804GYGoIVPOx/Rgc4DD43TtPkU/ZfC0b9doRlL+t4LK6Lt4Z3d/K5qthLxwoGY/bQK66xmJTr3FkSkjRKkt1sLumxmluQb/G7uoPBKhiVbkI9uNaXJcagEBziwWu04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 6E3AF58153D
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 13:58:52 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 692593EDB4
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 13:58:45 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ 0/6] "cleanup" variable attribute follow-up
Date: Tue,  9 Jun 2026 15:50:52 +0200
Message-ID: <20260609135837.476561-1-hadess@hadess.net>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: dmFkZTFgPMyUc0Nl1syOYJ7qo+6FQ50zZcUWhV424JsJzBJKXWHh3n5o4kBPSDbJLiY/8mqPZzzaeaCq9YfLQc2OqnQGffTms5dL9RSlJyuGqiLWU0FGXJUcBiqvw8WjE5nylZeTdbLarItcXpyldXLoFo1CPM3+KwjJvsYai5Nb3QVAeB+fO737BeHGRPjJ48lrqeKVgS5AQQ4W4hRScWXTpXnxfU7C8IVIg3kKH1qqOCvVSfIU4hAf1PrZcMRdJYTud670R1wR+Hi6Zv2p6eyXYqsXrZPitdC3AAsE6UhryqHR7xfnmKS7ggosNaBEHgPNbUHWuuP5iO97DjF7m08tAtIHNrrnBEFMaw3njUGL0P5nbKpjAagJVKIIaTgH/UKoqwXtgpz9j2cNXI9jhXe6OmAdQCmoslDL5jpRu8+lpSUB++3AVGSMXoCmm7oatjkWNarZZUtmq3hEirxb0WnHCUcuORl/9uy2WFyqkMDiv4kC7X1aNKApFJ3XrGrEDfVVYYNSJTKHOgno0Lhq4zz5GXRVKPAigFYmR6NeBCCO+2LwCcvFYhVepfmhBms5IfU26WUFfRgP1FDJcrmDSUkJslGCQTcaGl4B9p4JoF2RyHMnVNLLfSWJOD3pMwZmw+6+XEgmzVytRtF6F/jnDYjMJv1i24aiE56MUA4AWwd3W4u+uA

Follow-up to the partially applied "Add helper for "cleanup" variable
attribute" patchset.

This new version:
- fixes the crasher seen starting up bluetoothd
- fixes the warnings seen starting up bluetoothd, seen when free'ing
  NULL variables
- reimplements the _steal_ functions as macros to better type-check at
  compile-time
- mentions _steal_ macros in the style docs.

The original patchset also caught a bug in the meson port where the
config file path wasn't made absolute, so bluetoothd couldn't find the
config file when starting up, so I never saw those warnings and crashes.
This bug is now fixed in the meson port branch.

Bastien Nocera (6):
  shared/util: Fix warnings when cleaning up NULL pointers
  shared/util: Better type-checking in _steal_* commands
  doc: Recommend using _cleanup_ and friends
  main: Use _cleanup_() to simplify configuration parsing
  client: Use _cleanup_fd_ to simplify urandom access
  btattach: Use _cleanup_fd_ to simplify error paths

 client/mgmt.c                 |   5 +-
 doc/maintainer-guidelines.rst |   6 ++
 src/main.c                    | 108 ++++++++++++----------------------
 src/shared/util.h             |  23 +++-----
 tools/btattach.c              |  18 ++----
 5 files changed, 60 insertions(+), 100 deletions(-)

-- 
2.54.0

