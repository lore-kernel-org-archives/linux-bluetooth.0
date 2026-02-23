Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0FB5695
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Feb 2026 22:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771887444; cv=none; b=JSjbiei/XX0l/t8pNSz1jWHOp9DyLaGSF+PSWdoeF0Bud6X5/6ijkkh3J330j8gW+GPzQNX0KDByq+QOHrX49ceGcqtwlBtx+wrOdA7QYsWGV9q97SL/WjSgANETWG9tQgoJJbK7yuYRiPDrw93+0NPFhz/AY6h4S/Id4sa22p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771887444; c=relaxed/simple;
	bh=80zepsma+/YVws/Ei3JREcDUSJmiqyNHPGcVJHsWE+Q=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=C+zMPmVbM2YjGN1ELSyNY3cFDrZE5kAqmw3Tt0XieTIfPMkjfiNzDoPRaG2giux6ZmRvgLzF8CiWNLu2BRMiO8+n2ZNY0UbXtPqz/stAdxF79w+IKQvxFBWRYrH7fU1Ks7db0KdO8VBVr4UB2mjOgJAHXrlAf5Uiqt43vHExejA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=O4d1cdzY; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="O4d1cdzY"
Received: from github.com (hubbernetes-node-8ded26f.va3-iad.github.net [10.48.131.46])
	by smtp.github.com (Postfix) with ESMTPA id 54C9D4E09E9
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Feb 2026 14:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1771887442;
	bh=xsySsnxTEjuVvftG3dUeyQv4sXoVfrX0/z2fjkzCMXc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=O4d1cdzYGy5+fk5FoYc+alKODEUtLFDGpcfMn2UoU2hYNwIuEK/I2QMtZ1ZaeVWkv
	 g+B73jHy5+FzJiDt4DEMN/fjbZhmcj3csL7agTmrXlP0h3Wk+riV6OYmZFQ8TqplbM
	 XrSpamzQJPfC9jcF+BZI28CcPVNbLiHPjl3VdpGM=
Date: Mon, 23 Feb 2026 14:57:22 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1056016/752bb0-000000@github.com>
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

  Branch: refs/heads/1056016
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
