Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283DE322524
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Aug 2025 15:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755702084; cv=none; b=c6xEyvmZ4gnbb/v76anBhxEKCv0XPlq0wFN+ciFTi3A7w3WGHRmqU0Z8y5ba2yMx2Sq9oAZUWkElihA4d6qImLRAleRDC76X/gM0wOW3pamvXaV4GnMeNQjBBj+YaF8oFEnEd1TNcloqh4V63aaQMvOVTj3RCz66LjEZgW2avyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755702084; c=relaxed/simple;
	bh=na7ExFn8eDF5zFOGGc88HxXc/XHKgs2+t2P5iSW5Qvs=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=V3/kKqpsp3z28j3r58b9yjh/rHSrmUM1MVBAHehs/OqSmBNTR0yiFS78HL0jImFxV+UnV5eZVxmmBZXXq+jYkd4Uy0qghJD7RskaCi8w8PGUdgOIhUKJ80vEkUsg8WjyEmAd5Mo+J/AzYQs0OYSh5CgBz27ekGoPIsbc2VcV9l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=bng5rDW/; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="bng5rDW/"
Received: from github.com (hubbernetes-node-42fa868.va3-iad.github.net [10.48.136.32])
	by smtp.github.com (Postfix) with ESMTPA id 40EB1E0BC9
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Aug 2025 08:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1755702082;
	bh=GZyk+5ULrg5Yssm+0sEFGKwJ351XHqBaA3sJh6+i1xw=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=bng5rDW/B4efN2mosAy8hC1SFHd+AQ6rLoIJxslo1OGUvJqmKqdUBgnJCHZP7awVN
	 NAQwbBSAabLenUxVlbfMgDpB0PQUwQyyTWxrSAYvANJA1Gaxs2wGZ3x8eUCxbAUdh2
	 HskjwUy+ZRp+3iMLpg8e3d3/oT3Cicoze9Dcrma4=
Date: Wed, 20 Aug 2025 08:01:22 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/993518/0fff08-000000@github.com>
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

  Branch: refs/heads/993518
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
