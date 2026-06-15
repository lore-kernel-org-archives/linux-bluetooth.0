Received: from out-6.smtp.github.com (out-6.smtp.github.com [192.30.252.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F763B6C16
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2026 21:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781559983; cv=none; b=LCQXNyX4bEjTYpvaut56mwhcYIxQ/5S+GEZXElhiH5gg48+osoo/jPqEuJoENiCciw9l0dU78nZz/aH299uGkJI+ETe/1YBOUpbVobQ5re6b+4czYR3G6OzcTXbh+uehOauRfDSjO6/DDSgpdVDFDIVDUTqnjjACIfDKZeXkSlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781559983; c=relaxed/simple;
	bh=1rHU4l8VD9kR8m4aeK8s5J63MKHNaZoKEVc9Y7myn/M=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=YP3A1P0+0SKUmf0f2p7EhDrdcmFXa2DqFXXDDFR0a0keZZRt2xTqm0d66ufLwQYYINf/r3U7vhHLQCDyOWckdnr8zuN9zPkf1MgdirpMf3pG1hcudP54YlUX7G+qJWNnThGlufl0QjV4BqQ1qF7JKjTN3YLkyNUDp+EIEMQ8eNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Ha6XcQyN; arc=none smtp.client-ip=192.30.252.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Ha6XcQyN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1781559981;
	bh=KeiV3PvPFLpBRt61ESwMrxih65bRuKV16QOpv7b+K7w=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Ha6XcQyNiqw6XTK7yJ0vKp1LxZ5c6WYeZC+0zWpyzL8cTk9AOT1c1twbSBht/12u4
	 lvMLLgDpUoHfoFGc1fSAp4IS3h7QTWHkP2uP4r5s9xuAJAs+nm+AbVpysepfGafw+0
	 EG8iL+CHoQ6mCAnw91Y46AHXlSU0rm7b009Vj9GI=
Received: from github.com (hubbernetes-node-4f428b7.va3-iad.github.net [10.51.93.36])
	by smtp.github.com (Postfix) with ESMTPA id EBA6C78128E
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2026 14:46:20 -0700 (PDT)
Date: Mon, 15 Jun 2026 14:46:20 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/action-ci/push/refs/heads/main/979e81-058d4c@github.com>
Subject: [bluez/action-ci] 92ec40: ci: add CheckKernelLLVM
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

  Branch: refs/heads/main
  Home:   https://github.com/bluez/action-ci
  Commit: 92ec4064e91267f1d90ae7d9a391100c04ad09d2
      https://github.com/bluez/action-ci/commit/92ec4064e91267f1d90ae7d9a391100c04ad09d2
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-06-15 (Mon, 15 Jun 2026)

  Changed paths:
    M ci.py
    M ci/__init__.py
    M ci/checkallwarning.py
    A ci/checkkernelllvm.py
    M ci/generickernelbuild.py
    M entrypoint.sh

  Log Message:
  -----------
  ci: add CheckKernelLLVM

Add task to build kernel with LLVM + checking context analysis warnings:
https://docs.kernel.org/dev-tools/context-analysis.html

This feature does static compile time checking of the __must_hold,
__guarded_by etc annotations now used by kernel.


  Commit: a562057313abc7aef89ec87faaab11caa5aaf94e
      https://github.com/bluez/action-ci/commit/a562057313abc7aef89ec87faaab11caa5aaf94e
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-06-15 (Mon, 15 Jun 2026)

  Changed paths:
    M entrypoint.sh
    M libs/context.py

  Log Message:
  -----------
  entrypoint: add localci command for local CI dry run

Add localci command so that the docker CI can be tested locally without
secrets.

Example:

git clone --depth 1 https://github.com/bluez/bluetooth-next work/src
docker run --volume $PWD/work:/work/base:O $IMG localci kernel bluez/bluetooth-next 103


  Commit: 058d4cc766443e37c4c1150f44d474b4e98dc61e
      https://github.com/bluez/action-ci/commit/058d4cc766443e37c4c1150f44d474b4e98dc61e
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-06-15 (Mon, 15 Jun 2026)

  Changed paths:
    M ci.py
    M ci/buildbluez.py
    M ci/buildell.py
    M ci/buildkernel.py
    M ci/buildkernel32.py
    M ci/checkallwarning.py
    M ci/checksparse.py
    M ci/checkvalgrind.py
    M ci/genericbuild.py
    M ci/generickernelbuild.py
    M ci/incrementalbuild.py
    M ci/makedistcheck.py
    M ci/makeextell.py
    M ci/scanbuild.py
    M entrypoint.sh

  Log Message:
  -----------
  ci: add --jobs setting to set make -j

Add option for setting make -j option value.


Compare: https://github.com/bluez/action-ci/compare/979e8164c387...058d4cc76644

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/action-ci/settings/notifications
