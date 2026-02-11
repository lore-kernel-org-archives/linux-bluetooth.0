Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C572F2989B5
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Feb 2026 18:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770834922; cv=none; b=FWX7F5FTOTj6vLw/F6hhThhXQgM6O0YbYODd2Kuiak4SaHfB53QdV7Sa1H+aNmhgT0vKH1koq1q+A7XBUKd75tbI1TbewCBr/rLUkjAzr0otsqN5hbXeO2IEk8TiEbwA9PrnjfJXMDlFksw3f0MKzZf7qBFLwGnov1UAp+/4sTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770834922; c=relaxed/simple;
	bh=/4Eh9Pe2pJmaT/m+t00cVBvJbAlQ9qNDfHr11lw9eKM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=AdixHdtK+Y9huI1EEgUmsoJI4gdF1LnGUS+gFVo0GypiMNabblf48ffZBC0xQ3CvakN+ZZPSlSx+9GGUmIZ1u68j4H1sbNIRiCqAO98Szd5/8EH6Ogh5uGN0LMStzgCd9+gcK7GN6ExJm6yjbKJRDUuhOU57kq1N7y7hoOmjVlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=cA/32snj; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="cA/32snj"
Received: from github.com (hubbernetes-node-f1463e4.ac4-iad.github.net [10.52.172.30])
	by smtp.github.com (Postfix) with ESMTPA id 024E440132C
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Feb 2026 10:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1770834921;
	bh=ls1q1CoWLmLLiOz/RgjWnqoHYvQpo1xjQlUzlTBZYAI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=cA/32snj2akvTzzIyqQeWwAavhY/Wbs0ikoqdJUgbYQIEktZnjYl446BArMknSVqt
	 E6eadvWR79aGaa67+yKuIYA7idHhs3oCD6GladASZhWCPXNESafOfRVVdYQd02TOGA
	 KvWndvHkwVLg7V0zsc0AsS2DCFNC1VgHS4JRN5kc=
Date: Wed, 11 Feb 2026 10:35:20 -0800
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/f1eedd-30acac@github.com>
Subject: [bluez/bluez] 6b2a73: client: Add mgmt.exp-iso command
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
  Commit: 6b2a732b434fef055e90bb845106b35c09288ed7
      https://github.com/bluez/bluez/commit/6b2a732b434fef055e90bb845106b35c09288ed7
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-02-10 (Tue, 10 Feb 2026)

  Changed paths:
    M client/mgmt.c

  Log Message:
  -----------
  client: Add mgmt.exp-iso command

This adds mgmt.exp-iso command which can be used to toggle ISO socket
support:

@ MGMT Command: Set Experimental Feature (0x004a) plen 17
        UUID: BlueZ Experimental ISO Socket
        Action: Enabled (0x01)
@ MGMT Event: Command Complete (0x0001) plen 23
      Set Experimental Feature (0x004a) plen 20
        Status: Success (0x00)
        UUID: BlueZ Experimental ISO Socket
        Flags: 0x00000001
          Active
@ MGMT Event: Experimental Feature Changed (0x0027) plen 20
        UUID: BlueZ Experimental ISO Socket
        Flags: 0x00000001
          Active


  Commit: 30acac54935cc175649612633f685a4fbcdda5c6
      https://github.com/bluez/bluez/commit/30acac54935cc175649612633f685a4fbcdda5c6
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-02-10 (Tue, 10 Feb 2026)

  Changed paths:
    M doc/bluetoothctl-mgmt.rst

  Log Message:
  -----------
  bluetoothctl-mgmt: Add documentation to exp-iso command


Compare: https://github.com/bluez/bluez/compare/f1eedda9cefc...30acac54935c

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
