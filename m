Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Am28eZSQ"
Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F26B11F
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 Dec 2023 19:38:07 -0800 (PST)
Received: from github.com (hubbernetes-node-a46a486.ac4-iad.github.net [10.52.125.53])
	by smtp.github.com (Postfix) with ESMTPA id 954B15E072B
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 Dec 2023 19:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1701747486;
	bh=jE5/qhLcB5OrBza8LgXNPjfUI4tmT65Up6Mor7aNJRM=;
	h=Date:From:To:Subject:From;
	b=Am28eZSQtdXrMonZpOh4Hv3XudJw8n1mLiQ8UmRI08016bSdkv+JzQJW/s3rULDPP
	 lqH/pGsMG3HYzurtEyy7J2tRIf6N8i8cD9TBgtvz4EKln1uNbaGiZoIfN+8Li5WDtW
	 vKdTiMB+Q6NnV2okL3/QRGjhIGkoPpaAWYkuEzck=
Date: Mon, 04 Dec 2023 19:38:06 -0800
From: iulia-tanasescu <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/cb1a3f-8980f4@github.com>
Subject: [bluez/bluez] eae77d: shared/vcp: Fix comparison of values in
 different ...
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
  Commit: eae77d7e49cec29ab06e1c132d9750cdef3d01b5
      https://github.com/bluez/bluez/commit/eae77d7e49cec29ab06e1c132d975=
0cdef3d01b5
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-12-04 (Mon, 04 Dec 2023)

  Changed paths:
    M src/shared/vcp.c

  Log Message:
  -----------
  shared/vcp: Fix comparison of values in different endianness

Values received over the air are in Little Endian format so they first
need to be converted to host endianness before comparing with other
values.


  Commit: e3d9aad7d6e6ef07384b92b5632e9bab9f6f61bd
      https://github.com/bluez/bluez/commit/e3d9aad7d6e6ef07384b92b5632e9=
bab9f6f61bd
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-12-04 (Mon, 04 Dec 2023)

  Changed paths:
    M src/shared/lc3.h

  Log Message:
  -----------
  shared/lc3: Add QoS definitions

This adds the QoS preset definitions as per BAP specification.


  Commit: 9c3824db2aa5043ff857b9f3caa5f8fbc4ef08cc
      https://github.com/bluez/bluez/commit/9c3824db2aa5043ff857b9f3caa5f=
8fbc4ef08cc
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-12-04 (Mon, 04 Dec 2023)

  Changed paths:
    M unit/test-bap.c

  Log Message:
  -----------
  test-bap: Introduce QoS tests for LC3

4.8.3 Unicast Client Initiates Config QoS =E2=80=93 LC3
(Page 43)

  Test Purpose:
  Verify that a Unicast Client IUT can initiate a Config QoS operation fo=
r the
  LC3 codec.

  Pass verdict:
  The IUT successfully writes to the ASE Control Point characteristic wit=
h the
  opcode set to 0x02 (Config QoS) and the specified parameters.

