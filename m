Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24AD5476FD
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 17:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789061254; cv=none; b=QvL3j5UWHcmRcWYERy1kKNRKGVASZe2ESp9EngjBZDQKiZ/JbtbMOqFC3nRFduUVROfvnWn7H9x9y8j6+JtCMFn7FrRIJSr6NiPuXUa5KZ95BiM74zfXNUWdI6yhzBAdBA5Is0eIRV+1FimtwXDlaJsjajAvJl5ufXoNTGKuvfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789061254; c=relaxed/simple;
	bh=Dbo94gNsqoY02YUUTj3n0lJVXO12rr2y3iAyxlCyQjA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=EuBmRqtCngcvWD4E/+HS0wgTlOUzhrDC8jKTl5SC+wCLVy7C+2OadVc0Yl6jRaweKOOTmkZzJnKi9SWAieLTLfCqO34PS+169n3S0DC5CCevtJQkrfF18PsMqfYRIQuHttPEGK4hP1eUzk3/C8gvCsj5rLUi5IiNF9urJhzt744=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Iqu8FS/L; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Iqu8FS/L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1789061246;
	bh=RcOsON96m1pRj/rsmVwAYoh/vRDkVIEAI7yyI0I8DhE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Iqu8FS/LovlGHIVHXRUPB/lIAiYAXx4JFEB2A8LX9MH5zfGOwpVBZcY5miRqkPmuR
	 YCUECiHVbiF+EuUG2UhP++Go/feeOaBgXGTx0jDGACMAvql0EMf/buvsyXnbkkP0PS
	 vZefYC8CgPmGrKFo3910DpzxUtr0GUMzvVCeKP6A=
Received: from github.com (hubbernetes-node-bdd98ae.ac4-iad.github.net [10.52.210.70])
	by smtp.github.com (Postfix) with ESMTPA id 76E2494022A
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 10:27:26 -0700 (PDT)
Date: Thu, 10 Sep 2026 10:27:26 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/19ebd6-51d1b7@github.com>
Subject: [bluez/bluez] b93baa: monitor: Check valid range of CE Length
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
  Commit: b93baad72d27ec3fc5c42f80a6b21e9f3edfe014
      https://github.com/bluez/bluez/commit/b93baad72d27ec3fc5c42f80a6b21=
e9f3edfe014
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-10 (Thu, 10 Sep 2026)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Check valid range of CE Length

The connection event length recommended in requests by a Peripheral has
a valid range of 0x0001 to 0x7CFF (Time =3D N * 125 us, Time Range:
0.125 ms to 3.999875 s), so print values outside of it as reserved
instead of decoding them as a time.


  Commit: 9d35770cb64777b3a44b9deccc3683231486af0c
      https://github.com/bluez/bluez/commit/9d35770cb64777b3a44b9deccc368=
3231486af0c
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-10 (Thu, 10 Sep 2026)

  Changed paths:
    M emulator/btdev.c

  Log Message:
  -----------
  emulator/btdev: Check valid range of CE Length

The connection event length recommended in requests by a Peripheral has
a valid range of 0x0001 to 0x7CFF (Time =3D N * 125 us, Time Range:
0.125 ms to 3.999875 s), so reject LE Connection Rate Request and LE Set
Default Rate Parameters with values outside of it.


  Commit: 51da643c8271468013804e57b24a55ea4207410b
      https://github.com/bluez/bluez/commit/51da643c8271468013804e57b24a5=
5ea4207410b
  Author: Zijun Hu <zijun.hu@oss.qualcomm.com>
  Date:   2026-09-10 (Thu, 10 Sep 2026)

  Changed paths:
    M doc/hci-protocol.rst

  Log Message:
  -----------
  doc/hci-protocol: Fix missing & on mtu argument in BT_RCVMTU example

getsockopt() requires a pointer argument, but mtu was passed by value.

