Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69144CB24
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jan 2024 20:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706560930; cv=none; b=uUZo9YTi2vSWrixNP8LcZ5nrM3K6a0z8fmWK8L8mV1eCrmhPyrBefZSOZfYH3luiiN3LXKhGuSOWfUF0fRvVl1e3UARUDzuR22WcVWX9gtlL+XubMUm76NlGlQ+tzkWICJt3sa2Wj9vYA94O62zcikB02EB+aAuYtrReFDNHYN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706560930; c=relaxed/simple;
	bh=7mzXD94rZQaDiRyQi1Wq96pjZyIZyodiE6PCsbs+dhM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=q3gxR9GqKLtlogSqzHbpd5pdTGM8WLx0zcOoV3Rk/UgcW6VFx8V0Fm16Na8nN/KXX+dqWd2Y99L1h9/ncEyCMVvbOlCmLpEACsrEk+W7gJ1LkgSF/+uGAbW/cGDsLb0aDBoOI5umdMKBLRTiF/hoHMoVYQB6Aye8F/CB53cTQ9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=T+U+/at+; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="T+U+/at+"
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id ACAA9100005;
	Mon, 29 Jan 2024 23:42:04 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru ACAA9100005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1706560924;
	bh=S0rDk4HemQAYQBC8aV9gP4oOjgdPJ8qajD4OVufLL40=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=T+U+/at+d5xbg7wwx6ROWiEiMCfoChn/npXmaP0Yeseh5jvc76srJJ7uPxqPyNkmw
	 yQ7IApsinNR2SkX2ltVPzAYDxEGZGaYMwsF3J+5jhY3m95J8cz426BUPIlXGsqCr+0
	 ESl35fkloyMg8Y1I8ERR9jH6GMqnPG266/4RLpLChHYuDLUD5wm9WkTOCGJ0dWprRS
	 dO8qmmFJs+LgiKkasZkiSBUzvRWI16M7rEOAmxJJ0dU451HXf+ovNZ/Vf6Ewo+s5dE
	 s9OsDMcyU+KuvDLT4wknXTsOtclyJsPOKMKQDpZciAxHiP/QCyd1UtvgN+KI91kcuU
	 fL5pQDFM8JvcQ==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Mon, 29 Jan 2024 23:42:04 +0300 (MSK)
Received: from cab-wsm-0026722.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 29 Jan 2024 23:42:04 +0300
From: Victor Pushkarev <VAnPushkarev@salutedevices.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <VAnPushkarev@salutedevices.com>, <sdfw_system_team@salutedevices.com>,
	<corvinus.v@gmail.com>
Subject: [PATCH BlueZ v1 0/2] Introduce option to limit A2DP channels
Date: Mon, 29 Jan 2024 23:41:52 +0300
Message-ID: <20240129204154.95773-1-VAnPushkarev@salutedevices.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 183024 [Jan 29 2024]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: vanpushkarev@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;100.64.160.123:7.1.2;127.0.0.199:7.1.2;smtp.sberdevices.ru:5.0.1,7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/01/29 16:27:00 #23447558
X-KSMG-AntiVirus-Status: Clean, skipped

This patch adds feature to limit the number of active A2DP connections.

This may be necessary to prevent audio mixing problem when playing from
multiple sources using A2DP profile.

Victor Pushkarev (2):
  main.conf: Introduce option to limit A2DP channels
  a2dp: Reject connection when the channel limit is exceeded

 profiles/audio/a2dp.c |  8 ++++++++
 src/btd.h             |  6 ++++++
 src/main.c            | 16 ++++++++++++++++
 src/main.conf         |  5 +++++
 4 files changed, 35 insertions(+)

-- 
2.39.3 (Apple Git-145)

