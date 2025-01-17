Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DA01FC7FF
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jan 2025 10:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737110130; cv=none; b=nRcmGKIgxNP8+Qs/nTlZLxMZUAd8tYlYmg+hLCWBddNbV6R4SmD+oSaEXkUVQBgccMNXXd5WdKVsV+s+jPSLRavXYqCPw6Dv2bsiLv4TtNgs6vhS+6u1TnRBujFy1V/Scd0BQJ/Sl0LDDKWYanjP7ggGd3bVwPn5XNiaZemaFl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737110130; c=relaxed/simple;
	bh=256OK/zuauA3UPRT7RFtg4dj9bx7AUVPln9KovLvbig=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=UdWfNnk6Mt1GAlQUA4nBPzyN5iN1kSBR0HX0afe7kKii6ABC56lrKi4EcezblMLFH6iG090XqOGfhzUbZu/eMDXG/soZne9chzPQHjsvprWmg6DbZdEu4sO94oBEwnN5dZg/BH6nbntuit1GfhPhPkA2XJuE6LI2hEIlZPSiEfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3ce7b6225aeso30920265ab.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jan 2025 02:35:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737110127; x=1737714927;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zN7mic3nP/PDKtAd8QSR3x4fqqVKdg6cGKb/nuyB4MI=;
        b=s2DF9hrbt95eYFlEFmjLzJy4mC4Sxsqm4alZvt8HYrgIq5e9tYcnDeXYhiXR7E0fnB
         458lo1gmdl7rk81jvlNNnHSm2rdcEAaIpWwkyxrMy8sXOLEjHrSxe7Vvcx3PWHebzMd1
         axZ/otfT45ngGoENQsBEm0ts4r9d2fxMWr0mJITg8pKb2VJoFPDigrLsdhl7D5Jg6kYB
         lcnJDSatvKIN0VPQTi6Z1/Rz2HbK2rmRb2zdeyKC9jK8lV9XRPCjs7bh9TTlyksGoPwE
         9eGZT1J3/yGQHTx9urOsCtc8SQKIv8qd8UJn6BjOZ0+aIzkf4jXOp/ZHa5Mat2sPTgxK
         SSXQ==
X-Gm-Message-State: AOJu0YznVw41IXY04lfIGBB7+ZHnuJa3v/Ee/iFT0X/zDoQmzhL4HbEu
	kT7xtj9AppB3hqm+J0pYWF/Tm82XXkyCVn6cgEoYuzZUJ1IJJILCHBTE/ymMIvZwcxPmJaooUVY
	+oJR2f1xiUKTT1F5hgjVcT6YTkRtNDtDV8ILvrKIgbgAd4I/CGkQRv38=
X-Google-Smtp-Source: AGHT+IEhVbrD0Uhe5gMLh+O+t5czDEwf0ZudnSU1qM3ELa7U3A8NzBahNzZRQRvtE+k6VSbJftrjqYyvc/kK5sF/OIg7gk9GvBrO
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca47:0:b0:3ce:867c:f51b with SMTP id
 e9e14a558f8ab-3cf7447e655mr13737545ab.14.1737110127813; Fri, 17 Jan 2025
 02:35:27 -0800 (PST)
Date: Fri, 17 Jan 2025 02:35:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <678a326f.050a0220.20d369.0059.GAE@google.com>
Subject: [syzbot] Monthly bluetooth report (Jan 2025)
From: syzbot <syzbot+list6386fc8218378445ebcd@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello bluetooth maintainers/developers,

This is a 31-day syzbot report for the bluetooth subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bluetooth

During the period, 10 new issues were detected and 0 were fixed.
In total, 59 issues are still open and 75 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  22244   Yes   KASAN: slab-use-after-free Read in l2cap_unregister_user
                   https://syzkaller.appspot.com/bug?extid=14b6d57fb728e27ce23c
<2>  5541    Yes   WARNING in call_timer_fn
                   https://syzkaller.appspot.com/bug?extid=6fb78d577e89e69602f9
<3>  719     Yes   general protection fault in lock_sock_nested
                   https://syzkaller.appspot.com/bug?extid=d3ccfb78a0dc16ffebe3
<4>  698     Yes   general protection fault in skb_release_data (2)
                   https://syzkaller.appspot.com/bug?extid=ccfa5775bc1bda21ddd1
<5>  157     Yes   WARNING in hci_conn_timeout (2)
                   https://syzkaller.appspot.com/bug?extid=fc4b5b2477d4ca272907
<6>  129     Yes   WARNING: ODEBUG bug in hci_release_dev (2)
                   https://syzkaller.appspot.com/bug?extid=b170dbf55520ebf5969a
<7>  110     Yes   KASAN: slab-use-after-free Read in force_devcd_write
                   https://syzkaller.appspot.com/bug?extid=bc71245e56f06e3127b7
<8>  106     No    WARNING in l2cap_chan_del
                   https://syzkaller.appspot.com/bug?extid=3272785b7a1fc9b510f6
<9>  105     Yes   BUG: sleeping function called from invalid context in lock_sock_nested (3)
                   https://syzkaller.appspot.com/bug?extid=55cd5225f71c5cff7f6f
<10> 63      No    KASAN: slab-use-after-free Read in skb_queue_purge_reason (2)
                   https://syzkaller.appspot.com/bug?extid=683f8cb11b94b1824c77

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
