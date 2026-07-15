Received: from out-44.smtp.github.com (out-44.smtp.github.com [192.30.252.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11A74302F8
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2026 09:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784107890; cv=none; b=avmxPpC4LpUiP9dB25OJHUeF6WvoFi2ZZlazQduLFb5Uirnb87aRiJF9AGay84DybaVaZUBwh3gjbyBcawdQkHAO1vpKz9mU4SmLLFqQ/GMYLQZl2r0aM0qW7EKnUtHAv/L5i1J2eFtymISQ7RdLKDzQmuw4lIlvtvYgLKMIgHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784107890; c=relaxed/simple;
	bh=Vsdb+CBG324jszfOjEsGsz3MXs7iApDLVqvSntmUUCM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=HZvqTB7CTyMf++J4Ick9eSvvJjQkoRT6OkWAYbs+56NDJvlq2CCKYRySubo3mLcotGxJtPo93Z9CMnI/hxmQWbtMXxRg8vPNGhckgKpN5knwJMofNO8b+lnxNc3saU2tjgDYf8LmhWQcH5qw2zzV/aSqaWgDZGyAHRbIXnYc4ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=AjStseco; arc=none smtp.client-ip=192.30.252.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="AjStseco"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1784107885;
	bh=4+SQp4B4D0tF6CI3yApvv/t/vrGcdGhi8I4t/RqWtnI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=AjStsecor/s3kamNXXmscoA9CrRLyIMwRHmaVovAr9dL8isf2v7S/kowQGr8OWE6l
	 VC/v0lpZsIoLIzUs1Njyd2PVGeHucCdfTcIzl5Hay0krFWUiNe5K+Aqf2m/KTq8xMb
	 88EVy6d0+FxQrXgIG+K1vvJIZ/6BT4V2iJxPek3A=
Received: from github.com (hubbernetes-node-648ccbe.ash1-iad.github.net [10.56.211.57])
	by smtp.github.com (Postfix) with ESMTPA id 51F218412A2
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2026 02:31:25 -0700 (PDT)
Date: Wed, 15 Jul 2026 02:31:25 -0700
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1128034/000000-e5cd97@github.com>
Subject: [bluez/bluez] e5cd97: adapter: restrict delta=0 RSSI to proximity
 filters
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

  Branch: refs/heads/1128034
  Home:   https://github.com/bluez/bluez
  Commit: e5cd975f28413ecac5c4fb4702c24149525007d6
      https://github.com/bluez/bluez/commit/e5cd975f28413ecac5c4fb4702c24149525007d6
  Author: Xiuzhuo Shang <xiuzhuo.shang@oss.qualcomm.com>
  Date:   2026-07-15 (Wed, 15 Jul 2026)

  Changed paths:
    M src/adapter.c

  Log Message:
  -----------
  adapter: restrict delta=0 RSSI to proximity filters

When a discovery filter is active (filtered_discovery=true), BlueZ
unconditionally calls device_set_rssi_with_delta(..., delta=0),
causing every BLE advertisement to emit a PropertiesChanged(RSSI)
signal regardless of whether the RSSI value changed.

delta=0 is only needed when a client has expressed explicit proximity
interest by setting an RSSI or pathloss threshold in its discovery
filter. Filters that specify only transport type or UUIDs do not
require per-packet RSSI precision; for those, the standard
RSSI_THRESHOLD=8 rate-limiting is both correct and desirable.

The problem is triggered on dual-mode adapters by a transport-only
filter (e.g. Transport=le). In merge_discovery_filters(), the
transport-specific scan type (SCAN_TYPE_LE=6) does not equal the
adapter scan type (SCAN_TYPE_DUAL=7), so has_filtered_discovery is
set, filtered_discovery becomes true, and delta=0 is applied even
though no proximity condition was requested. With hundreds of BLE
devices advertising simultaneously this generates hundreds of
unnecessary PropertiesChanged(RSSI) signals per second.

Confirmed on QCS6490 (BlueZ 5.72) with Transport=le filter:

  adapter.c: filtered_discovery=1 (current_discovery_filter=set)
  device.c:  device_set_rssi_with_delta() rssi=-86 delta_threshold=0
  device.c:  device_set_rssi_with_delta() rssi=-79 delta_threshold=0

Add discovery_filter_has_proximity() which walks discovery_list and
returns true only when at least one active filter carries a real
proximity condition (rssi != DISTANCE_VAL_INVALID or pathloss !=
DISTANCE_VAL_INVALID). Use this to gate the delta=0 path.

Other filter fields (transport, uuids, duplicate, discoverable)
express capability or content criteria and carry no proximity
implication, so they are intentionally excluded from the check.

Signed-off-by: Xiuzhuo Shang <xiuzhuo.shang@oss.qualcomm.com>



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