Test Summary
------------
BAP/UCL/SCC/BV-035-C [UCL SRC Config QoS, LC3 8_1_1] Passed
BAP/UCL/SCC/BV-036-C [UCL SRC Config QoS, LC3 8_2_1] Passed
BAP/UCL/SCC/BV-037-C [UCL SRC Config QoS, LC3 16_1_1] Passed
BAP/UCL/SCC/BV-038-C [UCL SRC Config QoS, LC3 16_2_1] Passed
BAP/UCL/SCC/BV-039-C [UCL SRC Config QoS, LC3 24_1_1] Passed
BAP/UCL/SCC/BV-040-C [UCL SRC Config QoS, LC3 24_2_1] Passed
BAP/UCL/SCC/BV-041-C [UCL SRC Config QoS, LC3 32_1_1] Passed
BAP/UCL/SCC/BV-042-C [UCL SRC Config QoS, LC3 32_2_1] Passed
BAP/UCL/SCC/BV-043-C [UCL SRC Config QoS, LC3 44.1_1_1] Passed
BAP/UCL/SCC/BV-044-C [UCL SRC Config QoS, LC3 44.1_2_1] Passed
BAP/UCL/SCC/BV-045-C [UCL SRC Config QoS, LC3 48_1_1] Passed
BAP/UCL/SCC/BV-046-C [UCL SRC Config QoS, LC3 48_2_1] Passed
BAP/UCL/SCC/BV-047-C [UCL SRC Config QoS, LC3 48_3_1] Passed
BAP/UCL/SCC/BV-048-C [UCL SRC Config QoS, LC3 48_4_1] Passed
BAP/UCL/SCC/BV-049-C [UCL SRC Config QoS, LC3 48_5_1] Passed
BAP/UCL/SCC/BV-050-C [UCL SRC Config QoS, LC3 48_6_1] Passed
BAP/UCL/SCC/BV-051-C [UCL SNK Config QoS, LC3 8_1_1] Passed
BAP/UCL/SCC/BV-052-C [UCL SNK Config QoS, LC3 8_2_1] Passed
BAP/UCL/SCC/BV-053-C [UCL SNK Config QoS, LC3 16_1_1] Passed
BAP/UCL/SCC/BV-054-C [UCL SNK Config QoS, LC3 16_2_1] Passed
BAP/UCL/SCC/BV-055-C [UCL SNK Config QoS, LC3 24_1_1] Passed
BAP/UCL/SCC/BV-056-C [UCL SNK Config QoS, LC3 24_2_1] Passed
BAP/UCL/SCC/BV-057-C [UCL SNK Config QoS, LC3 32_1_1] Passed
BAP/UCL/SCC/BV-058-C [UCL SNK Config QoS, LC3 32_2_1] Passed
BAP/UCL/SCC/BV-059-C [UCL SNK Config QoS, LC3 44.1_1_1] Passed
BAP/UCL/SCC/BV-060-C [UCL SNK Config QoS, LC3 44.1_2_1] Passed
BAP/UCL/SCC/BV-061-C [UCL SNK Config QoS, LC3 48_1_1] Passed
BAP/UCL/SCC/BV-062-C [UCL SNK Config QoS, LC3 48_2_1] Passed
BAP/UCL/SCC/BV-063-C [UCL SNK Config QoS, LC3 48_3_1] Passed
BAP/UCL/SCC/BV-064-C [UCL SNK Config QoS, LC3 48_4_1] Passed
BAP/UCL/SCC/BV-065-C [UCL SNK Config QoS, LC3 48_5_1] Passed
BAP/UCL/SCC/BV-066-C [UCL SNK Config QoS, LC3 48_6_1] Passed
BAP/UCL/SCC/BV-067-C [UCL SRC Config QoS, LC3 8_1_2] Passed
BAP/UCL/SCC/BV-068-C [UCL SRC Config QoS, LC3 8_2_2] Passed
BAP/UCL/SCC/BV-069-C [UCL SRC Config QoS, LC3 16_1_2] Passed
BAP/UCL/SCC/BV-070-C [UCL SRC Config QoS, LC3 16_2_2] Passed
BAP/UCL/SCC/BV-071-C [UCL SRC Config QoS, LC3 24_1_2] Passed
BAP/UCL/SCC/BV-072-C [UCL SRC Config QoS, LC3 24_2_2] Passed
BAP/UCL/SCC/BV-073-C [UCL SRC Config QoS, LC3 32_1_2] Passed
BAP/UCL/SCC/BV-074-C [UCL SRC Config QoS, LC3 32_2_2] Passed
BAP/UCL/SCC/BV-075-C [UCL SRC Config QoS, LC3 44.1_1_2] Passed
BAP/UCL/SCC/BV-076-C [UCL SRC Config QoS, LC3 44.1_2_2] Passed
BAP/UCL/SCC/BV-077-C [UCL SRC Config QoS, LC3 48_1_2] Passed
BAP/UCL/SCC/BV-078-C [UCL SRC Config QoS, LC3 48_2_2] Passed
BAP/UCL/SCC/BV-079-C [UCL SRC Config QoS, LC3 48_3_2] Passed
BAP/UCL/SCC/BV-080-C [UCL SRC Config QoS, LC3 48_4_2] Passed
BAP/UCL/SCC/BV-081-C [UCL SRC Config QoS, LC3 48_5_2] Passed
BAP/UCL/SCC/BV-082-C [UCL SRC Config QoS, LC3 48_6_2] Passed
BAP/UCL/SCC/BV-083-C [UCL SNK Config QoS, LC3 8_1_2] Passed
BAP/UCL/SCC/BV-084-C [UCL SNK Config QoS, LC3 8_2_2] Passed
BAP/UCL/SCC/BV-085-C [UCL SNK Config QoS, LC3 16_1_2] Passed
BAP/UCL/SCC/BV-086-C [UCL SNK Config QoS, LC3 16_2_2] Passed
BAP/UCL/SCC/BV-087-C [UCL SNK Config QoS, LC3 24_1_2] Passed
BAP/UCL/SCC/BV-088-C [UCL SNK Config QoS, LC3 24_2_2] Passed
BAP/UCL/SCC/BV-089-C [UCL SNK Config QoS, LC3 32_1_2] Passed
BAP/UCL/SCC/BV-090-C [UCL SNK Config QoS, LC3 32_2_2] Passed
BAP/UCL/SCC/BV-091-C [UCL SNK Config QoS, LC3 44.1_1_2] Passed
BAP/UCL/SCC/BV-092-C [UCL SNK Config QoS, LC3 44.1_2_2] Passed
BAP/UCL/SCC/BV-093-C [UCL SNK Config QoS, LC3 48_1_2] Passed
BAP/UCL/SCC/BV-094-C [UCL SNK Config QoS, LC3 48_2_2] Passed
BAP/UCL/SCC/BV-095-C [UCL SNK Config QoS, LC3 48_3_2] Passed
BAP/UCL/SCC/BV-096-C [UCL SNK Config QoS, LC3 48_4_2] Passed
BAP/UCL/SCC/BV-097-C [UCL SNK Config QoS, LC3 48_5_2] Passed
BAP/UCL/SCC/BV-098-C [UCL SNK Config QoS, LC3 48_6_2] Passed
Total: 64, Passed: 64 (100.0%), Failed: 0, Not Run: 0


  Commit: f93fec890447401aa60403126e217b7154624405
      https://github.com/bluez/bluez/commit/f93fec890447401aa60403126e217=
