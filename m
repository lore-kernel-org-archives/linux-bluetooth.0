Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4439C134B4
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jan 2024 22:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706222179; cv=none; b=liQLHMKKw/OT5j4GWhI8GFEP8oKhq6GGrfJHYLzxFbbQUWT5uA5zWxzh+cPBytUqI0Ld4WsJ1GNPAn1p4C/vpwhXjJbauqrc9yZDDv/n5TqFGb5azWBl9HwMpCbbTVl3KZK/88bA65Zm6DEHKPY6sp9Gl8LA0C81agv4A7s+Ivw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706222179; c=relaxed/simple;
	bh=jGspU/RKIYq6fNpFJwTOUvtzdh8FGE5OfPt0Et4rIOw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Cyeh7ss3mLjvOoToTWIYifxA4RJ7K2wNH3BPusMWv+3ff8+8hy2lN4CmR1/WZODSFbIgLyydh9kg2xV4sM7kgxYqILF/OC9GmzSrCfIAdxq1uTDQSpNOVlL67lkoXfUtR4IS69d574h/puqCQqdyv7okP0pK18QR4GpNXLF0HU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=FfBxwOo+; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="FfBxwOo+"
Received: from github.com (hubbernetes-node-331f118.ash1-iad.github.net [10.56.159.32])
	by smtp.github.com (Postfix) with ESMTPA id 5F388100294
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jan 2024 14:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1706222174;
	bh=NSPnA4XU/uXwoXVvkgm4tbNSnepgt8bMOgsDCC7uaqY=;
	h=Date:From:To:Subject:From;
	b=FfBxwOo+sNUPMHYUOY0QHkHJN7j+Y/fYq68o1+cYuJYJRCjc8h5Vgvu97hGfTdK5B
	 dDFsGg99+1rlWfsqU55VqymUw4mMDqiSzJSl70qUxj7hKfeHBm+ptdwaMa+tq0/QLa
	 mzaBsB/57dOfC77QUrA/p3HrfY5w4q9miwGqceu4=
Date: Thu, 25 Jan 2024 14:36:14 -0800
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/d39719-0de32f@github.com>
Subject: [bluez/bluez] 2e2e50: bap: Fix update of context
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
  Commit: 2e2e50011d0c6685a7e2f3dc1d777a19fb4b11e6
      https://github.com/bluez/bluez/commit/2e2e50011d0c6685a7e2f3dc1d777=
a19fb4b11e6
  Author: Kiran K <kiran.k@intel.com>
  Date:   2024-01-25 (Thu, 25 Jan 2024)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  bap: Fix update of context

Fix context getting updated with support_context.


  Commit: 6c15afefcd7187cab0b299fb49f67def2254d9ac
      https://github.com/bluez/bluez/commit/6c15afefcd7187cab0b299fb49f67=
def2254d9ac
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2024-01-25 (Thu, 25 Jan 2024)

  Changed paths:
    M src/shared/att.c
    M src/shared/att.h
    M src/shared/gatt-client.c
    M src/shared/gatt-client.h

  Log Message:
  -----------
  shared/gatt: Prevent security level change for PTS GATT tests

Some PTS GATT tests like GATT/CL/GAR/BI-04-C request to be able to get th=
e
security error and do not try to change the security level.

This commit adds the ability to prevent to change the security level for
an operation.


  Commit: f0cef854f9637bcb16b5cf04c2720c8edc81b200
      https://github.com/bluez/bluez/commit/f0cef854f9637bcb16b5cf04c2720=
c8edc81b200
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2024-01-25 (Thu, 25 Jan 2024)

  Changed paths:
    M tools/btgatt-client.c

  Log Message:
  -----------
  btgatt-client: Add command to prevent security level change

Some PTS GATT tests like GATT/CL/GAR/BI-04-C request to be able to get th=
e
security error and do not try to change the security level.

This commit adds the ability to prevent to change the security level.


  Commit: 68cd2ae6f5134888b6285d20f3b6232c5bf641f0
      https://github.com/bluez/bluez/commit/68cd2ae6f5134888b6285d20f3b62=
32c5bf641f0
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2024-01-25 (Thu, 25 Jan 2024)

  Changed paths:
    M tools/btgatt-client.c

  Log Message:
  -----------
  btgatt-client: Add function to search service based on UUID

This is requested to pass PTS GATT/CL/GAD/BV-02-C test.


  Commit: 647adf9260ff554a5b2907ce2c327a9d8b5bd258
      https://github.com/bluez/bluez/commit/647adf9260ff554a5b2907ce2c327=
a9d8b5bd258
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2024-01-25 (Thu, 25 Jan 2024)

  Changed paths:
    M tools/btgatt-client.c

  Log Message:
  -----------
  btgatt-client: Add function to search characteristics

This is requested to pass PTS GATT/CL/GAD/BV-05-C test.
This search characteristics based on UUID, start and end handles.


  Commit: 0de32f67f685b95c35a5c2f1206081af89bd88b6
      https://github.com/bluez/bluez/commit/0de32f67f685b95c35a5c2f120608=
1af89bd88b6
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2024-01-25 (Thu, 25 Jan 2024)

  Changed paths:
    M tools/btgatt-client.c

  Log Message:
  -----------
  btgatt-client: Add function to search all primary services

This is requested to pass PTS GATT/CL/GAD/BV-01-C test.


Compare: https://github.com/bluez/bluez/compare/d3971990d926...0de32f67f6=
85
