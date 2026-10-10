Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BACB437845
	for <linux-bluetooth@vger.kernel.org>; Sat, 10 Oct 2026 09:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791623254; cv=none; b=dwEG2+72TcA266gfKe/OjIeIX6c0CjT3ZEDFoTukWwBnZw3qmkABEDUVhi9+bM44LYQUlIi1eudxT/CAHQDF8P4/2bYcmtszVu1v5oBldJ7v94gLxh4kj4GzSIHbm6t+qmzDwPEPmGcmKNwGXLfM/kxnJFNh6k9OzcIZHZKNjBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791623254; c=relaxed/simple;
	bh=+x48VhK52Xgg4WfxdkIUT51414g48IyTmS2XRpEiGME=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=rnvcZPyh0YBdgEP27tSGY1Q6j/CAkFWxg7yIwSzcYNqbq+4NZsO2Y39zP0jjPccy+Zp1sPOy/qTjPU9P6AuBlxs6S875n2BGblHId/srCtRY4it53IdIBIWOGLVO7YAiGaYOBczi4wJBO70ZC12F7NPrqiqI4qUcigtuk8CLIwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=BAdk7l3F; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="BAdk7l3F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1791623251;
	bh=mnAy2RRCJuerW3GYhsNNopsAZw4Seejv7do719Tkgtg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=BAdk7l3F3SnXHwX9tfqb4F18qI2MIAgqH06knzJGMaqvDQvn/bSAkLUnP/HfNTudN
	 D8FmVDMLvmgeFu6b0rXX/mgrC5UgnAXcRp8CELLdUGI4GOPe3CWnCM+ixyXQWlbXIh
	 89ZpUEPmL/DsgbWTofaMKDl5W16xDT4AckWAzqWm5FbfNaSjWmvFsa1NUVw3AYg3Az
	 7mtuuAknmIxjnlmpPMycS6TJaBdHd1oMCfIkKvsBCFZma/Vv0nvKJcj4ugR901Rkgo
	 5sArJ4LE5jBkoETtPWSzQOjZ75e333k28KvuNW73HENniGrmtNW1X4TvL0i5+7cx+9
	 S77wYmugTJOMQ==
Received: from github.com (hubbernetes-node-01f934e.ac4-iad.github.net [10.52.162.11])
	by smtp.github.com (Postfix) with ESMTPA id 30F4320B42
	for <linux-bluetooth@vger.kernel.org>; Sat, 10 Oct 2026 02:07:31 -0700 (PDT)
Date: Sat, 10 Oct 2026 02:07:31 -0700
From: IAROSLAV VOITOVYCH <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1182787/000000-0034d2@github.com>
Subject: [bluez/bluez] 0034d2: emulator: Free hooks in btdev_destroy
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

  Branch: refs/heads/1182787
  Home:   https://github.com/bluez/bluez
  Commit: 0034d2b7501bfa0458cf8f32f4ffd4a0f4fb6e51
      https://github.com/bluez/bluez/commit/0034d2b7501bfa0458cf8f32f4ffd4a0f4fb6e51
  Author: Iaroslav Voitovych <yaroslav.voytovych@gmail.com>
  Date:   2026-10-10 (Sat, 10 Oct 2026)

  Changed paths:
    M emulator/btdev.c

  Log Message:
  -----------
  emulator: Free hooks in btdev_destroy

Hooks added with btdev_add_hook() are only freed by btdev_del_hook(),
so a hook still installed when the device is destroyed is leaked. Five
mgmt-tester cases leave one installed: "Add + Remove Device Nowait -
Success" and the four "Adv. (non-)connectable & connected" cases on the
LE emulator; one l2cap-tester case does too. They pass, but with ASan
the tester exits with status 1 because LeakSanitizer reports, for
mgmt-tester:

  Direct leak of 120 byte(s) in 5 object(s) allocated from:
    #0 in malloc
    #1 in btdev_add_hook emulator/btdev.c:8891

Free the remaining hooks in btdev_destroy().

Fixes: 37199df506f4 ("emulator: Add support for pre/post command/event hooks")



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
