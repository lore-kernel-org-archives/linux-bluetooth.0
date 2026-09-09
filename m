Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AB141A903
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Sep 2026 19:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788981804; cv=none; b=NVQrGno/IrHgxib1nyu5Q3VUQRHh3coMxOLvUUDv05aVkTb2M7fDKWIUyDyD99vo8vtKgjtp5r3huj/adybzwgNjq8S2VmaJKEgx1QDbAUIDJGl1sjnpDAOHxGMxw6/INUr0RS2A0qcie87vDKwQyupMNCkN0dh11LCo/7jIIAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788981804; c=relaxed/simple;
	bh=FzuD/bhHJTHYE7ylE2b1rVwOf++kIm3h6vuhjCWOTtU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gTxp8s+DD0fdfxaTgjzD4xdqIsTi7t8zP0hidb/t0SqFdfBx+eCqLgNRywmuFOjQ5lW6P+33cFn3QeWWULaxlojgmJaqHi89jXddWqeOSwtwJcR6xVUBHbjC1MOs7YC/Y9Jeumrl+eb4RUv+Ynxr94kCaDZxUo+yuE26e5agbKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eaB2wcU0; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eaB2wcU0"
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-765c077b5c1so2174987137.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Sep 2026 12:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788981801; x=1789586601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fVh2xizPI5+aYuVO/ZaR5wqBeJm2g1smJJ2kZp9m5Dk=;
        b=eaB2wcU0cxAhXD6/6kJLAlO48ujIrEiCAYD0fxcq2w/LsR+M8tvp1UtJUJC0o1YA/1
         O/URayLyMpTHn5Xk3i/QlQQLicOF+yuMGjgRhaKavcthQbuTg4BhRWVnqN4flgNOpXqQ
         raB2qep32ZcoaeZEyrQnj0sFYDzRfh445URvCcTlpoO9o2y/3jryxfmgY157bGJKh85j
         Lklc8EI7UfunrRJ+Qui4N4hR/v6hmuhB78PGuu6Qk8o5PPZrWiHgTYFhGjlqwkW74lIC
         KNn6EQtzfS/j/a6dY9jcg6cJwwrJG+pwb6omHX3SbgMwC9TIM4jcDLdtD1j8EIoyBqZI
         MLFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788981801; x=1789586601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=fVh2xizPI5+aYuVO/ZaR5wqBeJm2g1smJJ2kZp9m5Dk=;
        b=AI0EWNNwfh5YpFcSK5NDs5ACuzX/bLcyy1wN/+VDeiBSS7lu2A+GodgdQEES3hYB6K
         1rbIqGboJQduyLJWRo2SPkamDXrrgVnh3W+pOL7P71U2simiZckQczcHnq9yB+3sronI
         HJzF8+QHRLYi26dVD6UIWhinfFyvHnFGyaEc/D1PV+kUbIfy+cJ2IS6/xFkTZzN3crmS
         4iolV/BZAO9SM6TRAs5W3h3AxSkMd75YZvGCMjCImLhSyF7iSeRiFgnIHzhUrYTevFhO
         k0fUiYZIcH1+PiuzIUrwpCtjbiLDZE7pLAUgQewy/p02//GA4OlvJV07Kq6ZqO4OA9rJ
         iMNg==
X-Gm-Message-State: AFuF++knbACtHrDnBROO8hSWrrLgE2DLfx05NW30+5Zfc55E1/sBYE6g
	8MBCDVXN7MqT5dSN9HIyFt07gTYqfDVedmfO9rfHVzSnrhbaG2A6d/hRHFLcKTQS
