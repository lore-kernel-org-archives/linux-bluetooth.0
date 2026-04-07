Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E2C3B583B
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Apr 2026 13:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775570289; cv=none; b=Bm/s5WJql5sriG2wmyMPkgQcYAY/q+0LASNI/euBZGe48DQXxEOYcOvxhsNCy9lQRdJ/9m5kuJz1YI7sxi+5lsKseq//v4Tsln+ay+IGEi98anVOw/kmWYGtcw2UQ5NaSMPcZAK/KRumHKgns8ZgcE7AXZVRUQ0dMlQ2cV1g2gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775570289; c=relaxed/simple;
	bh=P2S3zwZSee0LRL1KuyTMuZciydfOaZ0ThSNku4tRhwQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=nyPyo2+I1X0Ur3rRobEqgHBKXt+10BKodQ+v8QTOrEaUoBEZJ91kLU8cNg/G5GOejDOshCwqBVs3CCVY00pFwgUytYv/v7WyuRuGD+5LMAtzjdIqIJop7Obt9hTMeVdyI08rH/7Prj5pfe94+droHh2RNcjczZ8Bm11uRaV1srI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=NI4Ua46L; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="NI4Ua46L"
Received: from github.com (hubbernetes-node-886a828.va3-iad.github.net [10.48.144.45])
	by smtp.github.com (Postfix) with ESMTPA id 0002D4E11E7
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Apr 2026 06:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1775570288;
	bh=wGdAP1UtSh4SbEsSvdbIShTu8g5Uv/vMhLwbSRihHnA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=NI4Ua46L6T4EJIwyzGhtKLBn3C1fksIATr/Vqi7z7ol5Qltg6DXUvrwWeiythY1cR
	 HQ8tRaZ8UViYKN97wa8r992DeWA2fqf2BjvuJmw4ESuYkfzGvwi2P3BSt9I0FnLfdb
	 hveau5X5vk9sxDu4Mjzhhj/yQwhkLZYSMVaYrmus=
Date: Tue, 07 Apr 2026 06:58:07 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1077784/7f24cd-000000@github.com>
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

  Branch: refs/heads/1077784
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
