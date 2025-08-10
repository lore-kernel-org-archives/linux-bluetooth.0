Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313763B29E
	for <linux-bluetooth@vger.kernel.org>; Sun, 10 Aug 2025 18:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754851436; cv=none; b=aOSO02hqsteub5/MVZR338lgeoH17hLI+e018uI9/tlkyBQn6UXFUmqo9OzQyZNkzD31RTI+6qFLyIDKMibih4peKSb2bL4xx/yCA5IMJ1CKjiIbUfRchl/kTF9GTFXwC87az2IxLy5FOGIOmG/EDqI+ZwczalXrbT4wq3nyNXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754851436; c=relaxed/simple;
	bh=AmhYz8Zfo7SyK0f04NT3HL3ICGlr/b/JgPvrwLN2kQI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=UR1JfRQxtwdgnB+NE2LXGvZhA8pXPFtNSvjpPD0RE3+ne9DhzWW6vkn5zQWXQXUdtxFh8btl8hLPVjnqeO6wZ5jsM74bprFv9BwOeCKQWIWGe/SWzeZIlfe21R7p9YGsgrrKHqHCMErPFmV0ce1zDi9HtJxzvKbImWooE3Tthc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=bf5/x56C; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="bf5/x56C"
Received: from github.com (hubbernetes-node-ffed476.ac4-iad.github.net [10.52.141.31])
	by smtp.github.com (Postfix) with ESMTPA id 46C9A20114
	for <linux-bluetooth@vger.kernel.org>; Sun, 10 Aug 2025 11:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1754851434;
	bh=MkXskeKICfY6yBfiQz308uT+wBY8zDiv7xpEpbtMArY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=bf5/x56CrOeT+ctpD39UFnym6NSp2tjKFg7ILcD2VVLUFRdaFLxk7qFbmzv1790Nw
	 FH1akhp2eZqZ1fQhAlZY5kJN+DFT8qxNgSDPQcshZwYJvYnW7AL21ztU6gPfXLj3z/
	 4VgY+HM6FHI3VjcoAib7pq9w9yqm2VERnAoSUfAk=
Date: Sun, 10 Aug 2025 11:43:54 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/989741/000000-ca79b1@github.com>
Subject: [bluez/bluez] ca79b1: shared/bap: reset local ep states on bap
 session d...
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

  Branch: refs/heads/989741
  Home:   https://github.com/bluez/bluez
  Commit: ca79b1e5e43a1fdcf37a60777171244d031d302b
      https://github.com/bluez/bluez/commit/ca79b1e5e43a1fdcf37a60777171244d031d302b
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-08-10 (Sun, 10 Aug 2025)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: reset local ep states on bap session detach

When detaching BAP session, the session is removed from the global list,
and streams do not go through normal state change cleanup, so local
endpoint states are not cleaned up. This causes problems as ASE may be
in busy state even though there is no stream.

Fix by resetting all ASE to IDLE state after detaching all streams.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
