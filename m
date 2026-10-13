Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03635497B82
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 18:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791916358; cv=none; b=NUuHVEYEJwWDR1S0EAnHhe7t1kZqevdhbuTbikKi5y4D8BB122FvLl4UygdAd38ArmJpWjEN4L2BTXkPJXrMAuA06tiNNM8BfBOX9V/5SSta7KeivEfCIEEH4PXcLSWRNixYFPsql/IJJP+9eBzwlFAwhYyn+Cvy6FifTVX5rJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791916358; c=relaxed/simple;
	bh=CHzSEnQ7vMJbFgg3y+BRvRp6m5a+foaoanlS1aWN3x0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=tRAQcsFrO4f8Gpdk8TOFT4k7op0dzKACzj5+LrrfYSp9t5CzQyK5qjIZgdTNUnWgrMZ4BAIyjyC7UPAUnumW0kE8qB0B9oOmjBo4bjRHRlq5scNdQtKiATEC4JACrNuRGeSkMmaWRVL90gxdDFhZ/Pym7KYqfWFQfr9irGshoSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=NMueMzbT; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="NMueMzbT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1791916355;
	bh=gdhAXVPFX3zJCIAlgr7RrCAJd3OzAoFDnEtam+WAdWc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=NMueMzbTPDImvbU+l2xTmZc0U4EsNTaNUrfl4Zdk7bNx+BYMDm8XjDV2T3Vco2Ep5
	 3312YZTB8JriV1WU5XblKuXSSbXVsYfLnONtW6nBZB5KGU6Rkc0pStRl4yLzIMPPcA
	 umTqIZvXJfn1sGrmr//0yvvBZl1zX5yW1Tri7RfiG4p8gu/1JaJRgKUKzvzFGdfNnT
	 oTlG8jC80jhCS2gv9MXXrxiD1z+h7g0abZiomBEd8Z+GUToNZmK+pG0suTdx0pwk+O
	 VpohtwEUFlDhxEv5Z9J4+NDH3BBkeMPZQu2k/cXanYIDsUXJb86B4eQ7qtcpCyl1gs
	 V0iCYXdUwRcOw==
Received: from github.com (hubbernetes-node-894671c.ac4-iad.github.net [10.52.166.29])
	by smtp.github.com (Postfix) with ESMTPA id 22197780A2E
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 11:32:35 -0700 (PDT)
Date: Tue, 13 Oct 2026 11:32:35 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1184798/000000-9db197@github.com>
Subject: [bluez/bluez] 5d183b: monitor: Add Minimum Supported Connection
 Interval
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

  Branch: refs/heads/1184798
  Home:   https://github.com/bluez/bluez
  Commit: 5d183b9b980e191e8a14bc37bdd1ad60db6e2611
      https://github.com/bluez/bluez/commit/5d183b9b980e191e8a14bc37bdd1ad60db6e2611
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-10-13 (Tue, 13 Oct 2026)

  Changed paths:
    M monitor/bt.h
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Add Minimum Supported Connection Interval

The LE Read Connection Interval response carries a
Minimum_Supported_Connection_Interval octet between the status and
Num_Groups, in units of 125 us with a range of 0x03 to 0x3C. Add it to
the structure and decode it.

Assisted-by: OpenCode:claude-opus-5.5


  Commit: 9db1974ad9b910f12a29dc3ef75f26ccd1df5779
      https://github.com/bluez/bluez/commit/9db1974ad9b910f12a29dc3ef75f26ccd1df5779
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-10-13 (Tue, 13 Oct 2026)

  Changed paths:
    M emulator/btdev.c

  Log Message:
  -----------
  emulator: Add Minimum Supported Connection Interval

Fill the Minimum_Supported_Connection_Interval octet of the LE Read
Connection Interval response, reporting 1 ms, the same lower bound as
the interval group already returned.

Assisted-by: OpenCode:claude-opus-5.5


Compare: https://github.com/bluez/bluez/compare/5d183b9b980e%5E...9db1974ad9b9

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
