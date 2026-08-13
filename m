Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5ECC23395F
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Aug 2026 04:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786595359; cv=none; b=JPZ4QJNDtKZO/A4hjt1886gKortW/oyz55StnMvx/vwGJwUdl3DvdSW62z1KVzZz24+vbDUkN4tanFuKxZzb6b8OudymC83gKIpY8SOXRj8zjHdfGgVp4qzFjvHjJ8/mpFN251iLsV4FheNSaCDm7QD4lzSrFt53ZRL8PwLt1Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786595359; c=relaxed/simple;
	bh=SvyLtOw/94DFnl7V0FkuuBW1JyLZqZAEf5HB1uCTUHI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=gqGY6wOj4k80g+5Ex/mDJGA7AP3XrTIQYrApWd7LJipJ3+3wjEqI1eoi0lV18WM0P2cSlULvPJIf8ZqhwKVhoofPo220nOZxkfrTebTHi4rEXbN03tWM03P91k1hrI2DtpjNZkV+Mar+kApF4j0azqUaCqBz93vP2dkTgrlAQ+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=gV2Mc1GB; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="gV2Mc1GB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1786595358;
	bh=ehKsU8YXUP8oUn7/JkzqXS0yvht0K7lWu4+kvMXS3wQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=gV2Mc1GBIRsc24oc1vp8mDb62YXNqb1mWdgeVub2u4tvRmG1DTfHIo/VNXYMNwIH8
	 Sl+MpmLxag1rNtNDd2wqEMkqmUDp9rfS9UN0RYuCrSCTJWTxX6TbClU7s8N5vljl88
	 TW6q31n1rPCWSdOaXyYeePWFMkhs5E0HNPaBO9F8=
Received: from github.com (hubbernetes-node-c72bfd2.va3-iad.github.net [10.48.145.59])
	by smtp.github.com (Postfix) with ESMTPA id ED25A180C87
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Aug 2026 21:29:17 -0700 (PDT)
Date: Wed, 12 Aug 2026 21:29:17 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1127021/a894f3-000000@github.com>
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

  Branch: refs/heads/1127021
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
