Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55236207A20
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Sep 2025 16:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759251131; cv=none; b=cBWJPiAIYGpwNjG/ufax8w24BGvklZ6tbbiWySVX9scvlMvyKlncd7CK6RdSot2nxZNV/TmfBK5yCpn/kYlsFnTT3MjAIFRvQZ+wVoqsrGapff7Esb0PoQDJgNWMdU5Jz67qE5mdSlvUdlZmOjgJ0ofZ87rAkrUPn4GoK6u9ogU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759251131; c=relaxed/simple;
	bh=sDwSxSpfrnZLTfRewCm4tzP3ChV5qnBvSymO7Njv+c4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=meyf7E+pZatvj8bWgy6o+OWilagPV1pW+jDtX/TaaY8ocq3siNpJZ46y2eHbK0YnBxMyUwcY1IyRto4pad9DP/TpQF1n+h2laA2ffJDWcAtYefs7gDEaYKzCaBiynNSVq9wdEoYsC1qYT8Nehrz0JcS1/vemVxBUWxV2ProYCkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=MsGuBOt1; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="MsGuBOt1"
Received: from github.com (hubbernetes-node-c6c381a.va3-iad.github.net [10.48.13.73])
	by smtp.github.com (Postfix) with ESMTPA id 5E72BE03FE
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Sep 2025 09:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1759251129;
	bh=1MkO+Dt2QXmvBUOOkWEDtl4iqJDTIrD22hnK+/y/FUI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=MsGuBOt177Wxfei7WyQzkBZd1Rn26GKft6LyAo8He8jUunB9gxnmOe3ZjX8YNZR/7
	 CCkquPlf1lUXIk2TEIbpjaXX8bgrro/nKu1OnMoymONRp6vmBDHeMJI0SW682mxiN8
	 lgDem6h3Vc5+FXTbd7UugwhqIa2IL/3aB75ySgBQ=
Date: Tue, 30 Sep 2025 09:52:09 -0700
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/e7c77f-73dd85@github.com>
Subject: [bluez/bluez] df19a9: shared/hfp: Add Call answer support
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
  Commit: df19a94770ed0a9709b1ed8db5706cd61bdb321d
      https://github.com/bluez/bluez/commit/df19a94770ed0a9709b1ed8db5706=
cd61bdb321d
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-09-30 (Tue, 30 Sep 2025)

  Changed paths:
    M src/shared/hfp.c
    M src/shared/hfp.h

  Log Message:
  -----------
  shared/hfp: Add Call answer support

This also manage the +CIEV:<call>,=E2=80=A6 event to create, remove or up=
date
calls.


  Commit: aaabb8d758704d823d0cbe3fc7a9d93d63c031e0
      https://github.com/bluez/bluez/commit/aaabb8d758704d823d0cbe3fc7a9d=
93d63c031e0
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-09-30 (Tue, 30 Sep 2025)

  Changed paths:
    M unit/test-hfp.c

  Log Message:
  -----------
  unit/test-hfp: Add Answer Incoming Call tests for HF

This add the following tests:
- HFP/HF/ICA/BV-04-C
  Verify the incoming call is answered from HF, no in-band ring.
- HFP/HF/ICA/BV-06-C
  Verify the incoming call is answered from AG, no in-band ring.


  Commit: 5453bb52682462393d1763246d3a70426f39ac20
      https://github.com/bluez/bluez/commit/5453bb52682462393d1763246d3a7=
0426f39ac20
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-09-30 (Tue, 30 Sep 2025)

  Changed paths:
    M src/shared/hfp.c
    M src/shared/hfp.h

  Log Message:
  -----------
  shared/hfp: Add Call hangup support


  Commit: 976d87ba8e0255af8e050aa076b411706dea0714
      https://github.com/bluez/bluez/commit/976d87ba8e0255af8e050aa076b41=
1706dea0714
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-09-30 (Tue, 30 Sep 2025)

  Changed paths:
    M unit/test-hfp.c

  Log Message:
  -----------
  unit/test-hfp: Add Reject Incoming Call tests for HF

This add the following tests:
- /HFP/HF/ICR/BV-01-C
  Verify that the HF can reject an incoming call after being alerted.
- /HFP/HF/ICR/BV-02-C
  Verify that the AG, upon the corresponding action, rejects an incoming
  call and properly indicates this event to the HF.


  Commit: c53a401998f77766001d4b7744722408f04d4150
      https://github.com/bluez/bluez/commit/c53a401998f77766001d4b7744722=
408f04d4150
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-09-30 (Tue, 30 Sep 2025)

  Changed paths:
    M unit/test-hfp.c

  Log Message:
  -----------
  unit/test-hfp: Add Terminate Call tests for HF

This add the following tests:
- /HFP/HF/TCA/BV-01-C
  Verify that the HF can terminate an ongoing call in the AG.
- /HFP/HF/TCA/BV-02-C
  Verify that the AG, upon the corresponding action, terminates an
  ongoing call. The AG then indicates this event to the HF.
- /HFP/HF/TCA/BV-04-C
  Verify that the HF can release a call after dialing and prior to
  call completion.

/HFP/HF/TCA/BV-03-C (Verify that after a call is terminated from the
remote party, the HF receives the proper indication from the AG) is
similar to /HFP/HF/TCA/BV-02-C for the HF side.


  Commit: 73dd85a18b13d3e9cdef86079d759418037ff070
      https://github.com/bluez/bluez/commit/73dd85a18b13d3e9cdef86079d759=
418037ff070
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-09-30 (Tue, 30 Sep 2025)

  Changed paths:
    M doc/org.bluez.Device.rst

  Log Message:
  -----------
  doc: Fix typo in PreferredBearer property


Compare: https://github.com/bluez/bluez/compare/e7c77f80787d...73dd85a18b=
13

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
