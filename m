Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC94933030F
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Aug 2026 13:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786022566; cv=none; b=Kvua3hwdW3WUeABEWEpuKZtpDBPReicuIGLc0NNxcsht91bbneepbPezv5WP/4klbikJtPdK/SOuTRFh7m3oE5fNMwLomuQYEkMYE7WRRPPjL9wkverKG2+m5QV8j95hU3fXnm/hBNPT/U8rZLABlIWn1eMZXDR29nf7Rx86FF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786022566; c=relaxed/simple;
	bh=Psi6/g6bEx7OWc0omi4qup9vE5L/XDcjCB7Stj/Pwzw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ORLwZIfZGFBQ4lA1u2NFl7A4ViivjY/fW5jM9y5E2KtNrFu2Jjz9DE3b3hGtgWZkeUn7VuECaENSwMIaItIPvt9jXto/uZHyGKN7AJybdEr9URszs8KatfyFy16xe6bDC+x8pEJoTcvOL5vez3lT5dF9C3B9ziAp/E1BF6fOWnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1A6513EC5F
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Aug 2026 13:22:39 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ, v3 0/5] avrcp: Fix Out-of-Bounds Read in AVRCP GetFolderItems parsing
Date: Thu,  6 Aug 2026 15:21:01 +0200
Message-ID: <20260806132231.3052523-1-hadess@hadess.net>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Cause: dmFkZTERe397/X/0rnVUF+tvXGC0o6QCDdnIn1KASgkCB94VnzvOoVJVyQziqJipp2fYCpPVniBRyD1jh9I2ZkRWRO+2LjsveY4QJggdLcEjIzrTZ13ejTvLHBPCWkD9aVYb1y+ajEt7gFPKae6m5pMjpuwCd6wNEZv6SSbzZF4KlL9PaqTaXZ9uqBlOpbXJQrSAwttbevgYXCGtdrSQsmHFWOJ1U10niGOBmaPxOGMB208MPLRSRveQIcXS2hAKTNeZ6pD6Nr2KtLc9PP5Et6IyJFvp+fSaz1HjEomphhwx1b2uBYKRM5U59dznS3VBoETy8ecxBXtM6NjjfhHR5h1Pak2JLK6qwHXZAa8qUmF0CD4n0Jr3XNVVgVb94mVDCFA6h5UXTyTIMTapaPNedGsZUxLosgtz7mJTlW+XLGqrtvVVgviB8qxbxB3bZLEDd+b/ky23c98ZJBG6Pv7oo0MdBn4coHuzbyFKifLwdRE6GgIA6ilXvQfOPDC2Z/02KIczh1Y8UotzplJKsi/AOg+V6kjsYsYytsUiFAKZMwZTg4gijun943AJLWxXalWIQS9wL0FgFpTcq2+QsZOAsdzWlwbkgVmhinYKm0qhj2+jODlgIBDVt0qLgSBFpuhvTcuiGMMyrKa00lJpM7XaLD0UITzh+ttGwWclyOtJgQH4dpiUbg
X-GND-State: clean
X-GND-Score: 0

Changes since v2:
- Remove Android unit/test-avrcp test
- Rename new parser test to unit/test-avrcp

Changes since v1:
- Add missing inttypes.h include to split-off parsing functions

Bastien Nocera (4):
  unit: Remove Android avrcp.c dead-code
  unit: Remove left-over test-avrcp Android test
  avrcp: Split off name parsing from parse_*_element()
  unit: Adapt poc_*_oob.c test into a new test

Elman Shahbazov (1):
  avrcp: Fix Out-of-Bounds Read in AVRCP GetFolderItems parsing

 Makefile.am                  |    6 +-
 Makefile.plugins             |    1 +
 profiles/audio/avrcp-parse.c |   52 +
 profiles/audio/avrcp-parse.h |   19 +
 profiles/audio/avrcp.c       |   26 +-
 unit/avrcp-lib.c             | 3604 ----------------------------------
 unit/avrcp-lib.h             |  343 ----
 unit/avrcp.c                 | 1161 -----------
 unit/avrcp.h                 |   15 -
 unit/test-avrcp.c            | 2078 +-------------------
 10 files changed, 116 insertions(+), 7189 deletions(-)
 create mode 100644 profiles/audio/avrcp-parse.c
 create mode 100644 profiles/audio/avrcp-parse.h
 delete mode 100644 unit/avrcp-lib.c
 delete mode 100644 unit/avrcp-lib.h
 delete mode 100644 unit/avrcp.c
 delete mode 100644 unit/avrcp.h

-- 
2.55.0

