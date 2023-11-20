Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="GiIzmGDN"
Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F4EC8
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Nov 2023 07:19:00 -0800 (PST)
Received: from github.com (hubbernetes-node-968e6f3.va3-iad.github.net [10.48.200.69])
	by smtp.github.com (Postfix) with ESMTPA id 2217D8C11F3
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Nov 2023 07:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1700493540;
	bh=9y7+1SiAjqst519jVVGctwXxKDL014j1LAQ8wR8vzno=;
	h=Date:From:To:Subject:From;
	b=GiIzmGDNpnP98RU8WOj+YGSsWrtOB1CQsyuMQRDIOAje4X4iAV0A3fe5hsGgELCze
	 K3DhlBROIJ5a1GMVlThJEgPUMaZtDPPWXY97TbB1YHjgUavp2AaDhP0uB5aAe0ImT7
	 hkcASEwVlQAvLDpiu3hMxLhFqsNJGt1fVkoqFagE=
Date: Mon, 20 Nov 2023 07:19:00 -0800
From: iulia-tanasescu <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/8b035b-58e6ef@github.com>
Subject: [bluez/bluez] d8fc0d: shared/shell: Remove readline color escapes
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
  Commit: d8fc0dd5942e6e7b95833ee47fc4a8821c0c3421
      https://github.com/bluez/bluez/commit/d8fc0dd5942e6e7b95833ee47fc4a8821c0c3421
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-11-17 (Fri, 17 Nov 2023)

  Changed paths:
    M src/shared/shell.c
    M src/shared/shell.h

  Log Message:
  -----------
  shared/shell: Remove readline color escapes

This removes readline color escapes from color defines and instead only
used them with prompt since they are only really useful when readline
is rendering the text, so it can calculate the prompt length properly.

Fixes: https://github.com/bluez/bluez/issues/10


  Commit: 58e6ef54e672798e2621cae87356c66de14d011f
      https://github.com/bluez/bluez/commit/58e6ef54e672798e2621cae87356c66de14d011f
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2023-11-20 (Mon, 20 Nov 2023)

  Changed paths:
    M tools/iso-tester.c

  Log Message:
  -----------
  iso-tester: Add test for bcast AC 13 reconnect

This adds a test for Broadcast AC 13 reconnect:

ISO Broadcaster AC 13 Reconnect - Success


Compare: https://github.com/bluez/bluez/compare/8b035b70f379...58e6ef54e672