b7154624405
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-12-04 (Mon, 04 Dec 2023)

  Changed paths:
    M unit/test-bap.c

  Log Message:
  -----------
  test-bap: Add SCC Config QoS, VS tests

4.8.4 Unicast Client Initiates Config QoS =E2=80=93 Vendor-Specific (Page=
 46)

  Test Purpose:
  Verify that a Unicast Client IUT can initiate a Config QoS operation fo=
r a
  vendor-specific codec.

  Pass verdict:
  The IUT successfully writes to the ASE Control Point characteristic wit=
h the
  opcode set to 0x02 (Config QoS) and the specified parameters.

Test Summary
------------
BAP/UCL/SCC/BV-099-C [UCL SNK Config QoS, VS]        Passed
BAP/UCL/SCC/BV-100-C [UCL SRC Config QoS, VS]        Passed
Total: 2, Passed: 2 (100.0%), Failed: 0, Not Run: 0


  Commit: 6f957d3b6c438debefb1536a1ebb46214b592c57
      https://github.com/bluez/bluez/commit/6f957d3b6c438debefb1536a1ebb4=
6214b592c57
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-12-04 (Mon, 04 Dec 2023)

  Changed paths:
    M unit/test-bap.c

  Log Message:
  -----------
  test-bap: Add SCC Enable tests

4.8.5 Unicast Client Initiates Enable Operation (Page 48)

  Test Purpose:
  Verify that a Unicast Client IUT can initiate an Enable operation for a=
n ASE
  with a Unicast Server that is either in the Audio Sink role or the Audi=
o
  Source role.

  Pass verdict:
  The IUT successfully writes to the ASE Control Point characteristic wit=
h the
  opcode set to 0x03 (Enable) and the specified parameters.

Test Summary
------------
BAP/UCL/SCC/BV-101-C [UCL SRC Enable]                Passed
BAP/UCL/SCC/BV-102-C [UCL SNK Enable]                Passed
Total: 2, Passed: 2 (100.0%), Failed: 0, Not Run: 0


  Commit: 58805e4f28a3d1a401edae308a74dde66c77f27c
      https://github.com/bluez/bluez/commit/58805e4f28a3d1a401edae308a74d=
