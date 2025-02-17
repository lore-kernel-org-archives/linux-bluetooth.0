Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3947A1DDE9
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Feb 2025 12:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739796259; cv=none; b=jz7OIG+f6SLu39oCF+HGtX4x0XHDdCxqF1+BWQyi0pTsd18zUwWwXtOt2M7WhOlT3N1SOPqoGeoAehy8aNqD5rF6Vqr4AknqCAJ0xcU7iyhalwVNErnEluY/VYRKM0qi5FczanVb8EAxTlLUzYLKPyQLU8FjeWxYHFj6IKUCZhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739796259; c=relaxed/simple;
	bh=D4Y1T7mfxwOQ4MS09HwDhbNQiqQZcqPCW/8qshQ+Adw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Mi5xZT2F1AMCeFFa1mXSOip2ILbCyqruxSNPVczHu9RJg2/ooum3vRAGpJ/psWCc++IRjtpfs4F6cyPuPipD4Wnt2ce0rYJpBjlLRmyPahFLUu4z7u39SDyi24o4qJVv+IU2dippFSWtvFkpbjOwK7IT03vF6psj8LOTIdP+zpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3d18fbafa4dso25196185ab.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Feb 2025 04:44:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739796257; x=1740401057;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zjf1l0cPgcmh34vnjgEblNi+O3qUSdKZPLQ57K5Dj0s=;
        b=mZx6h3NoeInpFbx68A9O/TcDnt7E/0CEaHQFqeX7hPghXlBzr+V6UeWtLRnt6lbABX
         /W9CLV/23CTTr7xZFl+fVxxnCBGYm3j5YWBzoOt0XCVO5qBMCQEOMQKLv5v1OTZhzsjU
         mZbMAMkZxWo8A7i0YZls9zadf+V1yWw1iQYuGvgJYp582Ijm5PDeRGlGQz/a4fA966CB
         lsNQwOCAn3WI6ucnO+XIEjI1s+m4wYYBSLaBIEnDcGzCGQ/tXbF7cybDNQTAhBqLS710
         uE25h0Kqp5IQAK039v15xpOWKPUbiekCd/noTaUz77DeZ99Dji56yvV1k3w8eR/bBoTx
         Dkyw==
X-Gm-Message-State: AOJu0YyHGKyxYcgs5AW5XszE8NloGhwJTUz3ArEmfoIbsWd41ZXabGJb
	8taYTo0Od6ZGBsC6yrEk3905g3fMst/GkChOb7L018GyrHklMtK+kRcmRblL76Qw+jKdxVkeKis
	kXfaCvgpK5yINHnqYEcyCkzudlhoKR8OF0Rf1BQfH8hvwf/s9IZCniWg=
X-Google-Smtp-Source: AGHT+IETYE4hEIQrhLeq61cizQjcSFArms21MhpYRV8EaUvhO7cFeXO4BwBY46Ggi30TiEV3nqR6542Tua9ti3yfsbF7UZ8JEO7B
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c0f:b0:3cf:f8de:7662 with SMTP id
 e9e14a558f8ab-3d2808d6db7mr86085985ab.18.1739796257282; Mon, 17 Feb 2025
 04:44:17 -0800 (PST)
Date: Mon, 17 Feb 2025 04:44:17 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b32f21.050a0220.173698.0032.GAE@google.com>
Subject: [syzbot] Monthly bluetooth report (Feb 2025)
From: syzbot <syzbot+list13032b763486017a9b9e@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello bluetooth maintainers/developers,

This is a 31-day syzbot report for the bluetooth subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bluetooth

During the period, 6 new issues were detected and 0 were fixed.
In total, 58 issues are still open and 79 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  27541   Yes   KASAN: slab-use-after-free Read in l2cap_unregister_user
                   https://syzkaller.appspot.com/bug?extid=14b6d57fb728e27ce23c
<2>  5842    Yes   WARNING in call_timer_fn
                   https://syzkaller.appspot.com/bug?extid=6fb78d577e89e69602f9
<3>  943     Yes   general protection fault in lock_sock_nested
                   https://syzkaller.appspot.com/bug?extid=d3ccfb78a0dc16ffebe3
<4>  702     Yes   general protection fault in skb_release_data (2)
                   https://syzkaller.appspot.com/bug?extid=ccfa5775bc1bda21ddd1
<5>  242     Yes   WARNING in hci_conn_timeout (2)
                   https://syzkaller.appspot.com/bug?extid=fc4b5b2477d4ca272907
<6>  214     Yes   KASAN: slab-use-after-free Read in force_devcd_write
                   https://syzkaller.appspot.com/bug?extid=bc71245e56f06e3127b7
<7>  182     Yes   WARNING: ODEBUG bug in hci_release_dev (2)
                   https://syzkaller.appspot.com/bug?extid=b170dbf55520ebf5969a
<8>  137     Yes   KASAN: slab-use-after-free Read in l2cap_recv_frame
                   https://syzkaller.appspot.com/bug?extid=5c915dc5dd417b83b348
<9>  132     No    WARNING in l2cap_chan_del
                   https://syzkaller.appspot.com/bug?extid=3272785b7a1fc9b510f6
<10> 115     Yes   BUG: sleeping function called from invalid context in lock_sock_nested (3)
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
