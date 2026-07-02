Received: from out-32.smtp.github.com (out-32.smtp.github.com [192.30.252.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8B537A84A
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Jul 2026 15:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783005866; cv=none; b=rJuUBzZfMvJtUJVP9AfTFZoHm7JTFMVdvqRtT7VWLuvsMkhICMZ6VLASMZKBU77n9ARQjebD25vA4qLVLHQ9rgVZWvBQ0mXq39+7HFjEnq7DkhZvdMON5rddKMX2/GnSYkon8iKtEEJM68oDW+voljevUMSRM1ts2TM5PrkKn04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783005866; c=relaxed/simple;
	bh=2Ec9jiYXechCKRl7I4u8HdM6t2VrW+3WmhKSDnZ2ci0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Oy8YB+zoNGIVeHfl5JZM52JQWtt8Li2qnXLJsiIomufz+jnhAdLueFEItVV9RPjYsdOehtP39LNVksEc5Kb8WDUL4qLQpMeh+9EpJlqNHpp6XiWi0b4NFUTGtMicdLr5pK0+fcbwOOAa/ws1gWXC7JoUIW4UUKjE1k+IsC3bV8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=K6CJ59IK; arc=none smtp.client-ip=192.30.252.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="K6CJ59IK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1783005863;
	bh=B4/bL4gNcIf+srXEuGQDsgt/y/DdFpbSYg8Urd0g82Q=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=K6CJ59IKiGQROnyByMFvX5SOpZtGlcLmNM4PKQJQyX/xkyzFhV1zk9UB3aCdPCMVz
	 niKnjpEigi2fTr8Ac2E8fLsmu47c9ANrWZOZgL9h0TEFhlSiBYLA/pysUgKlxixXKL
	 aBB2jRZkBMhWJZrSyYhWzPCe1rjtYI898j8/a/aE=
Received: from github.com (hubbernetes-node-a2ce640.ac4-iad.github.net [10.52.145.27])
	by smtp.github.com (Postfix) with ESMTPA id A9C6232E00E
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Jul 2026 08:24:23 -0700 (PDT)
Date: Thu, 02 Jul 2026 08:24:23 -0700
From: raghava447 <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1120502/000000-a38052@github.com>
Subject: [bluez/bluez] 7ab771: shared/bap: Validate codec configuration
 parameters
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/1120502
  Home:   https://github.com/bluez/bluez
  Commit: 7ab7714c80737f7fab71d1ab083274cf257cb341
      https://github.com/bluez/bluez/commit/7ab7714c80737f7fab71d1ab083274cf257cb341
  Author: raghavendra <raghavendra.rao@collabora.com>
  Date:   2026-07-02 (Thu, 02 Jul 2026)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Validate codec configuration parameters

This is required for PTS test ASCS/SR/SPE/BI-07-C


  Commit: 6e4d8000b49b493c05a4fa3d1025224199cc4990
      https://github.com/bluez/bluez/commit/6e4d8000b49b493c05a4fa3d1025224199cc4990
  Author: raghavendra <raghavendra.rao@collabora.com>
  Date:   2026-07-02 (Thu, 02 Jul 2026)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Validate unicast QoS configuration

This is required for PTS tests ASCS/SR/SPE/BI-08-C and ASCS/SR/SPE/BI-10-C.


  Commit: e0e3fca8500f260b1c4b43ca9cad84c0856833b6
      https://github.com/bluez/bluez/commit/e0e3fca8500f260b1c4b43ca9cad84c0856833b6
  Author: raghavendra <raghavendra.rao@collabora.com>
  Date:   2026-07-02 (Thu, 02 Jul 2026)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Handle ASCS control point protocol errors

This is required for PTS tests ASCS/SR/SPE/BI-01-C and ASCS/SR/SPE/BI-09-C.


  Commit: a3805221ac641d8a28f02033874df1e1ee79e15e
      https://github.com/bluez/bluez/commit/a3805221ac641d8a28f02033874df1e1ee79e15e
  Author: raghavendra <raghavendra.rao@collabora.com>
  Date:   2026-07-02 (Thu, 02 Jul 2026)

  Changed paths:
    M unit/test-bap.c

  Log Message:
  -----------
  unit/bap: Add invalid ASCS control point tests

Adds coverage for PTS tests ASCS/SR/SPE/BI-01-C and BI-07-C to BI-10-C.


Compare: https://github.com/bluez/bluez/compare/7ab7714c8073%5E...a3805221ac64

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
