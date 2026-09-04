Received: from out-37.smtp.github.com (out-37.smtp.github.com [192.30.252.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502FA3A3E88
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Sep 2026 17:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788541674; cv=none; b=XFqLfTMjeoK08/cmPpRKLQ34MZIsqgImn1r/FwMJDxQQMekKGQJbSFzFPFAMlArH6ExHs8oNNUutO2AlQjSVAZYBfW5tpU3CYYGfsALWz8PsvcVtIhu1FTs6pH2B7LLz/3VYRj0YG9tuYeNcC5DbqDKWcO0L3O6khy48xoSCXa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788541674; c=relaxed/simple;
	bh=/F3pQSeCrF9+63mHsuEWgH2EYI6btsMAFdPDmZXtlvw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=oGJ47/QkqTQif9CzFvOryUad17m5BfsomM9wi2WrbLfXzb/dSwojjBgXGVZCkHAQbXmrLopOe/laDOVZnkUKWlHCYKXH5kqpdXWl45TQ2Sc/ypzylbLElQf6UiqdG3y5kSUBnHFusxvYT059n99SRDYk3YDe9qegZg1b5ZsJLP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Beh5Www3; arc=none smtp.client-ip=192.30.252.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Beh5Www3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1788541670;
	bh=npuTW3TNayG1HrHziYI8viwB+MM/zRFhnTipIVoWJzk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Beh5Www3eh59OgQtCRKks0bXxKn6XYdKrrD6j7RR1FlLxdyeYuu6A2self0iAtjqp
	 U2kKnjF0Gk/h3Xyi4qfpANmeQNSyJU5C3pr91e8Be7IwqhqC+WZN0yhX9ZXvu3cz5Z
	 Qec/jgJu8UyPTMRYVZolF1Cg3bp1GtenM6+6B2CM=
Received: from github.com (hubbernetes-node-902a3e8.ash1-iad.github.net [10.56.146.23])
	by smtp.github.com (Postfix) with ESMTPA id 666C0920734
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Sep 2026 10:07:50 -0700 (PDT)
Date: Fri, 04 Sep 2026 10:07:50 -0700
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1158120/000000-ac2d23@github.com>
Subject: [bluez/bluez] dbbf1c: client/btpclient: Add BTP_EV_BAP_ASE_FOUND
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

  Branch: refs/heads/1158120
  Home:   https://github.com/bluez/bluez
  Commit: dbbf1ca81be7478d316b3288226cde021f56c90d
      https://github.com/bluez/bluez/commit/dbbf1ca81be7478d316b3288226cd=
e021f56c90d
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-09-04 (Fri, 04 Sep 2026)

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


  Commit: b75191710a0865b4851966263ddd0c76a8ec10df
      https://github.com/bluez/bluez/commit/b75191710a0865b4851966263ddd0=
c76a8ec10df
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-09-04 (Fri, 04 Sep 2026)

  Changed paths:
    M Makefile.tools
    M client/btpclient/bap.c
    M src/shared/btp.h

  Log Message:
  -----------
  client/btpclient: Get Codec capabilities on ASE reply


  Commit: 086a6b090ca0f5fa594565cefbb96e24db60cdc4
      https://github.com/bluez/bluez/commit/086a6b090ca0f5fa594565cefbb96=
e24db60cdc4
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-09-04 (Fri, 04 Sep 2026)

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


  Commit: 3dce831e290de35e5ce41543d1d7306e6038cee7
      https://github.com/bluez/bluez/commit/3dce831e290de35e5ce41543d1d73=
06e6038cee7
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-09-04 (Fri, 04 Sep 2026)

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


  Commit: 83d89e73933ff41a10baea2b5e1fa893fa54ed5c
      https://github.com/bluez/bluez/commit/83d89e73933ff41a10baea2b5e1fa=
893fa54ed5c
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-09-04 (Fri, 04 Sep 2026)

  Changed paths:
    M client/btpclient/bap.c
    M src/shared/btp.h

  Log Message:
  -----------
  client/btpclient: Add BTP_OP_BAP_SEND support


  Commit: 3b999e3d83b6c126985dee05441e6b22b44d87c3
      https://github.com/bluez/bluez/commit/3b999e3d83b6c126985dee05441e6=
b22b44d87c3
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-09-04 (Fri, 04 Sep 2026)

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


  Commit: 6f0dbdc97d627bf97c9160dfbc5bd69ca6f79496
      https://github.com/bluez/bluez/commit/6f0dbdc97d627bf97c9160dfbc5bd=
69ca6f79496
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-09-04 (Fri, 04 Sep 2026)

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


  Commit: ac2d23e22b8f4ff7f6e5caacf0aef3b9a6c7cafe
      https://github.com/bluez/bluez/commit/ac2d23e22b8f4ff7f6e5caacf0aef=
3b9a6c7cafe
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-09-04 (Fri, 04 Sep 2026)

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


Compare: https://github.com/bluez/bluez/compare/dbbf1ca81be7%5E...ac2d23e=
22b8f

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
