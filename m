Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999721DDA34
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Jul 2025 21:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752526807; cv=none; b=Km3RYuKCU8cPr2wJ6OCQH4tJuzhsLvR4+QqUgxfTEbmruKq3pY/XSpKoHS4oPkFpY6oPn4grbDT5jCXt6Rs2cqNvJD+E6ZaMKQ3Cs1to47IMnopwbSLe6RRkEEf3a0jmyyBzn2OEAsumciy6v8JFKzqXTFxsv3QB2CHACj0o/NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752526807; c=relaxed/simple;
	bh=+Bm+Ekr+HWdsiYGHTjUyZkKR/UNij07yXYY0JhC3VYw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=fSufvqtwneXTC+2M4o6iQKfsO1/VfZMItMJjJZLsg5x1Bq2vY+2kPiOuXMepMH0CLZ9X9l8w+aMSTH5UBGl78tPK69/oY3IBa1a/pLlJDcwtAJJXzk8ySszvJUf13HWGBLOwUmkoF8PMrBbzdGFCTEZ4EfKJepdhSQ5ggaS3AvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=mkZvau+d; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="mkZvau+d"
Received: from github.com (hubbernetes-node-f05bc4b.ash1-iad.github.net [10.56.184.44])
	by smtp.github.com (Postfix) with ESMTPA id B6BB414129A
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Jul 2025 14:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1752526805;
	bh=vkP2gQPEpUNM3JWWWZ89RugD6MGxG3Y0elG9IoJmgFc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=mkZvau+dv7Lvr2BuOJDYSA9Z4DmDxH2Kss5gQk9oUHu1ilMhwXEUCUv/C88BvjJqW
	 PKXB5tumyYsTFelfRp8MBLvFsWCmuU+vkiPDgsc4EKNFeCFOSdTUpfeX9/rhSdQ1pM
	 P8q1VvlbLH0hzbvhmqek6jtnjhrFS99lusWWVTOY=
Date: Mon, 14 Jul 2025 14:00:05 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/981640/8b6c28-000000@github.com>
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

  Branch: refs/heads/981640
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
