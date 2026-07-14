Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242F743F4D1
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jul 2026 09:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784020792; cv=none; b=vGJ+Av/0TjLWcvqeiwumZ6xzRLYWhMXhgBK7fkCIRVprVvgTjnaHwHfU+fnGrqGShOPsfXrZYltchvBIHEE/aUZ7wu3ZmdNTV9jEifXxYBYkqUEj0JEcU+FmXpP7IjqIYyoUM/8TlOE+BtV0XJaIqz/qkDg6SDOnU7U8aDUDdII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784020792; c=relaxed/simple;
	bh=/g3pe33ub2DRLIIXRYqePYMCCSpU/4pjQXT7ntRw8NY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ciUlsNQ87tbDSXhVlpKqfY9dxOODvq20Evtz5lh+NkOAbX3xvWnMV94A/BcZy1aPFjpZcE4DuK8MD9VnLnhEvswx18t0rjItM8MtERQ5FBbr2DvVr87LSCx/S01VAlYpha1aM1/NX1vqjSIwBA03RsWCyzp+wLhqjzf44Irwg4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=PG6ZnU6p; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="PG6ZnU6p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1784020790;
	bh=G28oiwNuMKmLTDHr3FBoXpgRxaedsmVNmBs/54O/McU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=PG6ZnU6pJ7o/Se3DFLwceVz5W8MaZ5o94vXf049OtgHcWK/pSZhX0T2MNc6jusKbw
	 JqXOfhNsKrfDtv08DtiKIoikILpzl43IWbQaGRmrwP/4QjA7mTEFJ6pS04ojI+1CM7
	 uOUp50jjPdgzFglliw8/5Clx2WVpp0+GAdLhFq+k=
Received: from github.com (hubbernetes-node-da468ee.ac4-iad.github.net [10.52.171.37])
	by smtp.github.com (Postfix) with ESMTPA id 2230A78109B
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jul 2026 02:19:50 -0700 (PDT)
Date: Tue, 14 Jul 2026 02:19:50 -0700
From: Bhavani <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1127251/000000-76701e@github.com>
Subject: [bluez/bluez] b57f45: doc/org.bluez.ChannelSounding1:Add Used by
 referen...
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

  Branch: refs/heads/1127251
  Home:   https://github.com/bluez/bluez
  Commit: b57f4583cfe4a1eb34d886970339b6c7854c7b6c
      https://github.com/bluez/bluez/commit/b57f4583cfe4a1eb34d886970339b6c7854c7b6c
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-07-14 (Tue, 14 Jul 2026)

  Changed paths:
    A doc/org.bluez.ChannelSounding1.rst

  Log Message:
  -----------
  doc/org.bluez.ChannelSounding1:Add Used by reference and Examples

Add :Used by: field linking to bluetoothctl cs submenu and
Examples section showing corresponding bluetoothctl cs commands
for D-Bus methods


  Commit: e1841462a7654678c76ad578e955710f69591d37
      https://github.com/bluez/bluez/commit/e1841462a7654678c76ad578e955710f69591d37
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-07-14 (Tue, 14 Jul 2026)

  Changed paths:
    M Makefile.am
    A doc/org.bluez.ChannelSoundingRanging1.rst

  Log Message:
  -----------
  doc/org.bluez.ChannelSoundingRanging1:Add references and examples

Add :Used by: field linking to bluetoothctl cs submenu and
Examples section showing the corresponding bluetoothctl output
for the RangeEstimate signal


  Commit: 0ceb0039ac98685986e02320670bf1c4af3da269
      https://github.com/bluez/bluez/commit/0ceb0039ac98685986e02320670bf1c4af3da269
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-07-14 (Tue, 14 Jul 2026)

  Changed paths:
    M Makefile.tools
    A doc/bluetoothctl-cs.rst

  Log Message:
  -----------
  doc/bluetoothctl-cs: Add :Uses: fields and document arguments

Add :Uses: fields to link commands to their corresponding D-Bus API
methods, and document command arguments with usage examples.


  Commit: 76701e5ddfd61d9948ef75f41213bbbc4ba8db13
      https://github.com/bluez/bluez/commit/76701e5ddfd61d9948ef75f41213bbbc4ba8db13
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-07-14 (Tue, 14 Jul 2026)

  Changed paths:
    A client/scripts/cs-initiator.bt
    A client/scripts/cs-reflector.bt

  Log Message:
  -----------
  client: Add scripts to start cs Initiator/reflector

This adds sample bluetoothctl scripts for cs initiator/
reflector.

cs-initiator.bt sets up and runs a CS measurement as an Initiator
cs-reflector.bt sets up the device to respond as a Reflector


Compare: https://github.com/bluez/bluez/compare/b57f4583cfe4%5E...76701e5ddfd6

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
