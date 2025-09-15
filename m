Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEF41F7586
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Sep 2025 16:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757954981; cv=none; b=cEssLCSUWHC9ZM0YNMfXwUAzFldBCVdaVC3I76q2jfSf7Kcc0IYOehS7ULkjEgk7isc9XY8OacP9c8QZ7jJlQI0Rb4SKrsKTabD5TC3ZrWWhD7KciRHyZJn++3RoVZAgLvZ6t94zb2Fc8VzJeHaS7x83JnLlYpPek66QIpvOIEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757954981; c=relaxed/simple;
	bh=vD4R0i7p+pLqjg6YvtnGueD66752OnghMplkKMqNTlc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=JAvgTI2eR7NIHrAX33lW0TUvFowvWCTtQwlgUWLDOBezhLcXq4JFreaRtoOpKjIzf704HgVex40k0H7qkHW3z7tvd5qH6H+ThULXB92ki2/5iU8buXDmQ/OMdMSASID5gvgB/miIsk/HZ0OMz/Bs+3y0oTalLraqiIsrY3Fg7ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=aCxbqmc4; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="aCxbqmc4"
Received: from github.com (hubbernetes-node-e54cda0.ash1-iad.github.net [10.56.175.26])
	by smtp.github.com (Postfix) with ESMTPA id B2BFE921275
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Sep 2025 09:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1757954978;
	bh=y3yQRr6rt9rZAi5QOtxQ/6CIofB3YORTawvjmVUxkN0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=aCxbqmc4ceuSGBMwmGNbBlaJw5C5akBGP/co6QxOEtZ35FlyfCbv2krhSI2u6e++1
	 xO2xy45Qb9QzP+7i1yTc1DziRPOhXp9KU8iCYphPHuO9UHFhZ51Hwox9G5QPl/W6tK
	 gdbUvEtanr820IRhKr+w2L0DHCE5rmRl57qoJbsQ=
Date: Mon, 15 Sep 2025 09:49:38 -0700
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1002593/000000-763b8b@github.com>
Subject: [bluez/bluez] cc08bc: shared/hfp: Add Operator name support
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

  Branch: refs/heads/1002593
  Home:   https://github.com/bluez/bluez
  Commit: cc08bcf66c4cb959dc121db5b0ca1a0045882973
      https://github.com/bluez/bluez/commit/cc08bcf66c4cb959dc121db5b0ca1=
a0045882973
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-09-15 (Mon, 15 Sep 2025)

  Changed paths:
    M src/shared/hfp.c
    M src/shared/hfp.h
    M unit/test-hfp.c

  Log Message:
  -----------
  shared/hfp: Add Operator name support

Send AT+COPS=3D3,0 at the end of the SLC creation to set the format of
the operator selection to long alphanumeric, then query the currently
selected operator name from the AG.

Register +COPS handler to call the update_operator callback on event.


  Commit: a4640c4dc50c0481bf1206706bc78a6c73e9eae5
      https://github.com/bluez/bluez/commit/a4640c4dc50c0481bf1206706bc78=
a6c73e9eae5
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-09-15 (Mon, 15 Sep 2025)

  Changed paths:
    M unit/test-hfp.c

  Log Message:
  -----------
  unit/test-hfp: Add Operator name test for HF

This add the following test:
- HFP/HF/PSI/BV-04-C
  Verify that the HF can query the currently selected operator name.

Improve MINIMAL_SLC_SESSION macro to be able to set the service, call,
callsetup and callheld indicators at connection time.


  Commit: 916f40464b9d22f3a392886e4d2af096fbc77a30
      https://github.com/bluez/bluez/commit/916f40464b9d22f3a392886e4d2af=
096fbc77a30
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-09-15 (Mon, 15 Sep 2025)

  Changed paths:
    M src/shared/hfp.c
    M src/shared/hfp.h
    M unit/test-hfp.c

  Log Message:
  -----------
  shared/hfp: Add Call Line Identification support

Send AT+CLIP=3D1 at the end of the SLC creation to enable CLIP event.
Register +CLIP handler to call the update_call_line_id callback on event.=


During incoming call notifications, i.e. after +CIEV:<callsetup>,1
event which creates a new call object, the reception of +CLIP event
will update the line_id and type of the call object.


  Commit: 763b8b10b3b55b20b628abc031bd3a116d7a0908
      https://github.com/bluez/bluez/commit/763b8b10b3b55b20b628abc031bd3=
a116d7a0908
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-09-15 (Mon, 15 Sep 2025)

  Changed paths:
    M unit/test-hfp.c

  Log Message:
  -----------
  unit/test-hfp: Add Call Line Identification test for HF

This add the following test:
- HFP/HF/CLI/BV-01-C
  Verify that the HF receives the caller ID.


Compare: https://github.com/bluez/bluez/compare/cc08bcf66c4c%5E...763b8b1=
0b3b5

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
