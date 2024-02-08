Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE70B78B4A
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Feb 2024 14:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707401564; cv=none; b=uv9DMjAMKC7sLd1OOYZXILT5obFsgl2SILp/feTu1AmnBMs04+jZLrYbkCJ5R7LWNJegsuW52cgRf1bzHkiRCeHlmNAFx8ESv9HbO8hCI5KOGsPoCp/QnCxsHVFyIKau6Mg93KBt8EACejHP6cIJ5tW/HjyH8JeJieVjNwPi62Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707401564; c=relaxed/simple;
	bh=lIuF06a7jLQlUheI6rL+f21Jjecf6K6D0ZEEXgBud5k=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Z9PNz9ytaODDVl8oJBqAzDtC+PGGROMVO226LVV2klw2s04TBq9Izerjgq/K7SA49ncXak1iWYvul0pjFWEw4dxRlM+ErGJ4fjDyefIrVezldedROgkhU17Dl38G43BWSN4V8wz58F7Ay6itg0vKWNyaX7ofyG9JhRBWGb5/VUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=OOVIJf7A; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="OOVIJf7A"
Received: from github.com (hubbernetes-node-972c133.va3-iad.github.net [10.48.206.89])
	by smtp.github.com (Postfix) with ESMTPA id C222E8C10BB
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Feb 2024 06:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1707401561;
	bh=8N4z1nm63I10uflS9ZcL2IITXJyLsXoA6qb3ylXRUEo=;
	h=Date:From:To:Subject:From;
	b=OOVIJf7A+XxVIOlGd7H6Cix9tNA4DcqVcwQReX15bvBnKqnO5Hv2e0Q7XJyHrZQQx
	 WP1F0xj0b4CXS+/It/EtUuKCN2rO+lSJ2hgtwcafAVHZiujsp/+bYYAXqy0hjveD6U
	 c4BirOokdGJGhTTpW+pLdFamVMuC2SApB9Z6FICk=
Date: Thu, 08 Feb 2024 06:12:41 -0800
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/cfbaa6-513561@github.com>
Subject: [bluez/bluez] 513561: mgmt-tester: Remove High Speed test cases
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 5135613ce057c6ac03700097c5dd142533d29579
      https://github.com/bluez/bluez/commit/5135613ce057c6ac03700097c5dd142533d29579
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-02-08 (Thu, 08 Feb 2024)

  Changed paths:
    M tools/mgmt-tester.c

  Log Message:
  -----------
  mgmt-tester: Remove High Speed test cases

High Speed is has been removed so these tests are not run anymore so
they can be safely removed.


