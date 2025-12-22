Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D1932ED45
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Dec 2025 20:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766436647; cv=none; b=BAeY9HvFAYnxk0QzMByTsxHgMUXz9ZvMwNeMJrOldMJyMFu2WeZlLQ2m4o1mIgni9kLWHmaXUmxBr666Po+pvYGRn4SJSZ2uIov+Qn0TVfpOqCL/p8X7sh2OMoPCG5YvjA+dsAwGevSi3zaivd+C0gfmiWWRjV9IXA7MOykp7UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766436647; c=relaxed/simple;
	bh=QKgaYFvothNugkZjZktflMY0q3WdpVTvBaPl+Qzt3Ko=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=r8/RQque7vIvJeUGeJ9g3Xxe034+8lQ7ZmThjva1Ze7cIFbJU1Jo++F5I+vJJLoyalObSrmkrVW/EEMHKQzuN6wjDGpQqVTjuzJQlMkCu00ycVF7ouRWikT8cKKA1QSTqDrNQ+C2EPp+2BVkjgFTiXJ7SAnvlTHW+mKaC68eReI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=F9EpI9By; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="F9EpI9By"
Received: from github.com (hubbernetes-node-9563dcd.va3-iad.github.net [10.51.98.14])
	by smtp.github.com (Postfix) with ESMTPA id 6F0FA3C1018
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Dec 2025 12:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1766436645;
	bh=23CVNJoW8JnjSkbJHQHxZFdRpSBYCZTQ/djwBVt0iUc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=F9EpI9BysEyuXZZxLP3+R3N+YWLPTkpBHNZqcZU378aYDaWlER8yq3I7HO+VRI7+n
	 2rD3P6AuQytfDDBd+xk0pRzNkgJVQxCCfyR/Kei0RAjwkFS4hkKoJ+wr0sGae1gbNN
	 U+yDIWprcAnFLq9zew0QyuVU7K5BioLDUaWBd4fE=
Date: Mon, 22 Dec 2025 12:50:45 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1035135/1255b8-000000@github.com>
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

  Branch: refs/heads/1035135
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
