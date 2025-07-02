Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7DC27E1D0
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Jul 2025 13:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751462357; cv=none; b=V2FQj4OC6gNfsX/qIvqh2KKE07EgDBVlWAyqqIN7Nq4GwWWhUHKLUuTgJIh0h1I7tuh4IY8fGB4wTHnrL/bE2W7ptKm+OH48wNd2AQjThDlvC+SlvGJcUJvBWzLr8w2o1kziUm/8An/aLlvuHoGCEZH3a4U/miFkeSTVB66bQgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751462357; c=relaxed/simple;
	bh=NK6/oLT/nyZOb7nga60+Z/J4/uSK8wdbvVBDkZP84oU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=sO0hZJ4KmmWXwC0ZFFJfkbovm22KxnT/mY5qylCb8VZwJuhV2ISbiSX2CpROBZ3aj0RDkA40mBDyO0YD6AX7hPHucHbSRPbLUIjoLeu3EPB4oj0CxNQXF7B6Zi0UVM73dMhALJNBNVoZkbydiElVuAaxmulhxnHh4sTAE1y14QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=AiU+XUKS; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="AiU+XUKS"
Received: from github.com (hubbernetes-node-9a7dd51.va3-iad.github.net [10.48.204.69])
	by smtp.github.com (Postfix) with ESMTPA id 39F7FE14AF
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Jul 2025 06:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1751462352;
	bh=FeRyCNgVZ6q0loLDUizg4YKgWihipAz1qpwXDRws4gY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=AiU+XUKS7YyY4BPQ0SP0OXy3dUNyDzZ5KsQWirqejcVyUGRUPnO6ggsST+gC/cJpX
	 rnfYhVCnclJf8INTWSnheK69OQ7gzx+nIZc5K0DA2h1Z9YFjCxQnseXmOR0DGyKiDF
	 +pelQg/5KHx5FL+p5guwwQU1sjD2Oq8vL/JVgrak=
Date: Wed, 02 Jul 2025 06:19:12 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/55a676-248a67@github.com>
Subject: [bluez/bluez] 248a67: error: Add dedicated error domain for BREDR
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
  Commit: 248a671e518566b7cd0e0c4c63563d5b31b5372c
      https://github.com/bluez/bluez/commit/248a671e518566b7cd0e0c4c63563d5b31b5372c
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-07-01 (Tue, 01 Jul 2025)

  Changed paths:
    M doc/org.bluez.Device.rst
    M src/device.c
    M src/error.c
    M src/error.h

  Log Message:
  -----------
  error: Add dedicated error domain for BREDR

This adds dedicated error domain org.bluez.Error.BREDR for BREDR bearer
and then use it on the likes of btd_error_profile_unavailable.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
