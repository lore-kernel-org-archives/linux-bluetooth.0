Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80CE3F44E2
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Aug 2026 14:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785853483; cv=none; b=Vayw1zdqVnHr8w6wqKE0wj6QbbBV+2OsaKsHpDEHg2N6qqPnkxfE9ZmJR/Gy7QaJUJi05QQ+EuHAEXRZKIljwLkt95vR3vlxcbTd0PPjrk21yKtQ99/zLMJAwCsbonuau+JUm+iXjH2K/T6M0DvfQfFx5+8vVOYo/BUjPFfzwyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785853483; c=relaxed/simple;
	bh=D/pACVZGSZnR9I9lI0dSlElnAcbj6kH69pLXfejDBJY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=MUS+1/9FMB6HArsQIZnV6WnFLC0fwQfpSE6Vyq8wwsEEgOBvm6Rs3xcwZkT6jx7OBmOghlPxijePEhSkEus3sFIm/4UaZQsgwOBXVaXt4Wmczet7N3hmeKWJat1CvU2Nw0cfTYgRXNq7/1VNU2lBvupA5PXymP6GQbsnXzkOzB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id D68833ECDE
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Aug 2026 14:24:27 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ, v2 0/3] avrcp: Fix Out-of-Bounds Read in AVRCP GetFolderItems parsing
Date: Tue,  4 Aug 2026 16:23:29 +0200
Message-ID: <20260804142419.2274153-1-hadess@hadess.net>
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
X-GND-Cause: dmFkZTGoJjzgTuEpcIqmlbn0PQNvFnX3KwJcZE0BFN3yw48QOlxpttNfDpC9+avuYnY4XJAZ3K5JWBgJTxvuW6vayjfnwViqCYjid28cvGlKCGKIFhKfz3Zi4NFiL8+9B1nDzsetpP8OIv6I7qM8wCulY0/4FCRaf8GmrUHq7DNmHcSazwgd/hmTEAJmXfLvevTMelw8A4imYTknp+VKoRa9x/yH//fVDd7vNS4BWXz2xRecTAJjBmz9vUNi3YoCNgO72sD1n+G1P/JTWjdl2LQDuBaIgZol6BMHLBwuj6BYwj+oviHjP1HE/iikGmX2gJOKrk+8zq2Pf1AKnaX6aaJifrbBJ3/AMesKuFl0ygDVan/FpX3Xnh+e7wsnZC3x6SSRQLaG+359PuN/9ouej/vv0jWhIJiwTUvsWBj1Bq2NaDtgNI9jE0CYcjulU0ETHFAHTvebCBjT+nvB+ctnRD5J+7leWG0SBu/Nzk04teVFyMPl8jxHN3T22JiD8SVo+emXXMJCaok7XA6I3Kph/5XxAzoKS2RrMweUtsoNaIMxcHyO6Oo32jsI2BmIzuMDhAsmVazirZWv/eXeHCa2qNvUM+MJc0VaW0/5Nrp7fWKxqf7zQ8KpVBxtRrpw05mFdipjrYPgfoJKExP+5F7xZc/JcvC2AGCtnQAQ4GGla8xUg+rS2A
X-GND-State: clean

Changes since v1:
- Add missing inttypes.h include to split-off parsing functions

Bastien Nocera (2):
  avrcp: Split off name parsing from parse_*_element()
  unit: Adapt poc_*_oob.c test into a new test

Elman Shahbazov (1):
  avrcp: Fix Out-of-Bounds Read in AVRCP GetFolderItems parsing

 Makefile.am                  |  9 +++++
 Makefile.plugins             |  1 +
 profiles/audio/avrcp-parse.c | 52 ++++++++++++++++++++++++
 profiles/audio/avrcp-parse.h | 19 +++++++++
 profiles/audio/avrcp.c       | 26 +++---------
 unit/test-avrcp-sec.c        | 76 ++++++++++++++++++++++++++++++++++++
 6 files changed, 163 insertions(+), 20 deletions(-)
 create mode 100644 profiles/audio/avrcp-parse.c
 create mode 100644 profiles/audio/avrcp-parse.h
 create mode 100644 unit/test-avrcp-sec.c

-- 
2.55.0

