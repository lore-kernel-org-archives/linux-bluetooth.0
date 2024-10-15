Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F3418BBA2
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Oct 2024 08:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728981208; cv=none; b=OoL17MyC/Xi6vJ5pcgVAeoo9o8LcWyT+cqvQrHsq/9/EsCMBitN3osa5mz1T40qDNe4IdRxEs21GcfiLZrwCMaq7JQKPia7OmrtePZim8QHv4Js+LttW9LO2E/nY/VzDdHxh4KIyY6xqYSgpWLoCwWSSJMdYHdhqoY2GfhlG/7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728981208; c=relaxed/simple;
	bh=brGXm5QGlWX/75RpntS9S7a9tixHTLH1SjkC/et3nG8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=J7MgJBvEiwlHiuO7l5ao9hzT3xcDPrUZCWiLTIw8q7a9VIzWAtFFTIyE2N0envPNgDpd8NLgTGKVh1luLXEB0p9aa0RLD58MXoi0/n7ZB4fVKoBAr9j9djjEx2c55hJzsOx4Td35mAkb9FzZEu7TTDHh2BjsYxDAYlCH0/6eeM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3ae775193so37837285ab.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Oct 2024 01:33:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728981205; x=1729586005;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wJ+92rKJpzc7gFGhxIcfKPxEEBkRlPMq6apblhq+LxY=;
        b=WeGGdVaHxBg9cmxGXW/ktqGXQUp/cvdU4+F55XWonlrOZYDlw9YtfRFgSgJ/1bSfm9
         Vv3T2LJyN4rBPXd1fl5rh6yYoV6eHnC2fQUtCFpEt8bZkhBM6rA8BGhrH8O0eqHyuM+Z
         /GEU947mp6yK0GcHATuwyPa+D/2kmZeWjg2SFnsC7GG8/EdNHGSdGvRYpW5baZFoSk+n
         +UqSOGx+XKgm6nHwc3eGeuTKukmfEdIbbjbyXub4UsOADkbZsyRrl5sxEasilZZK87WV
         EE/XjmJx1mzQY3XZtzWu6mneN2Mq4eJ1/bNpw5kcF3h/ixrPFnQV76HWF90jUjvl4a1H
         LYWg==
X-Gm-Message-State: AOJu0Yw96xQeASYARjkTwYW51JIoAR6vU+1KNIuiaCR4qc99/okhzV1a
	zamkeiqj5/MAuju4ysWGyNsm0272eYk64hHqH0uz9MSvuSJlgI2KnEUM8162KEWIm4DKevlHRwq
	ZIdhpaxAHgOEsUvb2GtLNmlPqj9QluAk6uPuJLIcHWLMiUkJy0PRXID8=
X-Google-Smtp-Source: AGHT+IG61fSjJUpq0XydR2YAsm8DLx453GM2CbssO1bSfKVnVPORJxKdimQF+PztK/jVwgMTGcLN3LB7eQxAYzPEMyRxQJnnpjgh
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b2d:b0:3a1:a5dc:aa4e with SMTP id
 e9e14a558f8ab-3a3bcdbb661mr77680745ab.8.1728981204935; Tue, 15 Oct 2024
 01:33:24 -0700 (PDT)
Date: Tue, 15 Oct 2024 01:33:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670e28d4.050a0220.f16b.0006.GAE@google.com>
Subject: [syzbot] Monthly bluetooth report (Oct 2024)
From: syzbot <syzbot+list1d979a49215bb9d63dc5@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello bluetooth maintainers/developers,

This is a 31-day syzbot report for the bluetooth subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bluetooth

During the period, 6 new issues were detected and 2 were fixed.
In total, 47 issues are still open and 72 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  13649   Yes   possible deadlock in rfcomm_dlc_exists
                   https://syzkaller.appspot.com/bug?extid=b69a625d06e8ece26415
<2>  4263    Yes   WARNING in call_timer_fn
                   https://syzkaller.appspot.com/bug?extid=6fb78d577e89e69602f9
<3>  345     Yes   general protection fault in lock_sock_nested
                   https://syzkaller.appspot.com/bug?extid=d3ccfb78a0dc16ffebe3
<4>  175     Yes   BUG: sleeping function called from invalid context in hci_le_create_big_complete_evt
                   https://syzkaller.appspot.com/bug?extid=2fb0835e0c9cefc34614
<5>  130     Yes   KASAN: slab-use-after-free Read in l2cap_recv_frame
                   https://syzkaller.appspot.com/bug?extid=5c915dc5dd417b83b348
<6>  85      Yes   KASAN: slab-use-after-free Write in sco_conn_del
                   https://syzkaller.appspot.com/bug?extid=6b9277cad941daf126a2
<7>  57      Yes   BUG: sleeping function called from invalid context in lock_sock_nested (3)
                   https://syzkaller.appspot.com/bug?extid=55cd5225f71c5cff7f6f
<8>  46      Yes   WARNING: ODEBUG bug in put_device
                   https://syzkaller.appspot.com/bug?extid=a9290936c6e87b3dc3c2
<9>  45      No    KASAN: slab-use-after-free Read in skb_queue_purge_reason (2)
                   https://syzkaller.appspot.com/bug?extid=683f8cb11b94b1824c77
<10> 36      No    WARNING in l2cap_chan_send
                   https://syzkaller.appspot.com/bug?extid=b6919040d9958e2fc1ae

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
