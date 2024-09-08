Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99E1173347
	for <linux-bluetooth@vger.kernel.org>; Sun,  8 Sep 2024 16:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725813785; cv=none; b=Ipvf9inMjphhoTh6+xhiKfUtVYdJe/qTH3DlqVmg8BXEYXGn9argndMCgSilRfUDThEjP0CbJHPbk14PY91waIItYvgjHrVepvWOPw4Nc6i+syNBirP6TLHVHn1H5/xSG5ynlS50cgCa2xO9xsOsCF/WXeGFb9yRnzTTYLf/0Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725813785; c=relaxed/simple;
	bh=+hpRt2dV5nPaL/nXyAs/uGkUnfPrWQbCVMJPn5e929Q=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=JZWinUL58moMUXZNdHjf/etpH0JBX+iJmN5EGPNBuLhR8LwhvpO+MpEMwjeXvHmclY1yHkmnvldOPyNFk6tl50BL254hOmsK/cCZuCUBD1rGpjnKVMIT5wtrQBHYBW5YI3YNW6fAMSX3LsmWqzbsEk/AJOjdcYKlCGmPDo1Qjaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-82aad3fa5edso148241039f.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 08 Sep 2024 09:43:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725813783; x=1726418583;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l+wp0usBhcD98D12aDAt+WbEjn/+6VIsoMm0S/3mqMI=;
        b=iiWoOihb94Rf2FD1Hz6tG45d+ShnZ9jR+erBF0bslxBzoWn4cIJBfnI93pzNo9V1Lr
         9RXXl9UHMsQ4byoAR3TMTmsPW3RwmSnza8sQtD1s5C2nrqfauZdciAyamQO7sUh76Olx
         s/vbpAPvbKxZFPJUw/ZxWEgsrhhrJJusKzY3vSXJbbo4j1jN8dCyVYf7TvpZKtOTMteb
         LiB5Z0OfSRDe/MlD66AU90lSPANQhW61uETtzKHVQ840dSajqEkSleonRuIj21XphyVG
         vRUGFY9tdXd6N21fX8WI/J4p5G5M6OSliIx4v3lF5gjoHxSocjk5RzCh2JHc0POpJRIl
         aFJg==
X-Forwarded-Encrypted: i=1; AJvYcCXrB7z8AOr7QK8mODLKeYPKHQ4NyydPPWbIMyWh/pdTPK+tJ9kQqsnGU2aoE4KUwwdHTKBl1ZX/zdrXe4rWQhg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYT2gdNE+W/YUW94O7TUJzwTONDH9lyuxgAfx2PsKM9n0+VEeC
	06PsTphQvv7C1HZ9k3W/hvgWoyjVJdfqyo04J1v25aUeqLniQl3MrDdWFw2LAVhlRNP2/scj4i9
	wHf2F/1+6jNG+I+YFvJaJeHXwtTu2jB5n36JO3NzRjV+Kh9xiJS0rG6A=
X-Google-Smtp-Source: AGHT+IErW406J68fk8lzI9LE+Br5vIRWQbo3xGD7mtxZhp3G/swle8CJ+fMHpBuJiwZP8Jv49IExS2en+n4PALMBN85sEoQb4UpM
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c27:b0:3a0:4dcb:de0b with SMTP id
 e9e14a558f8ab-3a057461e7dmr42929675ab.10.1725813782959; Sun, 08 Sep 2024
 09:43:02 -0700 (PDT)
Date: Sun, 08 Sep 2024 09:43:02 -0700
In-Reply-To: <000000000000932e45061d45f6e8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007b685f06219e55c5@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in set_powered_sync
From: syzbot <syzbot+03d6270b6425df1605bf@syzkaller.appspotmail.com>
To: brian.gix@intel.com, davem@davemloft.net, johan.hedberg@gmail.com, 
	kuba@kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, luiz.von.dentz@intel.com, 
	marcel@holtmann.org, mlevitsk@redhat.com, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 275f3f64870245b06188f24bdf917e55a813d294
Author: Brian Gix <brian.gix@intel.com>
Date:   Tue Mar 1 22:34:57 2022 +0000

    Bluetooth: Fix not checking MGMT cmd pending queue

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=138c743b980000
start commit:   f723224742fc Merge tag 'nf-next-24-09-06' of git://git.ker..
git tree:       net-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=104c743b980000
console output: https://syzkaller.appspot.com/x/log.txt?x=178c743b980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=37742f4fda0d1b09
dashboard link: https://syzkaller.appspot.com/bug?extid=03d6270b6425df1605bf
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=110c589f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=139b0e00580000

Reported-by: syzbot+03d6270b6425df1605bf@syzkaller.appspotmail.com
Fixes: 275f3f648702 ("Bluetooth: Fix not checking MGMT cmd pending queue")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
