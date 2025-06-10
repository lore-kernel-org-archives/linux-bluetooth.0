Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7B4244186
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Jun 2025 15:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749568790; cv=none; b=Ukn8RRgwChdVtJ/EdWLYfZPE2kWbnzq4fEFdBwyo5PBtVLZnQYoHQiRfWQJ0niOhx15a3ek1lxIQB2x/KQetuw2MTs3JZe05yodNNqwTGxvz4XZeDM984LJtPsl8POxnF52kmlW5JzqJH8AMFeb4YV04u3HSg4zi8HUdf7WfRD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749568790; c=relaxed/simple;
	bh=5ccctKcyebKVC5qoq7dCchGItQQc4RRgyAf8celwWog=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=h6Tn7a4XzPYVG03B3AxZiojezenTDvehFnev8RbiMRZoV7ZM2YcvHnSDar6t+tP2VVQ0Z37ZLwi6YXWHASmM5h4YqkmUgwai55FBaz+hecwl0qn08dSgR4F/Ks+3bP/KbzlzvaQ02MdlCInUcnOeCwoPlpfoNJrpl8kSao/Edz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=N4lVR+FS; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="N4lVR+FS"
Received: from github.com (hubbernetes-node-e5258bc.ac4-iad.github.net [10.52.148.36])
	by smtp.github.com (Postfix) with ESMTPA id 8031064125D
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Jun 2025 08:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1749568788;
	bh=RYtW35xGxRXBZPo9szuW8lSFMEBLAlTY8x84iq/23D8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=N4lVR+FSWTh4TeOw/RBSTKVrf8uJqJTepnRu7FHbDlDKkoFbi4k1ORs1jKix0pQV3
	 1A+fsr4XLzJHbSeQmNYU0Xn8DJycdr6FWRYNvcpWCrbGZKb99sJadWQRQ8MZiW5pvT
	 uMtjZVY3kHZk6To0ffNm5d9//kFXxF0w3Ua5bPaI=
Date: Tue, 10 Jun 2025 08:19:48 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/970417/000000-ff3f31@github.com>
Subject: [bluez/bluez] 398649: btdev: Fix not setting sid on
 BT_HCI_EVT_LE_PA_SYN...
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

  Branch: refs/heads/970417
  Home:   https://github.com/bluez/bluez
  Commit: 39864922552ee23de948994e7bdff80102fe8c24
      https://github.com/bluez/bluez/commit/39864922552ee23de948994e7bdff80102fe8c24
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-06-10 (Tue, 10 Jun 2025)

  Changed paths:
    M emulator/btdev.c

  Log Message:
  -----------
  btdev: Fix not setting sid on BT_HCI_EVT_LE_PA_SYNC_ESTABLISHED

The event BT_HCI_EVT_LE_PA_SYNC_ESTABLISHED shall set the SID accourding
to the value set in the periodic advertisement it is synchronized since
the kernel will use that to complete the connection and notify the
socket.


  Commit: ff3f31db9cf457c4944bc51bb993bc0dd3549b3f
      https://github.com/bluez/bluez/commit/ff3f31db9cf457c4944bc51bb993bc0dd3549b3f
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-06-10 (Tue, 10 Jun 2025)

  Changed paths:
    M emulator/bthost.c
    M emulator/bthost.h
    M tools/iso-tester.c
    M tools/mesh-tester.c
    M tools/mgmt-tester.c

  Log Message:
  -----------
  iso-tester: Add more tests for getpeername

This tests setting SID for broadcast source in adition to existing test
that was testing broadcast sink only, so this adds/updates the following
test:

ISO Broadcaster SID auto - Success
ISO Broadcaster SID 0x01 - Success
ISO Broadcaster Receiver SID auto - Success
ISO Broadcaster Receiver SID 0x01 - Success


Compare: https://github.com/bluez/bluez/compare/39864922552e%5E...ff3f31db9cf4

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
