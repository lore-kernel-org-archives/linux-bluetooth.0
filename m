Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B64C345CC0
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Jun 2026 20:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780690064; cv=none; b=lWwlZMCOLCu+NbE1OUzubuZF/3rHc+mt0mDu4gg0lHn0BJskQSdQw1c3b7w0xIFLekzJOW4a2cWEi6Zsvgndehj8oUo2wZG+J8lia5BN5l9Zs4sygsKzcrpDN+/Xa/lj7Xw7GDhXYYtj5aHCNkgaA0usTbhrH0R4tvPcN5jSVq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780690064; c=relaxed/simple;
	bh=dR3RB/3OQBj72qDHZsqJTSwFaEst78S6WFBaywmkO44=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=pITbUeoQa0AYlfIJsoTrO+O0y1IELaqR8jysoHvWIzZ6cqQMDloDHG82catxNr29tITJkN5Cm3OM7ksnPOTh7JX/a6m5ogi6keA0ihHLac/+JmA0RzX4BhFPG65+Ed0ipIgCzYW6JDMH1FeAU/d/ZlbL4ralGFZ5uLgGfpNKj9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=SxOiW+dG; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="SxOiW+dG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1780690062;
	bh=zd4uSnpguKp36LyfEnvwOdGsYO46MRlYy0H/9R9KfeM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=SxOiW+dGNY0osyR7RlSua//Nzucr9hFFKSgKNzQSCNR11Srm0wY+drmu3FYpQejxZ
	 crS478LQbyi9bNoU+63/T4Y+BIpKD5LDeZ68s01ePnlu4epjU4fu56CrXK77BvePzG
	 iYxUu7jDwGJ95MyXcHkKqG02TcPt/l8ljowFzIzo=
Received: from github.com (hubbernetes-node-f2fb6c0.ash1-iad.github.net [10.56.180.16])
	by smtp.github.com (Postfix) with ESMTPA id C078018106A
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Jun 2026 13:07:42 -0700 (PDT)
Date: Fri, 05 Jun 2026 13:07:42 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/action-ci/push/refs/heads/main/573ed2-979e81@github.com>
Subject: [bluez/action-ci] 979e81: ci: fix GitLint instantiation passing
 contrib rule...
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

  Branch: refs/heads/main
  Home:   https://github.com/bluez/action-ci
  Commit: 979e8164c387738592e8af778f78634407a8c1bb
      https://github.com/bluez/action-ci/commit/979e8164c387738592e8af778f78634407a8c1bb
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-06-05 (Fri, 05 Jun 2026)

  Changed paths:
    M ci.py

  Log Message:
  -----------
  ci: fix GitLint instantiation passing contrib rules correctly

The --contrib argument was passed as a second argument to list.append()
instead of as a parameter to GitLint(). Pass it via gitlint_rules kwarg.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/action-ci/settings/notifications
