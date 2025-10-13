Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA6B19309C
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Oct 2025 16:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760372137; cv=none; b=IvIhelSRt7/kcm7MhukuoI8QkUxM1XhqmmlKUNvO1P/yfBdMWlUQ47tbxZFQq6/7RdtlletTd/hGWHIDUn98uWqSkoMlgk+0v3zQCIlrK+5SoPlHRi1eZnD0IedqHplVBoyjDngi6rwLiaZ39nPFhZVJzL75Pj3F+uaHJFIkROQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760372137; c=relaxed/simple;
	bh=Xi6X3BxDzvtEEVqMSZGC7STiKnCd7kaHbroYqa5FClM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=t7Bl1mc+pbY1dbIQcVNJo+7SDlEZU2QAI+pHduDwmmN+V1EQLPuEjVVqb5PQBqCvWYmqUWmWwF9zpkCFCSWo/tUJaqJKM1A+/0yOZm8Ep9E05WFvZeyULDmu92X5j1/2Oo3ry6JE2TDikURvNkt7vhAffHlUQ7VP0W5Dixdesvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=DCruaztc; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="DCruaztc"
Received: from github.com (hubbernetes-node-fd2241a.va3-iad.github.net [10.48.153.32])
	by smtp.github.com (Postfix) with ESMTPA id DEE5A8C0481
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Oct 2025 09:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1760372134;
	bh=Uzh5SZ/AyTJvQGdPb6KlTX5ej2FeL6cFcmIDasdB9d8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=DCruaztciRKXu3pRbUhUV90SlRi8RhHoMzzpTIBg/vue0qTXZDuWTWsEAY+dXdbNv
	 h84hgCz77GKd9E8BblYWHLV1UntCuVHIBTSmMvZxNYiP/yOvaH6lZ+FXQcflA1WMkW
	 wYXJfOsPesXf/eazaJVUZZFELySAlJnZZofAk73U=
Date: Mon, 13 Oct 2025 09:15:34 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/4be243-b3dd59@github.com>
Subject: [bluez/bluez] 217bd7: shared/hfp: Add dial support
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
  Commit: 217bd72c128a5b9fcb913d0ea18ac503c7bdc82e
      https://github.com/bluez/bluez/commit/217bd72c128a5b9fcb913d0ea18ac=
503c7bdc82e
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-10-13 (Mon, 13 Oct 2025)

  Changed paths:
    M src/shared/hfp.c
    M src/shared/hfp.h

  Log Message:
  -----------
  shared/hfp: Add dial support

If no number, NULL or empry string, is passed to hfp_hf_dial() this
will try to call the last dialed phone number using AT+BLDN.

If the phone number starts with '>' and is followed by a number nnn=E2=80=
=A6,
up to 10 digits, it will call the phone number in memory entry nnn=E2=80=A6=
.

Else it will performed a voice call to the number provided.


  Commit: c285274d17085b63d08fc308a27c81225b2d2dd5
      https://github.com/bluez/bluez/commit/c285274d17085b63d08fc308a27c8=
1225b2d2dd5
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-10-13 (Mon, 13 Oct 2025)

  Changed paths:
    M unit/test-hfp.c

  Log Message:
  -----------
  unit/test-hfp: Add dial tests for HF

This add the following tests:
- /HFP/HF/OCL/BV-01-C
  Initiate a call placed to the last number
- /HFP/HF/OCL/BV-02-C
  Handling ERROR response to a call placed to last number
- /HFP/HF/OCM/BV-01-C
  Initiate a request to place a call with a memory location
- /HFP/HF/OCM/BV-02-C
  Handling ERROR response to a call placed to an empty memory location
- /HFP/HF/OCN/BV-01-C
  HF places a call with a phone number


  Commit: ff984192b4529d6684173fb098e8bd1901932ea6
      https://github.com/bluez/bluez/commit/ff984192b4529d6684173fb098e8b=
d1901932ea6
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-10-13 (Mon, 13 Oct 2025)

  Changed paths:
    M src/shared/hfp.c
    M src/shared/hfp.h

  Log Message:
  -----------
  shared/hfp: Add in-band ring tone setting support


  Commit: fc3aa8a9fd4d06b127b309cbefd98ace719e3bfa
      https://github.com/bluez/bluez/commit/fc3aa8a9fd4d06b127b309cbefd98=
ace719e3bfa
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-10-13 (Mon, 13 Oct 2025)

  Changed paths:
    M unit/test-hfp.c

  Log Message:
  -----------
  unit/test-hfp: Add Answer Incoming Call with In-Band Ring tests for HF

