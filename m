Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0260D45BE3
	for <linux-bluetooth@vger.kernel.org>; Sun,  9 Aug 2026 08:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786264495; cv=none; b=EzQiFtSCxM5YOnypo8MIoi/aPGasZZ1QeU3ATumu9+jrsrRepz+MRmeNA631jZe85uiiupwr7UR05BDeqbEH1bdqbLzN01Kck3f+3jJudIZlkdAv2BL9GC0QPwCxlQP8IkO0G82YDC7qlRRmOAsHIZJUzHsnJALQjAC4ErtvWDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786264495; c=relaxed/simple;
	bh=Q5Ws3hysFw0MBrZyMGO/Ej5kMczLw1rJiaBUqI49lFY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Psf3WUNDCC7mmuz8ZQiWh1ExzFcURqxmm3P/CSB6QQgAISCEEF1IYQes3pIljBLg3kn6CWfgv39KiNBpgwEjPp1YTr1GGs8g4GOk+vRAo9fY78yYdlK2666V6dj0v78jGKMgwJDJL7JYSLrrQOUgKpXqLW+qEm6PO8eQhIriyHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=TmEyrAZH; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="TmEyrAZH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1786264493;
	bh=HiS8RYoeF3iYOZwafrKFupEuXj7cCR7XuxmLOcKnN7A=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=TmEyrAZH2+R2eBw3WIbDfl4GLz/vKEJ5cFX4V9wChk3cXYq+pyh5d3odJTjhGMOfS
	 Jv/61dIHCzkHqLVnq45DZahAJt+aONO9o8VesmAgdcsF+owKLnrgKlbPzOkTmD+o95
	 WEBLF2JwgQT8MT4+PUOLqpatcBbw85iKQaFKxVnI=
Received: from github.com (hubbernetes-node-011657f.ac4-iad.github.net [10.52.221.74])
	by smtp.github.com (Postfix) with ESMTPA id 3B32DA0733
	for <linux-bluetooth@vger.kernel.org>; Sun,  9 Aug 2026 01:34:53 -0700 (PDT)
Date: Sun, 09 Aug 2026 01:34:53 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1125144/2c883e-000000@github.com>
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

  Branch: refs/heads/1125144
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
