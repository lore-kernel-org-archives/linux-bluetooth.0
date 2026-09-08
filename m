Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9C9584952
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Sep 2026 17:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788887895; cv=none; b=kft56tsFFf1rKCaB2XEJrPs3KxK1FzFfrgklwaDGHw0SixchIoCfEktGZujd/NFM2zGq5yraLTteDJRkVjsOKQd0nTgyqepaYiadRCKnmKrvpFHXKL+KGEFhtUc+jB5nSWpJt9MPqDZ4wE1J9A+177OtcLp+6oer94p0X94GM1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788887895; c=relaxed/simple;
	bh=9cI5ruWDlyC0xAEV7ao7h/EOVvlYh1/paU4ozmR/rKo=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=T9Z0BCUzaX1y/Nfchma78TV8xtZDhKwS02a/RM4nmLCXbQbtPf7DfkvbkyhLMs5+clBxZ0R+JrL6/bLVWs2LxDiD8Yg3YVWt0jbzFLFaLJrd3U6c/1mUB0TMb6vlSOyI4W/mlGTD9eBk7Kf1CYy72r/IPbp6AG9yyMVjchx79rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=H2rxnLH7; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="H2rxnLH7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1788887893;
	bh=K6eIZfh/vDDsao/DHHg9Athrg+q3Zz6U0fp4FbnO7pk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=H2rxnLH7mFJpXo2iotC2Z31Ny072sQnApTE5Ww0PIWzJwKlI/xeVJ6+pja0Zsxglu
	 6fFl3aMzCXLmUTaBlYfFtL6b2qZ+a4EoUwI0LV/lhkkKBU2wEZwxuuL0xRjIwPyfJ1
	 AuHaoceTvXmdxrFnxIEA7YvU1qb6nCrR//zJO4rM=
Received: from github.com (hubbernetes-node-becfb34.ac4-iad.github.net [10.52.181.55])
	by smtp.github.com (Postfix) with ESMTPA id 5A8079407F1
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Sep 2026 10:18:13 -0700 (PDT)
Date: Tue, 08 Sep 2026 10:18:13 -0700
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1160712/000000-b28861@github.com>
Subject: [bluez/bluez] 6e3197: client/btpclient: Add BTP_EV_BAP_ASE_FOUND
 support
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

  Branch: refs/heads/1160712
  Home:   https://github.com/bluez/bluez
  Commit: 6e31974e35743dd35a75127b2aedf3a44f327881
      https://github.com/bluez/bluez/commit/6e31974e35743dd35a75127b2aedf=
3a44f327881
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-09-08 (Tue, 08 Sep 2026)

  Changed paths:
    M client/btpclient/bap.c
    M client/btpclient/bap.h
    M client/btpclient/btpclient.c
    M client/btpclient/btpclient.h
    M src/shared/btp.h

  Log Message:
  -----------
  client/btpclient: Add BTP_EV_BAP_ASE_FOUND support

This is used at least for BAP/UCL/SCC/BV-004-C and BAP/UCL/SCC/BV-019-C
tests.


  Commit: 772b7da15599d603b872c892900ed98d275dc58d
      https://github.com/bluez/bluez/commit/772b7da15599d603b872c892900ed=
98d275dc58d
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-09-08 (Tue, 08 Sep 2026)

  Changed paths:
    M Makefile.tools
    M client/btpclient/bap.c
    M src/shared/btp.h

  Log Message:
  -----------
  client/btpclient: Get Codec capabilities on ASE reply


  Commit: d401bba4f472599fb0e95ec14dff1cafe9a31ea5
      https://github.com/bluez/bluez/commit/d401bba4f472599fb0e95ec14dff1=
cafe9a31ea5
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-09-08 (Tue, 08 Sep 2026)

  Changed paths:
    M Makefile.tools
    A client/btpclient/ascs.c
    A client/btpclient/ascs.h
    M client/btpclient/btpclient.c
    M client/btpclient/btpclient.h
    M client/btpclient/core.c
    M client/btpclient/gap.c
    A client/btpclient/vendor.c
    A client/btpclient/vendor.h
    M src/shared/btp.h

  Log Message:
  -----------
  client/btpclient: Add ASCS BTP support

The audio endpoints are registered by ASCS setup command of VENDOR
service at start of the test.

For SelectProperties() D-Bus method, the reply is postponed after
auto-pts has requested the ASE and PACS characteritic values.

