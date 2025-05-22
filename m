Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85D128A70A
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 May 2025 12:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747918710; cv=none; b=c2AYc9UXZM4hpAnjvY5fj9TWhdJAyF5u03t0ADibtjON9bRx5KNtTRXokB89v2y717KqpOwnQc28icjkE4KvGSInmi91iRqm1lYfR48bPoBzcjOLGfi4bp3/O8+ffBdVN+j7i9eLFLTWeCNYPniJoT7mXmSOGEq52L3U9rUW8v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747918710; c=relaxed/simple;
	bh=UDczc3FisTkVeRDDzqDOpcVpYiRhEazsS1cFvyXtad4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=GmXNKR0cL2RvVt89jvQUZHZ2I9fkpUoPUjsa7tr5UTUxaCL/CpGzLitePCywM94lQtKI3a5n8/BVFcA/u/j3l3dS22ugj6N4RjQvvSHbJg3rAOS8Fim/yPDXvZ20EUCXs2tpZJq9GCQZdnhw/NgD8HjUOwPk9dSfBHZAlMrJUHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3dc8ab0ac67so20949735ab.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 May 2025 05:58:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747918708; x=1748523508;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=evFQw6Ly28nLSPr8OHYJcRMP6jYsr4DR4nvjV9TG/KA=;
        b=L46f++qP7IknpMq+MnTykVS8AzmOrVCzCWaKaD2hBbAZ5ZKT/Fl48tJKH8N93am8so
         f7g0bed9wSYv3wV1dWBo8UzpyUYDyzSZFy0GwaBJydc2XigDK4w+1PgzAc6EOHdjC3zh
         t5C4iI8bzp1d7Sv4C7fB1a7hvZwrNtcq7oBkDfVM2z4MaW3w6bfS/BemdKBMnppu6gYD
         Jj//1Iax6RwJfhu6sTVT7W3Q8543+F6MDh2Gzq7a3KVFXFHJSnZjdceMtyr3ejLWudw5
         nkI2/4I6ZPckZMo/fhVCmzWNML4lZ09tQI00g5eAU0BAsWpg6A8Mm4iw9Tfol3joR+k9
         zLxQ==
X-Gm-Message-State: AOJu0YwbIGs8NpoYZZHWDtKbDqfl6w9x+wcCydp5hhSfMTgLUQtxEvlM
	I2/cHTI+T/W1vlOis4+RsOADZ9IU4xM4vvv3RwsigsoAYwpTOcovuUrnQeNkP9CSsZz31dtcyGR
	r9hfwLFf4nlT8+7cICtxkJa5mDTaRtpvwG0oevYP4ZR2mz9+ix7Tn3pT4m4k=
X-Google-Smtp-Source: AGHT+IHJpKTNdTBFFSf8GIPQKvpRt+Fclj8eCecvR0dijP9DBJg4xB617rRg96Ja0wUShpDZuUsfdPJMisn/af7Tkn+adWMAkBqq
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:184c:b0:3db:754c:63b with SMTP id
 e9e14a558f8ab-3db842de1b9mr296437205ab.12.1747918707767; Thu, 22 May 2025
 05:58:27 -0700 (PDT)
Date: Thu, 22 May 2025 05:58:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <682f1f73.a00a0220.2a3337.0019.GAE@google.com>
Subject: [syzbot] Monthly bluetooth report (May 2025)
From: syzbot <syzbot+list28053b3b886a5c3dd091@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello bluetooth maintainers/developers,

This is a 31-day syzbot report for the bluetooth subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bluetooth

During the period, 5 new issues were detected and 1 were fixed.
In total, 52 issues are still open and 83 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  37884   Yes   KASAN: slab-use-after-free Read in l2cap_unregister_user
                   https://syzkaller.appspot.com/bug?extid=14b6d57fb728e27ce23c
<2>  6736    Yes   WARNING in call_timer_fn
                   https://syzkaller.appspot.com/bug?extid=6fb78d577e89e69602f9
<3>  2362    Yes   general protection fault in lock_sock_nested
                   https://syzkaller.appspot.com/bug?extid=d3ccfb78a0dc16ffebe3
<4>  682     Yes   KASAN: vmalloc-out-of-bounds Read in hci_devcd_dump
                   https://syzkaller.appspot.com/bug?extid=ac3c79181f6aecc5120c
<5>  443     Yes   WARNING in hci_conn_timeout (2)
                   https://syzkaller.appspot.com/bug?extid=fc4b5b2477d4ca272907
<6>  399     Yes   general protection fault in h5_recv
                   https://syzkaller.appspot.com/bug?extid=b5691bb559396b262064
<7>  347     Yes   KASAN: slab-use-after-free Read in force_devcd_write
                   https://syzkaller.appspot.com/bug?extid=bc71245e56f06e3127b7
<8>  278     Yes   general protection fault in bcsp_recv
                   https://syzkaller.appspot.com/bug?extid=4ed6852d4da4606c93da
<9>  249     Yes   WARNING: ODEBUG bug in hci_release_dev (2)
                   https://syzkaller.appspot.com/bug?extid=b170dbf55520ebf5969a
<10> 220     No    WARNING in l2cap_chan_del
                   https://syzkaller.appspot.com/bug?extid=3272785b7a1fc9b510f6

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
