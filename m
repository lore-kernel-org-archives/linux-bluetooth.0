Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F259126C02
	for <linux-bluetooth@vger.kernel.org>; Sun,  6 Sep 2026 17:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788716454; cv=none; b=TqSN6S8PHfepJpM9tlQ21c5GSoxJbsVLKnkT4T7dp4Ya6cOyYVCjfe8VALaMv2HZ5EmPVMdeg+Ibe0147GuU5n6rM0nfsKUHAX60UR2Uf4YRAuFvUsG4sueXdZWsnTICY/CvjSQXsFnolHEBM3mNYFZC+N7dL/L2J+TNHT0LZHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788716454; c=relaxed/simple;
	bh=NwxRmdJpzLVY7MQjvb6MFE+XkVKVnpDBlb4zy75bDhM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=J57/u90k55q4f94+SdJ6uihUBJvmTupmppK4iz7ffQO7ZMsY1dcIkta9QkmFymHGRVLy4KHwGFMxyHyJe+bJW/neE4QEH9mVMuUo/Qj73w5yXjENyMQ7zctwY3zCv4XRYQpeIIHUyxrs2O6GsqI1yMDOxmrR5aADIs2SWyqkOEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=IS/aMW6Y; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="IS/aMW6Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1788716451;
	bh=FfPYY/UegYQFoBGwsixqNovWmeD5IPIEY6WjPBr9510=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=IS/aMW6YDAEn4safAzDNQYSLAh7HKybQ33Phr0O0zFjtDRA1Mq7L/vj8oedL1sOlb
	 FFG1pj5T8FN1G4l6nby9Vf9WZCwca7e0aRXHhVRSOeAxFa6OmJ4+bwAUwNWV1PPMbW
	 Pg40dhusttvV7xDao95I80mdnWMKSTvKLy65ubaU=
Received: from github.com (hubbernetes-node-25c220c.ash1-iad.github.net [10.56.180.42])
	by smtp.github.com (Postfix) with ESMTPA id 8E2A21811B1
	for <linux-bluetooth@vger.kernel.org>; Sun,  6 Sep 2026 10:40:51 -0700 (PDT)
Date: Sun, 06 Sep 2026 10:40:51 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1159124/000000-bb3619@github.com>
Subject: [bluez/bluez] 080b15: doc: add functional/integration testing
 documentation
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

  Branch: refs/heads/1159124
  Home:   https://github.com/bluez/bluez
  Commit: 080b158a91ec7fe4a151028045554f0c3483f956
      https://github.com/bluez/bluez/commit/080b158a91ec7fe4a151028045554f0c3483f956
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-09-06 (Sun, 06 Sep 2026)

  Changed paths:
    A doc/test-functional.rst

  Log Message:
  -----------
  doc: add functional/integration testing documentation

Add documentation for functional/integration test suite.


  Commit: 5a38bde90745101e446620ecbf9d77235d0a50eb
      https://github.com/bluez/bluez/commit/5a38bde90745101e446620ecbf9d77235d0a50eb
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-09-06 (Sun, 06 Sep 2026)

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


  Commit: 41486cf21e7f0b8237e4217d197be18eb34e6c41
      https://github.com/bluez/bluez/commit/41486cf21e7f0b8237e4217d197be18eb34e6c41
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-09-06 (Sun, 06 Sep 2026)

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


  Commit: 792f6821e352c6225a8fde458bcba7025b8e070d
      https://github.com/bluez/bluez/commit/792f6821e352c6225a8fde458bcba7025b8e070d
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-09-06 (Sun, 06 Sep 2026)

  Changed paths:
    M test/functional/requirements.txt
    A test/functional/test_tests.py

  Log Message:
  -----------
  test: functional: impose Python code formatting

Check Python code formatting of the functional test suite.


  Commit: 9fe6efaa31a1a4d6dc2d5e101d32a42437461bab
      https://github.com/bluez/bluez/commit/9fe6efaa31a1a4d6dc2d5e101d32a42437461bab
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-09-06 (Sun, 06 Sep 2026)

  Changed paths:
    A test/functional/test_agent.py

  Log Message:
  -----------
  test: functional: add some Agent1 interface tests

Add test

test/functional/test_agent.py::test_agent_pair_bredr


  Commit: 9b003551aadf51d4a17c1df56e39226d75e58009
      https://github.com/bluez/bluez/commit/9b003551aadf51d4a17c1df56e39226d75e58009
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-09-06 (Sun, 06 Sep 2026)

  Changed paths:
    A test/functional/test_obex.py

  Log Message:
  -----------
  test: functional: add basic obex file transfer tests

Add tests for Obex DBus API and obexctl

test/functional/test_obex.py::test_obex_ftp_get
test/functional/test_obex.py::test_obex_ftp_list
test/functional/test_obex.py::test_obexctl_list


  Commit: a6e4a90cfc9af51c28447641ca324d0d375402e1
      https://github.com/bluez/bluez/commit/a6e4a90cfc9af51c28447641ca324d0d375402e1
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-09-06 (Sun, 06 Sep 2026)

  Changed paths:
    A test/functional/test_kernel_testers.py
    M test/pytest.ini

  Log Message:
  -----------
  test: functional: add tests running the various kernel testers

It's more convenient to have simple local test runner for these.


  Commit: 44d984fbcbb2b9318dcd3ebc550d9a7f1224f6e4
      https://github.com/bluez/bluez/commit/44d984fbcbb2b9318dcd3ebc550d9a7f1224f6e4
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-09-06 (Sun, 06 Sep 2026)

  Changed paths:
    M test/functional/conftest.py
    A test/functional/test_adv_monitor.py
    M test/pytest.ini

  Log Message:
  -----------
  test: functional: add test for adv_monitor crash

Add test checking adv_monitor overflow crash.
From PoC provided by Alexandro Calo' (Nozomi Networks Labs)


  Commit: bb3619f0e8cd67d61b362134b38856d74eb210b9
      https://github.com/bluez/bluez/commit/bb3619f0e8cd67d61b362134b38856d74eb210b9
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-09-06 (Sun, 06 Sep 2026)

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


Compare: https://github.com/bluez/bluez/compare/080b158a91ec%5E...bb3619f0e8cd

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