X-Gm-Gg: AYBFou07u3h1qGsdTPtUZFFk5UBzDwGAGcS6/f4hmTs0t0Bpzxx76YA2E51zuu1rvCm
	o2tuz4VFYaDyhQzirL+s+lQYIqVfLc3104LAkbrq19JQmXDeWMVw5mFM9kpviRM+8kE8VF6PRJX
	Ij+s0d1Q7lzotI5IQb7hMgvinkNXHx4xLe+F/SkL/Lg3pH7Ffoc43TUq/5gM03xO9LIfMwdmzIs
	3jpFsV7qd0+u3P4nomIVzgQq5qHgTx/T7UnXdUGfeDrXLooKfjy0OxZSIfhZTPCGCPslSp0h8bu
	3jCAxo6cKBNigqTAKhQ26y+IFIAeDg5cuTO2YGdiLVQr36UVu1Fh5AaQdARjKswTLiMPW6A2KHm
	yxaPFsZ6tzzg5J7j2gCTo5BeQ9JkSXPMfTOtVs6rkG4o+6/by3yxES/2NNpWTjkA/rZbVZshVAg
	/SVuAiBpGxGArXrDoknXRQ9mR6A2Vp0lyubCl7MU5KiyyUqICaLbW4vrAyqAmwMrpzRxoikoRUm
	8TVFniMMr0P6NF3Uvqw/7irhwhSs9nOSPDr0jgTWZeLpMzD3/YtNZj5F3Cwl4CW/Q==
X-Received: by 2002:a05:6102:554a:b0:785:c39b:6a1 with SMTP id ada2fe7eead31-78a4a8bb304mr15908109137.6.1788981800301;
        Wed, 09 Sep 2026 12:23:20 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9808ee8039csm13162744241.11.2026.09.09.12.23.19
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 12:23:19 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 02/12] doc: describe the functional test cases
Date: Wed,  9 Sep 2026 15:22:58 -0400
Message-ID: <20260909192308.1306567-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909192308.1306567-1-luiz.dentz@gmail.com>
References: <20260909192308.1306567-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add doc/functional-testing.rst describing the test cases under
test/functional as setup, steps, expected outcome and notes, so a test
can be reproduced and reviewed without reading its source, and the
reason behind the way it is written is not lost. The setup of each test
includes a topology diagram showing how many hosts are used and the
role each of them takes.

It also documents the pytest markers (vm, sa, tester) and the
convention of naming security advisory regression tests after their
GHSA id.

Tests for a specific profile need more context than the core ones, so
they are documented separately, in doc/functional-<profile>.rst.

Assisted-by: opencode:claude-opus-5
---
 Makefile.am                |   3 +
 doc/functional-avrcp.rst   |  64 +++++++
 doc/functional-obex.rst    |  90 ++++++++++
 doc/functional-testing.rst | 338 +++++++++++++++++++++++++++++++++++++
 4 files changed, 495 insertions(+)
 create mode 100644 doc/functional-avrcp.rst
 create mode 100644 doc/functional-obex.rst
 create mode 100644 doc/functional-testing.rst

diff --git a/Makefile.am b/Makefile.am
index 7895c3b2ab73..afa213cf0b8c 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -497,6 +497,9 @@ EXTRA_DIST += doc/assigned-numbers.rst doc/supported-features.txt \
 				doc/test-coverage.txt \
 				doc/test-runner.rst \
 				doc/test-functional.rst \
+				doc/functional-testing.rst \
+				doc/functional-avrcp.rst \
+				doc/functional-obex.rst \
 				doc/settings-storage.txt
 
 EXTRA_DIST += doc/hci-protocol.rst doc/mgmt-protocol.rst \
