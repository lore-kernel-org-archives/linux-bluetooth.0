Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9BA3D6494
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2026 09:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778059123; cv=none; b=e7nOtJMotW2f5tnWx+ccqpCry3OO9qa+HaEq+KMPpuBrZ7UMypUtzi6SF/Vo/jgVG1m2HLgbt6qerbTPpRQ91Mf1dLeH0MgIvtihvJ9Gk3Ycq5DuNiIJPTm1V6hu2SAQCRHmQY7NNOG26zADztZzQCHnO7WpQ3t15zQcDjIkA8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778059123; c=relaxed/simple;
	bh=H4oglBFwOfW+X/SIfsrLly5FOW3xfAR1t0j88/80APE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ZHp4L+EFPh3SLixwyRRhS66tILEFIoLBwGwOxr7mLm81vhEjboBgf2rAiziY5YH9w7N2KP6aSTh76gViUmpC4EOo1ACji6N3I7AYEmGfPP/r9tcRQP+m+zH+DXu+9URPFIbHbdJklx9cH4H0jQiHNxhTDWz3YMbdxJ9diNFEKSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 151573EBBB
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2026 09:18:32 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ 0/5] Add helper for "cleanup" variable attribute
Date: Wed,  6 May 2026 11:14:21 +0200
Message-ID: <20260506091824.2920716-1-hadess@hadess.net>
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
X-GND-Cause: dmFkZTGs65pZijBeJPT3bvhbSX+LjsP4eJgZ7+MGlp8Lo+ZrGukRQzxy32xJzZaBORj/JXqXcuZpi7j55kIgiLoi3ZHQMmsbE45kbFFCibwaUa+nHEvxpGBiT2k82dzMg0sEDXv6d2xjOJxdTsu9ThBAT2pDjwRPRI7mTmpA2kGil2Ww9qV7+tDNXLQj/uYt6JQiEOEvOANkktxZDml+k5xBK1a4L8xruZ+ophNSmu3B9m4xfrflEmI0doCwahYpcTd4ZH7O1sem5sZLHA/YZRdGmTr6xh4NbJD9M8+Ee+XksG78PZmnZh6njJKzob/62HMWyiDRLn6UTsXK3ZM2+6oA9wjYJcLJHmWIa6UlGaHq2b6E/giJOiQGWtJbYSQvuIWEtiCpPndSD13F8g7JbtheUbKY+e011qBpV8hhtSrxERyN18iNnXT6LkRaIP1VL6Bsgu+dM3rx2Oto+gKvv+omEchfObabRJSkEZEBbFiKQV6+X43qcqamTS72biNr+MsREKvXV7xVF7n+SfE0UuhQl8OvFa35o3yoimQR5DN8s2rFfN7XHR4pXRsty9Fsh7nSS0pLrbQTsyS3rVItgnNLY0Pkcbma3I+iGPP1SKpOPyTyRF8DciU2J7NMPJ3jGnW1cPXwv5bSthZ7ufdCOpnd7w7y05JSpjBXNXpZNnFapiVxbQ

As discussed in:
https://lore.kernel.org/linux-bluetooth/ed949f2550f79a4bef19bd482bf8b069ad5b7e0c.camel@hadess.net/

Implement a cleanup helper.

The MIN/MAX fix is here because it touches the same hunk in src/main.c 
as the other patches. Feel free to pick it up straight away while the
rest is discussed.

Bastien Nocera (5):
  all: Remove more unneeded MIN/MAX macro definition
  shared/util: Add helper for "cleanup" variable attribute
  doc: Recommend using _cleanup_ and friends
  main: Use _cleanup_() to simplify configuration parsing
  main: Use _cleanup_() to simplify GError-handling

 doc/maintainer-guidelines.rst |   3 +
 lib/bluetooth/hci.c           |   4 --
 src/main.c                    | 101 +++++++++++-----------------------
 src/shared/gatt-server.c      |   8 ---
 src/shared/util.h             |   7 +++
 5 files changed, 41 insertions(+), 82 deletions(-)

-- 
2.54.0

