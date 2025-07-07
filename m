Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4801A25C81E
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Jul 2025 06:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751868128; cv=none; b=VnmIPEXuZichQ0STeaTcuCOnlG3y8bdh0VUC6oOJiRE3epUy/N9j7e6JZJAzABjJH6dxM3z0ppG0G3VUE8X7VFcTIAjOBqDlAdChA1B7vkDJuu7G36DjgrT9woOyDQ6nOph3mFkZCoz7thF7+0V1ESrL9u4SPlbQBM6TS3gOWeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751868128; c=relaxed/simple;
	bh=Ub45tkheG+ujojL9OmJ+AWVxxV29qiwXaYb8E5Ud2fw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=dBrQ3bJ/UGWB4qTZNRvlvu58IrgaeKApwve8w7JmRdL+sZ8Jucxp6q4hIQUQP4L01h4bIsQIU7VtzanhOlr6wfZJufMRUYNyoXQkI43kar6vqZXtYJSqOKEH58UXxqjY/H3mvK09Cq1Cb+fwT4rpKm6ZGIBROsy/3MKPQ4Qn958=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=iqtt/uPe; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="iqtt/uPe"
Received: from github.com (hubbernetes-node-ea86f46.va3-iad.github.net [10.48.167.36])
	by smtp.github.com (Postfix) with ESMTPA id 598518C08A7
	for <linux-bluetooth@vger.kernel.org>; Sun,  6 Jul 2025 23:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1751868126;
	bh=By1HazaZLySLm4SRcC+i/LuIa8GjV7cah7ziYuRDqs8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=iqtt/uPeLuDXAg6TPDTM8CXXSC0uWFii9m7IWAa20AUjFso/DZ6A7jIJpPhDbBPUI
	 dqNSQoAjjGCE+VvIUHQ4VR4sVdXFV6KgOCE7vQmVFlM/zWwY6LFSVe16pj2CI8D3vH
	 jpcbd5N5vzULfPMupe+ywaTeBKTZLvTksjq4T5v8=
Date: Sun, 06 Jul 2025 23:02:06 -0700
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/979547/000000-f7155d@github.com>
Subject: [bluez/bluez] f7155d: shared/bap: Add stream state check in
 stream_disable
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

  Branch: refs/heads/979547
  Home:   https://github.com/bluez/bluez
  Commit: f7155d0d84ba62d7de1ab785ecda7dc817613dbf
      https://github.com/bluez/bluez/commit/f7155d0d84ba62d7de1ab785ecda7dc817613dbf
  Author: Yang Li <yang.li@amlogic.com>
  Date:   2025-07-07 (Mon, 07 Jul 2025)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Add stream state check in stream_disable

Add BT_BAP_STREAM_STATE_CONFIG state check so that stream_disable() is
a no-op when the stream is in CONFIG state. This prevents unexpected state
transitions or redundant operations during cleanup.

Error trace:
bluetoothd[2313]: src/shared/bap.c:stream_io_disconnected() stream 0x1f9fc20 io disconnected
bluetoothd[2313]: src/shared/bap.c:bap_ucast_set_state() stream 0x1f9fc20 dir 0x01: releasing -> config
bluetoothd[2313]: src/shared/bap.c:stream_notify() stream 0x1f9fc20 state 1
bluetoothd[2313]: profiles/audio/transport.c:bap_state_changed() stream 0x1f9fc20: releasing(6) -> config(1)
...
bluetoothd[2313]: src/shared/bap.c:stream_disable() stream 0x1f9fc20
bluetoothd[2313]: src/shared/bap.c:bap_ucast_set_state() stream 0x1f9fc20 dir 0x01: config -> qos

Signed-off-by: Yang Li <yang.li@amlogic.com>



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
