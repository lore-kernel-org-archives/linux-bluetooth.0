Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="BqeEmrQu"
Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D48C4
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Nov 2023 14:38:03 -0800 (PST)
Received: from github.com (hubbernetes-node-de53a38.ac4-iad.github.net [10.52.131.21])
	by smtp.github.com (Postfix) with ESMTPA id 339641E0D9B
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Nov 2023 14:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1701297483;
	bh=DD7kE/hDMyJkLWuhKOaW9YTLnJLYe7LlMHxOfQ5c2Tg=;
	h=Date:From:To:Subject:From;
	b=BqeEmrQuNIoFlYcQxlXHCNBsPQ+Zu8V3SMxDBK3sz7QeOcwkE2UaQRkqLcoq26/88
	 JJMMOTVnbRPKF6qLWuE9RXYNDDu5Nc4oG70h0JnyZVd7bDWn53AqtUl4x9l3oeE7gC
	 xZ+IH205pnEn/sGbUPUWoM8j3RrlhGZ+uIN9RiA4=
Date: Wed, 29 Nov 2023 14:38:03 -0800
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/bd5342-4db4d5@github.com>
Subject: [bluez/bluez] 3a2d3b: test-micp: Fix endianness error
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
  Commit: 3a2d3b31a3b5a7eeb45952ce880ca58c93b985bb
      https://github.com/bluez/bluez/commit/3a2d3b31a3b5a7eeb45952ce880ca58c93b985bb
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-11-29 (Wed, 29 Nov 2023)

  Changed paths:
    M unit/test-micp.c

  Log Message:
  -----------
  test-micp: Fix endianness error

On big endian the followin error can be observed:

MICP/CL/CGGIT/SER/BV-01-C - init
MICP/CL/CGGIT/SER/BV-01-C - setup
MICP/CL/CGGIT/SER/BV-01-C - setup complete
MICP/CL/CGGIT/SER/BV-01-C - run
micp_write_value handle: 3
**
ERROR:src/shared/tester.c:954:test_io_recv: assertion failed:
(memcmp(buf, iov->iov_base, len) == 0)
Bail out! ERROR:src/shared/tester.c:954:test_io_recv: assertion failed:
(memcmp(buf, iov->iov_base, len) == 0)
Aborted


  Commit: 4db4d5fa1c4fefcf3ec7f161a4c7164df0195ed7
      https://github.com/bluez/bluez/commit/4db4d5fa1c4fefcf3ec7f161a4c7164df0195ed7
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-11-29 (Wed, 29 Nov 2023)

  Changed paths:
    M src/shared/vcp.c

  Log Message:
  -----------
  shared/vcp: Fix endianness errors

On big endian the followin error can be observed:
VOCS/SR/SGGIT/CHA/BV-02-C - init
VOCS/SR/SGGIT/CHA/BV-02-C - setup
VOCS/SR/SGGIT/CHA/BV-02-C - setup complete
VOCS/SR/SGGIT/CHA/BV-02-C - run
**
ERROR:src/shared/tester.c:954:test_io_recv: assertion failed:
(memcmp(buf, iov->iov_base, len) == 0)
Bail out! ERROR:src/shared/tester.c:954:test_io_recv: assertion failed:
(memcmp(buf, iov->iov_base, len) == 0)
Aborted


Compare: https://github.com/bluez/bluez/compare/bd5342fdf46a...4db4d5fa1c4f
