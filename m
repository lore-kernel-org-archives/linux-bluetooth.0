Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18ED30E850
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Jun 2025 13:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750427584; cv=none; b=LdR4nTHd3WQd9V90CmB+bVifKa5Vd4EKDXYxwA72oxrHeGIRG/+3cClJ6Eaw5gfYbDBulL/7owtK193lYlD8mk/TG02XdfFwzY0Etoik1pa/MgLZ+7hAwAzA1MGOBGdDPsiZZNz3S/LtSx+4IBbIyA8vQkFfMf8iD6d+mR7kh6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750427584; c=relaxed/simple;
	bh=I0kNiC36PPFcOxZB+SjUymOM+cGIAv0fWb56prSweMg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cbxK9ZwwBJQMlscWCRSGEq88jHUEt42U1D1frz+dqOKeEe5SfOP+pRVz01tJh0ZNp+j51gE9hxXhHA5lAHopTpcsLE9KXV9Z84s8v3aFxkKxQBQ81w2klArqyRXb4SkZaYcWu8ujOBYW8QASOnSNxTXSKNlJjP6Tc5aJybKRvck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=unknown smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=tempfail smtp.mailfrom=omp.ru
Received: from inp1wst087.omp.ru (81.22.207.138) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Fri, 20 Jun
 2025 16:52:27 +0300
From: Kirill Samburskiy <k.samburskiy@omp.ru>
To: <linux-bluetooth@vger.kernel.org>
CC: Kirill Samburskiy <k.samburskiy@omp.ru>
Subject: [PATCH BlueZ v2 0/4] test-vcp: Fix test failing in some environments
Date: Fri, 20 Jun 2025 16:51:42 +0300
Message-ID: <20250620135146.243585-1-k.samburskiy@omp.ru>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 06/20/2025 13:44:21
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 19
X-KSE-AntiSpam-Info: Lua profiles 194234 [Jun 20 2025]
X-KSE-AntiSpam-Info: Version: 6.1.1.11
X-KSE-AntiSpam-Info: Envelope from: k.samburskiy@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 62 0.3.62
 e2af3448995f5f8a7fe71abf21bb23519d0f38c3
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 81.22.207.138 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 81.22.207.138 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info:
	inp1wst087.omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;lore.kernel.org:7.1.1;omp.ru:7.1.1;81.22.207.138:7.1.2;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: ApMailHostAddress: 81.22.207.138
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 19
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 06/20/2025 13:46:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 6/20/2025 9:37:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

This patch fixes test-vcp failing on some environments. It is done by
shutting down tester IO before test teardown and registering detach
callbacks to ensure proper cleanup. Similar changes are introduced to
test-micp to avoid similar problems in the future.

---
Note: this is the second version of the patch, the original discussion
can be found at:
https://lore.kernel.org/all/20250619153120.126315-1-k.samburskiy@omp.ru
See patch changelog below for changes in the new version.

After updating our bluez source code from v5.72 to v5.83 we noticed
that one of the tests (test-vcp) no longer passes on all environments
(specifically when building for x86_64 or arm64 architectures). This
patch resolves the problem, enabling all tests to pass. Here is a
short extract from test logs:

```
AICS/SR/CP/BV-01-C - init
AICS/SR/CP/BV-01-C - setup
AICS/SR/CP/BV-01-C - setup complete
AICS/SR/CP/BV-01-C - run
gatt_notify_cb: Failed to send notification
ERROR:src/shared/tester.c:981:test_io_recv: assertion failed (len == iov->iov_len): (5 == 6)
```

The reason this test was failing is incomplete test teardown.
Specifically, bt_vcp instances created by vcp_get_session function
are not freed and, more importantly, not removed from sessions queue
(both function and queue are found in shared/vcp.c file).

When a new test case is started, vcp_get_session function may be called
at some point. This function looks up session object using current
bt_att object as key. Each test case creates its own bt_att instance,
however in our case bt_att is always allocated at the same memory
address. This leads to vcp_get_session function looking up session
object belonging to the previous test case instead of creating a new
bt_vcp instance (since both current and previous test cases allocated
memory for bt_att object at the same address).

Getting the wrong session object leads to using wrong gatt_db, which
then uses the wrong user_data for CCC callbacks, ultimately leading
to gatt_notify_cb function from test-vcp.c getting incorrect test_data
pointer. Finally gatt_notify_cb attempts to send a notification using
an already freed bt_gatt_server instance, which unsurprisingly fails,
causing expected data to not be written into tester IO channel.

This patch fixes the issue by doing two things. First, it shuts down
tester IO as a part of test teardown, triggering disconnection
callbacks in bt_att object. One of these callbacks is registered in
vcp_get_session function, specifically vcp_disconnected function.
This function detaches bt_vcp instance (removes from sessions queue)
and triggers *_remote_client_detached callbacks. The second part of the
fix is registering vcp remote client callbacks using bt_vcp_register
function, with vcp_client_detached function responsible for unrefing
(and freeing) the detached bt_vcp instance. Since the instance is now
removed from sessions queue, vcp_get_session function can no longer
look up a wrong object during the test, allowing it to pass.

---
v2: tester_shutdown_io is now called from test_result, thus applying to
    all tests.
    Removed bt_vcp allocation from test-vcp since it was unnecessary.
    Added bt_vcp_add_db call to ensure all relevant attributes are
    still added to gatt_db.
    Introduced similar changes to test-micp: removed unnecessary
    bt_micp allocation and added detach callback for freeing bt_micp
    instance created by micp_get_session.
    In shared/bap, NULL attach or detach callbacks are now ignored to
    ensure test-bap does not fail due to introduction of IO shutdown.
---
Kirill Samburskiy (4):
  shared/bap: ignore NULL attach/detach callbacks
  test-vcp: remove unnecessary bt_vcp allocation
  test-micp: remove unnecessary bt_micp allocation
  shared/tester: shutdown tester IO before test teardown

 src/shared/bap.c    |  6 ++++++
 src/shared/tester.c |  8 ++++++++
 src/shared/tester.h |  1 +
 unit/test-micp.c    | 18 ++++++++++++++----
 unit/test-vcp.c     | 19 +++++++++++++++----
 5 files changed, 44 insertions(+), 8 deletions(-)

-- 
2.34.1

