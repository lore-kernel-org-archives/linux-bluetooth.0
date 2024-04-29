Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D35467A14
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Apr 2024 18:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714415825; cv=none; b=F6R2l+x4PZhcyNv2kGqmnRV8gj/aX9HPUZQSl2s1+oUwJefTDhZARZse4bKmFXY0xt7874xtO+2ptZ/Zk/rGXFbWo53fSCesHipyvyOdbR7vxr4weCeYLcvrzsqZXKWAO4aBei+wHEfx7DrrxAfqR6bTZeMBU5KHjljKezI6M9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714415825; c=relaxed/simple;
	bh=VtpWIt2Cg10SpMJg2TSidcDR0e8buD5s+hNLaTrQo9o=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=GsfCOWwf+9mW1hR9pufUHpoo4RB5qfCg/Jt6LAoVy3EpyiPNO3XYKFoJjxUp5sDZZn7blv7imI60dCloMg9P3+JHTohfKBNuRpIXqekKpM8CcGhIINcgknZBqBHpso8JGiYe19iOKTCf/9c3SRqtCeh8KnSeciDKKRIxBRgAdfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-36b2eee85edso55260815ab.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Apr 2024 11:37:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714415824; x=1715020624;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MujhuQRr+Zfbg9mAy/KHY5eP40BaRZQ7dzpBhYWyEFM=;
        b=HWoukj+iGXhUO4NQj0xsmYSwofgB60iTZZUNLlqXDTyjTtiVPwIkqli4R4Fbf+I/GC
         URQpoTYQuFQseIEF83JCK8f5Y/nS3DoCy2xVUWdjcDvQxTlnjhDRe+qnHngzxuF0x9pT
         ZFwR01rwiFdsOACsNvohcDIvEq3dkdbWaAqvcgs+zCggzffoBOtvqUBPu6S2KfJDQRww
         TUKwNrFSU+JoQkO+1bDSqz5BLI1cH6AeKwKu2I4Qwyg+bMpC2gibZbwD8WQbnt10zBNJ
         PYkvtPxPxRj85nnmvCgP5RFbS8tHnLytnSlGmMYVBo3rrXxgS8E750WKBLxebxd9KZRG
         6T4g==
X-Forwarded-Encrypted: i=1; AJvYcCXdEh/50BgNnQih5IWp8zGWre7MhSZokUH2ePumuEi7i9wPLfN3iwNhVaHTPWGyTLIil+CXauJ9yJRN/Q6gXYd12kcHz6wsE+xA4T1L467X
X-Gm-Message-State: AOJu0YwQQtq+J+pIPUBDKJP8k7d0mRmCEE86plPwL9RZjKo4BMkIimw2
	5s5LzcfGYfIopyM/i6rc4jPuqjDgl8vVs7wIB7TK/MeqKp2LTmd2sN198ZZf9o6/mL3rU3Kk4c1
	YqVIt2uLOed/Xg955dMT14UOZ9h8H13UHgUoe0Mx2gVozEIvQSrJnX4g=
X-Google-Smtp-Source: AGHT+IGz26Ea8EVfxmD7CYD1EYjaqOZ0tv4UBwYEaCP+dicgzHzlyyAYT0+U65N/8UcdrEHzAZFVltcTlujTmNGdSCUHHDgVF6KP
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4117:b0:487:31da:eaf1 with SMTP id
 ay23-20020a056638411700b0048731daeaf1mr628996jab.1.1714415823840; Mon, 29 Apr
 2024 11:37:03 -0700 (PDT)
Date: Mon, 29 Apr 2024 11:37:03 -0700
In-Reply-To: <0000000000007e812306170008d1@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002d7a7f0617408af1@google.com>
Subject: Re: [syzbot] [bluetooth?] possible deadlock in hci_dev_do_close (2)
From: syzbot <syzbot+c55f7bc8d4809b2bad59@syzkaller.appspotmail.com>
To: hdanton@sina.com, iam@sung-woo.kim, johan.hedberg@gmail.com, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, luiz.von.dentz@intel.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 37dd04e4d59487c928bf3561e4bd3a045762eabc
Author: Sungwoo Kim <iam@sung-woo.kim>
Date:   Thu Apr 25 04:11:28 2024 +0000

    Bluetooth: HCI: fix slab-use-after-free in cmd_sync_work

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14457fd8980000
start commit:   bb7a2467e6be Add linux-next specific files for 20240426
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16457fd8980000
console output: https://syzkaller.appspot.com/x/log.txt?x=12457fd8980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5c6a0288262dd108
dashboard link: https://syzkaller.appspot.com/bug?extid=c55f7bc8d4809b2bad59
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1590bcf8980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1349ee9b180000

Reported-by: syzbot+c55f7bc8d4809b2bad59@syzkaller.appspotmail.com
Fixes: 37dd04e4d594 ("Bluetooth: HCI: fix slab-use-after-free in cmd_sync_work")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
