Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3F235966
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Oct 2025 20:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760040933; cv=none; b=Vpsl/CjL16pts8g32wQXNJ1O7uMP0VeZ/4n60sLXOpv46Rv3hOjHDuFpvAL2OWFx1JVGgx4UPGMVp26qwpdgzL9EWiAwq0z3CxDcdik6v8NTr1ejYVxzNGD/BFdXaK6UPfM/mU4zgcH4C+rGhvlHOHuCbGaVivuws1DMX1fajYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760040933; c=relaxed/simple;
	bh=SpOx22Sd1ThvoXnRAWynZ0nEvQR6xRdJGDE5OcjGS04=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=RX9pdmevxAAw5ece2HnoiGOcy64v6vTipkUxcLczWXHOMK9RfVh62czzHH8nJEukqYexkF3wxHM0E8GKK2B3GXHDJCsDOTDK3IHwQdW7D9/7aoCSECpc0jUQ0C5XupQTIxag5715H8Jfl1kWanhjQ38+CBh5pmdhuVREpFDleJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=W/srrRug; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="W/srrRug"
Received: from github.com (hubbernetes-node-0ad56d2.va3-iad.github.net [10.48.206.70])
	by smtp.github.com (Postfix) with ESMTPA id 07D304E0C73
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Oct 2025 13:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1760040931;
	bh=bEPBtDSo5mCsxb66RtkDEwNjJbgWI9L250l6vTtBVxI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=W/srrRugZvxcEwbpDclM4Niik9AtYlxIduPd+NHPLVGn7V/pWLulVIevHcl0RoWpF
	 jo9/2W/KsR18nlk/gDWihwQyq/ILUthmdwWt3qbuUaOxBEFvSu/Mch3CRWDOFWWo2j
	 1uH7NBFnGjCv3DN6Au6OUidbkXNNUkKh3SHjm2vo=
Date: Thu, 09 Oct 2025 13:15:31 -0700
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1009862/000000-ed829b@github.com>
Subject: [bluez/bluez] 542c2d: shared/hfp: Add dial support
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

  Branch: refs/heads/1009862
  Home:   https://github.com/bluez/bluez
  Commit: 542c2d403576cc99b8068878c4c4298ee30ac5da
      https://github.com/bluez/bluez/commit/542c2d403576cc99b8068878c4c42=
98ee30ac5da
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-10-09 (Thu, 09 Oct 2025)

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


  Commit: cfe29d34378b3f3cdccdf1a62e20965df44ed979
      https://github.com/bluez/bluez/commit/cfe29d34378b3f3cdccdf1a62e209=
65df44ed979
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-10-09 (Thu, 09 Oct 2025)

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


  Commit: 8ab6653d176b51346594b5a2e2717b9349e7792e
      https://github.com/bluez/bluez/commit/8ab6653d176b51346594b5a2e2717=
b9349e7792e
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-10-09 (Thu, 09 Oct 2025)

  Changed paths:
    M src/shared/hfp.c
    M src/shared/hfp.h

  Log Message:
  -----------
  shared/hfp: Add in-band ring tone setting support


  Commit: 648338f6df71047227114ca7163dbbdf5ca9d4c4
      https://github.com/bluez/bluez/commit/648338f6df71047227114ca7163db=
bdf5ca9d4c4
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-10-09 (Thu, 09 Oct 2025)

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


  Commit: 1791b7797e78da0fb4c5c5d2840180bc68cae7ab
      https://github.com/bluez/bluez/commit/1791b7797e78da0fb4c5c5d284018=
0bc68cae7ab
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-10-09 (Thu, 09 Oct 2025)

  Changed paths:
    M unit/test-hfp.c

  Log Message:
  -----------
  unit/test-hfp: Add incoming call prior to connection test

This add the following test:
- /HFP/HF/ICA/BV-07-C
  Verify that HF can connect to an AG that is receiving an in-coming
  call.


  Commit: ed829bab477556592f789698a3082768a99940e4
      https://github.com/bluez/bluez/commit/ed829bab477556592f789698a3082=
768a99940e4
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-10-09 (Thu, 09 Oct 2025)

  Changed paths:
    M unit/test-hfp.c

  Log Message:
  -----------
  unit/test-hfp: Add incoming call interrupted test

This add the following test:
- /HFP/HF/CIT/BV-01-C
  Verify that HF responds as expected when a normal incoming call
  process is interrupted from the remote party.


Compare: https://github.com/bluez/bluez/compare/542c2d403576%5E...ed829ba=
b4775

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
