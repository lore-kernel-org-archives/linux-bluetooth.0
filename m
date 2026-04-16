Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0596D3B47E2
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 14:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776348610; cv=none; b=VKKxMpGAvzAOFW1yWpvcmliGgZp938W9rrKEXU3jP6IDieF3EdnUcmMWtvG53rY7MT2Aq73SufHyE4Dgis9MzsqFugzLY2H6fmKLSZgZ1irGp3E8213puvdj19bo2FULePHLuTVndKZJHt5qvbaIhX8qrG1p4/31rIxLLHxV6/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776348610; c=relaxed/simple;
	bh=KQ/hR+xsEcIkiHGTqNQYGQFi5OxKCwRmvRbY/XEDQ6Y=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=XyZbMUcK1jZr+ANErfx6AJqgV8rS1J8cKwPI5yL/82QdcN+nc/dwsQejs3LY42tSWDkdkFG8yJ8w/bqHDvdMge7/SjMiKFmjnSOwCdo/XqKeiBgDUYBWnQjbpCWfqH6wcUsrfurXFeIFcDYRjc+dV1QdDaf1BVs06BP0Msz17w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=CKmLswJ7; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="CKmLswJ7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1776348608;
	bh=0gdiqKBC1CtNd/4ZKc5PgPYKAM5TzAyh58t9yxqfumI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=CKmLswJ7nVtBp9ttNI+ivVVRZCaCscR5vbcar/TCs1AmbonUjip0sJt/PQZy5XX1B
	 uj3ohQsjCmjcV2rYzNaXT5e72aFN9HzW6isQwNnpxEYtq8hqqYvAGgMpWbiPmPukz8
	 mW/quwFQVWLYECN3SjqHfTdK3UOx/UBBgdWjinIU=
Received: from github.com (hubbernetes-node-7022585.ac4-iad.github.net [10.52.206.65])
	by smtp.github.com (Postfix) with ESMTPA id 324C5941268
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 07:10:08 -0700 (PDT)
Date: Thu, 16 Apr 2026 07:10:08 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1081970/a99137-000000@github.com>
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

  Branch: refs/heads/1081970
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
