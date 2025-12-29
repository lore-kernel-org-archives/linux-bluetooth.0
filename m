Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2C7231A21
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Dec 2025 08:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766995951; cv=none; b=FKAHGxq0tUZvI2UTqoYwKUujDqfSGHBR2/xPW8+2eUjhm59nCxMh5vYrRfqAjcb15h35J0pnPVKRnqDgSz4kPAH8haPuncNX++JDzcdf6+YavAKxHykEAQp3ljrNSvsx9cXOLUtC5lRRUBuorWic/JVlMLt2UN8c/rBDLMny/B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766995951; c=relaxed/simple;
	bh=+CbDHhskOgQhMex29FrfmnqMz2gj5f290x+wr69aTGs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=fJM/K+qzaw8ID+V0ACQvy2G50fWazr7HknO+g3j+twR9Kz/YbULQJBVwWoiOGL3khT/1JakG5IdxDzAFief3QWmXlMkPNPSt/WjcKOiMoJzDO6oX4hqznEcJ2qglPJLMBxk23uuQGLutsud9ccs9IgcBhdNJud7dP6u/pFx0PME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7ce031c61ccso549947a34.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Dec 2025 00:12:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766995948; x=1767600748;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x7iWlRGkWrGeh7NpBbmdG5Rrg4SUWlWmAcz5xw2Y7lk=;
        b=OOhASonN8q3/7W1yImTn1oxkGoXBIoCOqajG/WsBPkFM05CbKrsrgzT3wGgMujSKFC
         g8dHqQsYL1HDVZ0aTdfnK5MBvsOkTfrp7XfkjdpuMeB1+2xR1mZlZNRzYRKNlNAfBx+k
         vKY59eClLfyOeNluQ2+p36aXWUwBJVEEYUggEYt+xmMZoAKdzEJthShoo74H4mPLVCBC
         pb1m6LDJtxhbXVVTNn6TUqmGJMGi1SRsKHTMEItIwvZtq53l8y/mnQFbkWvZELJgBSLo
         iBCx6niae0mCLSDyJOlq90ICOKj6u8VDPOAtqX3YXjbcsGv+5YO5hCofxQV+iPZgMzpZ
         iHfQ==
X-Gm-Message-State: AOJu0Yza5CIq4d+bOFZoNsrAXbSec5y9ihBOxTGfFR0MdwmYwia5+AGS
	kGHeSjIg0HuFNHJ5V0zxGgk2U+/RWFkAmQF85cL7YGhSq3Xji0+4CF9AdIcyBbmCVw1ahqmJoDE
	WaW/A1G2/KMVM7/NOTX3XUJYpvL/WjGvYQOr6vVNOEgcyXD2zAZuTjPnuCsM=
X-Google-Smtp-Source: AGHT+IFKyUjVuxIK/MkKhsSR2WaV60dIlR2qf/H7vdsffEpZGAmeq54f5qata+3VPcphcdX9U+wWB5FrOzCOioaHprgFGbjh9/Ii
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:d154:0:b0:65c:f135:dc35 with SMTP id
 006d021491bc7-65cfe7b0177mr10762490eaf.38.1766995948393; Mon, 29 Dec 2025
 00:12:28 -0800 (PST)
Date: Mon, 29 Dec 2025 00:12:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <695237ec.a70a0220.c527.001e.GAE@google.com>
Subject: [syzbot] Monthly bluetooth report (Dec 2025)
From: syzbot <syzbot+listf8bad64c1ddc35a9f42b@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello bluetooth maintainers/developers,

This is a 31-day syzbot report for the bluetooth subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bluetooth

During the period, 7 new issues were detected and 0 were fixed.
In total, 44 issues are still open and 96 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  45703   Yes   KASAN: slab-use-after-free Read in l2cap_unregister_user
                   https://syzkaller.appspot.com/bug?extid=14b6d57fb728e27ce23c
<2>  7893    Yes   WARNING in call_timer_fn
                   https://syzkaller.appspot.com/bug?extid=6fb78d577e89e69602f9
<3>  4001    Yes   general protection fault in lock_sock_nested
                   https://syzkaller.appspot.com/bug?extid=d3ccfb78a0dc16ffebe3
<4>  3361    Yes   WARNING in hci_conn_timeout (2)
                   https://syzkaller.appspot.com/bug?extid=fc4b5b2477d4ca272907
<5>  2969    Yes   general protection fault in h5_recv
                   https://syzkaller.appspot.com/bug?extid=b5691bb559396b262064
<6>  596     No    KASAN: vmalloc-out-of-bounds Read in kcov_remote_start
                   https://syzkaller.appspot.com/bug?extid=8a173e13208949931dc7
<7>  440     Yes   possible deadlock in l2cap_conn_del
                   https://syzkaller.appspot.com/bug?extid=b71bb48c13bf3fed3692
<8>  426     Yes   WARNING: ODEBUG bug in hci_release_dev (2)
                   https://syzkaller.appspot.com/bug?extid=b170dbf55520ebf5969a
<9>  335     No    WARNING in l2cap_chan_del
                   https://syzkaller.appspot.com/bug?extid=3272785b7a1fc9b510f6
<10> 246     Yes   KASAN: slab-use-after-free Write in hci_conn_drop (3)
                   https://syzkaller.appspot.com/bug?extid=3609b9b48e68e1fe47fd

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
