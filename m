Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EC913633F
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 May 2025 20:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748379401; cv=none; b=UXOnULoMF8p5+A23V5YOLozt08++YM4oDra+XRBWYkJ34FdBqcW0FhaSRLCKNQoJ0X4zSo+eb2/8yUFGLo2fo2fteHXz/igWrTXqlVMy3ja/oVFY8ZmRzELpxw0g57zRT6TMk0s657MUtuyNhxcHIzDP457PEm+z43aly7q36hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748379401; c=relaxed/simple;
	bh=IiErNbraeMSZKc2f46uNukgAe9JO7xWE0nWdtZGSAgY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=au1vK+Q9s88EOgzjFuxhRuV/pVwMBrRo2eaCzUwVVENTl6Ou7FMWgVjtHqjf+OebeRGs+fmQQWtmCfV+i0lojTpwcI+EWdtweuRsQnBtbAiUW2M9glcpyswghAWIQh1rfu7aBsCR9WFpRBLElQZ+14zQ0Kc9zhNtynzX0XEPbIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Kl380Adg; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Kl380Adg"
Received: from github.com (hubbernetes-node-c2335c2.ash1-iad.github.net [10.56.172.10])
	by smtp.github.com (Postfix) with ESMTPA id 30C03920AEC
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 May 2025 13:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1748379399;
	bh=zAiVQJ9G/naqgWpYHzu6vvicq/LrTs/mEFq/0hqFyNU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Kl380Adgx8HWx5aH968BOLwNETOBiQOLScK+y0DJH1DqCwnVhEJHVr66HMsYnfaUK
	 +VWU59+dHCV1LNQW6t0VQLlTsgE4WS3PF2nMZwR6G/k2M4HKWT5IDBYaV1uY+dCbVz
	 Fn+MHPJ+LEsPEMt1nxCWHtQQvszVNwVB5MNEnCkA=
Date: Tue, 27 May 2025 13:56:39 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/f8c669-b14bfe@github.com>
Subject: [bluez/bluez] 05967f: mgmt: Add revision information for fields
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
  Commit: 05967f5650a37013fbc63b1ecd996c64f06e2011
      https://github.com/bluez/bluez/commit/05967f5650a37013fbc63b1ecd996c64f06e2011
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-05-27 (Tue, 27 May 2025)

  Changed paths:
    M doc/mgmt.rst

  Log Message:
  -----------
  mgmt: Add revision information for fields

This adds revision information for fields that were added/updated
causing them to be different then the revision of the command
itself.


  Commit: b14bfe90ae4ecf632bde3ba826be64030a60979f
      https://github.com/bluez/bluez/commit/b14bfe90ae4ecf632bde3ba826be64030a60979f
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-05-27 (Tue, 27 May 2025)

  Changed paths:
    R doc/mgmt-api.txt

  Log Message:
  -----------
  mgmt-api: Remove text only documentation

This removes mgmt-api.txt since all its information is covered in
mgmt.rst.


Compare: https://github.com/bluez/bluez/compare/f8c6693139de...b14bfe90ae4e

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