This add the following tests:
- /HFP/HF/ICA/BV-01-C
  Verify the incoming call is answered from HF, in-band ring tone.
- /HFP/HF/ICA/BV-02-C
  Verify that the AG can change its in-band ring tone setting.
- /HFP/HF/ICA/BV-03-C
  Verify that the HF alerts of an incoming call using the local ring
  signal regardless of the presence of the in-band ring tone.
- /HFP/HF/ICA/BV-04-C-full
  duplicate of /HFP/HF/ICA/BV-04-C test with full SLC setup.

/HFP/HF/ICA/BV-05-C (Verify that the HF alerts an incoming call using
a locally generated alert signal and can answer an incoming call in
the AG when the AG does not use an in-band ring tone as an alert
mechanism for the HF and the IUT allows an Audio Connection to be
present) is similar to /HFP/HF/TCA/BV-02-C/HFP/HF/ICA/BV-04-C-full for
the HF side.


  Commit: 78c723b4d568444d95e4a4bbec821b41fdce55ec
      https://github.com/bluez/bluez/commit/78c723b4d568444d95e4a4bbec821=
b41fdce55ec
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-10-13 (Mon, 13 Oct 2025)

  Changed paths:
    M unit/test-hfp.c

  Log Message:
  -----------
  unit/test-hfp: Add incoming call prior to connection test

This add the following test:
- /HFP/HF/ICA/BV-07-C
  Verify that HF can connect to an AG that is receiving an in-coming
  call.


  Commit: d01da89d6a1de435ad63560e26d442459086a99c
      https://github.com/bluez/bluez/commit/d01da89d6a1de435ad63560e26d44=
2459086a99c
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-10-13 (Mon, 13 Oct 2025)

  Changed paths:
    M unit/test-hfp.c

  Log Message:
  -----------
  unit/test-hfp: Add incoming call interrupted test

This add the following test:
- /HFP/HF/CIT/BV-01-C
  Verify that HF responds as expected when a normal incoming call
  process is interrupted from the remote party.


  Commit: 49d69b77fd4f2af99de71992b7ca2366b8e57038
      https://github.com/bluez/bluez/commit/49d69b77fd4f2af99de71992b7ca2=
366b8e57038
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-10-13 (Mon, 13 Oct 2025)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: check pac cc and metadata length before use

Don't read past buffer end if device provided bogus values for PAC
caps/metadata lengths.

Use iov pull properly, and also check metadata LTV validity.


  Commit: b3dd599874550ab4793fb369e7c69ed01b284f5b
      https://github.com/bluez/bluez/commit/b3dd599874550ab4793fb369e7c69=
ed01b284f5b
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-10-13 (Mon, 13 Oct 2025)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: fix crash when setting initial metadata of a stream

bt_bap_stream_metadata() when stream is IDLE causes IDLE->IDLE
transition and crashes due to UAF. This occurs if SelectProperties
provides a Metadata.

Fix by not updating state if stream is IDLE.

Log:

ERROR: AddressSanitizer: heap-use-after-free
READ of size 8 at 0x7ca9d83ec448 thread T0
    #0 0x000000927dce in bt_bap_stream_metadata src/shared/bap.c:6525
    #1 0x00000056ae75 in setup_config profiles/audio/bap.c:1790
    #2 0x00000056b865 in bap_config_setup profiles/audio/bap.c:1831
0x7ca9d83ec448 is located 8 bytes inside of 160-byte region [0x7ca9d83ec4=
40,0x7ca9d83ec4e0)
freed by thread T0 here:
    #0 0x7fc9da2e5beb in free.part.0 (/lib64/libasan.so.8+0xe5beb)
    #1 0x0000008e3481 in bap_stream_free src/shared/bap.c:1259
    #2 0x0000008e4586 in bt_bap_stream_unref src/shared/bap.c:1342
    #3 0x0000008e4b6e in bap_ucast_detach src/shared/bap.c:1366
    #4 0x0000008e6b63 in bap_stream_state_changed src/shared/bap.c:1496
    #5 0x0000008ec17d in bap_ucast_set_state src/shared/bap.c:1857
    #6 0x0000008e75e4 in stream_set_state src/shared/bap.c:1543
    #7 0x0000008f268c in stream_metadata src/shared/bap.c:2250
    #8 0x0000008f2801 in bap_ucast_metadata src/shared/bap.c:2274
    #9 0x000000927d3f in bt_bap_stream_metadata src/shared/bap.c:6523


Compare: https://github.com/bluez/bluez/compare/4be24398f9ef...b3dd599874=
55

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
