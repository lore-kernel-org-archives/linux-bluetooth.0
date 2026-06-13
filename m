Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B68D282F1D
	for <linux-bluetooth@vger.kernel.org>; Sat, 13 Jun 2026 16:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781367249; cv=none; b=Ucd0cYPYHay949H3/m6dx1XeTnpWys2wI6mH5pGsqze/INFG7FRd9oZ75T8fF2YmAoj2WehZVh8Y29jUEKJrdeKQwr031conCtJi6JZFxSokyhpo6zcLhQJWM6kCzZ35UZwkV/7FqYQnUiNRjHYJefwMZn1df44QVj31AQZ3AFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781367249; c=relaxed/simple;
	bh=WCePAin6Za2OIRfZoZPjM7kO315f80NfEjnRgiBsWmI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=tigkj4HBlR/qrCFNo0w6WiTzfM4CdsAlSazkYbv2BnaMIgmyrNnp/4AgB1HE4Fol6zYYipxzB45YUHkC4fFcpeuHasEhZYACBdcf+EVmI1wOzXdmXgQeZJApUg3xIMOlK9Z3EDcQIFBPbdPPRoP+OWyfcX1VClJ+VYGdkgFUD4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=SARmNGb8; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="SARmNGb8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1781367247;
	bh=Cserv+nriA9xfec7HOIS0BUDUDQ52wh0ZG/yWxndPno=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=SARmNGb8jFfZvfeLv/D7lVKqN6hPCt+apYitCIQIwhpdTSLYjTygVDorRdMwIS1hb
	 exlcC5Q+xaIqheNd6qZQPDeUhYQvxDxdwi5LurwDK777I2MzmETF5jzpVnjTxCD9ou
	 qzjg7qp0Sgd3SSyrx+H/XKiZRpPLSorHZqxeC4RQ=
Received: from github.com (hubbernetes-node-31668fe.va3-iad.github.net [10.48.13.84])
	by smtp.github.com (Postfix) with ESMTPA id 76169500C5B
	for <linux-bluetooth@vger.kernel.org>; Sat, 13 Jun 2026 09:14:07 -0700 (PDT)
Date: Sat, 13 Jun 2026 09:14:07 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1111076/000000-6b0711@github.com>
Subject: [bluez/bluez] 277b5b: doc: add functional/integration testing
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

  Branch: refs/heads/1111076
  Home:   https://github.com/bluez/bluez
  Commit: 277b5b08b658b1788cc4e1e365e49cdf7b0adc54
      https://github.com/bluez/bluez/commit/277b5b08b658b1788cc4e1e365e49cdf7b0adc54
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-06-13 (Sat, 13 Jun 2026)

  Changed paths:
    A doc/test-functional.rst

  Log Message:
  -----------
  doc: add functional/integration testing documentation

Add documentation for functional/integration test suite.


  Commit: a5f3028cbfbc8211779bf15ec8badd1d1d642bf1
      https://github.com/bluez/bluez/commit/a5f3028cbfbc8211779bf15ec8badd1d1d642bf1
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-06-13 (Sat, 13 Jun 2026)

  Changed paths:
    A test/functional/__init__.py
    A test/functional/conftest.py
    A test/functional/requirements.txt
    A test/functional/test_bluetoothctl_vm.py
    A test/functional/test_btmgmt_vm.py
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


  Commit: 5b980c4a877fdd3b6460dfd8a517e8c75b4e2bf2
      https://github.com/bluez/bluez/commit/5b980c4a877fdd3b6460dfd8a517e8c75b4e2bf2
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-06-13 (Sat, 13 Jun 2026)

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


  Commit: e27780d7bbf553fc34810f8bf5e7e8bbdbbcfc8e
      https://github.com/bluez/bluez/commit/e27780d7bbf553fc34810f8bf5e7e8bbdbbcfc8e
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-06-13 (Sat, 13 Jun 2026)

  Changed paths:
    A test/functional/test_tests.py

  Log Message:
  -----------
  test: functional: impose Python code formatting

Check Python code formatting of the functional test suite.


  Commit: b5e1ffdb14fa3a5bf11e57e41e1f67cf6eea1744
      https://github.com/bluez/bluez/commit/b5e1ffdb14fa3a5bf11e57e41e1f67cf6eea1744
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-06-13 (Sat, 13 Jun 2026)

  Changed paths:
    A test/functional/test_agent.py

  Log Message:
  -----------
  test: functional: add some Agent1 interface tests

Add test

test/functional/test_agent.py::test_agent_pair_bredr


  Commit: 6b0711ccbeee668ada328d5e4eff34f086222402
      https://github.com/bluez/bluez/commit/6b0711ccbeee668ada328d5e4eff34f086222402
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-06-13 (Sat, 13 Jun 2026)

  Changed paths:
    A test/functional/test_obex.py

  Log Message:
  -----------
  test: functional: add basic obex file transfer tests

Add tests for Obex DBus API and obexctl

test/functional/test_obex.py::test_obex_ftp_get
test/functional/test_obex.py::test_obex_ftp_list
test/functional/test_obex.py::test_obexctl_list


Compare: https://github.com/bluez/bluez/compare/277b5b08b658%5E...6b0711ccbeee

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
