Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63ECD2EDD52
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Feb 2026 18:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771610815; cv=none; b=G/Cx8c6KY+ufYLlmXNmTl1u+d37fe1OAmcBvcIsnc9tIi1bL+fJUXrGUBqgtXZr3P7yM97P9Musma7doT0FbxIIyeIAePoBby3NsQ0GYFuqrJ3b3/0y4DRHq/52v0cuDidsG+rJGDftzYOqGwzSw32T8bRKzJpvowsFGA0Z7kM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771610815; c=relaxed/simple;
	bh=kLwCJruNoHNk347IMrue9YqOaJO4eLprx8J0f7+K8oA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=F8HPeiaZ46a5JInWVjGs6lcS1+UIwWJrli7agOCUKsjdWjJpL6xih/4CgSbLJajexEEahFjA1jg7RxClJClBy3hpHiJPZ14Lj5ZNIq7HWeWDGnk5i+Y8VaaFKNF6XyPvPPsfNzZUQlXqcZZE4ehzDFERg3d+nvX1SD7G8qw0owA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=DFNJBgFr; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="DFNJBgFr"
Received: from github.com (hubbernetes-node-a8a5355.va3-iad.github.net [10.51.90.36])
	by smtp.github.com (Postfix) with ESMTPA id 9934F4E1209
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Feb 2026 10:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1771610813;
	bh=0OmCVFSoVJ9X5ixx37mSl1NdYzEVkuNltI6TpVkzcnc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=DFNJBgFrLo49i09w9EcF1cBkr69GoHNKkPzf19QDZI/QicunFeGp1lHC6v1f/2RI7
	 BfL/OWAeZ8ZL3xOpL5vULyTII5DB2hSdRWQKVkF4kgGGcfBLa8uj3CHP1BSJz9zk8Z
	 vzI/PBb7VqVckdkJd5QyvSo0bmbOZYUMjeZOhaAI=
Date: Fri, 20 Feb 2026 10:06:53 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1055603/353f08-000000@github.com>
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

  Branch: refs/heads/1055603
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
