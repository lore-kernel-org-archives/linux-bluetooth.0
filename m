Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D162D371068
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jan 2026 17:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769103433; cv=none; b=gXCQhooyTK3kgXCPko8uEuirSdWklS2UTcIXGDABAgFqPz22RrNSX9Pc9Yw6ff3Gxh1MslHjfmIDavS1oSkPqO2igjvI8c1GUrSklYGkm2NaDv4QkgWXvmbtIJQKr90l6iYxUYgoYrudf/1QevyAjHKrNKKIJkDM7t/ZOKS3MnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769103433; c=relaxed/simple;
	bh=BIJBAXQOwOCShVUhGTyKwKOBIZDjyGA1mwp/hAeKdZ4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=fGEayUpo0TY0Nz4gI7zv44OJfA9eVB2IH8NgBQvUYhnZN+qHrG5ysFifrlBmfM9afkGiV+TWGFl1/NQUh87PAZQo9X59DC71h9ICgv8Nu/Nb9B91mbvbcBSNBuhgeeYBmr8JRRJX0V8A7ehVKa91jyTauidHYjP6/xjsZNRCrcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=RX+8S2bs; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="RX+8S2bs"
Received: from github.com (hubbernetes-node-d242305.va3-iad.github.net [10.51.96.29])
	by smtp.github.com (Postfix) with ESMTPA id 9BAB34E0E0D
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jan 2026 09:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1769103422;
	bh=fQ2epCntrUWJsTCG4xePCu3P1ouTcfzbkLItZ31f/Z0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=RX+8S2bsBocaBC+Kyiv7OGdZm2dRnN/seN9L6wzGNO4rW943i/yT9HRtisDkTyuFy
	 5cLsc5xpg09VFSe7JX9NL08+jdDz8KDpHgSQPcYRGHl2jPcU4Zvk0RjVVp2AIqJUm6
	 4FCPFPjHNON6CBjHCbK21PZE69CeBQzViHhk+dsw=
Date: Thu, 22 Jan 2026 09:37:02 -0800
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1045811/000000-36aafb@github.com>
Subject: [bluez/bluez] a2537a: doc: Add "C" code-block markers for
 coding-style doc
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

  Branch: refs/heads/1045811
  Home:   https://github.com/bluez/bluez
  Commit: a2537a5e1fb5b1bcaa2b96eb3635682e528628e4
      https://github.com/bluez/bluez/commit/a2537a5e1fb5b1bcaa2b96eb3635682e528628e4
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-01-22 (Thu, 22 Jan 2026)

  Changed paths:
    M doc/coding-style.rst

  Log Message:
  -----------
  doc: Add "C" code-block markers for coding-style doc

The file isn't processed by rst2man, so this doesn't add a new
dependency as was the case in 0ea4e4d52c55 ("doc: Remove Pygments
dependency from manpage").


  Commit: 36aafba400cdae822dd5dbe1f23a79ec0dbab17d
      https://github.com/bluez/bluez/commit/36aafba400cdae822dd5dbe1f23a79ec0dbab17d
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-01-22 (Thu, 22 Jan 2026)

  Changed paths:
    M .gitignore

  Log Message:
  -----------
  doc: Update .gitignore for new daemon man page locations

bluetoothd.rst.in and bluetooth-meshd.rst.in moved, so the generated
".rst" files moved too. Update .gitignore to match the new location.


Compare: https://github.com/bluez/bluez/compare/a2537a5e1fb5%5E...36aafba400cd

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
