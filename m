Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717FA3B1029
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Aug 2026 15:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785857914; cv=none; b=ZSqist/yfe8i9FbvjMoM9Yl7PiJYA/sy0uuKoWuYnAJVNz9uzin/U853YgAC2GE288FP2zilupHcgo3X3bVWjrUpFJeATI+f74BwX5FILEdMO9NnXcNAdPD+ZXJXeZKzqM1PvqHtuXdsIjYHzH5nbRlCXRvdtXnzBETfAIQeZ24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785857914; c=relaxed/simple;
	bh=IcIuqT0uYZod54QoiVhFMsHBHpIK+QdMCZfyGbQpW4U=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Uwx2/nQqwSMMXymKTao7calVVHwB03/UupYId/IfP1wKTmhsRHzuIrYBz9zsfHJcDeNth741yVzXNsvoRE0W2qdMKkTlE0+i5vOOVxMVjUsF0oL876x7nJIeL9clyzZTifywr1akIEohtDBABNm6+ZU0nMviuqSBATz0BZdXWto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=DnLIryRO; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="DnLIryRO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1785857911;
	bh=BbBM/nn7p7ZTaUPN9AQwocfGW8r6mFd22YRciRT8pCM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=DnLIryROWJOKVQJS/0LVaYbQl0VKlfyJOSDMl8qjykj35+0rlmAM7U26NgfqEbNuL
	 tBGoHtyet07uOltnU8mu8TxVoQx6f5nE4fnvqUDlLP9nyl5M1pL/WenEmr5f8fJudV
	 k/kCTwOc98aH0jmZT/omI7cnpuRH0QBsnON3teV0=
Received: from github.com (hubbernetes-node-5b80fdc.ash1-iad.github.net [10.56.158.23])
	by smtp.github.com (Postfix) with ESMTPA id 53C75181341
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Aug 2026 08:38:31 -0700 (PDT)
Date: Tue, 04 Aug 2026 08:38:31 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1140113/e454c9-000000@github.com>
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

  Branch: refs/heads/1140113
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
