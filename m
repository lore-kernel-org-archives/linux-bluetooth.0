Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9C71B81B
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 Mar 2024 22:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709762910; cv=none; b=V3CDY62isOMyyzx8yjTYXm8bOMpZgIqEmRBK10OnHzLOnvR31012DFH4OzBZlUjOKzEWx7mpjZjK9fY0Rx22E1/UqRmSa/63d70msY8LV27LK/zOwBSqulAEL4kn03C1jICwVcAFzMstVetAqm1Rf/0A0dtZco4MqX57BN8WxgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709762910; c=relaxed/simple;
	bh=dNOqznjn5ybCeBNvEHvHzB1UiUrXUN/Sx+WiTzgXgAQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=f5LovwXB/5ks/3rBHQzET5bHCMxHvX9zBUbj2NrOd6LiA7eRqtRg9lF0vSfzpWFNl8SHdYguK9BKx4XjsYEAK6MQ56FSSubXBl9WsZs+a1TdqXSwkrjGQI226JXpD6BnAN1eavPgcoTM/eIDjtdwSD7Wi6eDMs7O1oHWUWUreMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7c84ad0cc57so29098039f.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 Mar 2024 14:08:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709762908; x=1710367708;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MPu8pxVqA/GG5U4nME77kZYjgEqZsNQoKccg4F1Fbto=;
        b=YHpBRwXfgavdU9ulxD3HadhAxjJSl+TalIAqyBaUczcwvvwHpvVhKxt1F3/3ivkmuB
         WsS+ODMRFwPolmUqkq7GfNwB+b/pqwbykuqjo1c84SWMMWPm7VvkQNDm6EUV/9I8DmZu
         La2zBj273TBOu6KCp/cLHV9bA/eCXsGMVuQYhRvcYcLcD1YorLjxAzPTfr5yZR1OEzvG
         9Ucq+07BfE66C8CSzuTIedV2orwJxAaeIorzWjj11Bp7Nx0t7ymNv2O5FQc/4tzCJoUF
         QQvV7TtnC7gyEbsz9LMDj5aO6sk6jgiM8sCaybB09l+BVlKwUvYWxdy9m6CmXK58c4jH
         WTFg==
X-Gm-Message-State: AOJu0YwJm8+2CZRYLbocw4Thn+R2HgKloXFE88AoKLwXXnirdauOEz2D
	Wik/TbQKzqbs4QvK4utC3K5lgAZMzSbFUD8wYXBcGVFqDyllGgl20s+FHbh973zr96Q5h3kDKwn
	u+PpwMbhp9E48Vc8W2HDbxfeLcF9cottTh+vHQ7ZoHeUVxiMscC+eHxHjfQ==
X-Google-Smtp-Source: AGHT+IFT54PwmYZVmKNdY/zZEIrOxYEj2j4cSTHIIWkUIsJC2vOOFniTTNhegl5L9CWatQyJEHqxOxVG3obWaC8kT3t3xHzCuCiF
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2b0d:b0:474:eb37:1f51 with SMTP id
 fm13-20020a0566382b0d00b00474eb371f51mr415581jab.2.1709762908565; Wed, 06 Mar
 2024 14:08:28 -0800 (PST)
Date: Wed, 06 Mar 2024 14:08:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d0c5a306130532ba@google.com>
Subject: [syzbot] Monthly bluetooth report (Mar 2024)
From: syzbot <syzbot+list13832dc108d3458e33cf@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello bluetooth maintainers/developers,

This is a 31-day syzbot report for the bluetooth subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bluetooth

During the period, 5 new issues were detected and 0 were fixed.
In total, 29 issues are still open and 60 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  17714   Yes   possible deadlock in rfcomm_sk_state_change
                   https://syzkaller.appspot.com/bug?extid=d7ce59b06b3eb14fd218
<2>  9531    Yes   possible deadlock in rfcomm_dlc_exists
                   https://syzkaller.appspot.com/bug?extid=b69a625d06e8ece26415
<3>  4920    Yes   WARNING in hci_conn_timeout
                   https://syzkaller.appspot.com/bug?extid=2446dd3cb07277388db6
<4>  3400    Yes   BUG: sleeping function called from invalid context in hci_cmd_sync_submit
                   https://syzkaller.appspot.com/bug?extid=e7be5be00de0c3c2d782
<5>  1369    Yes   WARNING in call_timer_fn
                   https://syzkaller.appspot.com/bug?extid=6fb78d577e89e69602f9
<6>  189     Yes   KASAN: slab-use-after-free Write in sco_sock_timeout
                   https://syzkaller.appspot.com/bug?extid=4c0d0c4cde787116d465
<7>  45      Yes   KASAN: slab-use-after-free Write in sco_conn_del
                   https://syzkaller.appspot.com/bug?extid=6b9277cad941daf126a2
<8>  22      Yes   KMSAN: uninit-value in eir_get_service_data
                   https://syzkaller.appspot.com/bug?extid=5e132fbe94a9ede456ad
<9>  3       No    possible deadlock in __flush_workqueue
                   https://syzkaller.appspot.com/bug?extid=da0a9c9721e36db712e8
<10> 2       No    KASAN: slab-use-after-free Read in l2cap_send_cmd
                   https://syzkaller.appspot.com/bug?extid=31c2f641b850a348a734

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
