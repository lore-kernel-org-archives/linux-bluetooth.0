Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4E62DA76D
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Jun 2025 19:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750879467; cv=none; b=jCKwTC1WKDusVn6Q6YP9WSjMHCUR2pS7zDtdiFieECJ44L4/vJcJIbmoDDf1/PzjTE3bIthGjHML5st4P/dKUeNPfMrfan36IcckgzsTnGM1kvCSsksyjEOdADiH+BBcYQNZLrXuBNLuXlPmCa12xuINhtZ5HQll/scsYZnZCCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750879467; c=relaxed/simple;
	bh=lxZEnbX8vZ9N6sX4l5Znt+CoNoaIxIBS8vajrxyULrU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=aI8u/PagqCJmdwE4T9TfW8oKNamSOGzHgOwfT/eXs5PoTeyl4B4/2KVVblmKzfFW06bDEjgsIEyVhfU/zExdS37d4SJPsaUX10MmzeJHH9cSK+k3xxYI/jF8cYENvzqOoKRMKjPXVHXAYkJLjjq7XGnQnHMolngJw1/9RJfAjK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Z9v8ArAE; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Z9v8ArAE"
Received: from github.com (hubbernetes-node-644aeef.ac4-iad.github.net [10.52.133.34])
	by smtp.github.com (Postfix) with ESMTPA id BD4E7640E1C
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Jun 2025 12:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1750879464;
	bh=Bm+dxDwQTs1AeXAF2v7eeAE4JfGvV3qKV8w33Giwxc8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Z9v8ArAEpt5Re4Tn4IxUHdUsbawSurEQ60TbtLJeFLjpD+I13l6cTPh1zunFKTdps
	 E90sMeilYXZ74SvOU9mIpvvphGz2qihDkaLYTyOEOj68Y5ivICA1qfpMCpt8fGR6Wd
	 8YMqXS22C8wd6udY3Roh2HUB8gc/2xl9gDw8zFXQ=
Date: Wed, 25 Jun 2025 12:24:24 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/975953/000000-2ed556@github.com>
Subject: [bluez/bluez] 2ed556: monitor: Print buffer pool information
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

  Branch: refs/heads/975953
  Home:   https://github.com/bluez/bluez
  Commit: 2ed5566485fce87aba7fc4483948b39e2eb0bfc8
      https://github.com/bluez/bluez/commit/2ed5566485fce87aba7fc4483948b39e2eb0bfc8
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-06-25 (Wed, 25 Jun 2025)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Print buffer pool information

This prints the number of buffers in transit and total information:

< ISO Data TX: Handle 2304 [1/8] flags 0x02 dlen 64 #1363
< ISO Data TX: Handle 2304 [2/8] flags 0x02 dlen 64 #1364
< ISO Data TX: Handle 2304 [3/8] flags 0x02 dlen 64 #1365
< ISO Data TX: Handle 2304 [4/8] flags 0x02 dlen 64 #1367
< ISO Data TX: Handle 2304 [5/8] flags 0x02 dlen 64 #1368
< ISO Data TX: Handle 2304 [6/8] flags 0x02 dlen 64 #1369
< ISO Data TX: Handle 2304 [7/8] flags 0x02 dlen 64 #1370
< ISO Data TX: Handle 2304 [8/8] flags 0x02 dlen 64 #1371
> HCI Event: Number of Completed Packets (0x13) plen 5
        Num handles: 1
        Handle: 2304 Address: FC:6D:77:BA:CF:A6 (Intel Corporate)
        Count: 1
        Buffers: 7/8
        #1363: len 64 (39 Kb/s)
        Latency: 13 msec (13-13 msec ~13 msec)
< ISO Data TX: Handle 2304 [8/8] flags 0x02 dlen 64



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
