Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568941D8A0B
	for <linux-bluetooth@vger.kernel.org>; Sun, 17 Nov 2024 14:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731852185; cv=none; b=N6ykIpf8Ee3HH7+DrAPxbCGyxVyeaXhqHhAOMHRlNzGQKM2Od2kWK/PpgWUlkr0CmD1aGIJPS1vDKi3LwetWcypuabqJns0Ix60Sjw2MjMg2xDOpZOacEsOrL/6C2Yg/hpojxEWs+hDDLB0tC0dNvaHE3A7osHxO/rq5AJj02kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731852185; c=relaxed/simple;
	bh=t2uHVMYp7iXp+o0/F+cYkAZoh2d2psBzk/GeopJjg0M=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=XYZGxEPA4OJMOm++YSv8xPYHn/xwkGSWzawDT+rldPmoIiS2b1P9PC/aC3MMRJ0C0R61QWq8vVx74eci3cusVqOlNkAyb9UUG1h+5dGoMQ8s3ICZGIjkK28VJN4aQ2f/G4fBb6qkbgZALuHd7uGqfnH5CBdGxScHQeMtV1N2upc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a7191aa79cso25187095ab.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 17 Nov 2024 06:03:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731852183; x=1732456983;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NUssD4OF1/0W4ulVXXYWglqzpn1NTprdCx53eur2zFw=;
        b=G7zz0X7i+JttA7+8ghwz7ZiG0xH2fBtcTCAlz+0LArdxpoeNPI6s6J3wtNRYrS4whg
         07xTv8Ftkxe6/YskLTnH6O0Lh1sd6Fw5vxJGj0ywEeTkU9DWCdcER7KGNyNMVRUJuxOw
         hLGlypqHZI933eiUKl9LWxuqxsCqZj4JYmvWjxPVVwYfAl9R7GbDDGj5bGspEUh41kJb
         X2m+S4s0MZP7pIM5Y92Bm6dXWt+I34MgSONDQ+2B1UUjdKsdTFkaVyjrwnvFD0g80IBZ
         DgsQ3lu3q5Z4X9uHqdGiGYRZq+nTz9RYcU7VU88dviPvmxuunx8qvmXNibs47sJ56qg3
         gu2w==
X-Forwarded-Encrypted: i=1; AJvYcCUXDKWnMsyhwUdvIhvpMuK/1MYeny4pwQqsD2E/FkYqHYVQsstYe65k5Y+ne308VcRx7p0fYjIEdaW+C30SdO0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT8AMh8J+NRxExKQI6yMooTCby+9HDIdTyZHGdidPmQWBoLmzb
	eeM0GvsyucC5sIiwBZtJEgmrDcNmswanGAHkXAeYH/Sr22+PbvDY7dejoIebZyhNURGq5rlTZdA
	ITqXM4MQI70n/X6XQdEEdc3FhTaQB1ne4sarSpZTo2g5ZyOuAU7fBlPo=
X-Google-Smtp-Source: AGHT+IGpPscsTKcEqBtvy667IuN2y2ojokY1wvLLrtmso7y8ucb+MsA5Aa7h+kCOP7Ws8bgrOxutXJzm1W2hGXSN+35UuaRYEzFV
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aaf:b0:3a6:aa64:dc9 with SMTP id
 e9e14a558f8ab-3a74802f569mr80874525ab.13.1731852183560; Sun, 17 Nov 2024
 06:03:03 -0800 (PST)
Date: Sun, 17 Nov 2024 06:03:03 -0800
In-Reply-To: <0000000000006477b305f2b48b58@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6739f797.050a0220.87769.000f.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] possible deadlock in rfcomm_dlc_exists
From: syzbot <syzbot+b69a625d06e8ece26415@syzkaller.appspotmail.com>
To: axboe@kernel.dk, davem@davemloft.net, edumazet@google.com, 
	hdanton@sina.com, johan.hedberg@gmail.com, kuba@kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, luiz.von.dentz@intel.com, marcel@holtmann.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	yangyingliang@huawei.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 08d1914293dae38350b8088980e59fbc699a72fe
Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Date:   Mon Sep 30 17:26:21 2024 +0000

    Bluetooth: RFCOMM: FIX possible deadlock in rfcomm_sk_state_change

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11bcdb5f980000
start commit:   5847c9777c30 Merge tag 'cgroup-for-6.8-rc7-fixes' of git:/..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=70429b75d4a1a401
dashboard link: https://syzkaller.appspot.com/bug?extid=b69a625d06e8ece26415
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1097b049180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=168a5bde180000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: Bluetooth: RFCOMM: FIX possible deadlock in rfcomm_sk_state_change

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
