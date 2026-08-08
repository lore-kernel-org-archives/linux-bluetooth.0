Received: from out-5.smtp.github.com (out-5.smtp.github.com [192.30.252.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BEC341ADD
	for <linux-bluetooth@vger.kernel.org>; Sat,  8 Aug 2026 20:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786221634; cv=none; b=WDvvMWTNmWInyHYfmRwJtBFVXPejcv7XflQdIOVeMnxyt39acIx47eo6rwlVScJnShFgO8G46serR6y2tS42VAzSy2WsJK240amGn1d3n/B679t1A43HUAaJkddyOKi9e8fYgrOIvyKfFSYgBkxeagELbcGfAn9bUUt7zZBvLXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786221634; c=relaxed/simple;
	bh=3/hyWrut546kv1fzVDGz7AA8ANUY0Lw0cH2W7q7+UvY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=PjaQ/mZELuo2IAniDZUkmDqkoKEaCVFiHiXaX54+NGmzZg5yBqHmw1RDNBSrYpMShZ4Mw6CHYeoC3HQMic7N5otj87nWF3/2jQCn3c6Yl34XefJlcCDJilBYP9lCLGEpQRAx12SEbGz7BPTz3h9iFeaYvH/d2Udh2lQxWthARvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=QNTr0ql6; arc=none smtp.client-ip=192.30.252.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="QNTr0ql6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1786221632;
	bh=WnjxS84LRmX59m5RR2jEd6wCixd4z8OiYG/F/p7dAns=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=QNTr0ql6MWG0fWbe3Ve76W3ErSs/ilxodLvgzncmm3EJaRgmuq/RJr9vAJQQOq/6F
	 iGNlmW1AErvFy51hIyTnh+fPqpk2cSDPS7ilgvCk6f07t9koTCumOHQIHA4osXcJRw
	 juAJTOlDVD9dK1UL4KMf3iHRBejN5IGq15vqsQds=
Received: from github.com (hubbernetes-node-e302c7b.va3-iad.github.net [10.48.67.93])
	by smtp.github.com (Postfix) with ESMTPA id 4A6FD78027E
	for <linux-bluetooth@vger.kernel.org>; Sat,  8 Aug 2026 13:40:32 -0700 (PDT)
Date: Sat, 08 Aug 2026 13:40:32 -0700
From: z4pdy <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1142780/000000-d6f27b@github.com>
Subject: [bluez/bluez] d6f27b: client: Avoid scan prompt when discovery is
 alread...
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

  Branch: refs/heads/1142780
  Home:   https://github.com/bluez/bluez
  Commit: d6f27b0adfa316bb060073640bb784619634f30f
      https://github.com/bluez/bluez/commit/d6f27b0adfa316bb060073640bb784619634f30f
  Author: z4pdy <305461556+z4pdy@users.noreply.github.com>
  Date:   2026-08-08 (Sat, 08 Aug 2026)

  Changed paths:
    M client/main.c

  Log Message:
  -----------
  client: Avoid scan prompt when discovery is already active

Check the adapter's Discovering property before prompting the user
to start scanning. This avoids prompting to scan when discovery is
already in progress, which previously resulted
in an org.bluez.Error.InProgress error.

Changes in v2:
- Move variable declarations to the beginning of cmd_connect()
to fix the ISO C90 build failure.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
