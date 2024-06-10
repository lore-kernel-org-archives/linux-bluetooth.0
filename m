Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26737F48C
	for <linux-bluetooth@vger.kernel.org>; Mon, 10 Jun 2024 11:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718020588; cv=none; b=BSfx6Tq2iSs5ufLkn+rlcEpZU0OJo4dhK95bogB5UKWYhABNhnqJljvhETl2Hd/TEKnLoKhSpKwc54W7DU9A0eGyMmmzlWf8GtINx+HvwwfUAh+nxObXywNMu3YOJNRqVt6SUfxFcHET/UqBLa0oKkyx1HIC2yaBOPuUjjRpgnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718020588; c=relaxed/simple;
	bh=3zfvzlmcR8N56u/FKlbPmt+e+1fkdR4IKAhj3L5vxzs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=m2vyvS1Iw4dLwgcNroueGr/QgIVWBchcPaDBnUYzcyPtZUYsRUzguF2rh/7EcFXfZSSRy9MKBT4LujwDWSCLrKPf452wDguni8uR2/k44zWgqmw3MzYfgjsUFO+CtH8SFvyb/mr9ltwZ6C3ipjrCx/ZSJDKpxtxFMs4ljCl0sfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-374a53fc682so42678115ab.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Jun 2024 04:56:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718020586; x=1718625386;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZkZ3+r53EPSlPEfxLkR3ZeP8CW8pwD/hEhLYRJTOsaQ=;
        b=ihpXrXhKsTnAnLCQj0G+rhpfF1cbWmbD10lXNFunGUAUzmdPcSNv74x5AZPTb7GqhP
         HQUxouIstFNbgpJx44y4TMSnRKbQ5N0C00O8iJA8HS+35dU3VrD3txwqDIMMQu2QPOk9
         Qtum11VtH0nBDyoLitwgEfWFLxjGmVZjvbxXSsxv+rNBkq6h9emEXFUvfqrpr7SbwwtP
         J6vy2r3lwxCLF8Hp5lDYyvVALbnS0ZqIfnEwiBG3lMte1IrgtJul0ADEMW1qCjGOJMnz
         eWr8uieOH4jTlbEczoAoynh95vkbDbaSyumjFyr9/6wBKLmxUKDWGEUKp+CvYOOSO3NL
         vCjw==
X-Gm-Message-State: AOJu0Yw9DGIksjve42brCt1IQvuekeKGnIOmo8EP6ReDmgFwwC1bL99A
	30dy/aE/rMobnyYh9IJLeVrYRBLx2GHpwJrbZGU66NHQXk9BDxn9T+TFbU0IMZiY6D0ogJjD7n5
	ilOtoSare1OdudaXI4boKE6cvK8XlZze3T51OQ5rH3izwZVVXStlalvI=
X-Google-Smtp-Source: AGHT+IEkaqB6ydyDctJGeDvNtCoQHlYExJ79u/V7cVFMgkdlq2tTHJ64KPaQk/juXHrnZEb840thf0gmF1RT6W3WOiOAOjqGU96Q
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:786:b0:375:9b4f:5e47 with SMTP id
 e9e14a558f8ab-3759b4f609emr1485945ab.1.1718020585979; Mon, 10 Jun 2024
 04:56:25 -0700 (PDT)
Date: Mon, 10 Jun 2024 04:56:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000be90d1061a87d641@google.com>
Subject: [syzbot] Monthly bluetooth report (Jun 2024)
From: syzbot <syzbot+listdd264ff43a865b537e43@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello bluetooth maintainers/developers,

This is a 31-day syzbot report for the bluetooth subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bluetooth

During the period, 4 new issues were detected and 0 were fixed.
In total, 53 issues are still open and 63 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  21745   Yes   possible deadlock in rfcomm_sk_state_change
                   https://syzkaller.appspot.com/bug?extid=d7ce59b06b3eb14fd218
<2>  7056    Yes   WARNING in hci_conn_del
                   https://syzkaller.appspot.com/bug?extid=b2545b087a01a7319474
<3>  5110    Yes   WARNING in hci_conn_timeout
                   https://syzkaller.appspot.com/bug?extid=2446dd3cb07277388db6
<4>  2972    Yes   WARNING in call_timer_fn
                   https://syzkaller.appspot.com/bug?extid=6fb78d577e89e69602f9
<5>  2528    Yes   KASAN: slab-use-after-free Read in __hci_req_sync
                   https://syzkaller.appspot.com/bug?extid=27209997e4015fb4702e
<6>  1001    No    possible deadlock in __flush_workqueue
                   https://syzkaller.appspot.com/bug?extid=da0a9c9721e36db712e8
<7>  680     No    possible deadlock in touch_wq_lockdep_map
                   https://syzkaller.appspot.com/bug?extid=91dbdfecdd3287734d8e
<8>  615     Yes   general protection fault in skb_release_data (2)
                   https://syzkaller.appspot.com/bug?extid=ccfa5775bc1bda21ddd1
<9>  243     Yes   KASAN: slab-use-after-free Write in sco_sock_timeout
                   https://syzkaller.appspot.com/bug?extid=4c0d0c4cde787116d465
<10> 185     Yes   general protection fault in lock_sock_nested
                   https://syzkaller.appspot.com/bug?extid=d3ccfb78a0dc16ffebe3

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
