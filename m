Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D241ACE8B
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Jun 2024 14:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718892767; cv=none; b=tj4XTadtSH+0vvpKbeaQqAxl+b1Sm9Vr0/TeDZ2fWY8lezHI2Y5ODAnPWyPsnyZiOsyEOs2Y1Vnl/h5KOdDGobmg73+oFFvsj30JhmuLHypt8+m877Kof+HiOeUyEqHsjIma+kKfmsndhI/2LFv794g6wa95p2uk2k79zKkqHU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718892767; c=relaxed/simple;
	bh=4UoQx4vOEjw9BxgsTz8NPkkfPsJD3YhTo6ztw37/Lp0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ZVnA3BsbRa/nY6atDAkeVCg6UCKIaJyQcuEhTh8BP2vQLP4r8iv/1X7vRmk6rjXb9keYXxwxk/XaREqKb4JLPuv9qZfEd34vvHSMvQFBkk9YFQbtvz7SZI7UmJtO9EaLgZ6GK0PD/IoKP02vljqmu26Zswr3H0mvVVZjDC/Li7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=f76hrFlH; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="f76hrFlH"
Received: from github.com (hubbernetes-node-107305c.ash1-iad.github.net [10.56.203.111])
	by smtp.github.com (Postfix) with ESMTPA id 893726C1082
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Jun 2024 07:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1718892765;
	bh=wVVDHD4H1bqinqC9B/P1p9iRlw/PIN+OdVpRzFH+Wfo=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=f76hrFlHi7deozqD2a7PDI5ZCvQyy/RwZSvYAt0hn3BaQGf8jvKiQIIiAJS28t25o
	 93+GH4shWEwiMXKDE+FQyVZV76KEH5xe+gRLZ+TbeLlGzBXu9fC/1nG42B/l8uULII
	 nM5E4f478Cq36KrdFDUBK2J1rSUBU3cQwQII4qp4=
Date: Thu, 20 Jun 2024 07:12:45 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/811e48-2bd25c@github.com>
Subject: [bluez/bluez] 2bd25c: shared/mcp: Add instance checks
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
  Commit: 2bd25c068c5f6a54fbe8d8ea11633d3b5f1468df
      https://github.com/bluez/bluez/commit/2bd25c068c5f6a54fbe8d8ea11633d3b5f1468df
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-06-19 (Wed, 19 Jun 2024)

  Changed paths:
    M src/shared/mcp.c

  Log Message:
  -----------
  shared/mcp: Add instance checks

This adds checks for NULL pointer being passed as mcp instance.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
