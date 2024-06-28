Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7892B1C8FA0
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jun 2024 15:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719587674; cv=none; b=quuWIfzHCUxkearBvI+QayFPv7VO0HtqjH0g0Wh9yE9Q1ewZ824B15zRXETg+or+RSoWvwN2pn5ostW5+q5pqaRMupDafzNimj+rDwEH5yBz3rwj1eTaDXrYlO3Neh0gbvB+VnOhHjzIupCTBvWvw9yEif50cGfFklHfBqH2N2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719587674; c=relaxed/simple;
	bh=+A1ntLFF7RI6DZfSwbpwjH9tP/0nwDBxl1uQBErnHOQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ak/5gPhk+O++DfVk+/UIWYCzrx0eAuBuROYVaEwjEcPSxU9x8mBxKSD/jHp+xAgfVk5+S8mi/zawMsYr/wYeKUUiPNQXNEX95/EkhqO647tqR5yYu5nfDqvBbwhphEulemP0upIyidwe+eizqE6v/8QWLRVqgIuVNpZOrD314r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=QxNqeNwh; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="QxNqeNwh"
Received: from github.com (hubbernetes-node-0e5c959.ac4-iad.github.net [10.52.139.30])
	by smtp.github.com (Postfix) with ESMTPA id 7DE745E05ED
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jun 2024 08:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1719587670;
	bh=8q3FLkxOnoufcJJIwJWpXC1GVySz/9SCGty42+bH4D0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=QxNqeNwh6qXQY/lm3cwDRrrvYexdvo/l/rkYuHo8yUUIcAgMyW9cQgfwRcU6fQ7kw
	 0vrWeoa6u3txTHRzhygmGkq5ZUOPuJ0hT22BWJbZqs9nW/+jh0sA8mlmYWEKY2z8fH
	 HlZIKUD4aYPkQ39TFN7u2+fEq8rdnZSUdSMGLvYk=
Date: Fri, 28 Jun 2024 08:14:30 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/e3616b-0ddcfa@github.com>
Subject: [bluez/bluez] 920c45: bass: add NULL check to bass_bcast_src_free()
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
  Commit: 920c4576907dfe292c733be4c413a49bd8fffe66
      https://github.com/bluez/bluez/commit/920c4576907dfe292c733be4c413a49bd8fffe66
  Author: Roman Smirnov <r.smirnov@omp.ru>
  Date:   2024-06-28 (Fri, 28 Jun 2024)

  Changed paths:
    M src/shared/bass.c

  Log Message:
  -----------
  bass: add NULL check to bass_bcast_src_free()

Make bass_bcast_src_free() safe for passing NULL pointers.


  Commit: ee12a631caef13b92603363fc7155f5794920ad0
      https://github.com/bluez/bluez/commit/ee12a631caef13b92603363fc7155f5794920ad0
  Author: Roman Smirnov <r.smirnov@omp.ru>
  Date:   2024-06-28 (Fri, 28 Jun 2024)

  Changed paths:
    M src/adapter.c

  Log Message:
  -----------
  core: add NULL check to adapter_service_remove()

Make adapter_service_remove() safe for passing NULL pointers.


  Commit: 0bd3d1505e3a9f8b48768411b837dac80b21827e
      https://github.com/bluez/bluez/commit/0bd3d1505e3a9f8b48768411b837dac80b21827e
  Author: Roman Smirnov <r.smirnov@omp.ru>
  Date:   2024-06-28 (Fri, 28 Jun 2024)

  Changed paths:
    M tools/l2test.c

  Log Message:
  -----------
  l2test: replace sprintf() with snprintf() in recv_mode()

Use snprintf() instead of sprintf() to avoid buffer overflow.

Found with the SVACE static analysis tool


  Commit: 9886a7557b3cd2e744cfb5d12679228a4caea1aa
      https://github.com/bluez/bluez/commit/9886a7557b3cd2e744cfb5d12679228a4caea1aa
  Author: Roman Smirnov <r.smirnov@omp.ru>
  Date:   2024-06-28 (Fri, 28 Jun 2024)

  Changed paths:
    M profiles/audio/mcp.c

  Log Message:
  -----------
  mcp: replace sprintf() with snprintf() in cb_track_duration()

Use snprintf() instead of sprintf() to avoid buffer overflow.

Found with the SVACE static analysis tool


  Commit: 559e40a8b9a413119cebe2f5dfa2ece04daff6ff
      https://github.com/bluez/bluez/commit/559e40a8b9a413119cebe2f5dfa2ece04daff6ff
  Author: Roman Smirnov <r.smirnov@omp.ru>
  Date:   2024-06-28 (Fri, 28 Jun 2024)

  Changed paths:
    M tools/rctest.c

  Log Message:
  -----------
  rctest: replace sprintf() with snprintf() in recv_mode()

Use snprintf() instead of sprintf() to avoid buffer overflow.

Found with the SVACE static analysis tool.


  Commit: 0ddcfaeafad6ae71b3495bdfb174773aceb3e996
      https://github.com/bluez/bluez/commit/0ddcfaeafad6ae71b3495bdfb174773aceb3e996
  Author: Roman Smirnov <r.smirnov@omp.ru>
  Date:   2024-06-28 (Fri, 28 Jun 2024)

  Changed paths:
    M src/shared/gatt-server.c

  Log Message:
  -----------
  gatt-server: fix memory leak in bt_gatt_server_send_notification()

data-pdu is allocated but not released when an error occurs.

Add data-pdu release before exiting the function in case of an error.

Found by Linux Verification Center (linuxtesting.org) with the SVACE
static analysis tool.


Compare: https://github.com/bluez/bluez/compare/e3616b776ae0...0ddcfaeafad6

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
