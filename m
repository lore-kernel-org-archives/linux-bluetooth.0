Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDD92C3257
	for <linux-bluetooth@vger.kernel.org>; Sun,  1 Mar 2026 06:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772346210; cv=none; b=fSWtk20txjxhqtOxQ6uFFlSPGkd4rEb+IvS3SSkqdXYSweC00hTcUWCwv7B7N42i2ZP8eDqypNZUHXCtFkv5ABUs0m63XYOd8uQLHSm78LrySB/QYP10l/AaHmK6Zm9kC+oZS/qYn+Nq1rK073B9+ZbMyb4ujRASgRHuFu4uvh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772346210; c=relaxed/simple;
	bh=ZtgAQKGxttvbLp5UclXrsIvRKvhGCmPWupiyo0rv6bs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=e3hrGFeKet/QPTlPkC6GRk1CWpkhFBBPjs/tyISchuvxF9Rq1SJjGr7kGwTzpr5HIxU64FmEzXKoRMRk+StmrKTsILY625gKVNGm0zVWVZZACmey8T4Z3QUOC9dLEb/6tNkYAFXslP44OGTYOaN38ZVnp6ZUdX13QvshO2pFXWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-679c29b437cso30329355eaf.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 28 Feb 2026 22:23:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772346208; x=1772951008;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+mP+R9zaDDsUjx+WhIpBXgtaUAljb2vLHaseaw78qjo=;
        b=JWQupCnih1ldVqbVLAPX/hFE6M7iSCLTnMQyL3Ik9SDQgLfltTWWpxXzLskpv1pvps
         Eb3ajkid8j6YTo7W8KrPJbubrBPt/aiam/LRTHwIJO6W5HDwckJfiRaPDHRrVtOj64JG
         GNraiU+ePD/mRPxn4d2MEhQgdyZoLtTSSxOLgqc/JLEmm6Y+V3uQEO77eLrHsLaUbaaS
         bs4lZPsM5v6OM7hkm52qLAVijvS/uM04m+vm19Dr0RePZa/CWeTpEFcj01XxCW64QhJb
         lGhS51vWuriFWziENE02lm5osU/e6K5k9OyiubS4Axn1A45ev8Tk2aUjKFpmbc0ZbI85
         uq6g==
X-Gm-Message-State: AOJu0Yyk0umcUSGhqAyZ7CmJmiiDLjoZaX6HtLk1It/eV50PoHt84HRV
	aP7Sx/jHbYyvw1cyfvr4y4fgLL5iOJDJK1Gyq9DBax/xfO6qr1JXwnu3C+NoiEeS/65LyD6mCil
	l/VDs5f4CoDbF8Quf/gg7c3kVQklh6fjxq7och+E1VZerR4cPt+z0Lmpd9fo=
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:e918:0:b0:663:517:7d8e with SMTP id
 006d021491bc7-679fadee2c8mr4429591eaf.17.1772346207992; Sat, 28 Feb 2026
 22:23:27 -0800 (PST)
Date: Sat, 28 Feb 2026 22:23:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69a3db5f.050a0220.3a55be.0054.GAE@google.com>
Subject: [syzbot] Monthly bluetooth report (Mar 2026)
From: syzbot <syzbot+list681cfcaa8eead23a8dda@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello bluetooth maintainers/developers,

This is a 31-day syzbot report for the bluetooth subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bluetooth

During the period, 1 new issues were detected and 0 were fixed.
In total, 37 issues are still open and 96 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  46025   Yes   KASAN: slab-use-after-free Read in l2cap_unregister_user
                   https://syzkaller.appspot.com/bug?extid=14b6d57fb728e27ce23c
<2>  11911   Yes   WARNING in hci_conn_timeout (2)
                   https://syzkaller.appspot.com/bug?extid=fc4b5b2477d4ca272907
<3>  8268    Yes   WARNING in call_timer_fn
                   https://syzkaller.appspot.com/bug?extid=6fb78d577e89e69602f9
<4>  4349    Yes   general protection fault in lock_sock_nested
                   https://syzkaller.appspot.com/bug?extid=d3ccfb78a0dc16ffebe3
<5>  985     Yes   KASAN: slab-use-after-free Write in hci_conn_drop (3)
                   https://syzkaller.appspot.com/bug?extid=3609b9b48e68e1fe47fd
<6>  538     Yes   possible deadlock in l2cap_conn_del
                   https://syzkaller.appspot.com/bug?extid=b71bb48c13bf3fed3692
<7>  497     Yes   KASAN: slab-use-after-free Write in le_read_features_complete
                   https://syzkaller.appspot.com/bug?extid=87badbb9094e008e0685
<8>  480     Yes   WARNING: ODEBUG bug in hci_release_dev (2)
                   https://syzkaller.appspot.com/bug?extid=b170dbf55520ebf5969a
<9>  348     No    WARNING in l2cap_chan_del
                   https://syzkaller.appspot.com/bug?extid=3272785b7a1fc9b510f6
<10> 231     Yes   KASAN: wild-memory-access Read in l2cap_connect_cfm
                   https://syzkaller.appspot.com/bug?extid=0e4ebcc970728e056324

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
