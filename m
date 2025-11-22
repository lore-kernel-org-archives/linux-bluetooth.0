Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C2D1DE2DC
	for <linux-bluetooth@vger.kernel.org>; Sat, 22 Nov 2025 16:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763828260; cv=none; b=awzvt53X5VoE8OkYY9NFYNNeuU31a8W6TlFpHOz4h+GuOXeTyBbLuV2y7OyYu3is+QT2JAeU5w3zeTx0sElcNrFWPmkkM0zkel6H9DuNx2ydZpBlaZerGLBmIEUgE3q+hCJ/rwHK02jqbIbbfBU3NjWehxiaJPtQ8a9zNfNAicQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763828260; c=relaxed/simple;
	bh=d6ochgcaLCirGxXETuCNyjHJ7MMQ0R/kBee6IleTHqc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=KyBbLm6Vn4XfJeUqXD/dmBIPrWAc1NglwOMfA+T/V8uuLxGhsw8lWiila3Vzg/ud2ide6ToiprrqgmgDZI4afufs0Qa3zG3Ih6ABdz9oa8Pu2oUOa7J3QzEzjdWfFUKSpuDn5Zy56CiXcRf/AK7LmPZMzaXEchXOLkYaj6WZYeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Rz0br9ov; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Rz0br9ov"
Received: from github.com (hubbernetes-node-d961b8a.ac4-iad.github.net [10.52.181.52])
	by smtp.github.com (Postfix) with ESMTPA id 49F324010AA
	for <linux-bluetooth@vger.kernel.org>; Sat, 22 Nov 2025 08:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1763828258;
	bh=8QyZFJSxh+Msrbb2g9fuEFAPVw7khkFOhtokYAEYD3c=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Rz0br9ovAx9rYpDF+/poef+ZqpnBJBnDX24+epyAMdAFQkJSpr/A/E9sd+O9NGOE5
	 SQ1ppSl3kYzN5ORjtOAdG0Q0kacdctudmE7hH5J87XsgHSDIhkfy+3OQVtVc5bdbER
	 zA3XKglam6xAQiiHwGGvA6SwVGC2W8RhVNydurOA=
Date: Sat, 22 Nov 2025 08:17:38 -0800
From: Peter Seiderer <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1026619/000000-0ca638@github.com>
Subject: [bluez/bluez] 0ca638: transport/audio: fix build with a2dp support
 disabled
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

  Branch: refs/heads/1026619
  Home:   https://github.com/bluez/bluez
  Commit: 0ca638d551803572613c7e0e57103e2b77c8a410
      https://github.com/bluez/bluez/commit/0ca638d551803572613c7e0e57103e2b77c8a410
  Author: Peter Seiderer <ps.report@gmx.net>
  Date:   2025-11-22 (Sat, 22 Nov 2025)

  Changed paths:
    M profiles/audio/media.c
    M profiles/audio/transport.c

  Log Message:
  -----------
  transport/audio: fix build with a2dp support disabled

Fixes:
    CCLD     src/bluetoothd
  /usr/lib64/gcc/x86_64-suse-linux/bin/ld: profiles/audio/bluetoothd-media.o: in function `endpoint_init_a2dp_sink':
  .../bluez-5.85/profiles/audio/media.c:728:(.text.endpoint_init_a2dp_sink+0x2b): undefined reference to `a2dp_add_sep'
  /usr/lib64/gcc/x86_64-suse-linux/bin/ld: profiles/audio/bluetoothd-media.o: in function `endpoint_init_a2dp_source':
  .../bluez-5.85/profiles/audio/media.c:715:(.text.endpoint_init_a2dp_source+0x28): undefined reference to `a2dp_add_sep'
  /usr/lib64/gcc/x86_64-suse-linux/bin/ld: profiles/audio/bluetoothd-media.o: in function `set_configuration':
  .../bluez-5.85/profiles/audio/media.c:512:(.text.set_config+0x35): undefined reference to `a2dp_setup_get_device'
  /usr/lib64/gcc/x86_64-suse-linux/bin/ld: .../bluez-5.85/profiles/audio/media.c:525:(.text.set_config+0x8c): undefined reference to `a2dp_setup_remote_path'
  /usr/lib64/gcc/x86_64-suse-linux/bin/ld: profiles/audio/bluetoothd-media.o: in function `media_endpoint_remove':
  .../bluez-5.85/profiles/audio/media.c:250:(.text.media_endpoint_remove+0xc): undefined reference to `a2dp_remove_sep'
  /usr/lib64/gcc/x86_64-suse-linux/bin/ld: profiles/audio/bluetoothd-media.o: in function `endpoint_reply':
  .../bluez-5.85/profiles/audio/media.c:361:(.text.endpoint_reply+0x267): undefined reference to `a2dp_parse_config_error'
  collect2: error: ld returned 1 exit status
  make[1]: *** [Makefile:5491: src/bluetoothd] Error 1
  make: *** [Makefile:4096: all] Error 2

Signed-off-by: Peter Seiderer <ps.report@gmx.net>



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
