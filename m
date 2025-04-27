Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B865B1F8AC0
	for <linux-bluetooth@vger.kernel.org>; Sun, 27 Apr 2025 11:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745755073; cv=none; b=ZZq1o4uadsn29sLH1TqmvbSLAmjs04hCZJOGZfqkZLZcC3JEQE3+Jyz18PNZBK9zW40GV6uJBj1r9xQTHa3xeYI6j2LX4P/1cbwpU/HUFzF5OrBBF+zSpxMdOxoa2YJagczvP7X5Az4wT/dyCBpnKd3SwMOzIx3GllFgLPOr2xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745755073; c=relaxed/simple;
	bh=6KSFV/es98Rik/gcECZVfBQJK/8m9ya9pwMex08aGGM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=gbykBqJ8AIpVeLXL+j/G0CHhxy3FFUZxRmuvmzXGxMucz3jdvEEcKEtoDp8rGvM5gxV6+WvmZwREXk7qWEiUVd8AeOszcWPEAtdPw8wvU0M2o/awQF0trPuO37mNroUA7LMCmEKgYXjsgl/mdZa9nHD67/rM8lnuwKdGeZjHjlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=TlclaTMl; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="TlclaTMl"
Received: from github.com (hubbernetes-node-f829d26.va3-iad.github.net [10.48.164.12])
	by smtp.github.com (Postfix) with ESMTPA id C2CEE4E054B
	for <linux-bluetooth@vger.kernel.org>; Sun, 27 Apr 2025 04:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1745755070;
	bh=KdIws1NbiYjqAoX6efeudVI9DvfoEBZYEa42ilaS1pk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=TlclaTMlfZT8ELb8NopEiW1a2RJInqam7wThvNI8cY/tzW+HPDWcNkow+kxanvD1X
	 KfGnZI1rxSKZbAt7W4AT/znxMtc38FhhcCLbUIrHZO3NnZENX49rBPvdinHY2BhngE
	 OF2kZm1xKcEkUrHBhZNlEynZnV0xzZuSUsZPr7D0=
Date: Sun, 27 Apr 2025 04:57:50 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/955480/42d3e7-000000@github.com>
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

  Branch: refs/heads/955480
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
