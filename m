Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B3E12E1E0
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jul 2024 07:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720683087; cv=none; b=TnFHbP8tMAVv0DgR58UOpYEGIYJ/8AF0vf4GhEqJXNAmuDHKAS9SLYLXZ+/wTEcQbjKkdGA1xXWePui/SrGUAAEvWg0yU//YU1r6uKVbdJE5qjf63Kj6JkVcDzc98DfvBP5EugHpfM4RYpYk1kG7L7tjqBcjnNivqJKcglZbP0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720683087; c=relaxed/simple;
	bh=2ykrV+db0A9oXfPwOZSh0YWS78FhI0FWtnZN5Z6XYCg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=h0w7jDGRdRAKWnRa47Wf4ZvTUZBf/FxoS+dQOX7OhZe9jGENJOzwRLzLcvyOvZa3msky0GQUAMEjObpOVyHUdsqApWxPjbcpVoDSmFh+W6GLgp4nLifag4xBG2Oq/DjuSVNvYBd04aQuDu9DaOH1uz0tNA3JdxTwroh554zWla0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7f684ab3f9cso46949439f.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jul 2024 00:31:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720683085; x=1721287885;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IxiJdl4VtQvTNmrKCocRbqkV0SinbYelbc+wAZLmHNQ=;
        b=gCamVA59JYDyFw9BGxNQXTqC5b9h51bpTh7JHkhwguIZCgvNuHVieqJqewKY5vfv9t
         Vpn7wL4sHsUy7nUyER1HLlrdDpxKhc/IXKFK0n7GSjoJTpDR56QY+ZwjExVj5AeHM6jH
         YXCiagb56tlJ3ZASrjRQrwAjt0Vl4dBiu9wfVVqmcaPgfolNHdbKpFm3AR4+dJY+g0Qw
         E3CdBBaAH523RtlQbM/vtfzI/W4QvVlRreClOYkHoamYSRGFXwx4MesZDpCPa/tarpId
         wdOk7p3FTJ4/qwtlZlgWVz6nfQeQMAGllJ+GBss8FCu85QAG7HNyLN9JA/j7gRpF1M29
         NQ5A==
X-Gm-Message-State: AOJu0YzG8f4c9U7K81O5y5aLjjglgMCshn3NoIeP981NyGXgqZ5O83l4
	ykJ7WHklCo+KSOJ6IQGhxJ7YtVk9Qz9AK+iBjLLWw1lHqCckYJ0r+eu64B4VxIMwtaKcGIYxl0j
	jJZcwZVb1XraPF/hhbjzEZNZVmRflcPkvzmnyL7Cs36GLYnmSveCZns8=
X-Google-Smtp-Source: AGHT+IFWckUCxHgwYGtn24fWh3b9Aa1oJyYIW3pH83j2rqWMToR0Qm4RcwrF2vzeHHitwxBvKQan6wwAGETGzhd46Y1AOmGtVRh0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:34a4:b0:4ba:f3bd:3523 with SMTP id
 8926c6da1cb9f-4c1bdedeac6mr126608173.2.1720683085409; Thu, 11 Jul 2024
 00:31:25 -0700 (PDT)
Date: Thu, 11 Jul 2024 00:31:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000013c187061cf3c09c@google.com>
Subject: [syzbot] Monthly bluetooth report (Jul 2024)
From: syzbot <syzbot+listf73783798eb5d74d411e@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello bluetooth maintainers/developers,

This is a 31-day syzbot report for the bluetooth subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bluetooth

During the period, 10 new issues were detected and 1 were fixed.
In total, 53 issues are still open and 64 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  21879   Yes   possible deadlock in rfcomm_sk_state_change
                   https://syzkaller.appspot.com/bug?extid=d7ce59b06b3eb14fd218
<2>  13079   Yes   possible deadlock in rfcomm_dlc_exists
                   https://syzkaller.appspot.com/bug?extid=b69a625d06e8ece26415
<3>  5305    Yes   WARNING in hci_conn_timeout
                   https://syzkaller.appspot.com/bug?extid=2446dd3cb07277388db6
<4>  3382    Yes   KASAN: slab-use-after-free Read in __hci_req_sync
                   https://syzkaller.appspot.com/bug?extid=27209997e4015fb4702e
<5>  3246    Yes   WARNING in call_timer_fn
                   https://syzkaller.appspot.com/bug?extid=6fb78d577e89e69602f9
<6>  680     Yes   general protection fault in skb_release_data (2)
                   https://syzkaller.appspot.com/bug?extid=ccfa5775bc1bda21ddd1
<7>  411     Yes   KASAN: slab-use-after-free Read in sk_skb_reason_drop
                   https://syzkaller.appspot.com/bug?extid=f115fcf7e49b2ebc902d
<8>  250     Yes   general protection fault in lock_sock_nested
                   https://syzkaller.appspot.com/bug?extid=d3ccfb78a0dc16ffebe3
<9>  249     Yes   KASAN: slab-use-after-free Write in sco_sock_timeout
                   https://syzkaller.appspot.com/bug?extid=4c0d0c4cde787116d465
<10> 120     Yes   KASAN: slab-use-after-free Read in skb_release_head_state
                   https://syzkaller.appspot.com/bug?extid=d863bc2d28ef7ff42984

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
