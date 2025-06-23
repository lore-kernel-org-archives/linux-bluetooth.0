Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DFEA933
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Jun 2025 07:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750663887; cv=none; b=OgKEM1+z39mYSeUxlHVwg0JP0yhsng5PhMhJ5GJLFVMOh4TvqRts9rbs6VaN5pk8kzfU58CAipItCKzhIKiWB9UkFTBnCbcCpBBd+lOQXHu1NSZB0Qn45fGRUQZvP+4HEUlxiHpV8JzgD2NBcW/emjcdERE+/yVexk4qpOSpE3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750663887; c=relaxed/simple;
	bh=imGZmfIS92AT8M2UOSabAeKhGS38Zmqtfb/vw4laE4A=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=fuNJDGyFFy3FeRnXIgRwZ/TasB96fOVZ4Oj17Wd5/2hgMWVpCHqmUxy9CHz4W4MSklo4xaBDEiuMo9UTFxytYIgOLG0+tlvy1fnRtyF/5ypGZ07/L9oEFGrp+q/a90Me2hjhmotQO4RRmvIEloGAPquEa/n+ZeBQRdNO99vvQig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-875b64cccd6so711836139f.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Jun 2025 00:31:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750663885; x=1751268685;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0LBTl20fx9cwH1yCh37c+MtQuYCafOELjlm2HlQGtHc=;
        b=BXP1yGVdBNm5Az4UwpSN8pgZf6qulzatlNmIkxH/h/9ehth+nXG2cYs1QlvmRZlD3/
         1TDht1qJwoIONE+QxLDib9jpvcqOnyW4Ayoegm9PtNd1RWjAkyp+XPLBxLq2rjh3pQ6z
         UKeJNsX4bLTtboeiqf76QbrQgAeiFsUZYJMda+L3QDUq5z3wVYpBU/yFtZP3ygUwNmtE
         x5PdN40mDd6ej4xjWdWBXl8jw53DbTdk+joZLLAC5iXgZxHNJn/D6WMefdw2OPxuPBsq
         dEDrFqSAt7VYylBGdy2uMGFyBYTFI37IXRW18ijZbD8ycuadRd8yNVg+R3fW9cHOPI/o
         UJDg==
X-Gm-Message-State: AOJu0Yzmd1oi6VhXuNEPTivFAz4R0WAlS8/tnu561erBCpQu25CVK/qa
	d8UKCGBZD0PlkfsQqDhNQaSaYzkpKUV5FAFPUhuuCVVYF5epHRfb/VVkUhqxB+/CXoKnYLsRb7v
	Rd4WKXDt7hXzHf7zW+R39dWRmh0fKduADKv9M7ewEqcAFrFm2UUxjrVHF/r8=
X-Google-Smtp-Source: AGHT+IGriwPmUf/QWYfE7lUZ7AQ9LCcX7KKVG+vi5BTy9rGDsCk7pJ/gNU8WhbgWiGyQF7+1ySHJbZOdx8h+Lca0DdXQ/rnvLr/b
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3415:b0:875:b8b7:7864 with SMTP id
 ca18e2360f4ac-8762cf399bfmr1328878839f.6.1750663885314; Mon, 23 Jun 2025
 00:31:25 -0700 (PDT)
Date: Mon, 23 Jun 2025 00:31:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <685902cd.a00a0220.2e5631.000e.GAE@google.com>
Subject: [syzbot] Monthly bluetooth report (Jun 2025)
From: syzbot <syzbot+liste6ea989cc3a25b8a140d@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello bluetooth maintainers/developers,

This is a 31-day syzbot report for the bluetooth subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bluetooth

During the period, 0 new issues were detected and 1 were fixed.
In total, 43 issues are still open and 87 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  40131   Yes   KASAN: slab-use-after-free Read in l2cap_unregister_user
                   https://syzkaller.appspot.com/bug?extid=14b6d57fb728e27ce23c
<2>  6964    Yes   WARNING in call_timer_fn
                   https://syzkaller.appspot.com/bug?extid=6fb78d577e89e69602f9
<3>  2709    Yes   general protection fault in lock_sock_nested
                   https://syzkaller.appspot.com/bug?extid=d3ccfb78a0dc16ffebe3
<4>  675     Yes   general protection fault in h5_recv
                   https://syzkaller.appspot.com/bug?extid=b5691bb559396b262064
<5>  507     Yes   WARNING in hci_conn_timeout (2)
                   https://syzkaller.appspot.com/bug?extid=fc4b5b2477d4ca272907
<6>  404     Yes   general protection fault in bcsp_recv
                   https://syzkaller.appspot.com/bug?extid=4ed6852d4da4606c93da
<7>  351     Yes   KASAN: slab-use-after-free Read in force_devcd_write
                   https://syzkaller.appspot.com/bug?extid=bc71245e56f06e3127b7
<8>  258     No    WARNING in l2cap_chan_del
                   https://syzkaller.appspot.com/bug?extid=3272785b7a1fc9b510f6
<9>  256     Yes   WARNING: ODEBUG bug in hci_release_dev (2)
                   https://syzkaller.appspot.com/bug?extid=b170dbf55520ebf5969a
<10> 170     Yes   possible deadlock in l2cap_conn_del
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
