Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75510366067
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 14:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773929735; cv=none; b=dXSabX0nTs+qn4JOvJVKcz+CqSbpuuwOoBwtT7hLt2vGYlStdAjTX/7zyRciwD7kibmnWQbkofLyvRUzpGCGRs1hUEwbra8b8vKXYDL68mxCOEojevBduKubxoBr9dcfxY1oGnQ5ND3LeBOlr+YZ4WtPybLg77Dq2v4q+KFKRSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773929735; c=relaxed/simple;
	bh=Esqg0IJermWAJs86MYX9TXT/qTLPtYu7HoK7uSaRipk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=JefcRH8uoBfsNKS5BOSHbhC86KdsCq28JqANJ8n3DjnKFrqJJeN0MdkRmOufRMp2DCHxeFCyQoBZpUcNrHcOznQoJxpHGyyDK0AwzRy7vwwPQQJQRF8Wd0AMUn1fTC1RxjhE/fn4RUA1QeM+BGUcGGZ71DZXDsidb6ne66uMwvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=g6ni9dI/; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="g6ni9dI/"
Received: from github.com (hubbernetes-node-9b906a8.ac4-iad.github.net [10.52.86.29])
	by smtp.github.com (Postfix) with ESMTPA id 81A07301092
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 07:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1773929733;
	bh=QLBtIcXm6XlWmSoVNZ2WKXXBfw8rEbCQZNCKERuMMWw=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=g6ni9dI/TiDO7vw5Ds1Y8u0zvYyeOMRXitaqQcvIuPyMc8YQwStDOscQKX0y6J7Qf
	 3Qvz/ccwnmijheZkWwfjY1w+UN0W9rDt/3Qc/Oim4DgS3UxAvPSe5BEncn87KDA719
	 8j2jJ4wjs62Ww79daOY2P7TrFaemCYKSOj+JFC1U=
Date: Thu, 19 Mar 2026 07:15:33 -0700
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1069297/000000-5c3408@github.com>
Subject: [bluez/bluez] 5c3408: shared/shell: Fix crash on bluetoothctl command
 co...
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

  Branch: refs/heads/1069297
  Home:   https://github.com/bluez/bluez
  Commit: 5c340857c7e14c9ed7c9bd020425de9eefa88843
      https://github.com/bluez/bluez/commit/5c340857c7e14c9ed7c9bd020425de9eefa88843
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-03-19 (Thu, 19 Mar 2026)

  Changed paths:
    M src/shared/shell.c

  Log Message:
  -----------
  shared/shell: Fix crash on bluetoothctl command completion

Don't try to complete empty commands, leading to invalid reads and
crashes.

==1430873== Invalid read of size 1
==1430873==    at 0x484BC77: strcmp (vg_replace_strmem.c:941)
==1430873==    by 0x435063: menu_completion (shell.c:1126)
==1430873==    by 0x4352F0: shell_completion (shell.c:1177)
==1430873==    by 0x4A2542B: gen_completion_matches (complete.c:1282)
==1430873==    by 0x4A2E9CD: rl_complete_internal (complete.c:2104)
==1430873==    by 0x4A257C2: _rl_dispatch_subseq (readline.c:944)
==1430873==    by 0x4A26ADF: readline_internal_char (readline.c:693)
==1430873==    by 0x4A46CE4: rl_callback_read_char (callback.c:275)
==1430873==    by 0x435E54: bt_shell_input_line (shell.c:309)
==1430873==    by 0x436A34: watch_callback (io-glib.c:173)
==1430873==    by 0x490A322: g_main_dispatch (gmain.c:3565)
==1430873==    by 0x490A322: g_main_context_dispatch_unlocked.lto_priv.0 (gmain.c:4425)
==1430873==    by 0x4913277: g_main_context_iterate_unlocked.isra.0 (gmain.c:4490)
==1430873==  Address 0x0 is not stack'd, malloc'd or (recently) free'd

==1516885==    at 0x484A126: rindex (vg_replace_strmem.c:216)
==1516885==    by 0x4353AA: submenu_completion (shell.c:1153)
==1516885==    by 0x4353AA: shell_completion (shell.c:1187)
==1516885==    by 0x4A2542B: gen_completion_matches (complete.c:1282)
==1516885==    by 0x4A2E9CD: rl_complete_internal (complete.c:2104)
==1516885==    by 0x4A257C2: _rl_dispatch_subseq (readline.c:944)
==1516885==    by 0x4A26ADF: readline_internal_char (readline.c:693)
==1516885==    by 0x4A46CE4: rl_callback_read_char (callback.c:275)
==1516885==    by 0x435E94: bt_shell_input_line (shell.c:309)
==1516885==    by 0x436A74: watch_callback (io-glib.c:173)
==1516885==    by 0x490A322: g_main_dispatch (gmain.c:3565)
==1516885==    by 0x490A322: g_main_context_dispatch_unlocked.lto_priv.0 (gmain.c:4425)
==1516885==    by 0x4913277: g_main_context_iterate_unlocked.isra.0 (gmain.c:4490)
==1516885==    by 0x491351E: g_main_loop_run (gmain.c:4695)
==1516885==  Address 0x0 is not stack'd, malloc'd or (recently) free'd

Reported-by: Wouter <wouter@xesxen.nl>



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
