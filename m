Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29DC1991C9
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Jun 2025 03:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748922790; cv=none; b=ProwHZW3KSxTyH67Xnj1jUqKx2ckXg2ecGLr/BOeu8tA7tJYZ8vo+yNrKkkMo/rAnTo0sjf6Cs5tIQjje5qpcazzdEXQiPL5/QI+Cux4zuX+PyDqxT96caQ7AENdxUeKbSXGG23j+62Q79amsd2O0lHKbzLjcw2vdwwp69Q67lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748922790; c=relaxed/simple;
	bh=/w/OBRpGALz9BuUCKENGFen1MUjUtLH1atY6H9Ks4kw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Dqb1ZZMUZn23A6KgZ9pmsXd3wIORZB/shXNa9DoUmG0rtotGjo7x/mBLBj6ateXdx+eUQ5rOqKkyGmxVwur39UmI0T0kkJTnSGEg8fiZFORAfdjea67TMJ0MEuHCd20/2kxqD2ZalupKr5UKlM188HlnyZU1lzpOTdDa1dr7VQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=mELrLFds; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="mELrLFds"
Received: from github.com (hubbernetes-node-0f6c2b1.ash1-iad.github.net [10.56.167.41])
	by smtp.github.com (Postfix) with ESMTPA id AFEF99205DB
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Jun 2025 20:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1748922787;
	bh=e1ccQr3x4z51UgWh2c29Y+ANAtE71W4jIQHbVPGTKC8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=mELrLFdsaWWcuhSzT/4Qi/0LYtWGXjkiBJ11NgTZ34/hLj1EETwkzOmGD6Hy4JAbL
	 oqAIwIsVO8IZoM3nYVPGD0lpYpx0dZPNTYI+vIEVcU/wEngmwWKXoSj0fU4YaH/+X2
	 Al/erPHwpHN4Msycv+oghsGAskXNzHko8y3LhV1E=
Date: Mon, 02 Jun 2025 20:53:07 -0700
From: Antonio Russo <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/968153/000000-b60af4@github.com>
Subject: [bluez/bluez] b60af4: Do not start mpris-proxy for system users
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

  Branch: refs/heads/968153
  Home:   https://github.com/bluez/bluez
  Commit: b60af47078b8cd864bb0735f875f073f584be3b4
      https://github.com/bluez/bluez/commit/b60af47078b8cd864bb0735f875f073f584be3b4
  Author: Antonio Russo <aerusso@aerusso.net>
  Date:   2025-06-03 (Tue, 03 Jun 2025)

  Changed paths:
    M tools/mpris-proxy.service.in

  Log Message:
  -----------
  Do not start mpris-proxy for system users

A default installation of bluez results in the systemd user unit
mpris-proxy.service being started for all users---including root.
This unnecessarily exposes system users to any security
vulnerabilities in mpris-proxy.

Inhibit this default behavior by using ConditionUser=!@system.

Signed-off-by: Antonio Enrico Russo <aerusso@aerusso.net>



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
