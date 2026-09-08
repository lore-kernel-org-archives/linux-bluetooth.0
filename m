Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3224915B7
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Sep 2026 19:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788897319; cv=none; b=TKgbjGLwF97EiM26ITXXswZhxcZGkutry2qQJ5K0U1zVAmTbhUAAr63bJ2IbxlRnrCal1n0VaI8GSkJgrLfnVjI2obAoY3b3Sf1ZTiroJ0onFH33ixzmJWZeFw9ShFgEpfcjyZpKpEofuGGEwCP2rzU5AsVULz3uAEP81ith1f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788897319; c=relaxed/simple;
	bh=NozxpYSM+tfcluWcPhMEsxr5N/nRNR+0zXfGjRHvqbA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=EXP4E6m5+WHge31AmQKvujHjCczqvkWGiUe3SeCB+hxaMaDRZoegM5ZmOQHdQXUqZUVo3NN4bzcEVprWpXeoqPgMN/2zV4QbkY9B6Z3fHuILruO5Pk/OcSW59I5/tuWWTNgOKr/7ACk336E2w+iu5Dyt4qRo/bhJ98s3JkToR9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Dpp26dIX; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Dpp26dIX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1788897316;
	bh=zJYwVVbPTF1DOL3Tz7d3di4e3dVxfwcgcrj66wTenmU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Dpp26dIXFqTAgaZHVWQqaTbJr2oy5LMVOf9/Ydd7VtHQWQjU5WcckL7eiw3Fq9s3A
	 1woPcVPMKbY+yMZxZp9o3jWPfIfsTVIIU6eIffEaT8VyJaL8ha8jkOPHICnXzDr3ts
	 Uk4g4kwoVe8nc99Sd8afSkuVf6KMZS1Dyug81a3Y=
Received: from github.com (hubbernetes-node-0e6f440.ash1-iad.github.net [10.56.207.15])
	by smtp.github.com (Postfix) with ESMTPA id 6BE31181390
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Sep 2026 12:55:16 -0700 (PDT)
Date: Tue, 08 Sep 2026 12:55:16 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/12f5eb-875012@github.com>
Subject: [bluez/bluez] 5ee67b: client: avoid registering ranging objects as
 direc...
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 5ee67b09a565764dd9850c2fb29c605f665867f7
      https://github.com/bluez/bluez/commit/5ee67b09a565764dd9850c2fb29c605f665867f7
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-09-08 (Tue, 08 Sep 2026)

  Changed paths:
    M client/cs.c

  Log Message:
  -----------
  client: avoid registering ranging objects as direct children of "/"

With the default provider path "/", cs_ranging_obj_create() exported
each device's RangingProvider1 object as a direct child of root. That
triggers a NULL-dereference bug in gdbus/object.c's
invalidate_parent_data(), crashing bluetoothctl with SIGSEGV on the
first ChannelSounding1.ProcedureData signal.

Fix by nesting under RANGING_PROVIDER_PATH that is
never independently registered, so the leaf's immediate parent isn't
root. src/ranging.c's provider watch matches any descendant of the
registered root, so discovery is unaffected.


  Commit: 1d413a73f4ffc9fdd3a7f4e188a4b26c0222ad94
      https://github.com/bluez/bluez/commit/1d413a73f4ffc9fdd3a7f4e188a4b26c0222ad94
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-09-08 (Tue, 08 Sep 2026)

  Changed paths:
    M doc/bluetoothctl-cs.rst

  Log Message:
  -----------
  doc: note RangingProvider1 objects are nested in bluetoothctl-cs

register_provider's exported RangingProvider1 objects live under
/org/example/ranging rather than directly under "/", to avoid a
gdbus/object.c bug when linking new top-level children of a path
that already has an ObjectManager attached. Document that alongside
the existing default-path note.


  Commit: b00e6942f13c1ccfeb7446c797c4aab8d4cac7ab
      https://github.com/bluez/bluez/commit/b00e6942f13c1ccfeb7446c797c4aab8d4cac7ab
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-09-08 (Tue, 08 Sep 2026)

  Changed paths:
    M src/btd.h
    M src/main.c
    M src/main.conf

  Log Message:
  -----------
  rap: Add OndemandRanging configuration option

