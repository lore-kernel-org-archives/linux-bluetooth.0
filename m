Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19542F503
	for <linux-bluetooth@vger.kernel.org>; Wed,  5 Jun 2024 02:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717552933; cv=none; b=Q0OFmn5Fr28x3uHZZqnlcC8NgfZGeHBH6Eo26DvYFbalCOC0UJiYRkluVnXwctm2eSJJb+MNbb96TajA8iVYV1hobipCjufcL/P2tZWEwET3zxF8AlCZxpPmUKlS4s3hcWXr33G3D3klc7kb8JkYXdkTniQ1px/dNUU1ol8uess=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717552933; c=relaxed/simple;
	bh=RGsuUnKezQ3GP/wFCmPjPE+DJg5n4FU7ztCfe9jT6Cg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=dDjZriuM6hNxWzPB2qyeiqkeC/r46bdstMRUJHLoVkcEXCPFmGctTxki1vRdgqRp5Kl/ZKcY1LRuCdgROfM3wcqgf5T4X++OeGHlm45Wma7Z+1cb0deGh7rcC5/AheDVoYECIh/BgiJrLXRqzwt3ONCu400XcaW3kPS/Tex9NiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=a3zFjJ22; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="a3zFjJ22"
Received: from github.com (hubbernetes-node-b3a77db.ash1-iad.github.net [10.56.150.35])
	by smtp.github.com (Postfix) with ESMTPA id 49B9A6005D6
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Jun 2024 19:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1717552931;
	bh=+pRAd3MFXtNU09TVQOv6Cekv265mfj5ubnG/oOQFAaA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=a3zFjJ22HwJkIrDMlJzHoEgsj3amKC0frV7Z9WF677uyMx+PqGo8NBoWW8CMMNIiv
	 OpZ3N6IOVdlyqwO04Q0t2MkyOo/Z+9S/YeZyHDxz4WRACeokXoC+wTl9fxeA0un5v6
	 TBAPC0CMV+LWBIjZUyu1TZsC8Hm87cawkAxXsl0A=
Date: Tue, 04 Jun 2024 19:02:11 -0700
From: Arun Raghavan <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/cbe414-61776f@github.com>
Subject: [bluez/bluez] 5c793e: gitignore: Add compile_commands.json
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
  Commit: 5c793eb3c55e718b16b1edb1ce1f45c60e6c9c50
      https://github.com/bluez/bluez/commit/5c793eb3c55e718b16b1edb1ce1f45c60e6c9c50
  Author: Arun Raghavan <arun@asymptotic.io>
  Date:   2024-06-04 (Tue, 04 Jun 2024)

  Changed paths:
    M .gitignore

  Log Message:
  -----------
  gitignore: Add compile_commands.json

Handy file that can be generated with bear, and allows clang-based LSP.


  Commit: 61776f0de7b2a272d9befe74b469f645b74b8133
      https://github.com/bluez/bluez/commit/61776f0de7b2a272d9befe74b469f645b74b8133
  Author: Arun Raghavan <arun@asymptotic.io>
  Date:   2024-06-04 (Tue, 04 Jun 2024)

  Changed paths:
    M .gitignore

  Log Message:
  -----------
  gitignore: Add __pycache__

These directories are created when running scripts in test/ in-tree, and
can safely be ignored.


Compare: https://github.com/bluez/bluez/compare/cbe4144dea6f...61776f0de7b2

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
