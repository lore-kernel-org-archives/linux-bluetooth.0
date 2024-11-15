Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD69F1CEE92
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 Nov 2024 14:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731681691; cv=none; b=kSxApr4A4E9iNdcEzbenDO8BHpD6cYfmfI0XRF9GdFOcrcHNTx6GXi6AUmfTU2fyLO85WdQnuJH+I91v7274gRfjM1oCcecraYTznpoMYaBkr4oSq8zoebH0fgyuqR4Twh2Pab/22XhE3ThwPGZCqSyJB7WsgVIHOVBljTce/7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731681691; c=relaxed/simple;
	bh=TvfAFGSsHmqIZByRKIp5Su5P4ciacTcybzgpExC/o/s=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=EMk/NriTGz4ayLDEHsoRkd+5O9Jk9aVavOHdYNlC6I3kI3pvSiLKs0OmIz1OJcC+koTgTU2UHcgNjg5W/N85k9YRGS7RfMI/a/TIMAf8sarBiJ3oWsuXEmGkEPUUWx2a43WcWueHpROP8GfvdXR9f0ZyvG1bkC+mTeme3bj0jHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a6b7974696so21330855ab.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Nov 2024 06:41:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731681689; x=1732286489;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uJQdBFgI5sJta5zrwY7MqKRjkyY24HYi+MEoJE1gW0A=;
        b=nwxMP6AW6HBxfQu6nkss22FfcfrFyweAeDcYgqMUdRh3O0A7UaMTtK2BrC29YAUdjl
         OVxzmzFbsldd4Vyidkkk07Muc3FOaMaxk51lO5OSYZ2N1Iv66zXj0vqfCkRXnFffH5a9
         jm4aGGR7+Zwx1mre6cf/FkYlE4sh3v5bnhBOKX7VmJi1xylsJ3Uxbl8IuhDHtn7QoQs6
         LH4kTHSL1aFqSD7Qa5L/GTU1ebs/MI9CcE8NRL3gA3f4Kj8DMZC5NLDIrRTnPRLCkBow
         EXUO+LUJzN9KSLJXYf9uKAXTb7LlHBlSHfzgSfPBLwGm8GuKAKWxpv/FtVWmSZmWh2l4
         DVug==
X-Gm-Message-State: AOJu0YybzynJQVoFTdtWJVdvXtnK6PX7HOa9s7UJV6ybh44/1vpPzjjO
	O2dhjC5FdhlScwSYIkflVK6ofAsm7KTbTRMH1igOHaDV/AZ7D/I6guzt/gDgSVu2Jv9thTsOc6T
	U14/Y10PXhNQPkTJe4SbnTKvP4PsWTZ5YVGVjcXaL/Iph7eJQyef7IFM=
X-Google-Smtp-Source: AGHT+IF+BwSfWGlw5VRacUhCrNIruqTUZNyQkcZ1dfBEACe6DCBAL4TM3xlxmBthlqiAd7wDqTEkNZTksWbPlj8jk3KQc7W0OFFO
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca06:0:b0:3a7:1b72:f36 with SMTP id
 e9e14a558f8ab-3a748088836mr28545775ab.21.1731681689035; Fri, 15 Nov 2024
 06:41:29 -0800 (PST)
Date: Fri, 15 Nov 2024 06:41:29 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67375d99.050a0220.bb738.0001.GAE@google.com>
Subject: [syzbot] Monthly bluetooth report (Nov 2024)
From: syzbot <syzbot+listb55ee1602b5d90b0989f@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello bluetooth maintainers/developers,

This is a 31-day syzbot report for the bluetooth subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bluetooth

During the period, 6 new issues were detected and 0 were fixed.
In total, 48 issues are still open and 72 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  695     Yes   general protection fault in skb_release_data (2)
                   https://syzkaller.appspot.com/bug?extid=ccfa5775bc1bda21ddd1
<2>  452     Yes   general protection fault in lock_sock_nested
                   https://syzkaller.appspot.com/bug?extid=d3ccfb78a0dc16ffebe3
<3>  346     Yes   BUG: sleeping function called from invalid context in hci_le_create_big_complete_evt
                   https://syzkaller.appspot.com/bug?extid=2fb0835e0c9cefc34614
<4>  141     Yes   KASAN: slab-use-after-free Read in set_powered_sync
                   https://syzkaller.appspot.com/bug?extid=03d6270b6425df1605bf
<5>  76      Yes   BUG: sleeping function called from invalid context in lock_sock_nested (3)
                   https://syzkaller.appspot.com/bug?extid=55cd5225f71c5cff7f6f
<6>  52      Yes   WARNING: ODEBUG bug in put_device
                   https://syzkaller.appspot.com/bug?extid=a9290936c6e87b3dc3c2
<7>  50      No    KASAN: slab-use-after-free Read in skb_queue_purge_reason (2)
                   https://syzkaller.appspot.com/bug?extid=683f8cb11b94b1824c77
<8>  42      No    WARNING in l2cap_chan_del
                   https://syzkaller.appspot.com/bug?extid=3272785b7a1fc9b510f6
<9>  33      Yes   possible deadlock in mgmt_set_connectable_complete
                   https://syzkaller.appspot.com/bug?extid=b1752fcfa8658bb8984a
<10> 9       Yes   general protection fault in l2cap_chan_timeout (3)
                   https://syzkaller.appspot.com/bug?extid=f0908ddc8b64b86e81f2

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
