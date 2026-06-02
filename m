Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E0014A619
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jun 2026 20:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780432349; cv=none; b=ISj8SCMFCL1vFvT1iJMMU7+j9BO3tEi59L4ibVbmzGsAhPiun76m5JL3G7ZpwFg633FXtTme61+4LsipawMOIcaY6nKPj0oWuiVKWYWlMkqRaYrXfSbwlaDLS7GjaRne3sha6wPUanhNrN+3fqrDuh9Jje/6Th2UQJmEoHCkP10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780432349; c=relaxed/simple;
	bh=UAjNaqFigzrGjvTO3eJoeWhSbtO95FApZcWU16dvi/o=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=jHAFG7O7I8GiX+nZ8yvA/5kkcKFymGx7QC0zcneJZ+VfsPd/+5zxYc++4LNgjPbieTR96KhM8dl8BJ92P7FFXs+cOKzaEsESQaVikUyvZdT/yP1Erp0jKvutevMs3Lrtk4no+e00ESTWbb+X25HPDCHCzqimayLc29zAS3CRT18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-69e47dbf2a7so277208eaf.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Jun 2026 13:32:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780432347; x=1781037147;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5pEnv0Shjf47V7AfpubXhYEZNx2P0+HCGmXw0XWFsOg=;
        b=UvkDnst3eeY/X6GwGIjWy37vzt1nCZrugtLGpWQRVZIeIpaVLfi78IwNkdHsOT0XsX
         ttf5sfreg1Iz962z9yjoWnbjEg4WYJnq4U3RMQqbnWIi+WpVovFSEIfoxF11e+DL6v6U
         FTvn15jTiu4AfK1Mdbeld1Xc0mbGOPcDvWgejvlTut9SoLzRnACIgir86S5ULPCH7QzI
         Sz8rFgbVcNiayocgJB4eMBFnjKTCUuLzGtdIHRfLzM3JAigjiAx2rZXWD4p4UQM4yZQm
         3kP9sQhq3oYO0JyfWlx3/GBqWTSACeni8UkI8atu21qC3h1pp4T/LpkF5e+xonBaMsrN
         KWbA==
X-Gm-Message-State: AOJu0Yyd1b2Irzya3uv6U0DKG/+KnDs2E4EMHxkVF/KzTsuxWea7Ibo1
	5Q0hB03lOFdqww+lHU99hsbgd7U9cd8Enr1b9kUzj0Sd/nJ9wwDjYezJO8C0shdagQ1l2NdxpAz
	+4lyoUMW74pdJBxaxT2xgSJ3RnbELTUYl2edr5cpjSDRVe5LKxXkCy1i8zhc=
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:e844:0:b0:69e:5d9:7e49 with SMTP id
 006d021491bc7-69e48cf973bmr165066eaf.34.1780432346989; Tue, 02 Jun 2026
 13:32:26 -0700 (PDT)
Date: Tue, 02 Jun 2026 13:32:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a1f3dda.7b89b7e1.205e57.0007.GAE@google.com>
Subject: [syzbot] Monthly bluetooth report (Jun 2026)
From: syzbot <syzbot+list9c475ae69cc5384cb852@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello bluetooth maintainers/developers,

This is a 31-day syzbot report for the bluetooth subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bluetooth

During the period, 4 new issues were detected and 0 were fixed.
In total, 27 issues are still open and 102 have already been fixed.
There are also 8 low-priority issues.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  9301    Yes   WARNING in call_timer_fn
                   https://syzkaller.appspot.com/bug?extid=6fb78d577e89e69602f9
<2>  564     Yes   WARNING: ODEBUG bug in hci_release_dev (2)
                   https://syzkaller.appspot.com/bug?extid=b170dbf55520ebf5969a
<3>  367     No    WARNING in l2cap_chan_del
                   https://syzkaller.appspot.com/bug?extid=3272785b7a1fc9b510f6
<4>  345     Yes   KASAN: wild-memory-access Read in l2cap_connect_cfm
                   https://syzkaller.appspot.com/bug?extid=0e4ebcc970728e056324
<5>  203     Yes   KASAN: slab-use-after-free Read in l2cap_sock_new_connection_cb
                   https://syzkaller.appspot.com/bug?extid=cdae834448ec8c3602fe
<6>  111     Yes   INFO: task hung in hci_cmd_sync_clear (3)
                   https://syzkaller.appspot.com/bug?extid=217e3f1283cafe80586e
<7>  97      Yes   KASAN: slab-use-after-free Read in l2cap_sock_ready_cb (2)
                   https://syzkaller.appspot.com/bug?extid=9265e754091c2d27ea29
<8>  33      No    WARNING: held lock freed in bt_accept_dequeue
                   https://syzkaller.appspot.com/bug?extid=4c5f0c6f8cc60159bdbf
<9>  165     Yes   KASAN: slab-use-after-free Read in bt_accept_unlink
                   https://syzkaller.appspot.com/bug?extid=a1595e656a83ea5b78eb
<10> 91      Yes   general protection fault in l2cap_chan_timeout (3)
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
