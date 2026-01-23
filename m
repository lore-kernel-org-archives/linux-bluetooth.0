Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8212E093A
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jan 2026 10:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769165350; cv=none; b=huvl5/8kPQzdP8UAM2iPxkdCrk4V7ewYpHN+lxgevtze90P87H9B6tsQyGI/mAXeE4ExJWijBtUf79ziQ2PSkFGdFobZlpwEvfV5t5usCzI208lV2o/CLjCN535ox4BSi11LBn4QQldd/IuzxBeaLdftFkEBC/TIUax6t08c2lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769165350; c=relaxed/simple;
	bh=zPBYU5BbeyynOaUTx4Wf+ohvFWHdm9E+vIkCcBBw8Gs=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=B25GpaP/rpbt924X+OYqXbiY+i3bwvkEUK/ycPIhz40TGgJ5NHpYQYGIglAvtsVxBhm8u/x+XJeI/DyN17mXjLI2HRQsrEFY3eGQqEC+UOk6dMaB+nHUIzqzWy8QLDtCTp8QaspsbyMObbBIyxc6LmJPU48UPU1DiPnLSiJ9KP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=clVVBj6H; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="clVVBj6H"
Received: from github.com (hubbernetes-node-2ab4973.ash1-iad.github.net [10.56.181.31])
	by smtp.github.com (Postfix) with ESMTPA id C90926011E8
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jan 2026 02:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1769165347;
	bh=SyGWONxRoT0PPUtn4JAH1VUNuJhzZ6F2OeRCHqL6nCk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=clVVBj6HW6g+ZXkHKzhfwRYd3F/lNO+tHwtxGNmgNE29F+O893pdVyPj/QhKVFr1h
	 C0+6DQK1RFdNPi9TqBn4WHuMpagOwuL4DvIAQxPMNpTf9ReAySQ/I/TrXlbTfwpmO3
	 7dBOWrXNzsfsWDv98/toVsqLB64sZHIGzwxywGpc=
Date: Fri, 23 Jan 2026 02:49:07 -0800
From: prathibhamadugonde <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1046197/000000-d5ca4f@github.com>
Subject: [bluez/bluez] d5ca4f: lib/uuid: Add RAS service and characteristic
 UUIDs
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

  Branch: refs/heads/1046197
  Home:   https://github.com/bluez/bluez
  Commit: d5ca4f82128737232ab9e136dc757b3531e283c5
      https://github.com/bluez/bluez/commit/d5ca4f82128737232ab9e136dc757b3531e283c5
  Author: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
  Date:   2026-01-23 (Fri, 23 Jan 2026)

  Changed paths:
    M lib/bluetooth/uuid.h

  Log Message:
  -----------
  lib/uuid: Add RAS service and characteristic UUIDs



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
