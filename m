Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7244942BEA0
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 15:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784214700; cv=none; b=L9TVHkt4jgs89J08EqRBjPwC/6NzNxcJOTj1l0S3vU1N8Sfcm1eFB7nqn9m4jYU523X/hZq0HIcIJCb9jhngZddStJ65dNnG2VUOvAff7myzmYL5VldkAgWtl8fCJMKld4zbXaM3xiO1ugyWll4NRG49AcLQPBgilMSqusaNsyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784214700; c=relaxed/simple;
	bh=nUidrqGL+3rMIHSeW/cviHhtPFDZ+XAE96dudF9p5/M=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=A8KBZuq2x0WLjxr8uBKbs1B520vcGHjQcAGKhGTlj7k+xjQ7BtCQRdzix6dz0xi+C+7if+E6Py5HpR/ogEnxGs1Ker8Y7ctSmyZEAEPVNCjnUacWMVARFYLDPyJGpWpnQPDDB0d+xjBuv084UPIWa38flQ6bxbSOdnb/s91JXGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=cli6Ztef; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="cli6Ztef"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1784214698;
	bh=j7rJrYoIHfab3KXjyf+KEeRjBR201Y3fc6RtYvatyNY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=cli6Ztefa88E63gXBpG38l0SvebVVONtTzcQQ8UzmRkrQZHm0rMVh8cTJzSLwrz/Z
	 qWCAnmk1ThHqC5e+QveqjfV+JMHipaPS7ojrziBU+3NOg19y21T7Hwm4Eapl577PNM
	 1Jd4HfYlesgRMWewETJhFBTkRu9L6U5RPcuyy88I=
Received: from github.com (hubbernetes-node-3150f6c.va3-iad.github.net [10.51.98.26])
	by smtp.github.com (Postfix) with ESMTPA id 949AE8011E1
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 08:11:38 -0700 (PDT)
Date: Thu, 16 Jul 2026 08:11:38 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1128302/48f9ed-000000@github.com>
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

  Branch: refs/heads/1128302
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
