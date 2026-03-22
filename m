Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470003B7A8
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Mar 2026 22:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774216865; cv=none; b=SfaHC3apUKifFtmKJCgJtc3cJ3QkaRkUKa7iNDP2cE995iG5r5hNru3c9pzKpXrU7o3WY4zFC/JrCL44EZcBST0itmYa/MlL3YUVVRV01NXzht/ZOrsMJAy2E0lDtYSUCpc+qI1jUjTRatJWKcSpy1o0UtF+0Skn+imf+qXGY9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774216865; c=relaxed/simple;
	bh=UuGHbdokGQyMe8/MiG28mPSmXBBY4BenLqc1EMH0928=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=RN0rPHrVUN5V7h0j2zv7juPRCcKYq892vQhGNfIOtr6nH7M+45qc+snK4itXYApza9aPYBbA6wc72JalhpcUCejPLjJYoYdOeu9Ocj1t22R9oCXeGbd/1jWoCPnzBH+Til7Po7EOUkZLIR9rDCvWCsHwXTWhjUwep5RRRd4o28E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=github.com; spf=none smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=k6pkY60y; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="k6pkY60y"
Received: from github.com (hubbernetes-node-2d2dc45.ash1-iad.github.net [10.56.207.82])
	by smtp.github.com (Postfix) with ESMTPA id 833549205F2
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Mar 2026 15:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1774216863;
	bh=VB7D//NLGbMqJyWxDH9j5A1zU+AC84xE1SnxAeuJ4Qc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=k6pkY60yY+qDeHBYyMq8pXKp3D03RzlIzk73GmAoF9c9fYHvzatjujD5YYC0hAP0z
	 b0ZtgPuZ2q4b/pcnsDuQEvF3WJ0bA5f9tmbme9Lzw98YzYEuEpqPViNgPkI3NhL4Yg
	 Z4PrISqME+3HNHYv9sZQq4v1J0h1XdMlZqwySsjM=
Date: Sun, 22 Mar 2026 15:01:03 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1070106/e9e0d0-000000@github.com>
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

  Branch: refs/heads/1070106
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
