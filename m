Received: from out-36.smtp.github.com (out-36.smtp.github.com [192.30.252.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CA519B5B1
	for <linux-bluetooth@vger.kernel.org>; Sat,  8 Aug 2026 05:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786166643; cv=none; b=J05VJi2r3lO0SYNv74yQnqZfAvJcXr/3mSsXUS/TlyjJkndz6GEb4DtfxSNJ7AcjjgDfnuMh9EMJvmhfOfp8lxT51+PXJBAbRqIxZmjF24ghFAZiK2fiDhyPch8/b9DtxDocJKXFtzqHpmh14rqj8HTeEMrYox8GPMNZFqjAB6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786166643; c=relaxed/simple;
	bh=apm1raOowlCkldonIK7VXhBthWPD+VMseSqdllmWcf8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=jlF7mu5yjoFsTFYBCyPuATEuDlZOX41UOMpLc1mY5y4PQrnIyjEYVPvkb+kBpAypEh555yhXxRnRMuCZyldOSyUU3+riIPEY1PV/F9zYegHGLM8M35J21HDbY0m2UPcEuWtgBv1GdaJPGsk2JUzvd/nK6QZNcQgg9gFEplkIokE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=SyolBl0U; arc=none smtp.client-ip=192.30.252.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="SyolBl0U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1786166641;
	bh=QD+jjcU/Xcqcf+hOBf25ggRZZePsXMfxthxYh8Iy9hc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=SyolBl0Ucr9KhTq405yE0Brl5xouFpfX1k6Yh/0Dm6h7u5TfoM6iisZrmqZNByj6S
	 oRwtkFLl2kXsGYROBN7XJHOuSpOlxxyapR7DUcSwA0xxNS2+qEhgWQBSaR8RTju5nH
	 idavKqOBu2xap0BTG18TIzkAUyCMFBFR1bKdna0w=
Received: from github.com (hubbernetes-node-04d8ddf.ac4-iad.github.net [10.52.205.84])
	by smtp.github.com (Postfix) with ESMTPA id 477AA740FF5
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Aug 2026 22:24:01 -0700 (PDT)
Date: Fri, 07 Aug 2026 22:24:01 -0700
From: Proxy Alt <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1142530/000000-ac5a8e@github.com>
Subject: [bluez/bluez] ac5a8e: shared/gatt-client: discover the CCC descriptor
 in...
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

  Branch: refs/heads/1142530
  Home:   https://github.com/bluez/bluez
  Commit: ac5a8e4fede675e736f2acd8123c1012e990465b
      https://github.com/bluez/bluez/commit/ac5a8e4fede675e736f2acd8123c1012e990465b
  Author: Proxy alt <proxy-alt@proxy-alt.dev>
  Date:   2026-08-08 (Sat, 08 Aug 2026)

  Changed paths:
    M src/shared/gatt-client.c
    M unit/test-bap.c
    M unit/test-mcp.c
    M unit/test-rap.c

  Log Message:
  -----------
  shared/gatt-client: discover the CCC descriptor instead of assuming it

discover_descs() skips descriptor discovery when a notify/indicate
characteristic has exactly one descriptor handle, inserting a synthesized
0x2902 into the database without ever querying the peer. The assumption
follows Core Spec Vol 3, Part G, 3.3.1.1 - notify or indicate implies a CCC
- but it is applied to hardware that does not honour that clause.

On Telink TLSR825x based devices (GE Cync bulbs and switches) the only
descriptor of the notify characteristic is a 0x2901 Characteristic User
Description reading "Status". No CCC exists anywhere on the service. btmon
shows FIND_INFORMATION_REQ issued for the descriptor slot following every
other characteristic and never for this one: the only slot skipped is the
one following the only characteristic declaring notify.

StartNotify then writes 0100 into that text descriptor. The device leaves
the Write Request unanswered - its own violation - the ATT transaction
timeout expires 30 seconds later, and a connection that was carrying live
notification traffic throughout is torn down. The client is handed
UNLIKELY_ERROR, which never appeared on the wire. The synthesized
descriptor is also written to the GATT cache, and regenerated there on
every fresh discovery, so removing the device does not clear it.

Removing the shortcut costs one round trip per notify characteristic per
discovery and lets the peer answer for itself. Where a CCC genuinely
exists, nothing changes. Where it does not, gatt_db_attribute_get_ccc()
returns NULL, chrc->ccc_handle stays zero, and register_notify() already
handles that case correctly - it completes the request and registers the
handler locally without writing anything. Notifications are dispatched on
a value handle match, so they continue to be delivered, and the link
survives.

Confirmed on the affected hardware with tools/btgatt-client, same device
and adapter minutes apart:

  before   descr - handle: 0x0013, uuid: 00002902-...
           < 12 13 00 01 00
           att: Operation timed out: 0x12
           Failed to register notify handler - error code: 0x0e
           Device disconnected

  after    discover_descs_cb() handle: 0x0013, uuid: 00002901-...
           Registering notify handler with id: 1
           no write to 0x0013, no error, link held

unit/test-bap, unit/test-mcp and unit/test-rap are updated. Their expected
PDU sequences omitted descriptor discovery for exactly those
characteristics whose CCC was being synthesized, so the test data encoded
the shortcut rather than the protocol. test-mcp says so directly - its
MCS_FIND_CHRC comment lists Find Information only "for each missing CCC
HND", the notify characteristics being absent because BlueZ never asked
about them. Now that it asks, those exchanges appear and are expected.

make check: 32/32 suites, 0 failures.

Fixes: https://github.com/bluez/bluez/issues/2383
Signed-off-by: Proxy alt <proxy-alt@proxy-alt.dev>



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
