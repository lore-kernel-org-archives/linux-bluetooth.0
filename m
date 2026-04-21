Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6917D37BE6F
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2026 16:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776789750; cv=none; b=lVo0Kyf5uTQ24L36j+7D4S1JxZfEkBPlLD2wZMo2cTDRCORKkY1XXd71/Obhl9QzpfY+SkAu27aR74Dbn32sCJ8eiuRjNWhkvzrZVakpnDg0LRTcbnBcfIU5eOjU1A7sO5Cyy9mIFam3VqDQ/U4Hj1MIsO0E4VVDjR1IBqc5RRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776789750; c=relaxed/simple;
	bh=aSIL+GW4h8XPHsEiWg5VVn8szRJnaU4iQO9gGwvICD0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=bkhet/nzyMYRwB3pyRMIuUl++YVusvQHzBMA0b7NMalN7hmVamA0k7hXq49isjyltHZnyVOxb9kQ92CBi6xh1zk959fsC8yIeYIdG7MHO/cknclrv/egfkiVdNvB8CnO/3VZkfFLtcjHRkCdp8hko5zkkuCo/yfmC6AOtFJ/ChI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=jAM4mkdI; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="jAM4mkdI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1776789743;
	bh=Xhjs3kKUcneGsBgGPx+wGDJK5vWDUQhNp5oLqK2da3s=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=jAM4mkdIQiGC1lPoHjadHtkhUk1+80/pdNY+c07WMnepsh2hghlT8kH/orDhhXwcJ
	 auBVy9i6yYFbqpObEvzmnxIDHN5EjR4c472JAFCKUtE5TEUlVbhRPNjq3kGJa7HPtN
	 EWuc6BtFv1bm1VRW/9v/vM715c5HpwbpRB+NKAG0=
Received: from github.com (hubbernetes-node-c1ff265.ac4-iad.github.net [10.52.200.94])
	by smtp.github.com (Postfix) with ESMTPA id 67DA9A1140
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2026 09:42:23 -0700 (PDT)
Date: Tue, 21 Apr 2026 09:42:23 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1083932/000000-7439ad@github.com>
Subject: [bluez/bluez] 7439ad: doc: Add AI coding assistants guidelines
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

  Branch: refs/heads/1083932
  Home:   https://github.com/bluez/bluez
  Commit: 7439ad7aaf4fedb3971c525b270b335d81e0e002
      https://github.com/bluez/bluez/commit/7439ad7aaf4fedb3971c525b270b335d81e0e002
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



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
