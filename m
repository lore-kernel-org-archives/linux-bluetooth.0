Received: from out-35.smtp.github.com (out-35.smtp.github.com [192.30.252.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7E5288D0
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2026 20:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776803651; cv=none; b=b+/GwNFa/4gujaL0EhsDSr4yGYJA6uNP/R5E/7QYBFgRiMFrPDARYOUl+3BhdoQuqAAZLo/KC/0LtUeB598/briFFqb041VNpLPBnI/qoTcPScecAH4EZFfkTiCySQ1smq0MIhvjIdGDct0qYdMST8i/PG5CZZm52PTzwYAaOuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776803651; c=relaxed/simple;
	bh=3YxkCS4PAI8saReWcK4Dqt0yjjlHehtLgHN3U6A3T78=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=c0MBITzuUZ8K8nk+VBwZX6cPYDkwWGm2TjdZtttFmBRWnf8z8MLUegq4/tK2gOnjL7u9RcRVVMXdutcapAj6LwRKSvYPctTRZBNXF0/qg7qnQ0Xu+cWl84SwNQH/wUqV6uzw3KAduEy5bvQx7Kh6cx6IktLjUOYRAaNLS0ZuqN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=P69viCnw; arc=none smtp.client-ip=192.30.252.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="P69viCnw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1776803649;
	bh=3OiH6gjznC2MMrBXa/oVwQsKIAHXKwCSwdopTRtAqmY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=P69viCnwTNC14pQvx+AJDf0lvC4OiYh3x+hAu1wGDI2HoHTPrX+Z0ycSRnYfg7Pwe
	 avr7GZ4yCZUDo/W1f04NXZW26PTD2LEcRvrSO/yD+yNfuhiJI/httRocizk987WxjI
	 f3hhS0iGb+6IKvy+tPPsVmYtooKG3ZRCQbE73y0A=
Received: from github.com (hubbernetes-node-5d8d89c.ac4-iad.github.net [10.52.223.27])
	by smtp.github.com (Postfix) with ESMTPA id C6235741198
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2026 13:34:09 -0700 (PDT)
Date: Tue, 21 Apr 2026 13:34:09 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/0fdf34-2c3961@github.com>
Subject: [bluez/bluez] 9dffe6: doc: Add AI coding assistants guidelines
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
  Commit: 9dffe61bd8b270681a1aa6d30f8819718c2d5a61
      https://github.com/bluez/bluez/commit/9dffe61bd8b270681a1aa6d30f8819718c2d5a61
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-04-21 (Tue, 21 Apr 2026)

  Changed paths:
    M README
    A doc/coding-assistants.rst

  Log Message:
  -----------
  doc: Add AI coding assistants guidelines

Add doc/coding-assistants.rst with guidance for AI tools contributing to
BlueZ, covering licensing compatibility, human responsibility, and the
Assisted-by attribution format. Reference the new document from the README.

Based on similar documentation from the Linux kernel:
  78d979db6cef ("docs: add AI Coding Assistants documentation")


  Commit: 2c3961e3b0fab02afa3b8388e35f190c96f94fdb
      https://github.com/bluez/bluez/commit/2c3961e3b0fab02afa3b8388e35f190c96f94fdb
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-04-21 (Tue, 21 Apr 2026)

  Changed paths:
    M .github/workflows/btsnoop-analyze.yml

  Log Message:
  -----------
  Add permissions for btsnoop-analyzer workflow

Grant issues:write, contents:read, and models:read so the reusable
workflow can post comments and access the GitHub Models API.


Compare: https://github.com/bluez/bluez/compare/0fdf34b17d41...2c3961e3b0fa

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
