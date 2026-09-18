Received: from out-29.smtp.github.com (out-29.smtp.github.com [192.30.252.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F5F3AC0ED
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 22:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789770329; cv=none; b=lOzMN9hMQCgWkOkq0iOfewh4DAA5IXjVFdLqQqI8S4jwbkHLWoHizBx6nnx1Xq0QR2NpWRtAVHPIzcSgDTb0IkvRlosvQTHyAi8mGZo5B2PZgzCzrul6MgvOjqyqFWKNj9PA+DQAloNgK7LQ5OsE33mzS4fhG3KR4s7Hqc2nrs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789770329; c=relaxed/simple;
	bh=RGE5jTTsCCoBzbvBpm4exyT0ssNAF7wzBcKkFDXCOS4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=lgBkvpqwmjUaRW0CGcJcipQMWV4JvK0UPdVYrcau99P7wqGEU9V6nAsRmqn3T1fiYD+MC+wuGKISJ4uYPFyJ8RIaqkero+5rCWYPxnvW6yycI/2Z5OTHGDzRYaSJ3A/oZrcybuwAs4iEeKh1osAVympffFZQcBLExGV/vyF4e5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=PKHdqiYK; arc=none smtp.client-ip=192.30.252.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="PKHdqiYK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1789770327;
	bh=Co2Xwbjb+CzTFH9+FJenlRHPrLWKj21u3pexFURCJ60=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=PKHdqiYK4DEPYs66NTgwM/X8m7wGM+/MNjDD0Z9wMKRX2ENSl64wfGYYAMkwMRNPo
	 x1ICKpay0nfyTugeFyxHkxfl8Efqup2l1koXP8g+WSxVYuXY1/7WT/JeeC0qhjgvlU
	 sCKce/yciT3f7zhMJau/NcmCL6g1tkNBtfH+sETY=
Received: from github.com (hubbernetes-node-3b6afb6.ac4-iad.github.net [10.52.135.36])
	by smtp.github.com (Postfix) with ESMTPA id 1DC713203D1
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 15:25:27 -0700 (PDT)
Date: Fri, 18 Sep 2026 15:25:27 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1169029/000000-bce86b@github.com>
Subject: [bluez/bluez] bce86b: adapter: remove the devices from the list
 before f...
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

  Branch: refs/heads/1169029
  Home:   https://github.com/bluez/bluez
  Commit: bce86bc9645e31c6c20b9e2d58337cbdec689811
      https://github.com/bluez/bluez/commit/bce86bc9645e31c6c20b9e2d58337cbdec689811
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-18 (Fri, 18 Sep 2026)

  Changed paths:
    M src/adapter.c

  Log Message:
  -----------
  adapter: remove the devices from the list before freeing them

The devices of an adapter are freed one by one when it is removed, but
the list keeps pointing at them until every one of them is gone, so it
refers to freed devices while the remaining ones are being removed.

Freeing a device looks devices up though, e.g. cleaning up its GATT
server reports the disconnection, which searches the list for the
device it belongs to, and the search reads the devices already freed:

  ERROR: AddressSanitizer: heap-use-after-free
    in bacmp lib/bluetooth/bluetooth.h:438
    in device_addr_type_cmp src/device.c:5657
    in btd_adapter_find_device src/adapter.c:1055
    in att_disconnected src/gatt-database.c:335
    in gatt_server_cleanup src/device.c:842
    in device_free src/device.c:918

Take each device out of the list before removing it, so only the ones
still to be removed are ever found.

This needs more than one device on the adapter to show up, which the
test of a coordinated set is the first to leave behind.

Assisted-by: opencode:claude-opus-5



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