Add a per-adapter config knob under [ChannelSounding] to let the RAS
Initiator use on-demand Ranging Data delivery (Get_Ranging_Data/
ACK_Ranging_Data) instead of real-time notifications. Defaults to
false.

- src/btd.h: add bool ondemand_ranging to struct btd_le_bcs.
- src/main.c: parse "OndemandRanging" into
  btd_opts.defaults.bcs.ondemand_ranging.
- src/main.conf: document the new option.


  Commit: f3e6f8944cc4b9281339759b8c0078f3be704d1f
      https://github.com/bluez/bluez/commit/f3e6f8944cc4b9281339759b8c0078f3be704d1f
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-09-08 (Tue, 08 Sep 2026)

  Changed paths:
    M src/shared/rap.c
    M src/shared/rap.h

  Log Message:
  -----------
  shared: add support for on-demand notification handling

When OndemandRanging is enabled in main.conf, allow the reflector role
to send on-demand ranging data. In the initiator role, handle
on-demand ranging data notifications and the associated control point
opcodes.


  Commit: 84e9708bc56b09e0ace53576f07c6f0796a2795f
      https://github.com/bluez/bluez/commit/84e9708bc56b09e0ace53576f07c6f0796a2795f
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-09-08 (Tue, 08 Sep 2026)

  Changed paths:
    M profiles/ranging/rap.c

  Log Message:
  -----------
  profiles: honor OndemandRanging config for RAS Initiator

In rap_accept(), call bt_rap_set_ondemand_ranging(data->rap, true)
before bt_rap_attach() when btd_opts.defaults.bcs.ondemand_ranging is
set, so the initiator uses on-demand ranging data delivery instead of
the default real-time stream.


  Commit: b21c216d580cf303681bfe9eab60a5414d8b6cc0
      https://github.com/bluez/bluez/commit/b21c216d580cf303681bfe9eab60a5414d8b6cc0
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-09-08 (Tue, 08 Sep 2026)

  Changed paths:
    M profiles/audio/avrcp.c

  Log Message:
  -----------
  avrcp: Fix out-of-bounds parsing of ListPlayerAttributes response

In profiles/audio/avrcp.c, avrcp_list_player_attributes_rsp() parsed the
response using hand-computed offsets into the operands buffer, without
accounting for the fact that operand_count spans the 7 byte AVRCP header
as well as the parameters:

- attrs is a 4 byte array which could be written out-of-bounds if a
  length greater than 4 was declared in the first parameter byte.

- The attribute bytes were read with a bound derived from operand_count,
  so a truncated response could be read past its end. As the receive
  buffer is reused across packets, those stale bytes could be echoed
  back to the peer in the following GetCurrentPlayerValue request.

- params_len was compared against count, which was only ever 0 at that
  point, so the length of the PDU was in practice never validated.

Parse the response through a struct iovec using the util_iov_pull_*
helpers instead, so that the header and each subsequent field are bounds
checked as they are consumed and the remaining length is tracked for us.
This lets params_len be validated against the actual number of parameter
bytes received. The attribute count is still clamped to
AVRCP_ATTRIBUTE_LAST, which is what bounds the write into attrs.

Reported-by: @ax-nnlabs
Closes: https://github.com/bluez/bluez/security/advisories/GHSA-m2vx-pw5f-rc8v
Reported-by: @ax-nnlabs


  Commit: f0ddbc7aaaf60f12871eacf05ad132e98e058a83
      https://github.com/bluez/bluez/commit/f0ddbc7aaaf60f12871eacf05ad132e98e058a83
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-08 (Tue, 08 Sep 2026)

  Changed paths:
    M profiles/audio/avrcp.c

  Log Message:
  -----------
  avrcp: Fix out-of-bounds read parsing attribute lists

avrcp_parse_attribute_list() received only a pointer and an attribute
count, with no indication of how many bytes were actually available. For
each attribute it read an 8 byte header followed by a 16 bit length and
that many bytes of value, none of which was bounds checked.

The callers only validated the fixed portion of each entry:

    if (be16_to_cpu(pdu->params_len) - 1 < count * 8)

which says nothing about the variable length values that follow, so a
response declaring a single attribute with a value length of 0xFFFF
would read far past the end of the receive buffer and pass the result to
media_player_set_metadata().

