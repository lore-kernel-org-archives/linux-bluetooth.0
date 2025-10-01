Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDB0537E9
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Oct 2025 07:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759302076; cv=none; b=Z2c99wK5GG53KhNLjv2IYK322LVQTzIE53PddQ3uT4yM5Ucq/MEbkiK4gRmkZplQykpOQl3ylXkZv9/+SJJsAp3++5RHtShhZUkoNnulEsZezAwphz9sQdnZ8i1Pao2A1Q25M6IjfOPxwfzwYvzcpzzYc0u1vzcYyknr3v3rq48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759302076; c=relaxed/simple;
	bh=zAmv81RqKItRnryWaFQMgUqbijGEZlzG9z2A6fq4cj4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=oLvVyPioZfRb6ZwwkwCUtkcnZBz5B3Yhd6uL6qJGd49McRmbG6dGIpyc7mZ3g99bUqYjHBZijrKAIMhmW5T/1EyCqIidirU7BmqB/sv2zuagSPPbx7qOPkSXSGOrnF+JgyPTXsY2bxZQ6ZWAMT18FwVmUDLgeXFV4dhHexQCtRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Z7kUoP8h; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Z7kUoP8h"
Received: from github.com (hubbernetes-node-2d4d89e.va3-iad.github.net [10.48.14.78])
	by smtp.github.com (Postfix) with ESMTPA id 7758FE1164
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Oct 2025 00:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1759302073;
	bh=/ySAFjlezKxPqmRVJ+5H9QDX9G0G/uvuNaEZ38wJ+zY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Z7kUoP8h1rHaLSyH+FdsZ/Y39Mo1PdGkmBQzUJxjUNez/50FdX6I/kIgdQB/sqAVr
	 5H4eTv3/5lUybaktU6tKJCyj2MgOhh+V6BruhSHw6C9+QOi//MF87EOOeU9PYA1UWu
	 QWyqYTt02FuILJi7qiBSWdV9qWeWR91b2j2ZBFv8=
Date: Wed, 01 Oct 2025 00:01:13 -0700
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1007578/000000-54d5cd@github.com>
Subject: [bluez/bluez] a410d2: shared/hfp: Add dial support
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

  Branch: refs/heads/1007578
  Home:   https://github.com/bluez/bluez
  Commit: a410d28ac471c702f8c93c261273cd2eb6bcbcfb
      https://github.com/bluez/bluez/commit/a410d28ac471c702f8c93c261273c=
d2eb6bcbcfb
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-10-01 (Wed, 01 Oct 2025)

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


  Commit: 7cc28016618a8828def72ee2eaed93cee838737d
      https://github.com/bluez/bluez/commit/7cc28016618a8828def72ee2eaed9=
3cee838737d
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-10-01 (Wed, 01 Oct 2025)

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


  Commit: b4c8b9d8fb54ef35f859fffd34ca2a927b1a0e16
      https://github.com/bluez/bluez/commit/b4c8b9d8fb54ef35f859fffd34ca2=
a927b1a0e16
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-10-01 (Wed, 01 Oct 2025)

  Changed paths:
    M src/shared/hfp.c
    M src/shared/hfp.h

  Log Message:
  -----------
  shared/hfp: Add in-band ring tone setting support


  Commit: 296538ad6a8b592bfee03e56a040a3bf5cfad3d0
      https://github.com/bluez/bluez/commit/296538ad6a8b592bfee03e56a040a=
3bf5cfad3d0
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-10-01 (Wed, 01 Oct 2025)

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


  Commit: 4809adf24f23078bcd3c18252f73ed7a64a532d6
      https://github.com/bluez/bluez/commit/4809adf24f23078bcd3c18252f73e=
d7a64a532d6
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-10-01 (Wed, 01 Oct 2025)

  Changed paths:
    M unit/test-hfp.c

  Log Message:
  -----------
  unit/test-hfp: Add incoming call prior to connection test

This add the following test:
- /HFP/HF/ICA/BV-07-C
  Verify that HF can connect to an AG that is receiving an in-coming
  call.


  Commit: 54d5cddfdf8792ac0b66b784311993cc0088b84e
      https://github.com/bluez/bluez/commit/54d5cddfdf8792ac0b66b78431199=
3cc0088b84e
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-10-01 (Wed, 01 Oct 2025)

  Changed paths:
    M unit/test-hfp.c

  Log Message:
  -----------
  unit/test-hfp: Add incoming call interrupted test

This add the following test:
- /HFP/HF/CIT/BV-01-C
  Verify that HF responds as expected when a normal incoming call
  process is interrupted from the remote party.


Compare: https://github.com/bluez/bluez/compare/a410d28ac471%5E...54d5cdd=
fdf87

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
