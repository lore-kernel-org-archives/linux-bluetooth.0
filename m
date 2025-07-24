Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A070C23F431
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Jul 2025 09:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753349563; cv=none; b=f+ccZiI+JqQ2kol3gF9y6Vis8AWDslIyOt8sSFAwGBZF44dNIGfvhaGWDt4yTFWdB8iwM8tyqPqSBz0jtM34tbiYQDGAY+Yks9PpsurcYG4Hi/i+JG0F+LFR5iH5NOCPwqIJebEcUVMSAn2o3JyVs2JoMoth0u7UoA9mI1w8nys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753349563; c=relaxed/simple;
	bh=pDmxqXkgtT077gBGUWCuGFnsjfQ7B4vJdQKb1n8lMm0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=av9rvuZhU6LHaeG1/eXjbu4nFzCZWepr+UWv8wd9mBgOm7XBvDJJtjslsk/eYm4LVjaFgPUKhKcOlFUYrbQz1eUPq+q+ETSAISu3TmwZ8W5mUDQvBeWIWx009CYT8QHqLliwIjnyu23H3gtpuU1bQcMMZ4AQhmOhmL0mY0He1LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-87c0915ba7dso46100339f.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Jul 2025 02:32:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753349561; x=1753954361;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MnLt7OL5FV5Gnqj6M/9QGNu9DnfrjRfhT5iMthmB2UU=;
        b=s6QhIWXtwy/12dfOFCWC0O0ILaGGnHWAgZOdZWcfNWowMv4JDz7917MNzF+aHw8yj5
         JKrB5RtcVmAKi8JGiF/XNx2cRdTcYcc86BhZqi4P9WZRRXWl+Z7mDSUVMqrW+dCZmPdQ
         qrfODJSlR6b0+aH91mMLuAqQayEBrj89GJHx+7kcr25WR0R/P9lghJ9BscD1wxvEv7g1
         pMElE+S5mHzOCp7H8u/t0i5LeH3zwtNYbe64J4YwY02Gl87mNXiEF2+Mc5QxW6E8rKP/
         anqoaLKaIDnP1GkhenWaqorf7FXtnz4pnot9b0GKNhN5UV2Rg/L2Agq6XBj0QVl18k8M
         QGNQ==
X-Gm-Message-State: AOJu0YyVmzu6Yn12SplJrsE5eNWkipRN/+0Neke3zA1SMXJTWLb3iMZa
	cxuGIWqw9Bn1qJJnjnGJDGCcRN38ViRfWCK2OPy/46xHAmwRVksHQ9r/TjPRMOGNkJ8IKatKvZU
	6BT7V/8EDi3UwFhkU5q34eKKG35kK2lBQC4ybWtEeCHCeMLIJ2OU5mWvkKtU=
X-Google-Smtp-Source: AGHT+IHYlaxdRTp97vlTVOLPj4bENCS9v3pmbcFIG51NoHWmxkI/XgOTVCjdtyx0GNY+IiSwG/pdU3BaO6Bpuuj66sJYTLElBXoD
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:14d2:b0:861:6f49:626 with SMTP id
 ca18e2360f4ac-87c64f937b3mr1253977039f.6.1753349560831; Thu, 24 Jul 2025
 02:32:40 -0700 (PDT)
Date: Thu, 24 Jul 2025 02:32:40 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6881fdb8.a00a0220.2f88df.001a.GAE@google.com>
Subject: [syzbot] Monthly bluetooth report (Jul 2025)
From: syzbot <syzbot+list4602750c76f9f394cfea@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello bluetooth maintainers/developers,

This is a 31-day syzbot report for the bluetooth subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bluetooth

During the period, 4 new issues were detected and 0 were fixed.
In total, 44 issues are still open and 83 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  41759   Yes   KASAN: slab-use-after-free Read in l2cap_unregister_user
                   https://syzkaller.appspot.com/bug?extid=14b6d57fb728e27ce23c
<2>  7143    Yes   WARNING in call_timer_fn
                   https://syzkaller.appspot.com/bug?extid=6fb78d577e89e69602f9
<3>  3022    Yes   general protection fault in lock_sock_nested
                   https://syzkaller.appspot.com/bug?extid=d3ccfb78a0dc16ffebe3
<4>  1093    Yes   general protection fault in h5_recv
                   https://syzkaller.appspot.com/bug?extid=b5691bb559396b262064
<5>  578     Yes   general protection fault in bcsp_recv
                   https://syzkaller.appspot.com/bug?extid=4ed6852d4da4606c93da
<6>  570     Yes   WARNING in hci_conn_timeout (2)
                   https://syzkaller.appspot.com/bug?extid=fc4b5b2477d4ca272907
<7>  363     Yes   KASAN: slab-use-after-free Read in force_devcd_write
                   https://syzkaller.appspot.com/bug?extid=bc71245e56f06e3127b7
<8>  314     Yes   WARNING: ODEBUG bug in hci_release_dev (2)
                   https://syzkaller.appspot.com/bug?extid=b170dbf55520ebf5969a
<9>  282     No    WARNING in l2cap_chan_del
                   https://syzkaller.appspot.com/bug?extid=3272785b7a1fc9b510f6
<10> 206     Yes   possible deadlock in l2cap_conn_del
                   https://syzkaller.appspot.com/bug?extid=b71bb48c13bf3fed3692

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