These are response callbacks, so they do not go through
handle_vendordep_pdu() and params_len had itself never been checked
against the number of bytes received. avrcp_get_element_attributes_rsp()
also cast the operands to an AVRCP header without checking that a full
header was present.

parse_media_element() had a related off-by-one, reading the attribute
count at operands[13 + namesize] when parse_media_name() only
guaranteed that 13 + namesize bytes were present.

Parse all of this through a struct iovec using the util_iov_pull_*
helpers so the remaining length is tracked as each field is consumed,
and validate params_len against the bytes actually received.


  Commit: dbf484cb5690d3f8daebb81550d06c15699f33af
      https://github.com/bluez/bluez/commit/dbf484cb5690d3f8daebb81550d06c15699f33af
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-08 (Tue, 08 Sep 2026)

  Changed paths:
    M profiles/audio/avrcp.c

  Log Message:
  -----------
  avrcp: Use util_iov helpers to parse responses

Every controller side response callback parsed the PDU with hand
computed offsets into the operands buffer. None of them validated the
declared parameters length against the number of bytes actually
received: unlike commands, responses do not go through
handle_vendordep_pdu(), so nothing did it on their behalf. Several read
past the end of the receive buffer as a result, for example:

- avrcp_get_capabilities_resp() read pdu->params[1 + count] for a count
  taken from the response itself, with no length check at all, and then
  shifted by the resulting event id without bounding it.

- avrcp_player_value_rsp() bounded its loop with

      if (pdu->params_len < count * 2)

  comparing a big endian field without byte swapping it, so on little
  endian the check passes for practically any value.

- avrcp_get_play_status_rsp() only checked params_len, which is supplied
  by the peer, and read nine bytes on the strength of it.

- avrcp_set_browsed_player_rsp() indexed folder names relative to
  pdu->params but bounded them against operand_count, which also spans
  the browsing header.

Add avrcp_pull_header() and avrcp_pull_browsing_header(), which pull the
respective header out of a struct iovec and check that the length it
declares matches what was received, and convert the response callbacks
to pull their fields with the util_iov helpers so the remaining length
is tracked as it is consumed.

Since the receive buffer is reused between packets, the bytes read past
the end of a short response were the contents of an earlier PDU, some of
which were then reported over D-Bus or echoed back to the peer.


  Commit: 52728deef506e43d8ed21f7d5a536d3834cc1844
      https://github.com/bluez/bluez/commit/52728deef506e43d8ed21f7d5a536d3834cc1844
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-08 (Tue, 08 Sep 2026)

  Changed paths:
    M Makefile.plugins
    A profiles/audio/avrcp-parse.c
    A profiles/audio/avrcp-parse.h
    M profiles/audio/avrcp.c
    M profiles/audio/avrcp.h

  Log Message:
  -----------
  avrcp: Move response parsers to avrcp-parse.c

The parsing of controller side responses lives in the middle of
avrcp.c, interleaved with the media_player and D-Bus glue that consumes
its results. That makes it unreachable from the unit tests: none of it
can be called without an adapter, a device, a service and a session.

The three preceding fixes were all in this code, and none of them could
be covered by a regression test as a result.

Move the parsing proper to a new avrcp-parse.c, which depends on
nothing but util_iov and log.h:

- avrcp_pull_header() and avrcp_pull_browsing_header()
- avrcp_parse_player_attributes(), which now takes the bound on the
  attribute array from its caller
- avrcp_parse_attribute_list(), which reports each attribute through a
  callback rather than calling media_player_set_metadata() itself
- avrcp_parse_media_name(), avrcp_parse_media_element() and
  avrcp_parse_media_folder(), which fill a plain struct rather than
  creating media items

struct avrcp_header, struct avrcp_browsing_header, NAME_MAX_LEN and the
player attribute ids move to the new header, which avrcp.h now includes
so that its users are unaffected.

The logic is unchanged; avrcp.c keeps the glue as thin wrappers.

Assisted-by: Claude:claude-opus-5 valgrind


  Commit: c1e0079c968b8c52f724db52fc33333749275ba3
      https://github.com/bluez/bluez/commit/c1e0079c968b8c52f724db52fc33333749275ba3
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-08 (Tue, 08 Sep 2026)

  Changed paths:
    M Makefile.am
    M unit/test-avrcp.c

  Log Message:
  -----------
  unit/test-avrcp: Add robustness tests for response parsing

