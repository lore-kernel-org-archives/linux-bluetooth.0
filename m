Received: from out-37.smtp.github.com (out-37.smtp.github.com [192.30.252.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4DE3A6B99
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 11:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776337996; cv=none; b=DFdtHLh6BHVBk/1GKH2qVavkYihtO5DvQ4MdN5nc98nJjo8DAD16d+B0qvWb9518AHjLnFopgMdzuep9uhfmXHTdz/7dwYfF7vBt9MoazbSDu/iNhleLaOyknAdEQ9Glklr+z2nLINVlTi52T+qxN3k9XRK0PD9ZnXfkU3IThQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776337996; c=relaxed/simple;
	bh=tqJ+6mmKMXsdZXanxd9QF+yKCtHODUPSHZN3jUGKles=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=gKifVwkr70zd3OW5YfLI59K3riULa/EjSoFqb5dNvTl3+LfhmqapzlWxyGMSbb93vkLbutFcKUfON8/JFRoixLuf6EnwtMuCoZjBdJaMwfQJgXMhssdoVIviQB1F4t27AANyCywLsjY0q650BsJPjzeDKeM/4ue+l/aGgub7QvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=iiFTapyg; arc=none smtp.client-ip=192.30.252.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="iiFTapyg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1776337994;
	bh=d6s7SyLaSa3kvmcCOOX56+7gJ17/r29YNOcTj+yukuU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=iiFTapygHR9/iKo8hT58koWl2j6UeLlGBi4OnHlPpr39lTMf+w5rkHbF6MnIZBGRr
	 01wIE5Y0u4EJ8mucJq1mwrt2U54rbY1l1ZXTPg+lZACg6hbBG8dtx5O1SglW1IT36I
	 M1qNbPamnTOkSTRFJ9Va+pRw3puojVuYnvcg7lzY=
Received: from github.com (hubbernetes-node-618b5f4.ash1-iad.github.net [10.56.226.35])
	by smtp.github.com (Postfix) with ESMTPA id 323539211DA
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 04:13:14 -0700 (PDT)
Date: Thu, 16 Apr 2026 04:13:14 -0700
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1081970/000000-a99137@github.com>
Subject: [bluez/bluez] a99137: doc: Add missing btmon-cs doc to btmon.rst
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
  Commit: a9913754f39b9a8ac38f51e9ec4de45ccce3b130
      https://github.com/bluez/bluez/commit/a9913754f39b9a8ac38f51e9ec4de45ccce3b130
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-04-16 (Thu, 16 Apr 2026)

  Changed paths:
    M Makefile.am
    M doc/btmon.rst

  Log Message:
  -----------
  doc: Add missing btmon-cs doc to btmon.rst



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
