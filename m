Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035CA265626
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 Aug 2025 08:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756111479; cv=none; b=kMzm3Fmr391ihTcp0Ctd31sItWQd7+Nm+jyzw0VDwzfLCXrOqrw83KAyiAV/zvfLBNXyJs0zYeKguBipLfs5kYKKh3DtV0vEMyrdlqxKS//zff/VwET/z7lHRjpciOWOuFriNS3FK6/5jCNEe14oqyjgWUXjLgivrm8N0O/NAjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756111479; c=relaxed/simple;
	bh=99pElrjncnHI5XeFUxDYhe++QFEH37ZEUtEhdHthNdQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=PPMtcuXG6WRjdZrtWOmRdPoNVZlUWgTi4JAtk7uweXw7s7QJNNDXzHHAXRN4y8SMKmI7mu7/luEno33v7nxJuVImjlVnU19c+XopuDWdbT0eVYiIOwUg/8upGHSXTfPEREWwRIB5SmC7/GkJCW6X5IKGpUf8Rje4er058UmvR3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3e6766c3935so49552015ab.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Aug 2025 01:44:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756111477; x=1756716277;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W3HzpC/sk8cTaTYP8M3QS+phqIoM/pXWlrfdCha75rQ=;
        b=dW5cigJ3gWMbbogroOpGTQBOClKs2w+sQCZTvXc9ie0FzhCyu8CldL4sfZ+osUlBgX
         GOHpFRuHFqKUBHlfHLuD3bfs6HRD/a8UBWx49X9SW5kdX7y7emVrystb46fkw8cxDjEO
         0nceOQICvUmXFozoDJpvvF1j7f6lFUPws4Xg83RLCNM9eV8SCDYABZJiXPfu2kK6YQHE
         ZMTOpqf6hi5ZY2ucW3P15e3v6TOspS2ex9gZiV1Gf7OsL9KKt4A0LOJvh6lKA1HNZmJT
         uGj/Gjx7ZbkZWFyDuKKrq/idWxl9X0QRxiMP7YUb4FkXoEvRl2lvaChWdIC5N4NFhkxb
         VbZQ==
X-Gm-Message-State: AOJu0Yxn7jYZimFcM3g5Ai0Wuq0ghVkjfHzLQdjt9H9k2AY3Nuo/dsO7
	wjqVGtURrYf2mnGNhzXsQTPvl2yiMoXU8SFybHYHpdpilb4PmrbYZOsTFwOU1U3uz5Jyi6pGC7R
	Y+toAsazkwKpkG8QsTjtr5hbCGXyuQylIyMv3mcxtLtdf7EkeeX3ZRmrl8l8=
X-Google-Smtp-Source: AGHT+IEl8hsDgPWR1gaNB8V7lUsbB3WfciOv8h1f866s1qwQVH+/t86uNxdJQ3D4eoiqAQCLy2vTd7PxBkNVVazJ7k+cxo+NcMTe
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4414:10b0:3e9:eec4:9b69 with SMTP id
 e9e14a558f8ab-3e9eec49e75mr86276165ab.32.1756111477176; Mon, 25 Aug 2025
 01:44:37 -0700 (PDT)
Date: Mon, 25 Aug 2025 01:44:37 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ac2275.a00a0220.33401d.0402.GAE@google.com>
Subject: [syzbot] Monthly bluetooth report (Aug 2025)
From: syzbot <syzbot+list4fa12c81c752ac5ed332@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello bluetooth maintainers/developers,

This is a 31-day syzbot report for the bluetooth subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bluetooth

During the period, 2 new issues were detected and 0 were fixed.
In total, 41 issues are still open and 90 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  7222    Yes   WARNING in call_timer_fn
                   https://syzkaller.appspot.com/bug?extid=6fb78d577e89e69602f9
<2>  3222    Yes   general protection fault in lock_sock_nested
                   https://syzkaller.appspot.com/bug?extid=d3ccfb78a0dc16ffebe3
<3>  1392    Yes   general protection fault in h5_recv
                   https://syzkaller.appspot.com/bug?extid=b5691bb559396b262064
<4>  749     Yes   general protection fault in bcsp_recv
                   https://syzkaller.appspot.com/bug?extid=4ed6852d4da4606c93da
<5>  651     Yes   WARNING in hci_conn_timeout (2)
                   https://syzkaller.appspot.com/bug?extid=fc4b5b2477d4ca272907
<6>  439     Yes   KASAN: slab-use-after-free Read in force_devcd_write
                   https://syzkaller.appspot.com/bug?extid=bc71245e56f06e3127b7
<7>  349     Yes   WARNING: ODEBUG bug in hci_release_dev (2)
                   https://syzkaller.appspot.com/bug?extid=b170dbf55520ebf5969a
<8>  286     No    WARNING in l2cap_chan_del
                   https://syzkaller.appspot.com/bug?extid=3272785b7a1fc9b510f6
<9>  228     Yes   possible deadlock in l2cap_conn_del
                   https://syzkaller.appspot.com/bug?extid=b71bb48c13bf3fed3692
<10> 152     Yes   BUG: sleeping function called from invalid context in lock_sock_nested (3)
                   https://syzkaller.appspot.com/bug?extid=55cd5225f71c5cff7f6f

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