The existing tests drive avrcp-lib.c through the AVCTP harness and all
feed it well formed PDUs. Nothing covered what happens when a peer
sends a response that lies about its own length, which is what the
three preceding fixes were about.

Add tests under /robustness that call the parsers in avrcp-parse.c
directly, since a response is entirely peer controlled and the parser
is what has to survive it:

- headers that are short, that declare more parameter bytes than were
  received, and that declare fewer

- a ListPlayerApplicationSettingAttributes response declaring 255
  attributes, which used to be written into a four byte array, and one
  declaring more attributes than it carries

- attribute lists declaring a 0xFFFF byte value with none of it
  present, a truncated value, a truncated attribute header, and more
  attributes than were received

- media elements missing the attribute count that follows the name,
  carrying a name longer than NAME_MAX_LEN, or declaring a name that is
  not there, and the equivalent for media folders

Each PDU is copied into a buffer of exactly its size, so that reading
past the end of it is an out-of-bounds access rather than a read of
whatever the receive buffer happened to hold beforehand, and the
attribute array is surrounded by a guard so that a write past its end
is caught without a sanitizer.

Reverting the three fixes fails ten of these outright and trips
valgrind on six more.

Assisted-by: Claude:claude-opus-5 valgrind


  Commit: 00061ef05da8799448a4feef7e94762b4f9af426
      https://github.com/bluez/bluez/commit/00061ef05da8799448a4feef7e94762b4f9af426
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-09-08 (Tue, 08 Sep 2026)

  Changed paths:
    A doc/test-functional.rst

  Log Message:
  -----------
  doc: add functional/integration testing documentation

Add documentation for functional/integration test suite.


  Commit: 7f9d38593d2e6c39e5c87b760cf84b4adbdb90ab
      https://github.com/bluez/bluez/commit/7f9d38593d2e6c39e5c87b760cf84b4adbdb90ab
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-09-08 (Tue, 08 Sep 2026)

  Changed paths:
    A test/functional/__init__.py
    A test/functional/conftest.py
    A test/functional/requirements.txt
    A test/functional/test_bluetoothctl.py
    A test/functional/test_btmgmt.py
    A test/pytest.ini
    A test/test-functional
    A test/test-functional-attach

  Log Message:
  -----------
  test: add functional/integration testing framework

Add framework for writing tests simulating "real" environments where
BlueZ and other parts of the stack run on different virtual machine
hosts that communicate with each other.

Add some smoke tests for bluetoothctl and btmgmt.

The implementation for the VM setup is maintained separately in the
pytest-bluezenv plugin, https://pypi.org/project/pytest-bluezenv

Implements:

- RPC communication with tester instances running each of the VM hosts,
  so that tests can be written on the parent host which coordinates the
  execution.

- Extensible way to add stateful test-specific code inside the VM
  instances

- Logging control: output from different processes running inside the VM
  are separated and can be filtered.

- Test runner framework with Pytest, factored into a pytest plugin

- Grouping tests to minimize VM reboots

- Redirecting USB controllers to use for testing

There is no requirement that the tests spawn VM instances.


  Commit: af075cdc093727eefe4e6ef2e288b35f97cdc396
      https://github.com/bluez/bluez/commit/af075cdc093727eefe4e6ef2e288b35f97cdc396
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-09-08 (Tue, 08 Sep 2026)

  Changed paths:
    M Makefile.am
    M configure.ac

  Log Message:
  -----------
  build: add functional testing target

This adds check-functional: target that runs the functional test suite.

Also add a --enable-functional-testing=<kernel-image> argument for
configure that can be used to include it in the check: make target,
possibly with a predefined kernel image.


  Commit: 9f223eb701e36fb746f1dbad097ac5d2883e3724
      https://github.com/bluez/bluez/commit/9f223eb701e36fb746f1dbad097ac5d2883e3724
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-09-08 (Tue, 08 Sep 2026)

  Changed paths:
    M test/functional/requirements.txt
    A test/functional/test_tests.py

  Log Message:
  -----------
  test: functional: impose Python code formatting