de66c77f27c
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-12-04 (Mon, 04 Dec 2023)

  Changed paths:
    M unit/test-bap.c

  Log Message:
  -----------
  test-bap: Add SCC Disable tests

4.8.6 Unicast Client Initiates Disable Operation (Page 50):

  Test Purpose:
  Verify that a Unicast Client IUT can initiate a Disable operation for a=
n ASE
  in the Enabling or Streaming state.

  Pass verdict:
  The IUT successfully writes to the ASE Control Point characteristic wit=
h the
  opcode set to 0x05 (Disable) and the specified parameters.

Test Summary
------------
BAP/UCL/SCC/BV-103-C [UCL SNK Disable in Enabling State] Passed
BAP/UCL/SCC/BV-104-C [UCL SRC Disable in Enabling or Streaming state] Pas=
sed
BAP/UCL/SCC/BV-105-C [UCL SNK Disable in Streaming State] Passed
Total: 3, Passed: 3 (100.0%), Failed: 0, Not Run: 0


  Commit: f10faf387d7ff5ef08a403dec895760996cb55ef
      https://github.com/bluez/bluez/commit/f10faf387d7ff5ef08a403dec8957=
60996cb55ef
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-12-04 (Mon, 04 Dec 2023)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Fix possible crash when freeing requests

Requests maybe queued using a stream so when detaching it needs to be
canceled otherwise they can lead crashes like bellow:

 Invalid read of size 8
    at 0x1C3247: stream_stop_complete (bap.c:1230)
    by 0x1BB2A3: bap_req_complete (bap.c:3863)
    by 0x1C7BB3: bap_req_detach (bap.c:4219)
    by 0x1C7BB3: bt_bap_detach (bap.c:4231)
    by 0x1C7BB3: bt_bap_detach (bap.c:4222)
    by 0x1C7E67: bap_free (bap.c:2937)
    by 0x1C7E67: bt_bap_unref (bap.c:3090)
    by 0x1C7E67: bt_bap_unref (bap.c:3082)
    by 0x18CCC2: test_teardown (test-bap.c:513)
    by 0x1D826A: teardown_callback (tester.c:434)
    by 0x491E4FC: g_idle_dispatch (gmain.c:6163)
    by 0x49224FB: UnknownInlinedFun (gmain.c:3460)
    by 0x49224FB: g_main_context_dispatch (gmain.c:4200)
    by 0x49806B7: g_main_context_iterate.isra.0 (gmain.c:4276)
    by 0x4921AFE: g_main_loop_run (gmain.c:4479)
    by 0x1E8EF4: mainloop_run (mainloop-glib.c:66)
    by 0x1E93F7: mainloop_run_with_signal (mainloop-notify.c:188)
  Address 0x57b9ad0 is 0 bytes inside a block of size 120 free'd
    at 0x4845B2C: free (vg_replace_malloc.c:985)
    by 0x1CBAB7: bap_stream_state_changed (bap.c:1290)
    by 0x1D3104: bap_ep_set_status (bap.c:3673)
    by 0x1DC746: queue_foreach (queue.c:207)
    by 0x1A5320: notify_cb (gatt-client.c:2271)
    by 0x19A1EF: handle_notify (att.c:1012)
    by 0x19A1EF: can_read_data (att.c:1096)
    by 0x1D68CF: watch_callback (io-glib.c:157)
    by 0x49224FB: UnknownInlinedFun (gmain.c:3460)
    by 0x49224FB: g_main_context_dispatch (gmain.c:4200)
    by 0x49806B7: g_main_context_iterate.isra.0 (gmain.c:4276)
    by 0x4921AFE: g_main_loop_run (gmain.c:4479)
    by 0x1E8EF4: mainloop_run (mainloop-glib.c:66)
    by 0x1E93F7: mainloop_run_with_signal (mainloop-notify.c:188)


  Commit: 5d2277071237e90ae407e3a31344870d91cb673d
      https://github.com/bluez/bluez/commit/5d2277071237e90ae407e3a313448=
