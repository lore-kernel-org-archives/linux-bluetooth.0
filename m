Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E676165F1A
	for <linux-bluetooth@vger.kernel.org>; Sat,  8 Aug 2026 03:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786161025; cv=none; b=G/ct5BnKCCg5ZdNGen0k+SIpixMHbc3S1M3pIgTpaoZ23wC3v6hcVP12PggOWhPTXR692Je2COomjgwFPU304ZuJWQjwzj93xtfpS4eOb+kObY6SjKMe8h4aauepnNdO4FtIMZM1+9jbDaY6/uAumgul12R+gHr4WcsHGLqMc2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786161025; c=relaxed/simple;
	bh=jjZ2zb9hd2DejW9F8JdVAa4rPmQZXyO0BSAKAUxHMk4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=cTVyAlln0Y8SC7+DXG5A7dX6x1oKQPMpx5W1qSFe8dTV90cvJhJ/DQH7bvd96IE30GBAhGRb6qWFIdShRmeIY19pYDQ6kQ3wNbi9vEXV2QzmIqnsqsryygZW4xHYWVr4S5sDx8BSh96LK3gSFYVtdEz/BooGP65ANFOycwXDo6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=GvmIJ/Fd; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="GvmIJ/Fd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1786161023;
	bh=ObxUV4yH79ti1P26BhPCcGp3Q9ZGVMypJ5u25LMHm2A=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=GvmIJ/Fd0JCFD0kDE+gCqHdZbOUpbDlGbyBdi4HNjsAO9Mk4QTV6cSQZbicx+EQW5
	 7ei13OPcj4eEkhZBcjAsRdmiPq5d+zeeoxlkvgDPR+2RmzRabs2/lofUBhxfypFiUd
	 LGXlFlsRBgWlNfULi9w5NXyrr4EwNYTOL4tglsh8=
Received: from github.com (hubbernetes-node-2302e7c.va3-iad.github.net [10.48.77.80])
	by smtp.github.com (Postfix) with ESMTPA id 4B7CA28058B
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Aug 2026 20:50:23 -0700 (PDT)
Date: Fri, 07 Aug 2026 20:50:23 -0700
From: Proxy Alt <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1142517/000000-574d52@github.com>
Subject: [bluez/bluez] 574d52: shared/gatt-client: discover the CCC descriptor
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

  Branch: refs/heads/1142517
  Home:   https://github.com/bluez/bluez
  Commit: 574d52f7cabb3472ce79d20b57a015350f68bf16
      https://github.com/bluez/bluez/commit/574d52f7cabb3472ce79d20b57a015350f68bf16
  Author: Proxy alt <proxy-alt@proxy-alt.dev>
  Date:   2026-08-08 (Sat, 08 Aug 2026)

  Changed paths:
    M src/shared/gatt-client.c

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

Reported and reproduced on three units across two OUI families, one of
which had never been connected before.

unit/test-gatt is unaffected: 192/193 passing, 0 failed, identical before
and after (the one not-run case is pre-existing). No test database has a
notify or indicate characteristic with a single descriptor handle, so
nothing in the suite exercises the shortcut being removed - which is also
how it went nine years without anyone noticing it guesses wrong.

Fixes: https://github.com/bluez/bluez/issues/2383
Signed-off-by: Proxy alt <proxy-alt@proxy-alt.dev>



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