This allows to pass the BAP/UCL/SCC/* tests.


  Commit: 86afda950aa4437746526a800c786f5c275f5440
      https://github.com/bluez/bluez/commit/86afda950aa4437746526a800c786=
f5c275f5440
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-09-08 (Tue, 08 Sep 2026)

  Changed paths:
    M Makefile.tools
    M client/btpclient/btpclient.h
    M client/btpclient/core.c
    A client/btpclient/pacs.c
    A client/btpclient/pacs.h
    M src/shared/btp.h

  Log Message:
  -----------
  client/btpclient: Add BTP_OP_PACS_SET_LOCATION support

This allows to store the expected location for a local endpoint.


  Commit: a6d91cced0f53b0e7ccc43d90eb5c8eb4dd43009
      https://github.com/bluez/bluez/commit/a6d91cced0f53b0e7ccc43d90eb5c=
8eb4dd43009
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-09-08 (Tue, 08 Sep 2026)

  Changed paths:
    M client/btpclient/bap.c
    M client/btpclient/btpclient.h
    M src/shared/btp.h

  Log Message:
  -----------
  client/btpclient: Add BTP_OP_BAP_SEND support


  Commit: 66d9820153161ac8d6ddc331e8e6d6380d00e364
      https://github.com/bluez/bluez/commit/66d9820153161ac8d6ddc331e8e6d=
6380d00e364
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-09-08 (Tue, 08 Sep 2026)

  Changed paths:
    M client/btpclient/ascs.c
    M client/btpclient/ascs.h
    M client/btpclient/bap.c
    M client/btpclient/btpclient.c
    M client/btpclient/btpclient.h
    M client/btpclient/vendor.c
    M src/shared/btp.h

  Log Message:
  -----------
  client/btpclient: Add ASCS support for BAP/UCL/STR/* tests


  Commit: 2dabc10c58c985b569cb7dc27ed86e24b4088d34
      https://github.com/bluez/bluez/commit/2dabc10c58c985b569cb7dc27ed86=
e24b4088d34
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-09-08 (Tue, 08 Sep 2026)

  Changed paths:
    M client/btpclient/ascs.c
    M client/btpclient/bap.c

  Log Message:
  -----------
  client/btpclient: Defer CIG/CIS assignment based on Client/Server role

Previously, CIG/CIS ids were eagerly assigned to each ASE as soon as
it was discovered (CIG 0, next available CIS), regardless of whether
the btpclient was acting as the Unicast Client or Server for that ASE.
This did not match how CIG/CIS ids are actually negotiated, nor what
auto-pts expects: unicast client tests expect CIG/CIS to start at 0/0,
while unicast server tests expect them to start at 1/1.

- As Unicast Client, the CIG/CIS ids are chosen locally when building
  the QoS properties returned from SelectProperties(), starting at 0.
- As Unicast Server, the CIG/CIS ids are only known once the transport
  reports them; if not yet available, all of the device's ASEs should
  share a common CIG (1) with CIS ids starting at 1 as well.

Move get_next_cis() from bap.c to ascs.c and extend it to take a base
CIS value, so it can be reused both for the Client and Server code
paths (base 0 and base 1 respectively) and skips ASEs whose CIS id is
still unset. Leave ase->cig_id and ase->cis_id unset
(BT_ISO_QOS_CIG_UNSET/BT_ISO_QOS_CIS_UNSET) at ASE discovery time, and
resolve them lazily:

- In get_properties_reply(), assign CIG 0 and the next CIS starting at
  0 when building the QoS reply for SelectProperties() (Client role).
- In ascs_proxy_added(), when the transport does not yet report a
  CIG/CIS, assign CIG 1 to all of the device's ASEs and derive CIS ids
  starting at 1 via the new set_cig_cis()/set_cig_cis_data helpers
  (Server role).


  Commit: b28861c01c301bc1efea47fabc1521ed763b2e34
      https://github.com/bluez/bluez/commit/b28861c01c301bc1efea47fabc152=
1ed763b2e34
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-09-08 (Tue, 08 Sep 2026)

  Changed paths:
    M client/btpclient/ascs.c
    M client/btpclient/bap.c
    M client/btpclient/bap.h
    M client/btpclient/btpclient.c
    M client/btpclient/btpclient.h

  Log Message:
  -----------
  client/btpclient: Add stream auto acquire for BAP/USR/STR/* tests

The sink stream should be auto acquired and data sent on it.


Compare: https://github.com/bluez/bluez/compare/6e31974e3574%5E...b28861c=
01c30

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
