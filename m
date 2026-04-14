Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8421C313550
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2026 19:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776196470; cv=none; b=s5TUI3qopRnSrZ3xzq7jZ0I54agbGwPafWg/HztmJAm8KaebmYJs7z1wsm+x3gb0Ifu8VRIBHjoBa5a825t8JQL3kXfSo7U3W46UP4QZwkeInXQUoPyGRfAkV+xtEfsyRp9nO9b4xYgdscHweVlhumbI3WM0QsP2qxX1atZDJ2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776196470; c=relaxed/simple;
	bh=dw/5gSF8bubFaFU4ixzMuurlbbctbD/I7qTMSkDYFhc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=WaGzoSkXbwvDBKQATjwk7pY1okk1ltSAPapw1c2kwaphmn20VT6ZHXLbFhyub7wH0IBwhagQPxN9SRLLiDd+zVLSPOdLnjqyonLyIvzXoJ/3SzVEbezlsi+C9zjW/Oo/jPEHyo27cai0c0YglA10oO5jmn64CR2TUYz64MrNr1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=NEK9nIcy; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="NEK9nIcy"
Received: from github.com (hubbernetes-node-607a941.ash1-iad.github.net [10.56.128.71])
	by smtp.github.com (Postfix) with ESMTPA id AA2F1C12C7
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2026 12:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1776196468;
	bh=QvOGWbFi6uRQAxAgqrWYxm7RHaLhTckRipWtW9wAAV4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=NEK9nIcyLKn2jIrxQ37rNB6LBXbulu9gBNymMK4obTaA5K/gV66JUdXYbvHEkJc8C
	 Kq1FqlXoLS8NdrysNQ+htMkxPqUxwPQbuvpHm1f/KLSJTTt/vsZCWNFU8JQQUo3ipI
	 EfMGyraRHVeVSIeDWfhJlxCA0QQKUIWqCS1rS5z8=
Date: Tue, 14 Apr 2026 12:54:28 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1081265/000000-25ba1c@github.com>
Subject: [bluez/bluez] 25ba1c: bass: Fix crashing on BT_BASS_MOD_SRC
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

  Branch: refs/heads/1081265
  Home:   https://github.com/bluez/bluez
  Commit: 25ba1cc75a26b4d4c780c2c3423942a9766c0932
      https://github.com/bluez/bluez/commit/25ba1cc75a26b4d4c780c2c3423942a9766c0932
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-04-14 (Tue, 14 Apr 2026)

  Changed paths:
    M profiles/audio/bass.c

  Log Message:
  -----------
  bass: Fix crashing on BT_BASS_MOD_SRC

If assistant attempt o modify source the code would attempt to iterate
over all valid range of BIS indexes which may lead to the following
trace since the delegator maybe freed in the process:

 #0  queue_find (queue=<optimized out>, function=function@entry=0x58b8761109c0 <setup_match_bis>, match_data=match_data@entry=0x3) at src/shared/queue.c:230
 #1  0x000058b8761127fb in bass_update_bis_sync (bcast_src=<optimized out>, dg=<optimized out>) at profiles/audio/bass.c:1824
 #2  handle_mod_src_req (data=<optimized out>, params=<optimized out>, bcast_src=0x58b894661be0) at profiles/audio/bass.c:1862
 #3  cp_handler (bcast_src=0x58b894661be0, op=<optimized out>, params=<optimized out>, user_data=<optimized out>) at profiles/audio/bass.c:1910
 #4  0x000058b8761bc978 in bass_handle_mod_src_op (bass=<optimized out>, attrib=<optimized out>, opcode=<optimized out>, id=<optimized out>, iov=<optimized out>, att=<optimized out>)
    at src/shared/bass.c:1069

To fix the code will now just interate at existing setups checking if
they match the BIS index then adding/removing the stream so it is no
longer possible to free the delegator before all setups are processed.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
