Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F82D1FB1
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Sep 2025 12:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758717577; cv=none; b=ucRe4pEUACkxwjkOy6Yml9/npNoLQg4xXQ9rr+Zd9F4/vnxxI5kuB1eCyer3usDc1TWY0mLPLquV7gMftG5NFTEMQZMKuZnUIJumhJvM+/ObE6NpW31tGSRrREsqbG0VLoTovyc4uMPVbm1/jnyeHSZL9YEiz6S55kJ9KCAvQ3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758717577; c=relaxed/simple;
	bh=k3UC0+sDUty0bqHOXRgKqlQ4Wfe4JIgKWq6+jTjIefY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=QD40kf+f1ki/M2y2dv1JcSj8jBe32p/bOMfiZ5jWLQHhOnHDVpVQKAdv4HAmXXurHDaER6sKqJ2HNqxz4JfeQZmEmMwqPEJ6iLL+8YjJ2dKdQbOsYnQIvwQQ9MOUc4lTfP944T7liyhE3s6zJPvaBBs5nLSN6DnP1DFbLi87UlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-4257453b390so47201315ab.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Sep 2025 05:39:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758717575; x=1759322375;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KCBkAvciMIfhEXb9B02ZXA5Q7/R2bL631dgebWBIimU=;
        b=PaYxjceHq5AytH5B2GcHwR4DWdhth1cdyFUhBURkVYzBLSQTOQNa0g9AKitELb8DJu
         zO1ajV6KgFibVqjQiv/cDqvLr3vVw9bu6lnVszIRoY9G7eYeg/0gCibR4GqxR6L46Rz4
         jbqz3H9zLxu95m7dAPzYOM0WPrfgR1fzWCG8b/GKwkqTaRfU5lEhmGaE14Ie8wNP9v90
         PN1+HKvdqt6wqBMqVx/L1GcRaRh3RUQlmp/FUC7q4JVvrNgXyXW3zJvkJnZ0v13b744C
         IlkGPiyq6JJC2rbbigxRA52dT02l1oI8tACEuhJCmy7y12boyqx0jXj+BjAtW6mDN4y2
         Q2lg==
X-Gm-Message-State: AOJu0Ywox54+VWJ3gQqaJi/hyFk+eLUKWXuUBEf6l0R8JzW2Qv4MNa13
	5i0xLUIZLjO0puwPz/rpRjF56VPXMl5mL72v7MKFxVKwXp/YnIAIiX8Xhe3RBijvmVWgMfp5asM
	RuqOamQcln8kKYmJN4XMRbxDFvVOLX1jLvW9WRdaBHccl60/FYLcHy5Kr0Rg=
X-Google-Smtp-Source: AGHT+IGglByV7oAt0AvvUsyv4OluheBxCIqzswCTekEX65jtiEkOcG4IX9vOVIkgRX1YKd1ZxVskcuoi0ggOIR1TO7+iXh/bn0T+
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:380d:b0:424:8d44:a267 with SMTP id
 e9e14a558f8ab-42581eac095mr102076685ab.29.1758717574612; Wed, 24 Sep 2025
 05:39:34 -0700 (PDT)
Date: Wed, 24 Sep 2025 05:39:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d3e686.a70a0220.4f78.0023.GAE@google.com>
Subject: [syzbot] Monthly bluetooth report (Sep 2025)
From: syzbot <syzbot+list84175158135809b979c6@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello bluetooth maintainers/developers,

This is a 31-day syzbot report for the bluetooth subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bluetooth

During the period, 2 new issues were detected and 1 were fixed.
In total, 38 issues are still open and 91 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  43283   Yes   KASAN: slab-use-after-free Read in l2cap_unregister_user
                   https://syzkaller.appspot.com/bug?extid=14b6d57fb728e27ce23c
<2>  7364    Yes   WARNING in call_timer_fn
                   https://syzkaller.appspot.com/bug?extid=6fb78d577e89e69602f9
<3>  3411    Yes   general protection fault in lock_sock_nested
                   https://syzkaller.appspot.com/bug?extid=d3ccfb78a0dc16ffebe3
<4>  1710    Yes   general protection fault in h5_recv
                   https://syzkaller.appspot.com/bug?extid=b5691bb559396b262064
<5>  719     Yes   WARNING in hci_conn_timeout (2)
                   https://syzkaller.appspot.com/bug?extid=fc4b5b2477d4ca272907
<6>  360     Yes   WARNING: ODEBUG bug in hci_release_dev (2)
                   https://syzkaller.appspot.com/bug?extid=b170dbf55520ebf5969a
<7>  304     No    WARNING in l2cap_chan_del
                   https://syzkaller.appspot.com/bug?extid=3272785b7a1fc9b510f6
<8>  274     Yes   possible deadlock in l2cap_conn_del
                   https://syzkaller.appspot.com/bug?extid=b71bb48c13bf3fed3692
<9>  139     Yes   KASAN: slab-use-after-free Read in l2cap_recv_frame
                   https://syzkaller.appspot.com/bug?extid=5c915dc5dd417b83b348
<10> 113     No    BUG: corrupted list in hci_cmd_sync_dequeue_once
                   https://syzkaller.appspot.com/bug?extid=5250d87dea2afdb718a5

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