70d91cb673d
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-12-04 (Mon, 04 Dec 2023)

  Changed paths:
    M unit/test-bap.c

  Log Message:
  -----------
  test-bap: Add SCC Release tests

4.8.7 Unicast Client Initiates Release Operation (Page 51):

  Test Purpose:
  Verify that a Unicast Client IUT can release an ASE by initiating a Rel=
ease
  operation.

  Pass verdict:
  The IUT successfully writes to the ASE Control Point characteristic wit=
h the
  opcode set to 0x08 (Release) and the specified parameters.

Test Summary
------------
BAP/UCL/SCC/BV-106-C [UCL SNK Release in Codec Configured state] Passed
BAP/UCL/SCC/BV-107-C [UCL SRC Release in Codec Configured state] Passed
BAP/UCL/SCC/BV-108-C [UCL SNK Release in QoS Configured state] Passed
BAP/UCL/SCC/BV-109-C [UCL SRC Release in QoS Configured state] Passed
BAP/UCL/SCC/BV-110-C [UCL SNK Release in Enabling state] Passed
BAP/UCL/SCC/BV-111-C [UCL SRC Release in Enabling or Streaming state] Pas=
sed
BAP/UCL/SCC/BV-112-C [UCL SNK Release in Streaming state] Passed
BAP/UCL/SCC/BV-113-C [UCL SNK Release in Disabling state] Passed
Total: 8, Passed: 8 (100.0%), Failed: 0, Not Run: 0


  Commit: 9b322d3a52a14b62547990c97bcf115a4f37ac4b
      https://github.com/bluez/bluez/commit/9b322d3a52a14b62547990c97bcf1=
15a4f37ac4b
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-12-04 (Mon, 04 Dec 2023)

  Changed paths:
    M unit/test-bap.c

  Log Message:
  -----------
  test-bap: Add SCC Update Metadata tests

4.8.8 Unicast Client Initiates Update Metadata Operation (Page 53):

  Test Purpose:
  Verify that a Unicast Client IUT can update the Metadata of an ASE by
  initiating an Update Metadata operation.

  Pass verdict:
  The IUT successfully writes to the ASE Control Point characteristic wit=
h the
  opcode set to 0x07 (Update Metadata) and the specified parameters.

Test Summary
------------
BAP/UCL/SCC/BV-115-C [UCL SNK Update Metadata in Enabling State] Passed
BAP/UCL/SCC/BV-116-C [UCL SRC Update Metadata in Enabling or Streaming st=
ate]
Passed
BAP/UCL/SCC/BV-117-C [UCL SNK Update Metadata in Streaming State] Passed
Total: 3, Passed: 3 (100.0%), Failed: 0, Not Run: 0


  Commit: 227e16f5c9874f27187a35a4d6408b2e811a7fd2
      https://github.com/bluez/bluez/commit/227e16f5c9874f27187a35a4d6408=
b2e811a7fd2
  Author: Per Waag=C3=B8 <pwaago@cisco.com>
  Date:   2023-12-04 (Mon, 04 Dec 2023)

  Changed paths:
    M src/adapter.c

  Log Message:
  -----------
  adapter: Enable SSP after enabling BREDR

When enabling Secure Simple Pairing, the kernel first checks if
BREDR is enabled. If it's not, enabling SSP fails. Therefore, it
is necessary to make sure that BREDR is enabled before enabling
SSP.

Without this fix, bluetoothd would start without SSP enabled if
started in dual or bredr mode after it had been run in le mode.


  Commit: 8980f4f1f730119749138c62f7e9f95a259c87d6
      https://github.com/bluez/bluez/commit/8980f4f1f730119749138c62f7e9f=
95a259c87d6
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2023-12-04 (Mon, 04 Dec 2023)

  Changed paths:
    M src/shared/bass.c

  Log Message:
  -----------
  shared/bass: Functions cleanup

This adds some cleanup in shared/bass code: use util_iov
APIs to extract/push bytes, use new0 to allocate structures,
remove redundant functions.


Compare: https://github.com/bluez/bluez/compare/cb1a3fd96c48...8980f4f1f7=
30
