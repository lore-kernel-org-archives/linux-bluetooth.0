Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498D12F509
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Feb 2025 01:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740099666; cv=none; b=VfZbB7v3C8A1iMjiM6Z1pIqGTf86orb2T3InssfyOpdLEs0L08VpxbDaGx6a5yuVXVE6PiEskmn1CkVkCR0KsC1/v+HZatQHbkbGgKqnfAJqUxGCAk5Wrvz66MyeV6kYXtWoa2W8IeBrvKL7wHf+vjSmvjXH2dMY7dn8LJGpaHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740099666; c=relaxed/simple;
	bh=4/jkSPd+7SkkOw/6xFeJ6XK66kxAJEdbOzjm8nMZabo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=dGygT4+RvR/pGdsO3yBlzIeuCoZW1y/o3Z0u8VBlspUlQFbHIkOSLsL5xdi3N7bTIwgb5XXB0S4Fhs6Z8/G3W6WbspCizoS03+tf2ZCJIQI7GZL9jB99afY08s4Jq2BAZX76syl+Og/4xFWzlG5FSqE+lkIljovnbDcWE2hdXks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3d2b6d933a3so24895105ab.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Feb 2025 17:01:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740099663; x=1740704463;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PPfQysImRr+xOu4kExsPqpYVpEICotxax76O4rF2U+c=;
        b=Bp0CjGR6w8+8HbhnPxyU6/NznDw3HGvn0dAuiSNQZuDhha0z22gbz1YlE92BEhm1JQ
         BLjr/Ajf0M0+R+Ybl0rg4aA8mIbU1d/iIT6vqy1JxknY9MZt2hMOsH9EU0dhCZKRNBg5
         Gf/wDYO0S9kDaBlsUL3IAwx8FPz2BA8PIsRdW6bYL0o+TSH/pGTm+0toCUZp5TNAsfmd
         7uIMKad250vrYkq6w2fHaQAhD2udnPSXyklpbqb3wxvF8jsGZQyfoFJVhuA1ZStBO6kx
         NSvFGm8nn7BixjEjl7hzayOHv3JaRJAjy0jcRTu2VnzYya+QJRJRSa4TswXyHDa9Q3er
         meHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJS0UFjRa4TbGwa/kyeQ7bVv193Bx8abSWXQPSdWVDWmRfppUlevn8Blo6mxxwlbUHa5iLeT2wDU6/gh1l+kE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxULFpxnf+oRDGQLTEmto6SE4o5W4cDa49xllRY6FuRw3HAv1Sd
	9k8WhTkO6riQmBQ3yqWHwql63ydyuDFyqYOK/cDmnxN3wXR8IPhEYpELk7lKci7PiuqAg1kFdTN
	iAcDeVblderKsUcwwIzJFL/XX03B8GHUKxMJ/vW1Jmc9RUsFVoLndt+A=
X-Google-Smtp-Source: AGHT+IFmlldBkF8QuqaN5ZkFiYY95ZxCZ6cNqSwuC6w7OcrsJlpJZo3bKAh8Iil4mYll5ouOOTyglBqplx9P1Lfq9fPXSS5CINTS
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:168d:b0:3d1:7835:1031 with SMTP id
 e9e14a558f8ab-3d2cae6c63fmr12541445ab.7.1740099663233; Thu, 20 Feb 2025
 17:01:03 -0800 (PST)
Date: Thu, 20 Feb 2025 17:01:03 -0800
In-Reply-To: <67b75955.050a0220.14d86d.02e5.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b7d04f.050a0220.14d86d.0303.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] general protection fault in h5_close
From: syzbot <syzbot+ce27f6f75880d7fe265c@syzkaller.appspotmail.com>
To: avkrasnov@salutedevices.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, luiz.von.dentz@intel.com, 
	marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 3ca66179e56d25f1e3ed1608241abb487c63e9b7
Author: Arseniy Krasnov <avkrasnov@salutedevices.com>
Date:   Thu Jan 30 18:43:26 2025 +0000

    Bluetooth: hci_uart: fix race during initialization

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=102567f8580000
start commit:   e5d3fd687aac Add linux-next specific files for 20250218
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=122567f8580000
console output: https://syzkaller.appspot.com/x/log.txt?x=142567f8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4e945b2fe8e5992f
dashboard link: https://syzkaller.appspot.com/bug?extid=ce27f6f75880d7fe265c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=178f2ba4580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=123375b0580000

Reported-by: syzbot+ce27f6f75880d7fe265c@syzkaller.appspotmail.com
Fixes: 3ca66179e56d ("Bluetooth: hci_uart: fix race during initialization")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
