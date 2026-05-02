Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6461B7DA66
	for <linux-bluetooth@vger.kernel.org>; Sat,  2 May 2026 12:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777725154; cv=none; b=u7AfXTivAIpEsLrRwVpZIDnIBH3mKkQwFLJc/ceDiMXm8de0dFf0HqdatHjhBOPHKDwCc3aV+nE384TXKYPQ36zePffnCibn7VtIJNMEwaejRTWyjfofQmnMwKafghwQnVCLG5M0r9covRVk+fd5OhLLDs7lcMx6954XldN2tcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777725154; c=relaxed/simple;
	bh=0jfR+1k3Knx6XJD1jgMvA62/++1KYKzWV9sRrSG2ZfM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qjmvuj7hblOXQAL2959fTj54WN2YSm4GRVVSqDQ18ulQZpyxUepD6PTqfjmM9Er9oX9bDk/kAPEllRPqjVhXP1ynlxjnwe7QuIII4X0WVbXbpjGJ5dIELf0deHX2RD/TDzUrvg+JtTx1LKxp4+l2Kl75Asv6T1pJjPjbSAYw4qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7dbbb806e10so6861790a34.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 02 May 2026 05:32:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777725152; x=1778329952;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LjCrP+M7oDEI7gxbbCXHvhY7RQ53BoiinsESowl10Z0=;
        b=g/ZZ93D/rGcwEQe36JoQ8aLOmTprAvDjiw5m//ONc5VoO7EySkKr/VdHJMO7pRSzJ5
         CDXUlxmQQs0fuO5j3HS2nVG44S3rb8R0tGqHnQe575h3HWSvkoZpLiA/k+I1Xy9KYpYo
         UexxjJa5dO+4hdObDhFF2HTtxve1yNuLMXSQCk+GcaxZC4Sd5xmUbBRvhmfsn4enajzB
         bchT+br8nTGJ4QNfFDXNyHrgjx/ulwLuAsKwGU+zVo6e4yLeHKRF8oxgHkvaOWhdDhFZ
         yWiLq4uFkbCk91GleuyzRxZItfl9QUtWD1SU9v5+53ILuB7FR7scsBDnYeZYCe1KGYzB
         9YvA==
X-Gm-Message-State: AOJu0YyyTNWqPJ/JD6TfQzDFofiK1hDRfC7088CfS96U7IdFT+smaiM7
	3RxucHYEX1dr/kh0MYg1KOXD94pGKA04FczuLq9YDwGLAuuyDbzHaW53aszBQHrGTp4+WnSiqQM
	Ovh80G85qYdlOX3l2if0lgDABvG+vrfnhI8Dbk8fE56TSFwoaTZQlnpNehVQ=
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:188e:b0:688:b73c:c41b with SMTP id
 006d021491bc7-69697db76eemr1397181eaf.49.1777725152467; Sat, 02 May 2026
 05:32:32 -0700 (PDT)
Date: Sat, 02 May 2026 05:32:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69f5eee0.050a0220.3cbe47.0018.GAE@google.com>
Subject: [syzbot] Monthly bluetooth report (May 2026)
From: syzbot <syzbot+listb0a6e8aa16ebe343b69f@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello bluetooth maintainers/developers,

This is a 31-day syzbot report for the bluetooth subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bluetooth

During the period, 3 new issues were detected and 0 were fixed.
In total, 32 issues are still open and 101 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  13915   Yes   WARNING in hci_conn_timeout (2)
                   https://syzkaller.appspot.com/bug?extid=fc4b5b2477d4ca272907
<2>  8770    Yes   WARNING in call_timer_fn
                   https://syzkaller.appspot.com/bug?extid=6fb78d577e89e69602f9
<3>  4488    Yes   general protection fault in lock_sock_nested
                   https://syzkaller.appspot.com/bug?extid=d3ccfb78a0dc16ffebe3
<4>  1766    No    KASAN: vmalloc-out-of-bounds Read in kcov_remote_start
                   https://syzkaller.appspot.com/bug?extid=8a173e13208949931dc7
<5>  524     Yes   WARNING: ODEBUG bug in hci_release_dev (2)
                   https://syzkaller.appspot.com/bug?extid=b170dbf55520ebf5969a
<6>  358     No    WARNING in l2cap_chan_del
                   https://syzkaller.appspot.com/bug?extid=3272785b7a1fc9b510f6
<7>  295     Yes   KASAN: wild-memory-access Read in l2cap_connect_cfm
                   https://syzkaller.appspot.com/bug?extid=0e4ebcc970728e056324
<8>  217     Yes   WARNING in hci_recv_frame
                   https://syzkaller.appspot.com/bug?extid=3e07a461b836821ff70e
<9>  163     Yes   KASAN: slab-use-after-free Read in l2cap_sock_new_connection_cb
                   https://syzkaller.appspot.com/bug?extid=cdae834448ec8c3602fe
<10> 135     Yes   KASAN: slab-use-after-free Read in bt_accept_unlink
                   https://syzkaller.appspot.com/bug?extid=a1595e656a83ea5b78eb

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
