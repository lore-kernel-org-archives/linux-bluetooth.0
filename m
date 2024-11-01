Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8512D1CACF2
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 Nov 2024 19:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730490846; cv=none; b=Ro1ODTlXsxULm7UsC5mGCkiKahmxvJiFW/QufLEWOG+kBBLIEEnAP/uknL6muwu+/dSFpEo1nREY3gId3IscruyXm3/vMpXDLpdYL+eO6hHpcmIzruZO4ujrJsnzTxtn+Ox3li5/h4jv3YmjappcFBO01ZkMd5jv4DwsJmGLaeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730490846; c=relaxed/simple;
	bh=8T08c4ViHxdRdt04IB93lbUJebJH1g6DSv3KJeWcAP4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Iecs7zjFXwDcs/Shg9v7Aazr4JwcLoqupnc6VdPJvxJG+yiZbtDiihs2CVL4tSQNf84jD0DnOr+k9QMaaU72tV+6zywXsRmkJ36iN+XcZpohcyHztffkA8D2Z5vAXwN8C5UkFc4OTOLIZPgZINe4NxnUgqoheNyP5pgCqlu2T/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a4f2698c76so21146315ab.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 01 Nov 2024 12:54:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730490843; x=1731095643;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t+8s9jsg7kj56nWZSY054okfs/Xt14HAbQYJwRRp8F0=;
        b=xRU7KUl1EKcE+osXbsJ18vtwBPGABJlpPs/5Z4khWzfBUEuf5wUJwHY0M+NdSqMEAf
         u4fpe+Te5Q6bdJ8v6exvq10yGKogx479caNbBDCUSd4jfBpCH0ZixPZUgZ1qJb7m1yP2
         FRpG5I9omnmxaPaHIQU0cI+n0KvJKanNPldTzcNIFPkKtTL+T1YmvMggIOxhkk0QRTHg
         0qWn9uIcHeLwfVa7hWFaNjuS4ovGnXxfe9orajjPqwtg1HX4gxHuMULDHaju05OLK85t
         7TbnLFIMqfHdPwLXB1L371n0btzRhV56cPDGP/ZfE4MwwD++Kvgz8LndafRVwMf6yrpg
         JWgA==
X-Forwarded-Encrypted: i=1; AJvYcCXPWuCYE3xGYyaXIVqQjcjz9QClflBJB1sv52siRnY+Wk4H9S766t+uKuz+z7K2Jsf3JxvK61zhOCDQG+mXUy8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywyp8p4FVlNENRoHpNWM8GuOopIfq1FuVfYhajOhr4nwQL3hvG/
	5FIAp8M1TBGR1zyr5Ota5wafW4rofX3cnCNptRR2wib3UPRLY5Yh4GU4OsN6TnBYsYq4nrWgdu4
	YIvMgz+WeO1SCTp+aLXiMWtvGTzmkw5Qxog8IekqNEMWamWri2IBbKi4=
X-Google-Smtp-Source: AGHT+IHpNLh7R0kkqJ6nQR81kFDOSR6qjieoRchkxeJRrR//riJWj1+JRQRt/TaFMUzMizLp0I89dPSh5s0mKAOVLPKrwZfvVeCC
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1e0a:b0:3a0:ae35:f2eb with SMTP id
 e9e14a558f8ab-3a6b032b0edmr50789745ab.19.1730490842700; Fri, 01 Nov 2024
 12:54:02 -0700 (PDT)
Date: Fri, 01 Nov 2024 12:54:02 -0700
In-Reply-To: <CABBYNZK3cVQ1nZbRDW2-VRTwOsJOW7hoRQEV26Qeh2juDjnMvA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672531da.050a0220.35b515.0178.GAE@google.com>
Subject: Re: [syzbot] [pm?] KASAN: use-after-free Read in netdev_unregister_kobject
From: syzbot <syzbot+6cf5652d3df49fae2e3f@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, johan.hedberg@gmail.com, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, lvc-project@linuxtesting.org, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+6cf5652d3df49fae2e3f@syzkaller.appspotmail.com
Tested-by: syzbot+6cf5652d3df49fae2e3f@syzkaller.appspotmail.com

Tested on:

commit:         c4264568 Merge tag 'acpi-6.12-rc6' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=148ad340580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2cf68159adbdf217
dashboard link: https://syzkaller.appspot.com/bug?extid=6cf5652d3df49fae2e3f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1122d340580000

Note: testing is done by a robot and is best-effort only.
