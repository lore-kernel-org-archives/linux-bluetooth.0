Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABA72F5474
	for <linux-bluetooth@vger.kernel.org>; Sat, 18 Apr 2026 17:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776531861; cv=none; b=cXYH4UFH/nfhf9VgEM/21LTpB9C2c3bLYiDYy/7ytpCAqypAo+KOJFgqb9Rv86wIpkCrtsUGAgCirwaTmi0I+ate9E+gChpwHKNGIxNJ5driZUU5712m6gbEVSCWmSgdyUwg9X6HMiX9/TnyUjMHnmxiaeBzjLhVEB5WJrlDz9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776531861; c=relaxed/simple;
	bh=GczUPpZdPL1QQU+k9qQNyIjk56f9Nh+WuB3yj85hnik=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=p3oZdpNByz9XuXc8JpjFYdXqIhIpZdA8DT98pPqKPi4QzcQ9Atgn26LaLtwYxctNfs3i7pf1Z2RoIAtxb7TJOcZRZk7Vdl9EdQG4MeYNH2+C17KcPA3tKlqhjF/ncxoXhoKn+FnX8DRi46zUHWPC7r7bIMB1+unGLYtrj984lqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=KYAM46q8; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="KYAM46q8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1776531860;
	bh=DTFxSYCwefijTT6Ggbz3gaEXfxvUOyMSveF7TIYZd2o=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=KYAM46q8PieKMH+jaVPxL84p/CIf/BOsCVoZrNeJ/jmryoGw1kOa6GCJnrh9iiaxo
	 uE+ohCqRUTjLSezy3np2RL0T7joRCgj2dmZrc6OX8Zsz0bIT+WHVrZOZbjUHxxCr7r
	 ajuxtmNrocVa6pqLIXlo9a8yL3tuoZQ6Quw6plBQ=
Received: from github.com (hubbernetes-node-3c0ab49.ac4-iad.github.net [10.52.207.85])
	by smtp.github.com (Postfix) with ESMTPA id 48F2D2104C
	for <linux-bluetooth@vger.kernel.org>; Sat, 18 Apr 2026 10:04:20 -0700 (PDT)
Date: Sat, 18 Apr 2026 10:04:20 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1082799/0e78f7-000000@github.com>
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

  Branch: refs/heads/1082799
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
