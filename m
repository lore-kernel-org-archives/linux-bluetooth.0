Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793620724;
	b=2QuAs6GPczno6VvCmCH3w95PdOZSAE/U3jcdobuzxZHNbYLwJP7wX+YkPt6F6ChC8ZB9
	 cn3OkPN9j0y9cmSkQqgkyDx8Re+2Li+4IdEc5iimYEQbrCXPelAHm+bx0cpNZNKwONMGN
	 YtP3sXKR7fKBT6Yik3sj2U2MDX6Wk0QX08dib9z0cdXFPIJb0kFjxG22+O1Eprpe01AZs
	 fVyhIb/lctd1af/Agiz/YFe6QBF2RzgJkoZIEomnPStM1DM011coIpUmOkWWWl15a4LD9
	 HfcTsGdCz7rqdvT2Dxh0FC91EHd3g998xSlmuHR2QocAwHnh7LVDXSmfvyJ0MTEN3+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793620724;
	h=DMARC-Filter:Received:From:To:Cc:Date:Message-ID:Subject:
	 Content-Type:Content-Transfer-Encoding:MIME-Version:X-HM-Tid:
	 X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=QA8QHK3ZtUn9TzFs8P37lxt4nTIOC/0mWQHKcLfADpA=;
	b=L9EtcJkMJX4sUQsWPU1ogwkPeN2B5MJ/ufsKqPYnqpEoQ+5axZeTvLnOd1hrvixJI93T
	 WL4+3hnEh0YcREri11P+HiUmWfRzKtWjIXJfsKKhOwpO5mJcB3wf+ocuWtdfDQVMmMnPJ
	 6BV3rwuS6ErIhiU3nBt5AL6lPmNz2vLpwKWx3kga6XAWDQHPoik01MPf4tE4lIJ2fvH9k
	 S4iNeSX05Xu7RPNxtW/kcrA/kmG54XG/Cp1zrWFLDCLgKzwF4PkzMzPeFdTsc+inmREXM
	 ZuX8ddH8ZWMs+kK8QQV7I/2utvVkXHv/xa2BLrFIC7kaMzgA2Gg0Qh/Bg5K96fhsnGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.pku.edu.cn;
	spf=pass smtp.mailfrom=stu.pku.edu.cn;
	dkim=pass header.d=stu.pku.edu.cn header.i=@stu.pku.edu.cn header.a=rsa-sha256 header.s=default header.b=L7Rgw8mC;
	arc=none smtp.remote-ip=45.254.49.197
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069E5606A327;
	Mon,  2 Nov 2026 11:58:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 069E5606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.pku.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.pku.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=stu.pku.edu.cn header.i=@stu.pku.edu.cn header.a=rsa-sha256 header.s=default header.b=L7Rgw8mC
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa (unknown [1.202.162.49])
	by smtp.qiye.163.com (Hmail) with ESMTP id 5330b2347;
	Mon, 2 Nov 2026 19:58:38 +0800 (GMT+08:00)
From: Yifan Zhang <yfzhang23@stu.pku.edu.cn>
To: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>, linux-kernel@vger.kernel.org
Date: Mon, 02 Nov 2026 19:58:37 +0800
Message-ID: <179362071770.29269.15160948500453012976@stu.pku.edu.cn>
Subject: [PATCH 0/2] Bluetooth: validate retained LE ISO command lengths
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-HM-Tid: 0aa19c2032fe03a2kunmab045f0fe84cf
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDTBpPVktKHh0fQ0hOSUNPT1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKVUlLSVVKTUlVT0JZV1kWGg8SFR0UWUFZT0tIVUpLSEpMTU
	NVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=L7Rgw8mCoM6vbX7F72lzI/m16not6uVxNwd85cmUTgvpdwc0sK0m+oqR9Dv2IRV77dPDE/PsCoPl2/t9iGhrWWupmsUDPXkgxihjSZiLiEYIdC8YxQ5052NXGaLhecvSkil9FYwFsqpjsEdwj6ziDUaGznI5/xpJ45dC/PRfsKQ=; s=default; c=relaxed/relaxed; d=stu.pku.edu.cn; v=1;
	bh=QA8QHK3ZtUn9TzFs8P37lxt4nTIOC/0mWQHKcLfADpA=;
	h=date:mime-version:subject:message-id:from;

Two LE ISO event handlers use flexible-array data from the retained command
skb without checking how much command data is present.  A malformed command
can therefore make either handler read beyond the skb when the controller
returns its status or completion event.

Add a saved-command helper that also returns the parameter length, then
use it to validate LE Create CIS and LE Set CIG Parameters commands before
their CIS arrays are accessed.

Yifan Zhang (2):
  Bluetooth: validate retained LE Create CIS command length
  Bluetooth: validate retained LE Set CIG Parameters command length

 include/net/bluetooth/hci_core.h |  2 ++
 net/bluetooth/hci_core.c         | 18 ++++++++++++++----
 net/bluetooth/hci_event.c        | 14 +++++++++++---
 3 files changed, 27 insertions(+), 7 deletions(-)

-- 
2.39.5 (Apple Git-154)