Check Python code formatting of the functional test suite.


  Commit: b626b5893f450d1b02d43f33b48a2bf1714cfaa2
      https://github.com/bluez/bluez/commit/b626b5893f450d1b02d43f33b48a2bf1714cfaa2
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-09-08 (Tue, 08 Sep 2026)

  Changed paths:
    A test/functional/test_agent.py

  Log Message:
  -----------
  test: functional: add some Agent1 interface tests

Add test

test/functional/test_agent.py::test_agent_pair_bredr


  Commit: b73c31b5302079ee282b33abdbc68627ec92b20f
      https://github.com/bluez/bluez/commit/b73c31b5302079ee282b33abdbc68627ec92b20f
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-09-08 (Tue, 08 Sep 2026)

  Changed paths:
    A test/functional/test_obex.py

  Log Message:
  -----------
  test: functional: add basic obex file transfer tests

Add tests for Obex DBus API and obexctl

test/functional/test_obex.py::test_obex_ftp_get
test/functional/test_obex.py::test_obex_ftp_list
test/functional/test_obex.py::test_obexctl_list


  Commit: a321411065b1cb727a0cea1801413dccb3c8a68c
      https://github.com/bluez/bluez/commit/a321411065b1cb727a0cea1801413dccb3c8a68c
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-09-08 (Tue, 08 Sep 2026)

  Changed paths:
    A test/functional/test_kernel_testers.py
    M test/pytest.ini

  Log Message:
  -----------
  test: functional: add tests running the various kernel testers

It's more convenient to have simple local test runner for these.


  Commit: 2bbf2db84c2ba53c7980d1afcd2c17614959f014
      https://github.com/bluez/bluez/commit/2bbf2db84c2ba53c7980d1afcd2c17614959f014
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-09-08 (Tue, 08 Sep 2026)

  Changed paths:
    M test/functional/conftest.py
    A test/functional/test_adv_monitor.py
    M test/pytest.ini

  Log Message:
  -----------
  test: functional: add test for adv_monitor crash

Add test checking adv_monitor overflow crash.
From PoC provided by Alexandro Calo' (Nozomi Networks Labs)


  Commit: 24fa99283d9f74fb2690dda89eb668a3416bc95f
      https://github.com/bluez/bluez/commit/24fa99283d9f74fb2690dda89eb668a3416bc95f
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-09-08 (Tue, 08 Sep 2026)

  Changed paths:
    M test/functional/conftest.py
    A test/functional/test_avrcp.py
    M test/functional/test_obex.py

  Log Message:
  -----------
  test: functional: add test for AVRCP crash

Add test checking AVRCP ListPlayerAttributes crash.
From PoC provided by Alexandro Calo' (Nozomi Networks Labs)

Refactor test_obex.paired_hosts fixture to global fixture.


  Commit: bed6e360235660b1278287a4121336af3e9614c1
      https://github.com/bluez/bluez/commit/bed6e360235660b1278287a4121336af3e9614c1
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-08 (Tue, 08 Sep 2026)

  Changed paths:
    M Makefile.am

  Log Message:
  -----------
  test: functional: exclude kernel testers from make check

The tests marked 'tester' are kernel testers: they exercise the kernel
rather than BlueZ userspace and should not gate a userspace release.
Run pytest with -m 'not tester' in check-functional (which make check
invokes when functional testing is enabled). The kernel testers can
still be run manually with 'test/test-functional -m tester'.

Assisted-by: opencode:glm-5.3


  Commit: 8750129efca858ff7e88e0d3166851fdd4590d8e
      https://github.com/bluez/bluez/commit/8750129efca858ff7e88e0d3166851fdd4590d8e
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-08 (Tue, 08 Sep 2026)

  Changed paths:
    M doc/test-functional.rst

  Log Message:
  -----------
  doc: test-functional: document make targets and configure options

Document 'make check' and 'make check-functional', including that
kernel testers are excluded from check-functional, and the
'--enable-functional-testing[=<image>]' configure option which takes
an optional kernel image path that becomes the default
FUNCTIONAL_TESTING_KERNEL, e.g.
'./bootstrap-configure --enable-functional-testing=/pathto/bzImage'.

Assisted-by: opencode:glm-5.3


Compare: https://github.com/bluez/bluez/compare/12f5eb726c6e...8750129efca8

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
