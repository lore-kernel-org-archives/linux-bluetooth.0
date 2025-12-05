Received: from o5.sgmail.github.com (o5.sgmail.github.com [192.254.113.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AE03570B4
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Dec 2025 15:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.254.113.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764947873; cv=none; b=sIwF67Mg2VxJcVthc2YoYBbgb9vdTvIt6HwjaA5xHqoilM1Lk9yLpE/bOpL4ow7fIGL6JGPrabFpW5yOQFMuRbQNyTyJLGwCTPsEEv5t0eGqmglkHWI0bRA3AyRyiztta7CUVA9KhhEA1ot2lPoNGLiU0rDrYnvm3hJrSqfpihA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764947873; c=relaxed/simple;
	bh=N2xzNldilhdWj4d7azNv+DUNCmkuNwJNLalb09vFbWE=;
	h=Date:From:Message-ID:Subject:Mime-Version:Content-Type:To; b=Nq+83p3W2qyQrYyt5GyvknWLj2NQf/C+yXV556y1S7g1sdjyxazgVJ3e046IGwihYSLr9LYYDQ9UqxG580GuYhJOggED8SK1b/3CWvT0uyogtxlZIbg99VZyM6sOR2vOPO/pmNW8An94Y8dYJiX+n8FHSRm9JwPw1kgthpNIKVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=sgmail.github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=hmuk+bT2; arc=none smtp.client-ip=192.254.113.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sgmail.github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="hmuk+bT2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	h=date:from:subject:mime-version:content-type:content-transfer-encoding:
	list-unsubscribe:to:cc:content-type:date:from:subject:to;
	s=smtpapi; bh=kxv2njOemcHe8r1toMrk98dqdfEXvqKe6fmlvke9cUY=;
	b=hmuk+bT2ARX8o8D/ld3oCoxtDWj+i6rYitZJR/U9v3l3/yQtcHHSClQl2TQb7AA0FxOL
	zjBp2k6qIOg3IYtC2b71ODtomrcbNBuXpsoG/NWhNm3I8c7l4FCI11LUL8JppW+otSk8ud
	GMM8MY1AbCbAAnQtVCM5h0FVuizRKFj5Q=
Received: by recvd-canary-5cb48dd6d9-qw4hc with SMTP id recvd-canary-5cb48dd6d9-qw4hc-1-6932F79B-FF
	2025-12-05 15:17:47.733988177 +0000 UTC m=+2736745.216477130
Received: from out-19.smtp.github.com (unknown)
	by geopod-ismtpd-56 (SG)
	with ESMTP id 9MpdZfeJQgCC2MZijUgEOQ
	for <linux-bluetooth@vger.kernel.org>;
	Fri, 05 Dec 2025 15:17:47.704 +0000 (UTC)
Received: from github.com (hubbernetes-node-98af5fc.va3-iad.github.net [10.48.180.62])
	by smtp.github.com (Postfix) with ESMTPA id 52651E08B1
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Dec 2025 07:17:41 -0800 (PST)
Date: Fri, 05 Dec 2025 15:17:47 +0000 (UTC)
From: Luiz Augusto von Dentz <noreply@github.com>
Message-ID: <bluez/bluez/push/refs/heads/1030870/000000-8f3910@github.com>
Subject: [bluez/bluez] 8f3910: bass: Fix attempting to create multiple
 assistant ...
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All
X-SG-EID: 
 =?us-ascii?Q?u001=2E8ki=2FFbqwlQO04QBiriT34f6qhM6wd38+BQvADylPPTIQmeZqt0Mdj+E9P?=
 =?us-ascii?Q?ngWQlMPxccS8u9EBUyRL9UmZaAIAn9hnlu2WFq3?=
 =?us-ascii?Q?Q+4HaZ3chQYw7E=2FqHMQpw=2F15oCy7Lr+z35gjgYb?=
 =?us-ascii?Q?SxHAteocwHBGoPiWeHUDPzi6ysG64Bw9d8dDRAo?=
 =?us-ascii?Q?d8pQjXLPWgKWZt82CjKO88mbxcnBZkEc9S1tlbw?=
 =?us-ascii?Q?z6HvC6SKI42cJqL=2FfYStXfYzYPxr4FXXwOr7iNH?=
 =?us-ascii?Q?BwEaw9ZHFSXol+W7LWeBfhgz2A=3D=3D?=
To: linux-bluetooth@vger.kernel.org
X-Entity-ID: u001.h3RSp2myFsXwI84tgZKC3Q==

  Branch: refs/heads/1030870
  Home:   https://github.com/bluez/bluez
  Commit: 8f3910faea58ca55f4b7fe71072195b4a442b01e
      https://github.com/bluez/bluez/commit/8f3910faea58ca55f4b7fe71072195b4a442b01e
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-12-05 (Fri, 05 Dec 2025)

  Changed paths:
    M profiles/audio/bass.c

  Log Message:
  -----------
  bass: Fix attempting to create multiple assistant for the same stream

bt_bap_stream may change from streaming -> streaming when updating its
metadata in which case bis_src_handler would be called multiple times
for the same stream causing it to fail at g_dbus_register_interface, to
fix this adds a check if the state is already streaming then it must
have been handle already so it safe to skip calling bt_bap_parse_base.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
