Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDF039E176
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Mar 2026 14:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773065489; cv=none; b=fWpB5zciJnZPkVr9WObKYfkXHOU2iXCUjU5CqTMa2t/N3h3NdcrXRf6+xaify92WFGUAKIhtAhS5Sw6a8UtxMpQaKOIfpH+xMCgS29X15zwSWRcvZ0BYPjdeyVGAqRfw2uuNdBXDf855SyyoXzsNgJl0/Gsy4qof28jpwHkAArY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773065489; c=relaxed/simple;
	bh=Jm14R8m48FO/zkRKeJbAQxFb4W9qG+BGl03Y1LqF7Hk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=WpOPclDN3iBtvQyHmK0z+R7MET/kYHBDmXPLPr0uCmoHWWdMRgIPGD2ZMCLq0LlLfb6SvFJcTMDHVpBNRJJ9vc9GmlqMoQTeQ3Pz6cBlQIoyQBmAFiZxrxztm44rmOqT5I4s7BmzJNg2YB0WkjUz2GQD6k+Scd3l4QSoWSZFjc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Gv8qbOMA; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Gv8qbOMA"
Received: from github.com (hubbernetes-node-28f9453.va3-iad.github.net [10.48.201.86])
	by smtp.github.com (Postfix) with ESMTPA id 4806D1C11EF
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Mar 2026 07:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1773065487;
	bh=6szgcxxzX4dI3Fg7G/MoQZFK2iNK9ODqoj2PfrknYUw=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Gv8qbOMACxeBHuwFjUhyoCC258+IccVcTINDlstb6xK7ik5GxHSbopEtN7HYqjQjF
	 iWOrhT41vwfr5ebngENKaTEfMSZfxeSp9JOkJ9IvrBKl3z6VTZgknVwvUFLECcIddL
	 UQVsC8mm9IEVdJ+RJsLGm5SrxWB6M6QumxOB3LN4=
Date: Mon, 09 Mar 2026 07:11:27 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/33388c-121e5c@github.com>
Subject: [bluez/bluez] 9c6e97: lib/mgmt: Added missing command "HCI Cmd Sync"
 to ...
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
  Commit: 9c6e97516cb1fd8dd355405a05af9e54d2f8a630
      https://github.com/bluez/bluez/commit/9c6e97516cb1fd8dd355405a05af9e54d2f8a630
  Author: Gabriel Woloz <wolozgabriel@gmail.com>
  Date:   2026-03-09 (Mon, 09 Mar 2026)

  Changed paths:
    M lib/bluetooth/mgmt.h

  Log Message:
  -----------
  lib/mgmt: Added missing command "HCI Cmd Sync" to mgmt_op


  Commit: 121e5ca79be559c5374f8a54c6fb6e233e383379
      https://github.com/bluez/bluez/commit/121e5ca79be559c5374f8a54c6fb6e233e383379
  Author: Jinwang Li <jinwang.li@oss.qualcomm.com>
  Date:   2026-03-09 (Mon, 09 Mar 2026)

  Changed paths:
    M profiles/audio/avrcp.c

  Log Message:
  -----------
  transport: Fix set volume failure with invalid device volume

When AVRCP is connected before AVDTP, an invalid device volume causes
the target to reject registration for the EVENT_VOLUME_CHANGED
notification, which breaks subsequent volume updates.

Fix this by initializing the volume to the maximum value in the AVRCP
target init path when it is invalid, allowing the controller to
subscribe to AVRCP_EVENT_VOLUME_CHANGED.

Fixes: fa7828bddd21 ("transport: Fix not being able to initialize volume properly")
Suggested-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>


Compare: https://github.com/bluez/bluez/compare/33388cb1d6f1...121e5ca79be5

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
