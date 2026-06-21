Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDAE274B2A
	for <linux-bluetooth@vger.kernel.org>; Sun, 21 Jun 2026 19:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782068870; cv=none; b=bxJ0AnBhwVmPKvv6616SRBRglyQMw/widZcf4oWGapNsSPt6WKMil6bsshDx0z+PpRH3NGzt8P8PYQBriW4SkeGo9/o6/1x6y2QBaG9RAAanMTOTVDOpHee5HQvVBmV9mLCPUmlb94Jwn0U18YWo8xJMQ4Nxpgjl7/aLUy2EZjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782068870; c=relaxed/simple;
	bh=JN6QWX+eylTfqEPh7xvs/e/GKZo38etey+C7ntu5Sig=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=RHTSydI2CD3PoIbLgNIo+w5UqN/UERpqjo0PcVl8xeSPUknAdX+8cyPqQNxL9/HWKHRuNw3XXMTrbKX0pDH7e/2W44MJkY1Yc+QIZWaclwbtD6c3t7U4N6LrcTAyXZZUzzpuMKKn3FT8dORA9TcCUv+jOddvLRVjDE+SPsQ5rD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=iK9UqPqx; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="iK9UqPqx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1782068868;
	bh=VEKkGPeeS2OmkPeLUV4AWOo8kIpCwliDhFwmFEt+ZwQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=iK9UqPqx1bKopf4mGxHu/eyz7rhVqt/tsokEsYzdtypHHJVUuQRd5WhwU/bZ55u7M
	 qw1mkBz6jqit+Z3DdLb0zqorpg0E7kJGRhK4H50EyDEiTJmOqOKG9lpuCShnHBGLfc
	 xLmORbVhQEcj/H1GMsOBnZ3b8BMXUwESx2eVu/AQ=
Received: from github.com (hubbernetes-node-2e8a199.va3-iad.github.net [10.48.201.60])
	by smtp.github.com (Postfix) with ESMTPA id 7886E800FB8
	for <linux-bluetooth@vger.kernel.org>; Sun, 21 Jun 2026 12:07:48 -0700 (PDT)
Date: Sun, 21 Jun 2026 12:07:48 -0700
From: Arnav Kapoor <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1114381/000000-7da905@github.com>
Subject: [bluez/bluez] 7da905: monitor: Remove dead assignments in hwdb
 helpers
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

  Branch: refs/heads/1114381
  Home:   https://github.com/bluez/bluez
  Commit: 7da905fd1f43fd80867c319a9a13cd9b9eef6530
      https://github.com/bluez/bluez/commit/7da905fd1f43fd80867c319a9a13cd9b9eef6530
  Author: Arnav Kapoor <kapoorarnav43@gmail.com>
  Date:   2026-06-21 (Sun, 21 Jun 2026)

  Changed paths:
    M monitor/hwdb.c

  Log Message:
  -----------
  monitor: Remove dead assignments in hwdb helpers

The return values of udev_hwdb_unref() and udev_unref()
are assigned to local variables that are never read again.

Remove the unnecessary assignments.

Found by scan-build.
Signed-by : Arnav Kapoor <kapoorarnav43@gmail.com>



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
