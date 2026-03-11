Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920F6202C29
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Mar 2026 11:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773229587; cv=none; b=jfmEWgc6JndHZM5wkuECPTU6yvCOB8QyXmcjhVR3N6+DABkUTUWdsAsLOSqXpaHsZj65uCcVkPxY/DAujQ6B9mKoCqQnybT0whWD9w5M4fpLbCNWUQXMxDhAVTZN/TwtqAXx6kcFF+G6M1Sv/sJFo5ux3xRjs3RKY86KB6xzc5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773229587; c=relaxed/simple;
	bh=cdO2yqyXMWJjGKEt4nAtI7ooJJBLJAww+lC2aIcy2x4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=dwGxAx06bfIX8rYssMaW+2aB7cvhwmCsuer3oMNmQT+bpK4847UU6c9x8zRtge3a4Uks7e7bq5ieMhYsSfyu1JlioeEWpu2tsYs/yqldpqf+l+ClcF7KKyYcoTYZn/bgpaksFfoLmbjt83VYmoDo20ZpTXDiWx2chQnLclOuJsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=cuEYuM5R; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="cuEYuM5R"
Received: from github.com (hubbernetes-node-c322354.va3-iad.github.net [10.48.200.23])
	by smtp.github.com (Postfix) with ESMTPA id C2430921215
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Mar 2026 04:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1773229585;
	bh=BEwiiQB5B5ywoA0CAijOMvz/6mvjxWJE/YDiMVOFp/c=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=cuEYuM5RNLpInNkac0vRn9oHFI2rqKLNbbkj5Ttc/CFjuyMi69Opru6Nwb955ZHvU
	 Epa05oV2vqHoTHbV5sb8bW04vD9K/vWGcs2jj0ho9vU98AueWI5B8/h6OBz4fGcWJq
	 QhAAj7ANPGl7xXco+YmM/1OygomDPxU/X7R4IISQ=
Date: Wed, 11 Mar 2026 04:46:25 -0700
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1064985/000000-8e04c2@github.com>
Subject: [bluez/bluez] 8e04c2: tools/btmgmt: Fix btmgmt --help hanging
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

  Branch: refs/heads/1064985
  Home:   https://github.com/bluez/bluez
  Commit: 8e04c27e9a48ac9c7d004c4ffebcf133642e2449
      https://github.com/bluez/bluez/commit/8e04c27e9a48ac9c7d004c4ffebcf133642e2449
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-03-11 (Wed, 11 Mar 2026)

  Changed paths:
    M tools/btmgmt.c

  Log Message:
  -----------
  tools/btmgmt: Fix btmgmt --help hanging

btmgmt when run interactively would wait for commands on its prompt, but
that prompt is never setup when the help output is requested.

Handle --help through bt_shell_handle_non_interactive_help() so that the
application exits as soon as the help content has been printed, like
other interactive apps in bluez.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
