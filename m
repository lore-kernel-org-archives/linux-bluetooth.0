Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D85721FF47
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Nov 2025 09:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762248907; cv=none; b=IvcVklLiq2nVCT3FZ2SJZIeybdSiutju46r/ha3AK1CnDW6Rji7DkVU8zpGuTgekwBHzukza2RQQ63Nh9qqWAwCJCP9csE8HhEdi5hWUHzAlQB0qRFdbfsuU3L37PPAdJEa+vWtBTOfURaf0xToF832FO0Fu4tRNfYCgKMvyLMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762248907; c=relaxed/simple;
	bh=3SzvjszGPWhwQfI1UpdxhnTgg/RWlHBdrxr/o6gbEms=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Ucjoh2oXEdpVq1amRfvKKXSy6+S8Fb3iZSbaIoGqyKjYntxh3S+WPLAjo1sg3HVApFlGHzc6urON/nrfgw0MV7oX9jaKTFK9lp/xxFNKwKajqwPQh3Z+ZLDOt7FPK2dNNF8ghjgGwc0bkZq6FU51EME3ULUXz1aXXypt74wsEWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=FkmeLo23; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="FkmeLo23"
Received: from github.com (hubbernetes-node-5cab7ce.va3-iad.github.net [10.48.160.12])
	by smtp.github.com (Postfix) with ESMTPA id 9F7914E08B6
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Nov 2025 01:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1762248905;
	bh=Pced2S7IA78OK4uElmcKvfuNejVB76LUqp2pxBwJFHE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=FkmeLo23HTy1FrppCWhqvbhH1k2GEkGLNo4gAgIa8oSAqIswOeVeWzZs/NX/DK/ix
	 JkYH0jwHUIHpW060zdzf3ZgyeavMGXRYY5f5TGrdtI4Ygo/RQV0nU2NwrmgSNYjpxc
	 2MAlYpnEHeo9XmMxCSTnIpYFNPw3XfrMXsB5H6V8=
Date: Tue, 04 Nov 2025 01:35:05 -0800
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1019334/000000-b64ffc@github.com>
Subject: [bluez/bluez] 5b73fa: shared/hfp: Add extended response code enabling
 co...
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

  Branch: refs/heads/1019334
  Home:   https://github.com/bluez/bluez
  Commit: 5b73fa75afda34e2b6e5ac432a8fe30644852b3e
      https://github.com/bluez/bluez/commit/5b73fa75afda34e2b6e5ac432a8fe=
30644852b3e
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-11-04 (Tue, 04 Nov 2025)

  Changed paths:
    M src/shared/hfp.c
    M unit/test-hfp.c

  Log Message:
  -----------
  shared/hfp: Add extended response code enabling command


  Commit: 672e75a3ae9ed566e73a553c88e6b81bb4e8fa18
      https://github.com/bluez/bluez/commit/672e75a3ae9ed566e73a553c88e6b=
81bb4e8fa18
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-11-04 (Tue, 04 Nov 2025)

  Changed paths:
    M src/shared/hfp.c
    M unit/test-hfp.c

  Log Message:
  -----------
  shared/hfp: Add NREC disable command


  Commit: b64ffc18fdc99ef6eab126548e15e71d91cb5715
      https://github.com/bluez/bluez/commit/b64ffc18fdc99ef6eab126548e15e=
71d91cb5715
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-11-04 (Tue, 04 Nov 2025)

  Changed paths:
    M unit/test-hfp.c

  Log Message:
  -----------
  unit/test-hfp: Add ECNR off test

This add the following test:
- /HFP/HF/ENO/BV-01-C
  Verify that the HF can disable the EC/NR function of the AG.


Compare: https://github.com/bluez/bluez/compare/5b73fa75afda%5E...b64ffc1=
8fdc9

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
