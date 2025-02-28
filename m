Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208B023F36A
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Feb 2025 20:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740775103; cv=none; b=q/s8gkIQ1GQP3Zhyvo4ip4sMzuymwf5ZDPl4lzUFQWCQaJrqZ261vPMQHi6PnXL6rVpUKtDUk8YHQTOrvuXHDvA/r7AtT05yWqo85aX+kxb4OyIWDuNuaYy9yqSblN2GdwTCuaP5RaXU3c/uw+hWGTUx1QOwDNW6SM+usbQAEf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740775103; c=relaxed/simple;
	bh=d/1km0iMSaQvkA6vLPh/0UReaOrLpQYEmoxJT5RfBz8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=IkCdUpG4d/ZOCn7edajqE3lqmtnc2RupjIwfOdo4NagDagrzv02Us2Gu3xH/OeJk/ExfMUo9HjRLKBpLZyi5LHZCrD/9OWy2X2/ON42SV9y30JpjIutRP16uL2gt2FQCAWNtKZZ5Xli3V+1jRDvNCUfwHmW4G2DUcWm2y3/8nsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=TnDoJuL9; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="TnDoJuL9"
Received: from github.com (hubbernetes-node-eda63aa.va3-iad.github.net [10.48.15.28])
	by smtp.github.com (Postfix) with ESMTPA id 10072E0153
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Feb 2025 12:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1740775101;
	bh=7juOorWs+iY+SyFUZ1TQR0fu+oxL2Fi2q5vwSuK8gAM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=TnDoJuL9oj7p02DBLBfwCGQZ9ybT68Zoap65TBdVU+yBzSv1e4rKEBI8CL+mGnOZ1
	 cXRzHT9oHF/VPuQM0kzcVUaUngVfimr+pYm1qlpoIRYZQ2bZHdjZ4AO7/FSOaIasYl
	 vBbA3MHE2zBPbAFFTEkfots3BvDrV8JnJR5R387Y=
Date: Fri, 28 Feb 2025 12:38:21 -0800
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/7f1fa3-711424@github.com>
Subject: [bluez/bluez] 4130fe: shared/bap: Fix not starting released operation
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
  Commit: 4130fe22fb8af7ebc02e737f2841da766e726b16
      https://github.com/bluez/bluez/commit/4130fe22fb8af7ebc02e737f2841da766e726b16
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-02-28 (Fri, 28 Feb 2025)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Fix not starting released operation

The release operation is intended to release CIS resources:

  'Releases resources associated with an ASE, immediately decouples the
  ASE from any previously coupled CIS, and tears down any CIS previously
  established for the ASE for one or more ASEs.

  Valid only if ASE_State field value = 0x01 (Codec Configured),
  0x02 (QoS Configured), 0x03 (Enabling), 0x04 (Streaming), or 0x05
  (Disabling).'

But as the stated in ASCS specification release can also be used with
the likes of Codec/QoS Configured which may not require the CIS to be
established and in that case released operation shall start
autonomously:

  'The Released operation shall be initiated autonomously by the server
  if:
  The Release operation for an ASE has been completed and the server
  controller has indicated that the underlying CIS for the ASE has been
  torn down.'


  Commit: 9efc138e98080e1e3f27e56c30cf289e014d5302
      https://github.com/bluez/bluez/commit/9efc138e98080e1e3f27e56c30cf289e014d5302
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-02-28 (Fri, 28 Feb 2025)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Fix state transition of sink for disable operation

This fixes a regression introduced by 173045553c15
("bap: Fix not generating releasing state") where the Disable operation
no long caused the transition to QoS configured for Sink, as per ASCS spec
Table 3.2: ASE state machine transitions that state transition is
required.


  Commit: 711424319562ef2efcb7ad0d5f264400f72af8fd
      https://github.com/bluez/bluez/commit/711424319562ef2efcb7ad0d5f264400f72af8fd
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-02-28 (Fri, 28 Feb 2025)

  Changed paths:
    M tools/sco-tester.c

  Log Message:
  -----------
  sco-tester: add test for disconnecting SCO

Add test that checks that shutdown(sk) results to
HCI_Disconnection_Complete for the SCO handle:

SCO Disconnect - Success


Compare: https://github.com/bluez/bluez/compare/7f1fa3d7ce39...711424319562

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
