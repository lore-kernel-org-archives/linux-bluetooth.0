Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3541DFE8
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 May 2024 15:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717081261; cv=none; b=uK0gvZo0wNoEpKLKTS6igrzVxDNTEkc6rMGN6LHPCz9it3zOH+0Kts0RkQKlodCKqGI5DJtm09JFQoN/Iwfv5AkJwvrBQtViefA4ntydq4t2rhPqhaASfSfigluqp8tsd30R0n0S6lanAOym3VghoyQ0w/pmW5AVFh7jNvepkpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717081261; c=relaxed/simple;
	bh=V/JOPG/Yzv3TattD5gR3BZWHiGICXMO3fS4RFao5UgE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d3xMb22y+C9lA8yp19z5FjAkCayGtDk3EDlr2p9VZ6sIBxuumBS8pkbzTHpjCSKfbq6NocWinFV3aZP8VqFBRoH7iZXOaHz1JGd0t38iIkcj9na2aEViPFv3OQsD2SG1D7AfNwSVzK3ftTKVJNz+rL7RCVPp3kq1WVp4Q0o1ek0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id BC7B220009;
	Thu, 30 May 2024 15:00:57 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ 0/9] Fix a number of static analysis issues #3
Date: Thu, 30 May 2024 16:57:54 +0200
Message-ID: <20240530150057.444585-1-hadess@hadess.net>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net

14 defects fixed, and 1 error check added.

Let me know whether there's any problems with the implementation, I'm
thinking in particular of the avdtp changes which are pretty invasive.

Cheers

Bastien Nocera (9):
  rctest: Fix possible overrun
  mgmt-tester: Fix buffer overrun
  l2test: Add missing error checking
  rfkill: Avoid using a signed int for an unsigned variable
  shared/mainloop: Fix integer overflow
  sdp: Fix ineffective error guard
  obexd: Fix buffer overrun
  bap: Fix more memory leaks on error
  avdtp: Fix manipulating struct as an array

 gobex/gobex.c                |  2 +-
 lib/sdp.c                    |  8 ++++----
 profiles/audio/avdtp.c       | 33 ++++++++++++++++++++++-----------
 profiles/audio/bap.c         |  5 ++++-
 src/rfkill.c                 |  2 +-
 src/shared/mainloop-notify.c |  3 ++-
 tools/l2test.c               |  5 +++++
 tools/mgmt-tester.c          |  2 +-
 tools/rctest.c               |  3 ++-
 9 files changed, 42 insertions(+), 21 deletions(-)

-- 
2.45.1

