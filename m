Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35D13064B5
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jun 2026 06:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780381130; cv=none; b=MqAYKvHMXWhW6AYd0QcxT2wFjQWhf9FB1SkZENTfSJeOXRQ8rtL/9vrdolL8qdOFpg8xc64/0OpC2UqhClPJYTeuGjMkFJInPexKDYtFWMWbTBnd4PDwuNMD7uWBtVR0qoYoSf5WVs977mvt7kA39a1jizd0+d1hBPUanKwlu14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780381130; c=relaxed/simple;
	bh=sK9+c20Ynvr6MxaIAsIYGp5SbwQDScODduc/4iy/tsw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=CLBjkRQkcP0jyDMZth0P/g3x5WSqPlyG4BlBjrlrWLGzMHs/0XjPEnovs2G2cqZCEFHnK9CZo43Z0Ane+cq7tPHMc8sTGX2zVKn+4aqLlRI0j9kKWoZanqalzCIEFMmclBFZKFy2ku26ZoSpcFV/MyAI8maXBMy34xS0Y/HIj/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=P0nYfXmd; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="P0nYfXmd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1780381128;
	bh=Bz0lXWAK4v0AVN5Uo4k7X6POwaHn5wA4T2qyIhrnp8g=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=P0nYfXmdWthb6NSPFMQMlnZ0xp+JagPnizSwebQcczHD6C4vg75loQmV1NA+vdIVN
	 IHx4HxFRk4tYkVNUJlDzSUllExxic4YjKGbj5Sz4iPjp3RKVTdiFb3fkMjFy8zJtug
	 WrF5aNNRBpCMGqw2bETeXuFoZfbRicnTLcawqwic=
Received: from github.com (hubbernetes-node-5b3ec41.ac4-iad.github.net [10.52.138.38])
	by smtp.github.com (Postfix) with ESMTPA id CAC379410B9
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Jun 2026 23:18:48 -0700 (PDT)
Date: Mon, 01 Jun 2026 23:18:48 -0700
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1104327/000000-1b39ef@github.com>
Subject: [bluez/bluez] 1b39ef: profile: Set L2CAP IMTU for external profile
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

  Branch: refs/heads/1104327
  Home:   https://github.com/bluez/bluez
  Commit: 1b39efe9c30d37330412342b59bce41297d68799
      https://github.com/bluez/bluez/commit/1b39efe9c30d37330412342b59bce41297d68799
  Author: Wei Deng <wei.deng@oss.qualcomm.com>
  Date:   2026-06-02 (Tue, 02 Jun 2026)

  Changed paths:
    M src/profile.c

  Log Message:
  -----------
  profile: Set L2CAP IMTU for external profile listeners

bt_io_listen() in ext_start_servers() creates the L2CAP listening
socket for external profiles without an explicit IMTU. This causes
the socket to use the L2CAP minimum of 672 bytes, which is advertised
to the peer in L2CAP_CONFIGURATION_RSP.

As a result, when acting as a server (receiver), the peer limits its
outgoing PDU size to our advertised 672 bytes. This leads to small
OBEX body chunks (~669 bytes) and severely degraded Rx throughput,
while Tx throughput is unaffected since the peer's IMTU is not
constrained by our setting.

The obexd client side (obexd/client/bluetooth.c) already sets IMTU to
BT_RX_MTU (32767) for outgoing connections. Mirror that on the server
side by setting BT_IO_OPT_IMTU to BT_RX_MTU in ext_start_servers(),
so incoming connections advertise the same maximum receive capability.

Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
