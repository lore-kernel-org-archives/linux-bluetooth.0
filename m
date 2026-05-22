Received: from out-34.smtp.github.com (out-34.smtp.github.com [192.30.252.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF9B368D74
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 May 2026 08:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779436885; cv=none; b=J8r73aaRwVz7iXAfqJEGdvfeEbeubySLEVc8Mh5tkH1Dsy3VS9RYP+H7rAN4Jv1Ft2Q9EkVFPnFeaMkrtQQ4XYAVWKi4EN/B/pOKuj39Y4Cd2jak8/vdngvCy/0rgT8/QIYjUg+ATQwGB65lFToE/aE/UcY06CGtiCn1tD7JDao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779436885; c=relaxed/simple;
	bh=oueiAHH8u7odmgsyB9XkepSdDKY44//RnbL9wPkSpD8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=FyA8EQLQfpxuj2l/xLbTdYqUSEmNJCHLX/uec+WpGJuLzPcQj558vyGK3NcDmH/R8pF6a0OruULfCsIa0lg1IECQoahdN+Sl9HPmOPQEe16t6qO531cvWCUPgRXNXiNPrYWoOBKk+L4MyTITBa7pUgoNvKrwutEWX7cCswvYopo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Jt78zH20; arc=none smtp.client-ip=192.30.252.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Jt78zH20"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1779436882;
	bh=0WRf4o/8oNHzAfRlfrSToV6D7QgJ4853QzGNvaRAOwg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Jt78zH20R+Y9Y7h/+WkD/SnLoL49jakYKmVxpLwASaumO4TC3SyQftY3AzhWgqr0t
	 uCKl1tm6unC/2YsTCjdkzkU9mQ5wRfSYd3vaKIy0NMMrM5ommvIatzNUq1KFz8l6Ex
	 mbGkmytppEssOy1bKvGC/IvKeJ7Y6CYuWpPndQXc=
Received: from github.com (hubbernetes-node-8fc05a5.ac4-iad.github.net [10.52.180.34])
	by smtp.github.com (Postfix) with ESMTPA id 94B0A74097E
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 May 2026 01:01:22 -0700 (PDT)
Date: Fri, 22 May 2026 01:01:22 -0700
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1099144/000000-4756b9@github.com>
Subject: [bluez/bluez] 4756b9: profile: Set L2CAP IMTU for external profile
 liste...
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

  Branch: refs/heads/1099144
  Home:   https://github.com/bluez/bluez
  Commit: 4756b963976b8c9c4406e0ee2e6a44c4f754a2cd
      https://github.com/bluez/bluez/commit/4756b963976b8c9c4406e0ee2e6a44c4f754a2cd
  Author: Wei Deng <wei.deng@oss.qualcomm.com>
  Date:   2026-05-22 (Fri, 22 May 2026)

  Changed paths:
    M src/profile.c

  Log Message:
  -----------
  profile: Set L2CAP IMTU for external profile listeners

bt_io_listen() in ext_start_servers() creates the L2CAP listening
socket for external profiles without an explicit IMTU, causing the
socket to default to the L2CAP minimum of 672 bytes. This is advertised
to the peer in L2CAP_CONFIGURATION_RSP and limits PDU size, degrading
Rx throughput.

The obexd client side (obexd/client/bluetooth.c) already sets IMTU to
BT_RX_MTU (32767) when connecting. Mirror that on the server side by
setting BT_IO_OPT_IMTU to 32767 in ext_start_servers().

Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