diff --git a/doc/functional-avrcp.rst b/doc/functional-avrcp.rst
new file mode 100644
index 000000000000..f77e2ed1d4ce
--- /dev/null
+++ b/doc/functional-avrcp.rst
@@ -0,0 +1,64 @@
+================
+functional-avrcp
+================
+
+DESCRIPTION
+===========
+
+AVRCP functional tests, `test/functional/test_avrcp.py`. See
+**functional-testing(7)** for the conventions used here, and
+**test-functional(1)** for how to run the suite.
+
+SETUP
+=====
+
+Two hosts, connected over BR/EDR:
+
+.. code-block::
+
+	+------------------------+                 +------------------------+
+	| host0                  |     BR/EDR      | host1                  |
+	| victim                 | --------------> | attacker               |
+	| bluetoothd             |                 | bluetoothd -P avrcp    |
+	| AVRCP Controller       |  AVCTP PSM 0x17 | malicious AVRCP Target |
+	|                        | <============== | (org.bluez.Profile1)   |
+	+------------------------+                 +------------------------+
+
+	--> connection is initiated by      ==> malicious response is sent by
+
+TEST CASES
+==========
+
+test_avrcp_GHSA_m2vx_pw5f_rc8v
+------------------------------
+
+:Setup: Two hosts paired over BR/EDR. host1 runs `bluetoothd` with the
+	`avrcp` plugin and registers a malicious AVRCP Target through
+	``org.bluez.ProfileManager1``: a server role profile on the AVCTP
+	PSM (0x17) with its own SDP record, which receives the accepted
+	AVCTP file descriptor through ``Profile1.NewConnection``.
+
+:Steps:
+	1. host0 connects the AVRCP Controller UUID
+	   (``0000110c-0000-1000-8000-00805f9b34fb``) with
+	   ``org.bluez.Device1.ConnectProfile``.
+	2. The AVRCP Target answers ``GetCapabilities``, and answers
+	   ``ListPlayerAttributes`` with an attribute count of 255.
+	3. host0 calls ``org.bluez.Device1.Disconnect``.
+
+:Expected:
+	1. ``ConnectProfile`` replies.
+	2. The target reports that it answered
+	   ``ListPlayerAttributes``.
+	3. `bluetoothd` on host0 has not crashed and still answers D-Bus,
+	   so ``Disconnect`` replies.
+
+:Notes: Regression test for NN-2026-0145. The response is parsed by
+	``avrcp_list_player_attributes_rsp()``
+	(`profiles/audio/avrcp.c`), which collects the attributes into a
+	buffer of ``AVRCP_ATTRIBUTE_LAST`` bytes without bounding the
+	count, and then passes that count to
+	``avrcp_get_current_player_value()``, which copies it into a
+	similarly sized buffer. With 255 valid attributes both overflow.
+
+	Marked ``sa``.
diff --git a/doc/functional-obex.rst b/doc/functional-obex.rst
new file mode 100644
index 000000000000..6cca30978b42
--- /dev/null
+++ b/doc/functional-obex.rst
@@ -0,0 +1,90 @@
+===============
+functional-obex
+===============
+
+DESCRIPTION
+===========
+
+OBEX functional tests, `test/functional/test_obex.py`. See
+**functional-testing(7)** for the conventions used here, and
+**test-functional(1)** for how to run the suite.
+
+SETUP
+=====
+
+Two hosts, connected over BR/EDR:
+
+.. code-block::
+
+	+------------------------+                 +------------------------+
+	| host0                  |     BR/EDR      | host1                  |
+	| FTP client             | --------------> | FTP server             |
+	| bluetoothd, obexd      |                 | bluetoothd, obexd      |
+	| org.bluez.obex client, |    OBEX FTP     | OBEX agent,            |
+	| or obexctl             | <============== | files in /run/obex     |
+	+------------------------+                 +------------------------+
+
+	--> connection is initiated by      ==> files are transferred towards
+
+Two hosts paired over BR/EDR, both running `obexd`:
+
+host0
+	Acts as File Transfer client, through the **org.bluez.obex** API
+	or through **obexctl(1)**.
+
+host1
+	Acts as server, with an OBEX agent registered, and serves the
+	files in ``/run/obex``.
+
+The session is created with
+``org.bluez.obex.Client1.CreateSession`` using the ``ftp`` target,
+which the agent of host1 has to authorize.
+
+TEST CASES
+==========
+
+test_obex_ftp_list
+------------------
+
+:Setup: As above.
+
+:Steps:
+	1. Create the FTP session from host0 and authorize it on host1.
+	2. Write a file named ``test`` with 4 bytes of content on host1.
+	3. host0 calls
+	   ``org.bluez.obex.FileTransfer1.ListFolder``.
+
+:Expected:
+	1. host1 receives ``org.bluez.Agent1.AuthorizeService`` for the
+	   FTP UUID, and ``CreateSession`` replies.
+	2. ``ListFolder`` returns a single entry, with ``Type`` ``file``,
+	   ``Name`` ``test`` and ``Size`` 4.
+
+test_obex_ftp_get
+-----------------
+
+:Setup: As above.
+
+:Steps:
+	1. Write a file named ``test`` with the content ``1234`` on host1.
+	2. host0 calls ``org.bluez.obex.FileTransfer1.GetFile``.
+
+:Expected:
+	1. The transfer object reaches ``Status`` ``complete``, tracked
+	   through ``PropertiesChanged`` on the
+	   ``org.bluez.obex.Transfer1`` object.
+	2. The received file has the content ``1234``.
+
+test_obexctl_list
+-----------------
+
+:Setup: As above, with the client driven through **obexctl(1)**.
+
+:Steps:
+	1. host0: ``connect <host1 bdaddr> <FTP UUID>``.
+	2. host1 authorizes the service.
+	3. host0: ``select <session>`` then ``ls``.
+
+:Expected:
+	1. ``Connection successful``.
+	2. ``ls`` prints ``Type: file``, ``Name: test`` and ``Size: 4``.
diff --git a/doc/functional-testing.rst b/doc/functional-testing.rst
new file mode 100644
index 000000000000..29436d4454c0
--- /dev/null
+++ b/doc/functional-testing.rst
@@ -0,0 +1,338 @@
+==================
+functional-testing
+==================
+
+DESCRIPTION
+===========
+
+This document describes the test cases run by **test-functional(1)**,
+i.e. the test modules under `test/functional`. For how to build,
+configure and run the suite, see **test-functional(1)**.
+
+This document covers the core test cases. Tests for a specific profile
+are documented separately:
+
+- **functional-avrcp(7)**: `test/functional/test_avrcp.py`
+- **functional-obex(7)**: `test/functional/test_obex.py`
+
+Each test case is described as:
+
+:Setup: The hosts, the plugins running on them and their
+	configuration, with a topology diagram showing how many hosts are
+	used and the role each of them takes.
+:Steps: The actions the test performs, in order.
+:Expected: What has to be observed for the test to pass.
+:Notes: Caveats, and why the test is written the way it is.
+
+In the topology diagrams, ``-->`` points at the host that accepts the
+connection, and ``==>`` at the host the data flows towards.
+
+MARKERS
+=======
+
+Markers are defined in `test/pytest.ini` and can be selected with
+``-m``:
+
+``vm``
+	Test requires a VM image (``--kernel``). Skipped if none is
+	available.
+
+``sa``
+	Security advisory regression test. Added automatically to tests
+	whose name matches ``_GHSA_xxxx_xxxx_xxxx``.
+
+``tester``
+	Kernel testers. These exercise the kernel rather than BlueZ
+	userspace and are excluded from ``make check-functional``.
+
+test_agent.py
+=============
+
+Pairing over D-Bus, driven directly through the **org.bluez** API using
+the `Agent` plugin on both hosts.
+
+test_agent_pair_bredr[accept]
+-----------------------------
+
+:Setup: Two hosts, each running `bluetoothd` with an agent registered
+	on D-Bus.
+
+	.. code-block::
+
+		+--------------------+                 +--------------------+
+		| host0              |      BR/EDR     | host1              |
+		| bluetoothd, agent  | --------------> | bluetoothd, agent  |
+		| discovers, pairs   |                 | pairable,          |
+		|                    |                 | discoverable       |
+		+--------------------+                 +--------------------+
+
+:Steps:
+	1. host0 calls ``org.bluez.Adapter1.StartDiscovery``.
+	2. host1 sets ``Pairable`` and ``Discoverable`` to true.
+	3. Wait until host0 has a device object for host1.
+	4. host0 calls ``org.bluez.Device1.Pair``.
+	5. Both agents reply to ``org.bluez.Agent1.RequestConfirmation``.
+
+:Expected:
+	1. ``StartDiscovery`` replies.
+	2. host0 discovers host1.
+	3. Both agents receive ``RequestConfirmation`` with the *same*
+	   passkey.
+	4. ``org.bluez.Device1.Pair`` replies successfully.
+
+:Notes: This test is also used as the ``paired_hosts_bredr`` fixture
+	(see `test/functional/conftest.py`), which other tests reuse to
+	get two already paired hosts.
+
+test_agent_pair_bredr[reject]
+-----------------------------
+
+:Setup: As above.
+
+:Steps:
+	1. Pair as above, up to the confirmation.
+	2. host0 accepts the confirmation, host1 replies with an error.
+
+:Expected: ``org.bluez.Device1.Pair`` returns an error.
+
+test_bluetoothctl.py
+====================
+
+End to end tests of the **bluetoothctl(1)** client, driven through its
+interactive prompt or its command line.
+
+test_bluetoothctl_pair_bredr
+----------------------------
+
+:Setup: Two hosts, each running `bluetoothctl`.
+
+	.. code-block::
+
+		+--------------------+                 +--------------------+
+		| host0              |      BR/EDR     | host1              |
+		| bluetoothctl       | --------------> | bluetoothctl       |
+		| scan on, pair      |                 | pairable on,       |
+		|                    |                 | discoverable on    |
+		+--------------------+                 +--------------------+
+
+:Steps:
+	1. host0: ``scan on``.
+	2. host1: ``pairable on`` and ``discoverable on``.
+	3. host0: ``pair <host1 bdaddr>`` once host1 is discovered.
+	4. Both sides answer ``yes`` to the passkey confirmation.
+
+:Expected:
+	1. ``Controller <host0> Discovering: yes``.
+	2. ``Changing pairable on succeeded`` and
+	   ``Controller <host1> Discoverable: yes``.
+	3. host0 prints ``Device <host1>``, then both sides prompt to
+	   confirm the *same* passkey.
+	4. host0 prints ``Pairing successful``.
+
+test_bluetoothctl_pair_le
+-------------------------
+
+:Setup: Two hosts, each running `bluetoothd` with
+	``ControllerMode = le`` and `bluetoothctl`.
+
+	.. code-block::
+
+		+--------------------+                 +--------------------+
+		| host0              |        LE       | host1              |
+		| bluetoothctl       | --------------> | bluetoothctl       |
+		| scan on, pair      |                 | advertise on       |
+		+--------------------+                 +--------------------+
+
+:Steps:
+	1. host0: ``scan on``.
+	2. host1: ``advertise on``.
+	3. host0: ``pair <host1 bdaddr>`` once host1 is discovered.
+	4. Answer the passkey confirmation, or enter the passkey on host1
+	   if legacy pairing was used.
+
+:Expected:
+	1. ``Controller <host0> Discovering: yes``.
+	2. ``Advertising object registered``.
+	3. host0 prints ``Device <host1>``.
+	4. host0 prints ``Pairing successful``.
+
+:Notes: If the controller is power cycled before `bluetoothd` starts,
+	which is what the tester does, enabling Secure Connections Host
+	Support may fail and pairing falls back to legacy passkey entry.
+	The test accepts both, but warns when the legacy path is taken.
+
+test_bluetoothctl_show
+----------------------
+
+:Setup: One host running `bluetoothd`, reused across the tests of this
+	module.
+
+	.. code-block::
+
+		+--------------------------+
+		| host0                    |
+		| bluetoothd, bluetoothctl |
+		+--------------------------+
+
+:Steps: Run ``bluetoothctl show``.
+
+:Expected: Exit status 0, and the output reports
+	``Controller <bdaddr>``, ``Powered:`` and ``Discoverable: no``.
+
+test_bluetoothctl_list
+----------------------
+
+:Setup: As above.
+
+:Steps: Run ``bluetoothctl list``.
+
+:Expected: Exit status 0, and the controller is listed and marked
+	``[default]``.
+
+test_bluetoothctl_script_show
+-----------------------------
+
+:Setup: As above.
+
+:Steps: Run ``show`` through ``bluetoothctl --init-script``.
+
+:Expected: Same as ``test_bluetoothctl_show``.
+
+:Notes: Covers the script input path rather than the command line.
+
+test_bluetoothctl_script_list
+-----------------------------
+
+:Setup: As above.
+
+:Steps: Run ``list`` through ``bluetoothctl --init-script``.
+
+:Expected: Same as ``test_bluetoothctl_list``.
+
+test_btmgmt.py
+==============
+
+test_btmgmt_info
+----------------
+
+:Setup: One host with a controller and no `bluetoothd` running.
+
+	.. code-block::
+
+		+--------------------------+
+		| host0                    |
+		| btmgmt, no bluetoothd    |
+		+--------------------------+
+
+:Steps: Run ``btmgmt --index 0 info``.
+
+:Expected: Exit status 0, and the output contains
+	``addr <bdaddr>`` for the controller of the host.
+
+:Notes: Skipped if `btmgmt` is not built. Checks the mgmt interface is
+	usable without a daemon.
+
+test_adv_monitor.py
+===================
+
+test_adv_monitor_GHSA_hhgc_hfgf_8m4x
+------------------------------------
+
+:Setup: One host running `bluetoothd` with ``Experimental = true``.
+
+	.. code-block::
+
+		+---------------------------------+
+		| host0                           |
+		| bluetoothd (Experimental)       |
+		| advertisement monitor app       |
+		+---------------------------------+
+
+:Steps:
+	1. Register an advertisement monitor application exposing one
+	   monitor with 8 patterns of 31 bytes each.
+	2. Call
+	   ``org.bluez.AdvertisementMonitorManager1.RegisterMonitor``.
+
+:Expected: ``RegisterMonitor`` completes, with either a reply or an
+	error, and `bluetoothd` does not crash.
+
+:Notes: Regression test for NN-2026-0142, a heap overflow caused by
+	``uint8`` length truncation when the mgmt command carrying the
+	patterns exceeds 255 bytes (`src/adv_monitor.c`). The overflow
+	happens during the ``ADD_ADV_PATTERNS_MONITOR`` mgmt call, before
+	the monitor is activated. Marked ``sa``.
+
+test_kernel_testers.py
+======================
+
+Kernel side tests: they run the BlueZ testers inside the VM against the
+kernel under test. Excluded from ``make check-functional``; run them
+with ``test/test-functional -m tester``.
+
+test_kernel_tester[<tester>]
+----------------------------
+
+:Setup: One host, without a controller, reused across the parameters.
+
+	.. code-block::
+
+		+----------------------------------+
+		| host0                            |
+		| kernel under test, no controller |
+		| tester creates its own hciX      |
+		+----------------------------------+
+
+:Steps:
+	1. Run the tester in the VM.
+	2. Parse its test summary.
+
+:Expected: No test is reported as ``Failed`` or ``Timed out``, except
+	the ones listed in the ``XFAIL`` table of the module.
+
+:Notes: The testers covered are `mgmt-tester`, `smp-tester`,
+	`l2cap-tester`, `rfcomm-tester`, `sco-tester`, `iso-tester`,
+	`mesh-tester`, `ioctl-tester`, `bnep-tester`, `userchan-tester`
+	and `6lowpan-tester`. A known failing case that unexpectedly
+	passes emits an ``XPASS`` warning, so the entry can be dropped.
+	Marked ``tester``.
+
+test_kernel_selftest
+--------------------
+
+:Setup: As above.
+
+:Steps: Run `check-selftest`, which reads the kernel Bluetooth selftest
+	results.
+
+:Expected: Exit status 0, and the output contains ``PASS`` and no
+	``FAIL``.
+
+:Notes: Skipped if ``CONFIG_BT_SELFTEST`` is not enabled, which is the
+	case when the output is empty.
+
+test_tests.py
+=============
+
+test_formatting
+---------------
+
+:Setup: None, the test does not use a VM.
+
+:Steps: Run `Black <https://black.readthedocs.io/en/stable/>`__ in
+	check mode over `test/functional`.
+
+:Expected: The sources are formatted. Formatting problems are reported
+	as a warning, not as a failure.
+
+:Notes: Skipped if `black` is not installed.
+
+ADDING TEST CASES
+=================
+
+When adding a test module or case, document it here as well, or in the
+matching profile document. For regression tests of security advisories,
+name the test ``test_<area>_GHSA_xxxx_xxxx_xxxx`` so it is
+automatically marked ``sa``, and describe the issue it covers.
+
+See **test-functional(1)** for how tests are written.
-- 
2.55.0

