Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347AF2D0636
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Dec 2025 18:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766167327; cv=none; b=PVKcXWfPON6oIgXSj07nj1+By8pl28xEsCntsTxFAn0TIphikP6+kCAG0HR4vFg/v4OJO7sTWi8VGPC4Lz3dSmWYhTVqkS3LKX0B5f7jC+uPVMhC/aV85sCRfP6NjoI3Pi8liSu2Eb3kXo/zuV1tCDOzGVTtY1Uojx4/bPq7XVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766167327; c=relaxed/simple;
	bh=wILFa4I7jJKmcQVLs75wnpc5w425JOEC5MCEU+NbjZc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=gI4n1T6fkmJzHreM+eFHb7JXfmmnG9dzBN+BQaNlsFibmlbeyqP6If8Z6ppjENl0CABe2Jy9iEi/YieoySBKm1TSgG2jqV/EjeeC6CmPc9btjxe/zW9HTCpm7Tuj7qH+zmN0yK+EERN5jCAXcjqdIQMzVzwNotq9XD0r68JiOfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=WnppeB1T; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="WnppeB1T"
Received: from github.com (hubbernetes-node-fb6008d.ac4-iad.github.net [10.52.220.81])
	by smtp.github.com (Postfix) with ESMTPA id 2F6D321080
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Dec 2025 10:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1766167325;
	bh=7YP8XZBrmClcRJhex2DAzyoqNgYAOiv8dAVYPsS+t98=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=WnppeB1Twnf9NpZm8TordZhR2bAlMV0R1pvXL5T2TkCXVJtpGu8K83VaYnZMRj8Ni
	 WaSzVIBJY60jfcA+ypyajGCPaxNbURNhMfdj0VNph2v7aeUOAJetehwMivj6C6B5Sw
	 SwBZWKg3Drfy2MZQFyZsiizC81Mtn9xhg9nQXT84=
Date: Fri, 19 Dec 2025 10:02:05 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1033942/5d8a64-000000@github.com>
Subject: [bluez/bluez]
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

  Branch: refs/heads/1033942
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
