Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BA329D275
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Sep 2025 19:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757534261; cv=none; b=CIoYfewMdmyplGCHw6PgHCMJ674HvMCGxIiT+IMqh1MdI0rlQ2Dt9Puyuda73chiDDDFcdMCJ414bfLveeot0Jg0eR11AgbZ4i47m5nzEPEOUoXa+lyqp2bQfB39ncaJEAOG2gc0J3ZhTV3FUp+5ZpEMbMkU7+FMZVLQk8SH+a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757534261; c=relaxed/simple;
	bh=qzpVChXuOQwXwZMcSDiZmy415T0A6TLYn+1WHvC9PVU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=nAw/DHLprp75nY0iyadcF3p+upLqNUjuB4fygiVjXih7my0hfN75st7yO0axnZjUnqJUF+ZmdREuT5abifiCMDh2BIxlNlIcbaTD3D/aPu+5dRozN7/a2tUOklQ7zDOEjtHHIMgDLw5WjeC8OqIn8wXWnEx+CWXDe2h3+8t8XKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=HuArD7ua; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="HuArD7ua"
Received: from github.com (hubbernetes-node-2784c81.va3-iad.github.net [10.48.173.31])
	by smtp.github.com (Postfix) with ESMTPA id E92AC4E0A20
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Sep 2025 12:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1757534259;
	bh=2w6J261q8Y3OXseucOGeOOX4X2tpPG23qZOJH07rOs4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=HuArD7ua2VGLT766mWzJiPzWn5Hs94Pt3n0XfsziRcUfHDXnyITZg5Lhpuj7GB8wr
	 sUSIKZagl2jeWUB9BfmtVx3EeSW/4uivVb0K1HCCgNcky4RozQPjEEoUGmy1mErmbr
	 3u42R8WeJrJreci730xrs2rDMojzkIUW1HNxJPnc=
Date: Wed, 10 Sep 2025 12:57:38 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/990211/3bcf3b-000000@github.com>
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

  Branch: refs/heads/990211
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
