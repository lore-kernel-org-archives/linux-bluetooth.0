Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2859A3DB97
	for <linux-bluetooth@vger.kernel.org>; Sun, 14 Apr 2024 12:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713097457; cv=none; b=dUFFZjx8BsTTliNeRjN2U6Ao7xWnutUE+P6WLkwjT4sH7bgQNf4JTGRvfM8h2Lzl6LJ5/CDZ/dlYuRLdGNJSiXrgfBWHTqrFJLOq9d3VFxO5QNsCGME6nz7WI71cLaEk9d927carkieIvV7gaUr9Ydv0kMhfc+TyBzz9VJ4jYFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713097457; c=relaxed/simple;
	bh=FP3PCb8USRWCd3xus4ktS6ZCZju1O1spva6HemC/5Rk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=YVRjgf/b5+xAs0VuvLk9bSIoLe5lAewtWqHBdxKvNPiM76277FfPtI93Ieo75acJyfI7yxRIofdVShmephdq/eoG+H3UZhLbS0vrZN9h6yXx6P9a4raqHVmmp11KZ5qFJ/iqtjrYuoOdVSmlW4WKQZvg/6BVGe94OgR548SJ/98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=NV+YeuVr; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="NV+YeuVr"
Received: from github.com (hubbernetes-node-cfa690f.ac4-iad.github.net [10.52.137.24])
	by smtp.github.com (Postfix) with ESMTPA id 34F8170041C
	for <linux-bluetooth@vger.kernel.org>; Sun, 14 Apr 2024 05:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1713097455;
	bh=S/qwtBDBMCuDCjUi0O2hd8s0Gg4z//iK8izjCpfatXM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=NV+YeuVrB9+JwcBfwWWekFxMb0WnaqF51bwg8NTJJbK695orAOgta39bdET0QtkK+
	 COnRoY7nCBh9mDKH6zm+h649DtTHKmqGU8v02mgnoP/j+GeY9oV5+pGQWEgVnwS7MK
	 m46zRxvwDomRCRbnwID7UwWHMlHwrkJSYV+KcOcM=
Date: Sun, 14 Apr 2024 05:24:15 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/tags/5.74/000000-df78a8@github.com>
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

  Branch: refs/tags/5.74
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
