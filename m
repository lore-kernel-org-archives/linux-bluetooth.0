Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E482B20B1F7
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Apr 2025 10:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745316696; cv=none; b=tQodBEUvSfOe6XIJytSgwYE1nkZSgNH4Mwm8hl+GAz4FBvvYqPJ1ji8xZyqOOthXex+uWH5bhZ6k+vt4IJDIS63rHE//gGkzqmOJrwp0Xcwo3o0nUXo//31aY++42P4bUkFs5Vg3OoCKVmIq+YyoF2O/ubPUSCWR575y7VlNErA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745316696; c=relaxed/simple;
	bh=KTWw2A2W5r7XIE7yNUuzgC4l1Uy5bt01OYJWw/4U4SA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=MvW8LnAcToI3Aj8bvUWNGQ+xtTJ9FzNRKEG9DQfecaFHMLvj3MRrm0Di6mfrbd4fi9dF0mqDNZgkZ2CZMQ4d47B/E6HGLqRoAPB+Wpu6RrxzOKyIRSZSGeeiAHHxjzMDWhVgoNdHP8Tvx1gpJRfUslcR6lKJZLXzAHftDLENCyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3d5b38276deso84291675ab.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Apr 2025 03:11:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745316694; x=1745921494;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qXwWJHvyf5rrUrVosJUo/obcxzIJOyen+c/SsGAvCfM=;
        b=If/lgbBIsvALEjdiXsyoafJ7xD+eKBkhqSHexsOGqXCwAaMRsJ9DQg2t2QbvqfTfGj
         /q631KGMZemDoSRVH4bqLX/P134VXbmm6PMAqK8wvHlmhpgNIS2zkqsk2XpxLCixgraM
         UOMiT3zhkiH7ztXElwUCFGTbLghu78q7PJsvek7O4adqaInDh/VjrQWpcZVmiuOvYDHI
         pIY3CdWIDkfz7lXGq5YwClGY8orJJpAsY3o/xWlmL74qeyObHkPNxe3Q/BkJx7zbeqcW
         75gNc+SQsqMxD1/seJwrpqEs/Mhw0iMfQwvKzhC4vBvmegyBJiRKr1QBneJcLm1wWVXl
         VIjg==
X-Gm-Message-State: AOJu0Yw6KC19e/fQw5qbZ5NGwTBzB7xJ/4O7qPBG8+kbPWi9/nMwGW+f
	ZViWYCl926GB2BrSJMCil5wnCVRDot6+lNnl4BOJjlTw3S2CNEZ3odvADKYFH+aquIFN7NJJdgw
	OS5QOVYe3wFHmWMzVnnFftiRGCsKpVI/Ap0mQEZeJDwHHUQ4jc5j2J94=
X-Google-Smtp-Source: AGHT+IFdNZfRtpoJ6sqN95w/HZYWx5B3VCO9ZfcceQXYX5W2MnWsdfZ0gje5KvSlJjSLuGujxY1Yw9adOWR2Q8JgcRGr/RfCqvvf
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2785:b0:3d8:1e96:1f0 with SMTP id
 e9e14a558f8ab-3d88ee6540amr156709575ab.20.1745316693994; Tue, 22 Apr 2025
 03:11:33 -0700 (PDT)
Date: Tue, 22 Apr 2025 03:11:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68076b55.050a0220.8500a.0004.GAE@google.com>
Subject: [syzbot] Monthly bluetooth report (Apr 2025)
From: syzbot <syzbot+list87f1666b0fff7a351cea@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello bluetooth maintainers/developers,

This is a 31-day syzbot report for the bluetooth subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bluetooth

During the period, 1 new issues were detected and 0 were fixed.
In total, 53 issues are still open and 82 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  35675   Yes   KASAN: slab-use-after-free Read in l2cap_unregister_user
                   https://syzkaller.appspot.com/bug?extid=14b6d57fb728e27ce23c
<2>  6521    Yes   WARNING in call_timer_fn
                   https://syzkaller.appspot.com/bug?extid=6fb78d577e89e69602f9
<3>  1876    Yes   general protection fault in lock_sock_nested
                   https://syzkaller.appspot.com/bug?extid=d3ccfb78a0dc16ffebe3
<4>  382     Yes   WARNING in hci_conn_timeout (2)
                   https://syzkaller.appspot.com/bug?extid=fc4b5b2477d4ca272907
<5>  359     Yes   KASAN: vmalloc-out-of-bounds Read in hci_devcd_dump
                   https://syzkaller.appspot.com/bug?extid=ac3c79181f6aecc5120c
<6>  334     Yes   KASAN: slab-use-after-free Read in force_devcd_write
                   https://syzkaller.appspot.com/bug?extid=bc71245e56f06e3127b7
<7>  228     Yes   WARNING: ODEBUG bug in hci_release_dev (2)
                   https://syzkaller.appspot.com/bug?extid=b170dbf55520ebf5969a
<8>  224     Yes   general protection fault in h5_recv
                   https://syzkaller.appspot.com/bug?extid=b5691bb559396b262064
<9>  199     No    WARNING in l2cap_chan_del
                   https://syzkaller.appspot.com/bug?extid=3272785b7a1fc9b510f6
<10> 166     Yes   general protection fault in bcsp_recv
                   https://syzkaller.appspot.com/bug?extid=4ed6852d4da4606c93da

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
