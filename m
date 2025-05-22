Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985BF28DB74
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 May 2025 15:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747929469; cv=none; b=dvh7+/s7iREvpwiuAwfKyfhcU7NENb0zWMpwTYmdc+A63um2iwsVBggd0duU8OUYJY8uDZ8BXdr+RaSe1LtS858ctSTFpi1mOiFJBeQvBa+1QMpQCOffBgDHnhXD28Uu2Tt/oWfN2DVKseeOJlhEi7tgwRlUhhDZL7H1f5RmiFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747929469; c=relaxed/simple;
	bh=cC3S6z63vSZlX2Zwcc7D751xiFihgqE2GYRylSQFZak=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=axbsLsjBCxAXfBUvfeVEbgn2UzG4s6uca/ff2Rl8piCBDBtdwpmi7AOL26rgOkstiTUCwRAdzY9MyAX1JR1bE4b/Y/jrJ05b61R3MdwXxpb2oh1zOMcXeuLemHmfLarjjIVreiCKfdL7DU7wYhdDJUcEXHZ+McpsuTTCd7gh924=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=LvE9NiiI; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="LvE9NiiI"
Received: from github.com (hubbernetes-node-79077ff.ash1-iad.github.net [10.56.153.33])
	by smtp.github.com (Postfix) with ESMTPA id A69EF1411E4
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 May 2025 08:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1747929467;
	bh=us0uCranf4ynb+gSX2nz5JjQC7ULBi/ihWbf+DkpaCI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=LvE9NiiIUEz6ZhjSbhrx9VBh9VRQurPxc0waG/CsTvDsnRFppfzGA7CkrxqLRSehB
	 ME8S8i9nk1VC6X6gjf4YxVpnFhPUwHkVPMipz9PyXzuv3dwTsVsbYGd4FFpELHDtCC
	 UXDN6K8NAxiHMdUw21O7RHG5hc3/jGVhK7pXK314=
Date: Thu, 22 May 2025 08:57:47 -0700
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/965460/000000-087a3a@github.com>
Subject: [bluez/bluez] a0f393: src/device: Add Disconnected signal to
 propagate d...
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/965460
  Home:   https://github.com/bluez/bluez
  Commit: a0f39364aaa37721b4537f7461e08e8cde4468b5
      https://github.com/bluez/bluez/commit/a0f39364aaa37721b4537f7461e08=
e8cde4468b5
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-05-22 (Thu, 22 May 2025)

  Changed paths:
    M src/adapter.c
    M src/device.c
    M src/device.h

  Log Message:
  -----------
  src/device: Add Disconnected signal to propagate disconnection reason

Currently a client application is informed of the disconnection by the
update of the Connected property to false.
This sends a Disconnected signal with the disconnection reason before
the property is updated.

This helps client application to know the reason for the disconnection
and to take appropriate action.


  Commit: bde7b9cafe63b409f051a70b9a4f1c30ba63e8ad
      https://github.com/bluez/bluez/commit/bde7b9cafe63b409f051a70b9a4f1=
c30ba63e8ad
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-05-22 (Thu, 22 May 2025)

  Changed paths:
    M doc/org.bluez.Device.rst

  Log Message:
  -----------
  doc/device: Add Disconnected signal


  Commit: 087a3a5bb028d1b02d4bff175f5ba6723e27a36a
      https://github.com/bluez/bluez/commit/087a3a5bb028d1b02d4bff175f5ba=
6723e27a36a
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-05-22 (Thu, 22 May 2025)

  Changed paths:
    M client/main.c

  Log Message:
  -----------
  client: Display disconnection reason

The new org.bluez.Device1.Disconnected signal propagates the
disconnection reason.


Compare: https://github.com/bluez/bluez/compare/a0f39364aaa3%5E...087a3a5=
bb028

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
