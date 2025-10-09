Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAAD23D7C6
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Oct 2025 19:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760038908; cv=none; b=AalLWYhYKFWVQAHUOlGbRJC6PexG7FXnLa3jAnRy10t29VP4xaRMN/qqAX76VbsVYp+r93slJvKSCKXd/PhcpM8AEf9AeVHNgsaX8RPISnrxQ+911yXul0x35eCvASM+pwT8y78lIT0ReD3RP8lahnqTLGPDf3PzvDFpl8yQS3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760038908; c=relaxed/simple;
	bh=XI6Z29HZFS0nl/7XfcF/vQgSj7g+SgJFx+arswVV5SE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=uZzf3DM8hjEfMi2Lev0rjrkBb2A7q2erDiD+Qk0g7ASdawzoUrMP+EUELMplU4NU7i2IRYV8F1Hvv1+Dj4z8G3B/salugADEGVuMUxCPW7pH1FWcDx/ePDs1rO2QOCdF2coTM9tZ+GR3FzpT7cR0JWjHT0WhYdL1kcTyCSCKixA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Dw2COuH5; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Dw2COuH5"
Received: from github.com (hubbernetes-node-0531bd6.ash1-iad.github.net [10.56.147.29])
	by smtp.github.com (Postfix) with ESMTPA id 528FA9212F0
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Oct 2025 12:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1760038906;
	bh=r0Jm9x3vzvNxpxvxNFLqmSI3MmU8Q9UgOOGZKmae0PU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Dw2COuH5hOZ7yR2TaCbK1md9tOj3PoD5adiV7nlNRGYVG6wfkrnvAgS7iyWjvcxLq
	 je9UrB6Z/yUGV5C6SvfX+/UL0SWzudauWGPG5wLQuo1XmTYWEULAQJSHpAn/BmW2Cq
	 tv7KDCdE8NKxL54A3yXbYWvof4XF/z1NbVw9uv8Q=
Date: Thu, 09 Oct 2025 12:41:46 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/f1fb4f-4be243@github.com>
Subject: [bluez/bluez] 273bf9: gobex: Fix abort for SRM operation
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 273bf9cec70dd2e5369c4d6e91dac2f5fe56a03e
      https://github.com/bluez/bluez/commit/273bf9cec70dd2e5369c4d6e91dac=
2f5fe56a03e
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-10-09 (Thu, 09 Oct 2025)

  Changed paths:
    M gobex/gobex.c

  Log Message:
  -----------
  gobex: Fix abort for SRM operation

The OBEX Abort operation currently triggers an OBEX session
which prevents further OBEX operations:

obexd[327475]: obexd/client/transfer.c:obc_transfer_register()
               0x50e000001380 registered
               /org/bluez/obex/client/session0/transfer0
obexd[327475]: obexd/client/session.c:obc_session_ref() 0x50c0000010c0:
               ref=3D3
obexd[327475]: obexd/client/session.c:obc_session_ref() 0x50c0000010c0:
               ref=3D4
obexd[327475]: obexd/client/session.c:session_process_transfer()
               Transfer(0x50e000001380) started
obexd[327475]: obexd/client/session.c:obc_session_unref() 0x50c0000010c0:=

               ref=3D3
obexd[327475]: Transfer(0x50e000001380) Error: Transfer cancelled by user=

obexd[327475]: obexd/client/session.c:obc_session_ref() 0x50c0000010c0:
               ref=3D4
obexd[327475]: obexd/client/transfer.c:obc_transfer_unregister()
               0x50e000001380 unregistered
               /org/bluez/obex/client/session0/transfer0
obexd[327475]: obexd/client/transfer.c:obc_transfer_free() 0x50e000001380=

obexd[327475]: obexd/client/session.c:obc_session_unref() 0x50c0000010c0:=

               ref=3D3
obexd[327475]: obexd/client/session.c:obc_session_unref() 0x50c0000010c0:=

               ref=3D2
obexd[327475]: Unknown header offset for opcode 0x10
obexd[327475]: obexd/client/session.c:obc_session_shutdown()
               0x50c0000010c0
obexd[327475]: obexd/client/session.c:obc_session_ref() 0x50c0000010c0:
               ref=3D3
obexd[327475]: obexd/client/pbap.c:pbap_remove()
               /org/bluez/obex/client/session0
obexd[327475]: obexd/client/session.c:obc_session_unref() 0x50c0000010c0:=

               ref=3D2
obexd[327475]: obexd/client/session.c:obc_session_unref() 0x50c0000010c0:=

               ref=3D1
obexd[327475]: obexd/client/session.c:session_unregistered()
               Session(0x50c0000010c0) unregistered
               /org/bluez/obex/client/session0
obexd[327475]: obexd/client/session.c:obc_session_unref() 0x50c0000010c0:=

               ref=3D0

As its highest bit is always set to 1, and so its value located after
G_OBEX_RSP_CONTINUE, the G_OBEX_OP_ABORT is part of the operations
constants.

This has been tested for PBAP and BIP-AVRCP with Android 15 and 16.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>


  Commit: 24c568a3b6899d0c8dcfc920c5536bf63515ca78
      https://github.com/bluez/bluez/commit/24c568a3b6899d0c8dcfc920c5536=
bf63515ca78
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-10-09 (Thu, 09 Oct 2025)

  Changed paths:
    M src/shared/hfp.c

  Log Message:
  -----------
  shared/hfp: Fix issues found by codacy

Move debug string after check of hfp pointer.
Add missing argument in debug trace.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>


  Commit: 1067426bec48881de1b44702f7401cb8d2f2e25e
      https://github.com/bluez/bluez/commit/1067426bec48881de1b44702f7401=
cb8d2f2e25e
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-09 (Thu, 09 Oct 2025)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Fix instance where BN is printed as PTO

This fixes 2 instance where BN is printed as PTO.


  Commit: 411e3e0e46953def64f48e8e337c65d3126da2d2
      https://github.com/bluez/bluez/commit/411e3e0e46953def64f48e8e337c6=
5d3126da2d2
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-09 (Thu, 09 Oct 2025)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client/player: Fix prompting for bcode when one is already set

If bcode is non-zeroed it means it already has been set so there is no
reason to ask the user to overwrite it, also fixes the assumption that
only strings could be entered as bcode rather than a byte array.


  Commit: 4be24398f9ef510e4904e7190688fc2c02f3a583
      https://github.com/bluez/bluez/commit/4be24398f9ef510e4904e7190688f=
c2c02f3a583
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-09 (Thu, 09 Oct 2025)

  Changed paths:
    M profiles/audio/bass.c

  Log Message:
  -----------
  bass: Fix restricting the BIS indexes to 1 as assistant

MediaAssistant are created per BIS which creates a problem since
MediaAssistant.Push could only push one index at the time, so instead
of always using the index use 0xFFFFFF (no preference) and leave it up
to the delegator to decide.


Compare: https://github.com/bluez/bluez/compare/f1fb4f95f49e...4be24398f9=
ef

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