Fix by using &mtu instead of mtu.


  Commit: 4be273b132a72c5eaeeac9b9b9cf19c241b321d0
      https://github.com/bluez/bluez/commit/4be273b132a72c5eaeeac9b9b9cf1=
9c241b321d0
  Author: Zijun Hu <zijun.hu@oss.qualcomm.com>
  Date:   2026-09-10 (Thu, 10 Sep 2026)

  Changed paths:
    M monitor/broadcom.c
    M monitor/broadcom.h
    M monitor/intel.c
    M monitor/intel.h
    M monitor/msft.c
    M monitor/msft.h
    M monitor/packet.c
    M monitor/vendor.c
    M monitor/vendor.h

  Log Message:
  -----------
  monitor: s/vendor_(evt|event)/\1_vendor/

Kernel include/net/bluetooth/hci.h defines:

  #define HCI_EVENT_PKT   0x04
  #define HCI_VENDOR_PKT  0xff
  #define HCI_EV_VENDOR   0xff

HCI_VENDOR_PKT and HCI_EV_VENDOR share the same value, but are very
different, as the table below shows:

+------------+-----------------------+---------------------------+
|            | HCI_VENDOR_PKT        | HCI_EV_VENDOR             |
+------------+-----------------------+---------------------------+
| Defined by | Vendor                | BT SIG                    |
+------------+-----------------------+---------------------------+
| Hierarchy  | Parallel to           | Nested inside             |
|            | HCI_EVENT_PKT         | HCI_EVENT_PKT             |
+------------+-----------------------+---------------------------+
| Direction  | RX and TX             | RX only                   |
+------------+-----------------------+---------------------------+
| kernel <-> | HCI_VENDOR_PKT, ...   | 0x04, HCI_EV_VENDOR, ...  |
| userspace  |                       |                           |
+------------+-----------------------+---------------------------+
| kernel <-> | RX: 23, vendor packet | RX: 3, HCI_EV_VENDOR, ... |
| monitor    | TX: 22, vendor packet |                           |
+------------+-----------------------+---------------------------+

monitor is about to gain HCI_VENDOR_PKT support. To avoid confusing the
two, rename what deals with HCI_EV_VENDOR to follow its pattern:

s/vendor_(evt|event)/\1_vendor/


  Commit: 160395d93d14d6f0e2db30c217a5c5d2ea6e49a4
      https://github.com/bluez/bluez/commit/160395d93d14d6f0e2db30c217a5c=
5d2ea6e49a4
  Author: Zijun Hu <zijun.hu@oss.qualcomm.com>
  Date:   2026-09-10 (Thu, 10 Sep 2026)

  Changed paths:
    M doc/btsnoop-protocol.rst
    M monitor/analyze.c
    M monitor/packet.c
    M monitor/packet.h
    M src/shared/btsnoop.h

  Log Message:
  -----------
  monitor: Support vendor packets

Kernel include/net/bluetooth/hci.h defines its packet type as:

  #define HCI_VENDOR_PKT  0xff

  - Defined by vendor
  - Bidirectional (RX and TX)
  - kernel <-> userspace: HCI_VENDOR_PKT followed by vendor packet
  - kernel <-> monitor: vendor packet has TX opcode (22) or RX
    opcode (23)

Support them in tool btmon.


  Commit: 06638a3983fd26f7ed141304b48f50ead2c6972e
      https://github.com/bluez/bluez/commit/06638a3983fd26f7ed141304b48f5=
0ead2c6972e
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-09-10 (Thu, 10 Sep 2026)

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


  Commit: 6679d89c7c6d3dd4c6b25c808bd58e1cc69f10fb
      https://github.com/bluez/bluez/commit/6679d89c7c6d3dd4c6b25c808bd58=
