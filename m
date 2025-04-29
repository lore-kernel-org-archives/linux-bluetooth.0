Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C90924728A
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Apr 2025 18:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745950431; cv=none; b=WuH/Z/l9OLDd7UzKOglhrw6L8kvtUhSj1LCix2kk3flVH5VKyk2eI4xNQHL7TN6AXimI4DY7biGDo972aMOCubch/Vk8e7w15ZOPZgKYTflvffbHD2kvYVF7td13Et9cJtPz5Hi6PP6oStgzVfGkPoefdoL1J8e5N2XdlYt6D8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745950431; c=relaxed/simple;
	bh=xpiQCn5MJAuAEQLg7Sy1/GuLmNlXH5nZ2bzI4UoVS/U=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=HgYmU3GEOXEgp4UTm4ilZXxCjRX4GpNLtWyn7gLd4RqeERjfzrvDgrXKFbPo1jNDzjI8klqJiWxqVKgM6+7XwCLqMhOJ+JCT0BM6f/SNhLM8TbQD5cO5Ru3OtACA4NKczZXl/MKS3FU+5zhHAgc56AIWLT2nESVJ+q+9YaysMJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=f8PnwF3D; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="f8PnwF3D"
Received: from github.com (hubbernetes-node-0117935.ash1-iad.github.net [10.56.149.36])
	by smtp.github.com (Postfix) with ESMTPA id 0FF68140602
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Apr 2025 11:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1745950429;
	bh=ltLjbgfb6Q+Bv/tNZ6sfcnnylkvgCRnIjGFpRqYizLg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=f8PnwF3DOJ+xgGykRgCq30ODd/55wjW3OUdmDHfC2n1eELBdNC1DfMzbiwk2Ul5jn
	 kMsBG2aAWfHFZRoXdGDQGSTXPgA0iRZUMJ7YoI++nROm45ZOeQLbq7tUnxrbnIteqs
	 mfRkYmNl1t6kLfJKcKDtOu9rjYKs/Pq6qbxXAZa8=
Date: Tue, 29 Apr 2025 11:13:49 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/f96f3b-237d81@github.com>
Subject: [bluez/bluez] 9bf6bb: pbap: Support calling pbap_init() after
 pbap_exit()
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
  Commit: 9bf6bb654ff78efafe8cb4c4d55b6acaa0f53c27
      https://github.com/bluez/bluez/commit/9bf6bb654ff78efafe8cb4c4d55b6acaa0f53c27
  Author: Andrew Sayers <kernel.org@pileofstuff.org>
  Date:   2025-04-29 (Tue, 29 Apr 2025)

  Changed paths:
    M obexd/client/pbap.c

  Log Message:
  -----------
  pbap: Support calling pbap_init() after pbap_exit()

pbap_exit() didn't previously unregister itself thoroughly.  That
was fine if it was only called when the service was about to exit,
because everything was implicitly unregistered when the process ended.
But we need to be more scrupulous if this can be called throughout
the program's lifecycle.

Send the UnregisterProfile message directly from pbap_exit(),
then call unregister_profile().

The UnregisterProfile message can't be sent directly from
unregister_profile(), because that also needs to be called when
register_profile() fails halfway through.


  Commit: 29f3c07b8dc95a17a128f2b461f133099fff3da7
      https://github.com/bluez/bluez/commit/29f3c07b8dc95a17a128f2b461f133099fff3da7
  Author: Andrew Sayers <kernel.org@pileofstuff.org>
  Date:   2025-04-29 (Tue, 29 Apr 2025)

  Changed paths:
    M obexd/plugins/bluetooth.c

  Log Message:
  -----------
  obexd/bluetooth: Support calling bluetooth_init() after bluetooth_exit()

bluetooth_exit() didn't previously unregister itself thoroughly.  That
was fine if it was only called when the service was about to exit,
because everything was implicitly unregistered when the process ended.
But we need to be more scrupulous if this can be called throughout
the program's lifecycle.

Send UnregisterProfile messages directly from bluetooth_exit(),
then call unregister_profile(profile).

The UnregisterProfile message can't be sent directly from
unregister_profile(), because that also needs to be called when
register_profile() fails halfway through.

Do not free profiles in bluetooth_exit() - profiles are needed
by a future call to bluetooth_init(), or will be freed by
bluetooth_stop() if necessary.


  Commit: 237d818ef294e22be87fba69b3cdd79c75c201e7
      https://github.com/bluez/bluez/commit/237d818ef294e22be87fba69b3cdd79c75c201e7
  Author: Andrew Sayers <kernel.org@pileofstuff.org>
  Date:   2025-04-29 (Tue, 29 Apr 2025)

  Changed paths:
    M obexd/src/main.c
    M obexd/src/obexd.h

  Log Message:
  -----------
  obexd: Support creating private system/session bus connections

Obexd can either connect to the system or session bus.
We mostly share a common connection to that bus, but it can be useful
to have a private connection.  For example, this allows us to quickly
unregister profiles when switching user.

Add obex_setup_dbus_connection_private(), which creates a new
connection to whichever bus was specified by the user.


Compare: https://github.com/bluez/bluez/compare/f96f3b34db40...237d818ef294

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