e1cc69f10fb
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-09-10 (Thu, 10 Sep 2026)

  Changed paths:
    M Makefile.tools
    M client/btpclient/bap.c
    M src/shared/btp.h

  Log Message:
  -----------
  client/btpclient: Get Codec capabilities on ASE reply


  Commit: 1f4dbf07531e95ee83ca24b3ece72f1551b8966b
      https://github.com/bluez/bluez/commit/1f4dbf07531e95ee83ca24b3ece72=
f1551b8966b
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-09-10 (Thu, 10 Sep 2026)

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


  Commit: 0aa5118f4c8782c4604937e26ec063a262e34010
      https://github.com/bluez/bluez/commit/0aa5118f4c8782c4604937e26ec06=
3a262e34010
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-09-10 (Thu, 10 Sep 2026)

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


  Commit: a0d138b16027d8597d134dab4edb344588db0f0d
      https://github.com/bluez/bluez/commit/a0d138b16027d8597d134dab4edb3=
44588db0f0d
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-09-10 (Thu, 10 Sep 2026)

  Changed paths:
    M client/btpclient/bap.c
    M client/btpclient/btpclient.h
    M src/shared/btp.h

  Log Message:
  -----------
  client/btpclient: Add BTP_OP_BAP_SEND support


  Commit: 2a0cee7a5af1072bf75239bc8c1fc65bb43033d3
      https://github.com/bluez/bluez/commit/2a0cee7a5af1072bf75239bc8c1fc=
65bb43033d3
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-09-10 (Thu, 10 Sep 2026)

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


  Commit: b2d1281907992e7d294f445fba0c03399f3ecc96
      https://github.com/bluez/bluez/commit/b2d1281907992e7d294f445fba0c0=
3399f3ecc96
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-09-10 (Thu, 10 Sep 2026)

  Changed paths:
    M client/btpclient/ascs.c
    M client/btpclient/bap.c

  Log Message:
  -----------
  client/btpclient: CIG/CIS assignment based on Client/Server role

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


  Commit: 6cf877bf5a61bcb7cd851bc5a98e5a4361608970
      https://github.com/bluez/bluez/commit/6cf877bf5a61bcb7cd851bc5a98e5=
a4361608970
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-09-10 (Thu, 10 Sep 2026)

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


  Commit: ed279b3516ee06f39c4a16b7c02a101de1ec61a6
      https://github.com/bluez/bluez/commit/ed279b3516ee06f39c4a16b7c02a1=
01de1ec61a6
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-10 (Thu, 10 Sep 2026)

  Changed paths:
    M Makefile.am
    M test/functional/requirements.txt

  Log Message:
  -----------
  build: run the test suite in parallel

Both the unit tests and the functional tests were running serially,
which makes "make check" unnecessarily slow.

The automake test harness spawns the individual tests from a sub-make,
so adding -j to AM_MAKEFLAGS for the check-TESTS/recheck targets is
enough to parallelize the unit tests.

The functional tests are parallelized with pytest-xdist. The loadgroup
scheduler is required since pytest-bluezenv marks the tests sharing a
host/VM setup with an xdist_group, so that they are kept on the same
worker instead of each worker re-creating the same setup.

The number of concurrent tests defaults to nproc and can be overridden
with CHECK_JOBS, e.g. "make CHECK_JOBS=3D1 check" for a serial run.

Assisted-by: Claude:claude-opus-5


  Commit: 51d1b7924e5580b724e8cbbfe31b5633d381ae65
      https://github.com/bluez/bluez/commit/51d1b7924e5580b724e8cbbfe31b5=
633d381ae65
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-10 (Thu, 10 Sep 2026)

  Changed paths:
    M .github/workflows/sync.yml

  Log Message:
  -----------
  workflows: allow the sync workflow to be triggered manually

The scheduled trigger is heavily throttled by Github and the run can be
delayed for hours, which makes it hard to verify a change or to recover
from a failed run. Add workflow_dispatch so the workflow can be started
on demand.


Compare: https://github.com/bluez/bluez/compare/19ebd6a2124d...51d1b7924e=
55

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
